param(
    [string]$AgentRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$Version
)

$ErrorActionPreference = "Stop"
$AgentRoot = (Resolve-Path -LiteralPath $AgentRoot).Path
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$versionPath = Join-Path $AgentRoot "agent-version.json"
$TextExtensions = @(".md", ".json", ".ps1", ".sh", ".py", ".yaml", ".yml", ".toml", ".txt")

function Get-CanonicalManifestBytes([string]$Path) {
    $item = Get-Item -LiteralPath $Path
    if ($item.Name -eq ".gitignore" -or $item.Extension.ToLowerInvariant() -in $TextExtensions) {
        return $Utf8.GetBytes([System.IO.File]::ReadAllText($Path, $Utf8).Replace("`r`n", "`n"))
    }
    return [System.IO.File]::ReadAllBytes($Path)
}

function Get-BytesSha256([byte[]]$Bytes) {
    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        return ([System.BitConverter]::ToString($sha.ComputeHash($Bytes))).Replace("-", "").ToLowerInvariant()
    } finally {
        $sha.Dispose()
    }
}

if (-not $Version) {
    $Version = ([System.IO.File]::ReadAllText($versionPath, $Utf8) | ConvertFrom-Json).version
}
if ($Version -notmatch '^v\d+\.\d+\.\d+$') {
    throw "Version vMAJOR.MINOR.PATCH biciminde olmali."
}

$excludedNames = @("release-manifest.json", "migrate_to_codex.ps1", "build_release_manifest.ps1")
$files = Get-ChildItem -LiteralPath $AgentRoot -Recurse -File | Where-Object {
    $_.FullName -notmatch "[\\/]vendor[\\/]" -and
    $_.FullName -notmatch "[\\/]node_modules[\\/]" -and
    $_.FullName -notmatch "[\\/]__pycache__[\\/]" -and
    $_.Extension -ne ".pyc" -and
    $_.Name -notin $excludedNames
} | Sort-Object { $_.FullName.Substring($AgentRoot.Length + 1).Replace('\', '/') }

$items = foreach ($file in $files) {
    $bytes = Get-CanonicalManifestBytes $file.FullName
    [ordered]@{
        path = $file.FullName.Substring($AgentRoot.Length + 1).Replace('\', '/')
        sha256 = Get-BytesSha256 $bytes
        size = $bytes.Length
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
