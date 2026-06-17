---
name: analytics
description: Pazarlama analitigi, event tracking ve olcum plani tasarla. KPI, dosya/export tabanli dashboard, GA4 veya pixel gerektiginde kullan.
---

# Analytics Setup

Analytics and measurement specialist. Event tracking strategy for file/export-based dashboards,
GA4, pixels, and future product analytics.

## Before You Start

1. Check **product-marketing** context
2. Understand:
   - Business model (SaaS, e-commerce, marketplace)
   - What is the conversion action?
   - Is there an existing analytics setup?
   - Which tools will be used?

## Event Tracking Strategy

### Critical Events (SaaS example)

| Category | Event | Why Important |
|----------|-------|---------------|
| **Acquisition** | page_view, signup_started, signup_completed | Channel efficiency |
| **Activation** | onboarding_step_1/2/3, first_project_created | Aha moment |
| **Engagement** | feature_used, invite_team_member, dashboard_view | Product usage |
| **Revenue** | trial_started, upgrade_to_paid, plan_changed | Revenue tracking |
| **Loss** | subscription_cancelled, account_deactivated | Churn analysis |

### Event Parameters
For each event:
- **Plan:** free / pro / enterprise
- **Source:** organic / ads / referral / email
- **Device:** desktop / mobile / tablet
- **Feature:** (feature-specific)

## Tool Selection

In the MVP, do not require Mixpanel, PostHog, Amplitude, or Airtable plugins. Treat them as
post-MVP candidates. If the user already has exports from these tools, analyze the exported files;
otherwise prepare a future integration note instead of blocking the work.

| Tool | What For | Alternative |
|------|----------|-------------|
| GA4 | Web analytics, traffic source | Plausible, Fathom |
| Mixpanel | Product analytics, funnel | Amplitude, PostHog |
| Meta Pixel | Meta ads conversion tracking | — |
| LinkedIn Insight Tag | LinkedIn ads tracking | — |
| Segment | CDP, event routing | RudderStack |
| Hotjar | Session recording, heatmap | Microsoft Clarity |

## Dashboard Recommendations

### Weekly SaaS Dashboard
- New signup count
- Activation rate (%)
- Weekly active users
- Trial → Paid conversion rate
- Churn rate
- MRR (monthly recurring revenue)

### Monthly Marketing Dashboard
- Channel-based traffic
- Channel-based conversion
- CAC (customer acquisition cost)
- LTV (customer lifetime value)
- LTV/CAC ratio
- ROAS (return on ad spend)

## Implementation Checklist

- [ ] GA4 property created
- [ ] Google Tag Manager set up (recommended)
- [ ] Critical events defined
- [ ] Conversion events marked
- [ ] Meta Pixel set up
- [ ] LinkedIn Insight Tag set up
- [ ] UTM parameter standard defined
- [ ] Dashboard created
- [ ] Anomaly alerts set up
