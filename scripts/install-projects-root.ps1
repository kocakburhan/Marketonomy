param(
    [string]$TargetRoot = (Get-Location).Path,
    [string]$SourceRepoRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [string]$UpdatePolicy = "ask",
    [switch]$ForceBootstrap
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$TextExtensions = @(".md", ".json", ".ps1", ".sh", ".py", ".yaml", ".yml", ".toml", ".txt")

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Get-CanonicalManifestHash([string]$Path) {
    $item = Get-Item -LiteralPath $Path
    $bytes = if ($item.Name -eq ".gitignore" -or $item.Extension.ToLowerInvariant() -in $TextExtensions) {
        $Utf8.GetBytes((Read-Utf8 $Path).Replace("`r`n", "`n"))
    } else {
        [System.IO.File]::ReadAllBytes($Path)
    }
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        ([System.BitConverter]::ToString($sha.ComputeHash($bytes))).Replace("-", "").ToLowerInvariant()
    } finally {
        $sha.Dispose()
    }
}

function Test-VersionString([string]$Value) {
    if ($Value -ne "latest" -and $Value -notmatch '^v\d+\.\d+\.\d+$') {
        throw "Version latest veya vMAJOR.MINOR.PATCH biciminde olmali."
    }
}

function Convert-VersionParts([string]$Value) {
    if ($Value -notmatch '^v(\d+)\.(\d+)\.(\d+)$') { throw "Gecersiz surum: $Value" }
    [int[]]@([int]$Matches[1], [int]$Matches[2], [int]$Matches[3])
}

function Get-LatestGitTag([string]$RemoteUrl) {
    $refs = & git ls-remote --tags --refs $RemoteUrl "v*" 2>&1
    if ($LASTEXITCODE -ne 0) { throw "GitHub tag bilgisi okunamadi: $refs" }
    $versions = foreach ($line in $refs) {
        if ($line -match 'refs/tags/(v\d+\.\d+\.\d+)$') { $Matches[1] }
    }
    if (-not $versions) { return $null }
    $versions | Sort-Object -Descending `
        -Property @{ Expression = { (Convert-VersionParts $_)[0] } },
                  @{ Expression = { (Convert-VersionParts $_)[1] } },
                  @{ Expression = { (Convert-VersionParts $_)[2] } } |
        Select-Object -First 1
}

function Invoke-GitClone([string[]]$Arguments) {
    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        $output = & git @Arguments 2>&1
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    $output | Out-String | Write-Verbose
    if ($exitCode -ne 0) { throw "Repo indirilemedi: $RepoUrl" }
}

function Test-Manifest([string]$AgentRoot) {
    $manifestPath = Join-Path $AgentRoot "release-manifest.json"
    if (-not (Test-Path -LiteralPath $manifestPath)) { throw "release-manifest.json bulunamadi." }
    $manifest = Read-Utf8 $manifestPath | ConvertFrom-Json
    foreach ($file in $manifest.files) {
        $path = Join-Path $AgentRoot $file.path
        if (-not (Test-Path -LiteralPath $path)) { throw "Manifest dosyasi eksik: $($file.path)" }
        $actual = Get-CanonicalManifestHash $path
        if ($actual -ne $file.sha256) { throw "Manifest hash uyusmazligi: $($file.path)" }
    }
    $manifest
}

Test-VersionString $Version
if ($UpdatePolicy -notin @("ask", "manual")) { throw "UpdatePolicy ask veya manual olmali." }

if (-not (Test-Path -LiteralPath $TargetRoot)) {
    New-Item -ItemType Directory -Force -Path $TargetRoot | Out-Null
}
$target = (Resolve-Path -LiteralPath $TargetRoot).Path
if (-not (Get-Item -LiteralPath $target).PSIsContainer) { throw "TargetRoot klasor olmali." }
if ((Test-Path -LiteralPath (Join-Path $target "PROJE.md")) -or
    (Test-Path -LiteralPath (Join-Path $target ".pa\project\state.json"))) {
    throw "Projects root installer proje workspace'ine kurulamaz."
}

$tempRepo = $null
try {
    if ($SourceRepoRoot) {
        $repoRoot = (Resolve-Path -LiteralPath $SourceRepoRoot -ErrorAction Stop).Path
    } elseif ($RepoUrl) {
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Git bulunamadi." }
        $resolvedVersion = $Version
        if ($resolvedVersion -eq "latest") {
            $latest = Get-LatestGitTag $RepoUrl
            if ($latest) { $resolvedVersion = $latest }
        }
        $tempRepo = Join-Path $env:TEMP ("pa-projects-root-source-" + [guid]::NewGuid().ToString("N"))
        if ($resolvedVersion -eq "latest") {
            Invoke-GitClone -Arguments @("-c", "core.autocrlf=false", "clone", "--depth", "1", $RepoUrl, $tempRepo)
        } else {
            Invoke-GitClone -Arguments @("-c", "core.autocrlf=false", "clone", "--depth", "1", "--branch", $resolvedVersion, $RepoUrl, $tempRepo)
        }
        $repoRoot = $tempRepo
    } else {
        $repoRoot = Split-Path -Parent $PSScriptRoot
    }

    $agentRoot = Join-Path $repoRoot "marketing-agent"
    $manifest = Test-Manifest $agentRoot
    $agentVersion = Read-Utf8 (Join-Path $agentRoot "agent-version.json") | ConvertFrom-Json
    $installedVersion = if ($Version -eq "latest") { [string]$agentVersion.version } else { $Version }

    $bootstrapSource = Join-Path $agentRoot "templates\projects-root-bootstrap-AGENTS.md"
    $guideSource = Join-Path $agentRoot "agents\onboarding-guide.md"
    $scriptFiles = @(
        @{ SourcePath = (Join-Path $agentRoot "scripts\check-onboarding-update.ps1"); Target = "check-update.ps1" },
        @{ SourcePath = (Join-Path $agentRoot "scripts\check-onboarding-update.sh"); Target = "check-update.sh" },
        @{ SourcePath = (Join-Path $repoRoot "scripts\install-projects-root.ps1"); Target = "install-projects-root.ps1" },
        @{ SourcePath = (Join-Path $repoRoot "scripts\install-projects-root.sh"); Target = "install-projects-root.sh" },
        @{ SourcePath = (Join-Path $agentRoot "scripts\update-onboarding.ps1"); Target = "update-onboarding.ps1" },
        @{ SourcePath = (Join-Path $agentRoot "scripts\update-onboarding.sh"); Target = "update-onboarding.sh" }
    )
    foreach ($path in @($bootstrapSource, $guideSource) + ($scriptFiles | ForEach-Object { $_.SourcePath })) {
        if (-not (Test-Path -LiteralPath $path)) { throw "Onboarding kaynak dosyasi eksik: $path" }
    }

    $rootAgents = Join-Path $target "AGENTS.md"
    if (Test-Path -LiteralPath $rootAgents) {
        $current = Read-Utf8 $rootAgents
        if ($current -notmatch "PA_PROJECTS_BOOTSTRAP_VERSION:\s*1") {
            if (-not $ForceBootstrap) {
                throw "Hedef AGENTS.md PersonalAutonomy Projects bootstrap degil. -ForceBootstrap kullan."
            }
            $agentsBackup = Join-Path $target ("AGENTS.md.pre-pa-projects-install-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".bak")
            Copy-Item -LiteralPath $rootAgents -Destination $agentsBackup -Force
        }
    }

    $paRoot = Join-Path $target ".pa"
    New-Item -ItemType Directory -Force -Path $paRoot | Out-Null
    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $staging = Join-Path $paRoot ("onboarding.installing-$stamp-" + [guid]::NewGuid().ToString("N").Substring(0, 6))
    $destination = Join-Path $paRoot "onboarding"
    $backup = Join-Path $paRoot ("onboarding.backup-$stamp-" + [guid]::NewGuid().ToString("N").Substring(0, 6))

    try {
        New-Item -ItemType Directory -Force -Path (Join-Path $staging "scripts") | Out-Null
        foreach ($file in $scriptFiles) {
            Copy-Item -LiteralPath $file.SourcePath `
                -Destination (Join-Path $staging ("scripts\" + $file.Target)) -Force
        }

        if (Test-Path -LiteralPath $destination) {
            Move-Item -LiteralPath $destination -Destination $backup
        }
        Move-Item -LiteralPath $staging -Destination $destination

        Write-Utf8 $rootAgents ((Read-Utf8 $bootstrapSource).TrimEnd() + "`r`n")
        Write-Utf8 (Join-Path $target "onboarding-guide.md") (Read-Utf8 $guideSource)
        $metadata = [ordered]@{
            schema_version = "1.0"
            repo_url = $RepoUrl
            requested_version = $Version
            installed_version = $installedVersion
            update_policy = $UpdatePolicy
            installed_at = (Get-Date).ToString("o")
            installer = "scripts/install-projects-root.ps1"
            manifest_version = [string]$manifest.version
        }
        Write-Utf8 (Join-Path $paRoot "onboarding-install.json") (($metadata | ConvertTo-Json -Depth 5) + "`n")

        if (Test-Path -LiteralPath $backup) {
            Remove-Item -LiteralPath $backup -Recurse -Force
        }
    } catch {
        if (Test-Path -LiteralPath $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
        if ((Test-Path -LiteralPath $backup) -and -not (Test-Path -LiteralPath $destination)) {
            Move-Item -LiteralPath $backup -Destination $destination
        }
        throw
    }

    Write-Output "SONUC: PersonalAutonomy Projects root onboarding kurulumu tamamlandi."
    Write-Output "Hedef: $target"
    Write-Output "Surum: $installedVersion"
} finally {
    if ($tempRepo -and (Test-Path -LiteralPath $tempRepo)) {
        Remove-Item -LiteralPath $tempRepo -Recurse -Force
    }
}
