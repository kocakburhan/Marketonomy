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

function Get-OnboardingInstallMetadata([string]$Target) {
    $resolvedTarget = if (Test-Path -LiteralPath $Target) {
        (Resolve-Path -LiteralPath $Target).Path
    } else {
        [System.IO.Path]::GetFullPath($Target)
    }
    $current = Split-Path -Parent $resolvedTarget
    while ($current) {
        $metadataPath = Join-Path $current ".pa\onboarding-install.json"
        if (Test-Path -LiteralPath $metadataPath) {
            return [System.IO.File]::ReadAllText($metadataPath, $Utf8) | ConvertFrom-Json
        }
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
if (-not $RepoUrl) {
    $onboardingInstall = Get-OnboardingInstallMetadata $target
    if ($onboardingInstall) {
        if (-not [string]::IsNullOrWhiteSpace([string]$onboardingInstall.repo_url)) {
            $RepoUrl = [string]$onboardingInstall.repo_url
        }
        if ($Version -eq "latest" -and
            [string]$onboardingInstall.requested_version -match '^v\d+\.\d+\.\d+$') {
            $Version = [string]$onboardingInstall.requested_version
        }
    }
}

foreach ($folder in @(
    "00-gelen-kutusu",
    "00-gelen-kutusu\yuklemeler",
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
    "04-urun\fikir-ozetleri",
    "04-urun\prd",
    "04-urun\coder-briefleri",
    "04-urun\urun-kararlari",
    "05-haftalik-planlar",
    "06-pazarlama-uygulamalari\dijital",
    "06-pazarlama-uygulamalari\saha",
    "06-pazarlama-uygulamalari\hibrit",
    "07-lansman",
    "08-raporlar",
    "08-raporlar\haftalik",
    "08-raporlar\pazarlama",
    "08-raporlar\analitik",
    "08-raporlar\yatirimci",
    "08-raporlar\finansal",
    "08-raporlar\pdf",
    "08-raporlar\excel",
    "09-varliklar",
    "10-final\prd",
    "10-final\coder-briefleri",
    "10-final\raporlar",
    "10-final\yatirimci",
    "10-final\lansman",
    "10-final\dijital",
    "10-final\saha",
    "10-final\hibrit",
    "11-notlar",
    "11-notlar\bilgi-haritasi\sayfalar",
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

$projectTemplate = @'
# {0}

project_id: {1}
idea_id: {2}

## Özet
- Durum: Yeni proje workspace'i
- Oluşturma tarihi: {3}
- Oluşturma akışı: approved create flow, Codex + Google Drive first

## Fikir Değerlendirme Modu
Bu workspace tek proje çalışma alanıdır. Fikir ayrı bir çalışma klasörüne taşınmaz.
Kullanıcı isterse ilk iş olarak fikir burada acımasızca değerlendirilir; araştırma ve karar
izleri `02-arastirma/fikir-degerlendirme/`, `03-strateji/dogrulama/`, `KARARLAR.md` ve
`DURUM.md` içinde tutulur. Fikir denenmeye değmezse proje dosyaları silinmez; gerekçe ve sonraki
seçenekler kayda geçirilir.

'@
Write-Utf8 (Join-Path $target "PROJE.md") ($projectTemplate -f $Title, $ProjectId, $IdeaId, $now.ToString("yyyy-MM-dd"))

$activeWeek = Get-ActiveIsoWeekName $now

Write-Utf8 (Join-Path $target "DURUM.md") @"
# Durum

- Workspace turu: Project
- Aktif iş: Proje bağlamı tamamlanıyor
- Aktif haftalik plan: 05-haftalik-planlar/$activeWeek.md
- Sonraki adım: 01-baglam/ proje bağlamını tamamla.

"@

Write-Utf8 (Join-Path $target "KARARLAR.md") "# Kararlar`n`nHenüz karar kaydı yok.`n"
Write-Utf8 (Join-Path $target "README.md") "# Workspace Rehberi`n`nBu klasör PersonalAutonomy proje workspace'idir.`n"
Write-Utf8 (Join-Path $target ".pa\project\active-task.md") "# Active Task`n`nDurum: Bos`n"
Write-Utf8 (Join-Path $target ".pa\project\settings.json") "{`"timezone`":`"Europe/Istanbul`"}`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides.md") "# Project Overrides`n`nOnaylı proje-özel tercih yok.`n"
Write-Utf8 (Join-Path $target ".pa\project\overrides-approved.md") "# Approved Project Overrides`n`nOnaylı proje-özel tercih yok.`n"
Write-Utf8 (Join-Path $target "10-final\linkler.md") "# Final Linkler`n`nHenüz final teslim linki yok.`n"
Write-Utf8 (Join-Path $target "11-notlar\bilgi-haritasi\index.md") "# Bilgi Haritası`n`nKalıcı çıktı, karar ve kaynak ilişkileri burada izlenir.`n"
Write-Utf8 (Join-Path $target "11-notlar\bilgi-haritasi\log.md") "# Bilgi Haritası Log`n`n"

$weekFile = Join-Path $target "05-haftalik-planlar\$activeWeek.md"
$weekFolder = Join-Path $target "05-haftalik-planlar\$activeWeek"
$scheduleFile = Join-Path $weekFolder "schedule.md"
New-Item -ItemType Directory -Force -Path $weekFolder | Out-Null

Write-Utf8 $weekFile @"
# $activeWeek Haftalık Plan

- Workspace: $Title
- Durum: Başlangıç plan taslağı
- Kapanış kuralı: Workspace artifact'i görevi açıkça kanıtlıyorsa agent görevi kapatır ve kullanıcıyı bilgilendirir. Harici aksiyonlar kullanıcı bildirimi bekler. Final yayın veya teslim açık onay ister.

## Bu Haftanın Odakları
- Başlangıç görevi yok.

## Notlar
- Bu dosya create-project.ps1 tarafından başlangıç iskeleti olarak oluşturuldu.
- İlk gerçek haftalık görevler kullanıcı ile birlikte planlanır.

"@

Write-Utf8 $scheduleFile @"
# $activeWeek Schedule

Timezone: Europe/Istanbul

## Haftalık Görünüm
- Pazartesi:
- Salı:
- Çarşamba:
- Perşembe:
- Cuma:
- Cumartesi:
- Pazar:

"@

$dayFiles = [ordered]@{
    "pazartesi.md" = "Pazartesi"
    "sali.md" = "Salı"
    "carsamba.md" = "Çarşamba"
    "persembe.md" = "Perşembe"
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
- Başlangıç görevi yok.

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
