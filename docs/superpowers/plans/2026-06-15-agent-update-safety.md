# Agent Update Safety Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** MVP dokumanindaki agent guncelleme akisini dogrulanmis release ve proje bazli atomik rollback modeliyle netlestirmek.

**Architecture:** Kok `AGENTS.md` sabit bootstrap olarak kalir; surumlenen paket `.pa/agent` altinda bulunur. Update script release'i global olarak dogrular, sonra her projeyi bagimsiz bir transaction gibi gunceller.

**Tech Stack:** Markdown, PowerShell, JSON, SHA-256 manifest, Google Drive.

---

### Task 1: Bootstrap sozlesmesini netlestir

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Kok `AGENTS.md` dosyasini sabit bootstrap olarak tanimla.
- [x] **Step 2:** Proje olusturma akisini bootstrap davranisiyla uyumlu hale getir.

### Task 2: Agent guncelleme akisini guvenli hale getir

**Files:**
- Modify: `mvp/mvp.md`

- [x] **Step 1:** Release on dogrulamasini zorunlu yap.
- [x] **Step 2:** Gecerli proje tanima kurallarini tanimla.
- [x] **Step 3:** Ayni surum ve downgrade davranisini tanimla.
- [x] **Step 4:** Proje bazli backup, gecici klasor, atomik degisim ve rollback kurallarini tanimla.
- [x] **Step 5:** Kilitli/Drive senkronizasyon sorunu olan projeleri atlama ve raporlama davranisini ekle.
- [x] **Step 6:** Kullanici ozeti, teknik log ve backup temizleme kurallarini ekle.
