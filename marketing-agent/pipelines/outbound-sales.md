# Pipeline 8: B2B Gelir ve Outbound Satış

**Zincirdeki yeri:** B2B dijital, B2B saha/fiziksel ve hibrit satış hareketleri için ana gelir
pipeline'ı. Lead generation, prospecting, outbound, inside sales, field sales, demo, teklif,
partner/channel sales ve takip süreçlerini birlikte yönetir.

**Ne zaman çalışır:** Kullanıcı B2B müşteri bulmak, satış pipeline'ı kurmak, toplantı almak,
demo yapmak, teklif hazırlamak, saha satışı yürütmek, partner/bayi kanalı kurmak veya mevcut
B2B satış sürecini iyileştirmek istediğinde.

**Amaç:** ICP'yi netleştirip kanıtlı hedef hesap listesi oluşturmak; dijital ve/veya fiziksel
kanallarla temas planı kurmak; mesaj, teklif, demo, toplantı ve takip materyallerini üretmek;
pipeline metriklerini izleyip satış sürecini iyileştirmek.

**Ön koşul:** Ürün/hizmet B2B veya B2B bileşenli hibrit olmalı. `PROJE.md`, ilgili
`01-baglam/` dosyaları ve temel teklif bilgisi mevcut olmalı; eksikse pipeline önce bunları
tamamlar.

---

## Ana İlke

Bu pipeline cold email ile sınırlı değildir. B2B satış hareketi şu kanallardan biri veya
birkaçıyla yürütülebilir:

- cold email
- LinkedIn/social selling
- telefon/WhatsApp
- demo ve online toplantı
- yüz yüze ziyaret, saha satış ve etkinlik/fuar
- webinar, workshop, topluluk veya partner etkinliği
- kanal/partner/bayi/referral
- ABM reklam, retargeting ve içerik destekli lead nurture

Agent kanal seçimini kullanıcının networkü, sektör bilgisi, hedef hesap tipi, satış döngüsü,
ticket size, karar verici erişimi ve saha kapasitesine göre yapar. Her temas kanalına ölçüm ve
takip adımı bağlanır.

---

## Pipeline Akışı

```text
Kullanıcı: "B2B müşteri bulalım / satış yapalım"
        |
        v
[8.1] Orchestrator -> B2B satış bağlamını ve satış hareketini çıkar
        |  Çıktı: 01-baglam/b2b-satis-baglami.md
        v
[8.2] Strategy Analyst -> ICP, segment, değer önerisi ve teklif hipotezi
        |  Çıktı: 03-strateji/pazara-giris/b2b-icp-ve-teklif.md
        v
[8.3] Market Scout + Outreach Specialist -> Hesap/prospect ve kanal araştırması
        |  Çıktı: 06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md
        v
[8.4] Outreach Specialist -> Çok kanallı temas dizisi
        |  Çıktı: 06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md
        v
[8.5] Content Creator + Brand Guardian -> Satış materyalleri
        |  Çıktı: 06-pazarlama-uygulamalari/saha/satis-materyalleri/
        v
[8.6] Product Architect + Brand Guardian -> Demo, teklif ve objection handling
        |  Çıktı: 06-pazarlama-uygulamalari/saha/teklifler/
        v
[8.7] Campaign Manager -> B2B reklam/ABM/retargeting destek planı
        |  Çıktı: 06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md
        v
[8.8] Outreach Specialist -> Partner, kanal, etkinlik veya saha satış planı
        |  Çıktı: 06-pazarlama-uygulamalari/saha/toplantilar/ ve etkinlikler/
        v
[8.9] Analytics Master -> Pipeline dashboard'u ve takip ritmi
        |  Çıktı: 08-raporlar/analitik/b2b-pipeline-dashboard.md
        v
[8.10] Orchestrator -> Haftalık plana görevleri ekle, kullanıcı onayı al
```

---

## Adım Detayları

### 8.1 — B2B Satış Bağlamı
**Agent:** Orchestrator

Toplanacak bilgiler:

1. Ürün/hizmet nedir ve hangi B2B problemi çözer?
2. Hedef müşteri: sektör, şirket büyüklüğü, lokasyon, olgunluk seviyesi
3. Karar vericiler ve etkileyiciler: unvan, departman, satın alma komitesi
4. Ticket size, fiyat modeli, satış döngüsü ve ödeme beklentisi
5. Kullanıcının networkü, referansları, sektör güvenilirliği ve erişebildiği hesaplar
6. Satış hareketi: inside sales, field sales, partner/channel, self-service destekli veya karma
7. Mevcut materyaller: sunum, demo, case study, landing page, teklif şablonu, referans
8. Kısıtlar: zaman, ekip, bütçe, coğrafya, regülasyon, entegrasyon, operasyon kapasitesi

**Çıktı:** `01-baglam/b2b-satis-baglami.md`

### 8.2 — ICP ve Teklif Stratejisi
**Agent:** Strategy Analyst

**Çıktı (`03-strateji/pazara-giris/b2b-icp-ve-teklif.md`):**

```markdown
# B2B ICP ve Teklif Stratejisi: [Proje]

## ICP
| Segment | Problem acısı | Bütçe | Erişim kolaylığı | Satış döngüsü | Öncelik |
|---------|---------------|-------|------------------|---------------|---------|

## Karar Verici Haritası
| Rol | Öncelik | Ana acı | Mesaj | Kanıt |
|-----|---------|---------|-------|-------|

## Değer Önerisi
- Ana vaat:
- ROI veya maliyet azaltma:
- Risk azaltıcı unsur:
- İlk teklif:

## Kanal Kararı
- Inside sales:
- Field sales:
- Partner/channel:
- Dijital talep yaratma:
```

### 8.3 — Hesap ve Prospect Araştırması
**Agent:** Market Scout + Outreach Specialist

Kaynaklar:

- LinkedIn, şirket siteleri, dizinler, sektör listeleri, oda/dernek listeleri
- kullanıcı networkü ve mevcut müşteri/referral kaynakları
- etkinlik/fuar katılımcı listeleri
- yerel saha hesapları, mağaza/şube/tesis listeleri
- web arama ve güvenilir kaynaklar

**Çıktı (`06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md`):**

```markdown
# Prospect Listesi: [Proje]
- ICP:
- Kaynaklar:

| # | Hesap | Segment | Karar verici | Kanal | Neden uygun | Kişiselleştirme notu | Öncelik |
|---|-------|---------|--------------|-------|-------------|----------------------|---------|
```

Kişisel veri ve iletişim bilgilerinde veri minimizasyonu uygula. Dış sisteme mesaj göndermeden
önce açık kullanıcı onayı al.

### 8.4 — Çok Kanallı Outreach Planı
**Agent:** Outreach Specialist

Kanal seçimi hedef hesaba göre yapılır. Cold email tek seçenek değildir.

**Çıktı (`06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md`):**

```markdown
# Çok Kanallı Outreach Planı: [Proje]

## Temas Dizisi
| Gün | Kanal | Mesaj amacı | CTA | Takip koşulu |
|-----|-------|-------------|-----|--------------|
| 0 | Email | Problem/ROI açılışı | 15 dk görüşme | Cevap yoksa LinkedIn |
| 2 | LinkedIn | Hafif temas | Bağlantı | Kabul edilirse mesaj |
| 5 | Telefon/WhatsApp | Toplantı netleştirme | Tarih seçimi | ... |

## Mesaj Varyantları
- Email 1:
- LinkedIn mesajı:
- Telefon açılış script'i:
- WhatsApp kısa mesajı:
- Breakup mesajı:
```

### 8.5 — Satış Materyalleri
**Agent:** Content Creator + Brand Guardian

Üretilecekler:

- tek sayfalık satış dokümanı
- problem/çözüm anlatımı
- sektör bazlı mesaj varyantları
- LinkedIn post veya thought leadership içerikleri
- landing page veya demo sayfası kopyası
- case study veya referans taslağı
- saha ziyareti için broşür/sunum özeti

**Çıktı klasörü:** `06-pazarlama-uygulamalari/saha/satis-materyalleri/`

### 8.6 — Demo, Teklif ve İtiraz Yönetimi
**Agent:** Product Architect + Brand Guardian

**Çıktılar:**

- `06-pazarlama-uygulamalari/saha/demolar/demo-akisi.md`
- `06-pazarlama-uygulamalari/saha/teklifler/teklif-sablonu.md`
- `06-pazarlama-uygulamalari/saha/toplantilar/toplanti-scripti.md`
- `06-pazarlama-uygulamalari/saha/takip/itiraz-yanitlari.md`

### 8.7 — B2B Talep Yaratma ve Reklam Desteği
**Agent:** Campaign Manager

B2B dijital destek gerekiyorsa:

- LinkedIn Ads veya Meta/Google hedefleme
- ABM küçük liste reklamları
- retargeting
- webinar/workshop kayıt kampanyası
- lead magnet veya rapor kampanyası

**Çıktı:** `06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md`

### 8.8 — Partner, Kanal, Etkinlik ve Saha Satış
**Agent:** Outreach Specialist

B2B fiziksel/saha gerekiyorsa:

- fuar/etkinlik listesi
- saha ziyaret planı
- bayi/partner hedef listesi
- demo günü/workshop planı
- toplantı öncesi ve sonrası takip akışı

**Çıktılar:**

- `06-pazarlama-uygulamalari/saha/etkinlikler/b2b-etkinlik-plani.md`
- `06-pazarlama-uygulamalari/saha/toplantilar/saha-ziyaret-plani.md`
- `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/partner-kanal-listesi.md`

### 8.9 — Pipeline Dashboard'u
**Agent:** Analytics Master

**Çıktı (`08-raporlar/analitik/b2b-pipeline-dashboard.md`):**

```markdown
# B2B Pipeline Dashboard: [Proje]
- Dönem:

## Funnel
| Aşama | Sayı | Dönüşüm | Hedef |
|-------|------|---------|-------|
| Hedef hesap | ... | ... | ... |
| Temas edildi | ... | ... | ... |
| Cevap | ... | ... | ... |
| Toplantı | ... | ... | ... |
| Demo | ... | ... | ... |
| Teklif | ... | ... | ... |
| Kazanılan | ... | ... | ... |

## Kanal Performansı
| Kanal | Temas | Cevap | Toplantı | Maliyet | Not |
|-------|-------|-------|----------|---------|-----|

## Karar
- Ölçekle:
- Revize:
- Durdur:
- Yeni test:
```

### 8.10 — Haftalık Plan
**Agent:** Orchestrator

Seçilen temas, demo, teklif, partner ve takip görevlerini aktif haftalık plana işler.
Tamamlanma yalnızca kullanıcı onayıyla kapanır.

---

## Karar Noktaları

| Adım | Karar |
|------|-------|
| 8.2 | Hangi ICP/segment öncelikli? |
| 8.4 | Hangi temas kanalları kullanılacak? |
| 8.6 | Demo/teklif paketi onaylı mı? |
| 8.8 | Saha/partner/etkinlik planı uygulanacak mı? |
| 8.9 | Ölçekle / revize / durdur |

---

## Çıktı Dosyaları

| Dosya | Üreten |
|-------|--------|
| `01-baglam/b2b-satis-baglami.md` | Orchestrator |
| `03-strateji/pazara-giris/b2b-icp-ve-teklif.md` | Strategy Analyst |
| `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/prospect-listesi.md` | Market Scout + Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/takip/cok-kanalli-outreach-plani.md` | Outreach Specialist |
| `06-pazarlama-uygulamalari/saha/satis-materyalleri/` | Content Creator + Brand Guardian |
| `06-pazarlama-uygulamalari/saha/demolar/demo-akisi.md` | Product Architect |
| `06-pazarlama-uygulamalari/saha/teklifler/teklif-sablonu.md` | Brand Guardian |
| `06-pazarlama-uygulamalari/dijital/reklamlar/b2b-talep-yaratma-plani.md` | Campaign Manager |
| `06-pazarlama-uygulamalari/saha/etkinlikler/b2b-etkinlik-plani.md` | Outreach Specialist |
| `08-raporlar/analitik/b2b-pipeline-dashboard.md` | Analytics Master |

---

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: `01-baglam/`, `03-strateji/pazara-giris/`,
  `06-pazarlama-uygulamalari/saha/`, `06-pazarlama-uygulamalari/dijital/`,
  `06-pazarlama-uygulamalari/hibrit/` ve `08-raporlar/analitik/`
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Dis sisteme email, LinkedIn mesajı, telefon, WhatsApp, form veya başvuru gönderimi için açık
  kullanıcı onayı alır.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
