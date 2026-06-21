---
name: fundraising-financials
description: Financial model, cap table, unit economics, revenue, burn runway ve use of funds hazirla.
---

# Fundraising Financials

You create investor-process financial documents from actual data, explicit assumptions, and
marketer-approved scenarios. Default user-facing output is Turkish unless the user asks otherwise.

## Use For

- Financial Model
- Cap Table
- Unit Economics
- Revenue Report
- Burn & Runway Report
- Use of Funds

## Non-Negotiable Data Rule

Never invent financial data. If actual data is missing, create a manual input table and label the
output as `Taslak - veri bekliyor`. If assumptions are used, label them as `Tahmin` or `Senaryo`.

Every number must include:

- formula;
- input values;
- period range;
- currency;
- source path or user statement;
- actual / estimate / target / scenario label.

## Evidence Block

Every output includes:

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

## Financial Model

Write to `08-raporlar/finansal/financial-model.md`:

```markdown
# Financial Model: [Project]
- Currency:
- Period:
- Scenario: Base | Conservative | Aggressive

## Revenue Assumptions
| Driver | Formula | Input | Source | Label |
|---|---|---|---|---|

## Cost Assumptions
| Cost item | Formula | Input | Source | Label |
|---|---|---|---|---|

## Monthly Projection
| Month | Revenue | COGS | Gross Margin | Opex | EBITDA | Cash Balance |
|---|---:|---:|---:|---:|---:|---:|

## Sensitivity
| Variable | Low | Base | High | Impact |
|---|---:|---:|---:|---|
```

## Cap Table

Write to `08-raporlar/finansal/cap-table.md`:

```markdown
# Cap Table: [Project]

## Current Ownership
| Holder | Security | Shares/Units | Ownership % | Notes |
|---|---|---:|---:|---|

## Financing Scenario
| Item | Value | Assumption |
|---|---:|---|

## Post-Money Ownership
| Holder | Ownership % before | Ownership % after | Dilution |
|---|---:|---:|---:|

## Open Checks
- Option pool:
- SAFE/convertible notes:
- Grants/loans:
- Legal review:
```

## Unit Economics

Write to `08-raporlar/finansal/unit-economics.md`:

- ARPU / average order value
- Gross margin
- CAC
- LTV
- LTV/CAC
- Payback period
- Contribution margin
- Sensitivity table

## Revenue Report

Write to `08-raporlar/finansal/revenue-report.md`:

- revenue by month;
- revenue by product/segment/channel;
- recurring vs one-time;
- expansion/churn when available;
- quality warning for missing exports.

## Burn And Runway

Write to `08-raporlar/finansal/burn-runway.md`:

- cash balance;
- monthly gross burn;
- monthly net burn;
- runway formula: `cash balance / net monthly burn`;
- planned hiring and cost changes;
- fundraising timing risk.

## Use Of Funds

Write to `08-raporlar/finansal/use-of-funds.md`:

```markdown
# Use of Funds
- Raise amount:
- Runway target:
- Milestone target:

| Category | Amount | % | Purpose | Milestone |
|---|---:|---:|---|---|
```

## Final Approval

Financial drafts stay in `08-raporlar/finansal/`. Investor-facing approved financial extracts can
be copied to `10-final/yatirimci/` only after explicit user approval.
