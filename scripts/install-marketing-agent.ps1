param(
    [string]$TargetRoot = (Get-Location).Path,
    [string]$SourceAgentRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [string]$UpdatePolicy = "ask",
    [switch]$ForceBootstrap
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Resolve-ExistingDirectory([string]$Path, [string]$Name) {
    $resolved = Resolve-Path -LiteralPath $Path -ErrorAction Stop
    $item = Get-Item -LiteralPath $resolved.Path
    if (-not $item.PSIsContainer) {
        throw "$Name klasor olmali: $Path"
    }
    return $item.FullName
}

function Read-Utf8([string]$Path) {
    return [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Test-VersionString([string]$Value, [string]$Name) {
    if ($Value -ne "latest" -and $Value -notmatch '^v\d+\.\d+\.\d+$') {
        throw "$Name latest veya vMAJOR.MINOR.PATCH biciminde olmali."
    }
}

function Convert-VersionParts([string]$Value) {
    if ($Value -notmatch '^v(\d+)\.(\d+)\.(\d+)$') {
        throw "Gecersiz surum: $Value"
    }
    return [int[]]@([int]$Matches[1], [int]$Matches[2], [int]$Matches[3])
}

function Compare-Semver([string]$Left, [string]$Right) {
    $leftParts = Convert-VersionParts $Left
    $rightParts = Convert-VersionParts $Right
    for ($i = 0; $i -lt 3; $i++) {
        if ($leftParts[$i] -lt $rightParts[$i]) { return -1 }
        if ($leftParts[$i] -gt $rightParts[$i]) { return 1 }
    }
    return 0
}

function Get-LatestGitTag([string]$RemoteUrl) {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git bulunamadi. RepoUrl ile kurulum icin git PATH uzerinde olmali veya -SourceAgentRoot kullanilmali."
    }

    $refs = & git ls-remote --tags --refs $RemoteUrl "v*" 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "GitHub tag bilgisi okunamadi: $refs"
    }

    $versions = foreach ($line in $refs) {
        if ($line -match 'refs/tags/(v\d+\.\d+\.\d+)$') {
            $Matches[1]
        }
    }

    if (-not $versions) {
        return $null
    }

    return ($versions | Sort-Object -Descending -Property @{ Expression = { (Convert-VersionParts $_)[0] } }, @{ Expression = { (Convert-VersionParts $_)[1] } }, @{ Expression = { (Convert-VersionParts $_)[2] } } | Select-Object -First 1)
}

function Resolve-RemoteAgentRoot([string]$RemoteUrl, [string]$RequestedVersion, [ref]$TempRoot) {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git bulunamadi. RepoUrl ile kurulum icin git PATH uzerinde olmali veya -SourceAgentRoot kullanilmali."
    }

    $versionToClone = $RequestedVersion
    if ($versionToClone -eq "latest") {
        $latest = Get-LatestGitTag $RemoteUrl
        if ($latest) {
            $versionToClone = $latest
        }
    }

    $temp = Join-Path $env:TEMP ("pa-agent-source-" + [guid]::NewGuid().ToString("N"))
    $TempRoot.Value = $temp

    if ($versionToClone -eq "latest") {
        & git clone --depth 1 $RemoteUrl $temp 2>&1 | Out-String | Write-Verbose
    } else {
        & git clone --depth 1 --branch $versionToClone $RemoteUrl $temp 2>&1 | Out-String | Write-Verbose
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Repo indirilemedi: $RemoteUrl"
    }

    $agentRoot = Join-Path $temp "marketing-agent"
    if (-not (Test-Path -LiteralPath $agentRoot)) {
        throw "Repo icinde marketing-agent klasoru bulunamadi: $RemoteUrl"
    }
    return $agentRoot
}

function Test-Manifest([string]$AgentRoot) {
    $manifestPath = Join-Path $AgentRoot "release-manifest.json"
    if (-not (Test-Path -LiteralPath $manifestPath)) {
        throw "release-manifest.json bulunamadi: $manifestPath"
    }

    $manifest = Read-Utf8 $manifestPath | ConvertFrom-Json
    foreach ($file in $manifest.files) {
        $path = Join-Path $AgentRoot $file.path
        if (-not (Test-Path -LiteralPath $path)) {
            throw "Manifest dosyasi eksik: $($file.path)"
        }

        $actual = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($actual -ne $file.sha256) {
            throw "Manifest hash uyusmazligi: $($file.path)"
        }
    }

    return $manifest
}

function Copy-AgentPackage([string]$Source, [string]$Destination) {
    $parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Force -Path $parent | Out-Null

    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $staging = Join-Path $parent ("agent.installing-$stamp")
    $backup = Join-Path $parent ("agent.backup-$stamp")
    $manifest = Test-Manifest $Source

    if (Test-Path -LiteralPath $staging) {
        Remove-Item -LiteralPath $staging -Recurse -Force
    }

    try {
        New-Item -ItemType Directory -Force -Path $staging | Out-Null

        foreach ($file in $manifest.files) {
            $sourcePath = Join-Path $Source $file.path
            $targetPath = Join-Path $staging $file.path
            $targetParent = Split-Path -Parent $targetPath
            New-Item -ItemType Directory -Force -Path $targetParent | Out-Null
            Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
        }

        Copy-Item -LiteralPath (Join-Path $Source "release-manifest.json") `
            -Destination (Join-Path $staging "release-manifest.json") -Force

        Test-Manifest $staging | Out-Null

        if (Test-Path -LiteralPath $Destination) {
            Move-Item -LiteralPath $Destination -Destination $backup
        }

        Move-Item -LiteralPath $staging -Destination $Destination
        Test-Manifest $Destination | Out-Null

        if (Test-Path -LiteralPath $backup) {
            Remove-Item -LiteralPath $backup -Recurse -Force
        }
    } catch {
        if (Test-Path -LiteralPath $staging) {
            Remove-Item -LiteralPath $staging -Recurse -Force
        }
        if ((Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $Destination)) {
            Move-Item -LiteralPath $backup -Destination $Destination
        }
        throw
    }
}

function Install-Bootstrap([string]$TargetRoot, [string]$TemplatePath, [switch]$ForceBootstrap) {
    $target = Join-Path $TargetRoot "AGENTS.md"
    $template = Read-Utf8 $TemplatePath

    if (-not (Test-Path -LiteralPath $target)) {
        Write-Utf8 $target ($template.TrimEnd() + "`r`n")
        return "created"
    }

    $current = Read-Utf8 $target
    if ($current -match "PA_BOOTSTRAP_VERSION:\s*1") {
        if ($current -ne $template) {
            Write-Utf8 $target ($template.TrimEnd() + "`r`n")
            return "updated"
        }
        return "unchanged"
    }

    if (-not $ForceBootstrap) {
        throw "Hedef AGENTS.md mevcut ama PersonalAutonomy bootstrap degil. Uzerine yazmak icin -ForceBootstrap kullan."
    }

    $backup = Join-Path $TargetRoot ("AGENTS.md.pre-pa-install-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".bak")
    Copy-Item -LiteralPath $target -Destination $backup -Force
    Write-Utf8 $target ($template.TrimEnd() + "`r`n")
    return "replaced-with-backup:$backup"
}

function Write-InstallMetadata(
    [string]$TargetRoot,
    [string]$RepoUrl,
    [string]$SourceAgentRoot,
    [string]$InstalledVersion,
    [string]$UpdatePolicy,
    [string]$RequestedVersion
) {
    $metadata = [ordered]@{
        schema_version = "1.0"
        repo_url = $RepoUrl
        source_agent_root = $SourceAgentRoot
        channel = "stable"
        requested_version = $RequestedVersion
        installed_version = $InstalledVersion
        update_policy = $UpdatePolicy
        installed_at = (Get-Date).ToString("o")
        installer = "scripts/install-marketing-agent.ps1"
    }
    $metadataPath = Join-Path $TargetRoot ".pa\agent-install.json"
    Write-Utf8 $metadataPath (($metadata | ConvertTo-Json -Depth 6) + "`n")
}

$targetRootFull = Resolve-ExistingDirectory $TargetRoot "TargetRoot"
$remoteTempRoot = $null

Test-VersionString $Version "Version"
if ($UpdatePolicy -notin @("ask", "manual")) {
    throw "UpdatePolicy ask veya manual olmali."
}

if ($SourceAgentRoot) {
    $sourceAgentFull = Resolve-ExistingDirectory $SourceAgentRoot "SourceAgentRoot"
} elseif ($RepoUrl) {
    $sourceAgentFull = Resolve-RemoteAgentRoot -RemoteUrl $RepoUrl -RequestedVersion $Version -TempRoot ([ref]$remoteTempRoot)
} else {
    $repoRoot = Split-Path -Parent $PSScriptRoot
    $SourceAgentRoot = Join-Path $repoRoot "marketing-agent"
    $sourceAgentFull = Resolve-ExistingDirectory $SourceAgentRoot "SourceAgentRoot"
}

$required = @(
    "AGENTS.md", "ARCHITECTURE.md", "SKILLS.md", "agents", "pipelines", "skills",
    "scripts", "templates", "mcps.json", "agent-version.json", "release-manifest.json"
)

foreach ($relative in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $sourceAgentFull $relative))) {
        throw "Kaynak agent paketi eksik: $relative"
    }
}

$manifest = Test-Manifest $sourceAgentFull
$templatePath = Join-Path $sourceAgentFull "templates\workspace-bootstrap-AGENTS.md"
if (-not (Test-Path -LiteralPath $templatePath)) {
    throw "Bootstrap sablonu eksik: templates/workspace-bootstrap-AGENTS.md"
}

$destinationAgent = Join-Path $targetRootFull ".pa\agent"
try {
    Copy-AgentPackage -Source $sourceAgentFull -Destination $destinationAgent
    $bootstrapStatus = Install-Bootstrap -TargetRoot $targetRootFull -TemplatePath $templatePath -ForceBootstrap:$ForceBootstrap

    $versionPath = Join-Path $destinationAgent "agent-version.json"
    $agentVersion = Read-Utf8 $versionPath | ConvertFrom-Json
    Write-InstallMetadata `
        -TargetRoot $targetRootFull `
        -RepoUrl $RepoUrl `
        -SourceAgentRoot $SourceAgentRoot `
        -InstalledVersion $agentVersion.version `
        -UpdatePolicy $UpdatePolicy `
        -RequestedVersion $Version

    Write-Output "SONUC: PersonalAutonomy Marketing Agent kurulumu tamamlandi."
    Write-Output "Hedef workspace: $targetRootFull"
    Write-Output "Agent hedefi: $destinationAgent"
    Write-Output "Surum: $($agentVersion.version)"
    Write-Output "Manifest dosya sayisi: $($manifest.files.Count)"
    Write-Output "Bootstrap AGENTS.md: $bootstrapStatus"
    Write-Output "Sonraki adim: Hedef klasoru Codex root olarak ac ve kok AGENTS.md talimatlarini izle."
} finally {
    if ($remoteTempRoot -and (Test-Path -LiteralPath $remoteTempRoot)) {
        Remove-Item -LiteralPath $remoteTempRoot -Recurse -Force
    }
}
