# Pipeline: Competitor Gap Opportunity Discovery

**When it runs:** The user knows a category, market, competitor set, or says "rakiplerden bosluk
bulalim".

**Purpose:** Find opportunities by comparing competitor positioning, features, pricing, reviews,
acquisition channels, and weak segments. The agent must avoid "copy a competitor" thinking; the
output is a narrower, better-tested angle.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Flow

```text
[G1] Define category and competitor set
      |
      v
[G2] Collect competitor evidence
      |
      v
[G3] Build comparison matrix
      |
      v
[G4] Analyze reviews/complaints and pricing
      |
      v
[G5] Identify underserved segment or job-to-be-done
      |
      v
[G6] Score gaps and produce opportunity candidates
```

---

## Evidence Sources

- Competitor landing pages, pricing pages, help docs, changelogs, app pages, marketplace pages.
- Review sites: G2, Capterra, Trustpilot, App Store, Google Play, Product Hunt.
- SEO and content footprint from active Codex web search.
- Browser/Chrome for dynamic pages.
- Playwright fallback for public pages that require rendering.
- `scripts/analyze_page.py` and `scripts/competitor_scanner.py` when appropriate.

---

## Comparison Matrix

```markdown
| Competitor | Target segment | Core promise | Pricing | Main features | Strength | Weakness | Source |
|---|---|---|---|---|---|---|---|
```

Gap matrix:

```markdown
| Gap | Evidence | Affected segment | Why competitors miss it | MVP angle | Risk | Confidence |
|---|---|---|---|---|---|---|
```

Valid gap types:

- Segment gap: a user group is poorly served.
- Workflow gap: existing tools solve pieces but not the job end-to-end.
- Price gap: products are too expensive or overbuilt for a segment.
- Trust gap: users complain about reliability, support, privacy, or opaque pricing.
- Localization gap: language, culture, country, or regulation mismatch.
- Channel gap: competitors depend on channels the user can attack differently.

---

## Output: Competitor Gap Report

Write to:

- Evaluation workspace: `ciktilar/competitor-gap-report.md`
- Project workspace: `02-arastirma/rakip-arastirmasi/competitor-gap-report.md`

```markdown
# Competitor Gap Report
- Date:
- Category:
- Competitors:

## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Competitor Matrix
| Competitor | Segment | Promise | Pricing | Strength | Weakness | Evidence |
|---|---|---|---|---|---|---|

## Review And Complaint Signals
- Common positive themes:
- Common negative themes:
- Repeated missing features:
- Price/value complaints:

## Gap Candidates
| Gap | Segment | Evidence | MVP angle | First channel | Confidence |
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

- Main output areas: in evaluation `ciktilar/`; in project `02-arastirma/rakip-arastirmasi/`.
- Do not claim a gap exists unless competitor evidence or user complaint evidence supports it.
- Do not copy competitor branding, protected assets, paid content, or private data.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- Obtain explicit user approval before account login, trial signup, or form submission.
- Copy approved final copies under `10-final/` and preserve the working source in place.
