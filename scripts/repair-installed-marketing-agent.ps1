param(
    [string[]]$ProjectsRoot,
    [string[]]$ProjectRoot,
    [string]$SourceRepoRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$SourceAgentRoot,
    [string]$RepoUrl = "https://github.com/kocakburhan/Marketonomy",
    [string]$Version = "v5.5.2",
    [switch]$Apply,
    [switch]$CleanupStrayRepo,
    [switch]$CleanupEmptyCodexArtifacts,
    [switch]$Json
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Resolve-OptionalDirectory([string]$Path, [string]$Name) {
    if (-not $Path) { return $null }
    $resolved = Resolve-Path -LiteralPath $Path -ErrorAction Stop
    $item = Get-Item -LiteralPath $resolved.Path
    if (-not $item.PSIsContainer) { throw "$Name klasör olmalı: $Path" }
    $item.FullName
}

function Add-UniqueIssue([System.Collections.Generic.List[string]]$Issues, [string]$Issue) {
    if (-not $Issues.Contains($Issue)) {
        $Issues.Add($Issue)
    }
}

function New-CorrectEmptyDecisionText {
    "Hen{0}z karar kayd{1} yok." -f [char]0x00FC, [char]0x0131
}

function Find-ProjectWorkspaces([string]$Root) {
    if (-not (Test-Path -LiteralPath $Root)) { return @() }
    @(
        Get-ChildItem -LiteralPath $Root -Force -Directory |
            Where-Object {
                (Test-Path -LiteralPath (Join-Path $_.FullName "PROJE.md")) -and
                (Test-Path -LiteralPath (Join-Path $_.FullName ".pa\project\state.json"))
            } |
            ForEach-Object { $_.FullName }
    )
}

function Test-DeadSourceAgentRoot([string]$Value) {
    if ([string]::IsNullOrWhiteSpace($Value)) { return $false }
    if ($Value -match "\\AppData\\Local\\Temp\\|\\Temp\\|/tmp/|pa-agent-source-|marketonomy-") { return $true }
    -not (Test-Path -LiteralPath $Value)
}

function Test-StrayMarketonomyRepo([string]$Root) {
    $candidate = Join-Path $Root "Marketonomy"
    (Test-Path -LiteralPath (Join-Path $candidate "marketing-agent\AGENTS.md")) -and
        (Test-Path -LiteralPath (Join-Path $candidate ".git"))
}

function Test-EmptyDirectory([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return $false }
    $item = Get-Item -LiteralPath $Path
    if (-not $item.PSIsContainer) { return $false }
    $entries = @(Get-ChildItem -LiteralPath $Path -Force -Recurse -ErrorAction SilentlyContinue)
    if ($entries.Count -eq 0) { return $true }
    $meaningfulEntries = @($entries | Where-Object { $_.Name -ne "desktop.ini" })
    $meaningfulEntries.Count -eq 0
}

function Get-RootReport([string]$Root) {
    $issues = [System.Collections.Generic.List[string]]::new()
    $actions = [System.Collections.Generic.List[string]]::new()
    $templatePath = Join-Path $script:SourceAgentRootFull "templates\projects-root-bootstrap-AGENTS.md"
    $agentsPath = Join-Path $Root "AGENTS.md"

    if (-not (Test-Path -LiteralPath $agentsPath)) {
        Add-UniqueIssue $issues "projects-bootstrap-needs-update"
    } elseif (Test-Path -LiteralPath $templatePath) {
        $current = (Read-Utf8 $agentsPath).TrimEnd()
        $template = (Read-Utf8 $templatePath).TrimEnd()
        if ($current -ne $template) { Add-UniqueIssue $issues "projects-bootstrap-needs-update" }
    }

    if (Test-StrayMarketonomyRepo $Root) { Add-UniqueIssue $issues "stray-marketonomy-repo" }
    foreach ($name in @(".git", ".agents", ".codex")) {
        if (Test-Path -LiteralPath (Join-Path $Root $name)) { Add-UniqueIssue $issues "stray-dot-$($name.TrimStart('.'))" }
    }

    if ($Apply) {
        $rootInstaller = Join-Path $SourceRepoRootFull "scripts\install-projects-root.ps1"
        & powershell -NoProfile -ExecutionPolicy Bypass -File $rootInstaller `
            -TargetRoot $Root `
            -SourceRepoRoot $SourceRepoRootFull `
            -RepoUrl $RepoUrl `
            -Version $Version | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Projects root installer başarısız oldu: $Root" }
        $actions.Add("projects-root-onboarding-reinstalled")

        if ($CleanupStrayRepo -and (Test-StrayMarketonomyRepo $Root)) {
            Remove-Item -LiteralPath (Join-Path $Root "Marketonomy") -Recurse -Force
            $actions.Add("removed-stray-marketonomy-repo")
        }

        if ($CleanupEmptyCodexArtifacts) {
            foreach ($name in @(".git", ".agents", ".codex")) {
                $artifact = Join-Path $Root $name
                if (Test-EmptyDirectory $artifact) {
                    Remove-Item -LiteralPath $artifact -Recurse -Force
                    $actions.Add("removed-empty-$($name.TrimStart('.'))")
                }
            }
        }
    }

    [ordered]@{
        type = "projects-root"
        path = $Root
        issues = @($issues)
        actions = @($actions)
    }
}

function Repair-KnownProjectText([string]$Project) {
    $actions = [System.Collections.Generic.List[string]]::new()
    $projectFile = Join-Path $Project "PROJE.md"
    if (Test-Path -LiteralPath $projectFile) {
        $text = Read-Utf8 $projectFile
        $updated = $text.Replace(([string][char]0) + "2-arastirma", '`02-arastirma')
        $updated = $updated.Replace(([string][char]0) + "3-strateji", '`03-strateji')
        if ($updated.Contains([string][char]0)) {
            throw "PROJE.md içinde bilinmeyen NUL karakteri kaldı: $Project"
        }
        if ($updated -ne $text) {
            Write-Utf8 $projectFile $updated
            $actions.Add("fixed-project-file-nul")
        }
    }

    $decisionsFile = Join-Path $Project "KARARLAR.md"
    if (Test-Path -LiteralPath $decisionsFile) {
        $text = Read-Utf8 $decisionsFile
        $knownBadDecisions = @(
            ("Hen{0}{1}{2}{3}z karar kaydi yok." -f [char]0x00C3, [char]0x0192, [char]0x00C2, [char]0x00BC),
            ("Hen{0}{1}z karar kaydi yok." -f [char]0x00C3, [char]0x00BC),
            ("Hen{0}{1}z karar kayd{2}{3} yok." -f [char]0x00C3, [char]0x00BC, [char]0x00C4, [char]0x00B1),
            "Henuz karar kaydi yok."
        )
        $updated = $text
        $correctEmptyDecision = New-CorrectEmptyDecisionText
        foreach ($knownBadDecision in $knownBadDecisions) {
            $updated = $updated.Replace($knownBadDecision, $correctEmptyDecision)
        }
        if ($updated -ne $text) {
            Write-Utf8 $decisionsFile $updated
            $actions.Add("fixed-decisions-known-mojibake")
        }
    }

    @($actions)
}

function Get-ProjectReport([string]$Project) {
    $issues = [System.Collections.Generic.List[string]]::new()
    $actions = [System.Collections.Generic.List[string]]::new()
    $agentRoot = Join-Path $Project ".pa\agent"
    $manifestPath = Join-Path $agentRoot "release-manifest.json"
    $paRoot = Join-Path $Project ".pa"
    $staleAgentDirs = @()

    if (Test-Path -LiteralPath $paRoot) {
        $staleAgentDirs = @(
            Get-ChildItem -LiteralPath $paRoot -Force -Directory -ErrorAction SilentlyContinue |
                Where-Object { $_.Name -like "agent.installing-*" -or $_.Name -like "agent.backup-*" }
        )
        if ($staleAgentDirs.Count -gt 0) {
            Add-UniqueIssue $issues "stale-agent-install-artifact"
        }
    }

    if (-not (Test-Path -LiteralPath $agentRoot)) {
        Add-UniqueIssue $issues "missing-agent-package"
    } elseif (-not (Test-Path -LiteralPath $manifestPath)) {
        Add-UniqueIssue $issues "missing-manifest-file"
    } else {
        try {
            $manifest = Read-Utf8 $manifestPath | ConvertFrom-Json
            foreach ($file in $manifest.files) {
                if (-not (Test-Path -LiteralPath (Join-Path $agentRoot $file.path))) {
                    Add-UniqueIssue $issues "missing-manifest-entry-file:$($file.path)"
                }
            }
        } catch {
            Add-UniqueIssue $issues "missing-manifest-file"
        }
    }

    $metadataPath = Join-Path $Project ".pa\agent-install.json"
    if (-not (Test-Path -LiteralPath $metadataPath)) {
        Add-UniqueIssue $issues "agent-install-missing-repo-url"
    } else {
        try {
            $metadata = Read-Utf8 $metadataPath | ConvertFrom-Json
            if ([string]::IsNullOrWhiteSpace([string]$metadata.repo_url)) {
                Add-UniqueIssue $issues "agent-install-missing-repo-url"
            }
            if (Test-DeadSourceAgentRoot ([string]$metadata.source_agent_root)) {
                Add-UniqueIssue $issues "agent-install-dead-temp-source"
            }
        } catch {
            Add-UniqueIssue $issues "agent-install-missing-repo-url"
        }
    }

    $projectFile = Join-Path $Project "PROJE.md"
    if (Test-Path -LiteralPath $projectFile) {
        $projectText = Read-Utf8 $projectFile
        if ($projectText.Contains([string][char]0)) { Add-UniqueIssue $issues "project-file-has-nul" }
    }

    $decisionsFile = Join-Path $Project "KARARLAR.md"
    if (Test-Path -LiteralPath $decisionsFile) {
        $decisionText = Read-Utf8 $decisionsFile
        $badHenSingle = "Hen{0}{1}z karar kaydi yok" -f [char]0x00C3, [char]0x00BC
        $badHenDouble = "Hen{0}{1}{2}{3}z karar kaydi yok" -f [char]0x00C3, [char]0x0192, [char]0x00C2, [char]0x00BC
        $badHenMixed = "Hen{0}{1}z karar kayd{2}{3} yok" -f [char]0x00C3, [char]0x00BC, [char]0x00C4, [char]0x00B1
        if ($decisionText.Contains($badHenSingle) -or
            $decisionText.Contains($badHenDouble) -or
            $decisionText.Contains($badHenMixed) -or
            $decisionText.Contains("Henuz karar kaydi yok")) {
            Add-UniqueIssue $issues "decisions-file-has-known-mojibake"
        }
    }

    $templatePath = Join-Path $SourceAgentRootFull "templates\workspace-bootstrap-AGENTS.md"
    $agentsPath = Join-Path $Project "AGENTS.md"
    if (-not (Test-Path -LiteralPath $agentsPath)) {
        Add-UniqueIssue $issues "workspace-bootstrap-needs-update"
    } elseif (Test-Path -LiteralPath $templatePath) {
        $current = (Read-Utf8 $agentsPath).TrimEnd()
        $template = (Read-Utf8 $templatePath).TrimEnd()
        if ($current -ne $template) { Add-UniqueIssue $issues "workspace-bootstrap-needs-update" }
    }

    if ($Apply) {
        foreach ($action in (Repair-KnownProjectText $Project)) { $actions.Add($action) }
        $installer = Join-Path $SourceRepoRootFull "scripts\install-marketing-agent.ps1"
        & powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
            -TargetRoot $Project `
            -SourceAgentRoot $SourceAgentRootFull `
            -RepoUrl $RepoUrl `
            -Version $Version | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Agent installer başarısız oldu: $Project" }
        $actions.Add("agent-package-reinstalled")

        foreach ($staleAgentDir in $staleAgentDirs) {
            if (Test-Path -LiteralPath $staleAgentDir.FullName) {
                Remove-Item -LiteralPath $staleAgentDir.FullName -Recurse -Force
                $actions.Add("removed-stale-agent-install-artifact:$($staleAgentDir.Name)")
            }
        }
    }

    [ordered]@{
        type = "project"
        path = $Project
        issues = @($issues)
        actions = @($actions)
    }
}

$SourceRepoRootFull = Resolve-OptionalDirectory $SourceRepoRoot "SourceRepoRoot"
if (-not $SourceAgentRoot) {
    $SourceAgentRoot = Join-Path $SourceRepoRootFull "marketing-agent"
}
$SourceAgentRootFull = Resolve-OptionalDirectory $SourceAgentRoot "SourceAgentRoot"

$allRoots = [System.Collections.Generic.List[string]]::new()
$allProjects = [System.Collections.Generic.List[string]]::new()

foreach ($root in @($ProjectsRoot)) {
    if ([string]::IsNullOrWhiteSpace($root)) { continue }
    $resolvedRoot = Resolve-OptionalDirectory $root "ProjectsRoot"
    if (-not $allRoots.Contains($resolvedRoot)) { $allRoots.Add($resolvedRoot) }
    foreach ($project in (Find-ProjectWorkspaces $resolvedRoot)) {
        if (-not $allProjects.Contains($project)) { $allProjects.Add($project) }
    }
}

foreach ($project in @($ProjectRoot)) {
    if ([string]::IsNullOrWhiteSpace($project)) { continue }
    $resolvedProject = Resolve-OptionalDirectory $project "ProjectRoot"
    if (-not (Test-Path -LiteralPath (Join-Path $resolvedProject "PROJE.md")) -or
        -not (Test-Path -LiteralPath (Join-Path $resolvedProject ".pa\project\state.json"))) {
        if ((Test-Path -LiteralPath (Join-Path $resolvedProject "AGENTS.md")) -and
            (Test-Path -LiteralPath (Join-Path $resolvedProject ".pa\onboarding-install.json"))) {
            if (-not $allRoots.Contains($resolvedProject)) { $allRoots.Add($resolvedProject) }
            foreach ($projectFromRoot in (Find-ProjectWorkspaces $resolvedProject)) {
                if (-not $allProjects.Contains($projectFromRoot)) { $allProjects.Add($projectFromRoot) }
            }
            continue
        }
        throw "ProjectRoot geçerli proje workspace'i değil: $resolvedProject"
    }
    if (-not $allProjects.Contains($resolvedProject)) { $allProjects.Add($resolvedProject) }
}

if ($allRoots.Count -eq 0 -and $allProjects.Count -eq 0) {
    throw "En az bir -ProjectsRoot veya -ProjectRoot ver."
}

$reports = [System.Collections.Generic.List[object]]::new()
foreach ($root in $allRoots) {
    $reports.Add((Get-RootReport $root))
}
foreach ($project in $allProjects) {
    $reports.Add((Get-ProjectReport $project))
}

$summary = [ordered]@{
    mode = if ($Apply) { "apply" } else { "dry-run" }
    source_repo_root = $SourceRepoRootFull
    source_agent_root = $SourceAgentRootFull
    repo_url = $RepoUrl
    version = $Version
    reports = @($reports)
}

if ($Json) {
    $summary | ConvertTo-Json -Depth 8
} else {
    Write-Output "Mode: $($summary.mode)"
    foreach ($report in $reports) {
        Write-Output "$($report.type): $($report.path)"
        if ($report.issues.Count -gt 0) {
            Write-Output "  Issues: $($report.issues -join ', ')"
        } else {
            Write-Output "  Issues: none"
        }
        if ($report.actions.Count -gt 0) {
            Write-Output "  Actions: $($report.actions -join ', ')"
        }
    }
}
