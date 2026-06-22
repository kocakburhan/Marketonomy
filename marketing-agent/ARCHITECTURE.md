# Marketing Agent Architecture - Codex Release

## Vision

The first product phase is Codex + Google Drive first. A marketer opens a central `Projects`
folder for onboarding and project creation. Every real initiative is then created as
`Projects/<project-name>/`, opened as a separate Codex workspace, and handled in its own thread.
There is no separate idea workspace type. Idea discovery and idea evaluation are capabilities
inside the project workspace.

```text
Projects root
  -> onboarding-guide
  -> Codex App plugin checklist
  -> .pa/marketer-profile.md
  -> create-project.ps1
      -> Projects/<project-name>
          -> .pa/agent/
          -> PROJE.md
          -> numbered project folders
```

The web app is deferred. Google Drive remains the real file store. Codex App and the installed
Marketing Agent package are the first-phase working runtime.

## Package And Workspace Separation

`.pa/agent/` is a versioned behavior-only package:

```text
AGENTS.md
ARCHITECTURE.md
SKILLS.md
agents/
pipelines/
skills/
scripts/
templates/
mcps.json
release-manifest.json
agent-version.json
```

User data, project facts, decisions, and outputs are never written inside `.pa/agent/`. Agent
updates preserve project files, `.pa/project/`, and all numbered project folders.

## Single Workspace Type

The only real work workspace is a project workspace:

```text
Projects/x-projesi/
  AGENTS.md
  PROJE.md
  DURUM.md
  KARARLAR.md
  00-gelen-kutusu/
  01-baglam/
  02-arastirma/
    fikir-degerlendirme/
    pazar-arastirmasi/
    rakip-arastirmasi/
    musteri-arastirmasi/
    trend-arastirmasi/
    store-intelligence/
  03-strateji/
    dogrulama/
    konumlandirma/
    fiyatlandirma/
    pazara-giris/
    buyume/
  04-urun/
  05-haftalik-planlar/
  06-pazarlama-uygulamalari/
  07-lansman/
  08-raporlar/
  09-varliklar/
  10-final/
  11-notlar/
    bilgi-haritasi/
  99-arsiv/
  .pa/project/
  .pa/agent/
```

`PROJE.md` carries identity and the current project/idea summary. `.pa/project/state.json`
carries machine-readable project state. `KARARLAR.md` carries decisions. `DURUM.md` and
`.pa/project/active-task.md` carry active operational state.

## Idea Evaluation Model

Idea evaluation is not a workspace type. If the marketer wants to test a raw idea, the project
workspace starts with the idea-value gate. Evidence and outputs go to:

- `02-arastirma/fikir-degerlendirme/`
- `03-strateji/dogrulama/`
- `KARARLAR.md`
- `DURUM.md`
- `11-notlar/bilgi-haritasi/`

If the idea is rejected, the project folder is preserved and the decision is recorded. The user can
revise, pivot, archive, or start another project.

## Work Mode Model

The agent selects the lightest safe mode:

- `Quick advisory` answers or reviews without creating files or changing workspace state.
- `Workspace task` produces one bounded canonical output and updates only operational facts that
  changed.
- `Pipeline mode` runs multi-stage, evidence-heavy, or explicitly strict work.
- `Urgent tactical` creates a usable first version quickly when time matters.
- `Assumption-led` proceeds from stated assumptions when the user asks the agent to decide.

Incomplete validation does not block reversible low-risk drafts or tactical support. It does block
high-cost, irreversible, legally sensitive, identity-changing, and final-publication decisions.

## Specialist Model

Specialist files are focused instructions, not separate runtimes. The active specialist set
covers onboarding, orchestration, market research, strategy, product architecture, launch,
content, growth, international expansion, outreach, analytics, brand, campaign, schedule
coordination, and investor readiness.

The onboarding role owns the `Projects` root first-use flow and the Marketer Profile Intake.
Approved create flow copies `Projects/.pa/marketer-profile.md` into
`.pa/project/marketer-profile.md`, so each new project starts with the user's reusable context.

## LLM-Wiki Output Memory Layer

The LLM-wiki output memory layer lives only in project workspaces at
`11-notlar/bilgi-haritasi/`. It keeps `index.md`, `log.md`, and pages under `sayfalar/` as
derived navigation over source evidence, canonical outputs, decisions, contradictions, and future
reuse. It does not replace raw files or make `.pa/agent/` a data store.

## Skill Model

Each `skills/<name>/SKILL.md` carries `name` and `description` frontmatter in the Codex Agent
Skills standard. Global or plugin Codex skills are optional active capabilities and can be used
only when visible in the current Codex environment. `brainstorming` is the expected active Codex
skill for collaborative exploration before a creative or strategic direction is finalized.

## Tools And Plugins

External capabilities are host-side. `mcps.json` is a declaration and fallback guide, not proof of
installation. The marketer manually installs the MVP Codex App plugin set:

- Google Drive
- Google Calendar
- Gmail
- Canva
- Figma
- GitHub

Google Drive is the primary file store. Google Calendar is a secondary schedule view. GitHub is
for approved private backup of lightweight files only.

## Research And Data Processing Backbone

Research work separates source collection, evidence, data processing, and conclusions:

```text
Codex tools / plugin / MCP / script / manual export
  -> raw source and evidence note
  -> normalized working data
  -> analysis, score, estimate, and decision impact
  -> canonical project output
```

Every evidence-heavy output must include `Kaynak ve Kanit Defteri`. Data transformations must
include `Veri Isleme Notlari`. Unsupported numbers are marked `Tahmin` or `Veri yok`.

## State And Approval Principles

- File evidence can close file-backed tasks automatically and inform the user.
- External actions wait for user-reported completion.
- Final publication or delivery always requires explicit user approval.
- Project behavior preference changes update `overrides.md`, `overrides-approved.md`, SHA-256
  state, and `KARARLAR.md` together.
- Operational time is `Europe/Istanbul`; weeks follow Monday-Sunday ISO standard.

## Error Boundaries

Identity mismatch, unreadable state, deprecated workspace markers, or invalid release stops normal
work. Missing external data or tooling is reported with impact and a fallback. Missing data is
never fabricated.
