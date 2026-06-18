# PersonalAutonomy MVP Mimarisi

Bu dokuman, PersonalAutonomy projesinin MVP asamasinda nasil calisacagini tarif eder.
Amac, marketing ve coding ekibinin Codex destekli calisma akisini hizli, dusuk maliyetli
ve yonetilebilir sekilde test etmektir.

MVP'nin ana fikri sudur:

- Sisteme yalnizca yonetici tarafindan davet edilen kullanicilar girer.
- Her kullanici kendi bilgisayarinda Codex App kullanir; disaridayken desteklenen mobil uzaktan
  erisim akisini kullanabilir.
- Dosyalar Google Drive for desktop uzerinden senkronize edilir.
- Yalnizca marketer'larin kisisel Drive calisma alani vardir.
- Coder'lar sadece katildiklari proje klasorlerine erisir; coder icin kisisel Drive calisma
  klasoru olusturulmaz.
- Her fikir degerlendirmesi ve her proje ayri bir klasor, Codex root ve Codex thread olarak
  calisir.
- Marketing Agent dosyalari degerlendirme ve proje workspace'lerine surumlu olarak kopyalanir.
- Agent guncellemeleri merkezi release klasorunden script ile tum gecerli workspace'lere
  dagitilir.

Bu model asil deger onerisine odaklanir: marketing ekiplerinin teknik detaylarla
ugrasmadan, telefon uzerinden yonlendirebildikleri Codex agent'lari ile PRD, analiz,
rapor, landing page brief'i, sosyal medya icerigi ve kampanya ciktilari uretebilmesi.

---

## 1. Temel Sistem Bilesenleri

MVP sistemi bes ana parcadan olusur:

1. **Kullanici bilgisayari**
   - Codex App acik kalir.
   - Google Drive for desktop kurulu olur.
   - Mobil uzaktan erisim icin bilgisayar uyanik, cevrimici ve Codex App ayni ChatGPT
     hesabi/workspace'iyle oturum acmis durumda olur.
   - Marketer kendi degerlendirme ve proje klasorlerinde Codex thread'leri baslatir.
   - Coder, kendisiyle paylasilan proje klasorlerinde Codex thread'leri baslatabilir.

2. **ChatGPT mobil uygulamasi**
   - Codex App'teki mobil kurulum/QR akisi ile yetkili host'a baglanir.
   - Kullanici disaridayken telefondan ayni Codex thread'lerine erisir.
   - Onay verir, yonlendirme yapar, ciktilari inceler.

3. **Google Drive**
   - Ana dosya depolama ve senkronizasyon katmanidir.
   - Marketer calisma alanlari kullanici bazli izole edilir.
   - Coder'a yalnizca katildigi proje klasoru paylasilir.
   - Degerlendirme ve proje dosyalari, PRD, rapor, analiz ve varliklar burada saklanir.

4. **Marketing agent paketi**
   - Her degerlendirme ve proje workspace'ine kopyalanir.
   - Codex'in aktif workspace'te nasil davranacagini belirler.
   - Merkezi release klasorunden guncellenir.

5. **PersonalAutonomy web app (PWA)**
   - Davetli kullanici kaydini ve rol sinirlarini yonetir.
   - Idea Pool, marketer degerlendirmeleri ve Project Pool is akisini yonetir.
   - Roller, proje uyelikleri, durumlar, Drive linkleri ve degisiklik gecmisini tutar.
   - Telefonlara Web Push bildirimi gonderir ve uygulama ici bildirim merkezi sunar.
   - Gercek proje dosyalarini depolamaz; Google Drive'a baglanti verir.

MVP'nin operasyonel saat dilimi `Europe/Istanbul` olarak sabittir. Web app zaman damgalarini
veritabaninda UTC saklar, arayuzde `Europe/Istanbul` olarak gosterir. ISO hafta dosya adi ve
Pazartesi-Pazar plan sinirlari da bu saat dilimine gore hesaplanir.

---

## 2. Google Drive Klasor Modeli

Ana Drive klasoru sistem sahibine aittir. Ana klasor herkese acilmaz. Marketer'lara yalnizca
kendi kisisel calisma klasorleri, coder'lara ise yalnizca katildiklari proje klasorleri
paylasilir.

MVP'nin zorunlu Drive yapisi:

```text
PersonalAutonomy/
  shared/
    tools/
      create-evaluation.ps1
      create-project.ps1
    templates/
    logs/

  marketers/
    ayse/
      .pa-create-work/
      .pa-script-logs/
      idea-workspace/
        fikir-001-ornek-fikir/
      projects/
        x-projesi/

    mehmet/
      idea-workspace/
      projects/
```

Paylasim kurali:

```text
PersonalAutonomy/
  Yalnizca sistem sahibi

PersonalAutonomy/shared/tools/
  Sistem sahibi: Editor
  Marketer'lar: Viewer ve yerel calistirma

PersonalAutonomy/shared/templates/
  Sistem sahibi: Editor
  Marketer'lar: Viewer

PersonalAutonomy/shared/logs/
  Yalnizca sistem sahibi

PersonalAutonomy/marketers/ayse/
  Sistem sahibi + Ayse

PersonalAutonomy/marketers/mehmet/
  Sistem sahibi + Mehmet

Bir proje klasoru:
  Sistem sahibi + Drive host marketer + projeye katilan marketer/coder'lar
```

Bu modelin sonucu:

- Sistem sahibi tum klasorleri gorebilir.
- Marketer yalnizca kendi kisisel alanini ve kendisiyle ayrica paylasilan proje klasorlerini
  gorur.
- Yalnizca Coder rolundeki kullanici icin `marketers/<kullanici>/` klasoru olusturulmaz.
- Coder yalnizca katildigi proje klasorunu gorur; baska marketer alanlarini veya projelerini
  goremez.
- Degerlendirme ham notlari marketer'in kisisel `idea-workspace/` alaninda kalir.
- Tum kullanicilar degerlendirme sonucunu web app'te okur. Istege bagli Drive raporu ayrica
  Viewer olarak paylasilir ve linki web app'e eklenir.
- Teknik agent update loglari `shared/logs/` altinda tutulur ve yalnizca Burhan Kocak
  tarafindan erisilebilir.
- Marketer tarafindan calistirilan create scriptlerinin sanitize edilmis teknik loglari ilgili
  kullanicinin `.pa-script-logs/` klasorunde tutulur; sistem sahibi ana Drive sahipligi
  sayesinde bu kayitlari inceleyebilir.

Bir projede birden fazla marketer veya coder calisacaksa tum `marketers/` alani acilmaz;
yalnizca ilgili proje klasoru yeni ekip uyeleriyle tek tek paylasilir. Proje klasoru ilk olumlu
marketer'in alaninda olusturulur ve bu kisi web app'te `Drive host marketer` olarak izlenir.
Host sorumlulugu degerlendirme sonucundan ayridir; acik devir tamamlanmadan kendiliginden baska
bir kullaniciya gecmez.

---

## 3. Kullanici Klasoru (Local & Codex)

Kisisel Drive calisma alani yalnizca Marketer rolundeki kullanicilar icin olusturulur:

```text
marketers/
  ayse/
    .pa-create-work/
    .pa-script-logs/
    idea-workspace/
      fikir-001-ornek-fikir/
    projects/
      x-projesi/
      y-projesi/
```

`idea-workspace/`, fikir Project Pool'a gecmeden once yapilan Marketing Agent destekli
incelemeler icindir. Her fikir degerlendirmesi ayri klasor, Codex root ve thread olarak
calisir.

`projects/`, marketer'in Drive host oldugu proje klasorlerini tutar. Bir proje baska bir
marketer'in alaninda bulunuyorsa ilgili klasor marketer veya coder ile Google Drive uzerinden
ayrica paylasilir; kullanicinin kisisel klasorune ikinci bir proje kopyasi olusturulmaz.

`.pa-script-logs/`, `create-evaluation.ps1` ve `create-project.ps1` hata/sonuc loglari icindir.
Loglar kullanici girdisinin veya proje iceriginin tamamini degil; zaman, script adi, hata kodu,
hedef kimlik ve sanitize edilmis teknik nedeni tutar. Kullanici bu klasoru elle yonetmez.

`.pa-create-work/`, create scriptlerinin ayni dosya sistemi icindeki gecici hazirlama alanidir.
Gecici workspace'ler `idea-workspace/` veya `projects/` altinda olusturulmaz. Basarili
dogrulamadan sonra hedef kokteki kalici adina tek tasima ile yayinlanir; hata halinde gecici
alan temizlenir.

Bu iki ust klasor yalnizca su islemler icin Codex root olabilir:

- mevcut workspace'leri listeleme
- `create-evaluation.ps1` ile yeni degerlendirme workspace'i olusturma
- `create-project.ps1` ile yetkili yeni proje workspace'i olusturma

Analiz, rapor, PRD, icerik veya diger gercek calismalar her zaman ilgili degerlendirme ya da
proje klasorunun icinde yeni bir Codex thread ile yapilir.

Yalnizca Coder rolundeki kullanicinin kisisel `idea-workspace/` veya `projects/` klasoru olmaz.
Coder, Project Pool'dan katildigi ve Drive erisimi kendisine manuel olarak verilen proje
klasorunu kendi bilgisayarinda senkronize ederek calisir.

---

## 4. Degerlendirme ve Proje Klasorleri

Bu bolum iki ayri workspace turunu tanimlar: fikir Project Pool'a gecmeden once kullanilan
degerlendirme workspace'i ve olumlu marketer karariyla olusan proje workspace'i. Iki tur de
bagimsiz Codex root ve thread olarak calisir; birbirinin dosyalarini otomatik baglam olarak
kullanmaz.

### Fikir degerlendirme workspace'i

Her marketer, degerlendirecegi fikir icin kendi Drive alaninda ayri workspace olusturur:

```text
marketers/
  ayse/
    idea-workspace/
      fikir-001-ornek-fikir/
        AGENTS.md
        DEGERLENDIRME.md
        DURUM.md
        RAPOR.md

        kaynaklar/
        ciktilar/
        notlar/

        .pa/
          agent/
            AGENTS.md
            ARCHITECTURE.md
            SKILLS.md
            agents/
            pipelines/
            skills/
            scripts/
            templates/
            mcps.json
            release-manifest.json
            agent-version.json
          evaluation/
            state.json
            active-task.md
            settings.json
```

`DEGERLENDIRME.md`, web app'in degismez `idea_id` degerini, fikir basligini, incelenen fikir
surumunu, degerlendiren marketer'i, karar kriterlerini ve son yayin durumunu tutar. `idea_id`
script tarafindan yazilir; kullanici veya agent tarafindan degistirilemez.

`DURUM.md`, degerlendirmenin aktif adimini, bekleyen karari ve sonraki islemi insan tarafindan
okunabilir bicimde ozetler. `RAPOR.md`, marketer isterse web app'teki sonuca ekleyecegi raporun
calisma dosyasidir. Ham kaynaklar `kaynaklar/`, uretilen analiz ve rapor dosyalari `ciktilar/`
altinda tutulur. Degerlendirme sirasinda tutulan serbest calisma notlari, gorusme notlari ve
kullanicinin agent'a aldirdigi notlar `notlar/` altinda saklanir.

`.pa/agent/`, merkezi release'ten kopyalanan bagimsiz Marketing Agent paketidir.
`.pa/evaluation/`, degerlendirme workspace'inin makine-okunabilir durumunu ve teknik ayarlarini
tutar. Bu dosyalar web app workflow'unu veya fikir kimligini degistiremez.

Degerlendirme sonucu, istege bagli aciklama ve istege bagli rapor linki web app'e yazilir. Ham
workspace dosyalari marketer'in kisisel alaninda kalir ve diger kullanicilara otomatik olarak
acilmaz.

#### Data-endeksli fikir kesfi

Marketer veya kullanici henuz net bir fikirle gelmediginde Marketing Agent, serbest beyin
firtinasi yapmak yerine data-endeksli fikir kesfi yapar. Bu calisma yine marketer'in kendi
`idea-workspace/` alaninda ve tekil Codex root/thread icinde tutulur.

Fikir kesfi icin agent su kaynakli akislari kullanir:

- App Store / Google Play siralama, kategori, yorum ve monetizasyon sinyalleri icin
  `store-intelligence`.
- Forum, Reddit, sikayet, yorum ve topluluk agrisi icin `complaint-mining`.
- Rakip ozellik, fiyatlandirma, konumlandirma ve yorum bosluklari icin `competitor-gap`.
- Google Trends, haber, Product Hunt, GitHub ve sosyal sinyal gibi yukselen konular icin
  `trend-to-product`.
- Bu kullanicinin fikri gercekten pazarlayip pazarlayamayacagini olcmek icin
  `user-advantage-fit`.

Bu akislarda Codex'in mevcut official web search, Browser, Chrome ve gerekirse public sayfalarda
Playwright/browser automation yetenekleri kullanilir. MCP veya ucretli veri saglayicilar zorunlu
degildir; aktif arac listesinde gorunuyorsa adapter olarak kullanilabilir. Agent gorunmeyen bir
MCP/API'yi kurulmus sayamaz.

App Store ve Google Play icin MVP karari:

- Apple public RSS/Search/Lookup kaynaklari ve gorunur store sayfalari oncelikli kullanilir.
- Google Play rakip verisi icin resmi Play Developer API zorunlu kaynak degildir; rakip
  arastirmasinda public sayfa, scraper, Browser/Chrome, Playwright fallback veya manuel export
  kullanilir.
- Tek gunluk chart verisi bir kategorinin `su an guclu` oldugunu gosterebilir; `yukseliste`
  demek icin workspace'te saklanan 7/14/30 gunluk snapshot veya guvenilir tarihsel kaynak
  gerekir.
- Kesin revenue, download, keyword volume veya rank gecmisi kaynak saglamiyorsa uydurulmaz;
  gerekiyorsa `Tahmin` veya `Veri yok` olarak etiketlenir.

Fikir kesfi ciktisi en az su izleri tasir:

- `Kaynak ve Kanit Defteri`
- `Veri Isleme Notlari`
- firsat skoru
- guven etiketi
- kullanici pazarlama avantaji
- ilk 10-50 kullaniciya ulasma plani
- ilk dogrulama testi ve durdurma kosulu

Bu akistan uretilen fikir otomatik olarak onaylanmis sayilmaz. Kullanici fikri ilerletmek isterse
fikir, Marketing Agent'in `idea-to-prd` degerlendirme kapisina girer ve yine `Denenmeye Deger`,
`Revizyonla Denenmeye Deger` veya `Denenmeye Degmez` sonucuyla tartilir.

### Proje workspace'i

Her proje bagimsiz bir Codex workspace olarak dusunulur. Codex thread'i dogrudan bu klasorde
baslar; bu nedenle proje klasoru hem calisma alani, hem hafiza, hem de cikti deposudur.

Ornek:

```text
marketers/
  ayse/
    projects/
      x-projesi/
        AGENTS.md
        PROJE.md
        DURUM.md
        KARARLAR.md
        README.md

        00-gelen-kutusu/
          fikir.md
          kullanici-notlari.md
          ham-linkler.md
          yuklemeler/
            pdf/
            dokumanlar/
            tablolar/
            sunumlar/
            gorseller/
            ekran-goruntuleri/
            ses-video/
            referanslar/
            diger/

        01-baglam/
          urun-baglami.md
          hedef-kitle.md
          marka.md
          kisitlar.md
          rakipler.md

        02-arastirma/
          pazar-arastirmasi/
          rakip-arastirmasi/
          musteri-arastirmasi/
          trend-arastirmasi/
          store-intelligence/
            raw/
            snapshots/

        03-strateji/
          dogrulama/
          konumlandirma/
          fiyatlandirma/
          pazara-giris/
          buyume/

        04-urun/
          fikir-ozetleri/
          prd/
          coder-briefleri/
          urun-kararlari/

        05-haftalik-planlar/
          2026-W25.md
          2026-W25/
            schedule.md
            pazartesi.md
            sali.md
            carsamba.md
            persembe.md
            cuma.md
            cumartesi.md
            pazar.md

        06-pazarlama-uygulamalari/
          dijital/
            icerik/
            sosyal-medya/
            eposta/
            landing-page/
            reklamlar/
            seo/
          saha/
            potansiyel-musteriler/
            toplantilar/
            demolar/
            sunumlar/
            teklifler/
            etkinlikler/
            takip/
            satis-materyalleri/
          hibrit/
            kampanyalar/
            musteri-yolculuklari/
            kanal-koordinasyonu/

        07-lansman/
          lansman-planlari/
          kontrol-listeleri/
          kanal-planlari/

        08-raporlar/
          haftalik/
          pazarlama/
          analitik/
          pdf/
          excel/

        09-varliklar/
          dijital/
          basili/
          marka/

        10-final/
          prd/
          coder-briefleri/
          raporlar/
          lansman/
          dijital/
          saha/
          hibrit/
          linkler.md

        11-notlar/
          ham-notlar/
          gunluk-notlar/
          toplanti-notlari/
          musteri-gorusmeleri/
          saha-notlari/
          takip-notlari/
          ozetler/

        99-arsiv/
          eski-versiyonlar/
          reddedilenler/
          gecersiz-kalanlar/

        .pa/
          agent/
            AGENTS.md
            ARCHITECTURE.md
            SKILLS.md
            agents/
            pipelines/
            skills/
            scripts/
            templates/
            mcps.json
            release-manifest.json
            agent-version.json
          project/
            overrides.md
            overrides-approved.md
            state.json
            active-task.md
            settings.json
```

### Dosyalarin gorevleri

`AGENTS.md`

Proje kokunde bulunan, guncellemelerde degismeyen bootstrap talimat dosyasidir. Codex'e aktif
marketing-agent talimatlarini `.pa/agent/AGENTS.md` dosyasindan okumasini, proje kokunun disina
cikmamasini ve proje ozel ayarlar icin `.pa/project/` dosyalarini kullanmasini soyler. Agent
surumu degistiginde kok `AGENTS.md` yeniden yazilmaz; surumlenen talimatlar `.pa/agent/`
altinda guncellenir. Script'lerin dosyayi dogrulayabilmesi icin bootstrap sablonu
`PA_BOOTSTRAP_VERSION: 1` makine-okunabilir isaretini tasir.

`PROJE.md`

Projenin ana kimlik kartidir:

- web app tarafindan uretilen degismez `project_id`
- bagli fikrin degismez `idea_id` degeri
- proje amaci
- urun/fikir ozeti
- proje ekibi ve Drive host icin ana kaynak olan web app Project Pool kaydina referans
- oncelikler
- kisitlar
- musteri/urun bilgileri
- musteri modeli: B2B / B2C / Hibrit
- pazarlama modeli: Dijital / Saha / Hibrit
- satis yaklasimi: Self-service / Ic satis / Yuz yuze / Karma
- hedef pazar ve segmentler
- satis dongusu
- temel karar vericiler
- kullanilan pazarlama ve satis kanallari

`DURUM.md`

Projenin anlik operasyonel durum dosyasidir:

- aktif pipeline veya is akisi nedir?
- son yapilan is nedir?
- bekleyen kullanici karari var mi?
- PRD, analiz, rapor veya icerik hangi asamada?
- aktif haftalik plan hangisidir?
- hangi haftalik gorevler kullanici onayi beklemektedir?
- marketer onayi var mi?
- sonraki adim ne?

`KARARLAR.md`

Kullanicinin proje boyunca verdigi onemli kararlarin tarihcesidir. Ornegin hedef segment,
fiyatlandirma yonu, MVP kapsami, marka tonu, devam/pivot/vazgec kararlari burada tutulur.

`README.md`

Proje klasorunu acan kisinin neyin nerede oldugunu hizlica anlamasi icin kisa aciklama
dosyasidir.

### Klasorlerin gorevleri

`00-gelen-kutusu/`

Kullanicidan gelen ham girdilerin toplandigi alandir. Agent burada duzenli cikti uretmez;
buradaki bilgileri okuyup isleyerek diger klasorlere duzenli ciktilar yazar.

`00-gelen-kutusu/fikir.md`

Ilk fikir, problem tanimi veya kullanicinin baslangic notu burada tutulur.

`00-gelen-kutusu/kullanici-notlari.md`

Kullanicinin serbest notlari, ek aciklamalari ve dusunceleri icindir.

`00-gelen-kutusu/ham-linkler.md`

Rakip sayfalari, haberler, urun linkleri, yorum sayfalari ve islenmemis diger linkler burada
toplanir.

`00-gelen-kutusu/yuklemeler/`

Kullanicinin disaridan getirdigi dosyalar icindir. Yuklemeler dosya tipine gore alt klasorlere
ayrilir:

- `pdf/`: rapor, makale, whitepaper, katalog veya kullanicinin Codex'e inceletmek istedigi PDF kaynaklari
- `dokumanlar/`: Word, Markdown, metin dosyalari ve eski brief dokumanlari
- `tablolar/`: Excel, CSV veya Google Sheets'ten indirilen ham veri dosyalari
- `sunumlar/`: PPT/PPTX, eski pitch deck veya musteri sunumlari
- `gorseller/`: fotograf, reklam gorseli, kreatif referans veya marka gorselleri
- `ekran-goruntuleri/`: urun, rakip, analytics, yorum veya kampanya ekran goruntuleri
- `ses-video/`: gorusme kaydi, demo videosu, reklam videosu veya ses notlari
- `referanslar/`: ornek landing page, kampanya, marka veya tasarim referans dosyalari
- `diger/`: yukaridaki kategorilere uymayan gecici dosyalar

`01-baglam/`

Agent'in her calismada bilmesi gereken uzun omurlu proje bilgilerini tutar. Urun baglami,
hedef kitle, marka tonu, kisitlar ve bilinen rakipler burada netlesir.

`02-arastirma/`

Pazar, rakip, musteri, trend ve store intelligence arastirmalarinin calisma alanidir. Market
Scout veya benzeri arastirma adimlari ciktilarini burada uretir. App Store / Google Play
arastirmalarinda normalize edilmis raporlar `store-intelligence/`, ham chart/review verileri
`store-intelligence/raw/`, gunluk chart snapshot'lari ise `store-intelligence/snapshots/`
altinda tutulur.

`03-strateji/`

Arastirmadan cikan yorumlarin stratejiye donustugu alandir. Fikir dogrulama, konumlandirma,
fiyatlandirma, pazara giris ve buyume planlari burada tutulur.

`04-urun/`

Fikrin urun dokumanlarina donustugu alandir. PRD taslaklari, coder briefleri, fikir ozetleri
ve urun kapsami kararlarini icerir.

`05-haftalik-planlar/`

Marketing agent ile kullanicinin birlikte hazirladigi haftalik operasyon planlarini tutar.
Her hafta ISO yil ve hafta numarasiyla ayri dosya olarak saklanir; ornegin
`2026-W25.md`. Plan Pazartesi-Pazar gunlerini kapsar ve gorevler gunlere dagitilir. Ayni hafta
icin `YYYY-WNN/` alt klasoru da olusturulabilir; bu klasor `schedule.md` haftalik gorunumunu ve
`pazartesi.md` ... `pazar.md` gunluk yapilacaklar listelerini tutar.

Her gorev en az su bilgileri tasir:

```markdown
- [ ] Gorev: B2B demo sunumunu hazirla
  - Kanal: Saha
  - Oncelik: Yuksek
  - Beklenen cikti: Demo sunumu
  - Cikti konumu: 06-pazarlama-uygulamalari/saha/sunumlar/
  - Durum: Bekliyor
  - Tamamlanma kaniti: Dosya / Kullanici bildirimi / Harici aksiyon
  - Google Calendar: Eklenecek / Eklendi / Guncellendi / Silindi / Kullanilmadi
```

Gorev durumlari `Bekliyor`, `Devam Ediyor`, `Kanıt ile Tamamlandı.`, `Kullanici Bildirimi
Bekliyor`, `Ertelendi`, `Iptal` veya `Tamamlandi` olabilir. Bir gorevin tamamlandigi uretilen
dosya, guncellenen dokuman, hazirlanan cikti veya benzeri acik kanitla anlasiliyorsa agent
gorevi kullaniciya sormadan tamamlandi olarak isaretler ve bunu kullaniciya bildirir. Bir
gorevin tamamlanmasi yatirim toplantisi, ofis ziyareti, telefon gorusmesi veya fiziksel dagitim
gibi agent'in dosyadan anlayamayacagi harici bir aksiyona bagliysa gorev `Kullanici Bildirimi
Bekliyor` olarak kalir; kullanici tamamladigini soylediginde guncellenir. Agent kullaniciyi surekli
"bunu yaptin mi?" diye darlamaz.

Schedule, Marketing Agent'in operasyon hafizasidir. Agent buradan kullanicinin dun ne yaptigini,
gecen hafta nelerin tamamlandigini, bugunku islerini, yarinki planini ve ertelenen gorevleri
anlar. Haftalik plan hazirlanirken agent kullaniciya `Aggressive`, `Balanced` veya `Relaxed`
tempo seceneklerini sorar; plan hazirlandiktan sonra yogunlugu artirmayi veya azaltmayi onerir.
Google Calendar plugini aktifse, dosya sistemindeki schedule ana kaynak kalmak kosuluyla
etkinlikler kullanici onayiyla Google Calendar'a eklenebilir veya guncellenebilir.
Ertelenen, iptal edilen veya sonraki haftaya aday gorevler gerekcesiyle kaydedilir. Tamamlanmayan
gorevlerin yeni haftaya tasinmasina agent ve kullanici birlikte karar verir.

`06-pazarlama-uygulamalari/`

Projenin pazarlama ve satis destek faaliyetlerinin uygulama alanidir. B2C, B2B ve hibrit
projelerin dijital ve yuz yuze calismalarini tek proje baglami icinde tutar.

`06-pazarlama-uygulamalari/dijital/`

Icerik, sosyal medya, eposta, landing page, dijital reklam ve SEO calismalarini tutar.
Buradaki `eposta/` klasoru pazarlama kampanyasi icerikleri icindir; web app'in sistem veya
workflow bildirimi gonderdigi anlamina gelmez.

`06-pazarlama-uygulamalari/saha/`

B2B ve yuz yuze pazarlama/satis destek surecini bastan sona kapsar. Potansiyel musteri
listeleri, toplanti hazirliklari ve notlari, demolar, sunumlar, teklifler, etkinlikler,
takip faaliyetleri ve satis materyalleri burada tutulur.

`06-pazarlama-uygulamalari/hibrit/`

Dijital ve saha kanallarinin birlikte yurutuldugu kampanyalari, musteri yolculuklarini ve
kanallar arasi koordinasyon planlarini tutar.

`07-lansman/`

Urun veya kampanya yayinlanmadan onceki lansman planlari, kanal planlari ve kontrol listeleri
burada tutulur. Lansman dijital, saha veya hibrit olabilir.

`08-raporlar/`

Haftalik raporlar, pazarlama raporlari, analitik raporlari ve disari aktarilacak rapor
dosyalari burada tutulur. PDF ciktilari `pdf/`, Excel veya CSV tabanli rapor ciktilari
`excel/` altinda saklanir.

`09-varliklar/`

Projede kullanilan secilmis ve tekrar kullanilabilir varliklari tutar. `dijital/` sosyal
medya, reklam ve web gorselleri; `basili/` brosur, kartvizit, katalog, afis ve etkinlik
materyalleri; `marka/` ise logo, renk, font ve ortak marka kaynaklari icindir.

`10-final/`

Onaylanmis ve teslim edilebilir son ciktilarin yeridir. Yetkili marketer, coder veya sistem
sahibi proje klasorunu actiginda once buraya bakarak final PRD, coder brief, rapor, lansman ve
dijital, saha veya hibrit pazarlama ciktilarina ulasir.

`11-notlar/`

Proje boyunca tutulan calisma notlari, toplantilar, musteri gorusmeleri, saha notlari, takip
notlari ve ozetler icindir. Kullanici buraya manuel not alabilir veya Marketing Agent'tan bu
alanda not tutmasini isteyebilir. Notlar Drive ile senkronize olur; ancak ham kaynak dosyalari
yerine gecmez ve ilgili arastirma, strateji, satis ya da rapor ciktilari kendi canonical
klasorlerine ayrica yazilir.

`99-arsiv/`

Artik aktif olmayan ama silinmemesi gereken eski versiyonlar, reddedilen fikirler ve gecersiz
kalan ciktilar burada saklanir.

`.pa/agent/`

Bu projede kullanilacak marketing-agent paketidir. Merkezi agent release'inden kopyalanir.
Agent tanimlari, pipeline'lar, skill'ler, script'ler, template'ler ve surum bilgisi burada
bulunur.

`.pa/project/overrides.md`

Her projede bulunmasi zorunlu, insan tarafindan okunabilir proje tercihleri dosyasidir.
Agent'in proje ozelinde nasil davranacagini belirler. Ornegin:

- bu proje daha resmi bir marka dili kullansin
- ciktilar B2B SaaS tonunda olsun
- raporlar kisa ve karar odakli olsun
- PRD ciktilari coder'a dogrudan teslim edilebilir bicimde olsun

Rakipler, hedef kitle, fiyat ve urun bilgileri gibi proje gercekleri bu dosyada tutulmaz;
`PROJE.md` ve `01-baglam/` altindaki ilgili dosyalara yazilir. Agent guncelleme scriptleri
`overrides.md` dosyasina dokunmaz. Agent dosyayi yalnizca acik kullanici onayindan sonra
gunceller ve degisikligi `KARARLAR.md` dosyasina kaydeder.

`.pa/project/overrides-approved.md`

Son kullanici onayli `overrides.md` iceriginin agent tarafindan yonetilen kopyasidir. Manuel
degisiklik reddedilirse onceki onayli tercihleri geri getirmek ve degisen maddeleri gostermek
icin kullanilir. Kullanici bu dosyayi elle duzenlemez.

`.pa/project/state.json`

Agent'in makine-okunabilir proje durumudur. Aktif pipeline, aktif adim, son cikti, bekleyen
karar ve devam bilgisi burada tutulabilir. Aktif haftalik plan, gunluk gorev durumlari ve
kullanici tamamlanma onayi bekleyen gorevler de bu dosyada izlenir. Bu dosyadaki durum,
haftalik Markdown planinin yerine gecmez; agent'in sureci guvenilir bicimde surdurmesine
yardimci olur. Dosya agent ve script tarafindan yonetilir; kullanici tarafindan elle
duzenlenmez. Web app'in degismez `project_id` ve `idea_id` degerleri ile onaylanmis son
`overrides.md` iceriginin SHA-256 degeri burada tutulur. Kimlik alanlari proje olusturulduktan
sonra agent, override veya normal kullanici islemiyle degistirilemez.

`.pa/project/active-task.md`

O anda yurutulen isin kisa tanimidir. Codex thread'i yarida kalirsa veya yeni thread
acilirsa agent'in hizli toparlanmasina yardim eder. Agent tarafindan yonetilir; kullanici bu
dosyayi dogrudan duzenlemek yerine gorev degisikligini Codex'e soyler.

`.pa/project/settings.json`

Proje ozel teknik ayarlar icindir. Dil, varsayilan cikti bicimi, final klasor davranisi veya
script ayarlari gibi bilgiler burada tutulur. Dosya agent ve script tarafindan yonetilir.
Kullanici bir teknik ayari degistirmek istediginde Codex'e soyler; agent degisikligi aciklar,
onay aldiktan sonra gunceller ve gerekiyorsa `KARARLAR.md` dosyasina kaydeder.

---

## 5. Codex Calisma Kurali

En kritik MVP kurali:

> Her gercek calisma thread'i dogrudan tek bir degerlendirme veya proje workspace'inde baslatilir.

Dogru degerlendirme root'u:

```text
PersonalAutonomy/marketers/ayse/idea-workspace/fikir-001-ornek-fikir
```

Dogru proje root'u:

```text
PersonalAutonomy/marketers/ayse/projects/x-projesi
```

Yanlis gercek calisma root'lari:

```text
PersonalAutonomy/marketers/ayse
PersonalAutonomy/marketers/ayse/idea-workspace
PersonalAutonomy/marketers/ayse/projects
PersonalAutonomy/marketers
```

`idea-workspace/` ve `projects/` ust klasorlerinde Codex yalnizca workspace listeleme ve
ilgili create script'ini calistirma icin kullanilir. Fikir analizi, degerlendirme raporu, PRD,
pazar arastirmasi, icerik veya diger gercek isler her zaman olusturulan workspace klasorunde
yeni bir thread ile yapilir.

Coder kendi kisisel workspace'ini olusturmaz. Katildigi proje klasoru kendisiyle Drive
uzerinden paylasildiktan ve yerel olarak senkronize edildikten sonra Codex root olarak bu
paylasilan proje klasorunu acar.

Bu kuralin nedeni:

- Codex aktif fikir veya proje baglamini net bilir.
- Kardes degerlendirme ve proje klasorlerini gereksiz yere okumaz.
- Farkli fikirlerden veya projelerden bilgi karisma riski azalir.
- Her workspace kendi thread gecmisine ve agent durumuna sahip olur.
- Kok `AGENTS.md` workspace sinirlarini belirler ve aktif agent talimatlari icin
  `.pa/agent/AGENTS.md` dosyasina yonlendirir.
- Degismez `idea_id` ve `project_id` degerleri web app kaydi ile yerel workspace arasindaki
  baglantiyi korur.

---

## 6. Workspace Olusturma Akislari

Workspace klasorlerini ve zorunlu dosyalarini Codex serbest bicimde tek tek olusturmaz.
Degerlendirme workspace'i `create-evaluation.ps1`, proje workspace'i `create-project.ps1`
tarafindan olusturulur. Scriptler onayli sablonlari ve guncel agent release'ini kullanir,
gecici alanda dogrulama yapar ve yalnizca eksiksiz sonucu kalici adiyla yayinlar.

Create scriptleri guncel release'i klasor degisiklik tarihine veya metin siralamasina gore
secmez. `vMAJOR.MINOR.PATCH` klasorleri semantik surum tamsayilariyla karsilastirilir ve en
yuksek surum aday secilir. Bu aday manifest/hash dogrulamasindan gecmezse daha eski surume
sessizce geri dusulmez; workspace olusturma durdurulur ve yoneticiye bildirilir.

### Yeni fikir degerlendirmesi olusturma

Marketer kendi `idea-workspace/` klasorunde Codex thread'i baslatir:

```text
PersonalAutonomy/marketers/ayse/idea-workspace
```

Web app'teki fikir kimligini ve kisa basligi kullanarak su talebi verir:

```text
Fikir degerlendirmesi olustur:
idea_id: fikir-001
baslik: Ornek Fikir
```

Codex, marketer kimligini aktif kullanici klasorunden belirler ve `create-evaluation.ps1`
script'ini `idea_id`, kisa baslik ve marketer kimligiyle calistirir. Script su islemleri
sirasiyla gerceklestirir:

```text
1. Komutun bir marketer'in kendi idea-workspace klasorunde calistirildigini kontrol eder.
2. idea_id degerinin bos olmadigini, beklenen guvenli kimlik bicimine uydugunu ve sonradan
   degistirilemez alan olarak kullanilabilecegini dogrular.
3. Kisa basligi guvenli klasor adina donusturur. Ornegin "Ornek Fikir" icin
   "fikir-001-ornek-fikir" onerir ve devam etmeden once kullanici onayi ister.
4. Ayni marketer'in idea-workspace altindaki gecerli state.json dosyalarinda ayni idea_id
   degerini arar. Bulursa ikinci workspace olusturmaz ve mevcut klasor yolunu gosterir.
5. Guncel marketing-agent release'ini ve zorunlu degerlendirme sablonlarini dogrular.
6. On kontroller basariliysa kullanicinin .pa-create-work/ alaninda benzersiz adli gecici
   klasor olusturur.
7. AGENTS.md, DEGERLENDIRME.md, DURUM.md, RAPOR.md, kaynaklar/, ciktilar/,
   .pa/agent/ ve .pa/evaluation/ yapisinin tamamini gecici klasorde olusturur.
8. Kok AGENTS.md dosyasini degismeyen bootstrap sablonundan uretir ve aktif talimatlar icin
   .pa/agent/AGENTS.md dosyasina yonlendirir.
9. DEGERLENDIRME.md ve .pa/evaluation/state.json icine idea_id, marketer kimligi ve olusturma
   zamanini yazar. Baslangic durumunu "Degerlendirme hazirlaniyor" olarak ayarlar.
10. Guncel agent paketini .pa/agent altina kopyalar; manifest, hash, JSON ve zorunlu dosya
    kontrollerini yapar.
11. Workspace'i Bolum 4'teki zorunlu yapiya gore dogrular. Hata varsa gecici klasoru temizler.
12. Dogrulanan gecici klasoru tek yeniden adlandirma islemiyle kalici adina cevirir. Drive
    kilidi varsa iki saniye arayla toplam uc kez dener; basarisizlikta kalici klasor birakmaz.
13. Kullaniciya yeni klasoru Codex root olarak acmasini, ayri thread baslatmasini ve
    degerlendirmeyi Marketing Agent ile tamamlamasini soyler.
```

Script herhangi bir adimda hata alirsa yarim veya kalici degerlendirme klasoru birakmaz.
Teknik olmayan kullaniciya ne oldugunu ve ne yapmasi gerektigini aciklar. Gerekli release,
sablon, erisim veya sistem dosyasi hatasinda tekrar tekrar denemek yerine Yonetici Burhan
Kocak ile iletisime gecilmesini soyler. Sanitize edilmis teknik kaydi kullanicinin
`.pa-script-logs/` klasorune yazar ve hata mesajinda log dosyasinin adini gosterir.

### Yeni proje olusturma

Bir fikir ancak marketer tarafindan `Denenmeye Deger` olarak degerlendirildikten ve web app
Project Pool kaydini olusturduktan sonra proje workspace'ine donusebilir. Web app degismez
`project_id` ve bagli `idea_id` degerini olusturur; ilk olumlu marketer'i proje uyesi ve
`Drive host marketer` olarak kaydeder.

Proje klasorunu yalnizca kayitli Drive host marketer kendi `projects/` klasorunde olusturur:

```text
PersonalAutonomy/marketers/ayse/projects
```

Ornek talep:

```text
Yeni marketing projesi olustur:
project_id: proje-001
idea_id: fikir-001
proje_adi: x-projesi
drive_host_marketer: ayse
```

Codex `create-project.ps1` script'ini bu dort zorunlu degerle calistirir. Codex proje
klasorlerini veya dosyalarini elle olusturmaz. Script su islemleri sirasiyla gerceklestirir:

```text
1. Komutun drive_host_marketer degerine ait projects klasorunde calistirildigini kontrol eder.
2. project_id ve idea_id degerlerinin bos olmadigini ve beklenen guvenli kimlik bicimine
   uydugunu dogrular.
3. Erisilebilen gecerli proje state.json dosyalarinda ayni project_id degerini arar. Bulursa
   ikinci klasor olusturmaz, mevcut proje yolunu gosterir ve islemi basarili tekrar olarak
   sonlandirir.
4. Proje adini bosluk, gecersiz karakter ve guvenli klasor adi kurallarina gore kontrol eder.
   Gerekirse guvenli bir ad onerir ve kullanici onayi ister.
5. Hedef projects klasorunde ayni klasor adi varsa hicbir dosyaya dokunmaz ve kullanicidan yeni
   bir proje adi ister.
6. Guncel marketing-agent release klasorunu ve zorunlu proje sablonlarini dogrular.
7. Release veya sablon eksikse kalici dosya birakmadan durur ve kullaniciyi Yonetici Burhan
   Kocak ile iletisime gecmeye yonlendirir.
8. Tum on kontroller basariliysa kullanicinin .pa-create-work/ alaninda benzersiz adli gecici
   proje klasoru olusturur.
9. Bolum 4'te tanimlanan proje klasor ve dosyalarinin tamamini ayni hiyerarsiyle gecici
   klasorde olusturur.
10. Kok AGENTS.md dosyasini bootstrap sablonundan; PROJE.md, DURUM.md, KARARLAR.md ve README.md
    dosyalarini onayli proje sablonlarindan uretir.
11. PROJE.md ve .pa/project/state.json icine project_id, idea_id ve ilk
    drive_host_marketer degerini yazar. Yalnizca project_id ve idea_id alanlarini degismez
    olarak isaretler; mevcut host bilgisi web app'teki ana kaydin yerel snapshot'idir.
12. 00-gelen-kutusu ve 01-baglam altinda Bolum 4'te adlandirilan tum baslangic dosyalarini
    onayli sablonlardan olusturur.
13. Bos calisma/cikti klasorlerine sabit .gitkeep dosyasi koyarak Drive'da klasor yapisinin
    eksiksiz korunmasini saglar.
14. Europe/Istanbul saat dilimindeki guncel tarihe gore ISO yil ve hafta numarasini hesaplar ve
    05-haftalik-planlar/YYYY-WNN.md dosyasini bos haftalik plan sablonundan olusturur.
15. Ayni hafta icin 05-haftalik-planlar/YYYY-WNN/ altinda schedule.md ve gunluk dosyalari
    olusturur; gunluk dosyalar baslangicta bos tutulur.
16. Haftalik plan sablonunu Pazartesi-Pazar basliklari, gorev, kanal, oncelik, beklenen cikti,
    cikti konumu, durum, tamamlanma kaniti ve Google Calendar alanlariyla olusturur; kullanici
    adina baslangic gorevi yazmaz.
17. Guncel marketing-agent paketini tum alt klasorleri ve dosyalariyla .pa/agent altina
    kopyalar ve dogrulanmis agent-version.json dosyasini yazar.
18. .pa/project altinda overrides.md, overrides-approved.md, state.json, active-task.md ve
    settings.json dosyalarini gecerli sablonlarla olusturur. Iki override dosyasi baslangicta
    aynidir; state.json onayli icerigin SHA-256 degerini tasir.
19. DURUM.md ve state.json icine aktif haftalik plan yolunu kaydeder. Baslangic durumunu
    "Proje baglami tamamlaniyor" yapar ve hicbir gorevi tamamlanmis saymaz.
20. DURUM.md ve README.md icinde kullaniciyi once PROJE.md ve 01-baglam dosyalarini
    tamamlamaya, Drive aktivasyon checklist'inden sonra guncel haftanin kalan gunleri icin
    plani agent ile doldurmaya yonlendirir.
20. Gecici projeyi zorunlu klasor/dosya listesi, kimlik alanlari, agent manifesti ve JSON
    gecerliligiyle dogrular. Hata varsa gecici klasoru temizler.
21. Dogrulama basariliysa gecici klasoru tek yeniden adlandirma islemiyle kalici proje adina
    cevirir. Drive kilidi varsa iki saniye arayla toplam uc kez dener; basarisizlikta kalici
    klasor birakmaz.
22. Basari mesajinda project_id, proje adi ve yolu gosterir; kullaniciyi web app'te script
    basarisini onaylamaya, Drive senkronizasyonunu tamamlamaya ve canonical klasor linkini
    eklemeye yonlendirir.
```

Ayni `project_id` icin veritabani benzersizlik kurali ana korumadir. Script'in erisilebilir
workspace taramasi ve klasor adi kontrolu ikinci savunma katmanidir. Web app yalnizca kayitli
Drive host marketer'in aktivasyon checklist'ini tamamlamasina izin verir; baska bir
kullanicinin olusturdugu kopya canonical proje klasoru olarak kabul edilmez.

Fikir basligi veya proje gorunen adi daha sonra degisse bile mevcut workspace klasoru otomatik
yeniden adlandirilmaz. Degerlendirme ve proje baglantisinin anahtari klasor adi degil,
degismez `idea_id` ve `project_id` degerleridir. MVP'de yayinlanmis workspace klasoru yeniden
adlandirilmak istenirse bu, Drive host ve sistem sahibi tarafindan planli manuel islem olarak
yapilir; Codex root yolu ve web app Drive linki islemden sonra yeniden dogrulanir.

Script herhangi bir adimda hata alirsa kalici proje klasoru olusturmaz, gecici klasoru temizler
ve teknik olmayan kullaniciya acik hata mesaji gosterir. Isim cakismasinda yeni isim ister.
Giderilemeyen release, sablon, sistem veya erisim hatasinda Yonetici Burhan Kocak ile
iletisime gecilmesini soyler. Sanitize edilmis teknik kaydi kullanicinin `.pa-script-logs/`
klasorune yazar ve hata mesajinda log dosyasinin adini gosterir.

Script'in basari olcutu yalnizca klasorun var olmasi degildir. Bolum 4'te tanimlanan butun
klasor/dosyalar, degismez kimlikler, agent paketi, proje durum dosyalari ve guncel ISO haftalik
plan sablonu dogrulanmadan proje basariyla olusturulmus sayilmaz.

Olusan proje:

```text
projects/
  x-projesi/
    AGENTS.md
    PROJE.md
    DURUM.md
    KARARLAR.md
    README.md
    00-gelen-kutusu/
    01-baglam/
    02-arastirma/
    03-strateji/
    04-urun/
    05-haftalik-planlar/
    06-pazarlama-uygulamalari/
    07-lansman/
    08-raporlar/
    09-varliklar/
    10-final/
    99-arsiv/
    .pa/
      agent/
      project/
```

Marketer aktivasyon checklist'ini tamamladiktan sonra yeni proje klasorunu Codex root olarak
acar ve ayri proje thread'i baslatir. Proje hafta ortasinda aktif olduysa bos haftalik sablon,
agent ve kullanici tarafindan yalnizca kalan gunler icin hemen doldurulur. Sonraki planlar her
Pazartesi hazirlanir.

---

## 7. Marketing Agent Dagitim Modeli

Marketing Agent'in resmi kaynagi GitHub reposudur. Drive bu asamada agent release kaynagi veya
toplu guncelleme mekanizmasi olarak kullanilmaz. Her degerlendirme veya proje workspace'i,
GitHub'daki dogrulanmis release'ten kendi bagimsiz `.pa/agent/` kopyasini alir:

```text
idea-workspace/fikir-001-ornek-fikir/.pa/agent/
projects/x-projesi/.pa/agent/
```

Her iki kopya da su ortak yapiyi tasir:

```text
.pa/
  agent/
    AGENTS.md
    ARCHITECTURE.md
    SKILLS.md
    skills/
    agents/
    pipelines/
    scripts/
    templates/
    mcps.json
    release-manifest.json
    agent-version.json

  agent-install.json
```

Bu modelin sonucu:

- Her degerlendirme ve proje workspace'i kendi agent kopyasina sahiptir.
- Codex aktif workspace icinden agent dosyalarina yerel olarak ulasir.
- Bir workspace'in agent durumu baska workspace'i dogrudan etkilemez.
- Proje davranis tercihleri surumlenen agent paketinden ayri `.pa/project/` alaninda kalir.
- Degerlendirme durumu surumlenen agent paketinden ayri `.pa/evaluation/` alaninda kalir.
- Hangi agent surumunun hangi workspace'te kullanildigi izlenebilir.
- `.pa/agent-install.json`, bu workspace'in agent'i hangi GitHub repo ve surum politikasindan
  kurdugunu kaydeder.
- Agent guncellemesi proje-localdir; bu etapta Drive kokunden toplu tarama veya toplu update
  yapilmaz.

---

## 8. Agent Guncelleme Akisi

Sistem sahibi Marketing Agent uzerinde degisiklik yaptiginda GitHub uzerinde yeni bir release
veya semver tag'i olusturur:

```text
v5.1.0
```

Release paketi `marketing-agent/release-manifest.json` dosyasini tasir. Manifest release
surumunu, zorunlu payload dosya listesini ve her payload dosyasinin SHA-256 hash degerini icerir.
Manifest guncel degilse kurulum veya guncelleme basarili sayilmaz.

Ilk kurulum resmi installer ile yapilir:

```powershell
.\scripts\install-marketing-agent.ps1 -TargetRoot "<workspace>" -RepoUrl "<GITHUB_REPO_URL>" -Version latest
```

Kurulum sonunda workspace kokunde su metadata dosyasi olusur:

```text
.pa/agent-install.json
```

Ornek:

```json
{
  "schema_version": "1.0",
  "repo_url": "https://github.com/.../PersonalAutonomy-MVP",
  "channel": "stable",
  "requested_version": "latest",
  "installed_version": "v5.1.0",
  "update_policy": "ask",
  "installed_at": "2026-06-18T12:00:00+03:00",
  "installer": "scripts/install-marketing-agent.ps1"
}
```

### Oturum basinda update kontrolu

Kok `AGENTS.md` sabit bootstrap olarak kalir ve aktif `.pa/agent/AGENTS.md` dosyasina
yonlendirir. Her yeni oturumda veya proje calismasina baslamadan once Codex su akisi uygular:

```text
1. .pa/agent-install.json dosyasini oku.
2. .pa/agent/scripts/check-update.ps1 ile guncelleme kontrolu yap.
3. Yeni surum yoksa mevcut .pa/agent/AGENTS.md ile devam et.
4. Yeni surum varsa kullaniciya acikca bildir.
5. Kullanici onay vermeden guncelleme yapma.
6. Onay verilirse .pa/agent/scripts/update-agent.ps1 -Yes calistir.
7. Guncelleme basariliysa .pa/agent/AGENTS.md dosyasini yeniden oku.
```

`check-update.ps1` salt okunur calisir; proje dosyalarini, `.pa/project/` veya
`.pa/evaluation/` alanlarini degistirmez.

### Surum karari

Her workspace kendi `.pa/agent/agent-version.json` dosyasindaki mevcut surumu okur:

- Surumler `vMAJOR.MINOR.PATCH` biciminde karsilastirilir.
- Mevcut surum hedefle ayniysa guncelleme yapilmaz.
- Mevcut surum hedeften yeniyse `-AllowDowngrade` olmadan degistirilmez.
- Mevcut surum hedeften eskiyse kullanici onayi ile normal guncelleme yapilir.
- Surum bilgisi okunamiyorsa workspace degistirilmez ve sorun aciklanir.

### Workspace bazli atomik guncelleme

`update-agent.ps1` yalnizca aktif workspace'i gunceller:

```text
1. Kullanici onayi olmadan calismaz; script -Yes ister.
2. GitHub veya verilen SourceAgentRoot kaynagindan hedef agent paketini hazirlar.
3. Kaynak release-manifest.json dosyasini ve hash degerlerini dogrular.
4. Yeni paketi .pa/ altinda staging klasorune kopyalar ve tekrar dogrular.
5. Mevcut .pa/agent klasorunu backup konumuna tasir.
6. Staging paketini .pa/agent konumuna tasir.
7. Yeni .pa/agent paketini son kez manifest ile dogrular.
8. Basarida backup ve staging alanlarini temizler.
9. Hatada staging'i kaldirir, backup'i .pa/agent olarak geri yukler ve eski agent'i dogrular.
```

Guncelleme yalnizca `.pa/agent/` klasorunu degistirir. Degerlendirme workspace'inde
`DEGERLENDIRME.md`, `DURUM.md`, `RAPOR.md`, `kaynaklar/`, `ciktilar/` ve
`.pa/evaluation/` korunur. Proje workspace'inde asagidaki veriler korunur:

```text
PROJE.md
DURUM.md
KARARLAR.md
README.md
00-gelen-kutusu/
01-baglam/
02-arastirma/
03-strateji/
04-urun/
05-haftalik-planlar/
06-pazarlama-uygulamalari/
07-lansman/
08-raporlar/
09-varliklar/
10-final/
99-arsiv/
.pa/project/
```

Ornek `agent-version.json`:

```json
{
  "version": "v5.1.0",
  "runtime": "codex",
  "mvp_contract": "PersonalAutonomy MVP 2026-06-15",
  "release_status": "source"
}
```

---

## 9. Proje Bazli Ozellestirme

Her projenin kendi agent kopyasi vardir; ancak proje ozel tercihleri surumlenen agent
dosyalarina yazilmaz. Proje davranisi icin zorunlu dosya sudur:

```text
.pa/project/overrides.md
```

Bu dosya yalnizca davranis ve cikti tercihlerini tutar:

```markdown
# Project Overrides

## Aktif Tercihler

- Marka dili resmi, acik ve profesyonel olacak.
- Raporlar en fazla iki sayfa ve karar odakli olacak.
- PRD ciktilari coder'a dogrudan teslim edilebilir formatta olacak.
- Saha toplantisi dokumanlarinda teknik terimler kisa aciklamalarla verilecek.
```

Rakipler, hedef segmentler, fiyat, urun ozellikleri ve satis dongusu gibi proje gercekleri
`overrides.md` icine yazilmaz. Bunlar `PROJE.md` veya `01-baglam/` altindaki ilgili dosyalarda
tutulur. Boylece ayni bilgi iki yerde farkli bicimde eskimez.

Degerlendirme workspace'lerinde proje override sistemi kullanilmaz. Degerlendirme davranisi
onayli `DEGERLENDIRME.md` sablonu, aktif agent talimatlari ve `.pa/evaluation/settings.json`
ile sinirlidir. Bu teknik ayarlar `idea_id`, degerlendirme sonucu yetkisi, web app'teki yayin
gorunurlugu, rol kurallari veya agent update guvenligini degistiremez.

### Dosya sahipligi

Proje dosyalari iki gruba ayrilir:

```text
Kullanici tarafindan okunabilir ve duzenlenebilir:
  PROJE.md
  KARARLAR.md
  01-baglam/
  .pa/project/overrides.md

Agent/script tarafindan yonetilir; kullanici elle duzenlemez:
  DURUM.md
  .pa/project/overrides-approved.md
  .pa/project/state.json
  .pa/project/active-task.md
  .pa/project/settings.json
```

Kullanici, agent tarafindan yonetilen bir bilgiyi degistirmek istediginde dosyayi elle
duzenlemek yerine Codex'e talimat verir. Agent onerilen degisikligi ve etkisini aciklar,
kullanici onayi aldiktan sonra ilgili dosyayi gunceller.

`PROJE.md` kullanici tarafindan duzenlenebilir olsa da `project_id` ve `idea_id` baslik
alanlari duzenlenebilir proje icerigi degildir. Agent her proje baslangicinda bu alanlari
`.pa/project/state.json` ile karsilastirir. Degerler farkliysa normal calismayi durdurur,
kimliklerden birini sessizce kabul etmez ve Yonetici Burhan Kocak'a yonlendirir. Ayni koruma
degerlendirme workspace'inde `DEGERLENDIRME.md` ile `.pa/evaluation/state.json` icindeki
`idea_id` icin uygulanir.

### Talimat onceligi

Iki kaynak birbiriyle celisirse agent su onceligi uygular:

```text
1. Platform guvenligi, erisim izinleri ve degistirilemez sistem sinirlari
2. Kullanicinin mevcut konusmada verdigi en son acik talimat
3. Kok AGENTS.md proje izolasyonu ve bootstrap kurallari
4. .pa/agent/AGENTS.md zorunlu agent is akisi ve guvenlik kurallari
5. PROJE.md, 01-baglam/ ve KARARLAR.md icindeki onaylanmis proje gercekleri/kararlari
6. .pa/project/overrides.md icindeki proje davranis tercihleri
7. .pa/project/settings.json icindeki teknik tercihler
8. DURUM.md, active-task.md ve state.json icindeki operasyonel durum
```

Guncel kullanici talebi proje tercihlerinden ustundur; ancak guvenlik, erisim, proje
izolasyonu veya zorunlu kullanici onayi kurallarini gecersiz kilamaz. Agent celiskiyi sessizce
cozmek yerine kullaniciya hangi iki kaynagin celistigini soyler. Proje gercegini degistiren
bir talep onaylandiginda ilgili kaynak dosya ve `KARARLAR.md` birlikte guncellenir.

### Calisma baslangicinda okuma sirasi

Agent yeni bir thread veya gorev baslatirken asagidaki sirayi izler:

```text
1. Kok AGENTS.md
2. .pa/agent/AGENTS.md
3. PROJE.md
4. 01-baglam/ altindaki ilgili dosyalar
5. KARARLAR.md
6. .pa/project/overrides.md
7. .pa/project/settings.json
8. DURUM.md
9. .pa/project/active-task.md
10. .pa/project/state.json (`overrides_sha256` her baslangicta; diger durum alanlari devam
    veya dogrulama gerektiginde)
```

Agent her iste tum buyuk dosyalari yeniden okumak zorunda degildir. Kok talimatlar, proje
kimligi ve `overrides_sha256` her calismada okunur; baglam, karar ve operasyon dosyalari
gorevle ilgili oldugu olcude okunur. `state.json` insan tarafindan yazilmis talimat kaynagi
degildir ve Markdown dosyalarindaki onaylanmis proje kararlarini gecersiz kilamaz.

### Tercih degistirme akisi

Kullanici proje davranisinda degisiklik istediginde su akis uygulanir:

```text
1. Agent istenen tercihi ve hangi ciktilari etkileyecegini ozetler.
2. Tercihin proje gercegi mi, davranis tercihi mi, teknik ayar mi oldugunu belirler.
3. Dogru hedef dosyayi secer: PROJE.md/01-baglam, overrides.md veya settings.json.
4. Yapilacak dosya degisikligini kullaniciya aciklar ve acik onay ister.
5. Kullanici onaylamadan hicbir tercih dosyasini degistirmez.
6. Onaydan sonra dosyayi gunceller.
7. Degisikligi tarih, tercih, gerekce ve onaylayan kullanici bilgisiyle KARARLAR.md dosyasina
   kaydeder.
8. overrides.md degistiyse ayni icerigi overrides-approved.md dosyasina yazar ve yeni SHA-256
   degerini state.json icindeki overrides_sha256 alanina kaydeder.
```

Kullanici `overrides.md` dosyasini elle duzenleyebilir. Agent calisma baslangicinda dosyanin
SHA-256 degerini `state.json` icindeki `overrides_sha256` ile karsilastirir. Deger farkliysa:

```text
1. Agent degisen maddeleri kullaniciya ozetler.
2. Yeni tercihleri henuz aktif kabul etmez ve eski dosyayi sessizce geri yazmaz.
3. Kullanicidan degisiklikleri onaylamasini, duzeltmesini veya geri almasini ister.
4. Onay verilirse KARARLAR.md kaydini ve overrides_sha256 degerini gunceller.
5. Onay verilmezse kullanicinin sectigi sonuca gore dosyayi duzeltir veya
   overrides-approved.md kopyasindan onceki onayli tercihlere geri dondurur.
```

### Gecersiz override kurallari

`overrides.md` su kurallari degistiremez veya devre disi birakamaz:

- platform guvenligi ve erisim izinleri
- proje klasoru disina cikmama ve kullanici izolasyonu
- web app tarafindan uretilen `project_id` ve `idea_id` kimlikleri
- davet, rol, proje uyeligi ve Drive host kurallari
- haftalik gorevleri tamamlamak icin gereken acik kullanici onayi
- agent release dogrulama, update, backup ve rollback kurallari
- kullanici verisini koruma ve gizli bilgileri loglamama kurallari
- dosya sahipligi ve degisiklik onayi akisi

Agent gecersiz bir override tespit ederse uygulamaz, nedenini teknik olmayan bir dille
aciklar ve guvenli bir alternatif onerir. Bu model merkezi agent guncellense bile proje ozel
tercihleri korurken sistemin temel guvenlik ve tutarlilik kurallarinin bozulmasini engeller.

---

## 10. Web App'in MVP'deki Rolu

Web app MVP'nin merkezi koordinasyon ve workflow katmanidir. Google Drive'in yerine gecmez ve
gercek degerlendirme/proje dosyalarini depolamaz. PRD, arastirma, rapor, landing page
kaynaklari, icerik, haftalik plan ve varliklar Google Drive'da kalir.

Web app su verileri kendi veritabaninda tutar:

```text
- davetler, kullanicilar ve roller
- fikirler, idea_id degerleri ve fikir surumleri
- marketer/yonetici degerlendirmeleri ve karar gecmisi
- Project Pool kayitlari, project_id degerleri ve proje durumlari
- marketer/coder proje uyelikleri
- Drive host sorumlulugu ve uye bazli Drive erisim durumu
- Project Pool alanlari ve alan bazli degisiklik gecmisi
- Drive ve cikti baglantilari
- aktivasyon checklist onaylari
- uygulama ici bildirimler ve Web Push abonelikleri
- aktivite, arsiv ve kritik yonetim kayitlari
```

Web app mobil oncelikli, ana ekrana eklenebilir bir PWA olarak sunulur. Davetli kullanicilar
tum gorunur workflow'u web app'ten izler; gercek calismayi yetkili olduklari yerel/Drive
workspace'inde Codex ile yurutur.

### Davet, kullanici ve roller

Acik kayit yoktur. Yalnizca Yonetici Burhan Kocak tarafindan davet edilen tam e-posta adresi
kayit olabilir. Davet, kullanicinin secebilecegi rol veya rolleri sinirlar:

```text
Marketer
Coder
Marketer + Coder
```

Kullanici ilk giriste yalnizca davette izin verilen seceneklerden birini secer. Daha sonraki
rol ekleme veya kaldirma islemini yalnizca yonetici yapabilir. Aktif `Denenmeye Deger`
degerlendirmesi bulunan marketer'in Marketer rolu, once degerlendirmeleri uygun bicimde
guncellenmeden kaldirilamaz. Drive host sorumlulugu bulunan kullanicinin Marketer rolu ise
host devri tamamlanmadan kaldirilamaz.

Davet e-postasi karsilastirmadan once bosluklardan arindirilir ve buyuk/kucuk harf farkindan
bagimsiz normalize edilir. Hesap, kimlik dogrulama saglayicisi e-posta adresini dogrulamadan ve
dogrulanan adres aktif davetle birebir eslesmeden etkinlestirilmez. Davet baska bir e-posta
adresine devredilemez. MVP'de bu dogrulanmis adres ayni zamanda kullanicinin Google Drive
paylasim hesabidir; web app ayri bir Drive e-posta kimligi tutmaz.

Yonetici rolu yalnizca Burhan Kocak hesabinda sabittir; kayit sirasinda secilemez,
devredilemez veya baska hesaba atanamaz. Yetki gorunen adla degil, sunucu tarafinda
yapilandirilmis degistirilemez kullanici kimligiyle kontrol edilir.

Yalnizca Marketer rolundeki kullanici icin kisisel Google Drive calisma alani olusturulur.
Yalnizca Coder rolundeki kullanici kisisel Drive workspace'i almaz; katildigi projelere
manuel Drive paylasimiyla erisir.

Tum aktif kullanicilar sunlari gorebilir:

- Idea Pool fikirleri ve fikir surumleri
- tum degerlendirme sonuclari, aciklamalari ve eklenmisse rapor linkleri
- Project Pool projeleri, ekipleri, durumlari ve baglantilari
- herkesce gorulebilen aktivite akisi

Yetki kurallari:

```text
Fikir ekleme:
  Tum aktif kullanicilar

Fikir degerlendirme:
  Marketer rolundeki kullanicilar + Yonetici Burhan Kocak

Project Pool alanlarini normal duzenleme:
  Projenin aktif marketer'lari + projenin coder'lari + yonetici

Fikri arsivleme:
  Fikri ekleyen kullanici + yonetici

Projeyi arsivleme:
  Proje ekibi + yonetici

Rol degistirme ve kalici silme:
  Yalnizca yonetici
```

Fikri ekleyen kisi proje ekibinde degilse Project Pool kaydini gorur ancak duzenleyemez.

Kalici silme normal kullanim akisi degildir. Varsayilan kaldirma yontemi geri alinabilir
arsivlemedir. Bagli Project Pool kaydi bulunan fikir veya aktif uyelik, Drive linki ya da
workflow gecmisi bulunan proje tek basina kalici silinemez; yoneticiye arsivleme onerilir.
Yalnizca yanlis/test amacli ve bagimliligi olmayan web app kaydi acik ikinci onayla silinebilir.
Kalici silme Google Drive dosyalarini silmez ve yonetim kaydina yazilir.

### Idea Pool ve fikir surumleri

Her aktif kullanici Idea Pool'a en az baslik ve aciklamayla fikir ekleyebilir. Web app fikir
icin degismez `idea_id` uretir. Yeni fikir `Havuzda` durumunda baslar ve tum aktif
kullanicilara bildirilir.

Fikir sahibi, fikir Project Pool'a gecmeden once mevcut icerigi duzenleyebilir. Project Pool
kaydi olustuktan sonraki degisiklik mevcut metni ezmez; yeni fikir surumu olusturur. Her
degerlendirme hangi fikir surumune gore verildigini saklar. Yeni fikir surumu mevcut projenin
aktif kaynak surumunu otomatik degistirmez; proje ekibi inceledikten sonra bu alani yetkili
bir degisiklikle guncelleyebilir.

Fikir Project Pool'a gectikten sonra Idea Pool'dan silinmez. `Projeye Donustu` etiketi ve
bagli proje linkiyle kalir. Arsivleme geri alinabilir; kalici silme yalnizca yoneticiye
aittir. Fikrin arsivlenmesi bagli projeyi otomatik arsivlemez.

Fikir durumlari:

```text
Havuzda
Projeye Donustu
Arsivlendi
```

### Degerlendirmeler ve Project Pool'a gecis

Marketer veya yonetici bir fikir surumunu iki sonuctan biriyle degerlendirebilir:

```text
Denenmeye Deger
Olumsuz
```

Sonucun secilmesi gecerli degerlendirme icin yeterlidir. Kisa aciklama ve Drive raporu istege
baglidir. Bir fikir birden fazla kisi tarafindan degerlendirilebilir. Tum degerlendirmeler
bagimsiz gorus kaydidir; hicbiri otomatik ana rapor sayilmaz ve onceki kararlar silinmez.

Marketer sonucu yayinlamadan once kendi `idea-workspace/` alaninda ilgili `idea_id` icin
`create-evaluation.ps1` script'inin basariyla tamamlandigini onaylar. Web app yerel klasoru
teknik olarak okuyamaz; bu onay, proje aktivasyon checklist'inde oldugu gibi kullanici
beyanina dayali workflow kanitidir. Yonetici gorus kaydi icin marketer workspace'i gerekmez.

Yonetici degerlendirmesi yalnizca gorus kaydidir. Yonetici `Denenmeye Deger` sonucunu secse
bile Project Pool kaydi, proje uyeligi veya proje klasoru olusmaz. Project Pool'a gecisi
yalnizca Marketer rolundeki kullanicinin `Denenmeye Deger` karari baslatabilir.

Ilk olumlu marketer degerlendirmesi tek transaction icinde su sonuclari uretir:

```text
1. Ayni idea_id icin Project Pool kaydi yoksa degismez project_id ile tek proje olusturulur.
2. Fikir Projeye Donustu durumuna gecirilir.
3. Degerlendirmeyi yapan marketer projeye esit yetkili marketer olarak eklenir.
4. Bu marketer Drive host marketer olarak kaydedilir.
5. Proje Drive Kurulumu Bekliyor durumunda baslar.
6. Degerlendirme, proje, uyelik ve host atamasi aktivite gecmisine yazilir.
7. Tum aktif kullanicilara bildirim gonderilir.
```

Ayni `idea_id` icin proje zaten varsa ikinci Project Pool kaydi veya proje klasoru
olusturulmaz. Yeni olumlu marketer mevcut projeye esit yetkili marketer olarak eklenir.
Proje `Yeniden Degerlendiriliyor` durumundaysa onceki gecerli durum saklanmis Drive kurulum
bilgisine gore geri yuklenir; kurulum artik gecerli degilse proje `Drive Kurulumu Bekliyor`
durumuna doner.

`Olumsuz` sonucu yalnizca degerlendiren kisinin gorusudur. Fikri kaldirmaz, baska
degerlendirmeleri engellemez ve diger olumlu kayitlari gecersiz kilmaz.

Marketer kendi sonucunu sonradan degistirebilir. `Denenmeye Deger` sonucu `Olumsuz`
yapildiginda marketer normal proje uyeliginden otomatik cikarilir; urettigi dosyalar,
degerlendirme surumleri ve aktivite gecmisi korunur. Kullanici Drive host ise host sorumlulugu
otomatik kalkmaz ve acik devir tamamlanana kadar devam eder.

### Project Pool, uyelik ve proje durumlari

Bir projede birden fazla marketer ve coder esit normal duzenleme yetkili proje uyesi olabilir.
Coder `Drive Kurulumu Bekliyor` dahil, `Yeniden Degerlendiriliyor` veya `Arsivlendi` olmayan
bir projeye Project Pool uzerinden katilabilir ve ayrilabilir. Klasor henuz hazir degilse
`Drive Erisimi Bekliyor` durumunda kalir. Katilim/ayrilma gecmise yazilir; onceki calismalar
silinmez. Coding asamasina gecis yine aktivasyon checklist'inin tamamlanmasini gerektirir.

Web app uyeligi Drive erisimi vermez. Yeni uye `Drive Erisimi Bekliyor` etiketiyle eklenir.
Drive host marketer veya sistem sahibi proje klasorunu uye ile paylasir; uye kendi Google
hesabiyla erisimi onayladiginda etiket `Drive Erisimi Var` olur. Bu etiket proje durumundan
ayri tutulur.

Proje durumlari:

```text
Drive Kurulumu Bekliyor
Aktif
Yeniden Degerlendiriliyor
Coding Asamasinda
Lansman Hazirliginda
Yayinda
Duraklatildi
Arsivlendi
```

Temel gecis kurallari:

- Ilk olumlu marketer degerlendirmesi: `Drive Kurulumu Bekliyor`
- Aktivasyon checklist'inin tamamlanmasi: `Drive Kurulumu Bekliyor -> Aktif`
- Coder katilimi yalnizca uyelik olusturur; proje durumunu otomatik degistirmez.
- `Coding Asamasinda` gecisi aktivasyondan sonra yetkili proje uyesinin acik islemiyle yapilir.
- `Aktif -> Lansman Hazirliginda` veya `Aktif -> Coding Asamasinda` gecislerinden uygun olani
  proje ekibi acikca secer; coding zorunlu bir ara durum degildir.
- `Coding Asamasinda -> Lansman Hazirliginda` ve `Lansman Hazirliginda -> Yayinda` gecisleri
  yetkili proje uyesinin acik islemiyle yapilir.
- `Aktif`, `Coding Asamasinda`, `Lansman Hazirliginda` veya `Yayinda` durumundaki proje
  onceki durumu saklanarak `Duraklatildi` yapilabilir; devam ettirildiginde o duruma doner.
- Son olumlu marketer'in sonucunu degistirmesi: onceki gecerli durum saklanarak
  `Yeniden Degerlendiriliyor`
- Yeni olumlu marketer: Drive kurulumu gecerliyse onceki gecerli duruma, degilse
  `Drive Kurulumu Bekliyor` durumuna donus
- Arsivleme: onceki durum saklanarak `Arsivlendi`
- Arsivden cikarma: kurallar izin veriyorsa onceki gecerli duruma donus

Projede olumlu marketer kalmadiginda proje silinmez. `Yeniden Degerlendiriliyor` durumunda:

- Project Pool normal alanlari salt okunur olur.
- Yeni coder katilimi ve ileri proje durum gecisleri engellenir.
- Mevcut dosyalar, baglantilar, ekip ve aktivite gecmisi tum aktif kullanicilara gorunur kalir.
- Yalnizca yeni marketer degerlendirmesi, gerekli host/Drive erisim islemleri, yonetici
  islemleri ve arsivleme gibi kurtarma islemleri yapilabilir.
- Google Drive klasoru, hostu ve mevcut izinleri otomatik degistirilmez.
- Web app Drive klasorunun salt okunur oldugunu iddia etmez; dondurma yalnizca web app
  workflow'una aittir.

`Arsivlendi` durumu otomatik degerlendirme ve proje gecislerinden once gelir. Arsivlenmis
fikir veya projede normal duzenleme, yeni uyelik veya proje uyeligini etkileyecek
degerlendirme sonucu degisikligi yapilamaz; once arsivden cikarilmasi gerekir. Arsivden
cikarilan projede olumlu marketer yoksa proje onceki calisma durumuna degil,
`Yeniden Degerlendiriliyor` durumuna doner.

### Project Pool alanlari

```text
project_id
Bagli idea_id ve aktif fikir surumu
Proje adi
Kisa aciklama
Marketer'lar
Coder'lar
Proje durumu
Oncelik
Sonraki adim
Aktif haftalik ilerleme ozeti
Notlar
Drive klasor linki
Drive host marketer
Uye bazli Drive erisim durumu
Drive aktivasyon checklist'i
PRD linki
Analiz linkleri
Landing page kaynak/brief Drive linkleri
Yayindaki landing page URL'si
Rapor linkleri
Olusturulma ve son guncellenme zamani
```

`project_id` ve `idea_id` normal kullanici tarafindan degistirilemez. Haftalik gorevlerin ana
kaynagi Drive'daki `05-haftalik-planlar/YYYY-WNN.md` dosyasidir. Web app haftalik planin
kopyasini tutmaz; yalnizca aktif ilerleme ozetini ve Drive baglantisini gosterir.

Normal durumda Project Pool alanlarini yalnizca proje ekibi ve yonetici duzenleyebilir. Alan
bazinda son kayit kazanir; bir alandaki degisiklik baska alandaki eszamanli degisikligi ezmez.
Her degisiklik eski deger, yeni deger, kullanici ve zamanla gecmise yazilir. Yetkili geri
yukleme de yeni bir gecmis kaydi olusturur.

### PWA bildirimleri ve aktivite akisi

Kullanici PWA'yi telefonunun ana ekranina ekler ve acik bir islemle Web Push izni verir.
Service worker ve Web Push ile web app kapaliyken telefonun sistem bildirim alanina bildirim
gonderilebilir. E-posta bildirimi MVP kapsaminda degildir.

Buradaki e-posta siniri workflow bildirimleri icindir. Kimlik dogrulama saglayicisinin hesap
adresini dogrulamak icin zorunlu olarak gonderdigi tek kullanimlik dogrulama mesaji, proje veya
aktivite e-posta bildirimi sayilmaz.

Tum aktif kullanicilara, islemi yapan kullanici dahil, push ve uygulama ici bildirim gonderilen
olaylar:

- yeni fikir veya yeni fikir surumu
- yeni degerlendirme veya degerlendirme sonucu degisikligi
- fikrin Project Pool'a gecmesi
- proje durumunun degismesi veya dondurulmasi
- marketer veya coder'in projeye katilmasi/ayrilmasi
- Drive host atamasi veya devri
- Drive klasor linkinin eklenmesi
- fikir veya projenin arsivlenmesi/geri alinmasi
- kullanicidan onay veya islem beklenmesi

Bildirime dokunuldugunda ilgili fikir, degerlendirme veya proje acilir. Okundu/okunmadi durumu
kullanici bazinda tutulur. Ayni olay icin yinelenen bildirimler idempotency anahtariyla
engellenir. Push izni vermeyen veya desteklenmeyen cihaz kullanan kisi ayni olayi uygulama ici
bildirim merkezinde gorur.

Push payload'i olay kimligi, olay turu, kisa bildirim metni ve uygulama ici hedefi tasir;
Drive URL'si, rapor icerigi, gizli proje verisi veya erisim bilgisi tasimaz. Gecersiz ya da
suresi dolmus push abonelikleri teslim hatasi sonrasinda devre disi birakilir; kullanici tekrar
izin verdiginde yeni abonelik kaydedilir.

Her onemli olay `kim-ne yapti-ne zaman` bilgisiyle tum aktif kullanicilarin gorebildigi
aktivite akisina yazilir. Rol degisikligi, kalici silme ve kritik yonetici islemleri ayrica
yonetim kaydina yazilir.

### Veri tutarliligi ve hata yonetimi

- `idea_id` ve `project_id` benzersiz, degismez veritabani kimlikleridir.
- Ayni `idea_id` icin tek Project Pool kaydi benzersizlik kuraliyla garanti edilir.
- Olumlu marketer degerlendirmesi, proje olusturma, marketer uyeligi, Drive host atamasi ve
  durum gecisi tek transaction icinde tamamlanir.
- Yonetici degerlendirmesi bu proje olusturma transaction'ini tetiklemez.
- Tekrar edilen ayni istek idempotency anahtariyla ikinci degerlendirme olayi, proje, uyelik
  veya bildirim olusturmaz.
- Yetki her sunucu isteginde kontrol edilir; yalnizca arayuz gizlemesine guvenilmez.
- Hata halinde yarim proje, yarim uyelik veya gecersiz durum birakilmaz.
- Push teslim hatasi ana islemi geri almaz; bildirim yeniden deneme kuyruguna girer.
- Drive linki gecersizse proje verisi kaybolmaz; link kaydedilmez ve duzeltme istenir.
- Web app ile Drive durumu celisirse sistem sessizce duzeltmez; ilgili kullanicilara uyari
  gosterir.

---

## 11. Drive Link Modeli (MVP)

Web app dosya yuklemez, Drive dosyalarini okumaz ve Google Drive izinlerini otomatik
degistirmez. Gercek degerlendirme ve proje dosyalari Google Drive'da kalir. Web app yalnizca
Drive kurulum adimlarini, host sorumlulugunu, uye erisim durumlarini ve dogrulanmis link
metadatasini workflow verisi olarak tutar.

MVP'de Google Drive API veya OAuth entegrasyonu yoktur. Bu nedenle web app bir linkin belirli
bir kullanici tarafindan gercekten acilabildigini veya beklenen Viewer/Editor iznine sahip
oldugunu sunucu tarafinda dogrulayamaz. Erisim, ilgili kullanicinin acik onayiyla workflow
kaniti olarak kaydedilir.

### Guvenli link dogrulamasi

Yetkili kullanici Drive klasoru, degerlendirme raporu veya proje cikti linkini ilgili web app
alanina ekler. Web app kaydetmeden once su yapisal kontrolleri yapar:

```text
1. URL HTTPS kullanmalidir.
2. Host yalnizca izin verilen Google alan adlarindan biri olmalidir:
   drive.google.com
   docs.google.com
   sheets.google.com
   slides.google.com
3. URL kullanici adi, sifre, IP adresi, localhost veya yonlendirme URL'si iceremez.
4. Proje klasoru alani drive.google.com/drive/folders/<id> bicimindeki canonical klasor
   linkini kabul eder.
5. Drive dosya alanlari su canonical turleri kabul eder:
   drive.google.com/file/d/<id>
   docs.google.com/document/d/<id>
   docs.google.com/spreadsheets/d/<id>
   docs.google.com/presentation/d/<id>
6. PRD ve tekil rapor alanlari klasor linki kabul etmez. Koleksiyon alanlari tasarimda acikca
   klasor destekliyorsa canonical klasor linki kabul edebilir.
7. Yayindaki landing page icin ayri landing_page_live_url alani kullanilir. Bu alan HTTPS
   kullanan genel web URL'sini kabul eder.
8. Link normalize edilir ve ayni kayit/alan icindeki birebir tekrarlar engellenir.
9. Link turu, ekleyen kullanici ve zaman bilgisiyle alan gecmisine yazilir.
```

Web app link hedefini sunucu tarafinda takip etmez, indirmez veya genel URL fetch islemi
yapmaz. Bu kural SSRF ve kimlik avi riskini azaltir. Link yeni sekmede `noopener` ve
`noreferrer` guvenlikleriyle acilir.

### Proje aktivasyon checklist'i

Proje klasor linkinin eklenmesi tek basina projeyi `Aktif` yapmaz. Kayitli Drive host marketer
proje `Drive Kurulumu Bekliyor` durumundayken su kosullari tamamlar:

```text
- [ ] create-project.ps1 dogru project_id ve idea_id ile basariyla tamamlandi.
- [ ] Yerel proje klasorunun Google Drive senkronizasyonu tamamlandi.
- [ ] Gecerli canonical Google Drive proje klasoru linki Project Pool kaydina eklendi.
- [ ] Kullanici GitHub hesabinda private proje yedek reposu olusturuldu veya bu adim bilincli
      olarak ertelendi.
```

Kurallar:

- Script basarisi ve Drive senkronizasyonu Drive host marketer'in acik onayiyla isaretlenir.
- Scriptteki `project_id` web app Project Pool kaydiyla ayni olmalidir.
- Klasor linki guvenli URL ve klasor turu kontrolunden gecmelidir.
- GitHub reposu Drive'in yerine gecmez. Repo private olmali, buyuk medya/dokuman arsivleri,
  ham video, agir PDF ve gizli bilgiler GitHub'a pushlanmamalidir.
- Checklist maddeleri kullanici, zaman ve onceki degerle gecmise yazilir.
- Aktivasyon kosullari tamamlaninca proje atomik olarak `Aktif` olur ve tum aktif kullanicilara, islemi
  yapan dahil, bildirim gider.
- Bir kosul daha sonra gecersiz olursa web app sessizce durum degistirmez; proje ekibine uyari
  gosterir ve acik duzeltme ister.

Bu onaylar Drive API dogrulamasi degil, kullanici beyanina dayali MVP workflow kanitidir.

### Degerlendirme raporu yayinlama

Ham degerlendirme, kaynaklar ve rapor dosyalari marketer'in kisisel klasorunde kalir:

```text
marketers/<kullanici>/idea-workspace/<fikir-id>-<kisa-baslik>/
```

Marketer yalnizca sonuc ve istege bagli aciklama ile degerlendirme yapabilir; Drive raporu
zorunlu degildir. Rapor yayimlamak isterse:

```text
1. Son rapor dosyasini kendi degerlendirme workspace'inde hazirlar.
2. Dosyayi aktif sistem kullanicilariyla Viewer olarak manuel paylasir; Google Drive
   "Notify people" secenegini kapali tutar.
3. Kendi hesabiyla linkin dogru dosyayi actigini kontrol eder.
4. Canonical Drive dosya linkini web app'teki degerlendirmeye ekler.
5. Erisimin paylasildigini acikca onaylar.
```

Diger kullanicilar degerlendirme sonucunu web app'te her durumda okuyabilir. Drive raporunu
yalnizca Google Drive paylasim izni varsa acar. Web app Viewer iznini teknik olarak
dogrulayamaz; link erisilemiyorsa rapor silinmez, yayinlayan marketer'a duzeltme uyarisi
gosterilir. Rapor `Anyone with the link` olarak herkese acilmak zorunda degildir.

### Proje klasoru paylasim rolleri

Proje klasoru ilk olumlu marketer'in kisisel `projects/` alaninda olusturulur. Bu kisi ayni
transaction icinde `Drive host marketer` olur. Projeye katilan marketer ve coder'lar calisma
yapabilmek icin yalnizca ilgili proje klasorunde `Editor` yetkisi alir.

Editor yetkisi dosya ekleme, duzenleme, tasima ve silme gibi genis etkiler verebilir. Web app
Drive erisimi onayi sirasinda bunu teknik olmayan bir dille aciklar. Tum marketer klasoru veya
baska projeler paylasilmaz.

Proje klasorunun Google Drive sahibi veya paylasim yonetme yetkisi bulunan hesabi, mumkun
oldugunda "Editors can change permissions and share" secenegini kapali tutar. Yeni uye
paylasimini Drive'da gercek paylasim yetkisi bulunan Drive host marketer; bu yetki hostta
yoksa sistem sahibi yapar. "Notify people" kapali tutulur ve uye bildirimi PersonalAutonomy
Web Push ile yapilir. Diger proje editorlerinin yeni kisi eklemesi surec kuraliyla yasaktir;
web app Drive API olmadan bu kurali teknik olarak denetleyemez. Bu sinir Editor'un dosya
duzenleme, tasima veya silme yetkisini kaldirmaz; Drive surum gecmisi ve `99-arsiv/` yapisi
korunur.

Web app uyeligi ile Drive erisimi ayri kayitlardir:

```text
Drive Erisimi Bekliyor
Drive Erisimi Var
Drive Erisimi Kaldirma Bekliyor
Drive Erisimi Kaldirildi
```

Yeni proje uyesi `Drive Erisimi Bekliyor` olarak baslar. Host marketer veya sistem sahibi
klasoru uye ile Editor olarak paylasir. Uye kendi Google hesabiyla acabildigini onayladiginda
gerekirse Google Drive'da "Add shortcut to Drive" ile klasoru Drive for desktop'ta gorunur
hale getirir; proje klasorunun ikinci kopyasini olusturmaz. Yerel erisim dogrulandiginda durum
`Drive Erisimi Var` olur. Diger uyelerin erisim durumu projenin `Aktif` olmasini engellemez;
kisi bazinda takip edilir.

### Drive host sorumlulugu ve devir

Drive host rolu, marketer'in degerlendirme sonucundan ve normal proje uyeliginden ayri bir
operasyonel sorumluluktur. Host marketer kendi sonucunu `Olumsuz` yapsa ve normal proje
uyeliginden otomatik cikarilsa bile acik devir tamamlanana kadar host olarak kalir.

Host devri kurallari:

```text
1. Devri yalnizca mevcut Drive host marketer veya Yonetici Burhan Kocak baslatabilir.
2. Yeni host aktif ve olumlu degerlendirmesi bulunan bir proje marketer'i olmalidir.
3. Yeni hostun klasor paylasimlarini yonetebilecek Google Drive yetkisi almasi saglanir.
   Google hesap/ownership kisitlari nedeniyle bu saglanamiyorsa devir tamamlanmis sayilmaz;
   klasor sistem sahibi tarafindan uygun alana tasinir veya yeniden paylasilir.
4. Yeni canonical klasor linki gerekiyorsa Project Pool kaydinda guncellenir.
5. Aktif proje uyelerinin erisimi yeniden onaylanir.
6. Yeni host sorumlulugu kabul ettiginde devir tek islem olarak tamamlanir ve gecmise yazilir.
7. Web app ana kaydi guncellendikten sonra PROJE.md ve .pa/project/state.json icindeki mevcut
   host snapshot'i agent tarafindan guncellenir.
```

Drive host sorumlulugu devredilmeden mevcut hostun Marketer rolu kaldirilamaz. Projede olumlu
marketer kalmadigi icin `Yeniden Degerlendiriliyor` durumuna gecilirse klasor eski hostta ve
mevcut izinleriyle kalabilir. Web app klasoru tasimaz, izinleri degistirmez veya salt okunur
oldugunu varsaymaz.

### Uyelikten ayrilma ve erisim kaldirma

Coder veya host olmayan uygun marketer proje ekibinden ayrildiginda web app duzenleme yetkisi
aninda kaldirilir. Google Drive izni otomatik kaldirilamadigi icin zorunlu manuel gorev
olusturulur:

```text
1. Uyenin Drive erisimi Drive Erisimi Kaldirma Bekliyor olur.
2. Drive host marketer veya sistem sahibi Google Drive'dan uye erisimini kaldirir.
3. Islemi yapan kisi web app'te erisimin kaldirildigini onaylar.
4. Durum Drive Erisimi Kaldirildi olur ve aktivite gecmisine yazilir.
```

Islem tamamlanana kadar proje ekibi ve yonetici uyarilir. Olumlu marketer ayri bir
`projeden ayril` islemi kullanmaz; once degerlendirme sonucunu degistirir. Drive host ayrilmak
veya rolunu kaybetmek istiyorsa once yukaridaki host devrini tamamlar.

### MVP Drive entegrasyonu siniri

Google Picker, Drive API ve Google OAuth MVP kapsaminda degildir. Web app Drive'da dosya veya
klasor olusturmaz, tasimaz, silmez, indirmez, izin yonetmez veya erisim testi yapmaz. Tum Drive
islemleri kullanici tarafindan manuel gerceklestirilir ve web app'te workflow onayi olarak
kaydedilir.

---

## 12. Gunluk Kullanim Akislari

### Davet, ilk giris ve bildirim kurulumu

```text
1. Yonetici Burhan Kocak kullanicinin tam e-posta adresine davet olusturur ve izin verilen
   Marketer/Coder rollerini belirler.
2. Kullanici Google Drive paylasiminda da kullanacagi davet e-posta adresiyle kimligini
   dogrular. Normalize edilen adres davetle eslesirse izin verilen rol secenekleri arasindan
   secim yapar.
3. Marketer rolu bulunan kullanici icin kisisel Drive alani olusturulur ve bilgisayarinda
   Google Drive for desktop ile senkronize edilir.
4. Yalnizca Coder rolundeki kullanici icin kisisel Drive workspace'i olusturulmaz.
5. Kullanici web app'i telefonunun ana ekranina ekler.
6. "Bildirimleri etkinlestir" islemiyle Web Push izni verir.
7. Push aboneligi kullanici hesabina kaydedilir.
8. Kullanici Idea Pool, Project Pool, bildirim merkezi ve aktivite akisini gorebilir.
```

Push izni verilmemesi web app kullanimini engellemez; olaylar uygulama ici bildirim
merkezinde gorunmeye devam eder.

### Fikir ekleme

```text
1. Herhangi bir aktif kullanici Idea Pool'a baslik ve aciklamayla fikir ekler.
2. Web app fikir icin degismez idea_id olusturur ve fikri Havuzda durumuna getirir.
3. Sistem islemi yapan dahil tum aktif kullanicilara bildirim gonderir.
4. Fikir Idea Pool'da degerlendirmeye acik olarak gorunur.
```

### Marketer degerlendirmesi hazirlama ve yayinlama

```text
1. Marketer web app'ten idea_id degerini, fikir basligini ve incelenecek surumu alir.
2. Kendi idea-workspace klasorunde Codex thread'i acar.
3. Codex create-evaluation.ps1 script'ini idea_id, kisa baslik ve marketer kimligiyle
   calistirir.
4. Script ayni fikir icin mevcut workspace varsa ikinci klasor olusturmaz; mevcut yolu
   gosterir. Yoksa degerlendirme workspace'ini ve agent paketini olusturur.
5. Marketer olusan klasoru ayri Codex root olarak acar ve yeni thread baslatir.
6. Marketing Agent ile fikri, pazari, hedef kitleyi, maliyet/riskleri ve deneme yaklasimini
   inceler.
7. Marketer web app'te Denenmeye Deger veya Olumsuz sonucunu secer.
8. Isterse kisa aciklama ekler.
9. Istege bagli Drive raporu varsa dosyayi aktif sistem kullanicilariyla Viewer olarak
   paylasir, erisimi onaylar ve canonical linki degerlendirmeye ekler.
10. Web app sonucu fikir surumune baglar, gecmise yazar ve islemi yapan dahil tum aktif
    kullanicilara bildirir.
```

Yonetici de web app'te degerlendirme sonucu kaydedebilir; ancak yoneticinin `Denenmeye Deger`
karari Project Pool kaydi veya proje workspace'i olusturmaz.

### Olumlu fikirden proje baslatma

```text
1. Ilk Marketer rolundeki Denenmeye Deger degerlendirmesi tek transaction icinde fikri
   Project Pool'a tasir.
2. Web app degismez project_id olusturur, marketer'i esit yetkili proje uyesi ve Drive host
   marketer olarak kaydeder.
3. Proje Drive Kurulumu Bekliyor durumunda baslar.
4. Host marketer kendi projects klasorunde Codex acar.
5. Codex create-project.ps1 script'ini project_id, idea_id, proje adi ve drive_host_marketer
   degerleriyle calistirir.
6. Script ayni project_id icin mevcut klasor varsa ikinci klasor olusturmaz; mevcut yolu
   gosterir. Yoksa Bolum 4'teki proje yapisini, sablonlari, kimlikleri, bos ISO hafta planini
   ve agent paketini olusturur.
7. Host marketer script basarisini web app'te onaylar.
8. Yerel proje klasoru Google Drive for desktop ile senkronize edilir.
9. Host marketer senkronizasyonun tamamlandigini onaylar.
10. Host marketer canonical Drive proje klasoru linkini Project Pool kaydina ekler.
11. Aktivasyon checklist'i tamamlanir.
12. Proje atomik olarak Aktif durumuna gecer ve islemi yapan dahil tum aktif kullanicilara
    bildirim gider.
13. Host marketer proje klasorunu ayri Codex root olarak acar ve yeni proje thread'i baslatir.
14. Codex PROJE.md ve 01-baglam dosyalarini tamamlamak icin gerekli sorulari tek tek sorar.
15. Agent ve marketer guncel haftanin bos sablonunu, hafta ortasinda ise yalnizca kalan gunler
    icin birlikte doldurur.
```

### Sonraki marketer'in projeye katilmasi

```text
1. Marketer ayni fikir icin kendi degerlendirme workspace'inde calisir.
2. Denenmeye Deger sonucu mevcut Project Pool kaydina baglanir; ikinci proje olusmaz.
3. Marketer projeye esit yetkili marketer olarak eklenir.
4. Uye Drive Erisimi Bekliyor durumunda baslar.
5. Drive host marketer veya sistem sahibi proje klasorunu yeni marketer ile Editor olarak
   paylasir.
6. Marketer gerekirse Add shortcut to Drive ile klasoru Drive for desktop'ta gorunur hale
   getirir, yerel erisimi onaylar ve Drive Erisimi Var durumuna gecer.
```

### Degerlendirme degisikligi ve proje dondurma

```text
1. Marketer Denenmeye Deger sonucunu Olumsuz olarak degistirirse normal proje uyeliginden
   otomatik cikarilir; gecmisi ve ciktilari korunur.
2. Kullanici Drive host ise host sorumlulugu otomatik kalkmaz; acik devir tamamlanana kadar
   devam eder.
3. Projede en az bir olumlu marketer kalirsa normal workflow devam eder.
4. Hic olumlu marketer kalmazsa onceki gecerli durum saklanir ve proje
   Yeniden Degerlendiriliyor durumuna gecer.
5. Web app normal alan duzenlemelerini, yeni coder katilimini ve ileri durum gecislerini
   dondurur; dosyalari, linkleri ve gecmisi okunur tutar.
6. Google Drive klasoru, hostu ve mevcut izinleri otomatik degismez.
7. Yeni bir marketer Denenmeye Deger sonucu verdiginde mevcut projeye katilir.
8. Drive kurulumu halen gecerliyse proje onceki gecerli durumuna; degilse
   Drive Kurulumu Bekliyor durumuna doner.
```

### Coder katilimi ve coding asamasina gecis

```text
1. Coder Drive Kurulumu Bekliyor dahil, Yeniden Degerlendiriliyor veya Arsivlendi olmayan
   projeye Project Pool'dan katilir.
2. Uyelik ve aktivite kaydi olusturulur; coder Drive Erisimi Bekliyor durumunda baslar.
3. Drive host marketer veya sistem sahibi yalnizca ilgili proje klasorunu coder ile Editor
   olarak paylasir.
4. Coder klasoru kendi Google hesabiyla acabildigini onaylar.
5. Coder gerekirse Add shortcut to Drive kullanarak paylasilan klasoru Drive for desktop'ta
   gorunur hale getirir, yerel erisimi onaylar ve Drive Erisimi Var durumuna gecer.
6. Coder'in katilmasi proje durumunu otomatik degistirmez.
7. Proje aktivasyon checklist'i tamamlandiktan sonra yetkili proje uyesi
   "Coding asamasini baslat" islemini acikca calistirir.
8. Proje atomik olarak Coding Asamasinda durumuna gecer ve tum aktif kullanicilara bildirilir.
```

Coder projeden ayrildiginda web app duzenleme yetkisi hemen kaldirilir. Drive izni
`Drive Erisimi Kaldirma Bekliyor` olarak izlenir; host marketer veya sistem sahibi izni
manuel kaldirir ve web app'te onaylar. Coder'in gecmisi ve ciktilari korunur.

### Haftalik plan hazirlama ve takip

```text
1. Proje ilk kez Aktif oldugunda agent ve marketer guncel ISO hafta sablonunu acar.
2. Agent kullaniciya haftanin temposunu Aggressive, Balanced veya Relaxed olarak nasil
   ayarlamasini istedigini sorar.
3. Proje hafta ortasinda aktif olduysa yalnizca kalan gunler icin gercekci gorevler birlikte
   belirlenir.
4. Sonraki haftalarda yeni plan her Pazartesi agent ve kullanici tarafindan birlikte hazirlanir.
5. Plan 05-haftalik-planlar/YYYY-WNN.md olarak, gunluk schedule ise
   05-haftalik-planlar/YYYY-WNN/ altinda kaydedilir.
6. Agent hazirladigi takvimi kullaniciya sunar; yogunlugu daha aggressive veya daha relaxed
   yapmayi onerir.
7. DURUM.md ve .pa/project/state.json aktif haftayi gosterecek sekilde guncellenir.
8. Agent hafta boyunca dosya, cikti ve schedule durumundan gorev ilerlemesini izler.
9. Dosya veya cikti kanitiyla tamamlandigi anlasilan gorevler kullaniciya sorulmadan
   Tamamlandi olarak isaretlenir ve kullaniciya bilgi verilir.
10. Harici aksiyon gerektiren ve agent'in dosyadan anlayamayacagi gorevler Kullanici Bildirimi
    Bekliyor durumunda kalir; kullanici tamamladigini soylediginde guncellenir.
11. Ertelenen, iptal edilen veya sonraki haftaya aday gorevler gerekceleriyle kaydedilir.
```

### PRD, analiz veya rapor uretme

```text
1. Yetkili marketer veya coder ilgili proje klasorunu Codex root olarak acar.
2. Agent PROJE.md, ilgili 01-baglam dosyalari, KARARLAR.md ve gerekli ham kaynaklari okur.
3. PRD'yi 04-urun/prd/, arastirmayi 02-arastirma/, stratejiyi 03-strateji/ veya raporu
   08-raporlar/ altina yazar.
4. DURUM.md ve .pa/project/state.json icindeki operasyonel durumu gunceller.
5. Ilgili haftalik gorev yalnizca kullanici tamamlanma onayindan sonra kapatilir.
6. Yetkili proje uyesi gerekli Drive cikti linkini veya aktif hafta ozetini Project Pool'da
   gunceller.
7. Web app alan gecmisini olusturur ve tum aktif kullanicilara ilgili workflow bildirimini
   gonderir.
```

### B2B saha ve hibrit pazarlama yurutme

```text
1. Agent PROJE.md icindeki musteri modeli, pazarlama modeli ve satis yaklasimini okur.
2. Potansiyel musteri, toplanti, demo, teklif, etkinlik ve takip gorevlerini haftalik plana
   marketer ile birlikte ekler.
3. Dijital ciktilari 06-pazarlama-uygulamalari/dijital/ altinda uretir.
4. Yuz yuze surec ve materyalleri 06-pazarlama-uygulamalari/saha/ altinda uretir.
5. Kanallar birlikte calisiyorsa koordinasyon kayitlarini hibrit/ altinda tutar.
6. Basili materyallerin onayli kaynaklarini 09-varliklar/basili/ altinda saklar.
7. Gorevleri yalnizca kullanicinin acik tamamlanma onayiyla kapatir.
```

### Agent guncelleme

```text
1. Sistem sahibi GitHub'da yeni agent release/tag yayinlar.
2. release-manifest.json ve SHA-256 degerlerini dogrular.
3. Kurulu workspace yeni oturumda check-update.ps1 ile yeni surumu kontrol eder.
4. Yeni surum varsa Codex kullaniciya sorar; onay yoksa guncelleme yapilmaz.
5. Onay verilirse update-agent.ps1 -Yes yalnizca aktif workspace'in .pa/agent paketini gunceller.
6. Hata olursa eski .pa/agent paketi backup'tan geri yuklenir.
7. PROJE.md, DURUM.md, KARARLAR.md, ciktilar, .pa/project ve .pa/evaluation korunur.
8. Guncelleme basariliysa Codex yeni .pa/agent/AGENTS.md dosyasini yeniden okur.
```

---

## 13. Nihai MVP Karari

PersonalAutonomy MVP, fikirden pazarlama ve urun uygulamasina kadar olan ekip workflow'unu web
app ile gorunur hale getiren; gercek calismayi Google Drive uzerindeki izole workspace'lerde
Codex ve Marketing Agent ile yuruten hibrit bir sistemdir.

### Kesin mimari

```text
Koordinasyon ve workflow:
  Mobil oncelikli PersonalAutonomy PWA

Gercek dosya sistemi:
  Google Drive + Google Drive for desktop

Calisma motoru:
  Kullanicinin bilgisayarindaki Codex App + Marketing Agent

Mobil bildirim:
  PWA Web Push + uygulama ici bildirim merkezi

Zaman standardi:
  Veritabaninda UTC
  Arayuz ve ISO haftalarda Europe/Istanbul

Kullanici erisimi:
  Yalnizca yonetici daveti ve dogrulanmis davet e-postasiyla
  Roller: Marketer, Coder veya davetin izin verdigi ikisi birlikte
  Yonetici: Yalnizca Burhan Kocak hesabinda sabit

Kisisel Drive alani:
  Yalnizca Marketer rolundeki kullanicilar

Coder Drive modeli:
  Kisisel workspace yok
  Yalnizca katildigi proje klasorune manuel erisim

Workspace turleri:
  idea-workspace/<fikir-id>-<kisa-baslik>
  projects/<proje-klasoru>

Codex izolasyonu:
  Her degerlendirme ve proje ayri Codex root
  Her workspace ayri thread
  Kok AGENTS.md ile workspace disina cikmama

Agent dagitimi:
  Her workspace'te bagimsiz .pa/agent paketi
  GitHub kaynakli, manifest ve SHA-256 ile dogrulanmis release
  Her workspace'in .pa/agent-install.json ile kendi update kaynagini bilmesi
  Kullanici onayli proje-local check-update.ps1 ve update-agent.ps1
```

### Baglayici fikir ve proje karari

1. Her aktif kullanici Idea Pool'a fikir ekleyebilir; fikir degismez `idea_id` alir ve tum
   aktif kullanicilara, islemi yapan dahil, bildirilir.
2. Marketer her fikri kendi izole degerlendirme workspace'inde Marketing Agent ile inceler.
   `create-evaluation.ps1` ayni marketer/fikir icin tek workspace olusturur.
3. Degerlendirme sonucu `Denenmeye Deger` veya `Olumsuz` olur. Aciklama ve Drive raporu
   istege baglidir; tum sonuclar web app'te herkes tarafindan okunabilir.
4. Yonetici degerlendirmesi gorus kaydidir ve tek basina proje olusturmaz.
5. Yalnizca marketer'in `Denenmeye Deger` karari, degismez `project_id` ile tek Project Pool
   kaydi olusturur ve marketer'i esit yetkili proje uyesi ile Drive host yapar.
6. Ayni fikir icin sonraki olumlu marketer'lar mevcut projeye katilir; ikinci proje olusmaz.
7. Proje klasorunu yalnizca kayitli Drive host marketer, `create-project.ps1` ile
   `project_id`, `idea_id`, proje adi ve host kimligini kullanarak olusturur.
8. Proje; script basarisi, Drive senkronizasyonu ve canonical klasor linki onaylanmadan
   `Aktif` olamaz.
9. Coder, `Yeniden Degerlendiriliyor` veya `Arsivlendi` olmayan projeye katilabilir ve sadece
   ilgili proje klasorune manuel Drive erisimi alir. Coder katilimi proje durumunu otomatik
   olarak degistirmez; coding asamasina gecis aktivasyon sonrasinda acik islem gerektirir.
10. Son olumlu marketer kalmadiginda proje silinmez; web app'te
    `Yeniden Degerlendiriliyor` durumunda dondurulur. Drive konumu ve izinleri otomatik
    degismez. Yeni olumlu marketer mevcut projeyi yeniden etkinlestirir.

### Drive sahipligi ve veri siniri

- Google Drive gercek degerlendirme/proje dosyalari icin tek dogruluk kaynagidir.
- Web app davet, rol, fikir, degerlendirme, proje, uyelik, durum, checklist, link, bildirim ve
  degisiklik gecmisi icin tek dogruluk kaynagidir.
- Ham degerlendirme dosyalari marketer'in kisisel `idea-workspace/` alaninda kalir.
- Istege bagli degerlendirme raporu marketer tarafindan Viewer olarak paylasilir; web app
  yalnizca canonical linki saklar.
- Drive host rolu degerlendirme sonucu ve normal proje uyeliginden ayri sorumluluktur. Mevcut
  host veya Burhan Kocak, aktif olumlu marketer'a acik devir yapmadan host degismez.
- Web app Drive dosyalarini okumaz, yuklemez, tasimaz, silmez, indirmez, yeniden yazmaz veya
  izinlerini otomatik yonetmez.
- Drive ile web app celisirse sistem sessizce varsayim yapmaz; ilgili kullaniciya uyari ve
  acik duzeltme adimi sunar.

### Marketing calisma karari

Marketing Agent yalnizca dijital B2C pazarlama icin degildir. B2B, saha ve hibrit pazarlamada
pazar/musteri arastirmasi, konumlandirma, fiyat/teklif, PRD, landing page, kampanya, icerik,
image generation, potansiyel musteri, toplanti, demo, etkinlik ve takip sureclerinde
marketer'a destek verir.

`create-project.ps1` guncel ISO haftasi icin bos sablon ve gunluk schedule klasoru olusturur.
Proje aktif oldugunda ilk plan kalan gunler icin hemen, sonraki planlar her Pazartesi agent ve
kullanici tarafindan birlikte hazirlanir. Web app planin kopyasini tutmaz. Dosya veya cikti bir
gorevin tamamlandigina acik kanit oluyorsa agent gorevi tamamlandi olarak isaretler ve
kullaniciya bildirir. Harici aksiyon gerektiren gorevler kullanici tamamladigini soyleyene kadar
`Kullanici Bildirimi Bekliyor` durumunda kalir.

### Otomasyon ve hata karari

- `create-evaluation.ps1` degerlendirme workspace'inin tek olusturucusudur.
- `create-project.ps1` proje workspace'inin tek olusturucusudur.
- Scriptler gecici klasorde kurar, zorunlu yapilari dogrular ve atomik olarak yayinlar.
- Ayni `idea_id`/`project_id` icin ikinci workspace veya proje kopyasi olusturulmaz.
- Agent guncellemesi proje-localdir; `check-update.ps1` salt okunur kontrol yapar,
  `update-agent.ps1 -Yes` yalnizca `.pa/agent/` paketini gunceller, kullanici verisini korur
  ve hata halinde rollback yapar.
- Hata mesajlari teknik olmayan kullaniciya ne oldugunu ve sonraki adimi aciklar. Sistem,
  release veya erisim hatasinda Yonetici Burhan Kocak ile iletisim yonlendirmesi yapilir.
- Kritik veritabani islemleri transaction, benzersizlik kurali, idempotency ve sunucu tarafli
  yetki kontroluyle korunur.

### Sabit MVP sinirlari

MVP asamasinda:

- acik kullanici kaydi yoktur,
- web app dosya yuklemez veya depolamaz,
- Google Drive API, Google OAuth veya Google Picker kullanilmaz,
- web app otomatik Drive klasoru olusturmaz,
- Drive ile otomatik cift yonlu dosya senkronizasyonu yapilmaz,
- Drive izinleri otomatik yonetilmez,
- background watcher service calistirilmaz,
- proje ve aktivite e-posta bildirimi gonderilmez; zorunlu hesap dogrulama mesaji bu sinirin
  disindadir,
- Mixpanel, PostHog, Amplitude ve Airtable entegrasyonlari kurulmaz; bunlar MVP sonrasi
  analitik, veri ve pano entegrasyonu adaylari olarak not edilir,
- gercek zamanli ortak metin editoru sunulmaz,
- calisan performans puani veya siralama sistemi kurulmaz,
- tam kapsamli admin paneli, object storage ve gelismis audit export/raporlama yapilmaz;
  davet, rol, kalici silme ve gerekli Drive host mudahalesi icin zorunlu asgari yonetici
  kontrolleri bu sinirin disindadir.

Bu bolum MVP'nin baglayici mimari ve kapsam kararidir. Bolum 1-12 ayrintili uygulama
kurallarini tanimlar. Hicbir uygulama; workspace izolasyonunu, degismez kimlikleri, davet ve rol
kurallarini, Drive sahipligini, acik kullanici onayini veya workflow durum makinesini sessizce
degistiremez.
