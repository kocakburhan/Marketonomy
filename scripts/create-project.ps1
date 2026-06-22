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

function Get-ActiveIsoWeekName([datetime]$Date) {
    $day = [int]$Date.DayOfWeek
    if ($day -eq 0) { $day = 7 }
    $thursday = $Date.AddDays(4 - $day)
    $year = $thursday.Year
    $jan1 = [datetime]::new($year, 1, 1)
    $jan1Day = [int]$jan1.DayOfWeek
    if ($jan1Day -eq 0) { $jan1Day = 7 }
    $firstThursdayOffset = (4 - $jan1Day + 7) % 7
    $firstThursday = $jan1.AddDays($firstThursdayOffset)
    $week = [int][Math]::Floor(($thursday - $firstThursday).TotalDays / 7) + 1
    return "{0}-W{1:D2}" -f $year, $week
}

function Get-MarketerRootProfilePath([string]$Target) {
    $resolvedTarget = if (Test-Path -LiteralPath $Target) {
        (Resolve-Path -LiteralPath $Target).Path
    } else {
        [System.IO.Path]::GetFullPath($Target)
    }
    $parent = Split-Path -Parent $resolvedTarget
    if (-not $parent) { return $null }

    $current = $parent
    while ($current) {
        $profilePath = Join-Path $current ".pa\marketer-profile.md"
        if (Test-Path -LiteralPath $profilePath) { return $profilePath }
        $next = Split-Path -Parent $current
        if (-not $next -or $next -eq $current) { break }
        $current = $next
    }
    return $null
}

if ([string]::IsNullOrWhiteSpace($IdeaId)) {
    $IdeaId = New-LocalId "idea"
}
if ([string]::IsNullOrWhiteSpace($ProjectId)) {
    $ProjectId = New-LocalId "project"
}

$target = Assert-SafeTarget $TargetRoot
$now = Get-Date

try {
if (-not $MarketerProfilePath) {
    $MarketerProfilePath = Get-MarketerRootProfilePath $target
}

foreach ($folder in @(
    "00-gelen-kutusu",
    "01-baglam",
    "02-arastirma",
    "02-arastirma\fikir-degerlendirme",
    "02-arastirma\pazar-arastirmasi",
    "02-arastirma\rakip-arastirmasi",
    "02-arastirma\musteri-arastirmasi",
    "02-arastirma\trend-arastirmasi",
    "02-arastirma\store-intelligence\raw",
    "02-arastirma\store-intelligence\snapshots",
    "03-strateji",
    "03-strateji\dogrulama",
    "03-strateji\konumlandirma",
    "03-strateji\fiyatlandirma",
    "03-strateji\pazara-giris",
    "03-strateji\buyume",
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

$gitkeepFolders = @(
    "00-gelen-kutusu",
    "01-baglam",
    "02-arastirma",
    "02-arastirma\fikir-degerlendirme",
    "02-arastirma\pazar-arastirmasi",
    "02-arastirma\rakip-arastirmasi",
    "02-arastirma\musteri-arastirmasi",
    "02-arastirma\trend-arastirmasi",
    "02-arastirma\store-intelligence\raw",
    "02-arastirma\store-intelligence\snapshots",
    "03-strateji",
    "03-strateji\dogrulama",
    "03-strateji\konumlandirma",
    "03-strateji\fiyatlandirma",
    "03-strateji\pazara-giris",
    "03-strateji\buyume",
    "04-urun",
    "06-pazarlama-uygulamalari\dijital",
    "06-pazarlama-uygulamalari\saha",
    "06-pazarlama-uygulamalari\hibrit",
    "07-lansman",
    "08-raporlar",
    "09-varliklar",
    "10-final\yatirimci",
    "11-notlar",
    "99-arsiv"
)
foreach ($folder in $gitkeepFolders) {
    Write-Utf8 (Join-Path $target "$folder\.gitkeep") ""
}

Write-Utf8 (Join-Path $target "PROJE.md") @"
# $Title

project_id: $ProjectId
idea_id: $IdeaId

## Ozet
- Durum: Yeni proje workspace'i
- Olusturma tarihi: $($now.ToString("yyyy-MM-dd"))
- Olusturma akisi: approved create flow, Codex + Google Drive first

## Fikir Degerlendirme Modu
Bu workspace tek proje calisma alanidir. Fikir ayri bir calisma klasorune tasinmaz.
Kullanici isterse ilk is olarak fikir burada acimasizca degerlendirilir; arastirma ve karar
izleri `02-arastirma/fikir-degerlendirme/`, `03-strateji/dogrulama/`, `KARARLAR.md` ve
`DURUM.md` icinde tutulur. Fikir denenmeye degmezse proje dosyalari silinmez; gerekce ve sonraki
secenekler kayda gecirilir.

"@

$activeWeek = Get-ActiveIsoWeekName $now

Write-Utf8 (Join-Path $target "DURUM.md") @"
# Durum

- Workspace turu: Project
- Aktif is: Proje baglami tamamlaniyor
- Aktif haftalik plan: 05-haftalik-planlar/$activeWeek.md
- Sonraki adim: 01-baglam/ proje baglamini tamamla.

"@

Write-Utf8 (Join-Path $target "KARARLAR.md") "# Kararlar`n`nHenüz karar kaydi yok.`n"
Write-Utf8 (Join-Path $target "README.md") "# Workspace Rehberi`n`nBu klasor PersonalAutonomy proje workspace'idir.`n"
Write-Utf8 (Join-Path $target ".pa\project\active-task.md") "# Active Task`n`nDurum: Bos`n"
Write-Utf8 (Join-Path $target ".pa\project\settings.json") "{`"timezone`":`"Europe/Istanbul`"}`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides.md") "# Project Overrides`n`nOnayli proje-ozel tercih yok.`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides-approved.md") "# Approved Project Overrides`n`nOnayli proje-ozel tercih yok.`n"

$weekFile = Join-Path $target "05-haftalik-planlar\$activeWeek.md"
$weekFolder = Join-Path $target "05-haftalik-planlar\$activeWeek"
$scheduleFile = Join-Path $weekFolder "schedule.md"
New-Item -ItemType Directory -Force -Path $weekFolder | Out-Null

Write-Utf8 $weekFile @"
# $activeWeek Haftalik Plan

- Workspace: $Title
- Durum: Baslangic plan taslagi
- Kapanis kurali: Workspace artifact'i gorevi acikca kanitliyorsa agent gorevi kapatir ve kullaniciyi bilgilendirir. Harici aksiyonlar kullanici bildirimi bekler. Final yayin veya teslim acik onay ister.

## Bu Haftanin Odaklari
- Baslangic gorevi yok.

## Notlar
- Bu dosya create-project.ps1 tarafindan baslangic iskeleti olarak olusturuldu.
- Ilk gercek haftalik gorevler kullanici ile birlikte planlanir.

"@

Write-Utf8 $scheduleFile @"
# $activeWeek Schedule

Timezone: Europe/Istanbul

## Haftalik Gorunum
- Pazartesi:
- Sali:
- Carsamba:
- Persembe:
- Cuma:
- Cumartesi:
- Pazar:

"@

$dayFiles = [ordered]@{
    "pazartesi.md" = "Pazartesi"
    "sali.md" = "Sali"
    "carsamba.md" = "Carsamba"
    "persembe.md" = "Persembe"
    "cuma.md" = "Cuma"
    "cumartesi.md" = "Cumartesi"
    "pazar.md" = "Pazar"
}

foreach ($entry in $dayFiles.GetEnumerator()) {
    $dayPath = Join-Path $weekFolder $entry.Key
    Write-Utf8 $dayPath @"
# $activeWeek $($entry.Value)

Timezone: Europe/Istanbul

## Gorevler
- Baslangic gorevi yok.

"@
}

$overridesHash = Get-FileSha256OrEmpty (Join-Path $target ".pa\project\overrides.md")
$state = [ordered]@{
    schema_version = "1.0"
    workspace_type = "project"
    project_id = $ProjectId
    idea_id = $IdeaId
    title = $Title
    timezone = "Europe/Istanbul"
    overrides_sha256 = $overridesHash
    active_week = $activeWeek
    active_week_plan = "05-haftalik-planlar/$activeWeek.md"
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
} catch {
    if (Test-Path -LiteralPath $target) {
        Remove-Item -LiteralPath $target -Recurse -Force
    }
    throw
}
