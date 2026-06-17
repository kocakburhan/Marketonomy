# Pipeline 1: Idea Discovery and Validation

**Position in chain:** Chain A (first step) — then transitions to P5.

**When it runs:** When the user says "I want to find an idea from scratch" or when they haven't
brought a concrete idea yet. If the user comes with a ready idea, do not start this pipeline;
direct them to the "is it worth trying?" flow in `pipelines/idea-to-prd.md`.

**Purpose:** Scan the market for gaps and opportunities to reach a testable product idea together
with the user. When the idea becomes clear, the agent validates the idea rigorously based on
evidence and the user's marketing advantage rather than being optimistic.

**Prerequisite:** `PROJE.md and relevant files under 01-baglam/` must be created.

---

## Pipeline Flow

```
User enters
        │
        ▼
[1.1] Orchestrator → Ask interest area/sector/product type
        │
        ▼
[1.2] Market Scout → Scan sources, produce opportunity map
        │  Output: firsat-haritasi.md
        ▼
[1.3] Orchestrator → Present opportunities to user, have them select a category
        │  User: "Analyze category X" (or "cancel")
        ▼
[1.4] Market Scout → Deep analysis in selected category
        │  Output: kategori-analizi.md
        ▼
[1.5] Strategy Analyst → Competitive analysis, gap detection
        │  Output: strateji-analizi.md
        ▼
[1.6] Orchestrator → Present gaps to user, have them select an opportunity
        │  User: selects a gap/opportunity (or "return to other category")
        ▼
[1.7] Product Architect → Generate idea from selected opportunity
        │  Output: idea-brief.md
        ▼
[1.8] Orchestrator → Discuss and shape the idea with the user
        │  User: approves / requests revision / cancels
        ▼
[1.9] Orchestrator → Pass approved idea to P5 valuation gate
           P5: user marketing advantage + research + rigorous validation
           If value decision is made: MVP → PRD → coder brief
```

---

## Step Details

### 1.1 — Interest Area and Product Type Determination
**Agent:** Orchestrator
**Questions to user:**
1. Which sector are you interested in? (open-ended or suggested list)
2. What type of product? (Mobile app / SaaS / E-commerce / ...)
3. Do you have a specific interest area? (sports, health, education, finance...)

**Note:** If the user says "I don't know," scan all popular categories.

### 1.2 — Opportunity Map
**Agent:** Market Scout
**Optional capabilities:**
- Mobile App: use `search_app` to find top apps in categories, use `analyze_top_keywords` to measure keyword traffic
- SaaS: scan G2/Capterra/Reddit with active Codex web/Browser/Chrome tool
- Physical Business: scan Google Maps/GBP with active Codex web/Browser/Chrome tool

**Action:** Scan all sources appropriate for the product type.
- App Store / Google Play → **mcp-appstore `search_app` + `analyze_top_keywords`**
- G2 / Capterra / Reddit → **active Codex web/Browser/Chrome tool**
- Google Maps / GBP → **active Codex web/Browser/Chrome tool**

**Note:** If the user specified a sector, scan only that sector. If not, scan all categories and rank the fastest-growing ones.

### 1.3 — Category Selection
**Agent:** Orchestrator
**Presented to user:** At least 3 rising categories, for each:
- How many apps/competitors exist
- Growth rate
- Average revenue (if available)
- One standout example

**User decision:** "Deeply analyze category X" or "cancel, scan another source"

### 1.4 — Deep Category Analysis
**Agent:** Market Scout
**Optional capabilities (for each competitor app):**
1. `get_app_details(appId, platform)` → downloads, rating histogram, category, screenshots
2. `analyze_reviews(appId, platform, sort="rating", num=200)` → sentiment, top negative keywords, common themes
3. `get_pricing_details(appId, platform)` → IAP prices, monetization model
4. `get_similar_apps(appId, platform)` → competitor discovery
5. **Revenue estimate:** `rating_count × avg_subscription_price × 0.02`

**Duration:** Depends on number of competitors in the category. At least 3, at most 10 competitors analyzed.

### 1.5 — Strategic Analysis
**Agent:** Strategy Analyst
**Input:** `kategori-analizi.md`
**Output:** SWOT, positioning map, gap list

### 1.6 — Opportunity Selection
**Agent:** Orchestrator
**Presented to user:** At least 3 concrete opportunity areas (gaps). For each:
- Which competitors' deficiency
- What users complain about
- Estimated market size

### 1.7 — Idea Generation
**Agent:** Product Architect
**Input:** Selected opportunity area
**Output:** `idea-brief.md` — problem, solution, target audience, MVP scope, revenue model

### 1.8 — Idea Discussion
**Agent:** Orchestrator
**Done with user:** Pros/cons of the idea, risks, alternative angles, target audience clarification. The user shapes the idea.

### 1.9 — Transition to P5 Valuation Gate
**Agent:** Orchestrator
**Input:** Approved `idea-brief.md` + discussion notes
**Action:** Treat the idea as a ready idea and start the `pipelines/idea-to-prd.md` flow.

In this transition, do not be optimistic toward the user again. Within P5, the user's network,
knowledge, field/sector of work, city/country of residence, sales/marketing experience, and first
user access channels are queried. If the idea is found valuable, first
`04-urun/fikir-ozetleri/mvp.md`, then `04-urun/prd/prd.md`, then
`04-urun/coder-briefleri/coder-brief.md` are produced.

---

## Decision Points

| Step | Decision | Options |
|------|----------|---------|
| 1.3 | Category selection | "Analyze X" / "Suggest another" / "Cancel" |
| 1.6 | Opportunity selection | "Generate idea from X opportunity" / "Return to other category" / "Cancel" |
| 1.8 | Idea approval | "Pass to P5 valuation gate" / "Change this part" / "Cancel" |
| 1.9 | Valuation transition | "Start P5" / "Revise idea first" / "Cancel" |

---

## Output Files

| File | Produced by | Description |
|------|-------------|-------------|
| `firsat-haritasi.md` | Market Scout | All categories, growth rates |
| `kategori-analizi.md` | Market Scout | Competitor profiles in selected category |
| `strateji-analizi.md` | Strategy Analyst | SWOT, gaps, opportunity areas |
| `idea-brief.md` | Product Architect | Detailed idea |
| P5 outputs | Orchestrator + specialists | If value decision is made: MVP, PRD, and coder brief |

---

## Next Pipeline

When Pipeline 1 completes, the orchestrator automatically gives this message:

```
If the P5 valuation gate is complete, the MVP, PRD, and coder brief are ready. Pass these to the coder.

While the coder develops the MVP, I can help you with:
• Opening social media accounts now
• Preparing a "Coming soon" page
• Email list building strategy

Let me know when the MVP is ready, and let's continue with Pipeline 2 (MVP Launch).
```

When the coder delivers the MVP → **Pipeline 2 (MVP Launch)** starts.

## PersonalAutonomy Execution Rules

- Main output areas: in evaluation ciktilar/ and RAPOR.md; in project 02-arastirma/ and 03-strateji/dogrulama/
- The pipeline does not create its own project or status folder. It keeps the active step in
  DURUM.md and the relevant .pa/*/active-task.md file.
- In an evaluation workspace, it does not apply project-only steps; it does not interpret a
  positive result as authority to create a project.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Records claims requiring current data with source and access date; if data is missing, labels
  the assumption explicitly.
- Obtains explicit user approval at decision gates. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- Places approved final copies under 10-final/ and preserves the working source in place.

Internal operating instructions are in English. The default user-facing language is Turkish.
