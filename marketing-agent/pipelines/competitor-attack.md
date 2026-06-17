# Pipeline 6: Competitor Attack

**Position in chain:** Chain D (supports P4) or independent entry point.

**When it runs:** When a strategy against a specific competitor is needed. When the user says
"what can I do against this competitor."

**Purpose:** Deeply analyze the competitor and produce an action plan targeting their weak points.

**Prerequisite:** The target competitor must be identified. `PROJE.md and relevant files under
01-baglam/` must be present.

---

## Pipeline Flow

```
User: "I want a strategy against competitor X"
        │
        ▼
[6.1] Market Scout → Deep scan of the competitor
        │  Output: rakip-profili.md
        ▼
[6.2] Strategy Analyst → Find the competitor's weak points
        │  Output: rakip-acik-analizi.md
        ▼
[6.3] Content Creator → Content strategy against the competitor
        │  Output: karsilastirma-icerik.md
        ▼
[6.4] Campaign Manager → Ads on competitor keywords
        │  Output: rakip-kampanya.md
        ▼
[6.5] Growth Hacker → Strategy to attract competitor customers
           Output: musteri-cekme.md
```

---

## Step Details

### 6.1 — Deep Competitor Profile
**Agent:** Market Scout
**Skill:** `competitor-profiling`
**Action:**
- Scan all of the competitor's pages (homepage, pricing, features, about, customers, blog)
- Perform SEO analysis
- Examine social media presence
- Collect user reviews

**Output (`rakip-profili.md`):**
- Summary, positioning, product/features, pricing, customer evidence, strengths/weaknesses

### 6.2 — Weak Point Analysis
**Agent:** Strategy Analyst
**Output (`rakip-acik-analizi.md`):**
```markdown
# Rakip Açık Analizi: [Competitor]
## Identified Weaknesses
| Weakness | Severity | Our Advantage | Action |
|----------|----------|---------------|--------|
| ... | Critical | ... | ... |

## Attack Vectors
1. ...
```

### 6.3 — Comparison Content
**Agent:** Content Creator
**Output (`karsilastirma-icerik.md`):**
- "X vs Y" landing page copy
- Competitor comparison table
- Blog/social media content targeting competitor customers

### 6.4 — Competitor Keyword Ads
**Agent:** Campaign Manager
**Output (`rakip-kampanya.md`):**
- Ads on competitor brand keywords
- Retargeting to competitor product page visitors

### 6.5 — Customer Attraction Strategy
**Agent:** Growth Hacker
**Output (`musteri-cekme.md`):**
- Switching campaign (campaign for switching from competitor)
- Comparison page CRO
- Special offer for competitor customers

---

## Output Files

| File | Produced by |
|------|-------------|
| `rakip-profili.md` | Market Scout |
| `rakip-acik-analizi.md` | Strategy Analyst |
| `karsilastirma-icerik.md` | Content Creator |
| `rakip-kampanya.md` | Campaign Manager |
| `musteri-cekme.md` | Growth Hacker |

---

## Next Step

Pipeline 6 runs independently. Its results can be used within **Pipeline 2 (MVP Launch)** or **Pipeline 4 (Growth Engine)**.

## PersonalAutonomy Execution Rules

- Main output areas: 02-arastirma/rakip-arastirmasi/ and 03-strateji/konumlandirma/
- The pipeline does not create its own project or status folder. It keeps the active step in
  DURUM.md and the relevant .pa/*/active-task.md file.
- In an evaluation workspace, it does not apply project-only steps; it does not interpret a
  positive result as authority to create a project.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Records claims requiring current data with source and access date; if data is missing, labels
  the assumption explicitly.
- Obtains explicit user approval at decision gates. Producing a file does not complete a weekly task.
- Places approved final copies under 10-final/ and preserves the working source in place.

Internal operating instructions are in English. The default user-facing language is Turkish.
