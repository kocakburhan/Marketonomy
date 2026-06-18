# Pipeline: Trend-to-Product Opportunity Discovery

**When it runs:** The user wants ideas from trends, rising searches, news, new platforms, social
behavior, emerging tools, or "yukselen alanlardan fikir bulalim".

**Purpose:** Convert trend signals into testable product opportunities. The agent must separate
short-lived hype from durable demand and must connect every trend to a specific user problem.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Flow

```text
[T1] Define trend domain and geography
      |
      v
[T2] Collect trend signals
      |
      v
[T3] Cross-check with complaints, competitors, and search behavior
      |
      v
[T4] Translate trend into user jobs and buying triggers
      |
      v
[T5] Score trend durability and MVP feasibility
      |
      v
[T6] Produce product opportunity candidates
```

---

## Sources

- Google Trends via `scripts/google_trends.py` or web search when available.
- News, reports, Product Hunt, GitHub trending, app stores, marketplaces.
- Reddit, forums, professional communities, YouTube/TikTok/LinkedIn public content.
- Active Codex web search for source discovery.
- Browser/Chrome for dynamic pages.
- Playwright fallback for public pages that need browser rendering.

---

## Trend Quality Checks

A trend is not an idea by itself. Check:

```markdown
| Trend | Evidence | User job | Buyer | Existing alternatives | Durability | Risk | Confidence |
|---|---|---|---|---|---|---|---|
```

Durability signals:

- Repeated search growth over time.
- Multiple independent sources mention the same behavior.
- Users ask for tools, templates, automation, training, compliance, or workflow support.
- Businesses already spend money around the trend.
- Competitors exist but leave a narrower gap.

Weak signals:

- One viral post only.
- No identifiable buyer.
- No repeated complaint or workaround.
- Trend is only interesting, not painful.

---

## Output: Trend-to-Product Report

Write to:

- Evaluation workspace: `ciktilar/trend-to-product-report.md`
- Project workspace: `02-arastirma/trend-arastirmasi/trend-to-product-report.md`

```markdown
# Trend-to-Product Report
- Date:
- Domain:
- Geography/language:

## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Trend Signals
| Trend | Source count | Search/social signal | Time direction | Confidence |
|---|---:|---|---|---|

## Product Translation
| Trend | User job | Pain | Buyer | Existing alternative | MVP angle |
|---|---|---|---|---|---|

## Opportunity Candidates
| Candidate | Why now | Segment | First validation test | Risk | Confidence |
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

- Main output areas: in evaluation `ciktilar/`; in project `02-arastirma/trend-arastirmasi/`.
- Do not treat trend popularity as proof of willingness to pay.
- Cross-check trends with complaints, competitors, or user workarounds before recommending ideas.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- Obtain explicit user approval before account login, paid data provider use, or external actions.
- Copy approved final copies under `10-final/` and preserve the working source in place.
