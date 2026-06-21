---
name: investor-data-room
description: Data room, due diligence pack, traction report, KPI dashboard, pipeline report ve cohort analysis hazirla.
---

# Investor Data Room

You create investor diligence indexes, traction evidence, KPI dashboards, pipeline reports, and
cohort analyses. Default user-facing output is Turkish unless the user asks otherwise.

## Use For

- Data Room
- Due Diligence Pack
- Traction Report
- KPI Dashboard
- Pipeline Report
- Cohort Analysis

## Data Room Principle

The data room index links to canonical workspace files. It does not duplicate heavy uploads, move
raw sources, or hide gaps. Raw uploaded materials stay under `00-gelen-kutusu/yuklemeler/`.

## Evidence Block

Every durable output includes:

```markdown
## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

## Data Room Index

Write to `08-raporlar/yatirimci/data-room-index.md`:

```markdown
# Data Room Index: [Project]

## 1. Company
| Item | Path | Status | Notes |
|---|---|---|---|

## 2. Product
| Item | Path | Status | Notes |
|---|---|---|---|

## 3. Market and Customers
| Item | Path | Status | Notes |
|---|---|---|---|

## 4. Traction and Analytics
| Item | Path | Status | Notes |
|---|---|---|---|

## 5. Financials
| Item | Path | Status | Notes |
|---|---|---|---|

## 6. Legal and Ownership
| Item | Path | Status | Notes |
|---|---|---|---|

## 7. Risks and Open Checks
| Check | Owner | Impact | Next step |
|---|---|---|---|
```

## Due Diligence Pack

Write to `08-raporlar/yatirimci/due-diligence-pack.md`:

- executive diligence summary;
- source inventory;
- unresolved questions;
- claims that need proof;
- legal/accounting review list;
- investor Q&A.

## Traction Report

Write to `08-raporlar/yatirimci/traction-report.md`:

```markdown
# Traction Report
- Period:
- Stage:

## Metric Snapshot
| Metric | Current | Previous | Change | Source | Confidence |
|---|---:|---:|---:|---|---|

## Qualitative Evidence
| Evidence | Source | Investor relevance |
|---|---|---|

## Interpretation
- Strong signals:
- Weak signals:
- Missing proof:
```

## KPI Dashboard

Write to `08-raporlar/yatirimci/kpi-dashboard.md`:

- acquisition;
- activation;
- retention;
- revenue;
- referral;
- sales pipeline;
- operational metrics;
- alert thresholds.

## Pipeline Report

Write to `08-raporlar/yatirimci/pipeline-report.md`:

- target accounts or investor pipeline when relevant;
- stage counts;
- conversion rates;
- weighted value;
- next actions.

## Cohort Analysis

Write to `08-raporlar/yatirimci/cohort-analysis.md`:

- cohort definition;
- period;
- retention or revenue table;
- sample size warning;
- interpretation and next test.

## Final Approval

Working files stay in `08-raporlar/yatirimci/`. Copy to `10-final/yatirimci/` only after explicit
user approval.
