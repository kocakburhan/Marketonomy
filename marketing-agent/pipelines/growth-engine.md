# Pipeline 4: Büyüme Motoru (Growth Engine)

**Zincirdeki yeri:** Zincir A ve D (P3'ten sonra, traction kazanınca).

**Ne zaman çalışır:** Ürün, hizmet, işletme veya B2B satış süreci traction kazandığında;
düzenli kullanıcı/müşteri/lead/ziyaretçi akışı olduğunda veya gelir oluşmaya başladığında.

**Amaç:** İş modeline uygun büyüme deneyleri tasarlayıp uygulayarak kullanıcı, müşteri, lead,
ziyaret, tekrar satın alma, pipeline veya geliri artırmak.

**Ön koşul:** Ürün/hizmet/satış süreci canlı, en az başlangıç metrikleri mevcut.

---

## Pipeline Akışı

```
Orchestrator: "Büyüme zamanı"
        │
        ▼
[4.1] Analytics Master → Mevcut metrikleri analiz et
        │  Çıktı: buyume-analizi.md
        ▼
[4.2] Growth Hacker → Büyüme deneyleri tasarla
        │  Çıktı: buyume-deneyleri.md
        ▼
[4.3] Orchestrator → Deneyleri kullanıcıya sun, seçtir
        │
        ▼
[4.4] Growth Hacker + Campaign Manager → Deneyleri uygula
        │  (Referans programı, churn önleme, topluluk, reklam)
        ▼
[4.5] Analytics Master → Deney sonuçlarını raporla
        │  Çıktı: deney-sonuclari.md
        ▼
[4.6] Orchestrator → Döngü kararı:
        ├── Başarılı → ölçekle, yeni deney tasarla
        └── Başarısız → analiz et, yeni deney tasarla
```

---

## Adım Detayları

### 4.1 — Büyüme Analizi
**Agent:** Analytics Master
**Girdi:** Kullanıcıdan alınan güncel metrikler
**Çıktı (`buyume-analizi.md`):**

```markdown
# Büyüme Analizi: [Ürün]
## AARRR Metrikleri
| Aşama | Metrik | Değer | Benchmark | Durum |
|-------|--------|-------|-----------|-------|
| Acquisition | İndirme/ziyaret | [x] | [x] | |
| Activation | Kayıt tamamlama | [%] | [%] | |
| Retention | D7/D30 | [%] | [%] | |
| Revenue | ARPU | [₺] | [₺] | |
| Referral | Viral katsayı | [x] | [x] | |

## Büyüme Fırsatları
[En düşük metrikten en yükseğe fırsat alanları]
```

Metrik modeli işe göre uyarlanır:

- B2C dijital: ziyaret, kayıt, activation, retention, ARPU, referral
- B2C fiziksel: temas, deneme/demo, satış, tekrar satın alma, yorum, kupon/QR dönüşümü
- B2B dijital: MQL, SQL, toplantı, demo, teklif, kazanılan müşteri, pipeline değeri
- B2B fiziksel/saha: hedef hesap, ziyaret, toplantı, demo günü, teklif, kanal/partner dönüşümü
- Hibrit: fiziksel temas + dijital nurture + satış/retention metrikleri birlikte

### 4.2 — Büyüme Deneyleri
**Agent:** Growth Hacker
**Çıktı (`buyume-deneyleri.md`):**
- Her deney için: hipotez, etki alanı, uygulama, süre, başarı kriteri, efor
- ICE skorlaması (Impact, Confidence, Ease)

### 4.3 — Deney Seçimi
**Agent:** Orchestrator
**Kullanıcıya sunulan seçenekler:** En az 3 deney, ICE skoruyla birlikte. Kullanıcı hangilerini uygulayacağını seçer.

### 4.4 — Deney Uygulama
**Agent:** Growth Hacker ve Campaign Manager playbooklarini koordine et
**Uygulanabilecek deney tipleri:**
- Referans programı (`referrals` skill)
- Churn önleme kampanyası (`churn-prevention` skill)
- Topluluk inşası (`community-marketing` skill)
- Paywall/upgrade CRO (`paywalls` skill)
- Reklam optimizasyonu (`ads` skill)
- Yaratıcı büyüme fikirleri (`marketing-ideas` skill)
- B2C fiziksel sadakat, kupon, lokasyon, etkinlik ve tekrar ziyaret deneyleri
- B2B demo, outbound mesaj, webinar, partner referral ve pipeline hızlandırma deneyleri

### 4.5 — Sonuç Raporu
**Agent:** Analytics Master
**Çıktı (`deney-sonuclari.md`):**
```markdown
# Deney Sonuçları: [Ürün]
| Deney | Hipotez | Süre | Sonuç | Başarı? | Öğrenilen |
|-------|---------|------|-------|---------|----------|
| ... | ... | [gün] | [metrik] | ✅/❌ | ... |
```

### 4.6 — Döngü Kararı
**Agent:** Orchestrator
- Başarılı deneyler → ölçeklendir, kalıcı hale getir
- Başarısız deneyler → neden analizi yap, pivot et
- Yeni deneyler tasarla → 4.2'ye dön

---

## Çıktı Dosyaları

| Dosya | Üreten |
|-------|--------|
| `buyume-analizi.md` | Analytics Master |
| `buyume-deneyleri.md` | Growth Hacker |
| `deney-sonuclari.md` | Analytics Master |

---

## Sonraki Adım

Pipeline 4 döngüseldir. Sürekli çalışır. Gerekirse **Pipeline 6 (Rakip Saldırı)** veya **Pipeline 8 (Outbound Satış)** ile desteklenir.

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: 03-strateji/buyume/, ilgili 06-pazarlama-uygulamalari/ klasorleri ve
  08-raporlar/analitik/
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
