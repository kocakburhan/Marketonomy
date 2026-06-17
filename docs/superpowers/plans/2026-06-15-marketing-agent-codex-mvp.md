# Marketing Agent Codex ve MVP Uyumu Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `marketing-agent/` paketini pazarlama mantigini koruyarak Codex App ve `mvp/mvp.md` workspace sozlesmesiyle tam uyumlu bir release paketine donusturmek.

**Architecture:** Kok talimatlar workspace turunu ve guvenlik sinirlarini belirler; orchestrator uzman rol ve pipeline playbook'larini goreve gore yukler. Kalici durum workspace'in MVP dosyalarinda tutulur, release paketi ise `.pa/agent/` altinda degistirilebilir ve manifest ile dogrulanabilir kalir.

**Tech Stack:** Markdown agent/skill talimatlari, PowerShell saglik ve uyumluluk denetimleri, Python yardimci scriptleri, JSON release metadata, Codex AGENTS.md ve Agent Skills standardi.

---

### Task 1: Uyum Denetimi

**Files:**
- Create: `marketing-agent/scripts/test_mvp_compatibility.ps1`

- [ ] Zorunlu release ogelerini, yasakli eski runtime referanslarini, skill frontmatter'larini ve MVP yol sozlesmesini kontrol eden denetimi yaz.
- [ ] Denetimi mevcut paket uzerinde calistir ve OpenCode/session/frontmatter nedenleriyle basarisiz oldugunu dogrula.

### Task 2: Codex Bootstrap ve Orchestrator

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/ARCHITECTURE.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/agents/onboarding-guide.md`
- Modify: `marketing-agent/QUICKSTART.md`

- [ ] Degerlendirme ve proje workspace turu tespitini ekle.
- [ ] MVP okuma sirasi, kimlik kontrolu, override onayi ve dosya sahipligini tanimla.
- [ ] Eski session/proje olusturma davranisini kaldir.
- [ ] Uzman agent'lari Codex rol playbook'lari olarak koru ve subagent kullanimini istege bagli yap.

### Task 3: Agent ve Pipeline Cikti Sozlesmeleri

**Files:**
- Modify: `marketing-agent/agents/*.md`
- Modify: `marketing-agent/pipelines/*.md`

- [ ] Eski `sessions/` ciktilarini MVP klasorlerine esle.
- [ ] Pipeline on kosullarini `PROJE.md`, `01-baglam/`, `DEGERLENDIRME.md` ve workspace turune bagla.
- [ ] Her pipeline adiminda `DURUM.md`, `active-task.md`, haftalik plan ve kullanici onayi kurallarini uygula.

### Task 4: Codex Skill Standardi

**Files:**
- Modify: `marketing-agent/skills/*/SKILL.md`
- Create: `marketing-agent/skills/*/agents/openai.yaml`
- Modify: `marketing-agent/SKILLS.md`

- [ ] Her skill icin yalnizca `name` ve kapsamli `description` iceren frontmatter olustur.
- [ ] OpenCode/Webwright/Puppeteer/WebFetch komutlarini Codex arac secimiyle degistir.
- [ ] Urun baglami ve cikti yollarini MVP klasorlerine yonlendir.
- [ ] UI metadata dosyalarini skill icerigiyle uyumlu olustur.

### Task 5: MCP, Saglik ve Release Butunlugu

**Files:**
- Modify: `marketing-agent/mcps.json`
- Modify: `marketing-agent/scripts/healthcheck.ps1`
- Create: `marketing-agent/agent-version.json`
- Create: `marketing-agent/release-manifest.json`
- Create: `marketing-agent/scripts/build_release_manifest.ps1`

- [ ] MCP dosyasini Codex host yapilandirma rehberine donustur.
- [ ] Saglik kontrolunu opsiyonel araclari FAIL yerine capability olarak raporlayacak bicimde guncelle.
- [ ] Payload SHA-256 degerleriyle deterministik release manifesti uret.

### Task 6: Son Dogrulama

**Files:**
- Test: `marketing-agent/scripts/test_mvp_compatibility.ps1`
- Test: `marketing-agent/scripts/healthcheck.ps1`
- Test: `marketing-agent/scripts/*.py`

- [ ] Uyum denetimini calistir ve sifir hata dogrula.
- [ ] Manifesti yeniden uretip ikinci calistirmada degisiklik olmadigini dogrula.
- [ ] PowerShell parse ve Python compile kontrollerini calistir.
- [ ] `git diff --check` ve hedefli `rg` taramalariyla eski model kalintilarini incele.
