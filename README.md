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
| **Sürüm** | `v5.4.2` |
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
        ├── agents/              # 15 uzman rol
        ├── pipelines/           # 16 çok adımlı iş akışı
        ├── skills/              # 45 yerel pazarlama becerisi
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

### 15 Uzman Rol
Orkestratör, pazar gözcüsü, strateji analisti, ürün mimarı, kampanya yöneticisi,
içerik üretici, büyüme korsanı, lansman komutanı, analitik ustası, marka koruyucusu,
outreach uzmanı, pazar genişleme danışmanı, takvim koordinatörü, yatırımcı hazırlık
danışmanı ve daha fazlası.

### 16 Pipeline
Fikirden PRD'ye, fikir keşfi, rakip atağı/açığı, şikâyet madenciliği, içerik makinesi,
fon toplama hazırlığı, büyüme motoru, MVP lansmanı, outbound satış, mağaza istihbaratı,
trendden ürüne ve daha fazlası.

### 45 Beceri
Ürün pazarlama, rakip profilleme, SEO/ASO, metin yazarlığı, reklam, fiyatlandırma,
yatırımcı dokümanları, cold email, topluluk pazarlaması, tavsiye sistemleri, churn
önleme, analitik, raporlama ve daha fazlası.

### 14 Beceri Zinciri
B2B outbound, fon toplama hazırlığı, fikir keşfi, içerik yayınlama, büyüme deneyleri
gibi uçtan uca senaryolar.

Tüm beceri ve pipeline'lar **Kaynak ve Kanıt Defteri** ile **Veri İşleme Notları**
eşliğinde, kanıta dayalı çıktı üretir.

---

## Kurulum

```powershell
# Repoyu geçici konuma klonla
git clone <repo-url> temp-personalautonomy

# Mevcut bir proje workspace'ine kur
powershell -ExecutionPolicy Bypass -File temp-personalautonomy\scripts\install-marketing-agent.ps1 `
    -RepoUrl <repo-url> -Version latest

# Sıfırdan yeni proje workspace'i oluştur
powershell -ExecutionPolicy Bypass -File temp-personalautonomy\scripts\create-project.ps1 `
    -ProjectName "proje-adım" -ProjectsRoot "C:\Users\...\Projects"
```

Installer, hedefin geçerli bir proje workspace'i olduğunu (`PROJE.md` +
`.pa/project/state.json` kimlik eşleşmesi) doğrular, agent paketini atomik
olarak kopyalar, bootstrap `AGENTS.md` oluşturur ve `release-manifest.json`
ile SHA-256 bütünlük doğrulaması yapar. Mevcut proje dosyaları asla silinmez.

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
| `marketing-agent/ARCHITECTURE.md` | Mimari plan — paket/workspace ayrımı, uzman/beceri modelleri |
| `marketing-agent/SKILLS.md` | Tam beceri kataloğu — çıktı yolları, zincirler ve uzman atamaları |
| `marketing-agent/release-manifest.json` | Paketteki her dosya için SHA-256 bütünlük kaydı |
| `marketing-agent/agent-version.json` | Semantik sürüm + çalışma zamanı + MVP sözleşme tarihi |
| `scripts/install-marketing-agent.ps1` | Doğrulanmış, atomik agent kurulum betiği |
| `scripts/create-project.ps1` | Kimlik üretimi ve iskelet oluşturma ile tam workspace fabrikası |
| `REHBER.md` | Türkçe son kullanıcı onboarding rehberi |

---

## Belgeler

- [**REHBER.md**](REHBER.md) — Sıfırdan kurulum ve ilk kullanım için adım adım Türkçe rehber.
- [**marketing-agent/QUICKSTART.md**](marketing-agent/QUICKSTART.md) — Hızlı başlangıç ve zihinsel model.
- [**yapılacaklar.md**](yapılacaklar.md) — Teslim ve pilot kontrol listesi.

---

## Lisans

Özel mülkiyet. PersonalAutonomy MVP geliştirmesi için dahili kullanım.
