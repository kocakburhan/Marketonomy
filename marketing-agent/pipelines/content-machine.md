# Pipeline 7: Content Machine

**Position in chain:** Chain C (supports P9) and Chain E (independent, continuous loop).

**When it runs:**
- When regular content production is needed
- When the user says "I want to be active on social media"
- When a continuous content flow is needed for a physical business
- When B2B thought leadership, lead nurturing, webinar/report, or sales support content is needed
- When a continuous content rhythm is needed for B2C digital, B2C physical, or hybrid campaigns

**Purpose:** Build a content system appropriate for the business model, produce a 30-day content
calendar and channel-based materials, and continuously update based on performance.

**Prerequisite:** `PROJE.md and relevant files under 01-baglam/` must be present. Brand voice must
be defined (from Brand Guardian).

---

## Pipeline Flow

```
User: "Let's start producing content"
        │
        ▼
[7.1] Content Creator → Create 30-day content calendar
        │  Script: social_calendar.py
        │  Output: content-calendar.md
        ▼
[7.2] Content Creator → Write platform-specific posts
        │  Output: content/ folder (each post as .md)
        ▼
[7.3] Analytics Master → Track content performance (after 30 days)
        │  Output: icerik-performans.md
        ▼
[7.4] Content Creator → Update calendar based on performance
           Output: content-calendar-v2.md
           │
           └── Return to [7.2] (new posts) → continuous loop
```

---

## Step Details

### 7.1 — Content Calendar
**Agent:** Content Creator
**Script:** `python social_calendar.py --topic "[topic]" --platforms instagram,linkedin --brand "[brand]"`

**Output (`content-calendar.md`):**
- 5 pillars: Education (40%), Social Proof (20%), Product/Promotion (15%), Community/Engagement (15%), Brand/Culture (10%)
- Weekly themes
- Daily post headlines

The content model is adapted per business:

- B2C digital: short-form video, social proof, product benefit, lifecycle email, creator content
- B2C physical: location, customer experience, event, campaign, before/after, UGC, Google Maps post
- B2B digital: thought leadership, case study, problem/ROI content, webinar, lead magnet, nurture
- B2B physical/field: pre-meeting content, demo support material, event/trade show content,
  proposal support documents
- Hybrid: digital follow-up and retargeting content after physical contact

### 7.2 — Post Production
**Agent:** Content Creator
**For each post:**
- Platform (Instagram/LinkedIn/TikTok/Twitter)
- Visual brief
- Post copy
- Hashtags
- Publication date

**Platform-specific rules:**
- Instagram: visual-focused, carousel/reels/story, 15-20 hashtags
- LinkedIn: professional tone, long form, 3-5 hashtags
- Twitter/X: short/direct, thread option, 1-2 hashtags
- TikTok: trend-focused, short video script, 3-5 hashtags
- For B2B content, the CTA should generally be meeting, demo, report download, or webinar.
- For B2C physical content, the CTA can be location visit, WhatsApp, coupon, QR, directions, or event participation.

### 7.3 — Performance Tracking
**Agent:** Analytics Master (after 30 days)
**Output (`icerik-performans.md`):**
```markdown
# İçerik Performansı: [30-day period]
## Per Platform
| Platform | Post Count | Total Engagement | Avg. Engagement | Best Post |
|----------|------------|------------------|-----------------|-----------|
| Instagram | 30 | [x] | [x] | [link] |
| LinkedIn | 20 | [x] | [x] | [link] |

## Best Performing Content Types
1. [type] — average [x] engagement

## Learnings and Recommendations
- ...
```

### 7.4 — Calendar Update
**Agent:** Content Creator
New calendar based on performance data:
- Increase ratio of content types that performed well
- Reduce or change those that performed poorly
- Add new trends/topics

---

## Output Files

| File | Produced by |
|------|-------------|
| `content-calendar.md` | Content Creator |
| `content/social-post-*.md` | Content Creator |
| `icerik-performans.md` | Analytics Master |
| `content-calendar-v2.md` | Content Creator |

---

## Next Step

Pipeline 7 runs in a continuous loop. A new calendar + performance analysis is done every month.

## PersonalAutonomy Execution Rules

- Main output areas: 06-pazarlama-uygulamalari/dijital/icerik/ and sosyal-medya/; for physical
  or hybrid businesses 06-pazarlama-uygulamalari/saha/satis-materyalleri/ and hibrit/kampanyalar/
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
