# Marketing Agent Architecture - Codex Release

## Vision

A marketer opens an evaluation or project folder as the Codex root and works with a single main
agent. The main agent loads specialist playbooks, pipelines, and skills as needed; all persistent
state is kept in PersonalAutonomy workspace files.

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

Identity and criteria live in `DEGERLENDIRME.md`, technical state in `.pa/evaluation/`, raw inputs
in `kaynaklar/`, analyses in `ciktilar/`, and the working report in `RAPOR.md`. This workspace is
pre-Project Pool and does not use project operations folders.

### Project

Identity and product facts live in `PROJE.md`, long-lived context in `01-baglam/`, decisions in
`KARARLAR.md`, and operations in `DURUM.md` and `.pa/project/`. All outputs from research to
final go to the numbered MVP folders.

The project file system is the central part of agent behavior. The main agent determines first the
workspace type, then the output type, then the canonical target folder for every output. Raw user
inputs are preserved in `00-gelen-kutusu/`; processed research goes to `02-arastirma/`, strategy
to `03-strateji/`, product docs to `04-urun/`, weekly plans and daily schedules to
`05-haftalik-planlar/`, execution outputs to `06-pazarlama-uygulamalari/`, launch to
`07-lansman/`, reports to `08-raporlar/`, reusable assets to `09-varliklar/`, approved
deliverables to `10-final/`, working notes to `11-notlar/`, and archived versions to `99-arsiv/`.
User data or project outputs are not written inside `.pa/agent/`.

## Specialist Model

12 specialist roles are maintained: onboarding, market research, strategy, product architecture,
launch, content, growth, outreach, analytics, brand, campaign, and schedule coordination. These
are not independent data repositories or mandatory separate processes/runtimes; they are focused
instruction files that Codex reads according to the task.

Codex subagent work is applied only when the user explicitly requests it or when the main request
explicitly specifies parallel agent usage. In all cases, the main agent verifies and consolidates
results according to the workspace contract.

## Marketing Coverage Model

The release does not reduce marketing demand to a single channel or single customer type. The
orchestrator classifies the customer model, channel model, lifecycle stage, market scope, and
sales motion for every request.

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

Therefore, compatibility does not mean the same file set is produced in every scenario. Correct
compatibility means the research, strategy, offer, channel, material, execution, measurement, and
improvement layers are transformed into outputs appropriate for the project type.

## Skill Model

Each `skills/<name>/SKILL.md` carries `name` and `description` frontmatter in the Codex Agent
Skills standard. Skill metadata is for Codex task matching; detailed instructions are loaded only
when the skill is selected.

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
