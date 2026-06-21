---
name: investor-documents
description: Pitch deck, one-pager, executive summary, investor update, board deck ve business plan hazirla.
---

# Investor Documents

You create investor-facing narrative documents from project context, evidence, traction, and
marketer decisions. Default user-facing output is Turkish unless the user asks for another
language.

## Use For

- Pitch Deck
- One-Pager
- Executive Summary
- Investor Update
- Board Deck
- Business Plan

## Inputs To Check

1. Product, customer, market, and business model from `PROJE.md` and `01-baglam/`.
2. Validation and positioning from `03-strateji/`.
3. Traction, KPI, revenue, cohort, and pipeline files under `08-raporlar/`.
4. Financial assumptions from `08-raporlar/finansal/`.
5. Marketer decisions in `KARARLAR.md`.
6. Target investor type, round purpose, requested amount, language, currency, and deadline.

If a required input is missing, ask only for the missing decision or create a clearly labeled
placeholder section called `Eksik Veri`.

## Evidence Rule

Do not invent market size, revenue, retention, customer count, pipeline, investor interest, or
partnerships. Each claim must be sourced, labeled as `Tahmin`, or marked `Kontrol gerekli`.

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

## Pitch Deck Structure

Write to `08-raporlar/yatirimci/pitch-deck.md`:

```markdown
# Pitch Deck: [Project]
**Tarih:** [YYYY-MM-DD]
**Hedef yatirimci:** [angel/VC/corporate/etc.]
**Tur:** [pre-seed/seed/growth/etc.]

## 1. Cover
- Company:
- One-line promise:
- Contact:

## 2. Problem
- Customer pain:
- Current alternatives:
- Why now:

## 3. Solution
- Product:
- Core workflow:
- Differentiation:

## 4. Market
- Segment:
- Market sizing:
- Source confidence:

## 5. Business Model
- Revenue model:
- Pricing:
- Gross margin assumption:

## 6. Traction
| Metric | Value | Period | Source | Confidence |
|---|---:|---|---|---|

## 7. Go-To-Market
- First reachable segment:
- Channels:
- Sales motion:

## 8. Competition
| Competitor | Alternative | Weakness | Our advantage |
|---|---|---|---|

## 9. Financial Snapshot
- Revenue:
- Burn:
- Runway:
- Key assumption:

## 10. Team
- Founder/owner strengths:
- Relevant advantage:
- Missing hire/advisor:

## 11. Ask and Use of Funds
- Raising:
- Use:
- Milestones:

## 12. Risks and Mitigations
| Risk | Impact | Mitigation |
|---|---|---|
```

## One-Pager Structure

Write to `08-raporlar/yatirimci/one-pager.md`. Keep it one to two pages:

- Company one-liner
- Problem and solution
- Target customer
- Traction snapshot
- Market and competition
- Business model
- Fundraising ask
- Contact

## Executive Summary Structure

Write to `08-raporlar/yatirimci/executive-summary.md`:

- 5-7 sentence summary
- Why this problem matters
- Why this team/project can win
- Current traction
- Next 12-month plan
- Funding need and use of funds
- Key risks

## Investor Update Structure

Write to `08-raporlar/yatirimci/investor-update.md`:

- Highlights
- Metrics
- Product progress
- Customers and pipeline
- Revenue and runway
- Asks from investors
- Risks and next month focus

## Board Deck Structure

Write to `08-raporlar/yatirimci/board-deck.md`:

- Agenda
- Company scorecard
- KPI trends
- Financials
- Product and go-to-market
- Hiring and operations
- Decisions needed
- Risks

## Business Plan Structure

Write to `08-raporlar/yatirimci/business-plan.md`:

- Company overview
- Market and customer
- Product and roadmap
- Business model
- Go-to-market
- Operations
- Financial plan
- Risk and milestones

## Final Approval

Working drafts stay in `08-raporlar/yatirimci/`. Copy to `10-final/yatirimci/` only after explicit
user approval. Preserve the working file.
