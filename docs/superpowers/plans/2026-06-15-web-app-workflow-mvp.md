# Web App Workflow MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Onaylanan Idea Pool, Project Pool, rol, degerlendirme, Drive, PWA bildirim ve durum makinesi tasarimini MVP mimari dokumanina eksiksiz islemek.

**Architecture:** Google Drive gercek proje dosyalarinin kaynagi olmaya devam eder. Web app kendi veritabaninda yalnizca is akisi, roller, degerlendirmeler, uyelikler, durumlar, baglantilar, bildirimler ve gecmis kayitlarini tutan mobil oncelikli bir PWA olur.

**Tech Stack:** Markdown mimari dokumani, Google Drive, Codex App, PWA, Web Push, iliskisel veritabani transaction ve benzersizlik kurallari.

---

### Task 1: Drive paylasim modelini web app akisiyla uyumlu hale getir

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Ortak fikir degerlendirme alanini Drive agacina ekle.
- [x] **Step 2:** Proje klasorunun ilk marketer alaninda kalmasi ve ekibe tek tek paylasilmasi kuralini yaz.

### Task 2: Web app MVP sozlesmesini yeniden yaz

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Web app/Drive veri sinirini tanimla.
- [x] **Step 2:** Kullanici rolleri ve yetki matrisini tanimla.
- [x] **Step 3:** Fikir surumleri ve marketer degerlendirmelerini tanimla.
- [x] **Step 4:** Project Pool uyelik, durum ve alan kurallarini tanimla.
- [x] **Step 5:** PWA push, bildirim merkezi ve aktivite akisini tanimla.
- [x] **Step 6:** Transaction, benzersizlik, gecmis ve arsiv kurallarini tanimla.

### Task 3: Baglantili MVP bolumlerini esitle

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Drive link modelini MVP kapsamiyla esitle.
- [x] **Step 2:** Marketer/coder ve gunluk kullanim akislarini yeni durum makinesine gore yaz.
- [x] **Step 3:** Riskler ve MVP disi maddeleri yeni web app kapsamina gore guncelle.
- [x] **Step 4:** Gelecek fazlar ve nihai MVP kararini web app'in artik kesin kapsam oldugunu gosterecek bicimde guncelle.

### Task 4: Dokuman dogrulamasi

**Files:**
- Verify: `mvp/mvp.md`

- [x] **Step 1:** Onaylanan web app gereksinimlerini metinde ara.
- [x] **Step 2:** Eski `fikri devral`, tek marketer/coder ve web app'i gelecege birakan ifadeleri temizle.
- [x] **Step 3:** Baslik sirasini ve Markdown code fence dengesini dogrula.
