---
name: social
description: LinkedIn, X, Instagram ve TikTok icin sosyal medya stratejisi, platform postlari, icerik takvimi ve gorsel uretim akisi hazirla. Sosyal post, yayin plani, carousel veya gorsel icerik istendiginde kullan.
---

# Social Media Content Strategy

Social media content specialist. Goal: produce platform-specific, engagement-driving social media
content that clearly conveys the brand promise.

## Before Starting

1. Read the product, target audience, value proposition, and brand tone from `PROJE.md`,
   `DEGERLENDIRME.md`, `01-baglam/`, or relevant marketing strategy files in the workspace.
2. Determine platforms: LinkedIn, X, Instagram, TikTok, or the channel specified by the user.
3. Clarify what the target audience is looking for on the platform, what objections they hold,
   and which CTA is appropriate.
4. Use the `image` skill for every post that requires a visual.

## Platform-Based Strategy

### LinkedIn
- Use a professional but warm tone.
- Prefer long-form text, story, insight, framework, and carousel formats.
- Plan 2-3 posts per week.
- Match the CTA to the goal: comment, demo, waitlist, or resource download.

### X
- Write short, direct, and rhythmic.
- Use threads for educational content.
- Plan 1-2 posts per day.
- Add quick reactions that connect current topics to the brand promise.

### Instagram
- Work visual-first.
- Clearly separate feed, carousel, story, and reels.
- Use aesthetic consistency, a repeating color palette, and a readable text layer.
- Suggest poll, question, or link sticker CTAs for stories.

### TikTok / Reels
- Build curiosity or tension in the first 2 seconds.
- Write a single-message, fast-paced script.
- Produce on-screen text, scene flow, and caption together.

## Content Categories

| Category | Ratio | Content Type |
|----------|------:|--------------|
| Education / Value | 40% | How-to, framework, data, insight |
| Social Proof | 20% | Customer success, case study, testimonial, UGC |
| Thought Leadership | 15% | Industry insight, future prediction |
| Company / Culture | 15% | Behind-the-scenes, team, values |
| Product / Promotion | 10% | New feature, use case, demo |

## Content Calendar Format

Produce the following fields for each post:

- **Platform:** Which platform or platforms.
- **Format:** Text, single image, carousel, video, story, or thread.
- **Hook:** Attention-grabbing first line.
- **Content:** Platform-appropriate body copy.
- **Hashtags:** Platform-appropriate targeted hashtags.
- **CTA:** What the user should do.
- **Best posting time:** Time suggestion appropriate for the audience.
- **Visual Brief:** Short creative direction if a visual is needed.
- **Visual Prompt:** Comprehensive prompt for Codex image generation.
- **Visual File:** File path of the generated visual, or "uretim bekliyor" note if the image
  generation tool is not active.

## Codex Image Generation Mandate

When a social media post requires a visual, carousel cover, ad creative, or story visual, do not
stop at writing a brief. For every visual post:

1. Use the `image` skill.
2. Select the platform ratio:
   - Instagram feed: 1080x1080 or 1080x1350
   - Instagram story/reels cover: 1080x1920
   - LinkedIn: 1200x627
   - X: 1200x675
   - Ad creative: ratio from the platform brief
3. Automatically write a comprehensive image prompt including brand, target audience, core
   message, composition, color palette, style, lighting, emotion, text placement, and elements
   to avoid.
4. Generate the visual using the active image generation flow within Codex.
5. Add the `Gorsel Promptu`, `Uretim Notlari`, and `Gorsel Dosyasi` fields to the post file.

If the image generation tool is not active in the Codex session, do not write as if a visual has
been generated. Save the comprehensive prompt and brief, write that generation is pending in the
`Gorsel Dosyasi` field, and inform the user that an active Codex image generation flow is needed.

## Comprehensive Image Prompt Template

```text
Create a [platform] marketing visual for [brand/product].
Goal: [campaign goal].
Audience: [target audience].
Core message: [one clear promise].
Format and size: [ratio/resolution].
Composition: [foreground, background, focal point, negative space].
Style: [photo/editorial/3D/flat/minimal/premium SaaS/etc.].
Brand cues: [colors, typography feeling, tone, logo usage if allowed].
Text on image: [exact text or "no text"].
Mood and lighting: [emotion, lighting, contrast].
Avoid: unreadable text, fake logos, distorted faces/hands, copyrighted characters, off-brand colors.
```

## Hook Formulas

- "No one is talking about this but..."
- "You're doing [number] things wrong"
- "I wish someone had told me this [time] ago"
- "Unpopular opinion: [topic]"
- "The biggest loss for [target audience] is..."
