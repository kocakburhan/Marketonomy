# Pipeline: Store Intelligence Opportunity Discovery

**When it runs:** Mobile app idea discovery, App Store / Google Play category analysis, top
grossing analysis, ASO opportunity search, or review-based app idea generation.

**Purpose:** Use store ranking, category, monetization, and review evidence to find data-backed
mobile app opportunities. This pipeline must work without a required MCP. If an app-store MCP is
visible later, it can replace the data adapter without changing the decision flow.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Source Priority

Use this order:

1. Public structured endpoints:
   - Apple RSS Feed Generator for top charts: `https://rss.marketingtools.apple.com/`
   - Apple iTunes Search / Lookup API for metadata: `https://itunes.apple.com/search` and
     `https://itunes.apple.com/lookup`
2. Active Codex official web search for source discovery and cross-checking.
3. Browser / Chrome for dynamic store pages and visible UI inspection.
4. Google Play scraper libraries or local scripts when available.
5. Playwright/browser automation fallback when no stable structured source exists and access is
   public.
6. Manual user export or screenshots if automated access fails.
7. MCP only if the active Codex tool list exposes a relevant app-store MCP.

Do not claim exact revenue, downloads, or historical rank movement unless the source provides it.
Rank position is evidence of store chart strength, not exact revenue.

---

## Core Flow

```text
[S1] Select platform, country, chart, and category scope
      |
      v
[S2] Fetch top charts and app metadata
      |
      v
[S3] Normalize apps by category, rank, rating, review count, price, IAP/subscription signal
      |
      v
[S4] Identify category concentration and monetization signal
      |
      v
[S5] If snapshots exist, calculate 7/14/30-day category movement
      |
      v
[S6] Select 3-10 apps in strongest category
      |
      v
[S7] Collect positive and negative reviews
      |
      v
[S8] Extract liked features, complaints, missing features, user segments, and payment triggers
      |
      v
[S9] Produce opportunity report and idea candidates
```

---

## S1 Scope

Default values if the user does not specify:

- Platform: iOS first, then Android if time allows.
- Country: `US` for global monetization signal; `TR` if the user targets Turkey.
- Chart: top grossing first, then top free for adoption signal.
- Result limit: 10 for quick scan, 50 for stronger category analysis.
- Categories: all categories unless user gives a sector.

Ask the user only if the decision materially changes the result. Otherwise proceed with defaults
and state them in the output.

---

## S2-S3 Data Collection And Normalization

Normalized app record:

```json
{
  "platform": "ios|android",
  "country": "US",
  "chart": "top_grossing|top_free|top_paid|search",
  "rank": 1,
  "app_id": "",
  "name": "",
  "developer": "",
  "category": "",
  "rating": null,
  "review_count": null,
  "price": null,
  "iap_or_subscription_signal": "yes|no|unknown",
  "source_url": "",
  "collected_at": ""
}
```

Store raw data before summarizing:

- Evaluation workspace: `kaynaklar/store-intelligence/` for raw exports if available, otherwise
  `ciktilar/store-intelligence-raw.md`.
- Project workspace: `02-arastirma/store-intelligence/raw/`.

Normalized output:

- Evaluation workspace: `ciktilar/store-intelligence-normalized.md`
- Project workspace: `02-arastirma/store-intelligence/store-intelligence-normalized.md`

---

## S4 Category Strength

For a single snapshot, use these signals:

- Number of apps from the category in the top list.
- Average rank of category apps.
- Presence of subscriptions, IAP, or paid price.
- Review volume and rating count.
- Whether competitors solve the same user job or different sub-jobs.

Use language precisely:

- If only today's chart is available, say `kategori su an guclu`.
- Say `yukseliste` only if past snapshots or a reliable historical source show movement.

---

## S5 Snapshot And Trend Rule

Public store endpoints usually return the current chart, not a historical 14-day chart. Therefore:

- If local snapshots exist, compare category share, average rank, and new entrants over 7/14/30
  days.
- If no snapshots exist, create the first snapshot and label trend as `Tarihsel veri yok`.
- If a paid or external provider supplies history, record the provider, date range, and fields.

Snapshot output:

- Evaluation workspace: `ciktilar/store-intelligence-snapshot-[YYYY-MM-DD].json`
- Project workspace: `02-arastirma/store-intelligence/snapshots/[YYYY-MM-DD].json`

Trend fields:

```markdown
| Category | Apps today | Avg rank today | Apps 14d ago | Avg rank 14d ago | Movement | Confidence |
|---|---:|---:|---:|---:|---|---|
```

---

## S7 Review Collection

Collect at least:

- 30 positive reviews if available.
- 30 negative reviews if available.
- Review date, rating, app version if visible, locale/country if visible.
- If less data is available, state the count and confidence impact.

For Apple, try public review feeds or visible store pages first; use Browser/Chrome/Playwright
fallback when public pages require dynamic inspection.

For Google Play competitor apps, do not rely on Google Play Developer API unless it is the user's
own app. Use public pages, scraper libraries, Browser/Chrome, Playwright fallback, or manual
export.

---

## S8 Review Mining

Extract:

- Positive themes: what users value and repeat.
- Negative themes: complaints, churn triggers, broken expectations.
- Missing features: requests and workaround language.
- User segments: who appears to need it.
- Payment signal: subscription complaints, "worth it", "too expensive", upgrade blockers,
  purchase regret, or willingness to pay.
- MVP implication: what a smaller better product could do first.

Quantify themes:

```markdown
| Theme | Positive count | Negative count | Example user language | Product implication |
|---|---:|---:|---|---|
```

---

## Output: Store Intelligence Opportunity Report

Write to:

- Evaluation workspace: `ciktilar/store-intelligence-opportunity-report.md`
- Project workspace: `02-arastirma/store-intelligence/store-intelligence-opportunity-report.md`

```markdown
# Store Intelligence Opportunity Report
- Date:
- Platform:
- Country:
- Chart:
- Category scope:

## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Top Apps
| Rank | App | Category | Rating | Review count | Monetization signal | Source |
|---:|---|---|---:|---:|---|---|

## Category Analysis
| Category | App count | Avg rank | Monetization signal | Trend status | Confidence |
|---|---:|---:|---|---|---|

## Selected Category
- Why selected:
- Evidence:
- Missing data:

## Review Analysis
### What Users Like
### What Users Complain About
### Requested Features
### User Segments
### Payment Signals

## Opportunity Candidates
| Candidate | Evidence | User pain | Competitor gap | MVP angle | Confidence |
|---|---|---|---|---|---|

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

---

## PersonalAutonomy Execution Rules

- Main output areas: in evaluation `ciktilar/`; in project `02-arastirma/store-intelligence/`
  and later `03-strateji/dogrulama/` if scored.
- Preserve raw chart/review data separately from normalized analysis.
- Do not fabricate exact revenue, downloads, rank history, or keyword volume.
- Use `yukseliste` only with historical evidence; otherwise say `su an guclu`.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- Obtain explicit user approval before any login, account action, paid provider use, or external
  write action.
- Copy approved final copies under `10-final/` and preserve the working source in place.
