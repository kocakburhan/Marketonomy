param(
    [string]$ProjectsRoot = (Get-Location).Path,
    [switch]$Json
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Convert-VersionParts([string]$Value) {
    if ($Value -notmatch '^v(\d+)\.(\d+)\.(\d+)$') { throw "Gecersiz surum: $Value" }
    [int[]]@([int]$Matches[1], [int]$Matches[2], [int]$Matches[3])
}

function Get-LatestGitTag([string]$RepoUrl) {
    $refs = & git ls-remote --tags --refs $RepoUrl "v*" 2>&1
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

$metadataPath = Join-Path $ProjectsRoot ".pa\onboarding-install.json"
if (-not (Test-Path -LiteralPath $metadataPath)) {
    throw "Onboarding kurulum metadata dosyasi bulunamadi: $metadataPath"
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git bulunamadi."
}

$metadata = [System.IO.File]::ReadAllText($metadataPath, $Utf8) | ConvertFrom-Json
if ([string]::IsNullOrWhiteSpace([string]$metadata.repo_url)) {
    throw "Onboarding metadata repo_url icermiyor."
}

$latest = Get-LatestGitTag ([string]$metadata.repo_url)
$result = [ordered]@{
    installed_version = [string]$metadata.installed_version
    latest_version = $latest
    update_available = ($latest -and $latest -ne [string]$metadata.installed_version)
    repo_url = [string]$metadata.repo_url
}

if ($Json) {
    $result | ConvertTo-Json -Depth 4
} else {
    Write-Output "Kurulu surum: $($result.installed_version)"
    Write-Output "En yeni surum: $($result.latest_version)"
    Write-Output "Update mevcut: $($result.update_available)"
}
