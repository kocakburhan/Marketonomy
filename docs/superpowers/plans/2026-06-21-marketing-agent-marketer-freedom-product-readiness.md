# Marketing Agent Marketer Freedom Product Readiness Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:executing-plans` or the closest available task-by-task execution workflow in your agent. Implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the Marketing Agent product-ready for real marketers by keeping marketers free to decide, while the agent guides, researches, drafts, organizes files, and supports proven marketing pipelines without becoming restrictive.

**Architecture:** Keep phase 1 as Codex App + Google Drive + approved PowerShell create/install/update scripts. The agent must not require the web app at runtime. The agent should distinguish safety boundaries from marketer choice: it blocks only identity corruption, unsafe file writes, fake evidence, irreversible publication, or final delivery without approval; it otherwise supports marketer judgment, creativity, and execution.

**Tech Stack:** Markdown behavior contracts, PowerShell validation scripts, JSON state files, SHA-256 release manifest, Codex/OpenCode agentic execution.

---

## OpenCode'a Verilecek Prompt

OpenCode'u `D:\Projects\PersonalAutonomy-MVP` repo kokunde ac ve su promptu aynen ver:

```text
You are working in D:\Projects\PersonalAutonomy-MVP.

Read and execute this implementation plan exactly:
docs/superpowers/plans/2026-06-21-marketing-agent-marketer-freedom-product-readiness.md

Context:
- This repo distributes the PersonalAutonomy Marketing Agent package.
- Phase 1 is Codex App + Google Drive + approved PowerShell create/install/update scripts.
- The web app/PWA/central role screen/central workflow record is post-MVP and must not become a phase-1 runtime requirement.
- The marketer is not a junior user to be controlled. Marketers are assumed to be capable, creative, networked, and responsible.
- The Marketing Agent should guide the marketer, make research and file work easier, expose accepted marketing pipelines, help with decisions, and create useful outputs.
- The Marketing Agent should not restrict marketer creativity, force unnecessary process, or take project decisions away from the marketer.
- The agent may be strict about evidence, file isolation, identity consistency, final delivery approval, and not fabricating data.
- The agent should otherwise use the lightest safe mode: Quick advisory, Workspace task, or Pipeline mode.
- Do not create real customer/project examples outside temporary test folders.
- Preserve existing Turkish folder/file names.
- Keep internal agent instructions in English and marketer-facing guidance in Turkish.
- Use ASCII-safe Turkish in repo docs unless the target file already clearly uses correct UTF-8 Turkish.
- Do not commit unless explicitly asked.

Important user decisions to implement:
1. Wrong-folder flow: use a marketer-friendly 3-option recovery flow.
2. idea-to-prd flow: first evaluate the idea itself; marketer advantage is later execution guidance, not the idea verdict.
3. mvp.md web app cleanup: use a two-stage approach. First remove direct phase-1 contradictions. Then move or clearly label web-app/PWA sections as Post-MVP Appendix / future design notes.

When finished, report:
1. Files changed.
2. What changed for wrong-folder recovery.
3. What changed for idea-value vs marketer-guidance separation.
4. What changed in mvp.md for web app/Post-MVP separation.
5. Tests/validation commands and exact pass/fail results.
6. Any remaining risk or manual review needed.
```

---

## Product Principle To Preserve Everywhere

The Marketing Agent exists to help marketers do better work, not to control them.

Use this principle when editing behavior contracts:

```text
Marketer ozgurlugu ve karari esastir.

Marketing Agent:
- marketer'in zekasini, yaraticiligini, network'unu ve tecrubesini ortaya cikarmaya yardim eder;
- arastirma, veri toplama, kaynak kaydi, dosya hazirlama, raporlama, kampanya, satis ve haftalik uygulama islerini kolaylastirir;
- evrensel kabul gormus marketing pipeline'lariyla yol gosterir;
- fikrin yeterliligini pazar, musteri acisi, odeme istegi, rekabet, farklilasma, zamanlama, uygulanabilirlik ve risk uzerinden degerlendirir;
- marketer avantajini verdict olarak degil, uygulama rehberligi olarak kullanir;
- marketer'a uygunluk varsa yureklendirir ve avantaji nasil kullanacagini soyler;
- marketer'a uygunluk zayifsa fikri otomatik reddetmez; daha dikkatli ilerleme, sektor tecrubesi toplama, uzman/mentor/partner destegi veya dusuk maliyetli validasyon onerir.

Marketing Agent:
- marketer'in yerine proje karari vermez;
- marketer'i gereksiz surecle kisitlamaz;
- dusuk riskli yaratici/taktik isleri gereksiz pipeline'a zorlamaz;
- final yayin/teslim veya irreversible kararlar disinda kullanicinin karar alanini daraltmaz.
```

---

## Current-State Rule

Some older issues may already be fixed in the current checkout. Do not blindly re-implement old fixes.

Before changing files:

- [ ] Run this status check:

```powershell
git status --short
```

Expected: no unrelated local edits from this task yet. If there are existing edits, do not revert them. Work with them.

- [ ] Run current validation:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
```

Expected in current healthy state:

```text
SONUC: Workspace create testleri gecti.
SONUC: Marketing Agent Codex ve PersonalAutonomy MVP uyumluluk denetiminden gecti.
SONUC: HAZIR - zorunlu release yapisi gecerli
```

If these already pass, focus on the product-readiness behavior below. If they fail, fix the specific failure first without changing the product decisions in this plan.

---

## File Map

Modify:

- `marketing-agent/AGENTS.md`
  - Add or strengthen wrong-folder 3-option recovery.
  - Add explicit marketer freedom/support principle.
  - Strengthen idea-value vs marketer-execution-guidance separation.

- `marketing-agent/agents/onboarding-guide.md`
  - Add marketer-friendly wrong-folder onboarding language.
  - Make the first 10 minutes even more outcome-focused and freedom-preserving.
  - Add "what happens if I have an idea?" explanation in plain Turkish.

- `marketing-agent/agents/orchestrator.md`
  - Reorder ready-idea guidance so the idea itself is judged first.
  - Treat marketer profile as execution guidance, not verdict.
  - Keep low-risk tactical/creative work flexible.

- `marketing-agent/pipelines/idea-to-prd.md`
  - Reorder pipeline: idea collection -> market research -> idea value decision -> marketer execution guidance -> MVP -> approval -> PRD -> coder brief.
  - Rename "User Marketing Advantage" framing to execution guidance where needed.
  - Keep evaluation workspace paths under `ciktilar/` and `RAPOR.md`; keep project paths under `02-arastirma/`, `03-strateji/`, and `04-urun/`.

- `mvp/mvp.md`
  - Remove direct phase-1 contradictions.
  - Label or move web-app/PWA/central workflow sections as Post-MVP future design notes.
  - Keep phase-1 contract clear: Codex + Google Drive + approved scripts.
  - Keep completion rule consistent.

- `marketing-agent/QUICKSTART.md`
  - Add brief marketer-facing wrong-folder guidance if not already present.
  - Keep it short.

- `marketing-agent/scripts/healthcheck.ps1`
  - Add string/contract checks for the new behavior so future regressions are caught.

- `marketing-agent/scripts/test_mvp_compatibility.ps1`
  - Add compatibility checks if healthcheck is not enough.

- `marketing-agent/agent-version.json`
  - Bump patch version only if this repo convention expects version changes for behavior-contract edits.

- `marketing-agent/release-manifest.json`
  - Regenerate after tracked agent package changes.

Do not modify unless tests show a real need:

- `scripts/create-project.ps1`
- `scripts/create-evaluation.ps1`
- `scripts/install-marketing-agent.ps1`
- `marketing-agent/scripts/update-agent.ps1`
- `marketing-agent/scripts/check-update.ps1`

---

### Task 1: Add Regression Checks First

**Files:**
- Modify: `marketing-agent/scripts/healthcheck.ps1`
- Modify if needed: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [ ] Open `marketing-agent/scripts/healthcheck.ps1` and find the existing behavior-contract check section.

- [ ] Add checks for these exact concepts. Use the existing local helper style in the file. If the script has a helper like `Assert-FileContains`, use that. If it uses a different helper name, follow the existing pattern.

Required contract phrases to check:

```text
3-option wrong-folder recovery:
- "Yeni fikir degerlendirme workspace'i"
- "Yeni proje workspace'i"
- "Var olan evaluation/project workspace"

Marketer freedom/support:
- "Marketer ozgurlugu"
- "marketer'in yerine proje karari vermez"
- "gereksiz surecle kisitlamaz"

Idea-first decision:
- "Aslolan fikirdir"
- "Marketer uygulama rehberligi"
- "verdict degildir"

Post-MVP web app boundary:
- "Post-MVP"
- "web app/PWA bolumleri ilk product fazi icin runtime gereksinimi degildir"
```

- [ ] If `marketing-agent/scripts/test_mvp_compatibility.ps1` already checks semantic MVP contract strings, add the same checks there too. If it only checks structure, leave it alone and keep the new assertions in healthcheck.

- [ ] Run the healthcheck and confirm it fails before behavior-doc edits:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
```

Expected before implementation: FAIL for at least some of the new strings.

If it unexpectedly passes, continue; the docs may already contain equivalent strings. Still inspect and improve the behavior docs for clarity.

---

### Task 2: Implement Wrong-Folder 3-Option Recovery

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/QUICKSTART.md`

**Behavior to implement:**

When the agent is opened in a folder that is not a valid evaluation or project workspace, it should not continue normal workspace work. But it should help the marketer recover without making them feel blocked.

Valid workspace roots:

- Evaluation workspace: has `DEGERLENDIRME.md` and `.pa/evaluation/state.json`
- Project workspace: has `PROJE.md` and `.pa/project/state.json`

Invalid or wrong roots:

- repo root
- marketer parent folder
- `idea-workspace/` parent folder
- `projects/` parent folder
- empty folder
- half-created/broken workspace

- [ ] In `marketing-agent/AGENTS.md`, find `## Determine The Workspace Type`.

- [ ] Replace the current invalid-workspace guidance with a marketer-friendly 3-option recovery rule. Keep the safety boundary. The text should include this meaning:

```markdown
If both workspace markers exist, neither marker exists, or required state cannot be read, stop normal workspace work. Do not scan sibling folders and do not create files by guessing.

Give the marketer a non-technical recovery answer with these three options:

1. Yeni fikir degerlendirme workspace'i: If they want to evaluate a new idea, they should run the approved `scripts/create-evaluation.ps1` flow from the correct marketer `idea-workspace/` parent, then open the created evaluation folder as Codex root.
2. Yeni proje workspace'i: If a validated idea is ready to become a project, they should run the approved `scripts/create-project.ps1` flow from the correct marketer `projects/` parent, then open the created project folder as Codex root.
3. Var olan evaluation/project workspace: If they already have a workspace, they should reopen Codex directly in the folder containing `DEGERLENDIRME.md` or `PROJE.md`.

If the folder looks corrupted, explain that identity/state repair must not be guessed and refer to administrator Burhan Kocak with the visible error.
```

- [ ] In `marketing-agent/agents/onboarding-guide.md`, add a section named:

```markdown
## Yanlis Klasorde Acilma Durumu
```

Use this user-facing Turkish text as the default answer template. Keep it short and practical:

```markdown
Bu klasor gecerli bir PersonalAutonomy calisma alani gibi gorunmuyor. Normal proje/fikir isine burada devam etmem dogru olmaz; yanlis yere dosya yazmak istemem.

Devam etmek icin 3 yol var:

1. Yeni fikir degerlendirme workspace'i olusturmak istiyorsan, onayli `create-evaluation.ps1` akisi kullanilmali. Sonra olusan klasor Codex root olarak acilir.
2. Onaylanmis bir fikirden yeni proje workspace'i olusturmak istiyorsan, onayli `create-project.ps1` akisi kullanilmali. Sonra olusan proje klasoru Codex root olarak acilir.
3. Var olan bir evaluation/project workspace uzerinde calisacaksan, Codex'i dogrudan `DEGERLENDIRME.md` veya `PROJE.md` bulunan klasorde acmalisin.

Ben burada sibling klasorleri tarayarak veya tahminle dosya olusturarak ilerlemem. Dogru klasoru acinca kaldigin yerden yardim ederim.
```

- [ ] In `marketing-agent/QUICKSTART.md`, add a short note under the section that explains how to open workspaces:

```markdown
Yanlis klasorde acarsan: Agent normal ise devam etmez. Yeni fikir degerlendirme, yeni proje veya var olan workspace'i dogrudan acma seceneklerini gosterir. Dogru workspace kokunde `DEGERLENDIRME.md` veya `PROJE.md` bulunur.
```

- [ ] Do not make the agent automatically scan or modify parent/sibling folders.

---

### Task 3: Add Marketer Freedom Principle To Runtime Contract

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/agents/orchestrator.md`

- [ ] In `marketing-agent/AGENTS.md`, add a new section after the core safety/workspace sections, before detailed orchestration:

```markdown
## Marketer Freedom And Support Principle

Marketer ozgurlugu ve karari esastir. Marketing Agent marketer'i kisitlamak icin degil, marketer'in zekasini, yaraticiligini, network'unu ve tecrubesini daha verimli kullanmasina yardim etmek icin calisir.

The agent should guide, research, draft, structure files, compare options, expose accepted marketing pipelines, and make execution easier. It should not take project decisions away from the marketer.

Use the lightest safe mode:

- Quick advisory for questions, discussion, idea shaping, quick judgment, and low-risk advice.
- Workspace task for one concrete output or bounded file work.
- Pipeline mode for evidence-heavy, multi-step, high-cost, irreversible, or explicitly comprehensive work.

Do not force a full pipeline when the marketer asks for a reversible draft, creative exploration, quick comparison, campaign idea, tactical asset, or discussion. Do require evidence and approval for claims, final delivery, publication, identity changes, project-state changes, irreversible commitments, legal/financial sensitivity, or high-cost execution.
```

- [ ] In `marketing-agent/agents/onboarding-guide.md`, add this idea to first-use orientation:

```markdown
Bu sistem seni kisitlamak icin degil, iyi marketer gibi daha hizli arastirma yapman, daha iyi dosya hazirlaman, daha net karar vermen ve fikirlerini daha guclu test etmen icin var. Son kararlar cogunlukla sende kalir; agent kanit, secenek, risk ve uygulanabilir yol cikarir.
```

- [ ] In `marketing-agent/agents/orchestrator.md`, add the same operating idea near `## Execution Posture`:

```markdown
The marketer is the decision owner. The agent supports judgment with evidence, options, drafts, and pipeline discipline. It should challenge weak evidence honestly, but it should not become a gatekeeper for low-risk marketer creativity or reversible tactical work.
```

---

### Task 4: Reorder idea-to-prd Around Idea Value First

**Files:**
- Modify: `marketing-agent/pipelines/idea-to-prd.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/AGENTS.md`
- Optional: `marketing-agent/agents/onboarding-guide.md`

**Required behavior:**

Aslolan fikirdir. Marketerlar zaten yetenekli ve akli basinda insanlardir. The agent should evaluate the idea first, then use marketer fit as execution guidance.

Wrong behavior:

```text
This marketer lacks sector network, therefore the idea is not worth trying.
```

Correct behavior:

```text
The idea is strong/weak based on market evidence. Separately, here is how this marketer should approach it given their network, sector knowledge, time, budget, and channels.
```

- [ ] In `marketing-agent/pipelines/idea-to-prd.md`, change the flow diagram so it follows this order:

```text
User: "I have an idea"
        |
        v
[5.1] Orchestrator -> Collect the idea and product type
        |
        v
[5.2] Market Scout -> Research market, competitors, alternatives, buyer pain, willingness to pay, timing, feasibility, and risk
        |  Output: pazar-arastirmasi.md
        v
[5.3] Strategy Analyst -> Decide idea value
        |  Output: fikir-dogrulama.md
        v
[5.4] Orchestrator -> Realist decision discussion: WORTH / REVISION / NOT WORTH
        |
        +-- "Denenmeye Degmez" -> Close the report, explain why, optionally suggest a narrower/revised idea, do not produce PRD
        |
        +-- "Revizyonla Denenmeye Deger" -> Revise the idea with the user -> Return to [5.2]
        |
        +-- "Denenmeye Deger" ->
                 v
            [5.5] Orchestrator -> Marketer execution guidance
                 |  Output: marketer-uygulama-rehberligi.md
                 v
            [5.6] Product Architect -> Write MVP from the approved final idea
                 |  Output: 04-urun/fikir-ozetleri/mvp.md
                 v
            [5.7] Orchestrator -> Get MVP scope approved by user
                 v
            [5.8] Product Architect -> Write PRD based on approved MVP
                 |  Output: 04-urun/prd/prd.md
                 v
            [5.9] Product Architect -> Prepare coder brief
                 |  Output: 04-urun/coder-briefleri/coder-brief.md
```

- [ ] Replace the section currently named like `User Marketing Advantage` with:

```markdown
### Marketer Execution Guidance
```

It must say:

```markdown
This section is not the idea-value verdict. It guides how this marketer should approach execution after the idea-value decision is made or while a low-cost validation test is being designed.

If the marketer has strong fit, encourage them to use that advantage directly: network, city, sector access, existing customer access, audience, sales skill, budget, speed, or channel leverage.

If the marketer has weak fit, do not reject the idea for that reason alone. Recommend a cautious execution path: sector conversations, mentor or partner support, expert interviews, customer discovery, local validation, small budget test, or narrowing to a reachable segment.
```

- [ ] Update all output path tables:

Evaluation workspace paths:

```markdown
| Output | Path |
|---|---|
| Market and competitor research | `ciktilar/pazar-arastirmasi.md` |
| Idea value decision | `ciktilar/fikir-dogrulama.md` |
| Marketer execution guidance | `ciktilar/marketer-uygulama-rehberligi.md` |
| Publishable working decision report | `RAPOR.md` |
| Operational status | `DURUM.md` and `.pa/evaluation/active-task.md` |
```

Project workspace paths:

```markdown
| Output | Path |
|---|---|
| Market and competitor research | `02-arastirma/pazar-arastirmasi.md` |
| Idea value decision | `03-strateji/dogrulama/fikir-dogrulama.md` |
| Marketer execution guidance | `03-strateji/dogrulama/marketer-uygulama-rehberligi.md` |
| MVP | `04-urun/fikir-ozetleri/mvp.md` |
| PRD | `04-urun/prd/prd.md` |
| Coder brief | `04-urun/coder-briefleri/coder-brief.md` |
| Operational status | `DURUM.md` and `.pa/project/active-task.md` |
```

- [ ] Add an explicit "Aslolan fikirdir" section near the top:

```markdown
## Idea Value Comes First

Aslolan fikirdir. Marketerlar yetenekli, akli basinda ve network sahibi insanlar olarak kabul edilir. Bu pipeline'in ilk gorevi marketer'i elemek degil, fikrin pazar acisindan yeterli olup olmadigini anlamaktir.

Idea value is decided from market pain, buyer urgency, willingness to pay, alternative behavior, competitor reality, differentiation, timing, feasibility, and risk.

Marketer fit is Marketer uygulama rehberligi. It can change the recommended validation route, confidence cautions, mentor/partner needs, first customer path, channel choice, and budget posture. It is verdict degildir and must not by itself turn a valuable idea into `Denenmeye Degmez`.
```

- [ ] In `marketing-agent/agents/orchestrator.md`, update ready-idea flow so profile/distribution info is not presented as a precondition for the idea verdict. Use this behavior:

```markdown
In the ready-idea flow, first understand the idea and decide whether market evidence supports it. Read the saved marketer profile when useful, but treat marketer fit as execution guidance, not as the idea-value verdict. If profile facts are missing, ask only what is needed to plan execution or low-cost validation after the idea-value question is clear.
```

- [ ] In `marketing-agent/AGENTS.md`, strengthen the Idea Evaluation Standard with this meaning:

```markdown
Aslolan fikirdir. Marketer profile or distribution fit must never be used as the sole reason to reject an otherwise valuable idea. If marketer fit is strong, encourage the marketer and explain how to use the advantage. If marketer fit is weak, recommend caution, sector experience gathering, expert/mentor/partner support, or low-cost validation.
```

- [ ] In `marketing-agent/agents/onboarding-guide.md`, update examples so first-use marketers learn the right mental model:

```markdown
"Fikrim var" dediginde once fikrin pazar acisindan denenmeye deger olup olmadigini ayiririz. Sonra senin network, zaman, butce, sektor bilgisi ve kanallarina gore nasil test edecegini planlariz. Senin uygunlugun fikri tek basina reddetmez; sadece uygulama yolunu degistirir.
```

---

### Task 5: Clean mvp.md Web App Drift In Two Stages

**Files:**
- Modify: `mvp/mvp.md`

**Stage 1: remove direct contradictions**

- [ ] Search for web-app statements that sound required in phase 1:

```powershell
rg -n "web app|PWA|Web Push|Project Pool|script basarisini onay|web app'te|workflow" mvp\mvp.md
```

- [ ] Preserve the top-level phase-1 rule:

```markdown
First product phase = Codex App + Google Drive for desktop + approved PowerShell create/install/update scripts.
Web app, PWA, Web Push, central role/membership UI, and web-based workflow recording are Post-MVP/future design notes and are not runtime requirements for phase 1.
```

- [ ] Fix any sentence that directly requires web app for current phase. Examples:

Bad:

```markdown
Marketer web app'ten idea_id degerini alir.
```

Good:

```markdown
Ilk product fazinda `idea_id`, onayli create akisi tarafindan uretilir veya script'e parametre olarak verilir. Web app kaynakli merkezi fikir havuzu Post-MVP tasarim notudur.
```

Bad:

```markdown
Kullanici web app'te script basarisini onaylar.
```

Good:

```markdown
Ilk product fazinda script basarisi terminal ciktilari, workspace dosyalari ve gerekirse kullanici bildirimiyle dogrulanir. Web app onayi Post-MVP tasarim notudur.
```

- [ ] Fix completion rule drift. The canonical rule must be:

```markdown
Workspace artifact'i gorevi acikca kanitliyorsa agent gorevi kapatir ve kullaniciyi bilgilendirir. Harici aksiyonlar kullanici tamamladigini bildirene kadar acik kalir. Final yayin veya teslim her zaman acik kullanici onayi ister.
```

Replace any line meaning "all tasks close only by explicit user approval" unless it clearly refers to external actions or final delivery.

**Stage 2: Post-MVP Appendix boundary**

- [ ] If the file has a large web-app/PWA/product-ui section, move it under a clear heading near the end:

```markdown
## Post-MVP Appendix: Web App / PWA Future Design Notes

Bu bolum ilk product fazi icin uygulanacak runtime sozlesmesi degildir. Codex App + Google Drive + approved create/install/update scriptleriyle calisan ilk fazda agent, create scriptleri ve marketer onboarding bu bolumu zorunlu gereksinim olarak kullanmaz.

Bu bolum ileriki web app/PWA/central workflow/role/member notification tasarimi icin saklanir.
```

- [ ] If moving the full section is too risky in one pass, keep the section in place but add this warning at the start of every major web-app subsection:

```markdown
> Post-MVP note: This subsection is future web app/PWA design. It is not a first-product-phase runtime requirement.
```

- [ ] Prefer moving to appendix if practical. If not practical, label aggressively and report why moving was not done.

---

### Task 6: Keep Marketer-Facing Onboarding Short But Powerful

**Files:**
- Modify: `marketing-agent/agents/onboarding-guide.md`

- [ ] Ensure first-use flow stays short:

```markdown
1. Confirm workspace type in user language.
2. If profile is missing, ask compact profile form once.
3. Say exactly: "Kocak sadakatini takdir ediyor."
4. Give outcome-based capability menu, not internal agent names.
5. Ask: "Simdi ne yapmak istiyorsun?"
```

- [ ] Make the outcome menu preserve marketer freedom:

```markdown
Simdi ne yapmak istiyorsun?

1. Fikrim var: Once fikrin kendisini kanitlarla degerlendirelim; sonra sana uygun uygulama yolunu cikaralim.
2. Fikrim yok: Veri, sikayet, trend ve rakip bosluklarindan firsat arayalim.
3. Mevcut proje: Eksikleri, pazarlama kararlarini, haftalik plani ve ilk uygulanacak isleri netlestirelim.
4. Acil taktik is: Brosur, e-posta, sosyal medya, teklif, sunum veya saha materyali gibi tek bir ciktiyi hemen uretelim.
5. Satis/pazarlama sistemi: ICP, kanal, kampanya, icerik, outbound, launch, metrik ve takip sistemini birlikte kuralim.
6. Sadece fikir/tartisma: Dosya yazmadan secenekleri, riskleri ve yaklasimi konusalim.
```

- [ ] Do not show the full specialist/skill map unless the user asks "neler yapabiliyorsun?" or it materially helps the chosen work.

---

### Task 7: Extend Tests And Healthcheck Until They Catch The Decisions

**Files:**
- Modify: `marketing-agent/scripts/healthcheck.ps1`
- Modify if needed: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [ ] Make healthcheck pass only if these behavior contracts are present:

```text
AGENTS.md contains:
- Marketer Freedom And Support Principle
- Marketer ozgurlugu
- Aslolan fikirdir
- Marketer uygulama rehberligi
- verdict degildir
- Yeni fikir degerlendirme workspace'i
- Yeni proje workspace'i
- Var olan evaluation/project workspace

agents/onboarding-guide.md contains:
- Yanlis Klasorde Acilma Durumu
- Sadece fikir/tartisma
- fikrin kendisini kanitlarla degerlendirelim

agents/orchestrator.md contains:
- marketer is the decision owner
- execution guidance
- not as the idea-value verdict

pipelines/idea-to-prd.md contains:
- Idea Value Comes First
- Aslolan fikirdir
- Marketer Execution Guidance
- `ciktilar/marketer-uygulama-rehberligi.md`
- `03-strateji/dogrulama/marketer-uygulama-rehberligi.md`

mvp/mvp.md contains:
- Post-MVP Appendix
- web app/PWA
- ilk product fazi icin runtime gereksinimi degildir
- Workspace artifact'i gorevi acikca kanitliyorsa
```

- [ ] Also add negative checks if the script style supports them:

```text
idea-to-prd.md must not say marketer fit is the idea verdict.
mvp.md must not say all weekly/project tasks close only with user completion approval.
```

If negative regex checks are hard in the current script style, skip them and report that manual review is still needed.

- [ ] Run healthcheck:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
```

Expected after implementation: PASS.

---

### Task 8: Regenerate Release Manifest

**Files:**
- Modify: `marketing-agent/release-manifest.json`
- Modify if version policy requires: `marketing-agent/agent-version.json`

- [ ] If `agent-version.json` uses semantic versions and behavior-contract edits require a release bump, bump the patch version. Example: `5.4.0` -> `5.4.1`. Do not invent a major/minor bump unless repo convention already requires it.

- [ ] Regenerate the release manifest:

```powershell
$agentRoot = (Resolve-Path -LiteralPath marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Expected: manifest regenerated without errors.

---

### Task 9: Full Validation

Run all required repo gates:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected:

```text
Marketing Agent compatibility: pass
Healthcheck: HAZIR / pass
Install/update test: pass
Workspace create test: pass
```

If a command fails:

- Fix the smallest cause.
- Re-run the failed command.
- Then re-run the full validation list.

---

## Manual Review Checklist Before Reporting Done

- [ ] Wrong-folder flow helps the marketer recover without scanning sibling folders or creating guessed files.
- [ ] Onboarding feels like a product assistant, not a system manual.
- [ ] The agent supports marketer freedom and creativity.
- [ ] Quick advisory stays lightweight.
- [ ] Workspace task stays bounded.
- [ ] Pipeline mode is reserved for rigorous/multi-step/high-risk work.
- [ ] Idea value is evaluated before marketer fit affects execution planning.
- [ ] Strong marketer fit encourages better execution, but does not rescue a weak idea by itself.
- [ ] Weak marketer fit creates caution/mentor/partner/validation guidance, but does not reject a strong idea by itself.
- [ ] Evaluation workspace outputs stay under `ciktilar/` and `RAPOR.md`.
- [ ] Project workspace outputs stay under the project folder contract.
- [ ] mvp.md no longer reads as if web app is required for phase 1.
- [ ] Completion rule is consistent everywhere.
- [ ] Release manifest was regenerated after tracked agent files changed.

---

## Final Report Format For OpenCode

When done, reply in Turkish with this structure:

```text
Tamamlandi.

Degisen dosyalar:
- ...

Karar 1 - Yanlis klasor akisi:
- Ne degisti:
- Dosya referanslari:

Karar 2 - Aslolan fikirdir:
- Ne degisti:
- Marketer uygulama rehberligi nasil ayrildi:
- Dosya referanslari:

Karar 3 - Web app Post-MVP ayrimi:
- Ne degisti:
- Hangi kisimlar temizlendi veya appendix olarak ayrildi:
- Dosya referanslari:

Validation:
- <komut>: PASS/FAIL
- <komut>: PASS/FAIL

Kalan risk:
- Yoksa "Bilinen kalan risk yok."
- Varsa acik yaz.
```

