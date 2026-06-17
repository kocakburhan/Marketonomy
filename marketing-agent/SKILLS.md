# Marketing Agent Skill Katalogu

Bu release 36 yerel marketing skill'i tasir. Ana agent, goreve uygun skill'in
`skills/<skill>/SKILL.md` dosyasini okur. Codex'in global veya plugin skill'leri ancak aktif
skill listesinde gorunuyorsa ek capability olarak kullanilabilir; bu paket onlarin kurulu
oldugunu varsaymaz.

## Dosya Sistemi Kurali

Bu katalogdaki "Varsayilan proje cikti alani" sutunu hizli yonlendirme icindir. Nihai dosyalama
kurali her zaman `.pa/agent/AGENTS.md` icindeki MVP Dosya Sistemi Hakimiyeti ve `mvp/mvp.md`
klasor sozlesmesidir.

Ana agent bir skill calistirdiginda once workspace turunu belirler:

- Degerlendirme workspace'inde skill ciktilari `kaynaklar/`, `ciktilar/`, `RAPOR.md`,
  `DURUM.md` ve `.pa/evaluation/` disina yazilmaz.
- Proje workspace'inde ham girdiler `00-gelen-kutusu/` icinde korunur; islenmis ciktilar
  baglam, arastirma, strateji, urun, uygulama, lansman, rapor, varlik, final veya arsiv turune
  gore numarali klasorlerden birine yazilir.
- `10-final/` yalnizca acik final onayi alan teslimler icindir; kaynak calisma dosyasi kendi
  canonical klasorunde kalir.
- Haftalik gorevle bagli her skill, aktif `05-haftalik-planlar/YYYY-WNN.md` gorevini,
  `DURUM.md` ve `.pa/project/active-task.md` ile tutarli izler; gorevi ancak kullanici onayindan
  sonra `[x]` ve `Tamamlandi` yapar.

## Baglam ve Planlama

| Skill | Gorev | Varsayilan proje cikti alani |
|---|---|---|
| `product-marketing` | Urun, hedef kitle, deger onerisi ve konumlandirma baglami | `PROJE.md`, `01-baglam/` |
| `marketing-plan` | AARRR tabanli cok kanalli pazarlama plani | `03-strateji/pazara-giris/`, `03-strateji/buyume/` |
| `marketing-ideas` | Baglama uygun kampanya ve deney fikirleri | `03-strateji/buyume/` |
| `marketing-psychology` | Etik davranissal ekonomi ve mesaj ilkeleri | Ilgili strateji veya uygulama klasoru |
| `customer-research` | Gorusme, anket, JTBD ve feedback sentezi | `02-arastirma/musteri-arastirmasi/` |

## Arastirma ve Kesfedilebilirlik

| Skill | Gorev | Varsayilan proje cikti alani |
|---|---|---|
| `web-research` | Kanitli URL ve web kaynagi arastirmasi | Ilgili `02-arastirma/` klasoru |
| `competitor-profiling` | Tek rakibin derin profili | `02-arastirma/rakip-arastirmasi/` |
| `market-competitors` | Coklu rakip karsilastirmasi | `02-arastirma/rakip-arastirmasi/` |
| `seo-audit` | Teknik ve on-page SEO denetimi | `06-pazarlama-uygulamalari/dijital/seo/` |
| `ai-seo` | AI arama motorlari icin gorunurluk | `06-pazarlama-uygulamalari/dijital/seo/` |
| `aso` | App Store ve Google Play optimizasyonu | `06-pazarlama-uygulamalari/dijital/seo/` |
| `directory-submissions` | Dizin secimi ve basvuru takibi | `06-pazarlama-uygulamalari/dijital/` |

## Icerik ve Marka

| Skill | Gorev | Varsayilan proje cikti alani |
|---|---|---|
| `content-strategy` | Konu, format, kanal ve yayin ritmi | `06-pazarlama-uygulamalari/dijital/icerik/` |
| `copywriting` | Landing page ve urun sayfasi metni | `06-pazarlama-uygulamalari/dijital/landing-page/` |
| `copy-editing` | Mevcut pazarlama metnini iyilestirme | Kaynak dosyanin calisma klasoru |
| `emails` | Lifecycle ve kampanya email dizileri | `06-pazarlama-uygulamalari/dijital/eposta/` |
| `social` | Sosyal medya stratejisi ve takvimi | `06-pazarlama-uygulamalari/dijital/sosyal-medya/` |
| `market-brand` | Marka sesi ve farklilasma analizi | `01-baglam/marka.md`, `09-varliklar/marka/` |
| `image` | Kapsamli prompt ve Codex image generation uretimi | `09-varliklar/dijital/` veya `09-varliklar/basili/` |
| `video` | Video stratejisi, senaryo ve yapim briefi | `06-pazarlama-uygulamalari/dijital/icerik/` |

## Reklam, Donusum ve Analitik

| Skill | Gorev | Varsayilan proje cikti alani |
|---|---|---|
| `ads` | Ucretli kanal, hedefleme ve butce stratejisi | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `ad-creative` | Kitle bazli kreatif ve A/B varyasyonlari | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `market-ads` | Platforma ozel uygulanabilir reklam paketi | `06-pazarlama-uygulamalari/dijital/reklamlar/` |
| `market-funnel` | Funnel ve donusum darbogazi analizi | `03-strateji/pazara-giris/` |
| `analytics` | Event tracking, KPI ve dashboard plani | `08-raporlar/analitik/` |
| `market-report` | Kapsamli karar odakli pazarlama raporu | `08-raporlar/pazarlama/` |
| `market-report-pdf` | Onayli Markdown raporundan PDF teslimi | `08-raporlar/pdf/` |

## Buyume, Satis ve Lansman

| Skill | Gorev | Varsayilan proje cikti alani |
|---|---|---|
| `pricing` | Fiyatlandirma, paketleme ve monetizasyon | `03-strateji/fiyatlandirma/` |
| `paywalls` | Paywall ve upgrade donusumu | `03-strateji/fiyatlandirma/` |
| `churn-prevention` | Iptal, save offer ve reaktivasyon | `03-strateji/buyume/` |
| `referrals` | Referans ve davet programi | `03-strateji/buyume/` |
| `community-marketing` | Topluluk ve ambassador sistemi | `06-pazarlama-uygulamalari/hibrit/` |
| `prospecting` | ICP bazli potansiyel musteri listesi | `06-pazarlama-uygulamalari/saha/potansiyel-musteriler/` |
| `cold-email` | B2B cold email ve takip dizisi | `06-pazarlama-uygulamalari/saha/takip/` |
| `market-proposal` | Pazarlama hizmet teklifi | `06-pazarlama-uygulamalari/saha/teklifler/` |
| `launch` | Pre-launch, launch day ve post-launch | `07-lansman/` |

## Skill Zincirleri

| Senaryo | Yerel zincir |
|---|---|
| Fikir dogrulama | `web-research` -> `customer-research` -> `competitor-profiling` -> `pricing` |
| Urun lansmani | `product-marketing` -> `launch` -> `emails` -> `social` -> `directory-submissions` |
| Icerik sistemi | `content-strategy` -> `copywriting` -> `copy-editing` -> `seo-audit` |
| B2C dijital pazarlama | `product-marketing` -> `content-strategy` -> `social` -> `ads` -> `analytics` |
| B2C fiziksel pazarlama | `web-research` -> `market-competitors` -> `marketing-ideas` -> `copywriting` -> `image` -> `analytics` |
| B2B outbound ve satis | `prospecting` -> `cold-email` -> `market-proposal` -> `ads` -> `analytics` |
| B2B saha/partner satis | `prospecting` -> `market-proposal` -> `copywriting` -> `community-marketing` -> `analytics` |
| Buyume | `marketing-plan` -> `referrals` -> `churn-prevention` -> `analytics` |
| Rakip stratejisi | `web-research` -> `competitor-profiling` -> `market-competitors` -> `marketing-psychology` |
| Hibrit kampanya | `marketing-plan` -> `social` -> `ads` -> `copywriting` -> `market-report` |

Degerlendirme workspace'inde bu cikti yollarinin yerine `ciktilar/` kullanilir ve sentez
`RAPOR.md` dosyasina islenir. `10-final/` yalnizca acikca onaylanan proje teslimleri icindir.
