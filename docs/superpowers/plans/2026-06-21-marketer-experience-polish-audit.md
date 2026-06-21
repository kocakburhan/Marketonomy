# Marketer Experience Polish Audit Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` or the closest available task-by-task execution workflow in your agent. Implement this plan in order. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Close the remaining product-experience gaps after the first marketer onboarding simulation fix, so the create scripts, onboarding wording, schedule contract, and regression tests agree with each other.

**Architecture:** Keep the product phase as Codex + Google Drive first. Do not add a web app dependency. This is a narrow polish/audit pass over workspace creation, exact onboarding wording, and test coverage.

**Tech Stack:** PowerShell workspace scripts, Markdown behavior contracts, JSON release manifest.

---

## OpenCode'a Verilecek Prompt

OpenCode'u `D:\Projects\PersonalAutonomy-MVP` repo kokunde ac ve su promptu aynen ver:

```text
You are working in D:\Projects\PersonalAutonomy-MVP.

Read and execute this plan exactly:
docs/superpowers/plans/2026-06-21-marketer-experience-polish-audit.md

Context:
- This is not a broad refactor.
- The previous 8 marketer-onboarding fixes mostly pass, but the experience is not yet "100% kusursuz".
- Fix only the remaining contract/test gaps listed in this plan.
- Preserve the Codex + Google Drive first architecture.
- Use test-first changes where the plan says RED/GREEN.
- Rebuild marketing-agent/release-manifest.json after package edits.
- Do not commit unless explicitly asked.

When finished, report:
1. Files changed.
2. Each issue and how it was fixed.
3. Verification commands and exact pass/fail results.
4. Any remaining risk.
```

---

## Problems To Fix

### Problem 1: Project create script does not create daily files

The runtime contract says the weekly schedule folder has:

```text
05-haftalik-planlar/YYYY-WNN/
  schedule.md
  pazartesi.md
  sali.md
  carsamba.md
  persembe.md
  cuma.md
  cumartesi.md
  pazar.md
```

Evidence:

- `marketing-agent/AGENTS.md` says the daily schedule folder has `schedule.md` and one file per day.
- `marketing-agent/agents/schedule-coordinator.md` lists all seven day files.
- `mvp/mvp.md` says `create-project.ps1` creates `schedule.md` and daily files.
- `scripts/create-project.ps1` currently creates only `schedule.md`.
- `scripts/test_marketing_agent_workspace_create.ps1` currently tests only `schedule.md`.

This is a real product-experience gap: a first project workspace starts with a schedule contract that the script does not fully create.

### Problem 2: Exact onboarding sentence drift risk

The stable phrase from prior user direction is:

```text
Kocak sadakatini takdir ediyor.
```

Some current files may use `Koçak sadakatini takdir ediyor.`. That is understandable Turkish, but this phrase has been treated as an exact contract before. Use one exact spelling everywhere in behavior contracts and tests:

```text
Kocak sadakatini takdir ediyor.
```

Do not rely on normalization to hide the mismatch.

### Problem 3: Tests are too weak for these two contracts

Current tests pass even when:

- daily files are missing;
- the exact post-profile sentence changes spelling.

Add regression checks so the same drift cannot return.

---

## File Map

Modify:

- `scripts/create-project.ps1`
- `scripts/test_marketing_agent_workspace_create.ps1`
- `marketing-agent/AGENTS.md`
- `marketing-agent/agents/onboarding-guide.md`
- `marketing-agent/scripts/test_mvp_compatibility.ps1`
- `marketing-agent/scripts/healthcheck.ps1`
- `marketing-agent/release-manifest.json`

Do not modify unless a test proves it is necessary:

- `scripts/install-marketing-agent.ps1`
- `marketing-agent/scripts/update-agent.ps1`
- `marketing-agent/scripts/check-update.ps1`
- `mvp/mvp.md`

---

### Task 1: Add RED Test For Daily Schedule Files

**Files:**
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] After the existing `$scheduleFile` assertion, add checks for all seven day files:

```powershell
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
```

- [ ] Run and confirm RED before implementation:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected before the script fix: failures for missing daily files.

---

### Task 2: Create Seven Daily Schedule Files

**Files:**
- Modify: `scripts/create-project.ps1`

- [ ] After writing `$scheduleFile`, create all seven day files:

```powershell
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
```

- [ ] Run the workspace create test again:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected:

```text
SONUC: Workspace create testleri gecti.
```

---

### Task 3: Standardize Exact Sadakat Sentence

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `marketing-agent/scripts/healthcheck.ps1`

- [ ] Replace all exact post-profile sentence instructions with:

```text
Kocak sadakatini takdir ediyor.
```

Expected locations:

- `marketing-agent/AGENTS.md`
- `marketing-agent/agents/onboarding-guide.md`

- [ ] In `marketing-agent/scripts/test_mvp_compatibility.ps1`, keep the existing positive check for `Kocak sadakatini takdir ediyor.` and add a negative check:

```powershell
Assert-NoText $agentsPath "Koçak sadakatini takdir ediyor." "AGENTS.md sadakat mesaji exact sozlesmeden sapmis"
Assert-NoText (Join-Path $AgentRoot "agents\onboarding-guide.md") "Koçak sadakatini takdir ediyor." "Onboarding sadakat mesaji exact sozlesmeden sapmis"
```

Because `Assert-NoText` normalizes Turkish characters, add an exact raw check that does not normalize:

```powershell
if ((Read-Utf8 $agentsPath).Contains("Koçak sadakatini takdir ediyor.")) {
    Add-Failure "AGENTS.md sadakat mesaji exact sozlesmeden sapmis: Koçak"
}
if ((Read-Utf8 (Join-Path $AgentRoot "agents\onboarding-guide.md")).Contains("Koçak sadakatini takdir ediyor.")) {
    Add-Failure "Onboarding sadakat mesaji exact sozlesmeden sapmis: Koçak"
}
```

- [ ] In `marketing-agent/scripts/healthcheck.ps1`, add:

```powershell
Test-RequiredText "AGENTS.md" "Kocak sadakatini takdir ediyor."
Test-RequiredText "agents\onboarding-guide.md" "Kocak sadakatini takdir ediyor."
Test-ForbiddenText "AGENTS.md" "Koçak sadakatini takdir ediyor."
Test-ForbiddenText "agents\onboarding-guide.md" "Koçak sadakatini takdir ediyor."
```

If `Test-ForbiddenText` uses exact text matching, this is enough for healthcheck.

- [ ] Run:

```powershell
rg -n "Koçak sadakatini" marketing-agent
rg -n "Kocak sadakatini takdir ediyor" marketing-agent\AGENTS.md marketing-agent\agents\onboarding-guide.md marketing-agent\scripts\test_mvp_compatibility.ps1 marketing-agent\scripts\healthcheck.ps1
```

Expected:

- First command: no output.
- Second command: multiple expected matches.

---

### Task 4: Add Compatibility Check For Daily File Contract

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `marketing-agent/scripts/healthcheck.ps1`

- [ ] In `test_mvp_compatibility.ps1`, add required schedule coordinator terms:

```powershell
foreach ($dayFile in @("pazartesi.md", "sali.md", "carsamba.md", "persembe.md", "cuma.md", "cumartesi.md", "pazar.md")) {
    Assert-Text (Join-Path $AgentRoot "agents\schedule-coordinator.md") $dayFile "Schedule coordinator gunluk dosya sozlesmesi eksik"
}
```

- [ ] Add create-script source checks from repo root when available:

```powershell
$createProjectPath = Join-Path $repoRoot "scripts\create-project.ps1"
if (Test-Path -LiteralPath $createProjectPath) {
    foreach ($dayFile in @("pazartesi.md", "sali.md", "carsamba.md", "persembe.md", "cuma.md", "cumartesi.md", "pazar.md")) {
        Assert-Text $createProjectPath $dayFile "create-project.ps1 gunluk dosya olusturmuyor"
    }
}
```

If `$repoRoot` is not already defined before this point, define it once:

```powershell
$repoRoot = Split-Path -Parent $AgentRoot
```

- [ ] In `healthcheck.ps1`, add:

```powershell
foreach ($dayFile in @("pazartesi.md", "sali.md", "carsamba.md", "persembe.md", "cuma.md", "cumartesi.md", "pazar.md")) {
    Test-RequiredText "agents\schedule-coordinator.md" $dayFile
}
```

---

### Task 5: Rebuild Manifest

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [ ] Rebuild manifest:

```powershell
$agentRoot = (Resolve-Path -LiteralPath .\marketing-agent).Path
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Expected:

```text
Manifest generated: ... files, version v5.4.1
```

---

### Task 6: Full Verification

Run all commands:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
git -c safe.directory=D:/Projects/PersonalAutonomy-MVP diff --check
```

Expected:

- Workspace create test passes.
- Install/update test passes.
- MVP compatibility test passes.
- Healthcheck passes.
- `diff --check` exits 0.

Also run:

```powershell
rg -n "Koçak sadakatini" marketing-agent
rg -n "Denenmeye Deger|Revizyonla Denenmeye Deger|Denenmeye Degmez" marketing-agent\pipelines\idea-to-prd.md
```

Expected: no output from both scans.

---

## Codex Review Checklist After OpenCode Finishes

Codex should verify:

1. A fresh project workspace contains `schedule.md` plus all seven day files.
2. The exact sentence is `Kocak sadakatini takdir ediyor.` everywhere it is specified.
3. Tests fail if daily files are removed.
4. Tests fail if the exact sadakat phrase drifts.
5. Manifest is current after package edits.
6. All verification commands pass.
