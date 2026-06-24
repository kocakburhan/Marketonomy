param(
    [string]$TargetRoot,
    [string]$SourceAgentRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [switch]$AllowDowngrade,
    [switch]$Yes
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Assert-WorkspaceIdentity(
    [string]$DocumentPath,
    [object]$State,
    [string[]]$IdentityFields,
    [string]$WorkspaceType
) {
    $document = Read-Utf8 $DocumentPath
    foreach ($field in $IdentityFields) {
        $stateValue = [string]$State.$field
        if ([string]::IsNullOrWhiteSpace($stateValue)) {
            throw "$WorkspaceType state.json icinde $field bos olamaz."
        }
        $match = [regex]::Match($document, "(?m)^\s*$field\s*:\s*([^\r\n#]+)")
        if (-not $match.Success) {
            throw "$WorkspaceType kimlik dosyasinda $field bulunamadi: $DocumentPath"
        }
        $documentValue = $match.Groups[1].Value.Trim()
        if ($documentValue -ne $stateValue) {
            throw "$WorkspaceType $field uyusmazligi: kimlik dosyasi ile state.json ayni olmali."
        }
    }
}

function Assert-ValidTargetWorkspace([string]$Root) {
    $projectDocument = Join-Path $Root "PROJE.md"
    $projectStatePath = Join-Path $Root ".pa\project\state.json"

    $hasProjectDocument = Test-Path -LiteralPath $projectDocument
    $hasProjectState = Test-Path -LiteralPath $projectStatePath

    if ((Test-Path -LiteralPath (Join-Path $Root "DEGERLENDIRME.md")) -or
        (Test-Path -LiteralPath (Join-Path $Root ".pa\evaluation"))) {
        throw "Ayrik evaluation workspace modeli kaldirildi. Hedef tek tip proje workspace'i olmali."
    }
    if ($hasProjectDocument -ne $hasProjectState) {
        throw "Project workspace eksik: PROJE.md ve .pa/project/state.json birlikte bulunmali."
    }
    if (-not ($hasProjectDocument -and $hasProjectState)) {
        throw "Hedef gecerli PersonalAutonomy proje workspace'i olmali: PROJE.md + .pa/project/state.json."
    }

    try {
        $state = Read-Utf8 $projectStatePath | ConvertFrom-Json
        Assert-WorkspaceIdentity -DocumentPath $projectDocument -State $state `
            -IdentityFields @("project_id", "idea_id") -WorkspaceType "Project workspace"
    } catch {
        throw "Hedef workspace dogrulanamadi: $($_.Exception.Message)"
    }
}

function Find-TargetRoot {
    if ($TargetRoot) {
        return (Resolve-Path -LiteralPath $TargetRoot -ErrorAction Stop).Path
    }

    $current = (Resolve-Path -LiteralPath $PSScriptRoot).Path
    while ($current) {
        if ((Split-Path -Leaf $current) -eq "agent" -and (Split-Path -Leaf (Split-Path -Parent $current)) -eq ".pa") {
            return (Split-Path -Parent (Split-Path -Parent $current))
        }
        $parent = Split-Path -Parent $current
        if ($parent -eq $current) { break }
        $current = $parent
    }

    throw "TargetRoot bulunamadi. -TargetRoot parametresi ver."
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
        throw "Git bulunamadi. RepoUrl ile guncelleme icin git PATH uzerinde olmali veya -SourceAgentRoot kullanilmali."
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
        throw "Git bulunamadi. RepoUrl ile guncelleme icin git PATH uzerinde olmali veya -SourceAgentRoot kullanilmali."
    }

    $versionToClone = $RequestedVersion
    if ($versionToClone -eq "latest") {
        $latest = Get-LatestGitTag $RemoteUrl
        if ($latest) {
            $versionToClone = $latest
        }
    }

    $temp = Join-Path $env:TEMP ("pa-agent-update-source-" + [guid]::NewGuid().ToString("N"))
    $TempRoot.Value = $temp

    if ($versionToClone -eq "latest") {
        & git -c core.autocrlf=false clone --depth 1 $RemoteUrl $temp 2>&1 | Out-String | Write-Verbose
    } else {
        & git -c core.autocrlf=false clone --depth 1 --branch $versionToClone $RemoteUrl $temp 2>&1 | Out-String | Write-Verbose
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

function Copy-AgentToStaging([string]$Source, [string]$Staging) {
    $manifest = Test-Manifest $Source
    New-Item -ItemType Directory -Force -Path $Staging | Out-Null
    foreach ($file in $manifest.files) {
        $sourcePath = Join-Path $Source $file.path
        $targetPath = Join-Path $Staging $file.path
        $targetParent = Split-Path -Parent $targetPath
        New-Item -ItemType Directory -Force -Path $targetParent | Out-Null
        Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
    }
    Copy-Item -LiteralPath (Join-Path $Source "release-manifest.json") -Destination (Join-Path $Staging "release-manifest.json") -Force
    Test-Manifest $Staging | Out-Null
}

function Write-InstallMetadata(
    [string]$Root,
    [object]$ExistingMetadata,
    [string]$InstalledVersion,
    [string]$RepoUrl,
    [string]$SourceAgentRoot,
    [string]$RequestedVersion
) {
    $metadata = [ordered]@{
        schema_version = "1.0"
        repo_url = $RepoUrl
        source_agent_root = $SourceAgentRoot
        channel = "stable"
        requested_version = $RequestedVersion
        installed_version = $InstalledVersion
        update_policy = "ask"
        installed_at = $null
        updated_at = (Get-Date).ToString("o")
        installer = "scripts/update-agent.ps1"
    }

    if ($ExistingMetadata) {
        if ($ExistingMetadata.channel) { $metadata.channel = $ExistingMetadata.channel }
        if ($ExistingMetadata.update_policy) { $metadata.update_policy = $ExistingMetadata.update_policy }
        if ($ExistingMetadata.installed_at) { $metadata.installed_at = $ExistingMetadata.installed_at }
    }

    Write-Utf8 (Join-Path $Root ".pa\agent-install.json") (($metadata | ConvertTo-Json -Depth 6) + "`n")
}

$root = Find-TargetRoot
Assert-ValidTargetWorkspace $root
$metadataPath = Join-Path $root ".pa\agent-install.json"
$metadata = $null
if (Test-Path -LiteralPath $metadataPath) {
    $metadata = Read-Utf8 $metadataPath | ConvertFrom-Json
    if (-not $RepoUrl) { $RepoUrl = $metadata.repo_url }
}

if (-not $Yes) {
    Write-Output "Guncelleme onay gerektirir. Kullanici onayindan sonra -Yes ile tekrar calistir."
    exit 2
}

$remoteTempRoot = $null
if ($SourceAgentRoot) {
    $sourceAgentFull = (Resolve-Path -LiteralPath $SourceAgentRoot -ErrorAction Stop).Path
} elseif ($RepoUrl) {
    $sourceAgentFull = Resolve-RemoteAgentRoot -RemoteUrl $RepoUrl -RequestedVersion $Version -TempRoot ([ref]$remoteTempRoot)
} else {
    throw "Guncelleme kaynagi bulunamadi. .pa/agent-install.json icinde repo_url olmali veya -SourceAgentRoot verilmeli."
}

$destinationAgent = Join-Path $root ".pa\agent"
$currentVersionPath = Join-Path $destinationAgent "agent-version.json"
if (-not (Test-Path -LiteralPath $currentVersionPath)) {
    throw "Kurulu agent-version.json bulunamadi: $currentVersionPath"
}

try {
    $currentVersion = (Read-Utf8 $currentVersionPath | ConvertFrom-Json).version
    $sourceVersion = (Read-Utf8 (Join-Path $sourceAgentFull "agent-version.json") | ConvertFrom-Json).version
    $comparison = Compare-Semver $currentVersion $sourceVersion

    if ($comparison -eq 0) {
        Write-Output "SONUC: Agent zaten guncel ($currentVersion)."
        exit 0
    }
    if ($comparison -gt 0 -and -not $AllowDowngrade) {
        Write-Output "SONUC: Kurulu agent daha yeni ($currentVersion > $sourceVersion). Downgrade icin -AllowDowngrade gerekir."
        exit 0
    }

    $parent = Split-Path -Parent $destinationAgent
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $staging = Join-Path $parent ("agent.updating-$stamp")
    $backup = Join-Path $parent ("agent.backup-$stamp")

    try {
        if (Test-Path -LiteralPath $staging) {
            Remove-Item -LiteralPath $staging -Recurse -Force
        }
        Copy-AgentToStaging -Source $sourceAgentFull -Staging $staging

        Move-Item -LiteralPath $destinationAgent -Destination $backup
        Move-Item -LiteralPath $staging -Destination $destinationAgent
        Test-Manifest $destinationAgent | Out-Null

        if (Test-Path -LiteralPath $backup) {
            Remove-Item -LiteralPath $backup -Recurse -Force
        }

        Write-InstallMetadata `
            -Root $root `
            -ExistingMetadata $metadata `
            -InstalledVersion $sourceVersion `
            -RepoUrl $RepoUrl `
            -SourceAgentRoot $SourceAgentRoot `
            -RequestedVersion $Version

        Write-Output "SONUC: Marketing Agent guncellendi."
        Write-Output "Hedef workspace: $root"
        Write-Output "Eski surum: $currentVersion"
        Write-Output "Yeni surum: $sourceVersion"
        Write-Output "Korunan alanlar: proje dosyalari ve .pa/project"
    } catch {
        if (Test-Path -LiteralPath $staging) {
            Remove-Item -LiteralPath $staging -Recurse -Force
        }
        if ((Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $destinationAgent)) {
            Move-Item -LiteralPath $backup -Destination $destinationAgent
            Test-Manifest $destinationAgent | Out-Null
        }
        throw
    }
} finally {
    if ($remoteTempRoot -and (Test-Path -LiteralPath $remoteTempRoot)) {
        Remove-Item -LiteralPath $remoteTempRoot -Recurse -Force
    }
}
