param(
    [string]$AgentRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$Version
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$versionPath = Join-Path $AgentRoot "agent-version.json"

if (-not $Version) {
    $Version = ([System.IO.File]::ReadAllText($versionPath, $Utf8) | ConvertFrom-Json).version
}
if ($Version -notmatch '^v\d+\.\d+\.\d+$') {
    throw "Version vMAJOR.MINOR.PATCH biciminde olmali."
}

$excludedNames = @("release-manifest.json", "migrate_to_codex.ps1")
$files = Get-ChildItem -LiteralPath $AgentRoot -Recurse -File | Where-Object {
    $_.FullName -notmatch "[\\/]vendor[\\/]" -and
    $_.FullName -notmatch "[\\/]node_modules[\\/]" -and
    $_.FullName -notmatch "[\\/]__pycache__[\\/]" -and
    $_.Extension -ne ".pyc" -and
    $_.Name -notin $excludedNames
} | Sort-Object { $_.FullName.Substring($AgentRoot.Length + 1).Replace('\', '/') }

$items = foreach ($file in $files) {
    [ordered]@{
        path = $file.FullName.Substring($AgentRoot.Length + 1).Replace('\', '/')
        sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
        size = $file.Length
    }
}

$manifest = [ordered]@{
    schema_version = "1.0"
    version = $Version
    hash_algorithm = "SHA-256"
    generated_at = "deterministic"
    files = @($items)
}

$json = $manifest | ConvertTo-Json -Depth 6
[System.IO.File]::WriteAllText((Join-Path $AgentRoot "release-manifest.json"), $json + "`n", $Utf8)
Write-Output "Manifest generated: $($items.Count) files, version $Version"
