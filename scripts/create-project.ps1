param(
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [string]$Title = "Yeni Proje",
    [string]$IdeaId,
    [string]$ProjectId,
    [string]$SourceAgentRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [string]$MarketerProfilePath
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Assert-SafeTarget([string]$Root) {
    if (Test-Path -LiteralPath $Root) {
        $item = Get-Item -LiteralPath $Root
        if (-not $item.PSIsContainer) { throw "TargetRoot klasor olmali: $Root" }
        $children = Get-ChildItem -LiteralPath $Root -Force
        if ($children.Count -gt 0) {
            throw "TargetRoot bos olmali; mevcut proje dosyalari uzerine workspace olusturulmaz: $Root"
        }
    } else {
        New-Item -ItemType Directory -Force -Path $Root | Out-Null
    }
    return (Resolve-Path -LiteralPath $Root).Path
}

function New-LocalId([string]$Prefix) {
    return "$Prefix-" + (Get-Date -Format "yyyyMMddHHmmss") + "-" + ([guid]::NewGuid().ToString("N").Substring(0, 8))
}

function Get-FileSha256OrEmpty([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return $null }
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

if ([string]::IsNullOrWhiteSpace($IdeaId)) {
    $IdeaId = New-LocalId "idea"
}
if ([string]::IsNullOrWhiteSpace($ProjectId)) {
    $ProjectId = New-LocalId "project"
}

$target = Assert-SafeTarget $TargetRoot
$now = Get-Date

foreach ($folder in @(
    "00-gelen-kutusu",
    "01-baglam",
    "02-arastirma",
    "03-strateji",
    "04-urun",
    "05-haftalik-planlar",
    "06-pazarlama-uygulamalari\dijital",
    "06-pazarlama-uygulamalari\saha",
    "06-pazarlama-uygulamalari\hibrit",
    "07-lansman",
    "08-raporlar",
    "09-varliklar",
    "10-final\yatirimci",
    "11-notlar",
    "99-arsiv",
    ".pa\project"
)) {
    New-Item -ItemType Directory -Force -Path (Join-Path $target $folder) | Out-Null
}

Write-Utf8 (Join-Path $target "PROJE.md") @"
# $Title

project_id: $ProjectId
idea_id: $IdeaId

## Ozet
- Durum: Yeni proje workspace'i
- Olusturma tarihi: $($now.ToString("yyyy-MM-dd"))
- Olusturma akisi: approved create flow, Codex + Google Drive first

"@

Write-Utf8 (Join-Path $target "DURUM.md") @"
# Durum

- Workspace turu: Project
- Aktif is: Baslangic hazirligi
- Sonraki adim: `01-baglam/` proje baglamini tamamla.

"@

Write-Utf8 (Join-Path $target "KARARLAR.md") "# Kararlar`n`nHenüz karar kaydi yok.`n"
Write-Utf8 (Join-Path $target "README.md") "# Workspace Rehberi`n`nBu klasor PersonalAutonomy proje workspace'idir.`n"
Write-Utf8 (Join-Path $target ".pa\project\active-task.md") "# Active Task`n`nDurum: Bos`n"
Write-Utf8 (Join-Path $target ".pa\project\settings.json") "{`"timezone`":`"Europe/Istanbul`"}`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides.md") "# Project Overrides`n`nOnayli proje-ozel tercih yok.`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides-approved.md") "# Approved Project Overrides`n`nOnayli proje-ozel tercih yok.`n"

$overridesHash = Get-FileSha256OrEmpty (Join-Path $target ".pa\project\overrides.md")
$state = [ordered]@{
    schema_version = "1.0"
    workspace_type = "project"
    project_id = $ProjectId
    idea_id = $IdeaId
    title = $Title
    timezone = "Europe/Istanbul"
    overrides_sha256 = $overridesHash
    created_at = $now.ToString("o")
    created_by = "scripts/create-project.ps1"
}
Write-Utf8 (Join-Path $target ".pa\project\state.json") (($state | ConvertTo-Json -Depth 6) + "`n")

if ($MarketerProfilePath) {
    $profileSource = Resolve-Path -LiteralPath $MarketerProfilePath -ErrorAction Stop
    Copy-Item -LiteralPath $profileSource.Path -Destination (Join-Path $target ".pa\project\marketer-profile.md") -Force
}

$installer = Join-Path (Split-Path -Parent $PSScriptRoot) "scripts\install-marketing-agent.ps1"
$installArgs = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $installer, "-TargetRoot", $target, "-Version", $Version)
if ($SourceAgentRoot) { $installArgs += @("-SourceAgentRoot", $SourceAgentRoot) }
if ($RepoUrl) { $installArgs += @("-RepoUrl", $RepoUrl) }
& powershell @installArgs | Out-String | Write-Verbose
if ($LASTEXITCODE -ne 0) { throw "Marketing Agent kurulumu basarisiz oldu." }

Write-Output "SONUC: Project workspace olusturuldu."
Write-Output "Path: $target"
Write-Output "project_id: $ProjectId"
Write-Output "idea_id: $IdeaId"
