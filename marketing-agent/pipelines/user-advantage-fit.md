# Pipeline: User Advantage Fit

**When it runs:** Every data-driven idea discovery or existing idea evaluation before final
recommendation.

**Purpose:** Help this specific marketer understand how safely and realistically they can test and
market an opportunity. This guidance never determines whether the idea itself is worth trying.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Flow

```text
[U1] Collect user advantage facts
      |
      v
[U2] Select a validation unit that fits the sales motion
      |
      v
[U3] Score distribution, credibility, resources, and constraints
      |
      v
[U4] Recommend advantage use, support needs, caution, or expert guidance
```

---

## Required Inputs

Collect succinctly:

1. City/country and target market relationship.
2. Work field, sector experience, and credibility.
3. Accessible network: customers, communities, businesses, institutions, influencers.
4. Existing audience: email list, social accounts, groups, customer portfolio, local traffic.
5. Sales/marketing experience and comfort with outreach.
6. Weekly time capacity and trial budget.
7. Language, culture, regulation, and operational advantages/disadvantages.
8. Concrete path to the sales-motion-appropriate validation unit.

If the user cannot answer, label that field as missing and lower confidence. Do not invent access.

---

## Scoring

```markdown
| Criterion | Score (1-5) | Evidence | Risk |
|---|---:|---|---|
| Target audience access | | | |
| Sector credibility | | | |
| Validation-unit access path | | | |
| Sales/channel ability | | | |
| Budget/time fit | | | |
| Local/language/culture advantage | | | |
| Product-building access | | | |
| Motivation/constraint fit | | | |
| **Total** | **/40** | | |
```

Marketer guidance:

- `30-40`: strong marketer fit; explain which advantages to use.
- `22-29`: partial fit; identify the missing channel, capability, partner, mentor, or specialist.
- `<22`: weak fit; recommend caution and advice from experienced people before high-cost action.

The score is private guidance between Marketing Agent and the marketer. It must not change the
idea-value verdict to `Denenmeye Değmez`.

## Validation Unit By Sales Motion

- B2C/self-service: typically 10-50 target users or equivalent behavioral tests.
- SMB B2B: typically 3-10 buyer conversations, pilots, or credible commitments.
- Enterprise/high-ticket/regulated: typically 1-3 design partners or budget-owner commitments.
- Physical/local: a defined number of visits, trials, orders, or repeat purchases.
- Marketplace: separate supply-side and demand-side thresholds.

---

## Output: User Advantage Fit Report

Write to:

- project idea-evaluation mode: `02-arastirma/fikir-degerlendirme/user-advantage-fit.md`
- Project workspace: `03-strateji/dogrulama/user-advantage-fit.md`

```markdown
# User Advantage Fit
- Date:
- Opportunity / idea:

## User Facts
- City/country:
- Field/sector:
- Network:
- Existing audience:
- Sales/marketing experience:
- Time:
- Budget:

## Kaynak ve Kanit Defteri
| ID | Arac | Kaynak | Erisim tarihi | Kullanilan veri | Guven |
|----|------|--------|---------------|-----------------|-------|

## Score
| Criterion | Score | Evidence | Risk |
|---|---:|---|---|

## Validation Access Plan
- Sales motion:
- Selected validation unit:
- Target threshold and rationale:
- Channel:
- Message:
- Required asset:

## Marketer Guidance
- Fit: Strong / Partial / Weak
- Advantages to use:
- Support or experienced advice needed:
- Caution note:

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

---

## PersonalAutonomy Execution Rules

- Main output areas: in evaluation `02-arastirma/fikir-degerlendirme/`; in project `03-strateji/dogrulama/`.
- This pipeline informs the marketer conversation; it never rejects the idea on marketer fit.
- Keep idea value and marketer fit as separate outputs.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- Obtain explicit user approval before writing final recommendations to `03-strateji/dogrulama/fikir-dogrulama.md` or copying
  approved project files under `10-final/`.
