---
name: marketing-plan
description: AARRR cercevesinde kapsamli pazarlama plani hazirla ve ilgili marketing skill'lerini koordine et. Cok kanalli plan istendiginde kullan.
---

# Marketing Plan (AARRR)

Main marketing planner working like a Fractional CMO. Goal: coordinate all marketing skills under the AARRR framework.

## Before You Start

1. Definitely read **product-marketing** context
2. Understand:
   - Business goal (revenue, growth, user count)
   - Timeframe (3 months, 6 months, 12 months)
   - Budget
   - Team
   - Current metrics

## AARRR Framework

### A — Acquisition
How will you find users?

**Channels:**
- Organic: SEO (seo-audit), content (content-strategy), social media (social)
- Paid: Google Ads, Meta Ads, LinkedIn Ads (ads, ad-creative)
- Viral: Referral program (referrals)
- Outbound: Cold email (cold-email), prospecting (prospecting)
- Directories: Directory submissions (directory-submissions)
- Community: Community (community-marketing)

**KPIs:** Traffic, signup count, CAC

### A — Activation
When does the user first see value?

**Strategies:**
- Onboarding flow optimization
- Welcome email sequence (emails)
- Demo video (video)
- Fast "aha moment" design

**KPIs:** Activation rate, time-to-value

### R — Retention
Why should the user come back?

**Strategies:**
- Churn prevention (churn-prevention)
- Community building (community-marketing)
- Regular value delivery (emails, social)
- Product quality and support

**KPIs:** DAU/WAU/MAU, churn rate, retention curve

### R — Revenue
How will you make money?

**Strategies:**
- Pricing optimization (pricing)
- Paywall and upgrade CRO (paywalls)
- Upsell/cross-sell
- Annual plan push

**KPIs:** MRR, ARPU, LTV, conversion rate

### R — Referral
How will users tell others about you?

**Strategies:**
- Referral program (referrals)
- NPS and customer advocacy
- Case studies
- Viral features

**KPIs:** NPS, viral coefficient, referral revenue

## Plan Template

```markdown
# {Product} — {Period} Marketing Plan

## Executive Summary
{1 page — main goal, strategy, expected outcome}

## Current Situation
- Metrics: ...
- Strengths: ...
- Weaknesses: ...

## AARRR Strategy

### Acquisition
| Channel | Action | Budget | Target | Timeline |
|---------|--------|--------|--------|----------|

### Activation
...

### Retention
...

### Revenue
...

### Referral
...

## Timeline
| Month | Focus | Key Actions | KPI |
|-------|-------|-------------|-----|

## Budget
| Item | Monthly | Annual |
|------|---------|--------|

## Risks
| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
```

## Skill Coordination

This plan reads the following skill files as needed:
- product-marketing (foundation)
- seo-audit, content-strategy (acquisition)
- emails, social (activation + retention)
- pricing, paywalls (revenue)
- referrals, community-marketing (referral)
- ads, cold-email, prospecting (acquisition — outbound)
- churn-prevention (retention)
- launch (for major launches)

For each action, read the relevant `skills/<skill>/SKILL.md` file and write to the MVP output location.
