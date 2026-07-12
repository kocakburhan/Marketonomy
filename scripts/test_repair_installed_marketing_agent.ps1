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

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { Add-Failure $Message }
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function New-CorrectEmptyDecisionText {
    "Hen{0}z karar kayd{1} yok." -f [char]0x00FC, [char]0x0131
}

function New-ProjectFixture([string]$Root, [string]$Name, [string]$ProjectId, [string]$IdeaId) {
    $project = Join-Path $Root $Name
    New-Item -ItemType Directory -Force -Path (Join-Path $project ".pa\project") | Out-Null
    Write-Utf8 (Join-Path $project "PROJE.md") "project_id: $ProjectId`nidea_id: $IdeaId`n`nizleri $([string][char]0)2-arastirma/fikir-degerlendirme/, $([string][char]0)3-strateji/dogrulama/`n"
    Write-Utf8 (Join-Path $project ".pa\project\state.json") "{`"project_id`":`"$ProjectId`",`"idea_id`":`"$IdeaId`"}`n"
    $badDecision = "Hen{0}{1}{2}{3}z karar kaydi yok." -f [char]0x00C3, [char]0x0192, [char]0x00C2, [char]0x00BC
    Write-Utf8 (Join-Path $project "KARARLAR.md") "# Kararlar`n`n$badDecision`n"
    Write-Utf8 (Join-Path $project "DURUM.md") "# Durum`n"
    Write-Utf8 (Join-Path $project "README.md") "# Readme`n"
    $project
}

$repair = Join-Path $RepoRoot "scripts\repair-installed-marketing-agent.ps1"
$sourceAgent = Join-Path $RepoRoot "marketing-agent"
$tmpRoot = Join-Path $env:TEMP ("pa-repair-test-" + [guid]::NewGuid().ToString("N"))

try {
    $projectsRoot = Join-Path $tmpRoot "Projects"
    New-Item -ItemType Directory -Force -Path (Join-Path $projectsRoot ".pa") | Out-Null
    Write-Utf8 (Join-Path $projectsRoot ".pa\onboarding-install.json") "{`"repo_url`":`"https://github.com/kocakburhan/Marketonomy`",`"requested_version`":`"v5.5.2`",`"installed_version`":`"v5.5.2`"}`n"

    $missingPackage = New-ProjectFixture $projectsRoot "broken-agent-missing-package" "project-repair-a" "idea-repair-a"
    $missingFile = New-ProjectFixture $projectsRoot "broken-agent-missing-file" "project-repair-b" "idea-repair-b"

    powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RepoRoot "scripts\install-marketing-agent.ps1") `
        -TargetRoot $missingFile `
        -SourceAgentRoot $sourceAgent `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
        -Version "v5.5.2" | Out-Null
    Remove-Item -LiteralPath (Join-Path $missingFile ".pa\agent\AGENTS.md") -Force
    $metadata = Read-Utf8 (Join-Path $missingFile ".pa\agent-install.json") | ConvertFrom-Json
    $metadata.repo_url = ""
    $metadata.source_agent_root = "C:\Users\example\AppData\Local\Temp\marketonomy-dead\marketing-agent"
    Write-Utf8 (Join-Path $missingFile ".pa\agent-install.json") (($metadata | ConvertTo-Json -Depth 6) + "`n")
    $staleAgentDir = Join-Path $missingFile ".pa\agent.installing-20260710-005846"
    New-Item -ItemType Directory -Force -Path (Join-Path $staleAgentDir "scripts") | Out-Null
    Write-Utf8 (Join-Path $staleAgentDir "scripts\build_release_manifest.ps1") "# stale release helper`n"

    $strayRepo = Join-Path $projectsRoot "Marketonomy"
    New-Item -ItemType Directory -Force -Path (Join-Path $strayRepo "marketing-agent") | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $strayRepo ".git") | Out-Null
    Write-Utf8 (Join-Path $strayRepo "marketing-agent\AGENTS.md") "# agent`n"
    foreach ($name in @(".git", ".agents", ".codex")) {
        New-Item -ItemType Directory -Force -Path (Join-Path $projectsRoot $name) | Out-Null
    }

    $beforeProject = Read-Utf8 (Join-Path $missingPackage "PROJE.md")
    $dryRun = powershell -NoProfile -ExecutionPolicy Bypass -File $repair `
        -ProjectsRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
        -Version "v5.5.2" `
        -Json
    $dry = ($dryRun -join "`n") | ConvertFrom-Json
    $dryIssues = @($dry.reports | ForEach-Object { $_.issues } | ForEach-Object { $_ })
    Assert-True ($dry.mode -eq "dry-run") "Repair varsayılan olarak dry-run çalışmalı."
    Assert-True ($dryIssues -contains "missing-agent-package") "Dry-run eksik agent paketini raporlamalı."
    Assert-True ($dryIssues -contains "project-file-has-nul") "Dry-run NUL karakterini raporlamalı."
    Assert-True ($dryIssues -contains "stale-agent-install-artifact") "Dry-run yarım kalmış agent kurulum klasörünü raporlamalı."
    Assert-True ((Read-Utf8 (Join-Path $missingPackage "PROJE.md")) -eq $beforeProject) "Dry-run dosya değiştirmemeli."

    powershell -NoProfile -ExecutionPolicy Bypass -File $repair `
        -ProjectsRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
        -Version "v5.5.2" `
        -Apply | Out-Null

    foreach ($project in @($missingPackage, $missingFile)) {
        $projectText = Read-Utf8 (Join-Path $project "PROJE.md")
        $decisionText = Read-Utf8 (Join-Path $project "KARARLAR.md")
        Assert-True (-not $projectText.Contains([string][char]0)) "Repair NUL karakterlerini temizlemeli: $project"
        Assert-True ($decisionText.Contains((New-CorrectEmptyDecisionText))) "Repair bilinen mojibake metni düzeltmeli: $project"
        Assert-True (Test-Path -LiteralPath (Join-Path $project ".pa\agent\AGENTS.md")) "Repair eksik agent paketini kurmalı: $project"
        Assert-True ([bool]((Read-Utf8 (Join-Path $project ".pa\agent-install.json") | ConvertFrom-Json).repo_url)) "Repair repo_url metadata'sını yazmalı: $project"
    }
    Assert-True (-not (Test-Path -LiteralPath $staleAgentDir)) "Repair yarım kalmış agent kurulum klasörünü temizlemeli."

    $postRun = powershell -NoProfile -ExecutionPolicy Bypass -File $repair `
        -ProjectsRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
        -Version "v5.5.2" `
        -Json
    $post = ($postRun -join "`n") | ConvertFrom-Json
    $postProjectIssues = @($post.reports | Where-Object { $_.type -eq "project" } | ForEach-Object { $_.issues } | ForEach-Object { $_ })
    Assert-True ($postProjectIssues -notcontains "missing-agent-package") "Post-check eksik agent paketi raporlamamalı."
    Assert-True ($postProjectIssues -notcontains "project-file-has-nul") "Post-check NUL raporlamamalı."
    Assert-True ($postProjectIssues -notcontains "decisions-file-has-known-mojibake") "Post-check mojibake raporlamamalı."
    Assert-True ($postProjectIssues -notcontains "stale-agent-install-artifact") "Post-check yarım kalmış agent kurulum klasörü raporlamamalı."

    powershell -NoProfile -ExecutionPolicy Bypass -File $repair `
        -ProjectsRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
        -Version "v5.5.2" `
        -Apply `
        -CleanupStrayRepo `
        -CleanupEmptyCodexArtifacts | Out-Null
    Assert-True (-not (Test-Path -LiteralPath $strayRepo)) "CleanupStrayRepo doğrulanmış Marketonomy repo klonunu kaldırmalı."
    foreach ($name in @(".agents", ".codex")) {
        Assert-True (-not (Test-Path -LiteralPath (Join-Path $projectsRoot $name))) "CleanupEmptyCodexArtifacts boş $name klasörünü kaldırmalı."
    }
} catch {
    Add-Failure $_.Exception.Message
} finally {
    if (Test-Path -LiteralPath $tmpRoot) {
        Remove-Item -LiteralPath $tmpRoot -Recurse -Force
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) repair script hatası bulundu."
    exit 1
}

Write-Output "SONUC: Repair script testleri gecti."
exit 0
