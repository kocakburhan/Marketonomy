# Project Customization Governance Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** MVP dokumaninda proje ozellestirmelerini kullanici onayi, dosya sahipligi ve kesin talimat onceligiyle yonetmek.

**Architecture:** Insan tarafindan yonetilen proje gercekleri ve tercihler Markdown dosyalarinda; agent tarafindan yonetilen teknik durum JSON ve operasyon dosyalarinda tutulur. Overrides degisiklikleri hash ve karar kaydi ile denetlenir.

**Tech Stack:** Markdown, JSON, SHA-256, Codex workspace.

---

### Task 1: Proje dosyasi sahipligini netlestir

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** `overrides.md` dosyasini zorunlu ve kullanici onayli tercih dosyasi olarak tanimla.
- [x] **Step 2:** `state.json`, `active-task.md` ve `settings.json` dosyalarini agent/script yonetimli olarak tanimla.
- [x] **Step 3:** Manuel degisiklik algilama ve onay akisina hash takibi ekle.

### Task 2: Ozellestirme sozlesmesini yeniden yaz

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Talimat onceligini ve eksiksiz okuma sirasini tanimla.
- [x] **Step 2:** Overrides kapsam ve guvenlik sinirlarini tanimla.
- [x] **Step 3:** Degisiklik-onay-karar kaydi akisini tanimla.
- [x] **Step 4:** Proje bilgisini overrides orneginden kaldir.
