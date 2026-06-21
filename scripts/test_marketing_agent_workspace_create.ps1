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

$createEvaluation = Join-Path $RepoRoot "scripts\create-evaluation.ps1"
$createProject = Join-Path $RepoRoot "scripts\create-project.ps1"
$agentRoot = Join-Path $RepoRoot "marketing-agent"
$tmpRoot = Join-Path $env:TEMP ("pa-create-test-" + [guid]::NewGuid().ToString("N"))
$baseProfile = Join-Path $tmpRoot "base-marketer-profile.md"

try {
    Assert-True (Test-Path -LiteralPath $createEvaluation) "create-evaluation.ps1 bulunmali."
    Assert-True (Test-Path -LiteralPath $createProject) "create-project.ps1 bulunmali."

    if ((Test-Path -LiteralPath $createEvaluation) -and (Test-Path -LiteralPath $createProject)) {
        New-Item -ItemType Directory -Force -Path $tmpRoot | Out-Null
        Write-Utf8 $baseProfile "Profil durumu: Hazir`nTercih edilen hitap: Test Marketer`n"

        $missingAgentRoot = Join-Path $tmpRoot "missing-agent-source"
        $failedEvaluationRoot = Join-Path $tmpRoot "failed-evaluation"
        $previousErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        try {
            powershell -NoProfile -ExecutionPolicy Bypass -File $createEvaluation `
                -TargetRoot $failedEvaluationRoot `
                -Title "Basarisiz Degerlendirme" `
                -IdeaId "idea-fail-001" `
                -SourceAgentRoot $missingAgentRoot *> $null
            $failedEvaluationExitCode = $LASTEXITCODE
        } finally {
            $ErrorActionPreference = $previousErrorActionPreference
        }
        $failedEvaluationCleaned = ($failedEvaluationExitCode -ne 0) -and (-not (Test-Path -LiteralPath $failedEvaluationRoot))
        Assert-True $failedEvaluationCleaned "Evaluation create install hatasinda yarim workspace birakmamali."

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

        $marketerRoot = Join-Path $tmpRoot "marketer-root"
        $ideaParent = Join-Path $marketerRoot "idea-workspace"
        $projectParent = Join-Path $marketerRoot "projects"
        New-Item -ItemType Directory -Force -Path (Join-Path $marketerRoot ".pa") | Out-Null
        New-Item -ItemType Directory -Force -Path $ideaParent | Out-Null
        New-Item -ItemType Directory -Force -Path $projectParent | Out-Null
        Write-Utf8 (Join-Path $marketerRoot ".pa\marketer-profile.md") "Profil durumu: Tamamlandi`nKaynak: Test marketer root`n"

        $evaluationAutoProfileRoot = Join-Path $ideaParent "degerlendirme-auto-profile"
        powershell -NoProfile -ExecutionPolicy Bypass -File $createEvaluation `
            -TargetRoot $evaluationAutoProfileRoot `
            -Title "Otomatik Profil Degerlendirme" `
            -IdeaId "idea-auto-profile-001" `
            -SourceAgentRoot $agentRoot | Out-Null

        Assert-True (Test-Path -LiteralPath (Join-Path $evaluationAutoProfileRoot ".pa\evaluation\marketer-profile.md")) "Evaluation marketer root profili otomatik kopyalanmali."
        Assert-True ((Read-Utf8 (Join-Path $evaluationAutoProfileRoot ".pa\evaluation\marketer-profile.md")) -match "Kaynak: Test marketer root") "Evaluation otomatik profil icerigi korunmali."

        $projectAutoProfileRoot = Join-Path $projectParent "proje-auto-profile"
        powershell -NoProfile -ExecutionPolicy Bypass -File $createProject `
            -TargetRoot $projectAutoProfileRoot `
            -Title "Otomatik Profil Proje" `
            -IdeaId "idea-auto-profile-001" `
            -ProjectId "project-auto-profile-001" `
            -SourceAgentRoot $agentRoot | Out-Null

        Assert-True (Test-Path -LiteralPath (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) "Project marketer root profili otomatik kopyalanmali."
        Assert-True ((Read-Utf8 (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) -match "Kaynak: Test marketer root") "Project otomatik profil icerigi korunmali."

        $evaluationRoot = Join-Path $tmpRoot "degerlendirme"
        powershell -NoProfile -ExecutionPolicy Bypass -File $createEvaluation `
            -TargetRoot $evaluationRoot `
            -Title "Akilli Teklif Araci" `
            -IdeaId "idea-test-001" `
            -SourceAgentRoot $agentRoot `
            -MarketerProfilePath $baseProfile | Out-Null

        Assert-True (Test-Path -LiteralPath (Join-Path $evaluationRoot "DEGERLENDIRME.md")) "Evaluation DEGERLENDIRME.md olusmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $evaluationRoot ".pa\evaluation\state.json")) "Evaluation state olusmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $evaluationRoot ".pa\agent\AGENTS.md")) "Evaluation agent paketi kurulmus olmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $evaluationRoot ".pa\evaluation\marketer-profile.md")) "Evaluation marketer profili kopyalanmali."
        $evaluationState = Read-Utf8 (Join-Path $evaluationRoot ".pa\evaluation\state.json") | ConvertFrom-Json
        Assert-Equal $evaluationState.idea_id "idea-test-001" "Evaluation idea_id state'e yazilmali."
        Assert-True ((Read-Utf8 (Join-Path $evaluationRoot "DEGERLENDIRME.md")) -match "idea-test-001") "DEGERLENDIRME.md idea_id icermeli."
        $evaluationReconcile = powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $evaluationRoot ".pa\agent\scripts\reconcile-workspace-state.ps1") `
            -WorkspaceRoot $evaluationRoot `
            -Json
        Assert-Equal ((($evaluationReconcile -join "`n") | ConvertFrom-Json).status) "ok" "Evaluation reconciliation ok olmali."

        $evaluationSettingsPath = Join-Path $evaluationRoot ".pa\evaluation\settings.json"
        Assert-True (Test-Path -LiteralPath $evaluationSettingsPath) "Evaluation settings.json olusmali."
        if (Test-Path -LiteralPath $evaluationSettingsPath) {
            $evaluationSettings = Read-Utf8 $evaluationSettingsPath | ConvertFrom-Json
            Assert-Equal $evaluationSettings.timezone "Europe/Istanbul" "Evaluation timezone Europe/Istanbul olmali."
        }
        Assert-NoControlChars (Join-Path $evaluationRoot "DURUM.md") "Evaluation DURUM.md temiz olmali."

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
        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\agent\AGENTS.md")) "Project agent paketi kurulmus olmali."
        Assert-True (Test-Path -LiteralPath (Join-Path $projectRoot ".pa\project\marketer-profile.md")) "Project marketer profili kopyalanmali."
        $projectState = Read-Utf8 (Join-Path $projectRoot ".pa\project\state.json") | ConvertFrom-Json
        Assert-Equal $projectState.idea_id "idea-test-001" "Project idea_id state'e yazilmali."
        Assert-Equal $projectState.project_id "project-test-001" "Project project_id state'e yazilmali."
        Assert-True ((Read-Utf8 (Join-Path $projectRoot "PROJE.md")) -match "project-test-001") "PROJE.md project_id icermeli."
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
        Assert-True ($projectDurum -match "Proje baglami tamamlaniyor") "Project DURUM.md baslangic durumunu mvp sozlesmesine gore yazmali."
        Assert-True ($projectDurum -match [regex]::Escape("05-haftalik-planlar/$weekName.md")) "Project DURUM.md aktif haftalik plan yolunu yazmali."

        $weekContent = Read-Utf8 $weekFile
        Assert-True ($weekContent -notmatch "\[ \]\s+PROJE\.md ve 01-baglam/") "Baslangic haftalik plani kullanici adina gorev yazmamali."
        Assert-True ($weekContent -match "Baslangic gorevi yok") "Baslangic haftalik plani bos gorev durumunu acik yazmali."

        $gitkeepFolders = @(
            "00-gelen-kutusu",
            "01-baglam",
            "02-arastirma",
            "03-strateji",
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
