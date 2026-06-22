# Pipeline 8: B2B Revenue and Outbound Sales

**Position in chain:** Main revenue pipeline for B2B digital, B2B field/physical, and hybrid
sales motions. Manages lead generation, prospecting, outbound, inside sales, field sales, demo,
proposal, partner/channel sales, and follow-up processes together.

**When it runs:** When the user wants to find B2B customers, build a sales pipeline, get meetings,
do demos, prepare proposals, run field sales, set up a partner/dealer channel, or improve the
existing B2B sales process.

**Purpose:** Clarify the ICP and build an evidence-based target account list; establish a contact
plan via digital and/or physical channels; produce message, proposal, demo, meeting, and
follow-up materials; monitor pipeline metrics and improve the sales process.

**Prerequisite:** The product/service must be B2B or hybrid with a B2B component. `PROJE.md`,
relevant `01-baglam/` files, and basic offering information must be present; if missing, the
pipeline completes these first.

---

## Core Principle

This pipeline is not limited to cold email. The B2B sales motion can be run through one or more
of the following channels:

- cold email
- LinkedIn/social selling
- phone/WhatsApp
- demo and online meeting
- face-to-face visit, field sales, and event/trade show
- webinar, workshop, community, or partner event
- channel/partner/dealer/referral
- ABM ads, retargeting, and content-supported lead nurture

The agent selects channels based on the user's network, industry knowledge, target account type,
sales cycle, ticket size, decision-maker access, and field capacity. Measurement and follow-up
steps are tied to every contact channel.

---

## Pipeline Flow

```text
User: "Let's find B2B customers / make sales"
        |
        v
[8.1] Orchestrator -> Extract B2B sales context and sales motion
        |  Output: 01-baglam/b2b-satis-baglami.md
        v
[8.2] Strategy Analyst -> ICP, segment, value proposition, and offering hypothesis
        |  Output: 03-strateji/pazara-giris/b2b-icp-ve-teklif.md
        v
[8.3] Market Scout + Outreach Specialist -> Account/prospect and channel research
        |  Output: 06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md
        v
[8.4] Outreach Specialist -> Multi-channel contact sequence
        |  Output: 06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md
        v
[8.5] Content Creator + Brand Guardian -> Sales materials
        |  Output: 06-pazarlama-uygulamalari/saha/satis-materyalleri/
        v
[8.6] Product Architect + Brand Guardian -> Demo, proposal, and objection handling
        |  Output: 06-pazarlama-uygulamalari/saha/teklifler/
        v
[8.7] Campaign Manager -> B2B ad/ABM/retargeting support plan
        |  Output: 06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md
        v
[8.8] Outreach Specialist -> Partner, channel, event, or field sales plan
        |  Output: 06-pazarlama-uygulamalari/saha/toplantilar/ and etkinlikler/
        v
[8.9] Analytics Master -> Pipeline dashboard and follow-up rhythm
        |  Output: 08-raporlar/analitik/b2b-pipeline-dashboard.md
        v
[8.10] Orchestrator -> Add tasks to weekly plan, get user approval
```

---

## Step Details

### 8.1 — B2B Sales Context
**Agent:** Orchestrator

Information to gather:

1. What is the product/service and what B2B problem does it solve?
2. Target customer: industry, company size, location, maturity level
3. Decision makers and influencers: title, department, buying committee
4. Ticket size, pricing model, sales cycle, and payment expectation
5. User's network, references, industry credibility, and accounts they can access
6. Sales motion: inside sales, field sales, partner/channel, self-service supported, or mixed
7. Existing materials: presentation, demo, case study, landing page, proposal template, reference
8. Constraints: time, team, budget, geography, regulation, integration, operational capacity

**Output:** `01-baglam/b2b-satis-baglami.md`

### 8.2 — ICP and Offering Strategy
**Agent:** Strategy Analyst

**Output (`03-strateji/pazara-giris/b2b-icp-ve-teklif.md`):**

```markdown
# B2B ICP ve Teklif Stratejisi: [Project]

## ICP
| Segment | Pain point | Budget | Access ease | Sales cycle | Priority |
|---------|------------|--------|-------------|-------------|----------|

## Decision Maker Map
| Role | Priority | Main pain | Message | Evidence |
|------|----------|-----------|---------|-----------|

## Value Proposition
- Core promise:
- ROI or cost reduction:
- Risk mitigation element:
- Initial offering:

## Channel Decision
- Inside sales:
- Field sales:
- Partner/channel:
- Digital demand generation:
```

### 8.3 — Account and Prospect Research
**Agent:** Market Scout + Outreach Specialist

Sources:

- LinkedIn, company websites, directories, industry lists, chamber/association lists
- user network and existing customer/referral sources
- event/trade show attendee lists
- local field accounts, store/branch/facility lists
- web search and reliable sources

**Output (`06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md`):**

```markdown
# Prospect Listesi: [Project]
- ICP:
- Sources:

| # | Account | Segment | Decision maker | Channel | Why suitable | Personalization note | Priority |
|---|---------|---------|----------------|---------|--------------|----------------------|----------|
```

Apply data minimization for personal data and contact information. Obtain explicit user approval
before sending a message to an external system.

### 8.4 — Multi-Channel Outreach Plan
**Agent:** Outreach Specialist

Channel selection is made per target account. Cold email is not the only option.

**Output (`06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md`):**

```markdown
# Çok Kanallı Outreach Planı: [Project]

## Contact Sequence
| Day | Channel | Message purpose | CTA | Follow-up condition |
|-----|---------|-----------------|-----|---------------------|
| 0 | Email | Problem/ROI opening | 15 min meeting | If no response, LinkedIn |
| 2 | LinkedIn | Soft touch | Connect | If accepted, message |
| 5 | Phone/WhatsApp | Finalize meeting | Date selection | ... |

## Message Variants
- Email 1:
- LinkedIn message:
- Phone opening script:
- WhatsApp short message:
- Breakup message:
```

### 8.5 — Sales Materials
**Agent:** Content Creator + Brand Guardian

Items to produce:

- one-page sales document
- problem/solution narrative
- industry-specific message variants
- LinkedIn post or thought leadership content
- landing page or demo page copy
- case study or reference draft
- brochure/presentation summary for field visit

**Output folder:** `06-pazarlama-uygulamalari/saha/satis-materyalleri/`

### 8.6 — Demo, Proposal, and Objection Handling
**Agent:** Product Architect + Brand Guardian

**Outputs:**

- `06-pazarlama-uygulamalari/saha/demolar/demo-akisi.md`
- `06-pazarlama-uygulamalari/saha/teklifler/teklif-sablonu.md`
- `06-pazarlama-uygulamalari/saha/toplantilar/toplanti-scripti.md`
- `06-pazarlama-uygulamalari/saha/takip/itiraz-yanitlari.md`

### 8.7 — B2B Demand Generation and Ad Support
**Agent:** Campaign Manager

If B2B digital support is needed:

- LinkedIn Ads or Meta/Google targeting
- ABM small-list ads
- retargeting
- webinar/workshop registration campaign
- lead magnet or report campaign

**Output:** `06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md`

### 8.8 — Partner, Channel, Event, and Field Sales
**Agent:** Outreach Specialist

If B2B physical/field is needed:

- trade show/event list
- field visit plan
- dealer/partner target list
- demo day/workshop plan
- pre- and post-meeting follow-up flow

**Outputs:**

- `06-pazarlama-uygulamalari/saha/etkinlikler/b2b-etkinlik-plani.md`
- `06-pazarlama-uygulamalari/saha/toplantilar/saha-ziyaret-plani.md`
- `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/partner-kanal-listesi.md`

### 8.9 — Pipeline Dashboard
**Agent:** Analytics Master

**Output (`08-raporlar/analitik/b2b-pipeline-dashboard.md`):**

```markdown
# B2B Pipeline Dashboard: [Project]
- Period:

## Funnel
| Stage | Count | Conversion | Target |
|-------|-------|------------|--------|
| Target accounts | ... | ... | ... |
| Contacted | ... | ... | ... |
| Response | ... | ... | ... |
| Meeting | ... | ... | ... |
| Demo | ... | ... | ... |
| Proposal | ... | ... | ... |
| Won | ... | ... | ... |

## Channel Performance
| Channel | Contacts | Response | Meeting | Cost | Note |
|---------|----------|----------|---------|------|------|

## Decision
- Scale:
- Revise:
- Stop:
- New test:
```

### 8.10 — Weekly Plan
**Agent:** Orchestrator

Loads selected contact, demo, proposal, partner, and follow-up tasks into the active weekly
plan. Completion is closed only with user approval.

---

## Decision Points

| Step | Decision |
|------|----------|
| 8.2 | Which ICP/segment is the priority? |
| 8.4 | Which contact channels will be used? |
| 8.6 | Is the demo/proposal package approved? |
| 8.8 | Will the field/partner/event plan be implemented? |
| 8.9 | Scale / revise / stop |

---

## Output Files

| File | Produced by |
|------|-------------|
| `01-baglam/b2b-satis-baglami.md` | Orchestrator |
| `03-strateji/pazara-giris/b2b-icp-ve-teklif.md` | Strategy Analyst |
| `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md` | Market Scout + Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/satis-materyalleri/` | Content Creator + Brand Guardian |
| `06-pazarlama-uygulamalari/saha/demolar/demo-akisi.md` | Product Architect |
| `06-pazarlama-uygulamalari/saha/teklifler/teklif-sablonu.md` | Brand Guardian |
| `06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md` | Campaign Manager |
| `06-pazarlama-uygulamalari/saha/etkinlikler/b2b-etkinlik-plani.md` | Outreach Specialist |
| `08-raporlar/analitik/b2b-pipeline-dashboard.md` | Analytics Master |

---

## PersonalAutonomy Execution Rules

- Main output areas: `01-baglam/`, `03-strateji/pazara-giris/`,
  `06-pazarlama-uygulamalari/saha/`, `06-pazarlama-uygulamalari/dijital/`,
  `06-pazarlama-uygulamalari/hibrit/`, and `08-raporlar/analitik/`
- The pipeline does not create its own project or status folder. It keeps the active step in
  DURUM.md and the relevant .pa/*/active-task.md file.
- In project idea-evaluation mode, it does not skip user approval before interpreting a
  positive result as authority to create a project.
- In a project, PROJE.md, relevant 01-baglam/ files, and KARARLAR.md are prerequisites.
- Records claims requiring current data with source and access date; if data is missing, labels
  the assumption explicitly.
- Obtains explicit user approval at decision gates. Weekly tasks close from evidence when
  file-proven; external-action tasks wait for user-reported completion.
- Obtains explicit user approval before sending email, LinkedIn message, phone, WhatsApp, form,
  or application to an external system.
- Places approved final copies under 10-final/ and preserves the working source in place.

Internal operating instructions are in English. The default user-facing language is Turkish.
