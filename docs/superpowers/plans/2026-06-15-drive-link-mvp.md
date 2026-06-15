# Drive Link MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** MVP'nin Drive link modelini API'siz guvenli URL dogrulamasi, uc kosullu proje aktivasyonu ve manuel Drive erisim yonetimiyle netlestirmek.

**Architecture:** Web app Drive dosyalarina veya izinlerine API ile erismez. Kullanicinin ekledigi Google linkini yapisal olarak dogrular; script, senkronizasyon ve link kosullarini workflow verisi olarak izler.

**Tech Stack:** Markdown, Google Drive Desktop, Google Drive paylasim izinleri, web app workflow veritabani.

---

### Task 1: Drive link sozlesmesini guncelle

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Bolum 11 basligini MVP link modeline gore degistir.
- [x] **Step 2:** URL allowlist ve link turu dogrulamasini tanimla.
- [x] **Step 3:** Uc kosullu proje aktivasyon checklist'ini tanimla.
- [x] **Step 4:** Ortak rapor ve proje klasoru Drive rollerini tanimla.
- [x] **Step 5:** Uye ekleme, ayrilma ve host devir kurallarini tanimla.
- [x] **Step 6:** Google Picker'i sonraki faz notuna indir.

### Task 2: Baglantili kurallari esitle

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Bolum 10 durum gecisini uc kosullu aktivasyonla esitle.
- [x] **Step 2:** Bolum 12-13 Drive kurulum adimlarini checklist ile esitle.
- [x] **Step 3:** Risk bolumunu URL, rol ve erisim kaldirma kurallariyla esitle.
