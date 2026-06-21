# Marketing Agent Skill Catalog

This release carries 45 local marketing skills. The main agent reads the
`skills/<skill>/SKILL.md` file of the skill appropriate for the task. Codex global or plugin
skills can be used as additional capabilities only if they appear in the active skill list; this
package does not assume they are installed.

## Active Codex Skills

`brainstorming` is not counted as a local marketing skill in this release. If it appears in the
active Codex skill list, the main agent should use it before finalizing open-ended creative or
strategic work with the marketer: campaign ideas, offer shaping, feature direction, validation
design, growth experiments, launch angles, content systems, or other ambiguous requests that need
2-3 approaches and user approval.

Use `brainstorming` as a conversation and decision layer. After the marketer approves a direction,
continue with the relevant bundled pipeline or local marketing skill. For example, a vague growth
request may use active `brainstorming` first, then `marketing-plan`, `marketing-ideas`,
`referrals`, `churn-prevention`, or `analytics` as needed. No-idea opportunity discovery still
uses `pipelines/idea-discovery.md` and its evidence pipelines.

## File System Rule

The "Default project output area" column in this catalog is for quick routing. The final filing
rule is always the MVP File-System Mastery in `.pa/agent/AGENTS.md` and the folder contract in
`mvp/mvp.md`.

When the main agent runs a skill, it first determines the workspace type:

- In an evaluation workspace, skill outputs are not written outside `kaynaklar/`, `ciktilar/`,
  `RAPOR.md`, `DURUM.md`, and `.pa/evaluation/`.
- In a project workspace, raw inputs are preserved inside `00-gelen-kutusu/`; processed outputs
  are written to one of the numbered folders according to the context, research, strategy,
  product, execution, launch, report, asset, final, or archive type.
- `10-final/` is only for deliveries that have received explicit final approval; the source
  working file stays in its canonical folder.
- Every skill tied to a weekly task tracks the active `05-haftalik-planlar/YYYY-WNN.md` task
  consistently with `DURUM.md` and `.pa/project/active-task.md`. Workspace evidence closes the
  task automatically and the user is informed; an external action waits for user report; final
  publication or delivery always waits for explicit approval.

## Output Relationship Memory

Skill outputs stay in their canonical MVP folders; the relationship memory is an additional map,
not a new destination for the output itself. When a skill produces durable research, strategy,
MVP/PRD, main campaign plan, final report, final-delivery, decision-changing, or superseding
Markdown, the main agent
also updates the LLM-wiki style `bilgi-haritasi` for the active workspace:

- Evaluation workspace: `ciktilar/bilgi-haritasi/index.md` and `ciktilar/bilgi-haritasi/log.md`
- Project workspace: `11-notlar/bilgi-haritasi/index.md` and `11-notlar/bilgi-haritasi/log.md`

The map links source evidence, related outputs, decisions, next use, and contradictions. It must
not copy raw sources, hide conflicting claims, or move a skill output away from the folder chosen
by the MVP File-System Mastery rule.

Internal operating instructions are in English. The default user-facing language is Turkish. All
project folder and file names remain as they are.

## Context And Planning

| Skill | Task | Default project output area |
|---|---|---|
| `product-marketing` | Product, target audience, value proposition, and positioning context | `PROJE.md`, `01-baglam/` |
| `marketing-plan` | AARRR-based multi-channel marketing plan | `03-strateji/pazara-giris/`, `03-strateji/buyume/` |
| `marketing-ideas` | Context-appropriate campaign and experiment ideas | `03-strateji/buyume/` |
| `marketing-psychology` | Ethical behavioral economics and messaging principles | Relevant strategy or execution folder |
| `customer-research` | Interview, survey, JTBD, and feedback synthesis | `02-arastirma/musteri-arastirmasi/` |

## Research And Discoverability

| Skill | Task | Default project output area |
|---|---|---|
| `web-research` | Evidence-backed URL and web source research | Relevant `02-arastirma/` folder |
| `competitor-profiling` | Deep profile of a single competitor | `02-arastirma/rakip-arastirmasi/` |
| `market-competitors` | Multi-competitor comparison | `02-arastirma/rakip-arastirmasi/` |
| `seo-audit` | Technical and on-page SEO audit | `06-pazarlama-uygulamalari/dijital/seo/` |
| `ai-seo` | Visibility for AI search engines | `06-pazarlama-uygulamalari/dijital/seo/` |
| `aso` | App Store and Google Play optimization | `06-pazarlama-uygulamalari/dijital/seo/` |
| `directory-submissions` | Directory selection and submission tracking | `06-pazarlama-uygulamalari/dijital/` |

## Content And Brand

| Skill | Task | Default project output area |
|---|---|---|
| `content-strategy` | Topic, format, channel, and publishing rhythm | `06-pazarlama-uygulamalari/dijital/icerik/` |
| `copywriting` | Landing page and product page copy | `06-pazarlama-uygulamalari/dijital/landing-page/` |
| `copy-editing` | Improve existing marketing copy | Source file's working folder |
| `emails` | Lifecycle and campaign email sequences | `06-pazarlama-uygulamalari/dijital/eposta/` |
| `social` | Social media strategy and calendar | `06-pazarlama-uygulamalari/dijital/sosyal-medya/` |
| `market-brand` | Brand voice and differentiation analysis | `01-baglam/marka.md`, `09-varliklar/marka/` |
| `competitors` | Competitor comparison and alternative-page messaging | `06-pazarlama-uygulamalari/dijital/icerik/` |
| `lead-magnets` | Lead magnet concept, format, capture path, and follow-up | `06-pazarlama-uygulamalari/dijital/icerik/` |
| `offers` | Offer design, value framing, packaging, guarantees, and urgency | `03-strateji/konumlandirma/`, `03-strateji/fiyatlandirma/` |
| `image` | Comprehensive prompt and Codex image generation output | `09-varliklar/dijital/` or `09-varliklar/basili/` |
| `video` | Video strategy, script, and production brief | `06-pazarlama-uygulamalari/dijital/icerik/` |

## Advertising, Conversion, And Analytics

| Skill | Task | Default project output area |
|---|---|---|
| `ads` | Paid channel, targeting, and budget strategy | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `ad-creative` | Audience-specific creative and A/B variants | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `market-ads` | Platform-specific actionable ad package | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `market-funnel` | Funnel and conversion bottleneck analysis | `03-strateji/pazara-giris/` |
| `analytics` | Event tracking, KPI, and dashboard plan | `08-raporlar/analitik/` |
| `market-report` | Comprehensive decision-focused marketing report | `08-raporlar/pazarlama/` |
| `market-report-pdf` | PDF delivery from an approved Markdown report | `08-raporlar/pdf/` |

## Fundraising And Investor Readiness

| Skill | Task | Default project output area |
|---|---|---|
| `investor-documents` | Pitch deck, one-pager, executive summary, investor update, board deck, and business plan | `08-raporlar/yatirimci/` |
| `fundraising-financials` | Financial model, cap table, unit economics, revenue report, burn/runway, and use of funds | `08-raporlar/finansal/` |
| `investor-data-room` | Data room, due diligence pack, traction report, KPI dashboard, pipeline report, and cohort analysis | `08-raporlar/yatirimci/` |
| `investment-legal-drafts` | Term sheet and SHA business drafts with lawyer handoff checklist | `08-raporlar/yatirimci/legal/` |

## Growth, Sales, And Launch

| Skill | Task | Default project output area |
|---|---|---|
| `pricing` | Pricing, packaging, and monetization | `03-strateji/fiyatlandirma/` |
| `paywalls` | Paywall and upgrade conversion | `03-strateji/fiyatlandirma/` |
| `churn-prevention` | Cancellation, save offer, and reactivation | `03-strateji/buyume/` |
| `referrals` | Referral and invitation program | `03-strateji/buyume/` |
| `community-marketing` | Community and ambassador system | `06-pazarlama-uygulamalari/hibrit/` |
| `co-marketing` | Partner selection and joint campaign planning | `06-pazarlama-uygulamalari/hibrit/` |
| `prospecting` | ICP-based prospect list | `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/` |
| `cold-email` | B2B cold email and follow-up sequence | `06-pazarlama-uygulamalari/saha/takip/` |
| `market-proposal` | Marketing service proposal | `06-pazarlama-uygulamalari/saha/teklifler/` |
| `revops` | Lead lifecycle, scoring, handoff, and revenue operations | `03-strateji/pazara-giris/`, `08-raporlar/analitik/` |
| `launch` | Pre-launch, launch day, and post-launch | `07-lansman/` |

## Skill Chains

| Scenario | Local chain |
|---|---|
| Idea discovery | `web-research` -> `customer-research` -> `market-competitors` -> `marketing-ideas` -> `pricing` |
| Mobile app opportunity discovery | `web-research` -> `aso` -> `customer-research` -> `market-competitors` -> `pricing` |
| Complaint-based opportunity discovery | `web-research` -> `customer-research` -> `marketing-psychology` -> `marketing-ideas` |
| Idea validation | `web-research` -> `customer-research` -> `competitor-profiling` -> `pricing` |
| Product launch | `product-marketing` -> `launch` -> `emails` -> `social` -> `directory-submissions` |
| Content system | `content-strategy` -> `copywriting` -> `copy-editing` -> `seo-audit` |
| B2C digital marketing | `product-marketing` -> `content-strategy` -> `social` -> `ads` -> `analytics` |
| B2C physical marketing | `web-research` -> `market-competitors` -> `marketing-ideas` -> `copywriting` -> `image` -> `analytics` |
| B2B outbound and sales | `prospecting` -> `cold-email` -> `market-proposal` -> `ads` -> `analytics` |
| B2B field/partner sales | `prospecting` -> `market-proposal` -> `copywriting` -> `community-marketing` -> `analytics` |
| International market expansion | `web-research` -> `market-competitors` -> `customer-research` -> `pricing` -> `prospecting` -> `market-funnel` -> `analytics` |
| Fundraising readiness | `investor-data-room` -> `fundraising-financials` -> `investor-documents` -> `investment-legal-drafts` |
| Growth | `marketing-plan` -> `referrals` -> `churn-prevention` -> `analytics` |
| Competitor strategy | `web-research` -> `competitor-profiling` -> `market-competitors` -> `marketing-psychology` |
| Hybrid campaign | `marketing-plan` -> `social` -> `ads` -> `copywriting` -> `market-report` |

In an evaluation workspace, `ciktilar/` is used in place of these output paths and the synthesis
is written to `RAPOR.md`. `10-final/` is only for explicitly approved project deliveries.

## Specialist Roles And Plugin Capabilities

`market-expansion-advisor` is a specialist role under `agents/`, not a local skill under `skills/`.
Use it for country comparison, beachhead market selection, international GTM, localization,
technical globalization readiness, and 90-day foreign demand tests. It coordinates existing
research, strategy, outreach, product readiness, and analytics skills; it does not require a new
runtime or external MCP.

`schedule-coordinator` is a specialist role under `agents/`, not a local skill under `skills/`.
Use it for weekly plans, daily schedule files, task completion evidence, task postponement,
future-week moves, schedule intensity (`Aggressive`, `Balanced`, `Relaxed`), and Google Calendar
sync.

`investor-readiness-advisor` is a specialist role under `agents/`, not a local skill under
`skills/`. Use it for fundraising strategy, investor document sequencing, data room readiness,
diligence gaps, financial/document consistency review, and final investor-pack approval gates.

The MVP plugin set expected from marketers is Google Drive, Google Calendar, Gmail, Canva, Figma,
and GitHub. These plugins extend the local skills only when they are visible in the active Codex
tool list. If a plugin is missing, save the appropriate plan, prompt, draft, or backup instruction
inside the workspace file system and tell the user what manual action is needed.

Mixpanel, PostHog, Amplitude, and Airtable are not part of the MVP plugin setup. Treat them as
post-MVP analytics, data, and dashboard integration candidates.
