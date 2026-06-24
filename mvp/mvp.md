# PersonalAutonomy MVP Mimarisi

Bu dokuman PersonalAutonomy ilk product fazinin baglayici mimari ve calisma sozlesmesidir.

## Post-MVP Appendix

## First Product Phase: Codex + Google Drive

PersonalAutonomy ilk product fazi, Codex App + Google Drive for desktop + onayli create/install/update scriptleriyle calisir.
Windows kullanicilari `.ps1`, macOS kullanicilari `.sh` scriptlerini kullanir.
Web app, PWA, Web Push, merkezi rol ekrani, web
tabanli workflow kaydi ve otomatik Drive operasyonlari post-MVP kapsamidir.

Aktif MVP'de:

- Kullanici bilgisayarinda Codex App kullanir.
- Dosyalar Google Drive for desktop ile senkronize edilen klasorlerde tutulur.
- Marketer'in ana calisma kok klasoru `Projects/` olur.
- `Projects/` yalnizca onboarding, Codex App plugin kurulumu, reusable marketer profili ve yeni
  proje olusturma icindir.
- Her is tek bir proje klasoru olarak olusturulur: `Projects/<proje-adi>/`.
- Her proje ayri Codex workspace ve ayri Codex thread olarak calisir.
- Fikir bulma ve fikir degerlendirme ayri workspace tipi degildir; proje klasoru icinde bir
  calisma modudur.
- Marketing Agent her proje workspace'ine `.pa/agent/` altinda surumlu olarak kurulur.
- Agent guncellemeleri proje-localdir ve kullanici onayi olmadan calismaz.

## Drive Ve Klasor Modeli

Marketer'in pratik dosya modeli:

```text
Projects/
  AGENTS.md
  onboarding-guide.md
  .pa/
    marketer-profile.md
    onboarding-install.json
    onboarding/
      scripts/
  .pa-create-work/
  .pa-script-logs/
  x-projesi/
  y-projesi/
```

`Projects/.pa/marketer-profile.md`, kullanicinin tekrar tekrar ayni bilgileri vermemesi icin
tutulan reusable marketer profilidir. Ana onboarding bu dosyayi olusturur veya gunceller.
`create-project.ps1`, dosya varsa yeni projenin `.pa/project/marketer-profile.md` yoluna kopyalar.
Profil sabit sorularla sinirli degildir. Kullanici gonullu olarak calisma bicimi, erisilebilirlik,
norocesitlilik veya isbirligini iyilestirecek baska bir baglam paylasirsa anlamini bozmadan
`Ek kullanici baglami` altinda saklanir. Agent hassas bilgi cikarsamaz ve teshis istemez.

`Projects/AGENTS.md`, ince onboarding bootstrap dosyasidir ve her oturumda
`Projects/onboarding-guide.md` dosyasini okutur. `onboarding-guide.md`, release icindeki canonical
`marketing-agent/agents/onboarding-guide.md` dosyasinin dogrulanmis kopyasidir.

`Projects/.pa/onboarding-install.json`, onboarding kaynaginin repo URL'sini, istenen surumu,
kurulu surumu ve update politikasini tutar. `.pa/onboarding/scripts/` salt-okunur update kontrolu
ve acik onayli onboarding update scriptlerini tutar.

`Projects/.pa-create-work/`, create scriptlerinin gecici hazirlama alanidir. Basarili dogrulamadan
sonra hedef proje klasoru yayinlanir; hata halinde yarim workspace birakilmaz.

`Projects/.pa-script-logs/`, sanitize edilmis teknik create/update loglari icindir. Kullanici
icerigi, gizli veri veya ham proje dosyalari bu loglara yazilmaz.

## Codex App Plugin Kurulumu

Onboarding agent ana `Projects` klasorunde kullaniciya su pluginleri elle kurdurur veya kontrol
ettirir:

1. Google Drive
2. Google Calendar
3. Gmail
4. Canva
5. Figma
6. GitHub

Belirsiz fikir, kampanya yonu, teklif, ozellik sekillendirme veya strateji konusmalari icin
Codex'te `brainstorming` skill'inin aktif olmasi onerilir.

## Proje Workspace Yapisi

Her proje bagimsiz bir Codex workspace olarak dusunulur:

```text
Projects/
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

    01-baglam/
      urun-baglami.md
      hedef-kitle.md
      marka.md
      kisitlar.md
      rakipler.md

    02-arastirma/
      fikir-degerlendirme/
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
      YYYY-WNN.md
      YYYY-WNN/
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
      saha/
      hibrit/

    07-lansman/
    08-raporlar/
      haftalik/
      pazarlama/
      analitik/
      yatirimci/
      finansal/
      pdf/
      excel/
    09-varliklar/
    10-final/
      prd/
      coder-briefleri/
      raporlar/
      yatirimci/
      lansman/
      dijital/
      saha/
      hibrit/
      linkler.md
    11-notlar/
      bilgi-haritasi/
        index.md
        log.md
        sayfalar/
    99-arsiv/

    .pa/
      project/
        state.json
        active-task.md
        marketer-profile.md
        settings.json
        overrides.md
        overrides-approved.md
      agent/
```

## Dosyalarin Gorevleri

`PROJE.md` projenin kimlik kartidir. `project_id`, `idea_id`, proje adi, fikir ozeti, hedef
kitle, ilk varsayimlar ve calisma baglami burada tutulur.

`DURUM.md` aktif pipeline, aktif is, bekleyen karar, haftalik plan ve sonraki adimi insan
tarafindan okunabilir bicimde tutar.

`KARARLAR.md` fikir degerlendirme sonucu, pivot, kapsam, kanal, fiyat, final onay ve durdurma
kararlarini gerekcesiyle tutar.

`.pa/project/state.json` makine-okunabilir state dosyasidir. `project_id` ve `idea_id`,
`PROJE.md` ile ayni olmalidir. Agent bu kimlikleri degistirmez.

`.pa/agent/` release paketidir. Kullanici verisi, kararlar, kaynaklar ve ciktilar buraya
yazilmaz.

## Fikir Degerlendirme Modeli

Fikir degerlendirme proje klasoru icinde yapilir. Kullanici `x-projesi` klasorunu actiginda ilk is
olarak fikri acimasizca degerlendirmek isteyebilir; bu durumda agent `idea-to-prd` akisini
proje ici fikir kapisi olarak calistirir.

Fikir degerlendirme ciktisinda en az:

- Kaynak ve Kanit Defteri
- Veri Isleme Notlari
- pazar/rakip/musteri kaniti
- kullanici pazarlama avantaji
- ilk 10-50 kullaniciya ulasma plani
- ilk dogrulama testi
- durdurma kosulu
- `Denenmeye Deger`, `Revizyonla Denenmeye Deger` veya `Denenmeye Degmez` onerisi

bulunur.

Bu modun ana yollari:

- `02-arastirma/fikir-degerlendirme/`
- `03-strateji/dogrulama/`
- `KARARLAR.md`
- `DURUM.md`
- `11-notlar/bilgi-haritasi/`

Fikir `Denenmeye Degmez` cikarsa proje klasoru silinmez. Karar ve gerekce kaydedilir; kullaniciya
revizyon, pivot, arsivleme veya baska proje yonu secenekleri sunulur.

## Proje Olusturma Akisi

Ana `Projects` klasorunde kullanici Codex'e yeni proje istedigini soyler:

```text
x isminde proje olustur.
```

Codex isletim sistemine uygun onayli create akisini kullanir: Windows'ta `create-project.ps1`,
macOS'ta `create-project.sh`. Script:

1. Hedef `Projects/x` klasorunun bos veya yeni olusturulabilir oldugunu dogrular.
2. `project_id` ve `idea_id` uretir veya verilen degerleri kullanir.
3. Proje klasor yapisini, `PROJE.md`, `DURUM.md`, `KARARLAR.md`, haftalik plan iskeletini ve
   `.pa/project/state.json` dosyasini olusturur.
4. `Projects/.pa/marketer-profile.md` varsa tum ek kullanici baglamiyla birlikte byte-for-byte
   `.pa/project/marketer-profile.md` yoluna kopyalar.
5. GitHub veya verilen kaynak agent paketinden `.pa/agent/` kurar.
6. `release-manifest.json` hashlerini dogrular.
7. Yarim kurulumda hedef klasoru temizler.
8. Kullaniciya projeye devam etmek icin `Projects/x` klasorunu Codex root olarak acmasini soyler.

## Installer Ve Update Siniri

Bos veya mevcut ana `Projects/` kokunun onboarding kurulumu:

```text
install-projects-root.ps1 / install-projects-root.sh
```

Bu installer proje workspace'ini reddeder; `Projects/AGENTS.md`, `onboarding-guide.md`,
`.pa/onboarding/` ve `.pa/onboarding-install.json` alanlarini yonetir. Mevcut
`.pa/marketer-profile.md` ve proje klasorlerini korur. Onboarding update kullanici onayi olmadan
calismaz.

`install-marketing-agent.ps1` ve `install-marketing-agent.sh` yalnizca gecerli proje workspace'ine kurulum yapar:

```text
PROJE.md + .pa/project/state.json
```

`update-agent.ps1 -Yes` ve `update-agent.sh --yes` yalnizca `.pa/agent/` paketini degistirir.
Kullanici onayi olmadan calismaz. Korunan alanlar:

- `PROJE.md`
- `DURUM.md`
- `KARARLAR.md`
- `.pa/project/`
- numbered project folders
- kaynaklar, notlar, haftalik planlar ve final ciktilar

## Haftalik Plan Ve Gorev Kapanisi

`create-project.ps1` guncel ISO haftasi icin bos bir plan ve gunluk schedule klasoru olusturur.
Ilk gercek gorevler kullanici ile birlikte belirlenir.

Workspace artifact'i gorevi acikca kanitliyorsa agent gorevi otomatik kapatir ve kullaniciyi
bilgilendirir. Harici aksiyonlar kullanici tamamladigini bildirene kadar
`Kullanici Bildirimi Bekliyor` durumunda kalir. Final yayin veya teslim her zaman acik kullanici
onayi ister.

## LLM-Wiki Output Memory

Proje hafizasi `11-notlar/bilgi-haritasi/` altinda tutulur. Bu katman ham dosyalarin yerine
gecmez; kaynaklar, kararlar, raporlar, celiskiler ve sonraki kullanim iliskileri icin harita
olusturur.

## Web App'in Post-MVP Rolu

### 10. Web App'in Post-MVP Rolu

Web app/PWA ilk product fazi icin runtime gereksinimi degildir. Ileriki fazda davet, rol,
uyelik, bildirim, merkezi proje durumu ve link kaydi icin tasarlanabilir.

### 11. Post-MVP Drive Link Modeli

Google Drive API, Google OAuth, Google Picker, otomatik klasor olusturma, dosya tasima, izin
yonetimi ve Drive link kaydi post-MVP konularidir. Aktif MVP'de Drive dosyalari kullanici ve
Google Drive for desktop tarafindan yonetilir.

### 12. Post-MVP Gunluk Kullanim Akislari

Project Pool, merkezi ekip uyeligi, coder katilimi, push bildirimleri, web tabanli aktivite
gecmisi ve otomatik workflow kaydi post-MVP tasarim notudur. Aktif MVP'de bu kararlar proje
dosyalari, kullanici onayi ve manuel Drive operasyonlariyla yurutulur.

## Nihai MVP Karari

PersonalAutonomy ilk product fazi, tek `Projects` kokunden yeni proje olusturan ve her projeyi
ayri Codex workspace/thread olarak calistiran workspace-first sistemdir. Fikir degerlendirme
kabiliyeti korunur, ancak ayri workspace tipi degildir. Tum uygulama, dokuman, script ve agent
davranisi bu karar ile uyumlu olmak zorundadir.
