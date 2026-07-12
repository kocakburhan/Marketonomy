param(
    [string]$TargetRoot,
    [string]$SourceAgentRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [switch]$Json
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
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
        throw "Git bulunamadi. RepoUrl ile update kontrolu icin git PATH uzerinde olmali."
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

function Get-SourceVersion([string]$RequestedVersion, [string]$LocalSource, [string]$RemoteUrl) {
    if ($RequestedVersion -ne "latest") {
        return $RequestedVersion
    }

    if ($LocalSource) {
        $sourceVersionPath = Join-Path $LocalSource "agent-version.json"
        if (-not (Test-Path -LiteralPath $sourceVersionPath)) {
            throw "SourceAgentRoot agent-version.json icermiyor: $LocalSource"
        }
        return (Read-Utf8 $sourceVersionPath | ConvertFrom-Json).version
    }

    if ($RemoteUrl) {
        $latest = Get-LatestGitTag $RemoteUrl
        if ($latest) { return $latest }
        return "unknown"
    }

    throw "Güncelleme kaynağı bulunamadı. .pa/agent-install.json içinde repo_url yok. Repair script ile repo_url metadata'sını düzelt veya -RepoUrl ver."
}

$root = Find-TargetRoot
$currentVersionPath = Join-Path $root ".pa\agent\agent-version.json"
if (-not (Test-Path -LiteralPath $currentVersionPath)) {
    throw "Kurulu agent-version.json bulunamadi: $currentVersionPath"
}

$metadataPath = Join-Path $root ".pa\agent-install.json"
if ((-not $RepoUrl) -and (Test-Path -LiteralPath $metadataPath)) {
    $metadata = Read-Utf8 $metadataPath | ConvertFrom-Json
    $RepoUrl = $metadata.repo_url
}

$currentVersion = (Read-Utf8 $currentVersionPath | ConvertFrom-Json).version
$availableVersion = Get-SourceVersion -RequestedVersion $Version -LocalSource $SourceAgentRoot -RemoteUrl $RepoUrl

$status = "unknown"
if ($availableVersion -eq "unknown") {
    $status = "unavailable"
} else {
    $comparison = Compare-Semver $currentVersion $availableVersion
    if ($comparison -lt 0) {
        $status = "update-available"
    } elseif ($comparison -eq 0) {
        $status = "up-to-date"
    } else {
        $status = "local-newer"
    }
}

$result = [ordered]@{
    status = $status
    current_version = $currentVersion
    available_version = $availableVersion
    repo_url = $RepoUrl
    checked_at = (Get-Date).ToString("o")
}

if ($Json) {
    Write-Output ($result | ConvertTo-Json -Depth 6)
} else {
    Write-Output "Durum: $status"
    Write-Output "Mevcut surum: $currentVersion"
    Write-Output "Uygun surum: $availableVersion"
}
