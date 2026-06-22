# Pipeline 3: Feedback & Improvement

**Position in chain:** Chain A, B, and C (after P2 or P9). Cyclical — repeats as P3 → P5 or P3 → P9.

**When it runs:**
- 2-4 weeks after launch
- When the user says "let's collect feedback"
- In every improvement cycle

**Purpose:** Analyze user, customer, lead, sales, field, and campaign feedback to identify
improvement areas. If needed, produces an updated PRD for the coder; for physical, B2B, or
campaign processes, updates the offering, materials, sales script, channel strategy, or
operations plan.

**Prerequisite:** The product, service, campaign, or sales process must have been in contact with
users/customers/leads.

---

## Pipeline Flow

```
Orchestrator: "Time to collect feedback"
        │
        ▼
[3.1] Orchestrator → Request basic metrics from user
        │  Questions: downloads, reviews, revenue, visitors, social media engagement
        ▼
[3.2] Market Scout → Analyze user reviews
        │  Sources: App Store, Google Play, Google Maps, forums, social media
        │  Output: yorum-analizi.md
        ▼
[3.3] Analytics Master → Perform metric analysis
        │  Output: analytics-raporu.md
        ▼
[3.4] Strategy Analyst → Identify improvement areas
        │  Output: iyilestirme-onerileri.md
        ▼
[3.5] Orchestrator → Present findings to user, ask for priorities
        │
        ▼
[3.6] Orchestrator → Select improvement type
        │  If product/technical: Product Architect → prd-v2.md
        │  If marketing/field/sales: relevant specialist → revision files
        ▼
[3.7] Orchestrator → Prepare implementation brief
           Output: coder-brief-v2.md or pazarlama-iyilestirme-briefi.md
```

---

## Step Details

### 3.1 — Metric Collection
**Agent:** Orchestrator

```
📊 Time to collect post-launch data!

Can you send me the following data?

From App Store / Google Play:
• Total download count
• Daily active users (if available)
• Average rating and review count
• Revenue in the last 30 days (if available)

From the website (if any):
• Visitor count
• Conversion rate

From social media:
• Post engagement
• Follower count

From users:
• Incoming emails/messages (summary)
• Verbal feedback from test users

From physical/field campaign:
• How many people were contacted?
• How many demos/tastings/trials occurred?
• How many sales/appointments/WhatsApp conversions?
• Which location/day/time worked?
• Which poster/brochure/coupon/message didn't work?

From B2B sales:
• How many target accounts were contacted?
• Response, meeting, demo, proposal, and win counts
• Top objections
• Which segment/channel performed better?

(You can also request some of this data from the coder — they may have access to dashboards)
```

### 3.2 — User Review Analysis
**Agent:** Market Scout
**Optional capabilities:**
- `fetch_reviews(appId, platform, sort="rating", num=500)` → pull raw low-rated reviews
- `analyze_reviews(appId, platform, num=500)` → sentiment distribution, keyword frequency, common themes, top negative keywords
- Physical business: Google Maps/GBP reviews + Şikayetvar/forums with active Codex web/Browser/Chrome tool

**Action:**
- App Store/Google Play reviews -> `pipelines/store-intelligence.md`; use mcp-appstore only if it is visible in the active Codex tool list
- Google Maps/GBP reviews → **active Codex web/Browser/Chrome tool**
- Social media mentions → **active Codex web/Browser/Chrome tool**
- Forum/complaint site reviews → **active Codex web/Browser/Chrome tool**
- B2B meeting/demo notes → **user notes, CRM export, or manual summary**
- Physical field feedback → **manual count, photos, coupon/QR data, sales notes**

**Output (`yorum-analizi.md`):**
```markdown
# Kullanıcı Yorum Analizi: [Product]
- Period: [date range]
- Total reviews: [count]
- Average rating: [x/5]
- Positive ratio: [%] | Negative ratio: [%]

## Patterns from Positive Reviews
1. [pattern] — [appears in how many reviews]

## Patterns from Negative Reviews
1. [pattern] — [appears in how many reviews]

## Most Requested Features
1. [feature] — [how many times requested]

## Customer Language Mining
Expressions users use to describe the product:
- ...
```

### 3.3 — Metric Analysis
**Agent:** Analytics Master
**Input:** Metric data gathered from user
**Output (`analytics-raporu.md`):**
- Critical metrics table (value vs target)
- Trend analysis
- Alarm situations
- Growth/decline comments

### 3.4 — Improvement Recommendations
**Agent:** Strategy Analyst
**Input:** `yorum-analizi.md` + `analytics-raporu.md`
**Output (`iyilestirme-onerileri.md`):**
- 3-level prioritization:
  - 🔴 Critical (must be done immediately)
  - 🟡 Important (should be done this month)
  - 🟢 Nice to have (if time permits)

### 3.5 — User Presentation
**Agent:** Orchestrator

```
📈 FEEDBACK ANALYSIS REPORT

Is there interest?
✅ / ⚠️ / ❌ [status assessment]

Key findings:
❤️ What users liked: [top 3]
💔 What users complained about: [top 3]
📊 Metric alerts: [if any]

Recommended improvements:
🔴 Critical: ...
🟡 Important: ...
🟢 Nice to have: ...

Which priorities should we proceed with?
A) Only critical ones
B) Critical + important ones
C) All of them
D) Let me specify my own selections
```

### 3.6 — Improvement Type and Revision
**Agent:** Orchestrator + relevant specialist
**Input:** `iyilestirme-onerileri.md` + user's priority decision

Select revision type:

- Product/technical change: Product Architect → `04-urun/prd/prd-v2.md`
- B2C physical marketing: Content Creator / Campaign Manager / Launch Commander →
  material, campaign, or activation revision
- B2B sales: Outreach Specialist / Brand Guardian → message, demo, proposal, objection, or pipeline revision
- Digital campaign: Campaign Manager / Content Creator → ad, content, landing, or lifecycle revision

### 3.7 — Implementation Brief
**Agent:** Orchestrator
**Output:** `coder-brief-v2.md` or `08-raporlar/pazarlama/pazarlama-iyilestirme-briefi.md`

---

## Decision Points

| Step | Decision |
|------|----------|
| 3.5 | Select improvement priorities |

---

## Output Files

| File | Produced by |
|------|-------------|
| `yorum-analizi.md` | Market Scout |
| `analytics-raporu.md` | Analytics Master |
| `iyilestirme-onerileri.md` | Strategy Analyst |
| `prd-v2.md` | Product Architect, only if product/technical revision is needed |
| `pazarlama-iyilestirme-briefi.md` | Orchestrator, if marketing/field/sales revision is needed |

---

## Next Pipeline

If product/technical improvement exists, the coder implements it → product is updated → if
desired, **Pipeline 3** runs again.

If marketing/field/sales improvement exists, the relevant campaign or sales plan is updated →
new tasks are added to the weekly plan → measured again with **Pipeline 3**.

Or if there is traction → **Pipeline 4 (Growth Engine)** is started.

## PersonalAutonomy Execution Rules

- Main output areas: 02-arastirma/musteri-arastirmasi/, 04-urun/urun-kararlari/,
  06-pazarlama-uygulamalari/, 08-raporlar/pazarlama/, and 08-raporlar/analitik/
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
