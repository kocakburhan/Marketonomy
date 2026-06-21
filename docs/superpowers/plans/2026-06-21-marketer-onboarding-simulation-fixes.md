# Marketer Onboarding Simulation Fixes Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` or the closest available task-by-task execution workflow in your agent. Implement this plan in order. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the first-time marketer experience so a user can open Codex, say "merhaba, ilk kez kullaniyorum", then continue with "x urun fikrim var" or an urgent tactical request without broken workspace files, stale web-app assumptions, wrong output paths, or unnecessary operational friction.

**Architecture:** Keep phase 1 as Codex + Google Drive first. Do not make the web app required. Strengthen create scripts, onboarding, idea-evaluation routing, specialist work-mode language, and regression tests.

**Tech Stack:** PowerShell workspace scripts, Markdown behavior contracts, JSON state files, SHA-256 release manifest.

---

## OpenCode'a Verilecek Prompt

OpenCode'u `D:\Projects\PersonalAutonomy-MVP` repo kokunde ac ve su promptu aynen ver:

```text
You are working in D:\Projects\PersonalAutonomy-MVP.

Read and execute this plan exactly:
docs/superpowers/plans/2026-06-21-marketer-onboarding-simulation-fixes.md

Context:
- This repo distributes the PersonalAutonomy Marketing Agent package.
- Phase 1 is Codex + Google Drive first. Do not make the web app required.
- The user wants the agent to work smoothly for a first-time marketer.
- Fix the eight issues in the plan one by one.
- Use test-first changes where the plan says RED/GREEN.
- Use safe file edits. Do not create real customer/project examples outside temporary test folders.
- Preserve existing Turkish folder/file names.
- Keep internal agent instructions in English and user-visible guidance in Turkish.
- Do not commit unless explicitly asked.

When finished, report:
1. Files changed.
2. Each of the eight issues and how it was fixed.
3. Verification commands and exact pass/fail results.
4. Any remaining risk.
```

---

## The Eight Issues

1. `scripts/create-project.ps1` writes a NUL/control character into `DURUM.md` because PowerShell interprets `` `0 `` inside `` `01-baglam/` ``.
2. `scripts/create-evaluation.ps1` does not create `.pa/evaluation/settings.json`, but `marketing-agent/AGENTS.md` expects evaluation settings during startup.
3. `scripts/create-project.ps1` creates `05-haftalik-planlar/` but not the active ISO weekly plan and `schedule.md` skeleton expected by onboarding/scheduling.
4. `mvp/mvp.md` still has first-phase web-app wording and an old completion rule that conflicts with Codex + Drive first.
5. `marketing-agent/pipelines/idea-to-prd.md` mixes evaluation workspace work with project-only output paths.
6. `marketing-agent/agents/onboarding-guide.md` is too broad for the first 10 minutes and lacks a simple marketer decision tree.
7. Some specialist playbooks still say "After every task, update DURUM.md...", which conflicts with Quick advisory / Workspace task / Pipeline mode.
8. Current tests do not catch these first-time marketer failures.

---

## File Map

Modify:

- `scripts/create-project.ps1`
- `scripts/create-evaluation.ps1`
- `scripts/test_marketing_agent_workspace_create.ps1`
- `marketing-agent/scripts/test_mvp_compatibility.ps1`
- `marketing-agent/scripts/healthcheck.ps1`
- `mvp/mvp.md`
- `marketing-agent/pipelines/idea-to-prd.md`
- `marketing-agent/agents/onboarding-guide.md`
- specialist files under `marketing-agent/agents/*.md` that contain old "After every task" state-update language
- `marketing-agent/agent-version.json`
- `marketing-agent/release-manifest.json` after regeneration

Do not modify unless a test proves it is required:

- `scripts/install-marketing-agent.ps1`
- `marketing-agent/scripts/update-agent.ps1`
- `marketing-agent/scripts/check-update.ps1`

---

### Task 1: Add RED Tests For Workspace Creation Bugs

**Files:**
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] Add this helper after `Assert-Equal`:

```powershell
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
```

- [ ] After evaluation state/profile assertions, add:

```powershell
$evaluationSettingsPath = Join-Path $evaluationRoot ".pa\evaluation\settings.json"
Assert-True (Test-Path -LiteralPath $evaluationSettingsPath) "Evaluation settings.json olusmali."
if (Test-Path -LiteralPath $evaluationSettingsPath) {
    $evaluationSettings = Read-Utf8 $evaluationSettingsPath | ConvertFrom-Json
    Assert-Equal $evaluationSettings.timezone "Europe/Istanbul" "Evaluation timezone Europe/Istanbul olmali."
}
Assert-NoControlChars (Join-Path $evaluationRoot "DURUM.md") "Evaluation DURUM.md temiz olmali."
```

- [ ] After project `PROJE.md` assertion, add:

```powershell
Assert-NoControlChars (Join-Path $projectRoot "DURUM.md") "Project DURUM.md temiz olmali."
Assert-True ((Read-Utf8 (Join-Path $projectRoot "DURUM.md")) -match "01-baglam/") "Project DURUM.md 01-baglam yolunu okunabilir yazmali."
```

- [ ] After project state assertions, add active week checks:

```powershell
$isoYear = [System.Globalization.ISOWeek]::GetYear((Get-Date))
$isoWeek = [System.Globalization.ISOWeek]::GetWeekOfYear((Get-Date))
$weekName = "{0}-W{1:D2}" -f $isoYear, $isoWeek
$weekFile = Join-Path $projectRoot "05-haftalik-planlar\$weekName.md"
$scheduleFile = Join-Path $projectRoot "05-haftalik-planlar\$weekName\schedule.md"
Assert-True (Test-Path -LiteralPath $weekFile) "Aktif ISO hafta plani olusmali: $weekName.md"
Assert-True (Test-Path -LiteralPath $scheduleFile) "Aktif ISO hafta schedule.md olusmali."
if (Test-Path -LiteralPath $weekFile) { Assert-NoControlChars $weekFile "Haftalik plan temiz olmali." }
if (Test-Path -LiteralPath $scheduleFile) { Assert-NoControlChars $scheduleFile "Haftalik schedule temiz olmali." }
```

- [ ] Run and confirm RED:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected before implementation: fails for missing evaluation settings, project control character, and missing weekly plan files.

---

### Task 2: Fix Create Scripts

**Files:**
- Modify: `scripts/create-evaluation.ps1`
- Modify: `scripts/create-project.ps1`

- [ ] In `scripts/create-evaluation.ps1`, after writing `.pa\evaluation\active-task.md`, add:

```powershell
Write-Utf8 (Join-Path $target ".pa\evaluation\settings.json") "{`"timezone`":`"Europe/Istanbul`"}`n"
```

- [ ] In `scripts/create-project.ps1`, replace this line in `DURUM.md`:

```powershell
- Sonraki adim: `01-baglam/` proje baglamini tamamla.
```

with:

```powershell
- Sonraki adim: 01-baglam/ proje baglamini tamamla.
```

- [ ] In `scripts/create-project.ps1`, add this helper near other helpers:

```powershell
function Get-ActiveIsoWeekName([datetime]$Date) {
    $isoYear = [System.Globalization.ISOWeek]::GetYear($Date)
    $isoWeek = [System.Globalization.ISOWeek]::GetWeekOfYear($Date)
    return "{0}-W{1:D2}" -f $isoYear, $isoWeek
}
```

- [ ] After `.pa\project\overrides-approved.md` is written, create the active week skeleton:

```powershell
$activeWeek = Get-ActiveIsoWeekName $now
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
- [ ] PROJE.md ve 01-baglam/ proje baglamini tamamla. Durum: Acik

## Notlar
- Bu dosya create-project.ps1 tarafindan baslangic iskeleti olarak olusturuldu.

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
```

- [ ] Add these fields to the `$state = [ordered]@{ ... }` block after `$activeWeek` is defined:

```powershell
active_week = $activeWeek
active_week_plan = "05-haftalik-planlar/$activeWeek.md"
```

If `$state` is currently built before `$activeWeek`, move the active-week block above `$state`.

- [ ] Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected:

```text
SONUC: Workspace create testleri gecti.
```

---

### Task 3: Add Compatibility Checks For Behavior Contracts

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `marketing-agent/scripts/healthcheck.ps1`

- [ ] In `test_mvp_compatibility.ps1`, near current onboarding assertions, add:

```powershell
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Ilk 10 Dakika Marketer Yolculugu" "Onboarding ilk 10 dakika yolculugu eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Simdi ne yapmak istiyorsun?" "Onboarding ilk niyet sorusu eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Fikrim var" "Onboarding fikir var secenegi eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Fikrim yok" "Onboarding fikir yok secenegi eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Mevcut proje" "Onboarding mevcut proje secenegi eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Acil taktik is" "Onboarding acil taktik is secenegi eksik"
```

- [ ] Add idea-to-PRD path split checks:

```powershell
Assert-Text (Join-Path $AgentRoot "pipelines\idea-to-prd.md") "Evaluation Workspace Output Paths" "Idea-to-PRD evaluation path ayrimi eksik"
Assert-Text (Join-Path $AgentRoot "pipelines\idea-to-prd.md") "Project Workspace Output Paths" "Idea-to-PRD project path ayrimi eksik"
Assert-Text (Join-Path $AgentRoot "pipelines\idea-to-prd.md") "Marketer Fit Guidance is not the idea-value verdict" "Marketer fit verdict ayrimi eksik"
```

- [ ] Add old specialist-language ban:

```powershell
foreach ($specialistFile in Get-ChildItem -LiteralPath (Join-Path $AgentRoot "agents") -Filter *.md) {
    Assert-NoText $specialistFile.FullName "After every task, update DURUM.md" "Eski specialist state update dili kalmis: agents/$($specialistFile.Name)"
    Assert-NoText $specialistFile.FullName "After every task, update" "Eski specialist state update dili kalmis: agents/$($specialistFile.Name)"
}
```

- [ ] Add `mvp/mvp.md` stale-text scan when the repo root exists:

```powershell
$repoRoot = Split-Path -Parent $AgentRoot
$mvpPath = Join-Path $repoRoot "mvp\mvp.md"
if (Test-Path -LiteralPath $mvpPath) {
    Assert-NoText $mvpPath "web app'in degismez `idea_id`" "mvp.md ilk fazda web app idea_id ifadesi kalmis"
    Assert-NoText $mvpPath "Degerlendirme sonucu, istege bagli aciklama ve istege bagli rapor linki web app'e yazilir" "mvp.md web app sonuc yazma ifadesi kalmis"
    Assert-NoText $mvpPath "Ilgili haftalik gorev yalnizca kullanici tamamlanma onayindan sonra kapatilir" "mvp.md eski haftalik kapanis kurali kalmis"
}
```

- [ ] In `healthcheck.ps1`, under `[Behavior contracts]`, add:

```powershell
Test-RequiredText "agents\onboarding-guide.md" "Ilk 10 Dakika Marketer Yolculugu"
Test-RequiredText "agents\onboarding-guide.md" "Simdi ne yapmak istiyorsun?"
Test-RequiredText "pipelines\idea-to-prd.md" "Evaluation Workspace Output Paths"
Test-RequiredText "pipelines\idea-to-prd.md" "Project Workspace Output Paths"
Test-RequiredText "pipelines\idea-to-prd.md" "Marketer Fit Guidance is not the idea-value verdict"
```

- [ ] Run and confirm RED before later docs are fixed:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent -SkipManifest
```

Expected before implementation: fails for missing onboarding journey, missing path split, old specialist language, and stale MVP text.

---

### Task 4: Fix Stale First-Phase Statements In `mvp/mvp.md`

**Files:**
- Modify: `mvp/mvp.md`

- [ ] Find stale web-app/completion text:

```powershell
rg -n "web app'in degismez|web app'teki sonuca|Degerlendirme sonucu, istege bagli aciklama ve istege bagli rapor linki web app'e yazilir|web app kaydi ile yerel workspace|Ilgili haftalik gorev yalnizca kullanici tamamlanma onayindan sonra kapatilir" mvp\mvp.md
```

- [ ] Replace first-phase web-app identity wording with Drive-first wording:

```markdown
`DEGERLENDIRME.md`, approved create flow tarafindan uretilen veya parametre olarak verilen
degismez `idea_id` degerini, fikir basligini, incelenen fikir surumunu ve degerlendirme
kriterlerini tutar.
```

- [ ] Replace report/web-app result wording with:

```markdown
`RAPOR.md`, marketer'in inceleyip onaylayacagi calisma raporudur. Ilk fazda rapor Drive
workspace'inde kalir; ileriki web app fazinda istenirse bu rapora link verilebilir.
```

- [ ] Replace "web app'e sonuc yazilir" wording with:

```markdown
Degerlendirme sonucu ve gerekcesi ilk fazda `RAPOR.md`, `DURUM.md` ve gerekiyorsa
`KARARLAR.md` icinde tutulur. Web app'e sonuc yazma akisi post-MVP kapsamidir.
```

- [ ] Replace old local workspace/web-app sync wording with:

```markdown
- Degismez `idea_id` ve `project_id` degerleri approved create flow ile yerel workspace
  arasindaki kimlik tutarliligi icindir.
```

- [ ] Replace old completion rule with:

```markdown
Ilgili haftalik gorev, workspace artifact'i gorevi acikca kanitliyorsa agent tarafindan kapatilir
ve kullanici bilgilendirilir. Harici aksiyonlar kullanici tamamladigini bildirene kadar
`Kullanici Bildirimi Bekliyor` kalir. Final yayin veya teslim acik kullanici onayi ister.
```

- [ ] Run the scan again. Expected: no output.

---

### Task 5: Fix Evaluation vs Project Paths In `idea-to-prd.md`

**Files:**
- Modify: `marketing-agent/pipelines/idea-to-prd.md`

- [ ] Add this section after `Pipeline Flow`:

```markdown
## Workspace Output Path Rules

### Evaluation Workspace Output Paths

In an evaluation workspace, this pipeline is only an idea-value decision process. It must not
write project folders, MVP final documents, PRDs, coder briefs, launch plans, or weekly project
plans.

Use these paths:

| Output | Path |
|---|---|
| User/marketer execution guidance | `ciktilar/kullanici-pazarlama-avantaji.md` |
| Market and competitor research | `ciktilar/pazar-arastirmasi.md` |
| Idea value decision | `ciktilar/fikir-dogrulama.md` |
| Publishable working decision report | `RAPOR.md` |
| Operational status | `DURUM.md` and `.pa/evaluation/active-task.md` |

If the idea is approved as `Denenmeye Deger` or `Revizyonla Denenmeye Deger`, the project
workspace is created separately through the approved create flow.

### Project Workspace Output Paths

In a project workspace, use these paths after the idea-value decision is approved:

| Output | Path |
|---|---|
| User/marketer execution guidance | `03-strateji/dogrulama/kullanici-pazarlama-avantaji.md` |
| Market and competitor research | `02-arastirma/pazar-arastirmasi.md` |
| Idea value decision | `03-strateji/dogrulama/fikir-dogrulama.md` |
| MVP | `04-urun/fikir-ozetleri/mvp.md` |
| PRD | `04-urun/prd/prd.md` |
| Coder brief | `04-urun/coder-briefleri/coder-brief.md` |
| Operational status | `DURUM.md` and `.pa/project/active-task.md` |

### Marketer Fit Guidance is not the idea-value verdict

Marketer fit can affect the recommended validation route, channel support, mentor/partner need,
budget caution, and execution risk. It must never turn an otherwise valuable idea into
`Denenmeye Degmez` by itself.
```

- [ ] Replace Step 5.2 output heading:

```markdown
**Output format:** use the workspace-specific path from `Workspace Output Path Rules`.
```

- [ ] Replace Step 5.4 output heading with the same sentence.

- [ ] Update the final `Output Files` section so it has separate evaluation and project path groups.

- [ ] Run:

```powershell
rg -n "03-strateji/dogrulama/kullanici-pazarlama-avantaji.md|03-strateji/dogrulama/fikir-dogrulama.md" marketing-agent\pipelines\idea-to-prd.md
```

Expected: hits are allowed only under `Project Workspace Output Paths` or project-only explanation.

---

### Task 6: Add First-Time Marketer Journey To Onboarding

**Files:**
- Modify: `marketing-agent/agents/onboarding-guide.md`

- [ ] Add this section after `Marketing Agent Capability Orientation`:

````markdown
## Ilk 10 Dakika Marketer Yolculugu

When the user says "merhaba", "ilk kez kullaniyorum", "nasil kullanacagim", or similar, do not
start with a long internal system tour. Use this order:

1. Confirm the workspace type in user language:
   - Evaluation workspace: "Bu alan bir fikir degerlendirme alani. Ana soru: Bu fikir denenmeye deger mi?"
   - Project workspace: "Bu alan bir proje calisma alani. Ana is: onayli fikri pazara, urune ve haftalik uygulamaya cevirmek."
2. If the marketer profile is missing, ask the compact profile form once.
3. After saving or postponing the profile, say exactly: "Kocak sadakatini takdir ediyor."
4. Give a short capability menu grouped by outcome, not internal agent names.
5. Ask one direct intent question.

Use this exact first intent question in Turkish:

```markdown
Simdi ne yapmak istiyorsun?

1. Fikrim var: Fikrin denenmeye deger mi, once bunu kanitlarla degerlendirelim.
2. Fikrim yok: Veri, sikayet, trend ve rakip bosluklarindan firsat arayalim.
3. Mevcut proje: Proje baglamini, eksikleri, haftalik plani ve ilk uygulanacak isleri netlestirelim.
4. Acil taktik is: Brosur, e-posta, sosyal medya, teklif, sunum veya saha materyali gibi tek bir ciktiyi hemen uretelim.
5. Satis/pazarlama sistemi: ICP, kanal, kampanya, icerik, outbound, launch, metrik ve takip sistemini birlikte kuralim.
```

After the user chooses, route according to `agents/orchestrator.md`. Do not force the full
capability table into the first answer unless the user asks "neler yapabiliyorsun?".
````

- [ ] Add this short outcome menu under the same section:

```markdown
### Kisa Kabiliyet Menusu

- Fikir: fikir bulma, fikir degerlendirme, revizyon, ilk dogrulama testi.
- Pazar: rakip, musteri, yorum/sikayet, trend, fiyat ve konumlandirma arastirmasi.
- Urun: MVP, PRD, coder brief, ozellik kapsami, teknik olmayan urun kararlari.
- Pazarlama: landing page, email, sosyal medya, reklam, SEO/ASO, icerik sistemi.
- Satis: ICP, prospect kriterleri, cold email, teklif, demo, saha takip, partner/kanal.
- Lansman ve buyume: launch plani, haftalik uygulama, referral, retention, churn, metrikler.
- Yatirimci: pitch deck, one-pager, financial model, data room, due diligence hazirligi.
```

- [ ] In `How to present the orientation`, ensure this rule exists:

```markdown
Do not show the full agent/skill table in the first response by default. Show it only when the
user asks for the full capability map or when it materially helps the selected task.
```

- [ ] Run:

```powershell
rg -n "Ilk 10 Dakika Marketer Yolculugu|Simdi ne yapmak istiyorsun\?|Fikrim var|Fikrim yok|Mevcut proje|Acil taktik is" marketing-agent\agents\onboarding-guide.md
```

Expected: every term appears.

---

### Task 7: Replace Old Specialist State-Update Language

**Files:**
- Modify matching files under `marketing-agent/agents/`

- [ ] Find old language:

```powershell
rg -n "After every task, update DURUM.md|After every task, update" marketing-agent\agents
```

- [ ] Replace each old sentence with:

```markdown
- For Workspace task or Pipeline mode, update `DURUM.md` and the relevant `.pa/*/active-task.md`
  only when the canonical operational fact actually changed. Quick advisory does not update
  workspace state.
```

- [ ] If a file has a variant with the same meaning, replace it with the same sentence.

- [ ] Verify old language is gone:

```powershell
rg -n "After every task, update DURUM.md|After every task, update" marketing-agent\agents
```

Expected: no output.

- [ ] Verify new language exists:

```powershell
rg -n "Quick advisory does not update workspace state" marketing-agent\agents
```

Expected: multiple specialist files appear.

---

### Task 8: Fix Weekly Plan Truncation If Present

**Files:**
- Modify: `marketing-agent/AGENTS.md`

- [ ] Inspect weekly plan section:

```powershell
$lines = Get-Content -LiteralPath .\marketing-agent\AGENTS.md
$start = ($lines | Select-String -Pattern "^## Weekly Plan$").LineNumber
$lines[($start-1)..([Math]::Min($lines.Count-1, $start+35))]
```

- [ ] If the sentence ends with `External calendar or app views do not`, replace the paragraph with:

```markdown
The weekly plan system is used only in project workspaces. The operational timezone is
`Europe/Istanbul`; the week standard is ISO Monday-Sunday. The main plan file is
`05-haftalik-planlar/YYYY-WNN.md`; the daily schedule folder is
`05-haftalik-planlar/YYYY-WNN/` with `schedule.md` and one file per day. External calendar or app
views do not store a copy of the weekly plan and are not the source of truth.
```

- [ ] Verify:

```powershell
rg -n "External calendar or app views do not$" marketing-agent\AGENTS.md
```

Expected: no output.

---

### Task 9: Bump Version And Rebuild Manifest

**Files:**
- Modify: `marketing-agent/agent-version.json`
- Modify: `marketing-agent/release-manifest.json`

- [ ] Set `marketing-agent/agent-version.json` to:

```json
{
  "version": "v5.4.1",
  "runtime": "codex",
  "mvp_contract": "PersonalAutonomy MVP 2026-06-21",
  "release_status": "source"
}
```

- [ ] Rebuild manifest:

```powershell
$agentRoot = (Resolve-Path -LiteralPath .\marketing-agent).Path
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Expected: manifest generated with version `v5.4.1`. Do not manually edit manifest hashes.

---

### Task 10: Full Verification

Run all commands from repo root:

- [ ] Workspace create:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected:

```text
SONUC: Workspace create testleri gecti.
```

- [ ] Install/update regression:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
```

Expected:

```text
SONUC: Install/update davranis testleri gecti.
```

- [ ] MVP compatibility:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
```

Expected:

```text
SONUC: Marketing Agent Codex ve PersonalAutonomy MVP uyumluluk denetiminden gecti.
```

- [ ] Healthcheck:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
```

Expected:

```text
SONUC: HAZIR - zorunlu release yapisi gecerli
```

Optional Python/Node warnings are acceptable if the required checks pass.

- [ ] Stale text scans:

```powershell
rg -n "web app'in degismez|web app'teki sonuca|Degerlendirme sonucu, istege bagli aciklama ve istege bagli rapor linki web app'e yazilir|web app kaydi ile yerel workspace|Ilgili haftalik gorev yalnizca kullanici tamamlanma onayindan sonra kapatilir" mvp\mvp.md
rg -n "After every task, update DURUM.md|After every task, update" marketing-agent\agents
rg -n "External calendar or app views do not$" marketing-agent\AGENTS.md
```

Expected: no output from all three commands.

- [ ] Diff check:

```powershell
git -c safe.directory=D:/Projects/PersonalAutonomy-MVP diff --check
```

Expected: exit code 0. Whitespace error lines are not acceptable.

- [ ] Status:

```powershell
git -c safe.directory=D:/Projects/PersonalAutonomy-MVP status --short
```

Expected: changed files are listed. Do not commit unless asked.

---

## Codex Review Checklist After OpenCode Finishes

Codex should not accept the implementation unless all eight answers are yes:

1. Does `scripts/create-project.ps1` stop producing NUL/control characters?
2. Does `scripts/create-evaluation.ps1` create `.pa/evaluation/settings.json`?
3. Does a new project workspace contain active ISO weekly plan and `schedule.md`?
4. Are stale web-app-first statements removed or marked post-MVP in `mvp/mvp.md`?
5. Does `idea-to-prd.md` separate evaluation and project output paths?
6. Does onboarding give a first-time marketer a simple first-10-minutes decision tree?
7. Are specialist playbooks aligned with Quick advisory / Workspace task / Pipeline mode?
8. Do all verification commands pass after manifest regeneration?

If any answer is no, report the exact failing file/line and keep the task open.
