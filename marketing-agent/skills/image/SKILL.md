---
name: image
description: Pazarlama gorselleri icin kapsamli uretim promptu yaz ve Codex image generation akisiyla gorsel uret. Sosyal grafik, reklam gorseli, blog hero veya infografik istendiginde kullan.
---

# AI Visual Generation

Marketing-focused AI visual generation specialist. Blog hero, social media graphic, product screenshot, infographic.

## Codex Image Generation Flow

When the user requests a social media visual, ad visual, blog hero, infographic, or similar
marketing visual, do not stop at a brief. First automatically write the comprehensive generation
prompt, then generate the visual using the active image generation flow within Codex.

The generation prompt must combine the following information into a single prompt:
- Brand/product name, target audience, and core promise
- Platform and format: Instagram feed/story, LinkedIn, X, ad, blog hero, etc.
- Size/ratio: 1080x1080, 1080x1350, 1200x627, 1200x675, 1200x630, etc.
- Composition: focal object, background, negative space, room for text
- Style: photographic, editorial, minimal, 3D, flat illustration, premium SaaS UI, etc.
- Color palette, lighting, emotion, and brand tone
- If readable text is needed: exact text and placement; if not: "no text"
- Things to avoid: distorted hands/faces, illegible text, fake logos, copyrighted characters,
  off-brand style

If the image generation tool is not active, do not claim that real generation occurred; save the
comprehensive prompt, design brief, and which Codex image flow the user should manually use.
If the tool is active, generate the visual and add the prompt, variation notes, and generation
file path to the output.

## Mandatory Behavior for Social Media

When the `social` skill or Content Creator produces a social post and the post format includes a
visual:
1. Write the visual brief for each post.
2. Convert this brief into a platform-appropriate comprehensive image prompt.
3. Generate the visual using the Codex image generation flow.
4. Add the visual prompt and the resulting visual file path to the post file.

## Visual Types

| Type | Size | Usage |
|------|------|-------|
| Blog hero | 1200x630 (16:9) | Blog post, social share |
| Social graphic | 1080x1080 (1:1) or 1080x1350 (4:5) | Instagram, LinkedIn |
| Infographic | 800x2000 (vertical) | Blog, Pinterest |
| Thumbnail | 1280x720 (16:9) | YouTube |
| Ad banner | 1200x628 | Google Display, Meta |

## Prompt Writing

### Midjourney Prompt Formula
```
[Subject] + [Style] + [Composition] + [Color palette] + [Technical details] --ar [width-height] --v 6
```

**Example:**
```
Futuristic project management dashboard with AI holograms, clean interface, 
blue and purple gradient, minimalist style, isometric view --ar 16:9 --v 6
```

### DALL-E Prompt Formula
```
[Detailed scene description], [style], [lighting], [color], [composition]
```

## Visual Strategy

- **Consistency:** All visuals share the same style, color palette, typography
- **Brand:** Logo, colors, font
- **Emotion:** What emotion should it evoke?
- **Story:** What does the visual communicate?

## Usage Channels

| Channel | Optimal Size | Format |
|---------|-------------|--------|
| Blog | 1200x630 | JPEG/WebP |
| LinkedIn | 1200x627 | JPEG |
| Instagram Feed | 1080x1080 | JPEG |
| Instagram Story | 1080x1920 | JPEG |
| Twitter/X | 1200x675 | JPEG |
