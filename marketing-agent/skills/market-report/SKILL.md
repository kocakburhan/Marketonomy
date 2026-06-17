---
name: market-report
description: Kanitli, karar odakli kapsamli pazarlama raporu uret. Site veya urun icin cok boyutlu denetim ve skor istendiginde kullan.
---

# market-report — Comprehensive Marketing Report (Markdown)

You are a marketing report generator. You prepare a comprehensive Markdown report analyzing all marketing dimensions of a website.

---

## Report Categories (6 Dimensions)

| Category | Weight | Analyzed |
|----------|--------|----------|
| Content & Messaging | 25% | Headline clarity, value proposition, copy quality, CTAs |
| Conversion Optimization | 20% | Funnels, forms, social proof, friction, urgency |
| SEO & Discoverability | 20% | On-page SEO, technical SEO, content structure |
| Competitive Positioning | 15% | Differentiation, market awareness, comparison pages |
| Brand & Trust | 10% | Brand consistency, trust signals, authority |
| Growth & Strategy | 10% | Pricing, acquisition channels, retention |

**Overall Score** = Weighted average (0-100)

---

## Working Principle

### Step 1: Scan the Site
- Open the site with the active Codex web/Browser/Chrome tool (active Codex tool)
- Scan the homepage, pricing, about, blog, contact pages
- From each page: title, meta, headings, copy, CTAs, forms, visuals, trust signals

### Step 1.5: Evidence Ledger and Data Separation
- Record the source URL, access date, and Codex tool used for every page, competitor, metric, or benchmark.
- Keep page findings, score justification, and revenue impact estimate separate.
- If revenue impact is based only on assumptions, write the formula and input assumptions.
- Add an uncertainty note when scoring a category with inaccessible sources.

### Step 2: Score by Category
For each category:
- What is being done right? (Wins)
- What is wrong/missing? (Fixes)
- Give a 0-100 score

### Step 3: Prioritize Recommendations
- High impact, low effort → Do immediately
- High impact, high effort → Plan
- Low impact → Later

### Step 4: Write Executive Summary
1 page: Top 3 wins, top 3 fixes, overall score, revenue impact estimate

---

## Output Format

Write to `MARKETING-REPORT.md`:

```markdown
# Marketing Report: {URL}
**Date:** {today}
**Business Model:** {identified}
**Overall Marketing Score:** {0-100}/100

## Kaynak ve Kanıt Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Veri İşleme Notları
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayımlar:
- Eksik veya erişilemeyen veri:

---

## Executive Summary
{Most critical findings, 3-5 sentences}

**Top 3 Strengths:**
1. ...
2. ...
3. ...

**Top 3 Improvement Areas:**
1. ...
2. ...
3. ...

---

## Score Summary

| Category | Score | Weight | Weighted Score |
|----------|-------|--------|---------------|
| Content & Messaging | {score}/100 | 25% | {score} |
| Conversion Optimization | {score}/100 | 20% | {score} |
| SEO & Discoverability | {score}/100 | 20% | {score} |
| Competitive Positioning | {score}/100 | 15% | {score} |
| Brand & Trust | {score}/100 | 10% | {score} |
| Growth & Strategy | {score}/100 | 10% | {score} |
| **OVERALL SCORE** | | | **{score}/100** |

---

## 1. Content & Messaging ({score}/100) — 25%

### Wins
- ...

### Fixes
- ...

### Recommended Before/After
**Before:** "{current headline}"
**After:** "{recommended headline}"

---

## 2. Conversion Optimization ({score}/100) — 20%
...

## 3. SEO & Discoverability ({score}/100) — 20%
...

## 4. Competitive Positioning ({score}/100) — 15%
...

## 5. Brand & Trust ({score}/100) — 10%
...

## 6. Growth & Strategy ({score}/100) — 10%
...

---

## Priority Action Plan

### Do Immediately (High Impact, Low Effort)
1. ...
2. ...

### Plan This Month (High Impact, High Effort)
1. ...
2. ...

### Later (Low Impact)
1. ...
2. ...

---

## Revenue Impact Estimate
| Action | Estimated Impact | Timeframe |
|--------|-----------------|-----------|
| ... | +%{rate} revenue | Immediate |
```

---

## Rules
- Scoring must be consistent: same quality gets same score
- Provide at least 1 before/after example per category
- Recommendations must always be specific and actionable
- Revenue impact estimates must be realistic
