param(
    [string]$TargetRoot = (Get-Location).Path,
    [string]$SourceAgentRoot,
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
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
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

$targetRootFull = Resolve-ExistingDirectory $TargetRoot "TargetRoot"

if (-not $SourceAgentRoot) {
    $repoRoot = Split-Path -Parent $PSScriptRoot
    $SourceAgentRoot = Join-Path $repoRoot "marketing-agent"
}

$sourceAgentFull = Resolve-ExistingDirectory $SourceAgentRoot "SourceAgentRoot"
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
Copy-AgentPackage -Source $sourceAgentFull -Destination $destinationAgent
$bootstrapStatus = Install-Bootstrap -TargetRoot $targetRootFull -TemplatePath $templatePath -ForceBootstrap:$ForceBootstrap

$versionPath = Join-Path $destinationAgent "agent-version.json"
$version = Read-Utf8 $versionPath | ConvertFrom-Json

Write-Output "SONUC: PersonalAutonomy Marketing Agent kurulumu tamamlandi."
Write-Output "Hedef workspace: $targetRootFull"
Write-Output "Agent hedefi: $destinationAgent"
Write-Output "Surum: $($version.version)"
Write-Output "Manifest dosya sayisi: $($manifest.files.Count)"
Write-Output "Bootstrap AGENTS.md: $bootstrapStatus"
Write-Output "Sonraki adim: Hedef klasoru Codex root olarak ac ve kok AGENTS.md talimatlarini izle."
