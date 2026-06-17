---
name: seo-audit
description: Teknik ve on-page SEO denetimi yap. Title, meta, heading, schema, hiz, indexleme veya ic baglanti analizi istendiginde kullan.
---

# SEO Audit

SEO technical audit specialist. Checks the site's search engine health, detects errors, prioritizes fixes.

## Audit Categories

### 1. On-Page SEO
- **Title tag:** 50-60 characters, keyword at the front, unique
- **Meta description:** 150-155 characters, CTA, keyword
- **H1:** Must be single, must include keyword
- **Heading hierarchy:** H1 → H2 → H3 logically ordered
- **URL structure:** Clean, readable, keyword-rich
- **Image alt tag:** On all images, descriptive

### 2. Technical SEO
- SSL certificate
- Mobile compatibility
- Page speed (target < 3s)
- Schema markup (Article, Product, FAQ, Breadcrumb)
- Robots.txt configuration
- XML sitemap
- Canonical URLs
- Broken links

### 3. Content Quality
- Content length and depth
- Originality (duplicate content check)
- E-E-A-T signals (Experience, Expertise, Authoritativeness, Trustworthiness)
- Freshness (last updated date)

### 4. Internal Link Structure
- Inter-page linking
- How many internal links to important pages
- Anchor text diversity
- Orphan pages (receiving no links)

## Audit Process

1. **Crawl the site** — with active Codex web/Browser/Chrome tool or active Codex web tool
2. **Extract on-page elements:** title, meta, headings, images, links
3. **Perform technical checks:** SSL, robots.txt, sitemap
4. **Evaluate content:** E-E-A-T criteria
5. **Prioritize errors:** Critical → Important → Improvement

## Codex Evidence Rule

- Record every URL, Codex tool, and access date used in the audit.
- For technical findings such as robots.txt, sitemap, schema, canonical, speed, or indexing,
  specify the source and verification method.
- If external data such as PageSpeed or Search Console is unavailable, do not produce an estimated
  score; document the missing data.
- Keep the technical finding and recommendation separate; if a finding is unverified, write
  `Kontrol gerekli`.

## Output Format

```markdown
# SEO Audit: {URL}
**Date:** {today}
**SEO Score:** {0-100}

## Kaynak ve Kanıt Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Critical Errors (Must Fix Immediately)
| # | Issue | Page | Solution |
|---|-------|------|----------|

## On-Page SEO
| Element | Status | Current | Recommended |
|---------|--------|---------|-------------|

## Technical SEO
| Element | Status | Note |
|---------|--------|------|

## Priority Actions
1. 🔴 ...
2. 🟡 ...
3. 🟢 ...
```
