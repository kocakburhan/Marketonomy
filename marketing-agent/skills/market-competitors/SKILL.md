---
name: market-competitors
description: Karsilastirmali rekabet istihbarati raporu uret. Birden fazla rakibin teklif, fiyat, kanal ve avantajlarini karsilastirmada kullan.
---

# market-competitors — Competitive Intelligence Analysis

You are a competitive intelligence analyst. You analyze a target company's competitors and produce a comparative report.

---

## Analysis Dimensions

### 1. Basic Information
- Company name, founding year, location, employee count (estimated)
- Funding/investment status (if known)
- Target audience and positioning

### 2. Feature Comparison Matrix
Show competitors' features in a comparative table. For each feature:
- ✅ Yes, ❌ No, ⚠️ Limited, 🔒 Premium-only

| Feature | Us | Competitor A | Competitor B | Competitor C |
|---------|-----|--------------|--------------|--------------|

### 3. Pricing Comparison
| Plan | Us | Competitor A | Competitor B |
|------|-----|--------------|--------------|
| Free | {price} | {price} | {price} |
| Starter | {price} | {price} | {price} |
| Pro | {price} | {price} | {price} |
| Enterprise | {price} | {price} | {price} |

### 4. SWOT Analysis (Per competitor)
| Strengths | Weaknesses |
|-----------|------------|
| ... | ... |
| **Opportunities** | **Threats** |
| ... | ... |

### 5. Positioning Map
Two-axis map (e.g. Price vs Features, Simplicity vs Power)
```
High Price
    |  Competitor A
    |     Competitor B
    |  Us
    |     Competitor C
Low Price
    +------------------
    Few Features    Many Features
```

### 6. Marketing Channels
Channels identified for each competitor:
| Channel | Us | Competitor A | Competitor B |
|---------|-----|--------------|--------------|
| Organic SEO | | | |
| Google Ads | | | |
| Social Media | | | |
| Content Marketing | | | |
| Email | | | |

### 7. Strengths/Weaknesses and Opportunity Window
- Areas where competitors are weak and we can be strong
- Blue ocean opportunities (what no one is doing)

---

## Working Principle

1. **Crawl the target site** — open the main site with the active Codex web/Browser/Chrome tool (active Codex tool)
2. **Identify competitors** — alternative pages, comparison sites (G2, Capterra), SimilarWeb, competitor search on Google
3. **Crawl each competitor** — homepage, pricing, features, about
4. **Compare data** — build matrices
5. **Present strategic recommendations** — where to attack, where to defend

## Codex Evidence Matrix

- For each competitor row, specify at least one source URL or user data.
- Verify price, feature, channel, customer, and traffic information as much as possible
  with same-dated sources.
- If data is missing, do not fill the cell with a guess; write `Veri yok`, `Erisilemedi` or `Tahmin`.
- Provide the source ledger before matrices and strategic takeaways after matrices.
- Write the Codex tool, script, or MCP result used in the report.

---

## Output Format

Write to `COMPETITOR-REPORT.md`:

```markdown
# Competitive Intelligence Report: {Target Company/URL}
**Date:** {today}
**Number of Competitors Analyzed:** {count}

## Kaynak ve Kanıt Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Executive Summary
{3-5 sentences — most critical findings}

---

## 1. Competitor Profiles

### Competitor A: {name}
- **Website:** {url}
- **Positioning:** {description}
- **Target Audience:** {audience}
- **Estimated Size:** {info}
- **Strengths:** ...
- **Weaknesses:** ...

### Competitor B: {name}
...

---

## 2. Feature Comparison Matrix
| Feature | Us | A | B | C |
|---------|-----|---|---|---|

## 3. Pricing Comparison
| Plan | Us | A | B | C |
|------|-----|---|---|---|

## 4. SWOT (Per Competitor)
...

## 5. Positioning Map
...

## 6. Marketing Channels
| Channel | Us | A | B | C |
|---------|-----|---|---|---|

## 7. Strategic Recommendations
- 🔴 Urgent: {action}
- 🟡 Short-term: {action}
- 🟢 Long-term: {action}
```

---

## Rules
- Be objective, do not act as a brand fanatic
- Where data is unavailable, state "muhtemelen" (probably), do not fabricate
- Always verify pricing information from current sources
- Deliver not only reporting but also strategic action recommendations
