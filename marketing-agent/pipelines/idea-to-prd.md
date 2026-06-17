# Pipeline 5: Var Olan Fikirden MVP ve PRD'ye (Idea to PRD)

**Zincirdeki yeri:** Zincir B başlangıç noktası veya P1'de üretilen fikrin sert değerleme adımı.

**Ne zaman çalışır:** Kullanıcının aklında zaten bir fikir varsa ve bunu "denemeye değer mi?"
diye test edip, değerliyse MVP ve PRD'ye dönüştürmek istiyorsa.

**Amaç:** Eldeki fikri kullanıcı avantajı, pazar verisi, rakip gerçekliği, müşteri acısı,
dağıtım kanalı, gelir potansiyeli ve MVP maliyetiyle yüzleştir. Sadece "değer" kararı çıkarsa
önce MVP dokümanı, sonra bu MVP'ye dayalı PRD ve coder brief üret.

**Ön koşul:** Kullanıcının somut bir fikri olmalı. Proje workspace'inde `PROJE.md` ve ilgili
`01-baglam/` dosyaları oluşturulmuş olmalı. Değerlendirme workspace'inde çalışılıyorsa bu
pipeline PRD üretmez; karar raporu `RAPOR.md` ve `ciktilar/` altında kalır.

---

## Temel Tutum

Bu pipeline'da agent kullanıcıyı yüreklendiren bir koç gibi davranmaz. Agent'ın görevi fikri
gerçekçi biçimde zorlamak, zayıf sinyalleri saklamamak ve kullanıcıyla birlikte daha denenebilir
bir forma getirmektir.

Kurallar:

1. "Güzel fikir", "potansiyeli var", "denemeye değer olabilir" gibi kanıtsız olumlu dil kullanma.
2. Fikir zayıfsa doğrudan söyle; gerekçeyi pazar, dağıtım, maliyet veya kullanıcı avantajı ile açıkla.
3. Kullanıcının tecrübesini ciddiye al ama tek kanıt sayma. Research çıktılarıyla birlikte tart.
4. Fikir kullanıcı tarafından pazarlanamayacaksa bu durum tek başına "değmez" veya "revizyon gerekir"
   kararına sebep olabilir.
5. Daha iyi bir hedef kitle, niş, kanal, fiyat modeli veya MVP kapsamı görürsen özgürce revizyon öner.
6. Kullanıcı son fikri ve karar yönünü açıkça onaylamadan MVP, PRD veya coder brief üretme.

---

## Pipeline Akışı

```text
Kullanıcı: "Elimde bir fikir var"
        |
        v
[5.1] Orchestrator -> Fikri ve ürün tipini al
        |
        v
[5.2] Orchestrator -> Kullanıcı profilini ve pazarlama avantajını çıkar
        |  Çıktı: kullanici-pazarlama-avantaji.md
        v
[5.3] Market Scout -> Pazar, rakip, trend ve müşteri sinyali araştır
        |  Çıktı: pazar-arastirmasi.md
        v
[5.4] Strategy Analyst -> Fikri "denemeye değer mi?" kriterleriyle puanla
        |  Çıktı: fikir-dogrulama.md
        v
[5.5] Orchestrator -> Realist karar tartışması: DEĞER / REVİZYON / DEĞMEZ
        |
        +-- "Denenmeye Değmez" -> Raporu kapat, gerekçeyi yaz, PRD üretme
        |
        +-- "Revizyonla Denenmeye Değer" -> Kullanıcıyla fikri revize et -> [5.2]'ye dön
        |
        +-- "Denenmeye Değer" ->
                 v
            [5.6] Product Architect -> Onaylı son fikirden MVP yaz
                 |  Çıktı: 04-urun/fikir-ozetleri/mvp.md
                 v
            [5.7] Orchestrator -> MVP kapsamını kullanıcıya onaylat
                 v
            [5.8] Product Architect -> Onaylı MVP'ye göre PRD yaz
                 |  Çıktı: 04-urun/prd/prd.md
                 v
            [5.9] Product Architect -> Coder brief hazırla
                 |  Çıktı: 04-urun/coder-briefleri/coder-brief.md
                 v
            [5.10] Orchestrator -> Kullanıcıyı MVP ve PRD dosyalarını coder'a iletmeye yönlendir
```

---

## Adım Detayları

### 5.1 — Fikir Toplama
**Agent:** Orchestrator

Kullanıcıdan şu bilgileri al:

1. Fikrini 3-5 cümleyle anlat.
2. Bu fikir hangi problemi çözüyor?
3. Problem kimin için acı verici veya maliyetli?
4. Bu fikir nereden çıktı: kişisel ihtiyaç, iş gözlemi, müşteri talebi, rakip eksiği veya başka kaynak?
5. Ürün tipi ne: mobil app, SaaS, fiziksel işletme, e-ticaret, hizmet, içerik, hibrit?
6. Bildiğin rakipler veya alternatif çözümler hangileri?
7. Bu fikri neden sen yapabilirsin?

Belirsiz cevaplarda fikri tamamlamaya çalışma; eksik varsayımları açıkça listele.

### 5.2 — Kullanıcı Pazarlama Avantajı
**Agent:** Orchestrator

Fikrin pazarlanabilirliğini kullanıcı özelinde ölç. Kullanıcıdan şu bilgileri al:

1. Yaşadığı şehir/ülke ve hedef pazarla ilişkisi
2. Çalıştığı alan, sektör ve mesleki deneyim
3. Konuyla ilgili bilgi birikimi veya kişisel uzmanlık
4. Network: erişebildiği müşteri, kurum, topluluk, influencer, kanal veya karar verici çevresi
5. Mevcut kitle: e-posta listesi, sosyal medya, topluluk, müşteri portföyü, mağaza trafiği
6. Satış ve pazarlama deneyimi
7. İlk 10-50 kullanıcıya nasıl ulaşabileceği
8. Haftalık zaman kapasitesi ve deneme bütçesi
9. Şehir, dil, kültür, regülasyon veya operasyonel avantaj/dezavantaj

**Çıktı formatı (`03-strateji/dogrulama/kullanici-pazarlama-avantaji.md`):**

```markdown
# Kullanıcı Pazarlama Avantajı: [Fikir]
- Tarih: [tarih]

## Kullanıcı Profili
- Şehir/ülke:
- Çalıştığı alan:
- Sektör bilgisi:
- Satış/pazarlama deneyimi:
- Zaman kapasitesi:
- Deneme bütçesi:

## Dağıtım Varlıkları
| Varlık | Güç | Kanıt | Risk |
|--------|-----|-------|------|
| Network | [düşük/orta/yüksek] | ... | ... |
| Mevcut kitle | ... | ... | ... |
| İlk kullanıcı erişimi | ... | ... | ... |

## Pazarlayabilirlik Skoru
| Kriter | Puan (1-10) | Gerekçe |
|--------|-------------|---------|
| Hedef kitleye erişim | ... | ... |
| Sektör güvenilirliği | ... | ... |
| İlk satış/edinim kanalı | ... | ... |
| Yerel/kültürel avantaj | ... | ... |
| Uygulama kapasitesi | ... | ... |
| **Toplam** | **.../50** | |

## Sonuç
- Kullanıcının bu fikri pazarlama avantajı:
- Kritik boşluk:
- Gerekirse revizyon önerisi:
```

### 5.3 — Pazar Araştırması
**Agent:** Market Scout

Ürün tipine göre doğru kaynaklardan veri topla:

- Mobil app: aktifse mcp-appstore, App Store, Google Play, yorumlar, keyword/ASO sinyalleri
- SaaS/web app: etkin Codex web/Browser/Chrome aracıyla G2, Capterra, Product Hunt, Reddit,
  Hacker News, Trustpilot, rakip siteleri
- Fiziksel işletme: Google Maps/GBP, Şikayetvar, yerel arama sonuçları, sektörel forumlar
- E-ticaret: marketplace yorumları, fiyat karşılaştırması, kategori trendleri
- Tümü: Google Trends, haberler, raporlar, sosyal kanıt, kullanıcı toplulukları

**Çıktı formatı (`02-arastirma/pazar-arastirmasi/pazar-arastirmasi.md`):**

```markdown
# Pazar Araştırması: [Fikir]
- Tarih: [tarih]

## Kaynak ve Kanıt Defteri
| ID | Araç | Kaynak | Erişim tarihi | Kullanılan veri | Güven |
|----|------|--------|---------------|-----------------|-------|

## Pazar ve Talep Sinyalleri
- Problem sıklığı:
- Para ödeme isteği:
- Trend yönü:
- Mevcut alternatifler:

## Rakip Listesi
| Rakip | Tip | Güçlü Yan | Zayıf Yan | Fiyat/Gelir Modeli | Kanıt |
|-------|-----|-----------|-----------|--------------------|-------|

## Müşteri Sinyalleri
- En sık şikayetler:
- Çözülmemiş beklentiler:
- Kullanıcıların kendi diliyle problem:

## Veri İşleme Notları
- Ham veri:
- Normalize edilen alanlar:
- Varsayımlar:
- Eksik veya erişilemeyen veri:
```

### 5.4 — Fikir Doğrulama
**Agent:** Strategy Analyst

`pazar-arastirmasi.md`, `kullanici-pazarlama-avantaji.md` ve kullanıcının fikrini birlikte
değerlendir.

**Çıktı formatı (`03-strateji/dogrulama/fikir-dogrulama.md`):**

```markdown
# Fikir Doğrulama: [Fikir]
- Tarih: [tarih]
- Kullanılan girdiler: [dosya referansları]

## Sert Değerlendirme Özeti
- En güçlü kanıt:
- En zayıf nokta:
- Ölümcül risk var mı:
- Agent'ın net görüşü:

## Değerlendirme Kriterleri
| Kriter | Puan (1-10) | Kanıt | Yorum |
|--------|-------------|-------|-------|
| Problem acısı | ... | ... | ... |
| Hedef kitle netliği | ... | ... | ... |
| Pazar/talep sinyali | ... | ... | ... |
| Rekabetten ayrışma | ... | ... | ... |
| Gelir potansiyeli | ... | ... | ... |
| MVP yapılabilirliği | ... | ... | ... |
| Kullanıcının pazarlama avantajı | ... | ... | ... |
| İlk 10-50 kullanıcıya erişim | ... | ... | ... |
| Maliyet/risk seviyesi | ... | ... | ... |
| Zamanlama | ... | ... | ... |
| **Toplam** | **.../100** | | |

## Karar
- Öneri: [Denenmeye Değer / Revizyonla Denenmeye Değer / Denenmeye Değmez]
- Gerekçe:
- Devam için zorunlu revizyonlar:
- Vazgeçme gerekçesi varsa:
```

Karar eşiği:

- `Denenmeye Değer`: toplam skor genelde 70/100 ve üzeri olmalı; problem acısı, pazarlama
  avantajı ve ilk kullanıcı erişimi ayrı ayrı zayıf olmamalı.
- `Revizyonla Denenmeye Değer`: fikirde sinyal var ama hedef kitle, kanal, kapsam, fiyat veya
  kullanıcı avantajı net değil.
- `Denenmeye Değmez`: acı zayıfsa, kullanıcı hedef kitleye ulaşamıyorsa, rekabet farkı yoksa,
  MVP maliyeti yüksekse veya gelir yolu gerçekçi değilse.

### 5.5 — Realist Karar Tartışması
**Agent:** Orchestrator

Kullanıcıya kısa ve net konuş:

```text
Doğrulama sonucu: [Denenmeye Değer / Revizyonla Denenmeye Değer / Denenmeye Değmez]
Neden:
1. ...
2. ...
3. ...

Benim pragmatik önerim:
- [Devam / şu revizyonla devam / bırak]

Kullanıcı avantajı açısından kritik gerçek:
- ...

Kararın:
1. Bu haliyle devam
2. Şu revizyonla tekrar değerlendir
3. Vazgeç
```

Kullanıcı "devam" dese bile agent ölümcül risk görüyorsa bunu tekrar belirtir ve PRD'ye geçmeden
önce riski `KARARLAR.md` veya değerlendirme raporuna yazar.

### 5.6 — MVP Yazımı
**Agent:** Product Architect

Sadece onaylı değer kararından sonra çalışır. MVP, fikrin minimum denenebilir ürün tanımıdır;
özellik yığını değildir.

**Çıktı:** `04-urun/fikir-ozetleri/mvp.md`

MVP şunları içermelidir:

- Nihai fikir tanımı
- Hedef kullanıcı ve ilk ulaşılacak segment
- Kullanıcının dağıtım avantajı ve ilk kullanıcı edinim yolu
- Çözülen ana problem
- MVP'nin tek ana vaadi
- Olmazsa olmaz özellikler
- Kapsam dışı bırakılanlar
- İlk manuel/concierge deneme yolu varsa
- Başarı metrikleri
- İlk 10-50 kullanıcıya ulaşma planı
- En büyük riskler ve test planı

### 5.7 — MVP Onayı
**Agent:** Orchestrator

MVP kapsamını kullanıcıyla tartış. Kapsam şişerse acımasızca daralt. Kullanıcı MVP'yi açıkça
onaylamadan PRD yazma.

### 5.8 — PRD Yazımı
**Agent:** Product Architect

Onaylı MVP'ye göre PRD üret. PRD, MVP'de olmayan yeni stratejik özellik ekleyemez; eklemek
gerekiyorsa önce MVP revize edilir.

**Çıktı:** `04-urun/prd/prd.md`

### 5.9 — Coder Brief
**Agent:** Product Architect

PRD'den coder için uygulanabilir brief çıkar.

**Çıktı:** `04-urun/coder-briefleri/coder-brief.md`

### 5.10 — Coder'a Yönlendirme
**Agent:** Orchestrator

Kullanıcıya şu net yönlendirmeyi yap:

```text
MVP ve PRD hazır.

Coder'a şu dosyaları ilet:
- 04-urun/fikir-ozetleri/mvp.md
- 04-urun/prd/prd.md
- 04-urun/coder-briefleri/coder-brief.md

Coder bu dosyaları okuyup teknik planı ve uygulama kapsamını çıkarabilir.
```

---

## P1 ve P5 Arasındaki Fark

| Özellik | P1 (Fikir Keşif) | P5 (Var Olan Fikir Değerleme) |
|---------|------------------|-------------------------------|
| Başlangıç noktası | Fikir yok | Fikir var |
| İlk iş | Fırsat üretmek | Fikri sert gerçeklikle test etmek |
| Kullanıcı profili | İlgi alanı için kullanılır | Pazarlama avantajı olarak skorlanır |
| Research | Fırsat keşfi için | Fikri öldürmek, revize etmek veya doğrulamak için |
| Karar | Fırsat seçimi | Denenmeye değer / revizyon / değmez |
| MVP | Fikir netleşirse | Sadece değer kararından sonra |
| PRD | MVP/idea brief sonrası | Onaylı MVP sonrası |

---

## Çıktı Dosyaları

| Dosya | Üreten | Açıklama |
|-------|--------|----------|
| `03-strateji/dogrulama/kullanici-pazarlama-avantaji.md` | Orchestrator | Kullanıcının fikri pazarlama gücü |
| `02-arastirma/pazar-arastirmasi/pazar-arastirmasi.md` | Market Scout | Rakip, trend, müşteri sinyali |
| `03-strateji/dogrulama/fikir-dogrulama.md` | Strategy Analyst | Sert skor, risk ve karar |
| `04-urun/fikir-ozetleri/mvp.md` | Product Architect | Onaylı MVP tanımı |
| `04-urun/prd/prd.md` | Product Architect | MVP'ye dayalı PRD |
| `04-urun/coder-briefleri/coder-brief.md` | Product Architect | Coder'a uygulanabilir özet |

Değerlendirme workspace'inde karşılık gelen çalışma dosyaları `ciktilar/` altında, nihai sentez
ise `RAPOR.md` içinde tutulur.

---

## PersonalAutonomy Yurutme Kurallari

- Ana cikti alanlari: 02-arastirma/, 03-strateji/dogrulama/ ve 04-urun/
- Pipeline kendi proje veya durum klasorunu olusturmaz. Aktif adimi DURUM.md ve ilgili
  .pa/*/active-task.md dosyasinda tutar.
- Degerlendirme workspace'inde proje-only adimlari uygulamaz; olumlu sonucu proje olusturma
  yetkisi olarak yorumlamaz.
- Degerlendirme workspace'inde MVP, PRD ve coder brief final teslimi uretme; bunlar proje
  workspace'inde onayli deger kararindan sonra yazilir.
- Projede PROJE.md, ilgili 01-baglam/ dosyalari ve KARARLAR.md on kosuldur.
- Guncel veri gerektiren iddialari kaynak ve erisim tarihiyle kaydeder; veri yoksa varsayimi
  acikca etiketler.
- Karar kapilarinda kullanicidan acik onay alir. Dosya uretmek haftalik gorevi tamamlamaz.
- Onayli final kopyalari 10-final/ altina alir ve calisma kaynagini yerinde korur.
