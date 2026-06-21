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
