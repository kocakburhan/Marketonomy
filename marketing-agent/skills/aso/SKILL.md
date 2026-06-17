---
name: aso
description: App Store ve Google Play optimizasyonu yap. Uygulama magazasi anahtar kelimesi, listing, yorum veya rakip app analizi istendiginde kullan.
---

# ASO (App Store Optimization)

Mobile app store optimization specialist. Ranking improvement in App Store and Google Play.

## Optimization Areas

### 1. App Name and Subtitle
- App Store: 30 characters (name) + 30 characters (subtitle)
- Google Play: 50 characters (name) + 80 characters (short description)
- Include the main keyword in the name
- Example: "ProjectFlow: Project Management & Team Communication"

### 2. Keywords
- App Store: 100 character keyword field
- Google Play: Must appear naturally in the description
- Competitor analysis: Which keywords are competitors using?
- Search for long-tail opportunities

### 3. Description
- First 3 lines are most critical — the portion visible in search results
- Value proposition right at the start
- Benefit-focused, not a feature list
- Social proof: awards, user count, rating

### 4. Visual Assets
- **Icon:** Simple, recognizable, high color contrast
- **Screenshots:** Show benefit, not just the interface
  - App Store: up to 10
  - Google Play: up to 8
- **Feature Graphic:** Mandatory for Google Play
- **Video:** App Store 30s, Google Play 30s-2 min

### 5. Rating and Reviews
- Target: 4+ stars, at least 50 reviews
- Request reviews at every update
- Respond quickly and constructively to negative reviews
- iOS: In-app review request via SKStoreReviewController API

## Ranking Factors

| Factor | App Store | Google Play |
|--------|:---------:|:-----------:|
| App name | High | High |
| Keywords | High | Medium |
| Download count | High | High |
| Rating and reviews | Medium | High |
| Download velocity | High | Medium |
| Update frequency | Medium | Medium |
| Engagement (opens) | Low | High |

## ASO Audit Steps

1. Check current ranking (App Store Connect, Google Play Console)
2. Research keywords competitors rank for
3. Optimize title, subtitle, description
4. Update visuals
5. Implement review strategy
6. A/B test (Google Play listing experiments)
7. Measure again after 2 weeks

## Codex and MCP Usage

- For App Store / Google Play data, mcp-appstore is used only if visible in the active Codex
  tool list.
- If MCP is unavailable, use official stores, Codex web/Browser/Chrome, user export, or manual
  data fallback; note unreachable metrics in the report.
- For changeable fields such as keyword, ranking, rating, review count, and price, write the
  source, date, and country/market parameter.
- Preserve raw reviews or keyword lists as source before summarizing; keep theme counts and
  sample user language separately.
