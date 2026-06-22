# Pipeline 4: Growth Engine

**Position in chain:** Chain A and D (after P3, when traction is gained).

**When it runs:** When the product, service, business, or B2B sales process gains traction;
when there is a regular flow of users/customers/leads/visitors, or when revenue begins to form.

**Purpose:** To design and implement growth experiments appropriate for the business model to
increase users, customers, leads, visits, repeat purchases, pipeline, or revenue.

**Prerequisite:** Product/service/sales process must be live, with at least initial metrics available.

---

## Pipeline Flow

```
Orchestrator: "Time to grow"
        │
        ▼
[4.1] Analytics Master → Analyze current metrics
        │  Output: buyume-analizi.md
        ▼
[4.2] Growth Hacker → Design growth experiments
        │  Output: buyume-deneyleri.md
        ▼
[4.3] Orchestrator → Present experiments to user, have them select
        │
        ▼
[4.4] Growth Hacker + Campaign Manager → Execute experiments
        │  (Referral program, churn prevention, community, ads)
        ▼
[4.5] Analytics Master → Report experiment results
        │  Output: deney-sonuclari.md
        ▼
[4.6] Orchestrator → Loop decision:
        ├── Successful → scale, design new experiment
        └── Failed → analyze, design new experiment
```

---

## Step Details

### 4.1 — Growth Analysis
**Agent:** Analytics Master
**Input:** Current metrics gathered from user
**Output (`buyume-analizi.md`):**

```markdown
# Büyüme Analizi: [Product]
## AARRR Metrics
| Stage | Metric | Value | Benchmark | Status |
|-------|--------|-------|-----------|--------|
| Acquisition | Downloads/visits | [x] | [x] | |
| Activation | Signup completion | [%] | [%] | |
| Retention | D7/D30 | [%] | [%] | |
| Revenue | ARPU | [₺] | [₺] | |
| Referral | Viral coefficient | [x] | [x] | |

## Growth Opportunities
[Opportunity areas from lowest metric to highest]
```

The metric model is adapted per business:

- B2C digital: visits, signups, activation, retention, ARPU, referral
- B2C physical: contacts, trial/demo, sales, repeat purchase, reviews, coupon/QR conversion
- B2B digital: MQL, SQL, meeting, demo, proposal, won customers, pipeline value
- B2B physical/field: target accounts, visits, meetings, demo days, proposals, channel/partner conversion
- Hybrid: physical contact + digital nurture + sales/retention metrics together

### 4.2 — Growth Experiments
**Agent:** Growth Hacker
**Output (`buyume-deneyleri.md`):**
- For each experiment: hypothesis, impact area, implementation, duration, success criteria, effort
- ICE scoring (Impact, Confidence, Ease)

### 4.3 — Experiment Selection
**Agent:** Orchestrator
**Options presented to user:** At least 3 experiments, with ICE scores. The user selects which ones to implement.

### 4.4 — Experiment Execution
**Agent:** Coordinate Growth Hacker and Campaign Manager playbooks
**Experiment types that can be implemented:**
- Referral program (`referrals` skill)
- Churn prevention campaign (`churn-prevention` skill)
- Community building (`community-marketing` skill)
- Paywall/upgrade CRO (`paywalls` skill)
- Ad optimization (`ads` skill)
- Creative growth ideas (`marketing-ideas` skill)
- B2C physical loyalty, coupon, location, event, and repeat visit experiments
- B2B demo, outbound message, webinar, partner referral, and pipeline acceleration experiments

### 4.5 — Results Report
**Agent:** Analytics Master
**Output (`deney-sonuclari.md`):**
```markdown
# Deney Sonuçları: [Product]
| Experiment | Hypothesis | Duration | Result | Success? | Learned |
|------------|------------|----------|--------|----------|---------|
| ... | ... | [days] | [metric] | ✅/❌ | ... |
```

### 4.6 — Loop Decision
**Agent:** Orchestrator
- Successful experiments → scale, make permanent
- Failed experiments → root cause analysis, pivot
- Design new experiments → return to 4.2

---

## Output Files

| File | Produced by |
|------|-------------|
| `buyume-analizi.md` | Analytics Master |
| `buyume-deneyleri.md` | Growth Hacker |
| `deney-sonuclari.md` | Analytics Master |

---

## Next Step

Pipeline 4 is cyclical. It runs continuously. If needed, it is supported by **Pipeline 6 (Competitor Attack)** or **Pipeline 8 (Outbound Sales)**.

## PersonalAutonomy Execution Rules

- Main output areas: 03-strateji/buyume/, relevant 06-pazarlama-uygulamalari/ folders, and
  08-raporlar/analitik/
- The pipeline does not create its own project or status folder. It keeps the active step in
  DURUM.md and the relevant .pa/*/active-task.md file.
- In project idea-evaluation mode, it does not skip user approval before interpreting a
  positive result as authority to create a project.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Records claims requiring current data with source and access date; if data is missing, labels
  the assumption explicitly.
- Obtains explicit user approval at decision gates. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- Places approved final copies under 10-final/ and preserves the working source in place.

Internal operating instructions are in English. The default user-facing language is Turkish.
