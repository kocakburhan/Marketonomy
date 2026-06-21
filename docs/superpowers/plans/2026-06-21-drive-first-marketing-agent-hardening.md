# Drive-First Marketing Agent Hardening Plan

**Goal:** Marketing Agent'i ilk product fazinda web app'e bagimli olmayan, Codex + Google Drive
workspace modeliyle kurulup kullanilabilen hale getirmek; kalan teknik bosluklari testlenebilir
script ve sozlesmelerle kapatmak.

**Architecture:** Web app post-MVP/ileriki faz olarak dokumante edilir. Ilk fazda workspace
kimlikleri ve klasor yapisi onayli PowerShell create scriptleriyle lokal/Drive klasorunde
olusturulur. Installer sadece dogrulanmis evaluation/project workspace'e kurar. Agent davranis
paketi, operasyonel dosyalar arasindaki kimlik ve durum tutarliligini raporlayan bir
reconciliation scripti tasir.

**Tech Stack:** PowerShell create/install/update/reconcile scriptleri, Markdown contract dosyalari,
JSON state dosyalari, SHA-256 release manifest.

---

### Task 1: RED validation

- [ ] Create scriptlerinin ve reconciliation scriptinin varligini test kapisina ekle.
- [ ] Web app'in ilk faz zorunlulugu olmamasini semantik testle dogrula.
- [ ] Workspace creation testini yaz ve mevcut durumda RED oldugunu goster.

### Task 2: Drive-first contract cleanup

- [ ] `mvp/mvp.md` ilk faz sozlesmesini Codex + Google Drive olarak netlestir.
- [ ] Runtime agent dokumanlarindaki "web app tarafindan uretilen kimlik" ifadelerini "approved create flow" ile degistir.
- [ ] Web app/rol/uyelik/Drive host sinirlarini post-MVP veya manuel isletim karari olarak ayir.

### Task 3: Workspace create scripts

- [ ] `scripts/create-evaluation.ps1` ekle.
- [ ] `scripts/create-project.ps1` ekle.
- [ ] Ikisinin de local/Drive klasorunde guvenli workspace olusturmasini, base marketer profilini kopyalamasini ve kimlik/state eslesmesini sagla.

### Task 4: Reconciliation script

- [ ] `marketing-agent/scripts/reconcile-workspace-state.ps1` ekle.
- [ ] Evaluation/project tipi, kimlik eslesmesi, state JSON okunabilirligi ve operational dosya varligini raporla.
- [ ] Varsayilan davranisi read-only tut; agent'a sakli otomatik repair yaptirma.

### Task 5: GREEN validation

- [ ] Manifesti yenile.
- [ ] Compatibility, healthcheck, install/update, workspace create ve diff-check kapilarini calistir.
