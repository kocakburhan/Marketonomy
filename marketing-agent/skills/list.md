# Marketing Agent — Agent ve Skill Listesi (v5.4.2)

Bu dosya `marketing-agent/agents/` altindaki tum agent'lari ve her agent'in
`## Skills You Use` tablosunda bagli olan skill'leri ozetler.

- **U** = Upstream (`coreyhaines31/marketingskills` reposundan, guncel v2.5.x)
- **L** = Local (`marketing-agent/skills/` altinda ozgun olarak yazilmis)

## Agent — Skill Baglantilari

| Agent | Upstream (U) | Local (L) | Toplam |
|---|---|---|---:|
| `analytics-master` | `analytics`, `ai-seo` | `market-report`, `market-report-pdf` | 4 |
| `brand-guardian` | `ad-creative`, `offers` | `market-brand`, `market-proposal` | 4 |
| `campaign-manager` | `ads`, `ad-creative` | `market-ads` | 3 |
| `content-creator` | `content-strategy`, `copywriting`, `copy-editing`, `social`, `image`, `video`, `competitors`, `lead-magnets` | — | 8 |
| `growth-hacker` | `referrals`, `churn-prevention`, `community-marketing`, `paywalls`, `marketing-ideas` | — | 5 |
| `investor-readiness-advisor` | `analytics`, `pricing` | `investor-documents`, `fundraising-financials`, `investor-data-room`, `investment-legal-drafts`, `market-report` | 7 |
| `launch-commander` | `launch`, `aso`, `seo-audit`, `directory-submissions`, `community-marketing` | — | 5 |
| `market-expansion-advisor` | `customer-research`, `pricing`, `prospecting`, `analytics` | `web-research`, `market-competitors`, `market-funnel` | 7 |
| `market-scout` | `competitor-profiling`, `customer-research`, `ai-seo` | `web-research`, `market-competitors` | 5 |
| `onboarding-guide` | — | — | 0 |
| `orchestrator` | — | — | 0 |
| `outreach-specialist` | `cold-email`, `emails`, `prospecting`, `directory-submissions`, `co-marketing`, `revops` | — | 6 |
| `product-architect` | `product-marketing`, `pricing`, `paywalls`, `aso` | — | 4 |
| `schedule-coordinator` | — | — | 0 |
| `strategy-analyst` | `marketing-psychology`, `pricing`, `marketing-ideas`, `marketing-plan` | `market-competitors`, `market-funnel` | 6 |

## Upstream Skill Kullanim Sikligi

Upstream repodan toplam 33 farkli skill en az bir agent'a bagli. Tekrar
edenler dahil 62 skill referansi var.

| Upstream Skill | Kullanan Agent Sayisi | Kullanan Agent'lar |
|---|---:|---|
| `ad-creative` | 2 | brand-guardian, campaign-manager |
| `ai-seo` | 2 | analytics-master, market-scout |
| `aso` | 2 | launch-commander, product-architect |
| `community-marketing` | 2 | growth-hacker, launch-commander |
| `directory-submissions` | 2 | launch-commander, outreach-specialist |
| `marketing-ideas` | 2 | growth-hacker, strategy-analyst |
| `paywalls` | 2 | growth-hacker, product-architect |
| `pricing` | 4 | investor-readiness-advisor, market-expansion-advisor, product-architect, strategy-analyst |
| `analytics` | 3 | analytics-master, investor-readiness-advisor, market-expansion-advisor |
| `churn-prevention` | 1 | growth-hacker |
| `co-marketing` | 1 | outreach-specialist |
| `cold-email` | 1 | outreach-specialist |
| `competitor-profiling` | 1 | market-scout |
| `competitors` | 1 | content-creator |
| `content-strategy` | 1 | content-creator |
| `copy-editing` | 1 | content-creator |
| `copywriting` | 1 | content-creator |
| `customer-research` | 2 | market-expansion-advisor, market-scout |
| `emails` | 1 | outreach-specialist |
| `image` | 1 | content-creator |
| `launch` | 1 | launch-commander |
| `lead-magnets` | 1 | content-creator |
| `marketing-plan` | 1 | strategy-analyst |
| `marketing-psychology` | 1 | strategy-analyst |
| `offers` | 1 | brand-guardian |
| `product-marketing` | 1 | product-architect |
| `prospecting` | 2 | market-expansion-advisor, outreach-specialist |
| `referrals` | 1 | growth-hacker |
| `revops` | 1 | outreach-specialist |
| `seo-audit` | 1 | launch-commander |
| `social` | 1 | content-creator |
| `video` | 1 | content-creator |
| `ads` | 1 | campaign-manager |

## Upstream Repoda Olup Agent'a Baglanmamis Skill'ler

Bu 12 skill upstream repoda mevcut ancak hicbir agent'in
`## Skills You Use` tablosunda yer almaz:

`ab-testing`, `cro`, `free-tools`, `onboarding`, `popups`,
`programmatic-seo`, `public-relations`, `sales-enablement`, `schema`,
`signup`, `site-architecture`, `sms`

## Skill Baglamayan Agent'lar

Asagidaki 3 agent `## Skills You Use` tablosu tasimaz; skill yerine
uzman rolu veya yonlendirici olarak calisir:

- `orchestrator` — Ana yonlendirici; pipeline ve skill'lere route eder.
- `onboarding-guide` — Karsilama ve pazarlamaci profil alimi.
- `schedule-coordinator` — Haftalik ve gunluk plan, Google Calendar senkronu.

## Ozet (v5.4.2)

- 15 agent, 12'si skill baglantisina sahip.
- 33 farkli upstream skill, 12 farkli local skill kullaniliyor (toplam 45 skill).
- En genis agent: `content-creator` (8 skill).
- En dar skill baglantilisi: `campaign-manager` (3 skill).
- v5.1.0 → v5.2.0: 28 upstream skill body guncellendi, 5 yeni upstream skill
  (co-marketing, competitors, lead-magnets, offers, revops) eklendi.
- v5.2.0 → v5.3.0: esnek calisma modlari, fikir degeri/marketer fit ayrimi,
  satis-modeli dogrulama birimleri ve semantik release kontrolleri eklendi.
- v5.3.0 → v5.4.2: marketer ozgurlugu, yanlis klasorde 3 secenekli kurtarma,
  ilk 10 dakika onboarding akisi, idea-value-first karar akisi, Post-MVP web app siniri,
  fundraising/investor readiness yuzeyi ve workspace-local update kontrolleri netlestirildi.
- 4 Codex-ozgu skill (seo-audit, competitor-profiling, ai-seo, aso) bu tur
  guncellenmedi; proje-ozgu Codex Evidence Rule bolumleri korundu.
