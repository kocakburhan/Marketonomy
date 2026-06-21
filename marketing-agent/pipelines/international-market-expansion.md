# International Market Expansion Pipeline

Use this pipeline when a project has traction in one country and the marketer wants to test a
different country or regional market. The goal is not to "go global" broadly; the goal is to pick
one beachhead market, test demand cheaply, and decide whether to scale, revise, or stop.

Internal operating instructions are in English. The default user-facing language is Turkish.

## PersonalAutonomy Execution Rules

1. Determine workspace type before starting.
2. In evaluation workspace, write working analysis under `ciktilar/` and synthesize the decision
   in `RAPOR.md`.
3. In project workspace, write research to `02-arastirma/pazar-arastirmasi/`, strategy to
   `03-strateji/pazara-giris/`, growth strategy to `03-strateji/buyume/`, outreach plans to
   `06-pazarlama-uygulamalari/saha/`, partner/channel coordination to
   `06-pazarlama-uygulamalari/hibrit/`, and reports to `08-raporlar/pazarlama/`.
4. Preserve raw user inputs and source exports. Do not overwrite or summarize away raw evidence.
5. Update `DURUM.md`, the relevant `.pa/*/active-task.md`, and the active `bilgi-haritasi`
   index/log for durable outputs.
6. Do not publish decisions, contact prospects, submit forms, create calendar/email items, or
   copy files to `10-final/` without explicit user approval.

## Trigger Phrases

Route here for requests such as:

- "Turkiye'de calisan urunu ABD'ye acmak istiyorum"
- "Bu urunu hangi ulkede denemeliyiz?"
- "Global pazara nasil aciliriz?"
- "Beachhead market sec"
- "UK mi Hollanda mi BAE mi?"
- "Baska ulkeye lokalize edelim"
- "Uluslararasi GTM plani"
- "Yurt disi talep testi"
- "Global B2B SaaS satis plani"
- "Data residency, GDPR, PIPL, latency, i18n hazir mi?"

## Pipeline Overview

```text
current traction evidence
  -> transferable ICP
  -> candidate country shortlist
  -> source-backed market research
  -> beachhead scorecard
  -> localization and trust package
  -> technical globalization readiness
  -> 90-day demand test
  -> go / revise / stop decision
```

## Step 1: Current Traction And Transferable Use-Case

Read:

- `PROJE.md`
- `01-baglam/urun-baglami.md`
- `01-baglam/hedef-kitle.md`
- `01-baglam/rakipler.md`
- `KARARLAR.md`
- current sales, customer, research, or analytics files if available

Extract:

- Current country and market.
- Product category and customer model: B2B, B2C, or hybrid.
- Channel model: digital, physical-field, or hybrid.
- Current ICP, buyer, user, decision maker, and budget owner.
- The use-case that works now.
- Evidence of traction: revenue, retention, paid pilots, LOI, active users, pipeline, case study,
  testimonial, discovery calls, demos, or user feedback.
- Weak proof and missing facts.

If there is no real traction evidence, do not frame the work as international expansion. Route to
`pipelines/idea-to-prd.md`, `pipelines/mvp-launch.md`, or validation work first.

## Step 2: Candidate Market Shortlist

Select 3-5 candidate countries or regional markets. Use user-suggested markets first; if the user
has none, propose candidates based on:

- language and sales access,
- sector demand,
- cultural or time-zone proximity,
- buyer budget,
- competition intensity,
- regulatory friction,
- support and technical readiness,
- partner/channel availability.

Do not compare "Europe" as one market unless the output explicitly splits it into country-level
recommendations.

## Step 3: Research Gate

Apply Codex research and data processing standards. Use active tools only:

1. Official web search for current market, regulation, competitor, pricing, and channel evidence.
2. Browser for dynamic public pages, competitor pages, directories, or visible UI inspection.
3. Chrome only when the user-managed session or authenticated view is explicitly needed and
   approved.
4. MCP tools only if they appear in the active tool list.
5. Local scripts or manual user export when active tools cannot collect reliable data.

Every research output must include:

```markdown
## Kaynak ve Kanit Defteri
| ID | Tool | Source | Access date | Data used | Confidence |
|----|------|--------|-------------|-----------|------------|

## Veri Isleme Notlari
- Raw data:
- Normalized fields:
- Tools or scripts:
- Assumptions:
- Missing or inaccessible data:
```

If a numeric claim is not sourced, label it `Tahmin`. If no source exists, write `Veri yok`.

## Step 4: Country-Level Evidence Collection

For each candidate market, collect or request evidence for:

1. Problem severity and urgency.
2. Buyer willingness to pay and budget owner.
3. Comparable competitors, substitutes, and incumbent tools.
4. Pricing range or procurement pattern.
5. Sales cycle and channel norms.
6. Reachable decision maker pool.
7. Trust requirements: case study, security, local language, partner, references.
8. Regulation and data constraints: GDPR, PIPL, KVKK, sector-specific rules, payment/tax/invoice.
9. Localization burden: language, workflow, integrations, currency, support, onboarding.
10. Technical readiness: region hosting, multi-tenancy, latency, i18n/l10n, observability, SLA.

For B2B, prioritize decision-maker access and willingness-to-pay evidence over broad market size.
For B2C, prioritize acquisition channel cost, local behavior, payment, trust, support, and
retention evidence.

## Step 5: Beachhead Scorecard

Write a scorecard using this table:

```markdown
## Beachhead Market Scorecard
| Market | Problem | Pay | Access | Competition | Regulation | Localization | Distribution | Reference | Technical | Total | Confidence |
|--------|---------|-----|--------|-------------|------------|--------------|--------------|-----------|-----------|-------|------------|
```

Scoring rules:

- Use 1-10 for each criterion.
- Regulation and localization are reversed-risk scores: higher means easier.
- Give a short evidence note for every score.
- If evidence is missing, mark the score as `Tahmin` and lower confidence.
- Do not let total score hide a fatal blocker. Write fatal blockers separately.

Recommended decision labels:

- `Denenmeye Değer`: one market has strong ICP transfer, reachable channel, manageable risk, and
  credible technical readiness.
- `Revizyonla Denenmeye Değer`: the market may work but message, product, technical readiness,
  partner, or ICP must narrow first.
- `Denenmeye Değmez`: no reachable buyer, fatal compliance gap, weak proof, or unrealistic
  execution cost.

## Step 6: Localization And Trust Package

For the recommended market, define:

- localized ICP,
- buyer and user map,
- core pain in local language or local business terms,
- ROI/result claim,
- trust proof needed,
- security/compliance proof needed,
- landing page or one-pager angle,
- demo narrative,
- pricing and pilot offer,
- onboarding and support promise,
- required integrations,
- partner or reseller need.

Do not translate existing Turkish copy directly. Rewrite the message around outcome, buying
trigger, risk, trust, and local workflow.

## Step 7: Technical Globalization Readiness

Create a readiness memo:

```markdown
## Technical Globalization Readiness
| Area | Current state | Target-market requirement | Risk | Required action |
|------|---------------|---------------------------|------|-----------------|
| Data residency and compliance | | | | |
| Multi-tenancy and tenant isolation | | | | |
| Regional routing and latency | | | | |
| i18n/l10n: language, time, currency | | | | |
| Payments, tax, and invoicing | | | | |
| Security and procurement trust | | | | |
| Observability and SLA | | | | |
| Support and onboarding | | | | |
```

If technical gaps block sales claims, route product/engineering preparation to Product Architect
or Coder brief work before a broad GTM push.

## Step 8: 90-Day Market Entry Test

Produce a 90-Day Market Entry Test plan:

```markdown
## 90-Day Market Entry Test

### Days 1-30: Select and prepare
- Final ICP:
- Localized positioning:
- Landing page / one-pager:
- Prospect source:
- Compliance/trust materials:
- Technical promises allowed:

### Days 31-60: Demand test
- Target accounts or users:
- Outreach volume:
- Discovery call target:
- Demo target:
- Pilot or LOI target:
- Messages to test:

### Days 61-90: Pilot or pivot
- Paid pilot criteria:
- Case study path:
- Pricing decision:
- Partner/channel decision:
- CRM and metrics setup:
- Pivot trigger:
```

Suggested starting thresholds, adapted to context:

- 100-300 target accounts or users.
- 20-30 discovery calls.
- 5-10 demos.
- 1-3 paid pilots, serious LOIs, or procurement conversations.
- Stop or revise if replies are polite but no demos, no budget discussion, and no clear pain.

## Step 9: Metrics And Stop Conditions

Define:

- outbound reply rate,
- demo booking rate,
- discovery-to-demo conversion,
- demo-to-pilot conversion,
- sales cycle,
- price objection quality,
- competitor comparison frequency,
- activation/onboarding success,
- support load,
- country-specific latency/error rate if product is live.

Write explicit gates:

```markdown
## Decision Gate
- Continue if:
- Revise if:
- Stop if:
- Data still missing:
```

## Step 10: Handoff Outputs

Depending on the next action, route to:

- `agents/outreach-specialist.md` for target accounts, cold email, LinkedIn, partner, field, or
  reseller outreach.
- `agents/content-creator.md` and `agents/brand-guardian.md` for landing page, one-pager, offer,
  and localized proof package.
- `agents/product-architect.md` for technical/product changes, compliance-driven scope, PRD, or
  coder brief.
- `agents/analytics-master.md` for metrics dashboard, event plan, and report.
- `agents/schedule-coordinator.md` for weekly plan and Google Calendar sync if approved.

## Standard Output

```markdown
# International Market Expansion Recommendation
- Date:
- Current market:
- Candidate markets:
- Recommended beachhead:
- Decision:
- Confidence:

## Kaynak ve Kanit Defteri
| ID | Tool | Source | Access date | Data used | Confidence |
|----|------|--------|-------------|-----------|------------|

## Veri Isleme Notlari
- Raw data:
- Normalized fields:
- Tools or scripts:
- Assumptions:
- Missing or inaccessible data:

## Current Traction Evidence

## Candidate Market Shortlist

## Beachhead Market Scorecard

## Recommended Market And Rationale

## Localization And Trust Package

## Technical Globalization Readiness

## 90-Day Market Entry Test

## Decision Gate

## Next Workspace Outputs

## Cikti Iliski Haritasi
- Kaynaklar:
- Ilgili ciktilar:
- Etkiledigi kararlar:
- Sonraki kullanim:
- Celiski veya kontrol notu:
```

## Output Paths

Evaluation workspace:

- Working research and scorecard: `ciktilar/uluslararasi-pazar-genisleme.md`
- Synthesis: `RAPOR.md`
- Notes: `notlar/`
- Relationship memory: `ciktilar/bilgi-haritasi/`

Project workspace:

- Research: `02-arastirma/pazar-arastirmasi/uluslararasi-pazar-arastirmasi.md`
- Strategy: `03-strateji/pazara-giris/uluslararasi-pazara-giris-stratejisi.md`
- Growth/test plan: `03-strateji/buyume/90-gun-pazar-testi.md`
- Outreach handoff: `06-pazarlama-uygulamalari/saha/uluslararasi-outreach-brief.md`
- Report: `08-raporlar/pazarlama/uluslararasi-pazar-genisleme-raporu.md`
- Relationship memory: `11-notlar/bilgi-haritasi/`

## Completion Rule

The file is complete only when it contains:

- current traction evidence,
- candidate markets,
- source-backed scorecard,
- recommended first market or clear stop decision,
- localization and trust package,
- technical readiness check,
- 90-Day Market Entry Test,
- decision gate,
- evidence ledger and data processing notes.

If sources are missing, complete the file with `Kontrol gerekli` sections and ask for the exact
manual data needed. Do not fabricate missing market evidence.
