# Pipeline: User Advantage Fit

**When it runs:** Every data-driven idea discovery or existing idea evaluation before final
recommendation.

**Purpose:** Decide whether this specific user or marketer can realistically test and market an
opportunity. A good market opportunity is not enough if the user cannot reach the first users.

Internal operating instructions are in English. The default user-facing language is Turkish.

---

## Flow

```text
[U1] Collect user advantage facts
      |
      v
[U2] Map opportunity to reachable first users
      |
      v
[U3] Score distribution, credibility, resources, and constraints
      |
      v
[U4] Recommend proceed, revise segment/channel, or reject
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
8. Concrete path to first 10-50 users.

If the user cannot answer, label that field as missing and lower confidence. Do not invent access.

---

## Scoring

```markdown
| Criterion | Score (1-5) | Evidence | Risk |
|---|---:|---|---|
| Target audience access | | | |
| Sector credibility | | | |
| First 10-50 user path | | | |
| Sales/channel ability | | | |
| Budget/time fit | | | |
| Local/language/culture advantage | | | |
| Product-building access | | | |
| Motivation/constraint fit | | | |
| **Total** | **/40** | | |
```

Decision guidance:

- `30-40`: user has a realistic test path.
- `22-29`: revise audience, scope, or channel before proceeding.
- `<22`: do not recommend unless user brings a new distribution advantage.

---

## Output: User Advantage Fit Report

Write to:

- Evaluation workspace: `ciktilar/user-advantage-fit.md`
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

## First User Access Plan
- First 10 users:
- First 50 users:
- Channel:
- Message:
- Required asset:

## Decision
- Recommendation: Proceed / Revise / Reject
- Reason:
- Mandatory revision:

## Veri Isleme Notlari
- Ham veri:
- Normalize edilen alanlar:
- Kullanilan script veya arac:
- Varsayimlar:
- Eksik veya erisilemeyen veri:
```

---

## PersonalAutonomy Execution Rules

- Main output areas: in evaluation `ciktilar/`; in project `03-strateji/dogrulama/`.
- This pipeline must run before a generated opportunity is recommended as an idea.
- Do not let market attractiveness override weak user distribution access.
- The pipeline does not create its own project or status folder. It keeps the active step in
  `DURUM.md` and the relevant `.pa/*/active-task.md` file.
- Obtain explicit user approval before writing final recommendations to `RAPOR.md` or copying
  approved project files under `10-final/`.
