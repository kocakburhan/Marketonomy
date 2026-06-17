# Pipeline 3: Feedback ve İyileştirme (Feedback & Improvement)

**Zincirdeki yeri:** Zincir A, B ve C (P2 veya P9'dan sonra). Döngüsel — P3 → P5 veya P3 → P9 şeklinde tekrarlanır.

**Ne zaman çalışır:**
- Lansmandan 2-4 hafta sonra
- Kullanıcı "feedback toplayalım" dediğinde
- Her iyileştirme döngüsünde

**Amaç:** Kullanıcı, müşteri, lead, satış, saha ve kampanya geri bildirimlerini analiz edip
iyileştirme alanlarını belirlemek. Gerekiyorsa coder için güncellenmiş PRD üretir; fiziksel,
B2B veya kampanya süreçlerinde ise teklif, materyal, satış script'i, kanal stratejisi veya
operasyon planını günceller.

**Ön koşul:** Ürün, hizmet, kampanya veya satış süreci kullanıcı/müşteri/lead ile temas etmiş
olmalı.

---

## Pipeline Akışı

```
Orchestrator: "Feedback toplama zamanı"
        │
        ▼
[3.1] Orchestrator → Kullanıcıdan temel metrikleri iste
        │  Sorular: indirme, yorum, gelir, ziyaretçi, sosyal medya etkileşimi
        ▼
[3.2] Market Scout → Kullanıcı yorumlarını analiz et
        │  Kaynaklar: App Store, Google Play, Google Maps, forumlar, sosyal medya
        │  Çıktı: yorum-analizi.md
        ▼
[3.3] Analytics Master → Metrik analizi yap
        │  Çıktı: analytics-raporu.md
        ▼
[3.4] Strategy Analyst → İyileştirme alanlarını belirle
        │  Çıktı: iyilestirme-onerileri.md
        ▼
[3.5] Orchestrator → Bulguları kullanıcıya sun, öncelikleri sor
        │
        ▼
[3.6] Orchestrator → İyileştirme türünü seç
        │  Ürün/teknik ise Product Architect → prd-v2.md
        │  Pazarlama/saha/satış ise ilgili uzman → revizyon dosyaları
        ▼
[3.7] Orchestrator → Uygulama brief'ini hazırla
           Çıktı: coder-brief-v2.md veya pazarlama-iyilestirme-briefi.md
```

---

## Adım Detayları

### 3.1 — Metrik Toplama
**Agent:** Orchestrator

```
📊 Lansman sonrası verileri toplama zamanı!

Bana şu verileri iletebilir misin?

App Store / Google Play'den:
• Toplam indirme sayısı
• Günlük aktif kullanıcı (varsa)
• Ortalama puan ve yorum sayısı
• Son 30 gündeki gelir (varsa)

Web sitesinden (varsa):
• Ziyaretçi sayısı
• Dönüşüm oranı

Sosyal medyadan:
• Gönderi etkileşimleri
• Takipçi sayısı

Kullanıcılardan:
• Gelen e-postalar/mesajlar (özet)
• Test kullanıcılarının sözlü geri bildirimleri

Fiziksel/saha kampanyasından:
• Kaç kişiyle temas edildi?
• Kaç demo/tadım/deneme oldu?
• Kaç satış/randevu/WhatsApp dönüşü oldu?
• Hangi lokasyon/gün/saat çalıştı?
• Hangi afiş/broşür/kupon/mesaj işe yaramadı?

B2B satıştan:
• Kaç hedef hesaba temas edildi?
• Cevap, toplantı, demo, teklif ve kazanım sayıları
• En sık itirazlar
• Hangi segment/kanal daha iyi döndü?

(Bu verilerin bir kısmını coder'dan da isteyebilirsin — onun erişimi olan dashboard'lar olabilir)
```

### 3.2 — Kullanıcı Yorumu Analizi
**Agent:** Market Scout
**Opsiyonel capability'ler:**
- `fetch_reviews(appId, platform, sort="rating", num=500)` → düşük puanlı ham yorumları çek
- `analyze_reviews(appId, platform, num=500)` → sentiment dağılımı, keyword frequency, common themes, top negative keywords
- Fiziksel işletme: etkin Codex web/Browser/Chrome araci ile Google Maps/GBP yorumları + Şikayetvar/forumlar

**Eylem:**
- App Store/Google Play yorumları → **mcp-appstore**
- Google Maps/GBP yorumları → **etkin Codex web/Browser/Chrome araci**
- Sosyal medya bahisleri → **etkin Codex web/Browser/Chrome araci**
- Forum/şikayet sitesi yorumları → **etkin Codex web/Browser/Chrome araci**
- B2B toplantı/demo notları → **kullanıcı notları, CRM exportu veya manuel özet**
- Fiziksel saha geri bildirimi → **manuel sayım, fotoğraf, kupon/QR verisi, satış notu**

**Çıktı (`yorum-analizi.md`):**
```markdown
# Kullanıcı Yorum Analizi: [Ürün]
- Dönem: [tarih aralığı]
- Toplam yorum: [sayı]
- Ortalama puan: [x/5]
- Olumlu oranı: [%] | Olumsuz oranı: [%]

## Olumlu Yorumlardan Pattern'lar
1. [pattern] — [kaç yorumda geçiyor]

## Olumsuz Yorumlardan Pattern'lar
1. [pattern] — [kaç yorumda geçiyor]

## En Sık Talep Edilen Özellikler
1. [özellik] — [kaç kez istendi]

## Customer Language Mining
Kullanıcıların ürünü tanımlarken kullandığı ifadeler:
- ...
```

### 3.3 — Metrik Analizi
**Agent:** Analytics Master
**Girdi:** Kullanıcıdan alınan metrik verileri
**Çıktı (`analytics-raporu.md`):**
- Kritik metrikler tablosu (değer vs hedef)
- Trend analizi
- Alarm durumları
- Büyüme/düşüş yorumları

### 3.4 — İyileştirme Önerileri
**Agent:** Strategy Analyst
**Girdi:** `yorum-analizi.md` + `analytics-raporu.md`
**Çıktı (`iyilestirme-onerileri.md`):**
- 3 seviyeli önceliklendirme:
  - 🔴 Kritik (hemen yapılmalı)
  - 🟡 Önemli (bu ay yapılmalı)
  - 🟢 Güzel olur (zaman kalırsa)

### 3.5 — Kullanıcıya Sunum
**Agent:** Orchestrator

```
📈 FEEDBACK ANALİZ RAPORU

İlgi var mı?
✅ / ⚠️ / ❌ [durum değerlendirmesi]

Öne çıkan bulgular:
❤️ Kullanıcıların sevdiği: [ilk 3]
💔 Kullanıcıların şikayet ettiği: [ilk 3]
📊 Metriklerde alarm: [varsa]

Önerilen iyileştirmeler:
🔴 Kritik: ...
🟡 Önemli: ...
🟢 Güzel olur: ...

Hangi önceliklerle ilerleyelim?
A) Sadece kritik olanları yapalım
B) Kritik + önemlileri yapalım
C) Hepsini yapalım
D) Kendi seçtiklerimi belirteyim
```

### 3.6 — İyileştirme Türü ve Revizyon
**Agent:** Orchestrator + ilgili uzman
**Girdi:** `iyilestirme-onerileri.md` + kullanıcının öncelik kararı

Revizyon türünü seç:

- Ürün/teknik değişiklik: Product Architect → `04-urun/prd/prd-v2.md`
- B2C fiziksel pazarlama: Content Creator / Campaign Manager / Launch Commander →
  materyal, kampanya veya aktivasyon revizyonu
- B2B satış: Outreach Specialist / Brand Guardian → mesaj, demo, teklif, itiraz veya pipeline revizyonu
- Dijital kampanya: Campaign Manager / Content Creator → reklam, içerik, landing veya lifecycle revizyonu

### 3.7 — Uygulama Brief'i
**Agent:** Orchestrator
**Çıktı:** `coder-brief-v2.md` veya `08-raporlar/pazarlama/pazarlama-iyilestirme-briefi.md`

---

## Karar Noktaları

| Adım | Karar |
|------|-------|
| 3.5 | İyileştirme önceliklerini seç |

---

## Çıktı Dosyaları

| Dosya | Üreten |
|-------|--------|
| `yorum-analizi.md` | Market Scout |
| `analytics-raporu.md` | Analytics Master |
| `iyilestirme-onerileri.md` | Strategy Analyst |
| `prd-v2.md` | Product Architect, yalnızca ürün/teknik revizyon gerekiyorsa |
| `pazarlama-iyilestirme-briefi.md` | Orchestrator, pazarlama/saha/satış revizyonu gerekiyorsa |

---

## Sonraki Pipeline

Ürün/teknik iyileştirme varsa coder uygular → ürün güncellenir → istenirse tekrar **Pipeline 3**
çalıştırılır.

Pazarlama/saha/satış iyileştirmesi varsa ilgili kampanya veya satış planı güncellenir →
haftalık plana yeni görevler eklenir → tekrar **Pipeline 3** ile ölçülür.

Veya traction varsa → **Pipeline 4 (Büyüme Motoru)** başlatılır.

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: 02-arastirma/musteri-arastirmasi/, 04-urun/urun-kararlari/,
  06-pazarlama-uygulamalari/, 08-raporlar/pazarlama/ ve 08-raporlar/analitik/
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
