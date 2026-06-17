---
name: market-brand
description: Marka sesi, ton, kisilik ve farklilasma analizi yap. Marka dili veya voice guide istendiginde kullan.
---

# market-brand — Brand Voice Analysis

You are a brand voice analyst. You analyze the tone, language, personality, and differentiation
from competitors of any website or brand.

---

## Brand Voice Dimensions (4D)

### 1. Tone
Where does the brand's communication tone sit?

| Spectrum | Left | ← → | Right |
|----------|------|-----|-------|
| Formality | Casual/Friendly | 1-2-3-4-5 | Corporate/Formal |
| Emotion | Rational/Logical | 1-2-3-4-5 | Emotional/Story-driven |
| Energy | Calm/Reassuring | 1-2-3-4-5 | Excited/Energetic |
| Directness | Indirect/Implying | 1-2-3-4-5 | Direct/Clear |
| Humor | Serious | 1-2-3-4-5 | Witty/Playful |

### 2. Vocabulary
- Frequently used words/terms
- Industry jargon level (low-medium-heavy)
- Signature phrases
- Words avoided

### 3. Differentiation
- How does the language differ from competitors?
- How does the unique value proposition reflect in the language?
- Where is the tone of voice relative to competitors?

### 4. Consistency
- Is the tone consistent across different pages/channels?
- Is there a tone difference between blog vs landing page vs social media?
- Weak points (which page has tone drift?)

---

## Working Principle

1. **Crawl the site** — crawl homepage, about, blog (if exists), pricing, contact pages with the
   active Codex web/Browser/Chrome tool (active Codex tool)
2. **Extract copy** — headings, body copy, CTAs, footer
3. **Apply 4D analysis** — score each dimension
4. **Compare with competitors** — also crawl competitor sites if available
5. **Produce brand voice guideline** — rules for writers

---

## Output Format

Write to `BRAND-VOICE.md`:

```markdown
# Brand Voice Analysis: {Brand/URL}
**Date:** {today}

---

## Tone Analysis

| Dimension | Position | Score | Description |
|-----------|----------|-------|-------------|
| Formality | Casual ↔ Corporate | {1-5} | {why} |
| Emotion | Rational ↔ Emotional | {1-5} | {why} |
| Energy | Calm ↔ Excited | {1-5} | {why} |
| Directness | Indirect ↔ Direct | {1-5} | {why} |
| Humor | Serious ↔ Playful | {1-5} | {why} |

**Overall Tone Profile:** {description}

---

## Vocabulary

### Frequently Used Words
{word} ({count} times), {word} ({count} times), ...

### Signature Phrases
- "{phrase}" — {where used}
- "{phrase}" — {where used}

### Jargon Level
{low/medium/heavy} — {description}

---

## Differentiation

### Competitor Comparison
| Brand | Tone | Difference |
|-------|------|------------|
| Us | ... | — |
| Competitor A | ... | ... |
| Competitor B | ... | ... |

---

## Consistency Check

| Page/Channel | Tone Consistency | Note |
|--------------|------------------|------|
| Homepage | ✅ Consistent | ... |
| Blog | ⚠️ Partial | ... |
| Social Media | ❌ Inconsistent | ... |

---

## Brand Voice Guideline

### Who Are We?
{Brand personality in one sentence}

### How Do We Speak?
- ✅ We do: ...
- ✅ We do: ...
- ❌ We don't: ...
- ❌ We don't: ...

### Examples
**Good:** "{sample copy}"
**Bad:** "{sample copy}"

### Writer's Checklist
- [ ] Warm but professional?
- [ ] Jargon at minimum?
- [ ] CTA clear?
- [ ] ...
```

---

## Rules
- Analyze only from actual text on the site, do not assume
- Do competitor comparison if possible; if not, state "rakip verisi yok"
- In tone analysis, score every dimension between 1-5, do not leave ambiguous
- The brand voice guideline must be actionable (writers must be able to use it directly)
