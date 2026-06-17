# Pipeline 1: Fikir Keşif ve Doğrulama (Idea Discovery)

**Zincirdeki yeri:** Zincir A (ilk adım) — sonrasında P5'e geçer.

**Ne zaman çalışır:** Kullanıcı "sıfırdan bir fikir bulmak istiyorum" dediğinde veya henüz
somut bir fikir getirmediğinde. Kullanıcı hazır bir fikirle geldiyse bu pipeline'ı başlatma;
`pipelines/idea-to-prd.md` içindeki "denemeye değer mi?" akışına yönlendir.

**Amaç:** Pazardaki boşlukları ve fırsatları tarayıp kullanıcıyla birlikte denenebilir bir ürün
fikrine ulaşmak. Fikir netleştiğinde agent, iyimser davranmak yerine kanıt ve kullanıcı
pazarlama avantajı üzerinden fikri sert biçimde doğrular.

**Ön koşul:** `PROJE.md ve 01-baglam/ altindaki ilgili dosyalar` oluşturulmuş olmalı.

---

## Pipeline Akışı

```
Kullanıcı giriş yapar
        │
        ▼
[1.1] Orchestrator → İlgi alanı/sektör/ürün tipi sor
        │
        ▼
[1.2] Market Scout → Kaynakları tara, fırsat haritası çıkar
        │  Çıktı: firsat-haritasi.md
        ▼
[1.3] Orchestrator → Fırsatları kullanıcıya sun, kategori seçtir
        │  Kullanıcı: "X kategorisini analiz et" (veya "vazgeç")
        ▼
[1.4] Market Scout → Seçilen kategoride derin analiz
        │  Çıktı: kategori-analizi.md
        ▼
[1.5] Strategy Analyst → Rekabet analizi, boşluk tespiti
        │  Çıktı: strateji-analizi.md
        ▼
[1.6] Orchestrator → Boşlukları kullanıcıya sun, fırsat seçtir
        │  Kullanıcı: bir boşluk/fırsat seçer (veya "diğer kategoriye dön")
        ▼
[1.7] Product Architect → Seçilen fırsattan fikir üret
        │  Çıktı: idea-brief.md
        ▼
[1.8] Orchestrator → Fikri kullanıcıyla tartış, şekillendir
        │  Kullanıcı: fikri onaylar / revize ister / vazgeçer
        ▼
[1.9] Orchestrator → Onaylı fikri P5 değerleme kapısına aktar
           P5: kullanıcı pazarlama avantajı + research + sert doğrulama
           Değer kararı çıkarsa: MVP → PRD → coder brief
```

---

## Adım Detayları

### 1.1 — İlgi Alanı ve Ürün Tipi Belirleme
**Agent:** Orchestrator
**Kullanıcıya sorulan:**
1. Hangi sektörle ilgileniyorsun? (açık uçlu veya önerili liste)
2. Ne tür ürün? (Mobil app / SaaS / E-ticaret / ...)
3. Özel bir ilgi alanın var mı? (spor, sağlık, eğitim, finans...)

**Not:** Kullanıcı "bilmiyorum" derse tüm popüler kategorileri tara.

### 1.2 — Fırsat Haritası
**Agent:** Market Scout
**Opsiyonel capability'ler:**
- Mobil App: `search_app` ile kategorilerdeki top app'leri bul, `analyze_top_keywords` ile keyword trafiğini ölç
- SaaS: etkin Codex web/Browser/Chrome araci ile G2/Capterra/Reddit tara
- Fiziksel İşletme: etkin Codex web/Browser/Chrome araci ile Google Maps/GBP tara

**Eylem:** Ürün tipine uygun tüm kaynakları tara.
- App Store / Google Play → **mcp-appstore `search_app` + `analyze_top_keywords`**
- G2 / Capterra / Reddit → **etkin Codex web/Browser/Chrome araci**
- Google Maps / GBP → **etkin Codex web/Browser/Chrome araci**

**Not:** Kullanıcı sektör belirtmişse sadece o sektörü tara. Belirtmemişse tüm kategorileri tara ve en hızlı büyüyenleri sırala.

### 1.3 — Kategori Seçimi
**Agent:** Orchestrator
**Kullanıcıya sunulan:** En az 3 yükselen kategori, her biri için:
- Kaç app/rakip var
- Büyüme oranı
- Ortalama gelir (varsa)
- Öne çıkan bir örnek

**Kullanıcı kararı:** "X kategorisini derinlemesine analiz et" veya "vazgeç, başka kaynak tara"

### 1.4 — Derin Kategori Analizi
**Agent:** Market Scout
**Opsiyonel capability'ler (her rakip app için):**
1. `get_app_details(appId, platform)` → indirme, puan histogramı, kategori, ekran görüntüleri
2. `analyze_reviews(appId, platform, sort="rating", num=200)` → sentiment, top negative keywords, common themes
3. `get_pricing_details(appId, platform)` → IAP fiyatları, monetization modeli
4. `get_similar_apps(appId, platform)` → rakip keşfi
5. **Revenue tahmini:** `rating_count × avg_subscription_price × 0.02`

**Süre:** Kategorideki rakip sayısına bağlı. En az 3, en çok 10 rakip analiz edilir.

### 1.5 — Stratejik Analiz
**Agent:** Strategy Analyst
**Girdi:** `kategori-analizi.md`
**Çıktı:** SWOT, pozisyon haritası, boşluk listesi

### 1.6 — Fırsat Seçimi
**Agent:** Orchestrator
**Kullanıcıya sunulan:** En az 3 somut fırsat alanı (boşluk). Her biri için:
- Hangi rakiplerin eksikliği
- Kullanıcıların neyden şikayet ettiği
- Tahmini pazar büyüklüğü

### 1.7 — Fikir Üretimi
**Agent:** Product Architect
**Girdi:** Seçilen fırsat alanı
**Çıktı:** `idea-brief.md` — problem, çözüm, hedef kitle, MVP kapsamı, gelir modeli

### 1.8 — Fikir Tartışması
**Agent:** Orchestrator
**Kullanıcıyla yapılan:** Fikrin artıları/eksileri, riskler, alternatif açılar, hedef kitle netleştirme. Kullanıcı fikri şekillendirir.

### 1.9 — P5 Değerleme Kapısına Geçiş
**Agent:** Orchestrator
**Girdi:** Onaylanmış `idea-brief.md` + tartışma notları
**Eylem:** Fikri hazır fikir gibi ele al ve `pipelines/idea-to-prd.md` akışını başlat.

Bu geçişte kullanıcıya tekrar iyimser davranma. P5 içinde kullanıcının networkü, bilgi birikimi,
çalıştığı alan/sektör, yaşadığı şehir/ülke, satış/pazarlama deneyimi ve ilk kullanıcıya erişim
kanalları sorgulanır. Fikir değerli bulunursa önce `04-urun/fikir-ozetleri/mvp.md`, sonra
`04-urun/prd/prd.md`, ardından `04-urun/coder-briefleri/coder-brief.md` üretilir.

---

## Karar Noktaları

| Adım | Karar | Seçenekler |
|------|-------|-----------|
| 1.3 | Kategori seçimi | "X'i analiz et" / "Başka öner" / "Vazgeç" |
| 1.6 | Fırsat seçimi | "X fırsatından fikir üret" / "Başka kategoriye dön" / "Vazgeç" |
| 1.8 | Fikir onayı | "P5 değerleme kapısına geçir" / "Şu kısmı değiştir" / "Vazgeç" |
| 1.9 | Değerleme geçişi | "P5'i başlat" / "Önce fikri revize et" / "Vazgeç" |

---

## Çıktı Dosyaları

| Dosya | Üreten | Açıklama |
|-------|--------|----------|
| `firsat-haritasi.md` | Market Scout | Tüm kategoriler, büyüme oranları |
| `kategori-analizi.md` | Market Scout | Seçilen kategorideki rakip profilleri |
| `strateji-analizi.md` | Strategy Analyst | SWOT, boşluklar, fırsat alanları |
| `idea-brief.md` | Product Architect | Detaylandırılmış fikir |
| P5 çıktıları | Orchestrator + uzmanlar | Değer kararı çıkarsa MVP, PRD ve coder brief |

---

## Sonraki Pipeline

Pipeline 1 tamamlandığında orchestrator otomatik olarak şu mesajı verir:

```
P5 değerleme kapısı tamamlandıysa MVP, PRD ve coder brief hazır. Bunları coder'a ilet.

Coder MVP'yi geliştirirken ben sana şu konularda yardımcı olabilirim:
• Sosyal medya hesaplarını şimdiden açmak
• "Coming soon" sayfası hazırlamak
• E-posta listesi oluşturma stratejisi

MVP hazır olduğunda bana haber ver, Pipeline 2 (MVP Lansman) ile devam edelim.
```

Coder MVP'yi teslim ettiğinde → **Pipeline 2 (MVP Lansman)** başlar.

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: degerlendirmede ciktilar/ ve RAPOR.md; projede 02-arastirma/ ve 03-strateji/dogrulama/
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
