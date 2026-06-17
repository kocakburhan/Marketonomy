# Pipeline 9: B2C Physical and Local Marketing

**Position in chain:** Main marketing operations pipeline for B2C projects requiring physical
contact. Manages digital support, field activation, local partnerships, ads, content, launch,
measurement, and improvement cycle together.

**When it runs:** When the user has a B2C product, service, or business that needs to be marketed
in the physical world.

Scope examples:

- restaurant, cafe, gym, clinic, beauty center, education center, store, event venue
- physical product, packaged consumer goods, boutique production, D2C but requiring field/retail product
- pop-up, booth, trade show, market, mall, festival, campus, neighborhood, district, or city-based activation
- flyer, brochure, poster, coupon, sample distribution, QR redirection, WhatsApp, local influencer,
  local ads, and in-store experience requiring work

**Purpose:** Provide end-to-end support to the user from idea to execution: understand the market,
build the physical customer journey, generate actionable campaign ideas, prepare materials, produce
a weekly action plan, measure results, and improve.

**Prerequisite:** Product/service/business description, target market or location, approximate
budget, point of sale/operations model, and user constraints must be gathered. If there are gaps,
the pipeline completes this information first.

---

## Core Principle

In this pipeline, the agent does not just give advice. It takes the user's physical marketing
process from start to finish:

- Tells what to do.
- Proves why it should be done.
- Produces what material is needed.
- Plans which day, where, with whom, with what budget to execute.
- Writes what metric to measure.
- Suggests new ideas and revisions based on the result.

Idea generation is mandatory. The agent must propose creative but actionable campaign,
partnership, event, sampling, experience, and repeat purchase ideas within the user's budget and
capacity. Every idea is filtered by cost, operational difficulty, permission/ethical risk,
measurement ease, and expected impact.

---

## Pipeline Flow

```text
User: "I need to physically market my B2C product/business"
        |
        v
[9.1] Orchestrator -> Gather business, product, location, budget, capacity, and constraints
        |  Output: 01-baglam/fiziksel-pazarlama-baglami.md
        v
[9.2] Market Scout -> Local market, competitor, customer, and physical channel research
        |  Output: 02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md
        v
[9.3] Strategy Analyst -> Physical customer journey and channel strategy
        |  Output: 03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md
        v
[9.4] Brand Guardian -> Offering, positioning, and physical touchpoint brand system
        |  Output: 03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md
        v
[9.5] Orchestrator -> Generate campaign idea pool and select with user
        |  Output: 03-strateji/pazara-giris/kampanya-fikir-havuzu.md
        v
[9.6] Content Creator -> Produce physical and digital support materials
        |  Output: 06-pazarlama-uygulamalari/saha/satis-materyalleri/
        v
[9.7] Outreach Specialist -> Local partnerships, retail, event, and community plan
        |  Output: 06-pazarlama-uygulamalari/saha/potansiyel-musteriler/ and etkinlikler/
        v
[9.8] Campaign Manager -> Local ads, field campaign, and budget plan
        |  Output: 06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md
        v
[9.9] Launch Commander -> Implementation calendar, checklist, and field operations plan
        |  Output: 07-lansman/fiziksel-aktivasyon-plani.md
        v
[9.10] Analytics Master -> Metric dashboard and follow-up rhythm
        |  Output: 08-raporlar/analitik/fiziksel-b2c-dashboard.md
        v
[9.11] Orchestrator -> Add tasks to weekly plan, get user approval
        |  Output: 05-haftalik-planlar/YYYY-WNN.md
        v
[9.12] Orchestrator -> Interpret results, start new idea/improvement cycle
```

---

## Step Details

### 9.1 — Physical Marketing Context
**Agent:** Orchestrator

Gather the following from the user:

1. What is the product/service/business?
2. In which city, district, neighborhood, location, or points of sale will it be marketed?
3. Who is the target customer: age, income, lifestyle, need, shopping habit?
4. What is the sales model: store, booth, dealer, online order + physical promotion, door-to-door
   sales, event, market, trade show, pop-up, WhatsApp, phone, appointment?
5. What is the price, gross margin, stock/capacity, and daily service limit?
6. What is the monthly/test budget and the user's weekly time capacity?
7. Existing assets: logo, photos, packaging, social media, website, Google Business Profile,
   customer list, WhatsApp line, physical space, team, vehicle, booth, samples.
8. Legal/ethical/permission constraints: health claims, food, child targeting, public space
   permission, personal data, raffle/campaign terms.

**Output (`01-baglam/fiziksel-pazarlama-baglami.md`):**

```markdown
# Fiziksel Pazarlama Bağlamı: [Project]
- Date: [date]

## Business and Offering
- Product/service:
- Price:
- Gross margin:
- Capacity/stock:
- Sales model:

## Target Customer
- Primary segment:
- Secondary segment:
- Location:
- Purchase trigger:

## Existing Assets
- Digital assets:
- Physical assets:
- Team and operations:

## Constraints
- Budget:
- Time:
- Permission/legal/ethical:
- Operational risk:
```

### 9.2 — Local Market and Physical Channel Research
**Agent:** Market Scout

Sources to research:

- Google Maps, Google Business Profile, competitor reviews
- Instagram/TikTok location tags, local accounts, micro influencers
- Contact points such as malls, streets, schools/campuses, gyms, markets, festivals, trade shows,
  event venues
- Competitor store/booth/packaging/price/promotion observations, photos and notes from the user
- Local Facebook/WhatsApp/Telegram groups, forums, Şikayetvar, Ekşi Sözlük, industry communities
- Retail/dealer possibilities, complementary businesses, cross-promotion partners

**Output (`02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md`):**

```markdown
# Fiziksel B2C Pazar Analizi: [Project]
- Date: [date]

## Kaynak ve Kanıt Defteri
| ID | Tool | Source | Access date | Data used | Confidence |
|----|------|--------|-------------|-----------|------------|

## Local Demand and Customer Signals
- Where the target customer is located:
- Purchase triggers:
- Season/day/time effect:
- Price sensitivity:

## Competitors and Alternatives
| Competitor/Alternative | Location/Channel | Offering | Price | Strength | Weakness | Evidence |
|------------------------|------------------|----------|-------|----------|----------|----------|

## Physical Channel Opportunities
| Channel | Suitability | Cost | Operational difficulty | Measurement ease | Note |
|---------|-------------|------|------------------------|-------------------|------|

## Missing Data
- Field observation needed from user:
- Inaccessible sources:
```

### 9.3 — Physical Customer Journey and Channel Strategy
**Agent:** Strategy Analyst

Build the customer journey based on physical reality:

1. Awareness: where does the customer notice the product/business?
2. Interest: what message, visual, or offer stops them?
3. Trial: sample, demo, tasting, mini service, free consultation, first class, coupon?
4. Purchase: payment, appointment, WhatsApp, store visit, web form?
5. Repeat: loyalty card, referral, package, subscription, follow-up message?
6. Social proof: review, UGC, before/after, customer story?

**Output (`03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md`):**

```markdown
# Fiziksel Kanal Stratejisi: [Project]

## Customer Journey
| Stage | Physical touchpoint | Message | CTA | Measurement |
|-------|---------------------|---------|-----|-------------|

## Channel Priority
| Channel | Priority | Why | First test | Success threshold |
|---------|----------|-----|------------|-------------------|

## Offering and Campaign Logic
- Core offering:
- First-trial offering:
- Repeat-purchase offering:
- Referral offering:
```

### 9.4 — Offering, Positioning, and Physical Brand System
**Agent:** Brand Guardian

Build the brand system that will be seen and heard in the physical world:

- one-sentence offering
- main message in customer language
- poster/brochure/booth/packaging headlines
- staff sales language
- objection responses
- price/package structure
- trust signals

**Output (`03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md`)**

### 9.5 — Campaign Idea Pool
**Agent:** Orchestrator

Generate at least 12 actionable ideas. Ideas should span these categories:

- in-store experience or window/booth idea
- sample, demo, tasting, first trial, or free mini service
- coupon, referral, loyalty, package, or subscription
- local influencer or micro creator
- neighboring business/partner cross-promotion
- event, workshop, pop-up, festival, market, school/campus, gym-type field activation
- physical-to-digital follow-up with WhatsApp/QR/landing page
- Google Maps review and social proof collection

**Output (`03-strateji/pazara-giris/kampanya-fikir-havuzu.md`):**

```markdown
# Kampanya Fikir Havuzu: [Project]
| Idea | Category | Cost | Difficulty | Expected impact | Measurement | Risk | Decision |
|------|----------|------|------------|-----------------|-------------|------|----------|
```

The agent must filter every idea. Mark weak ideas as "rejected" and write why.

### 9.6 — Material Production
**Agent:** Content Creator

Produce the physical and digital materials needed for selected campaigns:

- poster copy
- brochure/flyer copy
- coupon or card copy
- QR/landing page CTA copy
- WhatsApp welcome and follow-up messages
- staff sales script
- customer objection response card
- Instagram/TikTok/Reels content
- visual generation prompts
- photo/video shot list

**Primary output folder:** `06-pazarlama-uygulamalari/saha/satis-materyalleri/`

### 9.7 — Local Partnerships and Community Plan
**Agent:** Outreach Specialist

Areas to plan:

- neighboring businesses and complementary brands
- micro influencers and local content creators
- event/trade show/festival/market/mall/campus opportunities
- retail/dealer/shelf or consignment discussions
- club, association, school, gym, course, community, and neighborhood groups

**Outputs:**

- `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/yerel-partner-listesi.md`
- `06-pazarlama-uygulamalari/saha/etkinlikler/etkinlik-ve-pop-up-plani.md`
- `06-pazarlama-uygulamalari/saha/takip/partner-mesajlari.md`

### 9.8 — Local Ads and Field Campaign
**Agent:** Campaign Manager

The campaign plan addresses digital and physical channels together:

- Google Local/Search/Maps ads
- Meta/TikTok location-targeted ads
- local influencer boost
- poster/brochure print budget
- sample/gift/coupon cost
- booth/pop-up/event cost
- minimum test budget and maximum loss limit

**Output:** `06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md`

### 9.9 — Implementation Calendar and Checklist
**Agent:** Launch Commander

Plan the field implementation day by day:

- preparation list
- material production and print calendar
- team/staff tasks
- location/permission check
- execution day flow
- risk plan for bad weather, low traffic, stock depletion, staff absence
- post-campaign follow-up

**Output:** `07-lansman/fiziksel-aktivasyon-plani.md`

### 9.10 — Metric Dashboard
**Agent:** Analytics Master

Digital product metrics alone are not enough for physical marketing. Establish the following
metrics:

- foot traffic or contact count
- brochure/coupon/QR scan count
- tasting/demo/trial count
- sales/appointment/WhatsApp conversion
- location-based conversion
- channel-based CAC
- basket, margin, stock, and capacity impact
- Google Maps views, directions, searches, reviews
- social media follow/DM/UGC
- repeat purchase and referral

**Output:** `08-raporlar/analitik/fiziksel-b2c-dashboard.md`

### 9.11 — Weekly Plan
**Agent:** Orchestrator

Loads selected actions into the active weekly plan. Every task includes channel, priority,
expected output, output location, and `Tamamlanma onayi: Kullanici`.

### 9.12 — Improvement Cycle
**Agent:** Orchestrator + Analytics Master + relevant specialists

After the campaign, answer these questions:

1. Which channel really brought customers?
2. Which physical material or message didn't work?
3. Is the offering, location, target audience, or execution weak?
4. Which idea should be repeated next week, which should be cut?
5. What is the new test idea?

Write results to `08-raporlar/pazarlama/fiziksel-b2c-iyilestirme-raporu.md`.

---

## Decision Points

| Step | Decision |
|------|----------|
| 9.1 | Are the operations and budget constraints correct? |
| 9.5 | Which campaign ideas will be tested? |
| 9.6 | Which materials are approved for print/implementation? |
| 9.8 | Is the test budget and maximum loss limit approved? |
| 9.9 | Will the activation plan be implemented? |
| 9.12 | Continue / revise / stop decision |

---

## Output Files

| File | Produced by |
|------|-------------|
| `01-baglam/fiziksel-pazarlama-baglami.md` | Orchestrator |
| `02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md` | Market Scout |
| `03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md` | Strategy Analyst |
| `03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md` | Brand Guardian |
| `03-strateji/pazara-giris/kampanya-fikir-havuzu.md` | Orchestrator |
| `06-pazarlama-uygulamalari/saha/satis-materyalleri/` | Content Creator |
| `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/yerel-partner-listesi.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/etkinlikler/etkinlik-ve-pop-up-plani.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md` | Campaign Manager |
| `07-lansman/fiziksel-aktivasyon-plani.md` | Launch Commander |
| `08-raporlar/analitik/fiziksel-b2c-dashboard.md` | Analytics Master |
| `08-raporlar/pazarlama/fiziksel-b2c-iyilestirme-raporu.md` | Orchestrator + Analytics Master |

---

## Physical B2C vs. Digital Product Differences

| Area | Digital Product | Physical B2C |
|------|-----------------|--------------|
| First contact | ads, search, social | location, booth, window, event, human contact |
| Evidence | trial, reviews, metrics | tasting/demo, observation, conversation, coupon/QR, sales |
| Constraint | product bug, onboarding | stock, team, permission, weather, traffic, print, venue |
| Content | landing, ASO, post | poster, brochure, sales script, QR, in-store message |
| Success metric | signup, DAU, retention | contact, trial, sales, appointment, directions, review |
| Improvement | funnel optimization | location, offering, material, staff, timing |

---

## PersonalAutonomy Execution Rules

- Main output areas: `01-baglam/`, `02-arastirma/`, `03-strateji/`,
  `06-pazarlama-uygulamalari/saha/`, `06-pazarlama-uygulamalari/hibrit/`, `07-lansman/`,
  `08-raporlar/`, and `10-final/` for approved outputs
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
