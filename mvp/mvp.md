# PersonalAutonomy MVP Mimarisi

Bu dokuman, PersonalAutonomy projesinin MVP asamasinda nasil calisacagini tarif eder.
Amac, marketing ve coding ekibinin Codex destekli calisma akisini hizli, dusuk maliyetli
ve yonetilebilir sekilde test etmektir.

MVP'nin ana fikri sudur:

- Her kullanici kendi bilgisayarinda Codex App kullanir.
- Kullanici disaridayken ChatGPT mobil uygulamasindan kendi bilgisayarindaki Codex host'una erisir.
- Dosyalar Google Drive uzerinden senkronize edilir.
- Her marketer kendi Drive klasorunde calisir.
- Her proje ayri bir klasordur.
- Her Codex thread'i dogrudan ilgili proje klasorunde baslar.
- Marketing agent dosyalari her proje klasorunun icine versiyonlu olarak kopyalanir.
- Agent guncellemeleri merkezi release klasorunden script ile tum proje klasorlerine dagitilir.

Bu model asil deger onerisine odaklanir: marketing ekiplerinin teknik detaylarla
ugrasmadan, telefon uzerinden yonlendirebildikleri Codex agent'lari ile PRD, analiz,
rapor, landing page brief'i, sosyal medya icerigi ve kampanya ciktilari uretebilmesi.

---

## 1. Temel Sistem Bilesenleri

MVP sistemi dort ana parcadan olusur:

1. **Kullanici bilgisayari**
   - Codex App acik kalir.
   - Google Drive for desktop kurulu olur.
   - Kullanici kendi proje klasorlerinde Codex thread'leri baslatir.

2. **ChatGPT mobil uygulamasi**
   - Kullanici disaridayken telefondan Codex thread'lerine erisir.
   - Onay verir, yonlendirme yapar, ciktilari inceler.

3. **Google Drive**
   - Ana dosya depolama ve senkronizasyon katmanidir.
   - Klasorler kullanici bazli izole edilir.
   - Proje dosyalari, PRD, rapor, analiz ve assetler burada saklanir.

4. **Marketing agent paketi**
   - Her proje klasorune kopyalanir.
   - Codex'in o projede nasil davranacagini belirler.
   - Merkezi release klasorunden guncellenir.

---

## 2. Google Drive Klasor Modeli

Ana Drive klasoru sistem sahibine aittir. Kullanici izolasyonu icin ana klasor herkese
acilmaz; her kullaniciya sadece kendi alt klasoru paylasilir.

Onerilen yapi:

```text
PersonalAutonomy/
  shared/
    agent-releases/
      v1.0.0/
      v1.1.0/
    tools/
      create-project.ps1
      update-project-agent.ps1
      update-all-agents.ps1
    templates/

  marketers/
    ayse/
      projects/
        x-projesi/
        y-projesi/

    mehmet/
      projects/
        z-projesi/
```

Paylasim kurali:

```text
PersonalAutonomy/
  sadece sistem sahibi

PersonalAutonomy/marketers/ayse/
  sistem sahibi + Ayse

PersonalAutonomy/marketers/mehmet/
  sistem sahibi + Mehmet

PersonalAutonomy/shared/agent-releases/
  sistem sahibi yazabilir
  kullanicilar okuyabilir
```

Bu modelin sonucu:

- Sistem sahibi tum klasorleri gorebilir.
- Ayse sadece kendi klasorunu gorur.
- Mehmet sadece kendi klasorunu gorur.
- Kullanicilar birbirinin projelerini gormez.
- Tum dosyalar sistem sahibinin Drive ana yapisi altinda toplanir.

Ana klasoru herkese acmak dogru degildir. Izolasyon isteniyorsa yetki kullanici klasoru
seviyesinde verilmelidir.

---

## 3. Kullanıcı Klasörü (Local & Codex)

Her kullanicinin kendi calisma alani olur:

```text
marketers/
  ayse/
    projects/
      x-projesi/
      y-projesi/
```

Kullanicinin Codex ile gunluk calismasi esas olarak `projects` altindaki proje klasorlerinde
gerceklesir.

`projects` klasoru sadece iki is icin kullanilir:

- yeni proje olusturma
- mevcut projeleri listeleme

Gercek is akisi proje klasorunun icinde yurur.

---

## 4. Proje Klasoru

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

- proje amaci
- urun/fikir ozeti
- marketer
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

Pazar, rakip, musteri ve trend arastirmalarinin calisma alanidir. Market Scout veya benzeri
arastirma adimlari ciktilarini burada uretir.

`03-strateji/`

Arastirmadan cikan yorumlarin stratejiye donustugu alandir. Fikir dogrulama, konumlandirma,
fiyatlandirma, pazara giris ve buyume planlari burada tutulur.

`04-urun/`

Fikrin urun dokumanlarina donustugu alandir. PRD taslaklari, coder briefleri, fikir ozetleri
ve urun kapsami kararlarini icerir.

`05-haftalik-planlar/`

Marketing agent ile kullanicinin birlikte hazirladigi haftalik operasyon planlarini tutar.
Her hafta ISO yil ve hafta numarasiyla ayri dosya olarak saklanir; ornegin
`2026-W25.md`. Plan Pazartesi-Pazar gunlerini kapsar ve gorevler gunlere dagitilir.

Her gorev en az su bilgileri tasir:

```markdown
- [ ] Gorev: B2B demo sunumunu hazirla
  - Kanal: Saha
  - Oncelik: Yuksek
  - Beklenen cikti: Demo sunumu
  - Cikti konumu: 06-pazarlama-uygulamalari/saha/sunumlar/
  - Durum: Bekliyor
  - Tamamlanma onayi: Kullanici
```

Agent gorev ilerlemesini ve uretilen ciktilari izler; ancak bir dosyanin uretilmesi gorevi
otomatik olarak tamamlamaz. Gorev yalnizca kullanicinin acik onayindan sonra `[x]` ve
`Tamamlandi` olarak guncellenir. Ertelenen veya iptal edilen gorevler gerekcesiyle kaydedilir.
Tamamlanmayan gorevlerin yeni haftaya tasinmasina agent ve kullanici birlikte karar verir.

`06-pazarlama-uygulamalari/`

Projenin pazarlama ve satis destek faaliyetlerinin uygulama alanidir. B2C, B2B ve hibrit
projelerin dijital ve yuz yuze calismalarini tek proje baglami icinde tutar.

`06-pazarlama-uygulamalari/dijital/`

Icerik, sosyal medya, eposta, landing page, dijital reklam ve SEO calismalarini tutar.

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

Onaylanmis ve teslim edilebilir son ciktilarin yeridir. Coder veya sistem sahibi proje
klasorunu actiginda once buraya bakarak final PRD, coder brief, rapor, lansman ve dijital,
saha veya hibrit pazarlama ciktilarina ulasir.

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
duzenlenmez. Onaylanmis son `overrides.md` iceriginin SHA-256 degeri de burada
`overrides_sha256` alaniyla tutulur.

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

> Her gercek calisma thread'i dogrudan ilgili proje klasorunde baslatilir.

Dogru:

```text
Codex root:
PersonalAutonomy/marketers/ayse/projects/x-projesi
```

Yanlis:

```text
Codex root:
PersonalAutonomy/marketers/ayse/projects
```

`projects` klasorunde Codex yalnizca proje olusturma veya proje listeleme icin kullanilir.
PRD yazma, analiz yapma, rapor uretme, landing page hazirlama gibi isler her zaman ilgili
proje klasorunde yeni bir thread ile yapilir.

Bu kuralin nedeni:

- Codex aktif proje baglamini net bilir.
- Kardes proje klasorlerini gereksiz yere okumaz.
- Yanlis projeden bilgi alma riski azalir.
- Her proje kendi thread gecmisine sahip olur.
- Kok `AGENTS.md` proje sinirlarini belirler ve aktif agent talimatlari icin
  `.pa/agent/AGENTS.md` dosyasina yonlendirir.

---

## 6. Yeni Proje Olusturma Akisi

Kullanici once kendi `projects` klasorunde Codex thread'i baslatir:

```text
PersonalAutonomy/marketers/ayse/projects
```

Sonra su komutu verir:

```text
Yeni marketing projesi olustur: x-projesi
```

Codex kullanicinin talebini ve proje adini aldiktan sonra `create-project.ps1` script'ini
calistirir. Codex proje klasorlerini ve dosyalarini elle olusturmaz. Dosya sistemi uzerindeki
proje olusturma isleminin tek sorumlusu script'tir.

`create-project.ps1` script'i su islemleri sirasiyla gerceklestirir:

```text
1. Kullanicidan gelen proje adini bosluk, gecersiz karakter ve guvenli klasor adi kurallarina
   gore kontrol eder.
2. Proje adi uygun degilse guvenli bir ad onerir. Ornegin "Yeni Urun Projesi" icin
   "yeni-urun-projesi" onerilir ve devam etmeden once kullanici onayi istenir.
3. Hedef projects klasorunde ayni isimde proje olup olmadigini kontrol eder.
4. Ayni isimde proje varsa hicbir dosyaya dokunmadan islemi durdurur ve teknik olmayan
   kullaniciya su anlama gelen acik bir mesaj gosterir:
   "Bu isimde bir proje zaten var. Mevcut projeniz korunuyor ve herhangi bir degisiklik
   yapilmadi. Lutfen yeni projeniz icin farkli bir isim girin."
5. En guncel marketing-agent release klasorunun ve zorunlu sablon dosyalarinin mevcut ve
   okunabilir oldugunu kontrol eder.
6. Agent release veya zorunlu sablonlardan biri bulunamazsa projeyi olusturmaz, hicbir kalici
   dosya birakmaz ve su anlama gelen mesajla islemi durdurur:
   "Proje olusturulamadi; gerekli sistem dosyalari bulunamadi veya okunamadi. Lutfen tekrar
   denemek yerine Yonetici Burhan Kocak ile iletisime gecin."
7. Tum on kontroller basariliysa hedef projects klasoru icinde benzersiz adli gecici bir
   proje klasoru olusturur. Kalici x-projesi klasoru bu asamada henuz olusturulmaz.
8. MVP dokumaninin 4. Proje Klasoru bolumunde tanimlanan klasor ve dosyalarin tamaminin
   ayni adlar ve ayni hiyerarsiyle gecici klasorde olusturulmasini saglar.
9. Kok seviyedeki AGENTS.md dosyasini degismeyen bootstrap sablonundan olusturur. Bootstrap,
   Codex'i aktif talimatlar icin .pa/agent/AGENTS.md dosyasina yonlendirir. PROJE.md,
   DURUM.md, KARARLAR.md ve README.md dosyalarini onayli sablonlardan uretir.
10. 00-gelen-kutusu altindaki fikir.md, kullanici-notlari.md ve ham-linkler.md dahil olmak
    uzere Bolum 4'te dosya olarak gosterilen tum proje dosyalarini olusturur.
11. 01-baglam altindaki urun-baglami.md, hedef-kitle.md, marka.md, kisitlar.md ve rakipler.md
    dosyalarini onayli sablonlardan olusturur.
12. Bos tutulmasi gereken calisma ve cikti klasorlerini olusturur. Google Drive bos klasorleri
    senkronize etmiyorsa her bos klasore sabit bir `.gitkeep` dosyasi koyar; boylece Bolum 4
    yapisinin Drive uzerinde de eksiksiz korunmasini saglar.
13. Guncel yerel tarihe gore ISO yil ve hafta numarasini hesaplar ve
    05-haftalik-planlar/YYYY-WNN.md dosyasini haftalik plan sablonundan olusturur.
14. Haftalik plan sablonunu Pazartesi-Pazar basliklari, gorev alani, kanal, oncelik, beklenen
    cikti, cikti konumu, durum ve kullanici tamamlanma onayi alanlariyla olusturur; baslangic
    gorevlerini kullanici adina doldurmaz.
15. En guncel marketing-agent paketini tum alt klasorleri ve dosyalariyla .pa/agent altina
    kopyalar ve kopyalanan release'e uygun agent-version.json dosyasini yazar.
16. .pa/project altinda overrides.md, overrides-approved.md, state.json, active-task.md ve
    settings.json dosyalarini gecerli baslangic sablonlariyla olusturur. Iki override dosyasi
    baslangicta ayni icerige sahiptir; state.json bu icerigin SHA-256 degerini tasir.
17. DURUM.md ve .pa/project/state.json icine aktif haftalik plan dosyasini kaydeder. Baslangic
    durumunu "Proje baglami tamamlaniyor" olarak ayarlar; hicbir haftalik gorevi tamamlandi
    olarak isaretlemez.
18. DURUM.md ve README.md icinde teknik olmayan kullaniciya su sirayla yonlendirme yapar:
    once PROJE.md icin urun ve musteri bilgilerini tamamla; sonra 01-baglam dosyalarini agent
    ile netlestir; ardindan agent ile guncel haftalik plani birlikte hazirla.
19. Gecici projeyi Bolum 4'teki zorunlu klasor ve dosya listesine gore dogrular. Eksik,
    okunamayan veya hatali bir oge varsa islemi durdurur ve gecici klasoru temizler.
20. Dogrulama basariliysa gecici klasoru tek tasima islemiyle x-projesi adina cevirerek kalici
    proje klasorunu yayinlar.
21. Basari mesajinda proje adini ve konumunu gosterir; kullaniciyi yeni proje klasorunde Codex
    thread'i acmaya, once proje bilgilerini tamamlamaya ve sonra haftalik plani hazirlamaya
    yonlendirir.
```

Script herhangi bir adimda hata alirsa kalici proje klasoru olusturmaz. Olusturdugu gecici
klasoru temizler ve teknik hata kodu yerine kullanicinin ne oldugunu ve ne yapmasi gerektigini
anlayacagi bir mesaj gosterir. Ayrintili teknik hata, yonetici tarafindan incelenebilmesi icin
ayri log kaydina yazilabilir.

Script'in basari olcutu yalnizca proje klasorunun var olmasi degildir. Bolum 4'te tanimlanan
butun dosya ve klasorler, agent paketi, proje durum dosyalari ve guncel ISO haftalik plan
sablonu dogrulanmadan proje basariyla olusturulmus sayilmaz.

Olusan klasor:

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

Sonra kullanici yeni proje klasorunde yeni bir Codex thread'i baslatir:

```text
PersonalAutonomy/marketers/ayse/projects/x-projesi
```

Bu yeni thread artik projenin asil calisma thread'idir.

---

## 7. Marketing Agent Dagitim Modeli

Marketing agent merkezi olarak `shared/agent-releases` altinda tutulur.

Ornek:

```text
shared/
  agent-releases/
    v1.0.0/
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

    v1.1.0/
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
```

Yeni proje olusturulurken en guncel release proje icine kopyalanir:

```text
x-projesi/
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
```

Bu modelin avantaji:

- Her proje kendi agent kopyasina sahiptir.
- Codex proje klasorunden calisirken agent dosyalarina lokal olarak ulasir.
- Proje bazli ozellestirme yapilabilir.
- Eski projelerde hangi agent surumunun kullanildigi takip edilebilir.
- Merkezi agent degisikligi kontrollu script ile dagitilir.

---

## 8. Agent Guncelleme Akisi

Sistem sahibi marketing-agent uzerinde degisiklik yaptiginda yeni bir release olusturur:

```text
shared/agent-releases/v1.2.0
```

Release klasoru agent paketine ek olarak `release-manifest.json` dosyasini tasir. Manifest release surumunu,
zorunlu dosya listesini ve her dosyanin SHA-256 hash degerini icerir. Sistem sahibi sonra
update script'ini calistirir:

```powershell
.\shared\tools\update-all-agents.ps1 -Version "v1.2.0"
```

Eski bir surume kontrollu donus gerekiyorsa acik parametre kullanilir:

```powershell
.\shared\tools\update-all-agents.ps1 -Version "v1.1.0" -AllowDowngrade
```

`update-all-agents.ps1` dosya sistemi degisikliklerine baslamadan once hedef release'i bir
kez dogrular:

```text
1. Version parametresinin vMAJOR.MINOR.PATCH biciminde oldugunu kontrol eder. MAJOR, MINOR ve
   PATCH degerlerini ayri tamsayilar olarak yorumlar; surumleri metin olarak karsilastirmaz.
2. Hedef release klasorunun tek ve okunabilir oldugunu kontrol eder.
3. AGENTS.md, ARCHITECTURE.md, SKILLS.md, agents/, pipelines/, skills/, scripts/,
   templates/, mcps.json ve release-manifest.json dosyasinin mevcut oldugunu kontrol eder.
4. Manifest JSON yapisini, manifestteki surum ile Version parametresinin esitligini ve zorunlu
   dosya listesini kontrol eder.
5. Release icindeki dosyalarin SHA-256 hash degerlerini manifest ile karsilastirir.
6. mcps.json ve release icindeki diger JSON dosyalarinin gecerli JSON oldugunu kontrol eder.
```

Release on dogrulamadan gecmezse hicbir proje taranmaz veya degistirilmez. Script kullaniciya
release'in neden reddedildigini anlasilir bicimde soyler, teknik ayrintiyi log dosyasina yazar
ve Yonetici Burhan Kocak ile iletisime gecilmesini ister.

### Gecerli projelerin bulunmasi

Script `marketers/*/projects/*` klasorlerini tarar; ancak her klasoru proje kabul etmez. Bir
klasor yalnizca asagidaki isaretlerin tamami varsa PersonalAutonomy projesi sayilir:

```text
AGENTS.md
PROJE.md
.pa/agent/agent-version.json
.pa/project/state.json
```

Kok `AGENTS.md` icinde `PA_BOOTSTRAP_VERSION: 1` isareti de bulunmalidir.
`agent-version.json` ve `state.json` gecerli JSON degilse, gerekli alanlari tasimiyorsa veya
bootstrap isareti yoksa klasor degistirilmeden atlanir ve son raporda "gecersiz proje yapisi"
olarak listelenir. Boylece `projects/` altindaki rastgele veya kullaniciya ait baska klasorlere
dokunulmaz. Gecici calisma klasorleri proje taramasina dahil edilmez.

### Surum karari

Her gecerli proje icin mevcut `agent-version.json` okunur:

- Surum karsilastirmasi MAJOR, MINOR ve PATCH tamsayilari uzerinden yapilir. Ornegin v1.10.0,
  v1.2.0 surumunden yenidir.
- Mevcut surum hedef surumle ayniysa proje degistirilmeden `ayni surum` olarak atlanir.
- Mevcut surum hedeften yeniyse `-AllowDowngrade` yoksa proje degistirilmeden atlanir.
- Mevcut surum hedeften yeniyse ve `-AllowDowngrade` varsa kontrollu surum dusurme yapilir.
- Mevcut surum hedeften eskiyse normal guncelleme yapilir.
- Surum bilgisi okunamiyorsa proje degistirilmez ve hata raporuna eklenir.

### Proje bazli atomik guncelleme

Her proje birbirinden bagimsiz bir guncelleme islemi olarak ele alinir. Bir projedeki hata
diger projelerin guncellenmesini engellemez:

```text
1. Projenin .pa/agent klasorundeki zorunlu dosyalarin yerel olarak okunabilir oldugunu kontrol
   eder. agent-version.json ve release-manifest.json icin paylasimsiz okuma denemesi yapar.
2. `.pa/` altinda gecici bir test dosyasi olusturma, yeniden adlandirma ve silme islemlerini
   dener. Kilit veya Drive erisim sorunu varsa iki saniye arayla toplam uc kez tekrarlar.
3. Uc denemeden sonra okuma ya da yazma testi basarisizsa projeye dokunmaz; projeyi
   "kilitli veya senkronizasyon bekliyor" olarak atlar.
4. Proje klasorunun disinda ancak hedef projeyle ayni dosya sistemi/Drive kokunde bulunan
   `marketers/<kullanici>/.pa-update-work/` altinda, bu projeye ozel benzersiz backup ve
   hazirlama klasorleri olusturur. Boylece son yeniden adlandirma ayni dosya sistemi icinde
   kalir ve calisma alani proje taramasina girmez.
5. Mevcut .pa/agent klasorunu backup alanina kopyalar, backup icin gecici bir dosya/hash
   envanteri olusturur ve kopyanin eksiksizligini bu envanterle dogrular.
6. Yeni release'i hazirlama klasorune kopyalar, hedef surume ait agent-version.json dosyasini
   burada olusturur ve manifest/hash kontrollerini tekrar yapar.
7. Hazirlanan paket basariliysa mevcut .pa/agent klasorunu ayni dosya sistemi icindeki
   eski-surum konumuna yeniden adlandirir ve hazirlanan klasoru .pa/agent konumuna atomik
   yeniden adlandirma ile yerlestirir.
8. Yeni .pa/agent klasorunu, agent-version.json dosyasini ve zorunlu dosyalari son kez dogrular.
9. Son dogrulama basariliysa eski-surum klasorunu, backup'i ve gecici hazirlama alanini temizler.
10. Herhangi bir adim basarisizsa yeni veya yarim paket kaldirilir, backup eski .pa/agent
   konumuna geri yuklenir ve geri yuklenen surum dogrulanir.
11. Proje geri alindiktan sonra script diger projelerle devam eder.
```

Guncelleme sadece `.pa/agent/` klasorunu degistirir. Kok `AGENTS.md` sabit bootstrap olarak
kalir ve her zaman `.pa/agent/AGENTS.md` dosyasindaki aktif surume yonlendirir. Script su proje
verilerine ve ayarlarina dokunmaz:

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

### Sonuc raporu ve log

Script tamamlandiginda teknik olmayan kullanici icin kisa bir ozet gosterir:

```text
Hedef surum: v1.2.0
Guncellenen projeler: 12
Ayni surum oldugu icin atlananlar: 3
Surum dusurme izni olmadigi icin atlananlar: 1
Kilit veya Drive senkronizasyonu nedeniyle atlananlar: 2
Gecersiz proje yapisi nedeniyle atlananlar: 1
Hata sonrasi eski surume dondurulenler: 1
```

Ozet, sorunlu projelerin adlarini ve kullanicinin ne yapmasi gerektigini de belirtir. Teknik
ayrintilar `shared/logs/agent-update-YYYYMMDD-HHMMSS.log` dosyasina yazilir. Log; hedef surumu,
parametreleri, proje bazli eski/yeni surumu, baslangic ve bitis zamanini, atlama nedenlerini,
hash dogrulama sonucunu, rollback sonucunu ve hata ayrintilarini icerir. Log dosyasina agent
icerigi, kullanici proje verisi veya gizli bilgiler yazilmaz.

Script ancak geri yukleme de basarisiz olursa kritik hata ile durur ve diger projelere devam
etmez. Kullaniciya etkilenen proje yolu acikca gosterilir ve Yonetici Burhan Kocak ile iletisime
gecmesi soylenir. Normal bir proje guncelleme hatasinda rollback basariliysa diger projelerle
devam edilir.

Ornek `agent-version.json`:

```json
{
  "version": "v1.2.0",
  "updated_at": "2026-06-06T21:00:00+03:00",
  "source": "shared/agent-releases/v1.2.0",
  "manifest_sha256": "release-manifest-sha256"
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
- haftalik gorevleri tamamlamak icin gereken acik kullanici onayi
- agent release dogrulama, update, backup ve rollback kurallari
- kullanici verisini koruma ve gizli bilgileri loglamama kurallari
- dosya sahipligi ve degisiklik onayi akisi

Agent gecersiz bir override tespit ederse uygulamaz, nedenini teknik olmayan bir dille
aciklar ve guvenli bir alternatif onerir. Bu model merkezi agent guncellense bile proje ozel
tercihleri korurken sistemin temel guvenlik ve tutarlilik kurallarinin bozulmasini engeller.

---

## 10. Web App'in MVP'deki Rolu

MVP web app dosya depolamaz. Sadece is akisi ve metadata merkezi olur.

Web app'te tutulabilecek bilgiler:

```text
Idea Pool
  - fikir basligi
  - aciklama
  - ekleyen kisi
  - tarih

Project Pool
  - proje adi
  - marketer
  - coder
  - durum
  - checklist
  - notlar
  - Drive klasor linki
  - PRD linki
  - analiz linki
  - landing page linki
  - rapor linki
```

Dosyalar Google Drive'da kalir.

Web app sadece linkleri saklar:

```text
drive_folder_url
prd_file_url
analysis_file_url
report_file_url
landing_page_url
```

Ilk surumde dosya secimi icin file picker sart degildir. Kullanici Drive linkini yapistirabilir.
Daha sonra Google Picker eklenebilir.

---

## 11. Drive Link ve File Picker Modeli

Kullanici web app'e telefondan girdiginde proje icin Drive linkleri ekleyebilir.

MVP seviye 1:

```text
Kullanici Drive'dan dosya linkini kopyalar.
Web app'e yapistirir.
Web app linki proje kaydina ekler.
```

MVP seviye 2:

```text
Kullanici web app'te "Drive'dan sec" butonuna basar.
Google Picker acilir.
Kullanici kendisiyle paylasilmis klasorden dosya secer.
Web app secilen dosyanin linkini kaydeder.
```

Bu modelde dosya web app'e upload edilmez. Dosya Google Drive'da kalir.
Erisim kontrolunu web app degil, Google Drive belirler.

---

## 12. Marketer ve Coder Akisi

### Fikir havuzu

Her kullanici web app'e fikir ekleyebilir:

```text
Fikir: AI destekli restoran yorum analiz araci
Aciklama: Google yorumlarini analiz edip isletmeye aksiyon listesi verir.
Ekleyen: Ayse
Durum: Havuzda
```

### Marketer devralma

Marketer "fikri devral" der.

Sistem:

```text
1. Fikri proje havuzuna tasir.
2. Marketer'i projeye atar.
3. Drive tarafinda proje klasoru olusturulmasi gerekir.
4. Proje klasor linki web app'e eklenir.
```

MVP'de Drive klasoru Codex create-project komutu ile olusturulur.
Ileride web app Google Drive API ile klasoru kendisi olusturabilir.

### Coder devralma

Coder proje havuzundan "projeyi devral" der.

Web app'te proje kaydi guncellenir:

```text
Coder: Burak
Durum: Coding asamasinda
```

Coder ilgili Drive klasor linkinden PRD, analiz ve notlari gorebilir.

---

## 13. Gunluk Kullanim Akislari

### Yeni proje baslatma

```text
1. Marketer kendi projects klasorunde Codex acar.
2. "Yeni marketing projesi olustur: x-projesi" der.
3. Script proje klasorunu ve agent paketini olusturur.
4. Marketer x-projesi klasorunde yeni Codex thread'i baslatir.
5. Codex PROJE.md dosyasindaki urun, musteri modeli, pazarlama modeli ve satis yaklasimi
   alanlarini doldurmak icin gerekli sorulari tek tek sorar.
6. Proje calismasi bu thread icinde devam eder.
```

### Haftalik plan hazirlama ve takip

```text
1. Her Pazartesi agent aktif proje durumunu ve onceki haftayi inceler.
2. Kullanici ile birlikte Pazartesi-Pazar gunlerine dagitilmis yeni plan hazirlar.
3. Plan 05-haftalik-planlar/YYYY-WNN.md olarak kaydedilir.
4. DURUM.md ve .pa/project/state.json aktif haftayi gosterecek sekilde guncellenir.
5. Agent hafta boyunca gorev ciktilarini ve ilerlemeyi izler.
6. Agent tamamlandigini dusundugu gorev icin kullanicidan acik onay ister.
7. Yalnizca kullanici onaylarsa gorev tamamlandi olarak isaretlenir.
8. Ertelenen, iptal edilen veya sonraki haftaya aday gorevler gerekceleriyle kaydedilir.
```

### PRD uretme

```text
1. Marketer x-projesi thread'ini acar.
2. "Bu fikir icin PRD hazirla" der.
3. Agent PROJE.md ve varsa 00-gelen-kutusu/ altindaki dosyalari okur.
4. PRD cikti dosyasini 04-urun/prd/ altina yazar.
5. DURUM.md dosyasinda PRD durumunu gunceller.
6. Marketer web app'e PRD linkini ekler.
```

### Analiz veya rapor uretme

```text
1. Agent ilgili proje klasorunde calisir.
2. Arastirma ciktilarini 02-arastirma/, strateji ciktilarini 03-strateji/ veya raporlari
   08-raporlar/ altina yazar.
3. DURUM.md dosyasini gunceller.
4. Ilgili haftalik gorev ancak kullanici tamamlanma onayi verdikten sonra isaretlenir.
5. Varsa web app checklist'i ayni onaydan sonra guncellenir.
```

### B2B saha ve hibrit pazarlama yurutme

```text
1. Agent PROJE.md icindeki musteri modeli, pazarlama modeli ve satis yaklasimini okur.
2. Potansiyel musteri, toplanti, demo, teklif, etkinlik ve takip gorevlerini haftalik plana ekler.
3. Dijital ciktilari 06-pazarlama-uygulamalari/dijital/ altinda uretir.
4. Yuz yuze surec ve materyalleri 06-pazarlama-uygulamalari/saha/ altinda uretir.
5. Kanallar birlikte calisiyorsa koordinasyon kayitlarini hibrit/ altinda tutar.
6. Basili materyallerin onayli kaynaklarini 09-varliklar/basili/ altinda saklar.
7. Gorevleri yalnizca kullanicinin acik tamamlanma onayiyla kapatir.
```

### Agent guncelleme

```text
1. Sistem sahibi yeni agent release'i hazirlar.
2. shared/agent-releases/vX.Y.Z altina koyar.
3. release-manifest.json ve SHA-256 dogrulamalarini hazirlar.
4. update-all-agents.ps1 calistirir.
5. Script release'i bir kez, projeleri ise tek tek dogrular.
6. Gecerli projelerde .pa/agent atomik olarak guncellenir.
7. Hata alan proje eski surume dondurulur; diger projelerle devam edilir.
8. Kullaniciya sonuc ozeti, yoneticiye tarihli teknik log sunulur.
```

---

## 14. Google Drive Seciminin Gerekcesi

MVP icin Google Drive secilmesinin nedeni:

- Paylasimli klasor modeli yeterince basit.
- Desktop sync ile kullanici bilgisayarinda lokal klasor gibi calisir.
- Mobil web ve Drive link deneyimi yaygindir.
- Google Picker ile ileride web app icinden dosya secimi yapilabilir.
- Dosya preview/link paylasimi MVP icin yeterlidir.
- Storage ve dosya guvenligi gelistirme yuku ortadan kalkar.

OneDrive ve Dropbox alternatifleri mumkundur, ancak MVP icin Google Drive daha dusuk
surunmeli baslangic noktasi olarak secilmistir.

Uzun vadede sistem buyurse dosyalar object storage'a tasinabilir:

- Cloudflare R2
- Backblaze B2
- S3
- Google Cloud Storage
- Azure Blob

Bu gecis sonraki asama konusudur.

---

## 15. Riskler ve Onlemler

### Risk: Codex yanlis proje dosyasini okur

Onlem:

- Her proje ayri klasor.
- Her proje icin ayri Codex thread.
- Thread dogrudan proje klasorunde baslar.
- `AGENTS.md` aktif proje disina cikmamayi belirtir.

### Risk: Agent guncellemesi proje verisini bozar

Onlem:

- Update script sadece `.pa/agent` klasorunu gunceller.
- Kok `AGENTS.md` sabit bootstrap olarak aktif `.pa/agent/AGENTS.md` dosyasina yonlendirir.
- Proje dosyalarina dokunmaz.
- Release dagitimdan once manifest ve SHA-256 degerleriyle dogrulanir.
- Her proje icin proje disinda, ayni dosya sistemi uzerinde dogrulanmis backup alinir.
- Guncelleme proje bazinda atomik yapilir; hata halinde eski surum geri yuklenir.
- Bir projedeki normal hata diger projeleri durdurmaz ve sonuc raporunda aciklanir.

### Risk: Drive sync gecikir

Onlem:

- Kritik islerde sync tamamlanmadan thread baslatilmaz.
- Watcher tabanli otomasyon MVP'de kullanilmaz.
- Create/update scriptleri manuel tetiklenir.

### Risk: Kullanicilar birbirinin dosyalarini gorur

Onlem:

- Ana klasor herkese acilmaz.
- Her kullaniciya sadece kendi alt klasoru paylasilir.
- Ortak dosyalar `shared` altinda tutulur.

### Risk: Ayni dosya ayni anda duzenlenir

Onlem:

- Agent ciktilari tarihli dosya adlariyla yazilir.
- Onayli ciktilar ayri dosya olarak saklanir.
- `DURUM.md` kisa ve kontrollu tutulur.

### Risk: Agent haftalik gorevi erken tamamlar

Onlem:

- Bir cikti dosyasinin olusmasi tek basina tamamlanma kaniti sayilmaz.
- Agent her gorev icin kullanicidan acik tamamlanma onayi ister.
- Haftalik plan ve web app checklist'i yalnizca bu onaydan sonra guncellenir.

---

## 16. MVP Disi Birakilanlar

Bu asamada bilerek yapilmayacaklar:

- Object storage
- Tam admin panel
- Drive API ile otomatik klasor olusturma
- Background watcher service
- Karmasik permission automation
- Kullanicilar arasi detayli audit log
- Realtime collaboration dashboard

Bunlar sistem gercek kullanimda deger urettikten sonra ele alinabilir.

---

## 17. Gelecekte Web App'e Evrim

MVP'de web app basit bir is takip sistemi olabilir:

```text
Fikir havuzu
Proje havuzu
Marketer devralma
Coder devralma
Durum checklist'i
Notlar
Drive linkleri
```

Sonraki fazlarda web app sunlari ustlenebilir:

- Google Drive API ile proje klasoru olusturma
- Google Picker ile dosya secme
- Proje checklist otomasyonu
- Agent surum takibi
- Kullanici bazli dashboard
- Object storage entegrasyonu
- Rapor preview
- Bildirimler
- Audit log

Bu nedenle bugunku klasor yapisi web app'e gecisi engellemeyecek sekilde tasarlanmistir.

---

## 18. Nihai MVP Karari

MVP icin secilen model:

```text
Runtime:
  Kullanicinin kendi bilgisayari + Codex App

Mobil erisim:
  ChatGPT mobile remote access

Dosya sistemi:
  Google Drive shared folders

Izolasyon:
  Kullanici bazli Drive klasorleri

Proje modeli:
  Her proje ayri klasor

Codex modeli:
  Her proje ayri Codex root ve ayri thread

Agent modeli:
  Her proje icine kopyalanmis .pa/agent paketi

Agent guncelleme:
  Merkezi release'ten update-all-agents script'i

Web app:
  Dosya depolamayan, sadece workflow + link/metadata tutan basit sistem
```

Bu model basit, uygulanabilir ve geri donusu olmayan bir yatirim gerektirmez. MVP basarili
olursa ayni kavramlar daha sonra web app, object storage, merkezi auth ve admin panel ile
genisletilebilir.
