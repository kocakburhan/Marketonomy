# Pipeline 5: From Existing Idea to MVP and PRD (Idea to PRD)

**Position in the chain:** Starting point for Chain B or the hard evaluation step for an idea produced in P1.

**When it runs:** When the user already has an idea in mind and wants to test "is it worth trying?"
and if valuable, convert it to MVP and PRD.

**Goal:** Confront the existing idea with user advantage, market data, competitor reality, customer
pain, distribution channel, revenue potential, and MVP cost. Only if a "worth it" decision emerges,
produce first the MVP document, then the PRD and coder brief based on this MVP.

**Prerequisite:** The user must have a concrete idea. In a project workspace, `PROJE.md` and the relevant
`01-baglam/` files must be created. If working in an evaluation workspace, this pipeline does not produce
a PRD; the decision report stays under `RAPOR.md` and `ciktilar/`.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Core Attitude

In this pipeline, the agent does not act like an encouraging coach. The agent's job is to challenge
the idea realistically, not hide weak signals, and bring it to a more testable form together with
the user.

Rules:

1. Do not use unsourced positive language like "nice idea", "it has potential", "it could be worth trying".
2. If the idea is weak, say so directly; explain the reason with market, distribution, cost, or user advantage.
3. Take the user's experience seriously but do not count it as sole evidence. Weigh it together with research outputs.
4. If the user cannot market the idea, this alone may result in a "not worth it" or "revision required" decision.
5. If you see a better target audience, niche, channel, pricing model, or MVP scope, freely suggest a revision.
6. Do not produce MVP, PRD, or coder brief before the user explicitly approves the final idea and decision direction.

---

## Pipeline Flow

```text
User: "I have an idea"
        |
        v
[5.1] Orchestrator -> Collect the idea and product type
        |
        v
[5.2] Orchestrator -> Extract user profile and marketing advantage
        |  Output: kullanici-pazarlama-avantaji.md
        v
[5.3] Market Scout -> Research market, competitors, trends, and customer signals
        |  Output: pazar-arastirmasi.md
        v
[5.4] Strategy Analyst -> Score the idea against "is it worth trying?" criteria
        |  Output: fikir-dogrulama.md
        v
[5.5] Orchestrator -> Realist decision discussion: WORTH / REVISION / NOT WORTH
        |
        +-- "Denenmeye Değmez" -> Close the report, write the reason, do not produce PRD
        |
        +-- "Revizyonla Denenmeye Değer" -> Revise the idea with user -> Return to [5.2]
        |
        +-- "Denenmeye Değer" ->
                 v
            [5.6] Product Architect -> Write MVP from the approved final idea
                 |  Output: 04-urun/fikir-ozetleri/mvp.md
                 v
            [5.7] Orchestrator -> Get MVP scope approved by user
                 v
            [5.8] Product Architect -> Write PRD based on approved MVP
                 |  Output: 04-urun/prd/prd.md
                 v
            [5.9] Product Architect -> Prepare coder brief
                 |  Output: 04-urun/coder-briefleri/coder-brief.md
                 v
            [5.10] Orchestrator -> Direct user to forward MVP and PRD files to coder
```

---

## Step Details

### 5.1 — Idea Collection
**Agent:** Orchestrator

Collect the following information from the user:

1. Describe the idea in 3-5 sentences.
2. What problem does this idea solve?
3. For whom is the problem painful or costly?
4. Where did this idea come from: personal need, business observation, customer demand, competitor gap, or another source?
5. What is the product type: mobile app, SaaS, physical business, e-commerce, service, content, hybrid?
6. Which competitors or alternative solutions do you know?
7. Why can you execute this idea?

Do not try to complete the idea on vague answers; explicitly list missing assumptions.

### 5.2 — User Marketing Advantage
**Agent:** Orchestrator

Measure the marketability of the idea specifically for the user. Collect the following from the user:

1. City/country of residence and relationship with the target market
2. Field of work, sector, and professional experience
3. Knowledge base or personal expertise related to the topic
4. Network: accessible customer, institution, community, influencer, channel, or decision-maker circles
5. Existing audience: email list, social media, community, customer portfolio, store traffic
6. Sales and marketing experience
7. How they can reach the first 10-50 users
8. Weekly time capacity and trial budget
9. City, language, culture, regulation, or operational advantage/disadvantage

**Output format (`03-strateji/dogrulama/kullanici-pazarlama-avantaji.md`):**

```markdown
# User Marketing Advantage: [Idea]
- Date: [date]

## User Profile
- City/country:
- Field of work:
- Sector knowledge:
- Sales/marketing experience:
- Time capacity:
- Trial budget:

## Distribution Assets
| Asset | Strength | Evidence | Risk |
|--------|-----|-------|------|
| Network | [low/medium/high] | ... | ... |
| Existing audience | ... | ... | ... |
| First user access | ... | ... | ... |

## Marketability Score
| Criterion | Score (1-10) | Rationale |
|--------|-------------|---------|
| Target audience access | ... | ... |
| Sector credibility | ... | ... |
| First sales/acquisition channel | ... | ... |
| Local/cultural advantage | ... | ... |
| Execution capacity | ... | ... |
| **Total** | **.../50** | |

## Conclusion
- User's marketing advantage for this idea:
- Critical gap:
- Revision suggestion if needed:
```

### 5.3 — Market Research
**Agent:** Market Scout

Collect data from the right sources based on the product type:

- Mobile app: if active mcp-appstore, App Store, Google Play, reviews, keyword/ASO signals
- SaaS/web app: with active Codex web/Browser/Chrome tool, G2, Capterra, Product Hunt, Reddit,
  Hacker News, Trustpilot, competitor sites
- Physical business: Google Maps/GBP, Şikayetvar, local search results, sector forums
- E-commerce: marketplace reviews, price comparison, category trends
- All: Google Trends, news, reports, social proof, user communities

**Output format (`02-arastirma/pazar-arastirmasi/pazar-arastirmasi.md`):**

```markdown
# Market Research: [Idea]
- Date: [date]

## Kaynak ve Kanıt Defteri
| ID | Araç | Kaynak | Erişim tarihi | Kullanılan veri | Güven |
|----|------|--------|---------------|-----------------|-------|

## Market and Demand Signals
- Problem frequency:
- Willingness to pay:
- Trend direction:
- Existing alternatives:

## Competitor List
| Competitor | Type | Strength | Weakness | Price/Revenue Model | Evidence |
|-------|-----|-----------|-----------|--------------------|-------|

## Customer Signals
- Most common complaints:
- Unresolved expectations:
- Problem in users' own words:

## Veri İşleme Notları
- Ham veri:
- Normalize edilen alanlar:
- Varsayımlar:
- Eksik veya erişilemeyen veri:
```

### 5.4 — Idea Validation
**Agent:** Strategy Analyst

Evaluate `pazar-arastirmasi.md`, `kullanici-pazarlama-avantaji.md`, and the user's idea together.

**Output format (`03-strateji/dogrulama/fikir-dogrulama.md`):**

```markdown
# Idea Validation: [Idea]
- Date: [date]
- Inputs used: [file references]

## Hard Evaluation Summary
- Strongest evidence:
- Weakest point:
- Is there a fatal risk:
- Agent's clear view:

## Evaluation Criteria
| Criterion | Score (1-10) | Evidence | Comment |
|--------|-------------|-------|-------|
| Problem pain | ... | ... | ... |
| Target audience clarity | ... | ... | ... |
| Market/demand signal | ... | ... | ... |
| Competitive differentiation | ... | ... | ... |
| Revenue potential | ... | ... | ... |
| MVP feasibility | ... | ... | ... |
| User's marketing advantage | ... | ... | ... |
| Access to first 10-50 users | ... | ... | ... |
| Cost/risk level | ... | ... | ... |
| Timing | ... | ... | ... |
| **Total** | **.../100** | | |

## Decision
- Recommendation: [Denenmeye Değer / Revizyonla Denenmeye Değer / Denenmeye Değmez]
- Rationale:
- Mandatory revisions to proceed:
- If there is a reason to abandon:
```

Decision threshold:

- `Denenmeye Değer`: total score should generally be 70/100 and above; problem pain, marketing
  advantage, and first user access should not be individually weak.
- `Revizyonla Denenmeye Değer`: there is signal in the idea but target audience, channel, scope,
  pricing, or user advantage is not clear.
- `Denenmeye Değmez`: if pain is weak, user cannot reach the target audience, there is no
  competitive differentiation, MVP cost is high, or the revenue path is unrealistic.

### 5.5 — Realist Decision Discussion
**Agent:** Orchestrator

Speak to the user briefly and clearly:

```text
Validation result: [Denenmeye Değer / Revizyonla Denenmeye Değer / Denenmeye Değmez]
Why:
1. ...
2. ...
3. ...

My pragmatic recommendation:
- [Proceed / proceed with this revision / abandon]

Critical fact regarding user advantage:
- ...

Your decision:
1. Proceed as is
2. Re-evaluate with this revision
3. Abandon
```

Even if the user says "proceed", if the agent sees a fatal risk, restate it and write the risk to
`KARARLAR.md` or the evaluation report before moving to PRD.

### 5.6 — MVP Writing
**Agent:** Product Architect

Runs only after the approved value decision. The MVP is the minimum testable product definition of
the idea; it is not a feature pile.

**Output:** `04-urun/fikir-ozetleri/mvp.md`

The MVP must include:

- Final idea definition
- Target user and first segment to reach
- User's distribution advantage and first user acquisition path
- Main problem solved
- Single core promise of the MVP
- Must-have features
- Out-of-scope items
- If there is a first manual/concierge trial path
- Success metrics
- Plan to reach first 10-50 users
- Biggest risks and test plan

### 5.7 — MVP Approval
**Agent:** Orchestrator

Discuss the MVP scope with the user. If the scope inflates, narrow it ruthlessly. Do not write the
PRD before the user explicitly approves the MVP.

### 5.8 — PRD Writing
**Agent:** Product Architect

Produce a PRD based on the approved MVP. The PRD cannot add new strategic features not in the MVP;
if needed, first revise the MVP.

**Output:** `04-urun/prd/prd.md`

### 5.9 — Coder Brief
**Agent:** Product Architect

Extract an implementable brief for the coder from the PRD.

**Output:** `04-urun/coder-briefleri/coder-brief.md`

### 5.10 — Directing to Coder
**Agent:** Orchestrator

Give the user this clear direction:

```text
MVP and PRD are ready.

Forward the following files to the coder:
- 04-urun/fikir-ozetleri/mvp.md
- 04-urun/prd/prd.md
- 04-urun/coder-briefleri/coder-brief.md

The coder can read these files and extract the technical plan and implementation scope.
```

---

## Difference Between P1 and P5

| Feature | P1 (Idea Discovery) | P5 (Existing Idea Evaluation) |
|---------|------------------|-------------------------------|
| Starting point | No idea | Has an idea |
| First task | Generate opportunities | Test the idea against hard reality |
| User profile | Used for interest area | Scored as marketing advantage |
| Research | For opportunity discovery | To kill, revise, or validate the idea |
| Decision | Opportunity selection | Worth trying / revision / not worth |
| MVP | If the idea becomes clear | Only after value decision |
| PRD | After MVP/idea brief | After approved MVP |

---

## Output Files

| File | Produced By | Description |
|-------|--------|----------|
| `03-strateji/dogrulama/kullanici-pazarlama-avantaji.md` | Orchestrator | User's idea marketing power |
| `02-arastirma/pazar-arastirmasi/pazar-arastirmasi.md` | Market Scout | Competitor, trend, customer signal |
| `03-strateji/dogrulama/fikir-dogrulama.md` | Strategy Analyst | Hard score, risk, and decision |
| `04-urun/fikir-ozetleri/mvp.md` | Product Architect | Approved MVP definition |
| `04-urun/prd/prd.md` | Product Architect | PRD based on MVP |
| `04-urun/coder-briefleri/coder-brief.md` | Product Architect | Implementable summary for coder |

In an evaluation workspace, corresponding working files are kept under `ciktilar/`, and the final
synthesis is kept in `RAPOR.md`.

---

## PersonalAutonomy Execution Rules

- Main output areas: 02-arastirma/, 03-strateji/dogrulama/, and 04-urun/
- The pipeline does not create its own project or status folder. It keeps the active step in
  DURUM.md and the relevant .pa/*/active-task.md file.
- In an evaluation workspace, it does not apply project-only steps; it does not interpret a positive
  result as authorization to create a project.
- In an evaluation workspace, do not produce MVP, PRD, and coder brief as final delivery; these are
  written in a project workspace after the approved value decision.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Record claims requiring current data with source and access date; if data is missing, explicitly
  label the assumption.
- Obtain explicit user approval at decision gates. Producing a file does not complete a weekly task.
- Copy approved final copies under 10-final/ and preserve the working source in place.
