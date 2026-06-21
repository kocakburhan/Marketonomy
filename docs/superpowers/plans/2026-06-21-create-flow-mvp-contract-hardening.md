# Create Flow MVP Contract Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` or the closest available task-by-task execution workflow in your agent. Implement this plan in order. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make `create-evaluation.ps1` and `create-project.ps1` match the create-flow contract documented in `mvp/mvp.md`, so a fresh marketer workspace is not merely test-passing but actually aligned with the product model.

**Architecture:** Keep the MVP as Codex + Google Drive first. The create scripts may read the marketer root profile because they are approved create flows; the installed Marketing Agent must still stay inside the active workspace after creation. Do not add a web app runtime dependency.

**Tech Stack:** PowerShell create scripts, Markdown workspace templates, JSON state files, release manifest, regression tests.

---

## OpenCode'a Verilecek Prompt

OpenCode'u `D:\Projects\PersonalAutonomy-MVP` repo kokunde ac ve su promptu aynen ver:

```text
You are working in D:\Projects\PersonalAutonomy-MVP.

Read and execute this plan exactly:
docs/superpowers/plans/2026-06-21-create-flow-mvp-contract-hardening.md

Context:
- This is a narrow MVP-contract hardening pass.
- Do not refactor unrelated files.
- Keep Codex + Google Drive first.
- Do not make the web app required.
- Follow the test-first steps.
- Rebuild marketing-agent/release-manifest.json after package edits.
- Do not commit unless explicitly asked.

When finished, report:
1. Files changed.
2. Each MVP contract gap and how it was fixed.
3. Verification commands and exact pass/fail results.
4. Any remaining risk.
```

---

## Why This Is Needed

The previous fixes made the marketer onboarding flow much better, but the product experience is not yet "100% kusursuz" because the create scripts still diverge from `mvp/mvp.md`.

Validated gaps:

1. `mvp/mvp.md` says `create-evaluation.ps1` and `create-project.ps1` copy `.pa/marketer-profile.md` from the marketer root when it exists. Current scripts copy a base profile only when `-MarketerProfilePath` is explicitly passed.
2. `mvp/mvp.md` says empty project output folders get `.gitkeep` so Drive preserves the structure. Current create script creates folders but no `.gitkeep`.
3. `mvp/mvp.md` says the starting weekly plan does not write a user task on the user's behalf. Current `create-project.ps1` writes a checked-list style context task into the weekly plan.
4. `mvp/mvp.md` says `DURUM.md` and state record the active weekly plan path and the starting status is "Proje baglami tamamlaniyor". Current `state.json` has active week fields, but `DURUM.md` does not clearly record the active week path and still says `Baslangic hazirligi`.
5. Tests do not catch these contract gaps.

Do not broaden scope into full web-app workflow or role/membership implementation. This pass is only about local create-flow outputs.

---

## File Map

Modify:

- `scripts/create-evaluation.ps1`
- `scripts/create-project.ps1`
- `scripts/test_marketing_agent_workspace_create.ps1`
- `marketing-agent/scripts/test_mvp_compatibility.ps1`
- `marketing-agent/scripts/healthcheck.ps1`
- `marketing-agent/release-manifest.json`

Do not modify unless a test proves it is required:

- `scripts/install-marketing-agent.ps1`
- `marketing-agent/scripts/update-agent.ps1`
- `marketing-agent/scripts/check-update.ps1`
- `mvp/mvp.md`
- `marketing-agent/AGENTS.md`

---

### Task 1: Add RED Tests For Base Marketer Profile Auto-Copy

**Files:**
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] Add a helper that creates a marketer root profile and invokes create scripts without `-MarketerProfilePath`.

Use this model inside the existing temporary test setup:

```powershell
$marketerRoot = Join-Path $tmpRoot "marketer-root"
$ideaParent = Join-Path $marketerRoot "idea-workspace"
$projectParent = Join-Path $marketerRoot "projects"
New-Item -ItemType Directory -Force -Path (Join-Path $marketerRoot ".pa") | Out-Null
New-Item -ItemType Directory -Force -Path $ideaParent | Out-Null
New-Item -ItemType Directory -Force -Path $projectParent | Out-Null
Write-Utf8 (Join-Path $marketerRoot ".pa\marketer-profile.md") "Profil durumu: Tamamlandi`nKaynak: Test marketer root`n"
```

- [ ] Create a second evaluation workspace under `$ideaParent` without passing `-MarketerProfilePath`:

```powershell
$evaluationAutoProfileRoot = Join-Path $ideaParent "degerlendirme-auto-profile"
powershell -NoProfile -ExecutionPolicy Bypass -File $createEvaluation `
    -TargetRoot $evaluationAutoProfileRoot `
    -Title "Otomatik Profil Degerlendirme" `
    -IdeaId "idea-auto-profile-001" `
    -SourceAgentRoot $agentRoot | Out-Null

Assert-True (Test-Path -LiteralPath (Join-Path $evaluationAutoProfileRoot ".pa\evaluation\marketer-profile.md")) "Evaluation marketer root profili otomatik kopyalanmali."
Assert-True ((Read-Utf8 (Join-Path $evaluationAutoProfileRoot ".pa\evaluation\marketer-profile.md")) -match "Kaynak: Test marketer root") "Evaluation otomatik profil icerigi korunmali."
```

- [ ] Create a second project workspace under `$projectParent` without passing `-MarketerProfilePath`:

```powershell
$projectAutoProfileRoot = Join-Path $projectParent "proje-auto-profile"
powershell -NoProfile -ExecutionPolicy Bypass -File $createProject `
    -TargetRoot $projectAutoProfileRoot `
    -Title "Otomatik Profil Proje" `
    -IdeaId "idea-auto-profile-001" `
    -ProjectId "project-auto-profile-001" `
    -SourceAgentRoot $agentRoot | Out-Null

Assert-True (Test-Path -LiteralPath (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) "Project marketer root profili otomatik kopyalanmali."
Assert-True ((Read-Utf8 (Join-Path $projectAutoProfileRoot ".pa\project\marketer-profile.md")) -match "Kaynak: Test marketer root") "Project otomatik profil icerigi korunmali."
```

- [ ] Run and confirm RED:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected before implementation: auto-profile assertions fail.

---

### Task 2: Implement Marketer Root Profile Auto-Detection

**Files:**
- Modify: `scripts/create-evaluation.ps1`
- Modify: `scripts/create-project.ps1`

- [ ] Add this helper to both create scripts near existing helpers:

```powershell
function Get-MarketerRootProfilePath([string]$Target) {
    $resolvedTarget = if (Test-Path -LiteralPath $Target) {
        (Resolve-Path -LiteralPath $Target).Path
    } else {
        [System.IO.Path]::GetFullPath($Target)
    }
    $parent = Split-Path -Parent $resolvedTarget
    if (-not $parent) { return $null }

    $parentName = Split-Path -Leaf $parent
    $marketerRoot = if ($parentName -in @("idea-workspace", "projects")) {
        Split-Path -Parent $parent
    } else {
        $parent
    }
    if (-not $marketerRoot) { return $null }

    $profilePath = Join-Path $marketerRoot ".pa\marketer-profile.md"
    if (Test-Path -LiteralPath $profilePath) { return $profilePath }
    return $null
}
```

- [ ] After `$target = Assert-SafeTarget $TargetRoot`, resolve the profile source if no explicit path was passed:

```powershell
if (-not $MarketerProfilePath) {
    $MarketerProfilePath = Get-MarketerRootProfilePath $target
}
```

- [ ] Keep explicit `-MarketerProfilePath` precedence. If it is provided, do not auto-detect.

- [ ] Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected: auto-profile tests pass.

---

### Task 3: Add RED Tests For Project Workspace Skeleton Contract

**Files:**
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] Add assertions for `DURUM.md` active week and starting status after `$weekName` is known:

```powershell
$projectDurum = Read-Utf8 (Join-Path $projectRoot "DURUM.md")
Assert-True ($projectDurum -match "Proje baglami tamamlaniyor") "Project DURUM.md baslangic durumunu mvp sozlesmesine gore yazmali."
Assert-True ($projectDurum -match [regex]::Escape("05-haftalik-planlar/$weekName.md")) "Project DURUM.md aktif haftalik plan yolunu yazmali."
```

- [ ] Add assertion that the initial weekly plan does not create a user task:

```powershell
$weekContent = Read-Utf8 $weekFile
Assert-True ($weekContent -notmatch "\[ \]\s+PROJE\.md ve 01-baglam/") "Baslangic haftalik plani kullanici adina gorev yazmamali."
Assert-True ($weekContent -match "Baslangic gorevi yok") "Baslangic haftalik plani bos gorev durumunu acik yazmali."
```

- [ ] Add `.gitkeep` assertions for empty folders that otherwise disappear in Drive/Git sync. Use only folders that are intentionally empty at creation:

```powershell
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
```

- [ ] Run and confirm RED before implementation:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected before implementation: fails on `DURUM.md`, weekly plan task, and `.gitkeep`.

---

### Task 4: Align `create-project.ps1` With The Project Skeleton Contract

**Files:**
- Modify: `scripts/create-project.ps1`

- [ ] Change `DURUM.md` initial content to include MVP-contract status and active week path. Because `$activeWeek` must be known first, either move active-week calculation before writing `DURUM.md`, or write `DURUM.md` after active-week calculation.

Expected `DURUM.md` content:

```powershell
Write-Utf8 (Join-Path $target "DURUM.md") @"
# Durum

- Workspace turu: Project
- Aktif is: Proje baglami tamamlaniyor
- Aktif haftalik plan: 05-haftalik-planlar/$activeWeek.md
- Sonraki adim: 01-baglam/ proje baglamini tamamla.

"@
```

- [ ] Change the weekly plan skeleton so it does not assign a user task:

```powershell
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
```

- [ ] Add `.gitkeep` files to intentionally empty project folders after the folder creation loop:

```powershell
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
    Write-Utf8 (Join-Path $target "$folder\.gitkeep") ""
}
```

- [ ] Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected: workspace create test passes.

---

### Task 5: Add Compatibility Checks So The Contract Does Not Drift Again

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `marketing-agent/scripts/healthcheck.ps1`

- [ ] In `test_mvp_compatibility.ps1`, add source checks against create scripts:

```powershell
$createEvaluationPath = Join-Path $repoRoot "scripts\create-evaluation.ps1"
$createProjectPath = Join-Path $repoRoot "scripts\create-project.ps1"
if (Test-Path -LiteralPath $createEvaluationPath) {
    Assert-Text $createEvaluationPath "Get-MarketerRootProfilePath" "create-evaluation.ps1 marketer root profil auto-copy eksik"
    Assert-Text $createEvaluationPath ".pa\marketer-profile.md" "create-evaluation.ps1 marketer root profil yolu eksik"
}
if (Test-Path -LiteralPath $createProjectPath) {
    Assert-Text $createProjectPath "Get-MarketerRootProfilePath" "create-project.ps1 marketer root profil auto-copy eksik"
    Assert-Text $createProjectPath ".pa\marketer-profile.md" "create-project.ps1 marketer root profil yolu eksik"
    Assert-Text $createProjectPath ".gitkeep" "create-project.ps1 bos klasor .gitkeep korumasi eksik"
    Assert-Text $createProjectPath "Proje baglami tamamlaniyor" "create-project.ps1 mvp baslangic durumunu yazmiyor"
    Assert-Text $createProjectPath "Baslangic gorevi yok" "create-project.ps1 bos haftalik plan sozlesmesi eksik"
}
```

- [ ] In `healthcheck.ps1`, add lightweight checks:

```powershell
Test-RequiredText "..\scripts\create-project.ps1" ".gitkeep"
Test-RequiredText "..\scripts\create-project.ps1" "Proje baglami tamamlaniyor"
Test-RequiredText "..\scripts\create-project.ps1" "Baslangic gorevi yok"
```

If `Test-RequiredText` cannot read paths outside `$AgentRoot`, do not add these to healthcheck; keep them only in `test_mvp_compatibility.ps1`.

---

### Task 6: Rebuild Manifest

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

### Task 7: Full Verification

Run all:

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

Also run targeted scans:

```powershell
rg -n "Koçak sadakatini|Denenmeye Deger|Revizyonla Denenmeye Deger|Denenmeye Degmez|After every task, update" marketing-agent scripts
rg -n "\[ \]\s+PROJE\.md ve 01-baglam/" scripts\create-project.ps1
```

Expected:

- First command: no behavior files should contain stale target strings except test files that intentionally forbid them.
- Second command: no output.

---

## Codex Review Checklist After OpenCode Finishes

Codex should verify:

1. Create scripts auto-copy `.pa/marketer-profile.md` from marketer root when explicit `-MarketerProfilePath` is not passed.
2. Explicit `-MarketerProfilePath` still takes precedence.
3. Project create emits `.gitkeep` for empty project folders.
4. Project `DURUM.md` contains `Proje baglami tamamlaniyor` and active weekly plan path.
5. Initial weekly plan does not create a user task on behalf of the user.
6. All release gates pass after manifest regeneration.
