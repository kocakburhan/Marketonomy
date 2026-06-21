param(
    [string]$WorkspaceRoot = (Get-Location).Path,
    [switch]$Json
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$issues = [System.Collections.Generic.List[object]]::new()
$checks = [System.Collections.Generic.List[object]]::new()

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Add-Check([string]$Name, [string]$Status, [string]$Detail) {
    $checks.Add([ordered]@{ name = $Name; status = $Status; detail = $Detail })
}

function Add-Issue([string]$Severity, [string]$Code, [string]$Detail) {
    $issues.Add([ordered]@{ severity = $Severity; code = $Code; detail = $Detail })
}

function Get-IdentityValue([string]$Document, [string]$Field) {
    $match = [regex]::Match($Document, "(?m)^\s*$field\s*:\s*([^\r\n#]+)")
    if (-not $match.Success) { return $null }
    return $match.Groups[1].Value.Trim()
}

function Test-RequiredFile([string]$Root, [string]$RelativePath) {
    $path = Join-Path $Root $RelativePath
    if (Test-Path -LiteralPath $path) {
        Add-Check "file:$RelativePath" "ok" "mevcut"
    } else {
        Add-Check "file:$RelativePath" "fail" "eksik"
        Add-Issue "error" "missing-file" "$RelativePath eksik."
    }
}

$root = (Resolve-Path -LiteralPath $WorkspaceRoot -ErrorAction Stop).Path
$projectDocument = Join-Path $root "PROJE.md"
$projectStatePath = Join-Path $root ".pa\project\state.json"
$evaluationDocument = Join-Path $root "DEGERLENDIRME.md"
$evaluationStatePath = Join-Path $root ".pa\evaluation\state.json"

$hasProjectDocument = Test-Path -LiteralPath $projectDocument
$hasProjectState = Test-Path -LiteralPath $projectStatePath
$hasEvaluationDocument = Test-Path -LiteralPath $evaluationDocument
$hasEvaluationState = Test-Path -LiteralPath $evaluationStatePath
$hasProject = $hasProjectDocument -and $hasProjectState
$hasEvaluation = $hasEvaluationDocument -and $hasEvaluationState

$workspaceType = "unknown"
if (($hasProjectDocument -or $hasProjectState) -and ($hasEvaluationDocument -or $hasEvaluationState)) {
    Add-Issue "error" "mixed-workspace" "Project ve evaluation isaretleri ayni kokte birlikte bulunuyor."
} elseif ($hasProjectDocument -ne $hasProjectState) {
    Add-Issue "error" "partial-project-workspace" "PROJE.md ve .pa/project/state.json birlikte bulunmali."
} elseif ($hasEvaluationDocument -ne $hasEvaluationState) {
    Add-Issue "error" "partial-evaluation-workspace" "DEGERLENDIRME.md ve .pa/evaluation/state.json birlikte bulunmali."
} elseif ($hasProject) {
    $workspaceType = "project"
} elseif ($hasEvaluation) {
    $workspaceType = "evaluation"
} else {
    Add-Issue "error" "not-workspace" "Gecerli PersonalAutonomy workspace isareti bulunamadi."
}

if ($workspaceType -eq "project") {
    Test-RequiredFile $root "PROJE.md"
    Test-RequiredFile $root "DURUM.md"
    Test-RequiredFile $root "KARARLAR.md"
    Test-RequiredFile $root ".pa\project\active-task.md"
    Test-RequiredFile $root ".pa\project\state.json"

    try {
        $state = Read-Utf8 $projectStatePath | ConvertFrom-Json
        $document = Read-Utf8 $projectDocument
        foreach ($field in @("project_id", "idea_id")) {
            $docValue = Get-IdentityValue $document $field
            $stateValue = [string]$state.$field
            if ([string]::IsNullOrWhiteSpace($docValue) -or [string]::IsNullOrWhiteSpace($stateValue)) {
                Add-Issue "error" "missing-identity" "$field PROJE.md veya state.json icinde eksik."
            } elseif ($docValue -ne $stateValue) {
                Add-Issue "error" "identity-mismatch" "$field PROJE.md ve state.json arasinda uyusmuyor."
            } else {
                Add-Check "identity:$field" "ok" $docValue
            }
        }
    } catch {
        Add-Issue "error" "unreadable-state" ".pa/project/state.json okunamadi: $($_.Exception.Message)"
    }
} elseif ($workspaceType -eq "evaluation") {
    Test-RequiredFile $root "DEGERLENDIRME.md"
    Test-RequiredFile $root "DURUM.md"
    Test-RequiredFile $root "RAPOR.md"
    Test-RequiredFile $root ".pa\evaluation\active-task.md"
    Test-RequiredFile $root ".pa\evaluation\state.json"

    try {
        $state = Read-Utf8 $evaluationStatePath | ConvertFrom-Json
        $document = Read-Utf8 $evaluationDocument
        $docValue = Get-IdentityValue $document "idea_id"
        $stateValue = [string]$state.idea_id
        if ([string]::IsNullOrWhiteSpace($docValue) -or [string]::IsNullOrWhiteSpace($stateValue)) {
            Add-Issue "error" "missing-identity" "idea_id DEGERLENDIRME.md veya state.json icinde eksik."
        } elseif ($docValue -ne $stateValue) {
            Add-Issue "error" "identity-mismatch" "idea_id DEGERLENDIRME.md ve state.json arasinda uyusmuyor."
        } else {
            Add-Check "identity:idea_id" "ok" $docValue
        }
    } catch {
        Add-Issue "error" "unreadable-state" ".pa/evaluation/state.json okunamadi: $($_.Exception.Message)"
    }
}

$result = [ordered]@{
    workspace_root = $root
    workspace_type = $workspaceType
    checked_at = (Get-Date).ToString("o")
    checks = $checks
    issues = $issues
    status = $(if ($issues.Count -eq 0) { "ok" } else { "needs-attention" })
}

if ($Json) {
    Write-Output (($result | ConvertTo-Json -Depth 8) + "`n")
} else {
    Write-Output "Workspace reconciliation"
    Write-Output "Root: $root"
    Write-Output "Type: $workspaceType"
    Write-Output "Status: $($result.status)"
    foreach ($issue in $issues) {
        Write-Output "$($issue.severity.ToUpperInvariant()) $($issue.code): $($issue.detail)"
    }
}

if ($issues.Count -gt 0) { exit 1 }
exit 0
