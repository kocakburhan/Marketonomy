param(
    [string]$ProjectsRoot = (Get-Location).Path,
    [switch]$Yes,
    [string]$SourceRepoRoot,
    [string]$Version = "latest"
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

if (-not $Yes) {
    throw "Onboarding update icin acik kullanici onayi gerekir. -Yes parametresini kullan."
}

$metadataPath = Join-Path $ProjectsRoot ".pa\onboarding-install.json"
if (-not (Test-Path -LiteralPath $metadataPath)) {
    throw "Onboarding kurulum metadata dosyasi bulunamadi: $metadataPath"
}
$metadata = [System.IO.File]::ReadAllText($metadataPath, $Utf8) | ConvertFrom-Json
$repoUrl = [string]$metadata.repo_url

if ($SourceRepoRoot) {
    $repoRoot = (Resolve-Path -LiteralPath $SourceRepoRoot -ErrorAction Stop).Path
    $installer = Join-Path $repoRoot "scripts\install-projects-root.ps1"
} else {
    if ([string]::IsNullOrWhiteSpace($repoUrl)) { throw "Onboarding metadata repo_url icermiyor." }
    $installer = Join-Path $PSScriptRoot "install-projects-root.ps1"
}
if (-not (Test-Path -LiteralPath $installer)) { throw "Projects root installer bulunamadi: $installer" }

$args = @(
    "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $installer,
    "-TargetRoot", $ProjectsRoot,
    "-Version", $Version,
    "-ForceBootstrap"
)
if ($SourceRepoRoot) { $args += @("-SourceRepoRoot", $repoRoot) }
if ($repoUrl) { $args += @("-RepoUrl", $repoUrl) }
& powershell @args
if ($LASTEXITCODE -ne 0) { throw "Onboarding update basarisiz oldu." }
