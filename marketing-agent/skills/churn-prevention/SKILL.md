---
name: churn-prevention
description: Musteri terkini azaltan iptal, save offer, odeme kurtarma ve reaktivasyon akislari tasarla. Churn veya retention sorunu istendiginde kullan.
---

# Churn Prevention

Customer retention specialist. Goal: reduce customer loss, recover cancellations, reactivate dormant users.

## Churn Types

| Type | Cause | Solution |
|------|-------|----------|
| Active cancellation | User consciously canceled | Save offer, feedback |
| Passive churn | Didn't see value, forgot | Re-engagement email |
| Payment churn | Credit card declined | Dunning (payment recovery) |
| Growth churn | User outgrew, product too small | Enterprise plan |

## Cancellation Flow Design (Save Offer)

### Tiered Save Offer Strategy

1. **Cancel button clicked:**
   - Exit survey: "Why are you canceling?"
   - Show objection response based on most common reason

2. **First save offer:**
   - "You can freeze your account for 1 free month."
   - Low commitment, no data loss

3. **Second save offer:**
   - "Continue at 50% off for 3 months."
   - For price objections

4. **Final stage:**
   - "Your account has been frozen. You can return within 30 days."
   - Don't delete data, leave the door open

## Payment Recovery (Dunning)

When credit card is declined:
- **Day 0:** Notify immediately
- **Day 3:** Reminder
- **Day 7:** Final warning
- **Day 14:** Freeze account (don't cancel)
- "Update your card" button at every step

## Dormant User Reactivation

### Triggers
- No login for 14 days
- No use of core feature for 30 days
- Incomplete activation

### Re-engagement Email Sequence
1. **Day 14:** "We miss you" + new feature
2. **Day 21:** Value the user is missing
3. **Day 30:** Special offer / support offer

## Early Warning Signals

| Signal | Action |
|--------|--------|
| Usage frequency declining | Proactive support outreach |
| Support tickets increasing | Solve the issue, follow up |
| Low NPS | One-on-one meeting |
| Feature usage decreasing | Educational email |
| Team shrinking (B2B) | Pricing flexibility |

## Churn Metrics

| Metric | Calculation |
|--------|-------------|
| Monthly churn rate | Canceled / Beginning-of-month customers |
| Net revenue churn | (Lost MRR - Expansion MRR) / Starting MRR |
| Recovery rate | Recovered cancellations / Total cancellation attempts |
| LTV | ARPU / Churn rate |
