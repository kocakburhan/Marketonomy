# Pipeline 5: From Existing Idea to MVP and PRD (Idea to PRD)

**Position in the chain:** Starting point for Chain B or the hard evaluation step for an idea produced in P1.

**When it runs:** When the user already has an idea in mind and wants to test "is it worth trying?"
and if valuable, convert it to MVP and PRD.

**Goal:** Confront the existing idea with market data, competitor reality, customer pain, buyer
evidence, differentiation, revenue potential, feasibility, and MVP cost. Only if a "worth it" decision emerges,
produce first the MVP document, then the PRD and coder brief based on this MVP.

**Prerequisite:** The user must have a concrete idea and be working inside a project workspace with `PROJE.md` and `.pa/project/state.json`. The pipeline may start as pure idea evaluation inside the project; MVP, PRD, and coder brief are produced only after the user approves the decision direction.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Idea Value Comes First

Aslolan fikirdir. Marketerlar yetenekli, akli basinda ve network sahibi insanlar olarak kabul
edilir. Bu pipeline'in ilk gorevi marketer'i elemek degil, fikrin pazar acisindan yeterli
olup olmadigini anlamaktir.

Idea value is decided from market pain, buyer urgency, willingness to pay, alternative behavior,
competitor reality, differentiation, timing, feasibility, and risk.

Marketer fit is Marketer uygulama rehberligi. It can change the recommended validation route,
confidence cautions, mentor/partner needs, first customer path, channel choice, and budget
posture. It is verdict degildir and must not by itself turn a valuable idea into
`Denenmeye Degmez`.

---

## Core Attitude

In this pipeline, the agent does not act like an encouraging coach. The agent's job is to challenge
the idea realistically, not hide weak signals, and bring it to a more testable form together with
the user.

The pipeline exists to stop premature building. It is better to reject, narrow, or test cheaply
than to let the coder spend months on a product whose market, buyer, distribution channel, or
willingness to pay is not proven.

Rules:

1. Do not use unsourced positive language like "nice idea", "it has potential", "it could be worth trying".
2. If the idea is weak, say so directly; explain the reason with market, buyer, differentiation,
   economics, feasibility, or risk evidence. Marketer fit is not an idea-value rejection reason.
3. Take the user's experience seriously but do not count it as sole evidence. Weigh it together with research outputs.
4. If marketer fit is weak, give cautious guidance and recommend experienced advice, a partner,
   mentor, specialist, or channel support. Never change the idea-value verdict for this reason alone.
5. If you see a better target audience, niche, channel, pricing model, or MVP scope, freely suggest a revision.
6. Do not produce MVP, PRD, or coder brief before the user explicitly approves the final idea and decision direction.
7. Do not treat `PROJE.md`, a user request for a PRD, or an available coder as validation. Market
   evidence and a sales-motion-appropriate validation path must still be present.

---

## Pipeline Flow

```text
User: "I have an idea"
        |
        v
[5.1] Orchestrator -> Collect the idea and product type
        |
        v
[5.2] Market Scout -> Research market, competitors, alternatives, buyer pain, willingness to pay, timing, feasibility, and risk
        |  Output: pazar-arastirmasi.md
        v
[5.3] Strategy Analyst -> Decide idea value
        |  Output: fikir-dogrulama.md
        v
[5.4] Orchestrator -> Realist decision discussion: WORTH / REVISION / NOT WORTH
        |
        +-- "Denenmeye Degmez" -> Close the report, explain why, optionally suggest a narrower/revised idea, do not produce PRD
        |
        +-- "Revizyonla Denenmeye Deger" -> Revise the idea with the user -> Return to [5.2]
        |
        +-- "Denenmeye Deger" ->
                 v
            [5.5] Orchestrator -> Marketer execution guidance
                 |  Output: marketer-uygulama-rehberligi.md
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
```

## Workspace Output Path Rules

### Project Workspace Output Paths`r`n`r`nUse these paths inside the project workspace:

| Output | Path |
|---|---|
| Idea-evaluation evidence | `02-arastirma/fikir-degerlendirme/` |`r`n| Market and competitor research | `02-arastirma/fikir-degerlendirme/pazar-rakip-kanitlari.md` |
| Idea value decision | `03-strateji/dogrulama/fikir-dogrulama.md` |
| Marketer execution guidance | `03-strateji/dogrulama/marketer-uygulama-rehberligi.md` |
| MVP | `04-urun/fikir-ozetleri/mvp.md` |
| PRD | `04-urun/prd/prd.md` |
| Coder brief | `04-urun/coder-briefleri/coder-brief.md` |
| Operational status | `DURUM.md` and `.pa/project/active-task.md` |

### Marketer Execution Guidance

This section is not the idea-value verdict. It guides how this marketer should approach
execution after the idea-value decision is made or while a low-cost validation test is being
designed.

If the marketer has strong fit, encourage them to use that advantage directly: network, city,
sector access, existing customer access, audience, sales skill, budget, speed, or channel
leverage.

If the marketer has weak fit, do not reject the idea for that reason alone. Recommend a cautious
execution path: sector conversations, mentor or partner support, expert interviews, customer
discovery, local validation, small budget test, or narrowing to a reachable segment.

### Marketer Fit Guidance is not the idea-value verdict

Marketer fit can affect the recommended validation route, channel support, mentor/partner need,
budget caution, and execution risk. It must never turn an otherwise valuable idea into
`Denenmeye Degmez` by itself.

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
7. Optional for later execution guidance: what customer access, network, sector knowledge, time,
   or budget do you already have for testing this idea?

Do not try to complete the idea on vague answers; explicitly list missing assumptions.

### 5.2 — Market Research
**Agent:** Market Scout

Collect data from the right sources based on the product type:

- Mobile app: if active mcp-appstore, App Store, Google Play, reviews, keyword/ASO signals
- SaaS/web app: with active Codex web/Browser/Chrome tool, G2, Capterra, Product Hunt, Reddit,
  Hacker News, Trustpilot, competitor sites
- Physical business: Google Maps/GBP, Şikayetvar, local search results, sector forums
- E-commerce: marketplace reviews, price comparison, category trends
- All: Google Trends, news, reports, social proof, user communities

**Output format:** use the workspace-specific market research path from `Workspace Output Path Rules`.

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

### 5.3 — Idea Validation
**Agent:** Strategy Analyst

Evaluate `pazar-arastirmasi.md` and the user's idea together. If research is missing or too
shallow, return to [5.2] instead of scoring from assumptions. Marketer execution guidance
is not an input to the idea-value score.

**Output format:** use the workspace-specific path from `Workspace Output Path Rules`.

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
| Validation path for the sales motion | ... | ... | ... |
| Cost/risk level | ... | ... | ... |
| Timing | ... | ... | ... |
| **Total** | **.../100** | | |

## Decision
- Recommendation: [Denenmeye Değer / Revizyonla Denenmeye Değer / Denenmeye Değmez]
- Rationale:
- Mandatory revisions to proceed:
- If there is a reason to abandon:
```

### Idea Value Decision

Decision threshold:

- `Denenmeye Değer`: total score should generally be 70/100 and above; problem pain, buyer,
  differentiation, economics, and a credible validation path should not be individually weak.
- `Revizyonla Denenmeye Değer`: there is signal in the idea but target audience, channel, scope,
  pricing, differentiation, or validation design is not clear.
- `Denenmeye Değmez`: if pain is weak, no buyer or budget exists, there is no competitive
  differentiation, MVP cost is high, the revenue path is unrealistic, or a fatal legal/operational
  blocker exists. Marketer fit alone can never produce this verdict.

### Validation Unit By Sales Motion

- B2C/self-service: typically 10-50 target users or equivalent behavioral tests.
- SMB B2B: typically 3-10 buyer conversations, pilots, or credible commitments.
- Enterprise/high-ticket/regulated: typically 1-3 design partners or budget-owner commitments.
- Physical/local: a defined number of visits, trials, orders, or repeat purchases.
- Marketplace: separate supply-side and demand-side thresholds.

Treat these as planning defaults. Adapt the threshold to price, cycle length, risk, and evidence
quality; do not use one universal count as an automatic verdict rule.

Hard stop conditions before PRD/coder brief:

- No credible path to reach an appropriate validation unit for the sales motion.
- No evidence of painful or costly demand.
- No buyer or budget owner is identifiable.
- Competitors already solve the problem well and no sharp differentiation exists.
- MVP cost or implementation time is high relative to the validation signal.
- A fatal legal, operational, safety, or economic blocker makes even a bounded test unreasonable.

### 5.4 — Realist Decision Discussion
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

Separate marketer-fit guidance:
- ...

Your decision:
1. Proceed as is
2. Re-evaluate with this revision
3. Abandon
```

Even if the user says "proceed", if the agent sees a fatal risk, restate it and write the risk to
`KARARLAR.md` or the evaluation report before moving to PRD.

### 5.5 — Marketer Execution Guidance
**Agent:** Orchestrator

Marketer execution guidance is produced after the idea-value decision. It is execution
guidance, not the idea-value verdict. If the idea is `Denenmeye Deger` or
`Revizyonla Denenmeye Deger`, the marketer profile is used to recommend the validation
route, channel, and validation unit, not to reject the idea. If marketer fit is strong, show
how to use it directly. If marketer fit is weak, recommend a cautious path: sector
conversations, mentor or partner support, expert interviews, customer discovery, local
validation, small budget test, or narrowing to a reachable segment.

Discuss marketer fit separately from the idea-value score and verdict. This is guidance between
Marketing Agent and the marketer, not a rejection gate:

- Strong fit: show how the marketer can use sector knowledge, network, credibility, location, or
  channel access.
- Partial fit: recommend the missing capability, channel, partner, mentor, or specialist support.
- Weak fit: recommend caution and getting advice from experienced people before a high-cost move.

Never change `Denenmeye Değer` to `Denenmeye Değmez` because the current marketer lacks experience,
network, audience, or a direct distribution channel.

Collect the following from the user:

1. City/country of residence and relationship with the target market
2. Field of work, sector, and professional experience
3. Knowledge base or personal expertise related to the topic
4. Network: accessible customer, institution, community, influencer, channel, or decision-maker circles
5. Existing audience: email list, social media, community, customer portfolio, store traffic
6. Sales and marketing experience
7. How they can reach the sales-motion-appropriate validation unit
8. Weekly time capacity and trial budget
9. City, language, culture, regulation, or operational advantage/disadvantage

**Output format:** use the workspace-specific path from `Workspace Output Path Rules`.

```markdown
# Marketer Execution Guidance: [Idea]
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

### 5.6 — MVP Writing
**Agent:** Product Architect

Project workspace only.

Runs only after the approved value decision inside the same project workspace. If the decision is not worth trying, stop with `03-strateji/dogrulama/fikir-dogrulama.md`, record the reason in `KARARLAR.md`, and do not produce MVP, PRD, or coder brief.

The MVP is the minimum testable product definition of the idea; it is not a feature pile.

If the decision was `Revizyonla Denenmeye Değer`, the MVP must be based on the revised idea, not
the original unfiltered version. If the decision was `Denenmeye Değmez`, this step must not run.

**Output:** `04-urun/fikir-ozetleri/mvp.md`

The MVP must include:

- Final idea definition
- Target user and first segment to reach
- Sales-motion-appropriate validation path
- Main problem solved
- Single core promise of the MVP
- Must-have features
- Out-of-scope items
- If there is a first manual/concierge trial path
- Success metrics
- Plan to reach the selected validation unit
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
| User profile | Used for marketer guidance | Never changes the idea-value verdict by itself |
| Research | For opportunity discovery | To kill, revise, or validate the idea |
| Decision | Opportunity selection | Worth trying / revision / not worth |
| MVP | If the idea becomes clear | Only after value decision |
| PRD | After MVP/idea brief | After approved MVP |

---

## Output Files

### Project Workspace`r`n`r`n| File | Produced By | Description |
|-------|--------|----------|
| `02-arastirma/fikir-degerlendirme/pazar-rakip-kanitlari.md` | Market Scout | Competitor, trend, customer signal |
| `03-strateji/dogrulama/fikir-dogrulama.md` | Strategy Analyst | Hard score, risk, and decision |
| `03-strateji/dogrulama/marketer-uygulama-rehberligi.md` | Orchestrator | Marketer execution guidance, not verdict |
| `04-urun/fikir-ozetleri/mvp.md` | Product Architect | Approved MVP definition |
| `04-urun/prd/prd.md` | Product Architect | PRD based on MVP |
| `04-urun/coder-briefleri/coder-brief.md` | Product Architect | Implementable summary for coder |
| `DURUM.md` and `.pa/project/active-task.md` | Orchestrator | Operational status |

---

## PersonalAutonomy Execution Rules

- Main output areas: 02-arastirma/, 03-strateji/dogrulama/, and 04-urun/
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and `.pa/project/active-task.md`.
- Idea evaluation, validation, MVP, PRD, and coder brief all stay inside the same project workspace.
- Do not produce MVP, PRD, or coder brief until the idea-value decision and MVP direction are approved by the user.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Record claims requiring current data with source and access date; if data is missing, explicitly
  label the assumption.
- Obtain explicit user approval at decision gates. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- Copy approved final copies under 10-final/ and preserve the working source in place.
