# Pipeline 1: Data-Driven Idea Discovery

**Position in chain:** Chain A first step. When a concrete idea is produced and approved for
evaluation, transition to `pipelines/idea-to-prd.md`.

**When it runs:** When the user says "fikir bulalim", "bana fikir bul", "hangi isi yapalim",
"app fikri bulalim", or when the user has no concrete idea yet.

**Purpose:** Help a non-marketing expert find realistic, data-backed opportunities with the
marketer. The agent must not brainstorm from taste alone. It must collect evidence, identify
pain, compare competitors, score user advantage, and turn only the strongest opportunities into
testable ideas.

**Prerequisite:** In an evaluation workspace, `DEGERLENDIRME.md` and workspace state must exist.
In a project workspace, `PROJE.md` and relevant `01-baglam/` files must exist. If the user is
only exploring before a workspace is ready, write a draft plan and list required setup steps.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Core Rule

Idea discovery is a research and decision process:

```text
source data
  -> evidence ledger
  -> pain / demand / trend / competitor gap
  -> user segment
  -> willingness-to-pay signal
  -> user's marketing advantage
  -> opportunity score
  -> testable idea
  -> first validation test
```

Do not present an idea as promising unless the evidence, user advantage, and first test path are
visible. If data is weak, label the idea as `Dusuk guven`, `Varsayim`, or `Tahmin`.

---

## Pipeline Flow

```text
User enters with no idea
        |
        v
[1.1] Orchestrator -> Collect discovery frame and user constraints
        | Output: fikir-kesif-cercevesi.md
        v
[1.2] Orchestrator -> Select one or more opportunity pipelines
        | Store / Complaint / Competitor Gap / Trend / User Advantage
        v
[1.3] Market Scout -> Run source-specific data collection
        | Outputs: raw source notes + normalized research files
        v
[1.4] Strategy Analyst -> Score opportunities
        | Output: firsat-skorlari.md
        v
[1.5] Orchestrator -> Discuss 3-5 opportunity candidates with user
        | User selects / asks for more research / rejects
        v
[1.6] Product Architect -> Convert selected opportunity into idea brief
        | Output: idea-brief.md
        v
[1.7] Orchestrator -> Pragmatic idea discussion and revision
        | User approves final idea for valuation / revises / cancels
        v
[1.8] Orchestrator -> Start P5 valuation gate
        | `pipelines/idea-to-prd.md`
```

---

## 1.1 Discovery Frame

Ask only what is needed to start. If the user says "bilmiyorum", continue with a broad scan.

Minimum inputs:

1. Desired product type: mobile app, SaaS, local business, e-commerce, service, content, or "open".
2. Market geography: TR, US, global English, local city, or "open".
3. User constraints: budget, weekly time, coding access, language, and preferred channels.
4. User advantage hints: sector, city, network, audience, communities, sales access.
5. Exclusions: sectors, regulated areas, or business types the user does not want.

Output file:

- Evaluation workspace: `ciktilar/fikir-kesif-cercevesi.md`
- Project workspace: `03-strateji/dogrulama/fikir-kesif-cercevesi.md`

---

## 1.2 Opportunity Pipeline Selection

Select pipelines based on the discovery frame:

| Situation | Pipeline |
|---|---|
| Mobile app ideas, app-store monetization, review gaps | `pipelines/store-intelligence.md` |
| User pain, complaints, forums, Reddit, review mining | `pipelines/complaint-mining.md` |
| Known competitors or crowded category | `pipelines/competitor-gap.md` |
| Trend, news, rising topic, product category exploration | `pipelines/trend-to-product.md` |
| Any idea must be checked against the user's actual access | `pipelines/user-advantage-fit.md` |

For broad discovery, run at least three perspectives:

1. `store-intelligence` if mobile apps are allowed.
2. `complaint-mining` for pain discovery.
3. `trend-to-product` or `competitor-gap` depending on whether the user starts from a trend or a
   known category.
4. Always run `user-advantage-fit` before recommending a final idea.

---

## 1.3 Source Collection Rules

Use Codex's active research tools:

- Official web search for current source discovery and public pages.
- Browser or Chrome for dynamic pages, visible UI inspection, session-dependent pages, and local
  verification.
- Playwright/browser automation only when structured/public endpoints or simpler page fetches are
  insufficient and the page can be accessed without bypassing controls.
- MCP only when visible in the active tool list.
- Scripts and manual user exports when web tools are unavailable or rate-limited.

All research files must include:

```markdown
## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

---

## 1.4 Opportunity Scoring

Each candidate receives a score. Do not hide weak scores.

```markdown
## Opportunity Score
| Criterion | Score (1-5) | Evidence | Note |
|---|---:|---|---|
| Problem severity | | | |
| Willingness-to-pay signal | | | |
| Competitor gap | | | |
| Trend / timing signal | | | |
| MVP feasibility | | | |
| User marketing advantage | | | |
| First 10-50 user access | | | |
| Data confidence | | | |
| **Total** | **/40** | | |
```

Decision guidance:

- `30-40`: strong candidate, can move to idea brief if no fatal risk exists.
- `22-29`: revise or narrow before idea brief.
- `<22`: do not recommend unless the user explicitly wants a speculative experiment.

---

## 1.5 User Discussion

Present 3-5 candidates in plain Turkish:

```text
Data ile one cikan firsatlar:
1. [Opportunity] - neden: [evidence], risk: [risk], skor: [x/40]
2. ...

Benim pragmatik onerim:
- Once [X] firsatini derinlestirelim, cunku [reason].

Karar:
1. X firsatindan fikir uret
2. Y firsatini derinlestir
3. Daha fazla kaynak tara
4. Bu yonu kapat
```

Do not move to MVP or PRD here. First convert the opportunity to an idea brief, then pass it to
the hard valuation gate.

---

## 1.6 Idea Brief

Output:

- Evaluation workspace: `ciktilar/idea-brief.md`
- Project workspace: `04-urun/fikir-ozetleri/idea-brief.md`

Required sections:

```markdown
# Idea Brief: [Name]
- Date:
- Source opportunity:
- Data confidence: High / Medium / Low

## Evidence Summary
- Strongest data:
- Weakest assumption:
- User pain:
- Willingness-to-pay signal:
- Competitor gap:

## Target User
- Segment:
- Situation:
- Existing alternative:
- Why now:

## Proposed Product
- Core promise:
- MVP scope:
- Out of scope:
- Revenue hypothesis:

## First Validation Test
- How to reach first 10-50 users:
- What to test:
- Success metric:
- Stop condition:

## Risks
- Market risk:
- Acquisition risk:
- Product risk:
- Data gap:
```

---

## 1.7 Transition to P5

After the user approves the idea brief, treat the idea as a ready idea and start
`pipelines/idea-to-prd.md`. The P5 gate may still decide:

- `Denenmeye Deger`
- `Revizyonla Denenmeye Deger`
- `Denenmeye Degmez`

The agent must not consider a generated idea validated merely because it was produced by this
pipeline.

---

## Output Files

| File | Produced by | Evaluation path | Project path |
|---|---|---|---|
| `fikir-kesif-cercevesi.md` | Orchestrator | `ciktilar/` | `03-strateji/dogrulama/` |
| Source research files | Market Scout | `ciktilar/` | `02-arastirma/` |
| `firsat-skorlari.md` | Strategy Analyst | `ciktilar/` | `03-strateji/dogrulama/` |
| `idea-brief.md` | Product Architect | `ciktilar/` | `04-urun/fikir-ozetleri/` |

---

## PersonalAutonomy Execution Rules

- Main output areas: in evaluation `ciktilar/` and `RAPOR.md`; in project `02-arastirma/`,
  `03-strateji/dogrulama/`, and `04-urun/fikir-ozetleri/`.
- Preserve raw source notes separately from normalized summaries.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- In an evaluation workspace, do not produce final PRD, coder brief, weekly project plan, or
  project-only folders.
- In a project, `PROJE.md`, relevant `01-baglam/` files, and `KARARLAR.md` are prerequisites.
- Record claims requiring current data with source and access date; if data is missing, label the
  assumption explicitly.
- Obtain explicit user approval at decision gates. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- Copy approved final copies under `10-final/` and preserve the working source in place.
