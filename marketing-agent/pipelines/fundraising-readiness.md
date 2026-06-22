# Pipeline: Fundraising Readiness and Investor Documents

**Position in chain:** Investor preparation pipeline for project workspaces that need fundraising,
board, diligence, or investor communication documents.

**When it runs:** When the user asks for Pitch Deck, One-Pager, Executive Summary, Financial
Model, Cap Table, Traction Report, KPI Dashboard, Unit Economics, Revenue Report, Burn & Runway
Report, Use of Funds, Data Room, Due Diligence Pack, Term Sheet, Shareholders' Agreement / SHA,
Investor Update, Board Deck, Business Plan, Pipeline Report, or Cohort Analysis.

**Purpose:** Turn existing project context, market evidence, traction, financials, and marketer
decisions into consistent investor-ready working documents, then copy only user-approved final
versions into `10-final/yatirimci/`.

**Prerequisite:** Project workspace for all fundraising documents. In early idea-evaluation mode,
produce only readiness notes, risk lists, and preliminary assessment under `02-arastirma/fikir-degerlendirme/` and
`03-strateji/dogrulama/fikir-dogrulama.md`.

---

## Core Principle

Fundraising materials must be consistent, evidence-backed, and decision-oriented. The agent may
draft and assemble documents automatically, but it must not invent traction, financials, legal
terms, investor commitments, valuation, or market size. Missing data is a visible diligence risk.

---

## Pipeline Flow

```text
User: "Yatirimci dokumanlarini hazirla / pitch deck yap / data room olustur"
        |
        v
[F1] Orchestrator -> Workspace, fundraising goal, investor audience, stage
        | Output: DURUM.md and .pa/project/active-task.md
        v
[F2] Investor Readiness Advisor -> Source inventory and missing-data map
        | Output: 08-raporlar/yatirimci/fundraising-readiness-checklist.md
        v
[F3] Analytics Master + investor-data-room -> Traction, KPI, pipeline, cohort evidence
        | Output: 08-raporlar/yatirimci/
        v
[F4] fundraising-financials -> Financial model, cap table, unit economics, burn/runway, use of funds
        | Output: 08-raporlar/finansal/
        v
[F5] investor-documents -> Pitch deck, one-pager, executive summary, investor update, board deck, business plan
        | Output: 08-raporlar/yatirimci/
        v
[F6] investor-data-room -> Data room and due diligence pack index
        | Output: 08-raporlar/yatirimci/data-room-index.md
        v
[F7] investment-legal-drafts -> Term sheet / SHA business drafts if requested
        | Output: 08-raporlar/yatirimci/legal/
        v
[F8] Investor Readiness Advisor -> Consistency review and final approval gate
        | Output: 08-raporlar/yatirimci/investor-pack-review.md
        v
[F9] Orchestrator -> Copy approved versions to 10-final/yatirimci/ and update weekly plan
```

---

## Step Details

### F1 - Fundraising Goal and Audience

**Agent:** Orchestrator

Gather:

1. Purpose: investor search, first meeting, diligence, board update, strategic partnership,
   internal planning, or legal term review.
2. Audience: angel, VC, accelerator, corporate investor, lender, grant, board, or partner.
3. Stage and round: idea, MVP, pre-revenue, revenue, seed, pre-seed, growth, bridge, or unknown.
4. Language and currency.
5. Requested documents and final deadline.

If the user asks for all documents, start with the readiness checklist before drafting everything.

### F2 - Source Inventory and Missing-Data Map

**Agent:** Investor Readiness Advisor

**Output (`08-raporlar/yatirimci/fundraising-readiness-checklist.md`):**

```markdown
# Fundraising Readiness Checklist

## Requested Documents
| Document | Status | Missing input | Decision owner |
|---|---|---|---|

## Source Inventory
| Source | Path or URL | Used for | Quality |
|---|---|---|---|

## Missing Data
| Missing item | Impact | Minimum fallback |
|---|---|---|

## Decision Gates
- Story angle:
- Target investor:
- Ask / round size:
- Valuation or terms:
- Final approval:
```

### F3 - Traction, KPI, Pipeline, and Cohort Evidence

**Agent:** Analytics Master + `investor-data-room`

Use existing exports or user-provided data. If no data exists, create a manual data request table
instead of fabricating metrics.

Outputs:

- `08-raporlar/yatirimci/traction-report.md`
- `08-raporlar/yatirimci/kpi-dashboard.md`
- `08-raporlar/yatirimci/pipeline-report.md`
- `08-raporlar/yatirimci/cohort-analysis.md`

### F4 - Financial Package

**Skill:** `fundraising-financials`

Outputs:

- `08-raporlar/finansal/financial-model.md`
- `08-raporlar/finansal/cap-table.md`
- `08-raporlar/finansal/unit-economics.md`
- `08-raporlar/finansal/revenue-report.md`
- `08-raporlar/finansal/burn-runway.md`
- `08-raporlar/finansal/use-of-funds.md`

### F5 - Investor Narrative Documents

**Skill:** `investor-documents`

Outputs:

- `08-raporlar/yatirimci/pitch-deck.md`
- `08-raporlar/yatirimci/one-pager.md`
- `08-raporlar/yatirimci/executive-summary.md`
- `08-raporlar/yatirimci/investor-update.md`
- `08-raporlar/yatirimci/board-deck.md`
- `08-raporlar/yatirimci/business-plan.md`

### F6 - Data Room and Due Diligence Pack

**Skill:** `investor-data-room`

Outputs:

- `08-raporlar/yatirimci/data-room-index.md`
- `08-raporlar/yatirimci/due-diligence-pack.md`

The data room index links to files already in the workspace. It must not duplicate heavy uploads
or move raw files away from `00-gelen-kutusu/yuklemeler/`.

### F7 - Legal Business Drafts

**Skill:** `investment-legal-drafts`

Outputs:

- `08-raporlar/yatirimci/legal/term-sheet-business-draft.md`
- `08-raporlar/yatirimci/legal/sha-business-draft.md`

Add a visible legal-review warning. Do not present these documents as lawyer-approved.

### F8 - Consistency Review

**Agent:** Investor Readiness Advisor

**Output (`08-raporlar/yatirimci/investor-pack-review.md`):**

```markdown
# Investor Pack Review

## Consistency Checks
| Check | Result | Issue | Fix |
|---|---|---|---|

## Claim Audit
| Claim | Source | Status |
|---|---|---|

## Finalization Gate
- Approved by:
- Approval date:
- Files copied to final:
```

### F9 - Weekly Plan and Final Copy

**Agent:** Orchestrator

If investor-document work is tied to the active week, update the weekly plan and close only
file-proven tasks from evidence. Copy files into `10-final/yatirimci/` only after explicit user
approval. Preserve working copies.

---

## Decision Points

| Step | Decision |
|---|---|
| F1 | Which investor audience and round purpose? |
| F2 | Which missing data can be filled now, estimated, or labeled as missing? |
| F4 | Which financial assumptions are approved? |
| F5 | Which narrative angle is approved? |
| F7 | Which legal terms are only business preferences and need counsel review? |
| F9 | Which files are final investor-facing copies? |

---

## PersonalAutonomy Execution Rules

- Main project output areas: `08-raporlar/yatirimci/`, `08-raporlar/finansal/`, and approved
  final copies under `10-final/yatirimci/`.
- In project idea-evaluation mode, write preliminary readiness assessment under `02-arastirma/fikir-degerlendirme/` and do not
  create project-only folders.
- Raw uploaded sources remain under `00-gelen-kutusu/yuklemeler/`; normalized tables and analysis
  are separate working files.
- Every research, traction, financial, data room, or legal draft output includes `Kaynak ve Kanit Defteri`
  and `Veri Isleme Notlari`.
- Financial metrics include formula, inputs, period, currency, and actual/estimate/scenario label.
- Legal drafts are not legal advice and require lawyer review before external use.
- The agent updates `DURUM.md`, `.pa/*/active-task.md`, weekly plan files when applicable, and the
  active `bilgi-haritasi`.
- Approved final copies go to `10-final/yatirimci/` only after explicit user approval.
