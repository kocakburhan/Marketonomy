# Pipeline 2: MVP Launch

**Position in chain:** Chain A and B (after P1/P5, when coder delivers the MVP).

**When it runs:** When the coder delivers the MVP, the user says "MVP is ready," or a B2B/B2C
digital, physical, or hybrid offering is ready to be brought to market for the first time.

**Purpose:** To create strategy, content, ads, field/channel, and launch plan for marketing the
MVP, physical product, service offering, or B2B sales package.

**Prerequisite:** The thing to be brought to market must be ready: app/web MVP, physical product,
pilot service, B2B demo/proposal package, or event/activation plan. `PROJE.md`, relevant
`01-baglam/` files, and if applicable, `04-urun/prd/` or offering/MVP documents must be present.

---

## Pipeline Flow

```
User: "MVP is ready"
        │
        ▼
[2.1] Orchestrator → Gather MVP details from user
        │  Questions: link, feature list, known bugs, gaps
        ▼
[2.2] Strategy Analyst → MVP-specific marketing strategy
        │  Output: marketing-strategy.md
        ▼
[2.3] Content Creator → Produce launch content
        │  Output: content-calendar.md, social posts, email sequences
        ▼
[2.4] Campaign Manager → Design ad campaign
        │  Output: ad-campaigns.md, ad-creatives.md
        ▼
[2.5] Launch Commander → Create launch checklist
        │  Output: launch-plan.md, launch-checklist.md
        ▼
[2.6] Orchestrator → Present the full plan to user, get approval
        │
        ▼
[2.7] Launch Commander → Start the launch
           (Communicate step-by-step actions to the user)
```

---

## Step Details

### 2.1 — Gathering MVP Details
**Agent:** Orchestrator

```
Can I get the MVP details? What I need:

MANDATORY:
• App/product name
• Go-to-market format: app/web, physical product, service, B2B demo/proposal, event, or hybrid
• Link, point of sale, location, demo path, or proposal file
• What is in the MVP/offering scope? (brief list)
• What features/services/scope are missing? (to be added later)

OPTIONAL (if available):
• What are the known bugs?
• Any notes the coder wants to add?
• First impressions from test users?
```

### 2.2 — Marketing Strategy
**Agent:** Strategy Analyst
**Input:** `current PRD under 04-urun/prd/`, `pazara-giris-stratejisi.md` (if exists), MVP details

**Output (`marketing-strategy.md`):**
```markdown
# Pazarlama Stratejisi: [Product] v1.0
## Target Audience
- Primary segment: ...
- Secondary segment: ...

## Positioning
[1 sentence]

## Launch Channels (prioritized)
1. [channel] — [why, target]
2. ...

## Model Adaptation
- Customer model: [B2B/B2C/Hybrid]
- Channel model: [Digital/Physical/Hybrid]
- Sales motion:
- Required field/digital support:

## Launch Timeline
- D-14: ...
- D-7: ...
- D-Day: ...
- D+7: ...

## Budget Plan
| Item | Budget | Expected Return |
|------|--------|-----------------|
| Ads | ₺xxx | [target] |
| ... | ... | ... |

## Success Metrics
| Metric | 7 days | 30 days | 90 days |
|--------|--------|---------|---------|
| Downloads | [x] | [x] | [x] |
| DAU | [x] | [x] | [x] |
| Revenue | [₺] | [₺] | [₺] |
```

### 2.3 — Launch Content
**Agent:** Content Creator
**Parallel tasks (all can be done simultaneously):**

- 30-day social media calendar with `social_calendar.py`
- App Store / Google Play description (ASO optimized)
- Launch email sequence (email-launch template)
- Landing page copy (if there is a website)
- Social media launch posts
- Promo video script (video skill)
- For physical product/service: poster, brochure, QR/coupon, and field script
- For B2B: demo invitation, meeting message, proposal summary, and LinkedIn/email content

**Outputs:**
- `content-calendar.md`
- `content/social-post-*.md`
- `content/email-launch.md`
- `content/aso-metni.md`

### 2.4 — Ad Campaign
**Agent:** Campaign Manager
**Outputs:**
- `ad-campaigns.md` — platform selection, budget, campaign structure
- `ad-creatives.md` — 3+ variants (for each platform)
- For B2B: `b2b-talep-yaratma-plani.md`
- For physical/hybrid: `fiziksel-b2c-kampanya-plani.md` or field support campaign

### 2.5 — Launch Plan and Checklist
**Agent:** Launch Commander
**Outputs:**
- `launch-plan.md` — launch summary, channels, calendar, metric targets
- `launch-checklist.md` — 8-week detailed checklist (populated from template)

### 2.6 — Approval
**Agent:** Orchestrator

```
📋 LAUNCH PACKAGE READY

Here's what we've prepared for the launch:
• Marketing strategy → [file]
• Content calendar (30 days) → [file]
• Ad campaign → [file]
• Launch plan → [file]

Total estimated budget: ₺xxx

Do you approve? Shall we start the launch?
```

### 2.7 — Launch
**Agent:** Launch Commander
Communicates the step-by-step actions to the user on launch day.

---

## Decision Points

| Step | Decision |
|------|----------|
| 2.6 | Approve / revise launch plan |

---

## Output Files

| File | Produced by |
|------|-------------|
| `marketing-strategy.md` | Strategy Analyst |
| `content-calendar.md` | Content Creator |
| `content/social-post-*.md` | Content Creator |
| `content/email-launch.md` | Content Creator |
| `content/aso-metni.md` | Content Creator |
| `ad-campaigns.md` | Campaign Manager |
| `ad-creatives.md` | Campaign Manager |
| `launch-plan.md` | Launch Commander |
| `launch-checklist.md` | Launch Commander |
| Physical/B2B support materials | Relevant specialists |

---

## Next Pipeline

2-4 weeks after launch → **Pipeline 3 (Feedback & Improvement)** starts. Or when the user says
"let's start collecting feedback."

## PersonalAutonomy Execution Rules

- Main output areas: 07-lansman/ and relevant 06-pazarlama-uygulamalari/ folders
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
