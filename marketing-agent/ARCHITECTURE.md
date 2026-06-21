# Marketing Agent Architecture - Codex Release

## Vision

A marketer opens an evaluation or project folder as the Codex root and works with a single main
agent. The first product phase is Codex + Google Drive first: workspaces live in local or
Drive-synced folders and are created by approved PowerShell create scripts. A future web app can
record workflow state later, but it is not a first-phase runtime dependency. The main agent loads
specialist playbooks, pipelines, and skills as needed; all persistent state is kept in
PersonalAutonomy workspace files.

```text
User
  -> Codex main agent
      -> Orchestrator playbook
          -> Specialist role playbooks
          -> Pipelines
          -> Codex skills and available tools
      -> MVP workspace files
```

## Package And Workspace Separation

`.pa/agent/` is a versioned behavior-only package that is updated from the central release:

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

User data, project facts, decisions, and operational state are not written inside `.pa/agent/`.
Agent updates preserve `.pa/evaluation/` in evaluations, `.pa/project/` in projects, and all
user outputs.

## Two Workspace Types

### Idea Evaluation

Identity and criteria live in `DEGERLENDIRME.md`, technical state in `.pa/evaluation/`, the
workspace-local marketer profile in `.pa/evaluation/marketer-profile.md`, raw inputs in
`kaynaklar/`, analyses in `ciktilar/`, and the working report in `RAPOR.md`. This workspace is
pre-Project Pool and does not use project operations folders.

### Project

Identity and product facts live in `PROJE.md`, long-lived context in `01-baglam/`, decisions in
`KARARLAR.md`, the workspace-local marketer profile in `.pa/project/marketer-profile.md`, and
operations in `DURUM.md` and `.pa/project/`. All outputs from research to final go to the
numbered MVP folders.

The project file system is the central part of agent behavior. The main agent determines first the
workspace type, then the output type, then the canonical target folder for every output. Raw user
inputs are preserved in `00-gelen-kutusu/`; processed research goes to `02-arastirma/`, strategy
to `03-strateji/`, product docs to `04-urun/`, weekly plans and daily schedules to
`05-haftalik-planlar/`, execution outputs to `06-pazarlama-uygulamalari/`, launch to
`07-lansman/`, reports including investor and financial packages to `08-raporlar/`, reusable
assets to `09-varliklar/`, approved deliverables to `10-final/`, working notes to `11-notlar/`,
and archived versions to `99-arsiv/`.
User data or project outputs are not written inside `.pa/agent/`.

An LLM-wiki output memory layer sits above those canonical folders as derived Markdown navigation.
For evaluation workspaces it lives under `ciktilar/bilgi-haritasi/`; for project workspaces it
lives under `11-notlar/bilgi-haritasi/`. The layer keeps `index.md` as a content map and `log.md`
as an append-only chronology, linking source evidence, canonical outputs, decisions,
contradictions, and follow-up use. It does not duplicate raw data, replace the numbered MVP
folders, or make `.pa/agent/` a data store. It is mandatory only for durable research, decisions,
strategy, MVP/PRD/coder briefs, main campaign plans, final reports/deliveries, and superseding
outputs; routine notes, small copy edits, temporary drafts, and ordinary weekly tasks do not add
relationship metadata.

## Work Mode Model

The agent selects the lightest safe mode for each request:

- `Quick advisory` answers or reviews without creating files or changing workspace state.
- `Workspace task` produces one bounded canonical output and updates only operational facts that
  actually changed.
- `Pipeline mode` runs multi-stage, evidence-heavy, or explicitly strict work.

Existing projects may execute as `Validated`, `Assumption-led`, or `Urgent tactical`. Incomplete
validation does not block reversible low-risk drafts or time-sensitive tactical support. It does
block high-cost, irreversible, legally sensitive, identity-changing, and final-publication
decisions. Specialist roles and pipelines provide rigor when needed; they are not mandatory
ceremony for every marketer request.

## Specialist Model

14 specialist roles are maintained: onboarding, market research, strategy, product architecture,
launch, content, growth, international market expansion, outreach, analytics, brand, campaign,
schedule coordination, and investor readiness. These are not independent data repositories or mandatory separate
processes/runtimes; they are focused instruction files that Codex reads according to the task.

The onboarding role owns first-use Marketer Profile Intake. Approved create flows copy a reusable
base profile into the workspace when available; the workspace copy stores only project-specific
capacity, budget, channel, or advantage differences. City, profession, expertise,
marketing/sales experience, accessible channels, budget range, and weekly time are the normal
fields. Age and education are optional and requested with a reason only when material to a
specific decision. A saved or postponed profile prevents the full intake from being repeated.

Codex subagent work is applied only when the user explicitly requests it or when the main request
explicitly specifies parallel agent usage. In all cases, the main agent verifies and consolidates
results according to the workspace contract.

## Marketing Coverage Model

The release does not reduce marketing demand to a single channel or single customer type. For a
Workspace task or Pipeline mode where the classification affects the result, the orchestrator
classifies customer model, channel model, lifecycle stage, market scope, and sales motion. Quick
advisory does not create a formal classification record unless the answer needs one.

```text
Customer model:
  B2B | B2C | Hybrid

Channel model:
  Digital | Physical/Field | Hybrid

Lifecycle:
  idea -> validation -> MVP/offer -> pre-launch -> launch -> sales
  -> growth -> retention -> feedback -> improvement
```

When main pipelines are insufficient alone, they are combined. For example, B2B field sales starts
with `outbound-sales` but is supplemented with `local-business-launch`, `content-machine`,
`campaign-manager`, and `analytics-master` outputs when events, physical materials, or local
activation is needed. For B2C physical marketing, P9 is the main flow; digital support, growth,
and feedback loops are added as needed.

International market expansion uses `pipelines/international-market-expansion.md` and
`agents/market-expansion-advisor.md`. This role does not create a separate runtime; it coordinates
market research, strategy, outreach, product readiness, and analytics playbooks around one
beachhead-market decision. It treats global expansion as a testable sequence: current traction
evidence, transferable ICP, candidate country scorecard, localization and trust package, technical
globalization readiness, and a 90-day demand test before heavy investment.

Fundraising and investor preparation uses `pipelines/fundraising-readiness.md` and
`agents/investor-readiness-advisor.md`. This role does not create a separate runtime; it
coordinates investor narrative documents, financial models, data room readiness, diligence packs,
and legal business drafts while preserving the rule that the marketer makes fundraising decisions
and the agent produces evidence-backed working files.

## Data-Driven Opportunity Discovery Model

When a marketer asks to find an idea from scratch, the release uses `pipelines/idea-discovery.md`
as an orchestrator over source-specific opportunity pipelines:

```text
store-intelligence
complaint-mining
competitor-gap
trend-to-product
user-advantage-fit
  -> opportunity score
  -> idea brief
  -> idea-to-prd valuation gate
```

This model keeps idea generation evidence-based. App Store / Google Play MCPs are useful adapters
but not required for the core architecture. The agent first uses visible Codex capabilities:
official web search, Browser, Chrome, Playwright/browser automation for public rendered pages,
local scripts, public endpoints, and manual exports. MCP and paid providers can later replace a
data adapter without changing the pipeline contract.

Trend language is controlled. A current chart snapshot can prove that a category is currently
strong; it cannot prove a 14-day rise unless the workspace has snapshots or a source provides
historical rank data. Snapshots are therefore part of the store-intelligence data model.

Therefore, compatibility does not mean the same file set is produced in every scenario. Correct
compatibility means the research, strategy, offer, channel, material, execution, measurement, and
improvement layers are transformed into outputs appropriate for the project type.

## Skill Model

Each `skills/<name>/SKILL.md` carries `name` and `description` frontmatter in the Codex Agent
Skills standard. Skill metadata is for Codex task matching; detailed instructions are loaded only
when the skill is selected.

Global or plugin Codex skills are optional active capabilities. The package may route to them only
when they are visible in the active skill list, and must not depend on local machine skill paths.
`brainstorming` is the expected active Codex skill for collaborative exploration before a creative
or strategic direction is finalized. It works above the bundled local marketing skills: first shape
the marketer's intent and options, then run the relevant pipeline or local skill and save outputs to
the MVP workspace contract.

The canonical release copy is under `.pa/agent/skills/`. The workspace creation or release
distribution script may additionally publish the same skills to the area Codex supports for
repo-scope skill discovery. The package also works by explicitly reading canonical skill files
via the main AGENTS.md instruction without requiring this publication.

## Pipeline State

Pipeline files are ready-to-use workflows; they do not create their own state repository. The
active pipeline and step are kept in human-readable form in `DURUM.md`, and the machine-readable
required fields in the relevant state JSON and `active-task.md`.

The task-oriented weekly calendar is the main rhythm and operational memory of project work. Each
ISO week has a main plan at `05-haftalik-planlar/YYYY-WNN.md` and an optional daily schedule
folder at `05-haftalik-planlar/YYYY-WNN/` with `schedule.md` plus day files. Pipelines and skills
can advance tasks in these files. If file/output evidence proves completion, the task can be
closed and the user is informed. External-action tasks remain `Kullanici Bildirimi Bekliyor`
until the user reports completion; postponed or cancelled tasks are recorded with reasons.

## Tools And MCP

External capabilities are provided on the Codex host side. `mcps.json` defines required or
optional capabilities and manual fallback; it is not proof of installation. The main agent uses
only capabilities it sees in the active tool list.

For web research, the available official web, Browser, or Chrome tool is used. Sources, access
dates, and evidence are preserved in the output. If a tool is absent, a script or manual data flow
is selected.

The MVP plugin set for marketers is Google Drive, Google Calendar, Gmail, Canva, Figma, and
GitHub. These plugins are installed manually in Codex App by the marketer. Google Calendar is a
secondary external view of the file-system schedule, not the source of truth. GitHub is used only
for approved private backups of lightweight project files; Google Drive remains the primary file
store.

## Research And Data Processing Backbone

Research and data processing is a first-class behavior of the release. The agent does not just
produce a final interpretation; it executes source collection, evidence ledger, raw data
preservation, normalization, analysis, and decision impact as separate layers.

```text
Codex tools / MCP / script / manual export
  -> raw source and evidence note
  -> normalized JSON/CSV/Markdown working data
  -> analysis, score, estimate, and decision impact
  -> RAPOR.md or relevant MVP output folder
```

Mixing these layers is a release error. Unsourced numeric claims, assumptions about capabilities
not visible in the tool list, or summarization that deletes raw data are not considered
Codex-compliant.

## State And Approval Principles

- File production is task completion only when the artifact clearly proves the task is done.
- Final delivery requires explicit user approval. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- A project behavior preference change updates `overrides.md`, `overrides-approved.md`, SHA-256
  state, and `KARARLAR.md` together.
- Project facts are not copied into the override file.
- Operational time is `Europe/Istanbul`; weeks follow the Monday-Sunday ISO standard.

## Error Boundaries

Identity mismatch, broken workspace type, unreadable state, or invalid release stops normal work.
Missing external data/tool is noted with evidence and a safe manual fallback is offered. In no
case is missing data fabricated.
