# PersonalAutonomy Marketing Agent

> **Codex App + Google Drive üzerinde çalışan, workspace-first yapay zekâ pazarlama ajanı.**
>
> Her proje klasörünün içinde yaşayan, dosya tabanlı bir pazarlama çalışma arkadaşı.
> Fikir değerlendirme, pazar araştırması, rakip analizi, PRD yazımı, kampanya planlama,
> haftalık iş planı, yatırımcı dokümanları ve raporlama için uçtan uca destek sunar.

---

## Genel Bakış

PersonalAutonomy Marketing Agent, pazarlamacıların kendi proje klasörlerine kurduğu
**kaynak ve dağıtım reposudur**. Agent, Google Drive for desktop ile senkronize edilen
yerel dosyalar üzerinden çalışır. Web uygulaması, merkezi panel veya sunucu yoktur —
her proje kendi kendine yeten bir klasördür ve kendi Codex workspace'i olarak açılır.

| | |
|---|---|
| **Sürüm** | `v5.5.0` |
| **Çalışma Zamanı** | Codex |
| **MVP Sözleşmesi** | 2026-06-21 |
| **Dil** | Türkçe (varsayılan kullanıcı dili) |

---

## Mimari

```
┌─────────────────────────────────────────────────┐
│                   Codex App                      │
│                                                  │
│  ┌────────────┐          ┌────────────────────┐  │
│  │ Projects/  │          │ Projects/<ad>/     │  │
│  │  ana kök   │          │  aktif workspace   │  │
│  │            │          │                    │  │
│  │ Onboarding │  create  │  .pa/agent/        │  │
│  │ Profil     │ ──────── │  .pa/project/      │  │
│  │ Pluginler  │          │  00-99 klasörleri  │  │
│  └────────────┘          │  AGENTS.md         │  │
│                          └────────────────────┘  │
└─────────────────────────────────────────────────┘
                           │
                     ┌─────┴──────┐
                     │ Google Drive │
                     │  (desktop)   │
                     └─────────────┘
```

**Yalnızca iki Codex kökü vardır:**

- **`Projects/`** — onboarding, plugin kontrolü, yeniden kullanılabilir pazarlamacı profili
  ve yeni proje oluşturma.
- **`Projects/<proje-adı>/`** — tüm gerçek işin yapıldığı tek aktif workspace.

---

## Proje Workspace Yapısı

```
Projects/<ad>/
├── AGENTS.md                    # Bootstrap → .pa/agent/AGENTS.md'ye yönlendirir
├── PROJE.md                     # Kimlik kartı (project_id, idea_id, özet)
├── DURUM.md                     # Aktif pipeline, mevcut görev, sonraki adım
├── KARARLAR.md                  # Tüm kararlar ve gerekçeleri
├── 00-gelen-kutusu/             # Ham girdiler, notlar, bağlantılar
├── 01-bağlam/                   # Bağlam: kitle, marka, kısıtlar
├── 02-araştırma/                # Araştırma, fikir değerlendirme, rakip istihbaratı
├── 03-strateji/                 # Doğrulama, konumlandırma, fiyat, büyüme
├── 04-ürün/                     # PRD, coder brief, ürün kararları
├── 05-haftalık-planlar/         # Haftalık planlar (YYYY-WNN.md)
├── 06-pazarlama-uygulamaları/   # Dijital, saha, hibrit pazarlama
├── 07-lansman/                  # Lansman
├── 08-raporlar/                 # Raporlar, analitik, yatırımcı dokümanları
├── 09-varlıklar/                # Varlıklar
├── 10-final/                    # Yalnızca onaylanmış nihai teslimler
├── 11-notlar/                   # Notlar ve LLM-wiki bilgi haritası
├── 99-arşiv/                    # Arşiv
└── .pa/
    ├── project/                 # Değişmez proje durumu
    │   ├── state.json
    │   ├── marketer-profile.md
    │   └── settings.json
    └── agent/                   # Sürümlü agent paketi
        ├── AGENTS.md
        ├── agents/              # 15 agent
        ├── pipelines/           # 16 çok adımlı pipeline
        ├── skills/              # 45 yerel marketing skill
        └── scripts/             # Güncelleme, sağlık kontrolü, araçlar
```

---

## Üç AGENTS.md Seviyesi

| Seviye | Konum | Görev |
|--------|-------|-------|
| **1. Repo kökü** | `AGENTS.md` | Bu repository üzerinde çalışan Codex'i yönetir — release kuralları, doğrulama, test |
| **2. Agent paketi** | `marketing-agent/AGENTS.md` | Çalışma zamanı davranış sözleşmesi — her projeye `.pa/agent/AGENTS.md` olarak kurulur |
| **3. Bootstrap** | Proje kökü `AGENTS.md` | `.pa/agent/AGENTS.md` dosyasına kısa yönlendirme + workspace izolasyon kuralları |

**Yetki zinciri:** `mvp/mvp.md` mimari kararlar için → `marketing-agent/AGENTS.md` çalışma
zamanı davranışı için. Çelişkiler sessizce çözülmez; kullanıcıya gösterilir.

---

## Agent Yetenekleri

### 15 Agent
Orchestrator, Market Scout, Strategy Analyst, Product Architect, Campaign Manager,
Content Creator, Growth Hacker, Launch Commander, Analytics Master, Brand Guardian,
Outreach Specialist, Market Expansion Advisor, Schedule Coordinator, Investor Readiness
Advisor ve daha fazlası.

### 16 Pipeline
idea-to-PRD, idea-discovery, competitor-attack/gap, complaint-mining, content-machine,
fundraising-readiness, growth-engine, MVP-launch, outbound-sales, store-intelligence,
trend-to-product ve daha fazlası.

### 45 Skill
product-marketing, competitor-profiling, SEO/ASO, copywriting, ads, pricing,
investor-documents, cold-email, community-marketing, referrals, churn-prevention,
analytics, reporting ve daha fazlası.

### 14 Skill Chain
B2B outbound, fundraising readiness, idea discovery, content publishing, growth
experimentation gibi uçtan uca senaryolar.

Tüm skill ve pipeline'lar **Kaynak ve Kanıt Defteri** ile **Veri İşleme Notları**
eşliğinde, kanıta dayalı çıktı üretir.

---

## LLM-Wiki Output Memory

Proje, [Andrej Karpathy'nin llm-wiki yaklaşımından](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
esinlenen bir **türetilmiş çıktı hafıza katmanı** içerir. Bu katman, ham dosyaların
yerine geçmez; kaynak kanıtlar, kanonik çıktılar, kararlar, çelişkiler ve yeniden
kullanım ilişkileri arasında bir **bilgi haritası** görevi görür.

### Yapı

Proje workspace'inde `11-notlar/bilgi-haritasi/` altında üç bileşenden oluşur:

| Dosya | Görev |
|-------|-------|
| `index.md` | İçerik haritası — tüm sayfaların ve ilişkilerin navigasyonu |
| `log.md` | Kronolojik işlem günlüğü — hangi kararın ne zaman alındığı |
| `sayfalar/` | Konu bazlı wiki sayfaları — varlık, konsept, karar ve ders sayfaları |

Fikir değerlendirme modunda bu katman `02-arastirma/fikir-degerlendirme/bilgi-haritasi/`
altında çalışır.

### Çalışma Prensibi

- **Kaynak değil haritadır:** Ham kaynaklar ve kanonik çıktılar kendi klasörlerinde
  kalır; `bilgi-haritasi` yalnızca bunlar arasındaki ilişkileri, bağlantıları ve
  çelişkileri kaydeder.
- **Her çıktı değil, kalıcı çıktı:** Yalnızca araştırma, strateji, PRD, final
  teslim veya karar değiştiren nitelikteki *kalıcı* çıktılar haritaya işlenir.
- **Çelişkiler işaretlenir:** Birbiriyle çelişen bulgular sessizce silinmez;
  açıkça işaretlenir.
- **Skill çıktılarıyla entegre:** Herhangi bir skill kalıcı bir çıktı ürettiğinde,
  orchestrator agent `bilgi-haritasi`'ni de günceller.

### Arama ve Geri Çağırma Akışı

Büyük strateji, PRD, lansman, yatırımcı veya haftalık planlama işlerinden önce
agent şu sırayla okur:

```
index.md  →  log.md  →  ilgili sayfalar  →  kanonik dosyalar
```

Bu akış, agent'ın geçmiş kararları ve birikmiş bağlamı gözden kaçırmadan çalışmasını
sağlar. Uyumluluk testleri (`test_mvp_compatibility.ps1`) bu katmanın varlığını
zorunlu bir sözleşme maddesi olarak denetler.

---

## Kurulum

Marketer'ların sistemi nasıl kuracağı ve kullanacağı adım adım
[REHBER.md](REHBER.md) dosyasında anlatılmaktadır. Özet akış:

1. Google Drive ile senkronize bir `Projects/` ana klasörü oluşturulur.
2. Codex App'te `Projects/` kök olarak açılır.
3. GitHub repo linki ile onboarding prompt'u verilir. Codex önce Windows'ta
   `install-projects-root.ps1`, macOS'ta `install-projects-root.sh` kullanarak
   `Projects/AGENTS.md`, `Projects/onboarding-guide.md` ve onboarding metadata/update
   dosyalarını kurar.
4. Plugin kontrolü ve marketer profili tamamlanır. Profil standart sorularla sınırlı değildir;
   kullanıcının gönüllü verdiği ek çalışma veya erişilebilirlik bağlamı da korunur.
5. Codex resmi `create-project.ps1/.sh` akışıyla ilk projeyi oluşturur.
6. Oluşturulan `Projects/<proje-adı>/` klasörü yeni Codex workspace olarak açılır
   ve tüm çalışma burada yürütülür.

Installer, hedefin geçerli bir proje workspace'i olduğunu (`PROJE.md` +
`.pa/project/state.json` kimlik eşleşmesi) doğrular, agent paketini atomik
olarak kopyalar, bootstrap `AGENTS.md` oluşturur ve `release-manifest.json`
ile SHA-256 bütünlük doğrulaması yapar. Mevcut proje dosyaları asla silinmez.

macOS kullanan marketer'lar ayni akis icin `.sh` dosyalarini kullanir:

```bash
./scripts/create-project.sh --target-root "$HOME/Projects/x-projesi" --repo-url <GITHUB_REPO_URL> --version latest
./scripts/install-marketing-agent.sh --target-root "$HOME/Projects/x-projesi" --repo-url <GITHUB_REPO_URL> --version latest
```

---

## Doğrulama

Agent paketinde yapılan her değişiklikten sonra şunları çalıştırın:

```powershell
# Release manifestini yenile
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot .\marketing-agent

# MVP uyumluluk kontrolü
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent

# Agent sağlık kontrolü
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent

# Kurulum + güncelleme entegrasyon testi
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1

# Workspace oluşturma testi
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1

# macOS script sozlesmesi
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_macos_scripts.ps1
```

---

## Kritik Sınırlar

| Kural | Uygulama |
|-------|----------|
| Agent workspace kökünü asla terk etmez | Bootstrap `AGENTS.md` izolasyon kuralları |
| Agent paketi vs. kullanıcı verisi ayrımı | `.pa/agent/` yalnızca davranış; çıktılar numaralı klasörlere yazılır |
| Güncellemeler proje verisini korur | `update-agent.ps1` yalnızca `.pa/agent/` dizinini değiştirir |
| Sahte ilerleme yok | Eksik araç/plugin → boşluk belirtilir, manuel yedek yol sunulur |
| Nihai teslim onay gerektirir | `10-final/` yalnızca açıkça onaylanmış çıktıları alır |
| Türkçe önceliklidir | Sohbet, dosya ve teslimler için varsayılan kullanıcı dili |
| Release manifest bütünlüğü | SHA-256 doğrulanmazsa kurulum/güncelleme başarısız olur |

---

## Ana Dosyalar

| Dosya | Amaç |
|-------|------|
| `mvp/mvp.md` | Yetkili mimari sözleşme — workspace modeli, Drive modeli, kapsam kararları |
| `marketing-agent/AGENTS.md` | Çalışma zamanı davranışı — sınırlar, çalışma modları, başlangıç sırası, kapanış kuralları |
| `marketing-agent/ARCHITECTURE.md` | Mimari plan — paket/workspace ayrımı, agent/skill modelleri |
| `marketing-agent/SKILLS.md` | Tam skill kataloğu — çıktı yolları, chain'ler ve agent atamaları |
| `marketing-agent/release-manifest.json` | Paketteki her dosya için SHA-256 bütünlük kaydı |
| `marketing-agent/agent-version.json` | Semantik sürüm + çalışma zamanı + MVP sözleşme tarihi |
| `scripts/install-marketing-agent.ps1` | Doğrulanmış, atomik agent kurulum betiği |
| `scripts/install-projects-root.ps1` | Windows ana Projects onboarding bootstrap installer'ı |
| `scripts/create-project.ps1` | Kimlik üretimi ve iskelet oluşturma ile tam workspace fabrikası |
| `scripts/install-marketing-agent.sh` | macOS icin dogrulanmis, atomik agent kurulum betigi |
| `scripts/install-projects-root.sh` | macOS ana Projects onboarding bootstrap installer'i |
| `scripts/create-project.sh` | macOS icin proje workspace fabrikasi |
| `REHBER.md` | Türkçe son kullanıcı onboarding ve kurulum rehberi |

---

## Belgeler

- [**REHBER.md**](REHBER.md) — Sıfırdan kurulum ve ilk kullanım için adım adım Türkçe rehber.
- [**marketing-agent/QUICKSTART.md**](marketing-agent/QUICKSTART.md) — Hızlı başlangıç ve zihinsel model.
- [**yapılacaklar.md**](yapılacaklar.md) — Teslim ve pilot kontrol listesi.

---

## Lisans

Özel mülkiyet. PersonalAutonomy MVP geliştirmesi için dahili kullanım.
