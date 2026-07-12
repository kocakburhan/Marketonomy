param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure([string]$Message) {
    $failures.Add($Message)
    Write-Output "FAIL: $Message"
}

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { Add-Failure $Message }
}

function Assert-Equal([object]$Actual, [object]$Expected, [string]$Message) {
    if ($Actual -ne $Expected) {
        Add-Failure "$Message Beklenen: $Expected, gercek: $Actual"
    }
}

function Assert-NoControlChars([string]$Path, [string]$Message) {
    $content = Read-Utf8 $Path
    for ($i = 0; $i -lt $content.Length; $i++) {
        $code = [int][char]$content[$i]
        $isAllowedWhitespace = $code -in @(9, 10, 13)
        if ($code -lt 32 -and -not $isAllowedWhitespace) {
            Add-Failure "$Message Kontrol karakteri bulundu: U+$($code.ToString('X4')) at index $i"
            return
        }
    }
}

function Get-IsoWeekName([datetime]$Date) {
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

$createProject = Join-Path $RepoRoot "scripts\create-project.ps1"
$agentRoot = Join-Path $RepoRoot "marketing-agent"
$tmpRoot = Join-Path $env:TEMP ("pa-create-test-" + [guid]::NewGuid().ToString("N"))
$baseProfile = Join-Path $tmpRoot "base-marketer-profile.md"

try {
    Assert-True (Test-Path -LiteralPath $createProject) "create-project.ps1 bulunmali."
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $RepoRoot "scripts\create-evaluation.ps1"))) "Ayrik evaluation create scripti kalmamali; fikir degerlendirme proje icinde mod olmali."

    if (Test-Path -LiteralPath $createProject) {
        New-Item -ItemType Directory -Force -Path $tmpRoot | Out-Null
        Write-Utf8 $baseProfile "Profil durumu: Hazir`nTercih edilen hitap: Test Marketer`n"

        $missingAgentRoot = Join-Path $tmpRoot "missing-agent-source"
        $failedProjectRoot = Join-Path $tmpRoot "failed-project"
        $previousErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        try {
            powershell -NoProfile -ExecutionPolicy Bypass -File $createProject `
                -TargetRoot $failedProjectRoot `
                -Title "Basarisiz Proje" `
                -IdeaId "idea-fail-001" `
                -ProjectId "project-fail-001" `
                -SourceAgentRoot $missingAgentRoot *> $null
            $failedProjectExitCode = $LASTEXITCODE
        } finally {
            $ErrorActionPreference = $previousErrorActionPreference
        }
        $failedProjectCleaned = ($failedProjectExitCode -ne 0) -and (-not (Test-Path -LiteralPath $failedProjectRoot))
        Assert-True $failedProjectCleaned "Project create install hatasinda yarim workspace birakmamali."

        $projectsRoot = Join-Path $tmpRoot "Projects"
        New-Item -ItemType Directory -Force -Path (Join-Path $projectsRoot ".pa") | Out-Null
        $rootProfileContent = @"
Profil durumu: Tamamlandı
Kaynak: Test Projects root
Ek kullanıcı bağlamı: Ben otistiğim; yazılı ve net görevleri tercih ederim.
"@
        Write-Utf8 (Join-Path $projectsRoot ".pa\marketer-profile.md") $rootProfileContent

        $projectAutoProfileRoot = Join-Path $projectsRoot "proje-auto-profile"
        powershell -NoProfile -ExecutionPolicy Bypass -File $createProject `
            -TargetRoot $projectAutoProfileRoot `
            -Title "Otomatik Profil Proje" `
            -IdeaId "idea-auto-profile-001" `
            -ProjectId "project-auto-profile-001" `
            -SourceAgentRoot $agentRoot | Out-Null

        Assert-True (Test-Path -LiteralPath (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) "Project marketer root profili otomatik kopyalanmali."
        Assert-Equal (Read-Utf8 (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) $rootProfileContent "Project marketer profili byte-for-byte korunmali."
        Assert-True ((Read-Utf8 (Join-Path $projectAutoProfileRoot "AGENTS.md")) -match [regex]::Escape(".pa/project/marketer-profile.md")) "Project bootstrap marketer profilini okumaya yonlendirmeli."

        $projectRoot = Join-Path $tmpRoot "proje"
        powershell -NoProfile -ExecutionPolicy Bypass -File $createProject `
            -TargetRoot $projectRoot `
            -Title "Akilli Teklif Araci" `
            -IdeaId "idea-test-001" `
            -ProjectId "project-test-001" `
            -SourceAgentRoot $agentRoot `
            -MarketerProfilePath $baseProfile | Out-Null

        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot "PROJE.md")) "Project PROJE.md olusmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\project\state.json")) "Project state olusmali."
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $projectRoot "DEGERLENDIRME.md"))) "Project workspace ayrik DEGERLENDIRME.md icermemeli."
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\evaluation"))) "Project workspace .pa/evaluation icermemeli."
        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\agent\AGENTS.md")) "Project agent paketi kurulmus olmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\project\marketer-profile.md")) "Project marketer profili kopyalanmali."
        $projectState = Read-Utf8 (Join-Path $projectRoot ".pa\project\state.json") | ConvertFrom-Json
        Assert-Equal $projectState.idea_id "idea-test-001" "Project idea_id state'e yazilmali."
        Assert-Equal $projectState.project_id "project-test-001" "Project project_id state'e yazilmali."
        Assert-True ((Read-Utf8 (Join-Path $projectRoot "PROJE.md")) -match "project-test-001") "PROJE.md project_id icermeli."
        Assert-NoControlChars (Join-Path $projectRoot "PROJE.md") "Project PROJE.md kontrol karakteri içermemeli."
        Assert-NoControlChars (Join-Path $projectRoot "KARARLAR.md") "Project KARARLAR.md kontrol karakteri içermemeli."
        $projectText = Read-Utf8 (Join-Path $projectRoot "PROJE.md")
        $decisionsText = Read-Utf8 (Join-Path $projectRoot "KARARLAR.md")
        Assert-True ($projectText -match "Fikir Değerlendirme Modu") "PROJE.md doğru Türkçe karakter kullanmalı."
        Assert-True ($decisionsText -match "Henüz karar kaydı yok\.") "KARARLAR.md doğru Türkçe karakter kullanmalı."
        Assert-True ($projectText -notmatch "Fikir Degerlendirme|Kullanici|arastirma ve karar") "PROJE.md Türkçe kullanıcı metnini ASCII'ye çevirmemeli."
        $projectReconcile = powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $projectRoot ".pa\agent\scripts\reconcile-workspace-state.ps1") `
            -WorkspaceRoot $projectRoot `
            -Json
        Assert-Equal ((($projectReconcile -join "`n") | ConvertFrom-Json).status) "ok" "Project reconciliation ok olmali."
        Assert-NoControlChars (Join-Path $projectRoot "DURUM.md") "Project DURUM.md temiz olmali."
        Assert-True ((Read-Utf8 (Join-Path $projectRoot "DURUM.md")) -match "01-baglam/") "Project DURUM.md 01-baglam yolunu okunabilir yazmali."

        $weekName = Get-IsoWeekName (Get-Date)
        $weekFile = Join-Path $projectRoot "05-haftalik-planlar\$weekName.md"
        $scheduleFile = Join-Path $projectRoot "05-haftalik-planlar\$weekName\schedule.md"
        Assert-True (Test-Path -LiteralPath $weekFile) "Aktif ISO hafta plani olusmali: $weekName.md"
        Assert-True (Test-Path -LiteralPath $scheduleFile) "Aktif ISO hafta schedule.md olusmali."
        if (Test-Path -LiteralPath $weekFile) { Assert-NoControlChars $weekFile "Haftalik plan temiz olmali." }
        if (Test-Path -LiteralPath $scheduleFile) { Assert-NoControlChars $scheduleFile "Haftalik schedule temiz olmali." }
        $dayFiles = @(
            "pazartesi.md",
            "sali.md",
            "carsamba.md",
            "persembe.md",
            "cuma.md",
            "cumartesi.md",
            "pazar.md"
        )
        foreach ($dayFileName in $dayFiles) {
            $dayFile = Join-Path $projectRoot "05-haftalik-planlar\$weekName\$dayFileName"
            Assert-True (Test-Path -LiteralPath $dayFile) "Gunluk schedule dosyasi olusmali: $dayFileName"
            if (Test-Path -LiteralPath $dayFile) {
                Assert-NoControlChars $dayFile "Gunluk schedule temiz olmali: $dayFileName"
            }
        }

        $projectDurum = Read-Utf8 (Join-Path $projectRoot "DURUM.md")
        Assert-True ($projectDurum -match "Proje bağlamı tamamlanıyor") "Project DURUM.md baslangic durumunu mvp sozlesmesine gore yazmali."
        Assert-True ($projectDurum -match [regex]::Escape("05-haftalik-planlar/$weekName.md")) "Project DURUM.md aktif haftalik plan yolunu yazmali."

        $weekContent = Read-Utf8 $weekFile
        Assert-True ($weekContent -notmatch "\[ \]\s+PROJE\.md ve 01-baglam/") "Baslangic haftalik plani kullanici adina gorev yazmamali."
        Assert-True ($weekContent -match "Başlangıç görevi yok") "Baslangic haftalik plani bos gorev durumunu acik yazmali."

        $gitkeepFolders = @(
            "00-gelen-kutusu",
            "01-baglam",
            "02-arastirma",
            "02-arastirma\fikir-degerlendirme",
            "03-strateji",
            "03-strateji\dogrulama",
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
            Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot "$folder\.gitkeep")) "Bos klasor .gitkeep ile korunmali: $folder"
        }

        $canonicalFolders = @(
            "00-gelen-kutusu\yuklemeler",
            "04-urun\fikir-ozetleri",
            "04-urun\prd",
            "04-urun\coder-briefleri",
            "04-urun\urun-kararlari",
            "08-raporlar\haftalik",
            "08-raporlar\pazarlama",
            "08-raporlar\analitik",
            "08-raporlar\yatirimci",
            "08-raporlar\finansal",
            "08-raporlar\pdf",
            "08-raporlar\excel",
            "10-final\prd",
            "10-final\coder-briefleri",
            "10-final\raporlar",
            "10-final\yatirimci",
            "10-final\lansman",
            "10-final\dijital",
            "10-final\saha",
            "10-final\hibrit",
            "11-notlar\bilgi-haritasi\sayfalar"
        )
        foreach ($folder in $canonicalFolders) {
            Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot $folder)) "Canonical proje klasoru olusmali: $folder"
        }

        foreach ($file in @(
            "10-final\linkler.md",
            "11-notlar\bilgi-haritasi\index.md",
            "11-notlar\bilgi-haritasi\log.md"
        )) {
            Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot $file)) "Canonical baslangic dosyasi olusmali: $file"
        }
    }
} catch {
    Add-Failure $_.Exception.Message
} finally {
    if (Test-Path -LiteralPath $tmpRoot) {
        Remove-Item -LiteralPath $tmpRoot -Recurse -Force
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) workspace create hatasi bulundu."
    exit 1
}

Write-Output "SONUC: Workspace create testleri gecti."
exit 0
