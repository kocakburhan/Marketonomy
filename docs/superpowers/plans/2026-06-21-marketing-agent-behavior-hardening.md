# Marketing Agent Behavior Hardening Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Marketing Agent'i marketer'i destekleyen esnek bir calisma modeline gecirirken karar, gorev, profil, installer ve release sozlesmelerindeki semantik tutarsizliklari gidermek.

**Architecture:** Ana davranis sozlesmesi uc is modu tanimlayacak: dosya/state degistirmeyen `Quick advisory`, canonical cikti ve gerekli operasyonel durumu guncelleyen `Workspace task`, cok asamali ve kanit kapili `Pipeline`. Fikir degeri yalnizca pazar/fikir kanitlariyla kararlastirilacak; marketer uygunlugu ayri, danismanlik niteliginde bir yonlendirme olacak. Release testleri yalnizca dosya varligini degil, ortak sozlukleri ve celiskili kurallarin yoklugunu da denetleyecek.

**Tech Stack:** Markdown davranis sozlesmeleri, PowerShell installer ve regresyon testleri, JSON SHA-256 release manifesti.

---

### Task 1: Semantik regresyon testleri

**Files:**
- Modify: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Modify: `marketing-agent/scripts/healthcheck.ps1`
- Modify: `scripts/test_marketing_agent_install_update.ps1`

- [ ] Ortak karar sozlugunu, gorev kapanis kurallarini, uc calisma modunu, katalog kapsamlarini ve yasak eski ifadeleri kontrol eden testleri ekle.
- [ ] Installer'in gecersiz hedefi reddettigini; gecerli project/evaluation hedeflerini kabul ettigini test et.
- [ ] Testleri calistir ve yeni davranislar henuz uygulanmadigi icin beklenen RED sonucunu dogrula.

### Task 2: Esnek calisma modlari ve operasyonel kapsam

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/QUICKSTART.md`

- [ ] `Quick advisory`, `Workspace task` ve `Pipeline` secim kurallarini ekle.
- [ ] Basit islerde specialist/pipeline/state zorunlulugunu kaldir.
- [ ] `Validated`, `Assumption-led` ve `Urgent tactical` yurutme durumlarini tanimla; dusuk riskli taktik islerin genis validasyon eksigi nedeniyle engellenmesini onle.
- [ ] Tek cikti taleplerinin kapsamini otomatik genisleten evrensel katman kuralini daralt.
- [ ] Yalnizca gercek operasyonel degisikliklerde `DURUM.md`, `active-task.md`, state ve plan dosyalarini uzlastir.

### Task 3: Tek karar ve gorev sozlugu

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/SKILLS.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/agents/schedule-coordinator.md`
- Modify: `marketing-agent/agents/strategy-analyst.md`
- Modify: `marketing-agent/pipelines/*.md` (yalnizca eslesen karar/gorev ifadeleri)
- Modify: `marketing-agent/QUICKSTART.md`

- [ ] Karar degerlerini `Denenmeye Deger`, `Revizyonla Denenmeye Deger`, `Denenmeye Degmez` olarak tekilestir.
- [ ] Workspace kanitli gorevi otomatik kapat; harici aksiyonu kullanici bildirimi bekliyor durumunda tut; final yayin/teslim icin acik onay iste.
- [ ] `Kanıt ile Tamamlandı` degerini tek noktalama ve yazim bicimine getir.

### Task 4: Fikir degeri ve marketer uygunlugu ayrimi

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/agents/strategy-analyst.md`
- Modify: `marketing-agent/pipelines/idea-to-prd.md`
- Modify: `marketing-agent/pipelines/idea-discovery.md`
- Modify: `marketing-agent/pipelines/user-advantage-fit.md`

- [ ] Fikir degeri kararinda marketer profilini red nedeni olmaktan cikar.
- [ ] Marketer uygunlugunu ayri bir yonlendirme notu yap; dusuk uyumda temkin, mentor/uzman gorusu, partner veya kanal destegi oner.
- [ ] Sabit `ilk 10-50 kullanici` kapisini satis modeline gore B2C, SMB B2B, enterprise, fiziksel ve marketplace dogrulama birimlerine cevir.

### Task 5: Profil, bilgi haritasi ve katalog sadelestirmesi

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/SKILLS.md`
- Modify: `mvp/mvp.md`

- [ ] Marketer temel profilinin workspace olusturulurken kopyalanmasi sozlesmesini tanimla; proje dosyasinda yalnizca proje-ozel farklari tut.
- [ ] Yas ve egitimi istege bagli yap ve yalnizca karari etkiliyorsa nedenini acikla.
- [ ] Bilgi haritasini yalnizca arastirma, karar, strateji, MVP/PRD, ana kampanya, final rapor ve superseded ciktilar icin zorunlu tut.
- [ ] Eksik bes skill'i kataloga ekle ve mevcut olmayan `sales-enablement` yonlendirmelerini mevcut skill/routing ile degistir.

### Task 6: Installer hedef dogrulamasi

**Files:**
- Modify: `scripts/install-marketing-agent.ps1`
- Modify: `marketing-agent/QUICKSTART.md`
- Modify: `marketing-agent/templates/workspace-bootstrap-AGENTS.md` if required by final contract

- [ ] Hedefi project veya evaluation workspace kimlik dosyalari ve state dosyalariyla dogrula.
- [ ] Iki tur birden varsa, hicbiri yoksa veya state okunamiyorsa kurulumdan once acik hata ver.
- [ ] Mevcut guvenli bootstrap ve proje-verisi koruma davranisini degistirme.

### Task 7: GREEN ve release dogrulamasi

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [ ] Semantik ve installer testlerini calistir; tum yeni kontrolleri GREEN yap.
- [ ] `build_release_manifest.ps1` ile manifesti yenile.
- [ ] `test_mvp_compatibility.ps1`, `healthcheck.ps1` ve `test_marketing_agent_install_update.ps1` komutlarini temiz ortamda calistir.
- [ ] `git diff --check`, encoding taramasi ve degisiklik kapsam incelemesini tamamla.
