# Pipeline 9: B2C Fiziksel ve Yerel Pazarlama

**Zincirdeki yeri:** Fiziksel temas gerektiren B2C projeler için ana pazarlama operasyon
pipeline'ı. Dijital destek, saha aktivasyonu, yerel iş birlikleri, reklam, içerik, lansman,
ölçüm ve iyileştirme döngüsünü birlikte yönetir.

**Ne zaman çalışır:** Kullanıcının pazarlaması fiziksel dünyada yapılması gereken bir B2C
ürünü, hizmeti veya işletmesi varsa.

Kapsam örnekleri:

- restoran, kafe, spor salonu, klinik, güzellik merkezi, eğitim merkezi, mağaza, etkinlik alanı
- fiziksel ürün, ambalajlı tüketici ürünü, butik üretim, D2C ama saha/retail gerektiren ürün
- pop-up, stant, fuar, pazar, AVM, festival, kampüs, mahalle, semt veya şehir bazlı aktivasyon
- el ilanı, broşür, afiş, kupon, numune dağıtımı, QR yönlendirmesi, WhatsApp, yerel influencer,
  lokal reklam ve mağaza içi deneyim gerektiren işler

**Amaç:** Kullanıcıya fikirden uygulamaya kadar eksiksiz destek vermek: pazarı anlamak, fiziksel
müşteri yolculuğunu kurmak, uygulanabilir kampanya fikirleri üretmek, materyalleri hazırlamak,
haftalık aksiyon planı çıkarmak, sonuçları ölçmek ve iyileştirmek.

**Ön koşul:** Ürün/hizmet/işletme açıklaması, hedef pazar veya lokasyon, yaklaşık bütçe,
satış noktası/operasyon modeli ve kullanıcı kısıtları toplanmış olmalı. Eksikler varsa pipeline
önce bu bilgileri tamamlar.

---

## Ana İlke

Bu pipeline'da agent sadece tavsiye vermez. Kullanıcının fiziksel pazarlama sürecini baştan sona
taşır:

- Ne yapılacağını söyler.
- Neden yapılacağını kanıtlar.
- Hangi materyalin gerektiğini üretir.
- Hangi gün, nerede, kimle, hangi bütçeyle uygulanacağını planlar.
- Hangi metrikle ölçüleceğini yazar.
- Sonuca göre yeni fikir ve revizyon önerir.

Fikir üretimi zorunludur. Agent, kullanıcının bütçesi ve kapasitesi içinde yaratıcı ama
uygulanabilir kampanya, iş birliği, etkinlik, sampling, deneyim ve tekrar satın alma fikirleri
önermelidir. Her fikir maliyet, operasyon zorluğu, izin/etik risk, ölçüm kolaylığı ve beklenen
etki açısından elenir.

---

## Pipeline Akışı

```text
Kullanıcı: "B2C ürünümü/işletmemi fiziksel olarak pazarlamam gerekiyor"
        |
        v
[9.1] Orchestrator -> İş, ürün, lokasyon, bütçe, kapasite ve kısıtları topla
        |  Çıktı: 01-baglam/fiziksel-pazarlama-baglami.md
        v
[9.2] Market Scout -> Yerel pazar, rakip, müşteri ve fiziksel kanal araştırması
        |  Çıktı: 02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md
        v
[9.3] Strategy Analyst -> Fiziksel müşteri yolculuğu ve kanal stratejisi
        |  Çıktı: 03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md
        v
[9.4] Brand Guardian -> Teklif, konumlandırma ve fiziksel temas marka sistemi
        |  Çıktı: 03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md
        v
[9.5] Orchestrator -> Kampanya fikir havuzu üret ve kullanıcıyla seç
        |  Çıktı: 03-strateji/pazara-giris/kampanya-fikir-havuzu.md
        v
[9.6] Content Creator -> Fiziksel ve dijital destek materyallerini üret
        |  Çıktı: 06-pazarlama-uygulamalari/saha/satis-materyalleri/
        v
[9.7] Outreach Specialist -> Yerel iş birlikleri, retail, etkinlik ve topluluk planı
        |  Çıktı: 06-pazarlama-uygulamalari/saha/potansiyel-musteriler/ ve etkinlikler/
        v
[9.8] Campaign Manager -> Lokal reklam, saha kampanyası ve bütçe planı
        |  Çıktı: 06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md
        v
[9.9] Launch Commander -> Uygulama takvimi, checklist ve saha operasyon planı
        |  Çıktı: 07-lansman/fiziksel-aktivasyon-plani.md
        v
[9.10] Analytics Master -> Metrik dashboard'u ve takip ritmi
        |  Çıktı: 08-raporlar/analitik/fiziksel-b2c-dashboard.md
        v
[9.11] Orchestrator -> Haftalık plana görevleri ekle, kullanıcı onayı al
        |  Çıktı: 05-haftalik-planlar/YYYY-WNN.md
        v
[9.12] Orchestrator -> Sonuçları yorumla, yeni fikir/iyileştirme döngüsünü başlat
```

---

## Adım Detayları

### 9.1 — Fiziksel Pazarlama Bağlamı
**Agent:** Orchestrator

Kullanıcıdan şu bilgileri topla:

1. Ürün/hizmet/işletme nedir?
2. Hangi şehir, ilçe, semt, lokasyon veya satış noktalarında pazarlanacak?
3. Hedef müşteri kim: yaş, gelir, yaşam tarzı, ihtiyaç, alışveriş alışkanlığı?
4. Satış modeli nedir: mağaza, stant, bayi, online sipariş + fiziksel tanıtım, kapıda satış,
   etkinlik, pazar, fuar, pop-up, WhatsApp, telefon, randevu?
5. Fiyat, brüt marj, stok/kapasite ve günlük hizmet verme sınırı nedir?
6. Aylık/test bütçesi ve kullanıcının haftalık zaman kapasitesi nedir?
7. Mevcut varlıklar: logo, fotoğraf, ambalaj, sosyal medya, web sitesi, Google Business Profile,
   müşteri listesi, WhatsApp hattı, fiziksel mekan, ekip, araç, stant, numune.
8. Yasal/etik/izin kısıtları: sağlık beyanı, gıda, çocuk hedefleme, kamusal alan izni,
   kişisel veri, çekiliş/kampanya şartları.

**Çıktı (`01-baglam/fiziksel-pazarlama-baglami.md`):**

```markdown
# Fiziksel Pazarlama Bağlamı: [Proje]
- Tarih: [tarih]

## İş ve Teklif
- Ürün/hizmet:
- Fiyat:
- Brüt marj:
- Kapasite/stok:
- Satış modeli:

## Hedef Müşteri
- Primer segment:
- Sekonder segment:
- Lokasyon:
- Satın alma tetikleyicisi:

## Mevcut Varlıklar
- Dijital varlıklar:
- Fiziksel varlıklar:
- Ekip ve operasyon:

## Kısıtlar
- Bütçe:
- Zaman:
- İzin/yasal/etik:
- Operasyon riski:
```

### 9.2 — Yerel Pazar ve Fiziksel Kanal Araştırması
**Agent:** Market Scout

Araştırılacak kaynaklar:

- Google Maps, Google Business Profile, rakip yorumları
- Instagram/TikTok lokasyon etiketleri, yerel hesaplar, mikro influencer'lar
- AVM, cadde, okul/kampüs, spor salonu, pazar, festival, fuar, etkinlik alanı gibi temas
  noktaları
- Rakip mağaza/stand/ambalaj/fiyat/promosyon gözlemleri, kullanıcıdan gelen fotoğraf ve notlar
- Yerel Facebook/WhatsApp/Telegram grupları, forumlar, Şikayetvar, Ekşi Sözlük, sektörel
  topluluklar
- Retail/bayi olasılıkları, tamamlayıcı işletmeler, çapraz tanıtım partnerleri

**Çıktı (`02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md`):**

```markdown
# Fiziksel B2C Pazar Analizi: [Proje]
- Tarih: [tarih]

## Kaynak ve Kanıt Defteri
| ID | Araç | Kaynak | Erişim tarihi | Kullanılan veri | Güven |
|----|------|--------|---------------|-----------------|-------|

## Yerel Talep ve Müşteri Sinyalleri
- Hedef müşteri nerede bulunuyor:
- Satın alma tetikleyicileri:
- Sezon/gün/saat etkisi:
- Fiyat hassasiyeti:

## Rakip ve Alternatifler
| Rakip/Alternatif | Lokasyon/Kanal | Teklif | Fiyat | Güçlü Yan | Zayıf Yan | Kanıt |
|------------------|----------------|--------|-------|-----------|-----------|-------|

## Fiziksel Kanal Fırsatları
| Kanal | Uygunluk | Maliyet | Operasyon zorluğu | Ölçüm kolaylığı | Not |
|-------|----------|---------|-------------------|-----------------|-----|

## Eksik Veri
- Kullanıcıdan gereken saha gözlemi:
- Erişilemeyen kaynaklar:
```

### 9.3 — Fiziksel Müşteri Yolculuğu ve Kanal Stratejisi
**Agent:** Strategy Analyst

Müşteri yolculuğunu fiziksel gerçekliğe göre kur:

1. Farkındalık: müşteri ürünü/işletmeyi nerede fark eder?
2. İlgi: hangi mesaj, görsel veya teklif durdurur?
3. Deneme: numune, demo, tadım, mini hizmet, ücretsiz danışma, ilk ders, kupon?
4. Satın alma: ödeme, randevu, WhatsApp, mağaza ziyareti, web formu?
5. Tekrar: sadakat kartı, referans, paket, abonelik, takip mesajı?
6. Sosyal kanıt: yorum, UGC, before/after, müşteri hikayesi?

**Çıktı (`03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md`):**

```markdown
# Fiziksel Kanal Stratejisi: [Proje]

## Müşteri Yolculuğu
| Aşama | Fiziksel temas | Mesaj | CTA | Ölçüm |
|-------|----------------|-------|-----|-------|

## Kanal Önceliği
| Kanal | Öncelik | Neden | İlk test | Başarı eşiği |
|-------|---------|-------|----------|-------------|

## Teklif ve Kampanya Mantığı
- Ana teklif:
- İlk deneme teklifi:
- Tekrar satın alma teklifi:
- Referans teklifi:
```

### 9.4 — Teklif, Konumlandırma ve Fiziksel Marka Sistemi
**Agent:** Brand Guardian

Fiziksel dünyada görülecek ve duyulacak marka sistemini kur:

- tek cümlelik teklif
- müşteri dilinde ana mesaj
- afiş/broşür/stand/ambalaj başlıkları
- personel satış dili
- itirazlara yanıtlar
- fiyat/paket yapısı
- güven sinyalleri

**Çıktı (`03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md`)**

### 9.5 — Kampanya Fikir Havuzu
**Agent:** Orchestrator

En az 12 uygulanabilir fikir üret. Fikirler şu kategorilere yayılmalı:

- mağaza içi deneyim veya vitrin/stand fikri
- numune, demo, tadım, ilk deneme veya ücretsiz mini hizmet
- kupon, referans, sadakat, paket veya abonelik
- yerel influencer veya mikro creator
- komşu işletme/partner çapraz tanıtımı
- etkinlik, workshop, pop-up, festival, pazar, okul/kampüs, spor salonu gibi saha aktivasyonu
- WhatsApp/QR/landing page ile fizikselden dijitale takip
- Google Maps yorum ve sosyal kanıt toplama

**Çıktı (`03-strateji/pazara-giris/kampanya-fikir-havuzu.md`):**

```markdown
# Kampanya Fikir Havuzu: [Proje]
| Fikir | Kategori | Maliyet | Zorluk | Beklenen etki | Ölçüm | Risk | Karar |
|-------|----------|---------|--------|---------------|-------|------|-------|
```

Agent her fikri elemelidir. Zayıf fikirleri "reddedildi" diye işaretle ve nedenini yaz.

### 9.6 — Materyal Üretimi
**Agent:** Content Creator

Seçilen kampanyalar için gerekli fiziksel ve dijital materyalleri üret:

- afiş metni
- broşür/flyer metni
- kupon veya kart metni
- QR/landing page CTA metni
- WhatsApp karşılama ve takip mesajları
- personel satış konuşması
- müşteri itirazlarına yanıt kartı
- Instagram/TikTok/Reels içerikleri
- görsel üretim promptları
- fotoğraf/video shot list

**Birincil çıktı klasörü:** `06-pazarlama-uygulamalari/saha/satis-materyalleri/`

### 9.7 — Yerel İş Birlikleri ve Topluluk Planı
**Agent:** Outreach Specialist

Planlanacak alanlar:

- komşu işletmeler ve tamamlayıcı markalar
- mikro influencer'lar ve yerel içerik üreticileri
- etkinlik/fuar/festival/pazar/AVM/kampüs fırsatları
- retail/bayi/raf veya konsinye görüşmeleri
- kulüp, dernek, okul, spor salonu, kurs, topluluk ve semt grupları

**Çıktılar:**

- `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/yerel-partner-listesi.md`
- `06-pazarlama-uygulamalari/saha/etkinlikler/etkinlik-ve-pop-up-plani.md`
- `06-pazarlama-uygulamalari/saha/takip/partner-mesajlari.md`

### 9.8 — Lokal Reklam ve Saha Kampanyası
**Agent:** Campaign Manager

Kampanya planı dijital ve fiziksel kanalları birlikte ele alır:

- Google Local/Search/Maps reklamı
- Meta/TikTok lokasyon hedefli reklam
- lokal influencer boost
- afiş/broşür baskı bütçesi
- numune/hediye/kupon maliyeti
- stant/pop-up/etkinlik maliyeti
- minimum test bütçesi ve maksimum kayıp limiti

**Çıktı:** `06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md`

### 9.9 — Uygulama Takvimi ve Checklist
**Agent:** Launch Commander

Saha uygulamasını gün gün planla:

- hazırlık listesi
- materyal üretim ve baskı takvimi
- ekip/personel görevleri
- lokasyon/izin kontrolü
- uygulama günü akışı
- kötü hava, düşük trafik, stok bitmesi, personel yokluğu gibi risk planı
- kampanya sonrası takip

**Çıktı:** `07-lansman/fiziksel-aktivasyon-plani.md`

### 9.10 — Metrik Dashboard'u
**Agent:** Analytics Master

Fiziksel pazarlama için dijital ürün metrikleri yetmez. Aşağıdaki metrikleri kur:

- yaya trafiği veya temas sayısı
- broşür/kupon/QR tarama sayısı
- tadım/demo/deneme sayısı
- satış/randevu/WhatsApp dönüşümü
- lokasyon bazlı dönüşüm
- kanal bazlı CAC
- sepet, marj, stok ve kapasite etkisi
- Google Maps görüntülenme, yol tarifi, arama, yorum
- sosyal medya takip/DM/UGC
- tekrar satın alma ve referans

**Çıktı:** `08-raporlar/analitik/fiziksel-b2c-dashboard.md`

### 9.11 — Haftalık Plan
**Agent:** Orchestrator

Seçilen aksiyonları aktif haftalık plana işler. Her görevde kanal, öncelik, beklenen çıktı,
çıktı konumu ve `Tamamlanma onayi: Kullanici` bulunur.

### 9.12 — İyileştirme Döngüsü
**Agent:** Orchestrator + Analytics Master + ilgili uzmanlar

Kampanya sonrası şu soruları cevapla:

1. Hangi kanal gerçekten müşteri getirdi?
2. Hangi fiziksel materyal veya mesaj çalışmadı?
3. Teklif mi, lokasyon mu, hedef kitle mi, uygulama mı zayıf?
4. Bir sonraki hafta hangi fikir tekrar edilmeli, hangisi kesilmeli?
5. Yeni test fikri ne?

Sonuçları `08-raporlar/pazarlama/fiziksel-b2c-iyilestirme-raporu.md` dosyasına yaz.

---

## Karar Noktaları

| Adım | Karar |
|------|-------|
| 9.1 | Operasyon ve bütçe kısıtları doğru mu? |
| 9.5 | Hangi kampanya fikirleri test edilecek? |
| 9.6 | Hangi materyaller baskı/uygulama için onaylı? |
| 9.8 | Test bütçesi ve maksimum kayıp limiti onaylı mı? |
| 9.9 | Aktivasyon planı uygulanacak mı? |
| 9.12 | Devam / revize / durdur kararı |

---

## Çıktı Dosyaları

| Dosya | Üreten |
|-------|--------|
| `01-baglam/fiziksel-pazarlama-baglami.md` | Orchestrator |
| `02-arastirma/pazar-arastirmasi/fiziksel-b2c-pazar-analizi.md` | Market Scout |
| `03-strateji/pazara-giris/fiziksel-kanal-stratejisi.md` | Strategy Analyst |
| `03-strateji/konumlandirma/fiziksel-teklif-ve-marka.md` | Brand Guardian |
| `03-strateji/pazara-giris/kampanya-fikir-havuzu.md` | Orchestrator |
| `06-pazarlama-uygulamalari/saha/satis-materyalleri/` | Content Creator |
| `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/yerel-partner-listesi.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/etkinlikler/etkinlik-ve-pop-up-plani.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/hibrit/kampanyalar/fiziksel-b2c-kampanya-plani.md` | Campaign Manager |
| `07-lansman/fiziksel-aktivasyon-plani.md` | Launch Commander |
| `08-raporlar/analitik/fiziksel-b2c-dashboard.md` | Analytics Master |
| `08-raporlar/pazarlama/fiziksel-b2c-iyilestirme-raporu.md` | Orchestrator + Analytics Master |

---

## Fiziksel B2C ve Dijital Ürün Farkı

| Alan | Dijital Ürün | Fiziksel B2C |
|------|--------------|--------------|
| İlk temas | reklam, arama, sosyal | lokasyon, stant, vitrin, etkinlik, insan teması |
| Kanıt | deneme, yorum, metrik | tadım/demo, gözlem, konuşma, kupon/QR, satış |
| Kısıt | ürün bug'ı, onboarding | stok, ekip, izin, hava, trafik, baskı, mekan |
| İçerik | landing, ASO, post | afiş, broşür, satış script'i, QR, mağaza içi mesaj |
| Başarı metriği | kayıt, DAU, retention | temas, deneme, satış, randevu, yol tarifi, yorum |
| İyileştirme | funnel optimizasyonu | lokasyon, teklif, materyal, personel, zamanlama |

---

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: `01-baglam/`, `02-arastirma/`, `03-strateji/`,
  `06-pazarlama-uygulamalari/saha/`, `06-pazarlama-uygulamalari/hibrit/`, `07-lansman/`,
  `08-raporlar/` ve onayli ciktilar icin `10-final/`
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
