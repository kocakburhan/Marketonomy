# Pipeline 2: MVP Lansman (MVP Launch)

**Zincirdeki yeri:** Zincir A ve B (P1/P5'ten sonra, coder MVP'yi teslim edince).

**Ne zaman çalışır:** Coder MVP'yi teslim ettiğinde, kullanıcı "MVP hazır" dediğinde veya
B2B/B2C dijital, fiziksel ya da hibrit bir teklif ilk kez pazara çıkarılacak hale geldiğinde.

**Amaç:** MVP'yi, fiziksel ürünü, hizmet teklifini veya B2B satış paketini pazarlamak için
strateji, içerik, reklam, saha/kanal ve lansman planı oluşturmak.

**Ön koşul:** Pazara çıkarılacak şey hazır olmalı: app/web MVP, fiziksel ürün, pilot hizmet,
B2B demo/teklif paketi veya etkinlik/aktivasyon planı. `PROJE.md`, ilgili `01-baglam/` dosyaları
ve varsa `04-urun/prd/` veya teklif/MVP dokümanları mevcut olmalı.

---

## Pipeline Akışı

```
Kullanıcı: "MVP hazır"
        │
        ▼
[2.1] Orchestrator → MVP detaylarını kullanıcıdan al
        │  Sorular: link, özellik listesi, bilinen bug'lar, eksikler
        ▼
[2.2] Strategy Analyst → MVP'ye özel pazarlama stratejisi
        │  Çıktı: marketing-strategy.md
        ▼
[2.3] Content Creator → Lansman içeriklerini üret
        │  Çıktı: content-calendar.md, social post'lar, email dizileri
        ▼
[2.4] Campaign Manager → Reklam kampanyası tasarla
        │  Çıktı: ad-campaigns.md, ad-creatives.md
        ▼
[2.5] Launch Commander → Lansman checklist'i oluştur
        │  Çıktı: launch-plan.md, launch-checklist.md
        ▼
[2.6] Orchestrator → Tüm planı kullanıcıya sun, onay al
        │
        ▼
[2.7] Launch Commander → Lansmanı başlat
           (Kullanıcıya adım adım yapılacakları ilet)
```

---

## Adım Detayları

### 2.1 — MVP Detaylarını Toplama
**Agent:** Orchestrator

```
MVP detaylarını alabilir miyim? İhtiyacım olanlar:

ZORUNLU:
• App/ürün adı
• Pazara çıkış formatı: app/web, fiziksel ürün, hizmet, B2B demo/teklif, etkinlik veya hibrit
• Link, satış noktası, lokasyon, demo yolu veya teklif dosyası
• MVP/teklif kapsamında neler var? (kısaca liste)
• Hangi özellikler/hizmetler/kapsamlar eksik? (ileride eklenecek)

OPSİYONEL (varsa):
• Bilinen bug'lar neler?
• Coder'ın eklemek istediği notlar var mı?
• Test kullanıcılarından gelen ilk izlenimler?
```

### 2.2 — Pazarlama Stratejisi
**Agent:** Strategy Analyst
**Girdi:** `04-urun/prd/ altindaki guncel PRD`, `pazara-giris-stratejisi.md` (varsa), MVP detayları

**Çıktı (`marketing-strategy.md`):**
```markdown
# Pazarlama Stratejisi: [Ürün] v1.0
## Hedef Kitle
- Primer segment: ...
- Sekonder segment: ...

## Konumlandırma
[1 cümle]

## Lansman Kanalları (öncelikli)
1. [kanal] — [neden, hedef]
2. ...

## Model Uyarlaması
- Müşteri modeli: [B2B/B2C/Hibrit]
- Kanal modeli: [Dijital/Fiziksel/Hibrit]
- Satış hareketi:
- Gerekli saha/dijital destek:

## Lansman Zamanlaması
- D-14: ...
- D-7: ...
- D-Day: ...
- D+7: ...

## Bütçe Planı
| Kalem | Bütçe | Beklenen Dönüş |
|-------|-------|---------------|
| Reklam | ₺xxx | [hedef] |
| ... | ... | ... |

## Başarı Metrikleri
| Metrik | 7 gün | 30 gün | 90 gün |
|--------|-------|--------|--------|
| İndirme | [x] | [x] | [x] |
| DAU | [x] | [x] | [x] |
| Gelir | [₺] | [₺] | [₺] |
```

### 2.3 — Lansman İçerikleri
**Agent:** Content Creator
**Paralel görevler (hepsi aynı anda yapılabilir):**

- `social_calendar.py` ile 30 günlük sosyal medya takvimi
- App Store / Google Play açıklaması (ASO optimize)
- Lansman email dizisi (email-launch template)
- Landing page kopyası (varsa web sitesi)
- Sosyal medya lansman post'ları
- Tanıtım videosu senaryosu (video skill)
- Fiziksel ürün/hizmet ise afiş, broşür, QR/kupon ve saha script'i
- B2B ise demo daveti, toplantı mesajı, teklif özeti ve LinkedIn/email içerikleri

**Çıktılar:**
- `content-calendar.md`
- `content/social-post-*.md`
- `content/email-launch.md`
- `content/aso-metni.md`

### 2.4 — Reklam Kampanyası
**Agent:** Campaign Manager
**Çıktılar:**
- `ad-campaigns.md` — platform seçimi, bütçe, kampanya yapısı
- `ad-creatives.md` — 3+ varyant (her platform için)
- B2B ise `b2b-talep-yaratma-plani.md`
- Fiziksel/hibrid ise `fiziksel-b2c-kampanya-plani.md` veya saha destek kampanyası

### 2.5 — Lansman Planı ve Checklist
**Agent:** Launch Commander
**Çıktılar:**
- `launch-plan.md` — lansman özeti, kanallar, takvim, metrik hedefleri
- `launch-checklist.md` — 8 haftalık detaylı checklist (template'ten doldurulur)

### 2.6 — Onay
**Agent:** Orchestrator

```
📋 LANSMAN PAKETİ HAZIR

İşte lansman için hazırladıklarımız:
• Pazarlama stratejisi → [dosya]
• İçerik takvimi (30 gün) → [dosya]
• Reklam kampanyası → [dosya]
• Lansman planı → [dosya]

Toplam tahmini bütçe: ₺xxx

Onaylıyor musun? Lansmanı başlatalım mı?
```

### 2.7 — Lansman
**Agent:** Launch Commander
Lansman günü adım adım yapılacakları kullanıcıya iletir.

---

## Karar Noktaları

| Adım | Karar |
|------|-------|
| 2.6 | Lansman planını onayla / revize et |

---

## Çıktı Dosyaları

| Dosya | Üreten |
|-------|--------|
| `marketing-strategy.md` | Strategy Analyst |
| `content-calendar.md` | Content Creator |
| `content/social-post-*.md` | Content Creator |
| `content/email-launch.md` | Content Creator |
| `content/aso-metni.md` | Content Creator |
| `ad-campaigns.md` | Campaign Manager |
| `ad-creatives.md` | Campaign Manager |
| `launch-plan.md` | Launch Commander |
| `launch-checklist.md` | Launch Commander |
| Fiziksel/B2B destek materyalleri | İlgili uzmanlar |

---

## Sonraki Pipeline

Lansmandan 2-4 hafta sonra → **Pipeline 3 (Feedback ve İyileştirme)** başlar. Veya kullanıcı "feedback toplamaya başlayalım" dediğinde.

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: 07-lansman/ ve ilgili 06-pazarlama-uygulamalari/ klasorleri
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
