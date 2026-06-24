# PersonalAutonomy Marketing Agent Kullanim Rehberi

Bu rehber Marketing Agent'i kullanacak marketer'lar icindir. Teknik detaylari bilmeniz gerekmez;
dogru klasoru acmaniz ve agent'a ne istediginizi net soylemeniz yeterlidir.

## Kisa Ozet

PersonalAutonomy Marketing Agent, Codex App icinde calisan bir pazarlama calisma arkadasidir.
Fikirleri gercekci sekilde degerlendirir, pazar ve rakip arastirmasi yapar, PRD ve coder brief
hazirlar, kampanya ve satis materyali uretir, haftalik plan cikarir ve ciktıları proje
klasorunuzde dogru yere dosyalar.

## Klasor Mantigi

Ana model artik basittir:

```text
Projects/
  AGENTS.md
  onboarding-guide.md
  .pa/
    marketer-profile.md
    onboarding-install.json
    onboarding/
      scripts/
  x-projesi/
  y-projesi/
```

`Projects/` ana klasoru yalnizca:

- ilk onboarding
- Codex App plugin kurulumu
- kullanici/marketer profilini toplama
- yeni proje klasoru olusturma

icin kullanilir.

Gercek calisma her zaman proje klasorunde yapilir:

```text
Projects/x-projesi/
```

Her proje ayri Codex workspace ve ayri Codex thread olarak acilir. Bir projenin dosyalari baska
bir projenin dosyalariyla karistirilmaz.

## Codex App Plugin Kurulumu

Marketer'lar Codex App'i actiklarinda karar verilen pluginleri Codex App uzerinden elle
kurmalidir. Kurulacak pluginler:

1. Google Drive
2. Google Calendar
3. Gmail
4. Canva
5. Figma
6. GitHub

Daha iyi fikir gelistirme, kampanya yonu secme, teklif veya ozellik sekillendirme ve belirsiz
strateji konusmalari icin Codex'te `brainstorming` skill'inin kurulu ve aktif olmasi onerilir.

## Ilk Kullanim

1. Codex'te ana `Projects/` klasorunu acin.
2. Resmi Projects root installer `AGENTS.md` ve `onboarding-guide.md` dosyalarini kursun.
3. Onboarding agent sizi tanisin ve `.pa/marketer-profile.md` profilini olustursun.
4. Plugin checklist'ini tamamlayin.
5. Yeni proje icin Codex'e soyleyin:

```text
x isminde proje olustur.
```

Codex isletim sisteminize uygun onayli scripti calistirir ve `Projects/x` klasorunu olusturur.
Windows'ta `.ps1`, macOS'ta `.sh` scriptleri kullanilir. Sonra size sunu soyler:

```text
Projeye devam etmek icin Codex'te Projects/x klasorunu ac ve yeni bir Codex oturumu baslat.
```

## Proje Klasorunde Calisma

Proje klasorunu actiginizda sunlardan birini isteyebilirsiniz:

- Fikrim var, once gercekci sekilde degerlendir.
- Fikrim yok, veri ve rakip bosluklarindan firsat bul.
- Proje baglamini tamamlayalim.
- PRD hazirla.
- Coder brief hazirla.
- Pazar/rakip/musteri arastirmasi yap.
- Landing page, e-posta, sosyal medya veya reklam metni uret.
- B2B satis, outbound, demo veya teklif plani hazirla.
- Haftalik calisma planini hazirla.
- Yatirimci dokumanlari veya data room hazirligi yap.

## Fikir Degerlendirme

Fikir degerlendirme ayri klasor degildir. Proje klasorunun icinde yapilir. Agent fikri
desteklemek zorunda degildir; pazar, rakip, musteri, maliyet, dagitim, sizin avantajiniz ve
uygulanabilirlik acisindan acimasizca tartar.

Fikir degerlendirme dosyalari genelde buralara yazilir:

- `02-arastirma/fikir-degerlendirme/`
- `03-strateji/dogrulama/`
- `KARARLAR.md`
- `DURUM.md`

Fikir `Denenmeye Degmez` cikarsa proje klasoru silinmez. Gerekce kaydedilir; revizyon, pivot,
arsivleme veya baska proje yonu secilebilir.

## En Onemli Klasorler

```text
00-gelen-kutusu/        Sizden gelen ham fikir, not, link ve yuklemeler
01-baglam/              Urun, hedef kitle, marka, kisit ve rakip baglami
02-arastirma/           Pazar, rakip, musteri, trend ve fikir degerlendirme
03-strateji/            Dogrulama, konumlandirma, fiyat, pazara giris, buyume
04-urun/                MVP, PRD, coder brief, urun kararlari
05-haftalik-planlar/    Haftalik ve gunluk is plani
06-pazarlama-uygulamalari/ Dijital, saha ve hibrit uygulama dosyalari
08-raporlar/            Haftalik, pazarlama, analitik, yatirimci ve finansal raporlar
10-final/               Sadece sizin onayladiginiz final teslimler
11-notlar/              Notlar ve bilgi-haritasi
```

## Gorev Kapanisi

Bir gorevin tamamlandigi uretilen dosya veya guncellenen dokumanla acikca kanitlaniyorsa agent
gorevi kapatabilir ve size bilgi verir. Harici aksiyonlar, ornegin gorusme yapmak, teklif
gondermek veya saha ziyareti tamamlamak, siz tamamladiginizi soyleyene kadar acik kalir. Final
yayin veya teslim her zaman acik onay ister.

## Iyi Baslangic Promptlari

Yeni proje klasorunde:

```text
Bu proje workspace'ini incele. PROJE.md, DURUM.md, KARARLAR.md ve 01-baglam klasorunu oku.
Once fikri mi degerlendirecegiz, proje baglamini mi tamamlayacagiz, yoksa direkt bir cikti mi
uretecegiz bana sor.
```

Fikir degerlendirme:

```text
Bu fikri denemeye deger mi diye degerlendir. Beni memnun etmeye calisma; gercekci, kanitli ve
pragmatik ol. Eksik bilgileri sor, arastirma yap, riskleri yaz ve onerini 03-strateji/dogrulama
altinda topla.
```

Haftalik plan:

```text
Bu hafta icin gercekci bir pazarlama calisma plani hazirlayalim. Mevcut DURUM.md, PROJE.md ve
gecen haftanin planini oku. Sonra bana bu hafta icin en onemli hedefleri sor.
```

Finale alma:

```text
Bu ciktiyi onayliyorum. Kaynak dosyayi koru, final kopyasini 10-final altinda dogru klasore al
ve DURUM.md dosyasinda bu teslimi belirt.
```

## Sifirdan Kurulum: Projects Klasorunu Actiktan Sonra

Bu bolum, kullanicinin kendi bilgisayarinda PersonalAutonomy Marketing Agent'i ilk kez kurarken
izleyecegi pratik akistir.

### 1. Ana Projects klasorunu hazirlayin

Bilgisayarinizda veya Google Drive ile senkronize edilen alanda bir ana klasor olusturun:

```text
Projects/
```

Bu klasor sizin ana kontrol merkezinizdir. Gercek proje dosyalari daha sonra bu klasorun altinda
olusturulur:

```text
Projects/x-projesi/
```

Ana `Projects/` klasorunde PRD, kampanya, rapor veya proje ciktisi uretilmez. Burada yalnizca
kurulum, onboarding, profil toplama ve yeni proje olusturma yapilir.

### 2. Codex App'te Projects klasorunu acin

Codex App'i acin ve workspace/root olarak ana `Projects/` klasorunu secin.

Dogru:

```text
Projects/
```

Yanlis:

```text
Belgeler/
Masaustu/
Projects/x-projesi/
```

Ilk kurulumda proje klasorunu degil, ana `Projects/` klasorunu acmalisiniz. Proje klasorune daha
sonra gececeksiniz.

### 3. GitHub repo linkini kopyalayin

Size verilen resmi PersonalAutonomy Marketing Agent GitHub reposunu tarayicida acin.

GitHub'da:

1. Repo sayfasinda yesil `Code` butonuna tiklayin.
2. `HTTPS` sekmesini secin.
3. Linki kopyalayin.

Link su formata benzer:

```text
https://github.com/<OWNER>/<REPO>.git
```

Bu rehberde bu linki `<GITHUB_REPO_URL>` olarak gosteriyoruz.

### 4. Codex'e kurulum promptunu verin

Ana `Projects/` klasoru Codex'te acikken Codex'e su promptu verin. `<GITHUB_REPO_URL>` yerine
GitHub'dan kopyaladiginiz linki yapistirin:

```text
Bu klasor benim PersonalAutonomy ana Projects klasorum.

Su resmi GitHub reposundaki PersonalAutonomy Marketing Agent kurulum ve proje olusturma sistemini
bu Projects klasoru icin hazirla:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Once Windows'ta scripts/install-projects-root.ps1, macOS'ta
scripts/install-projects-root.sh ile ana Projects onboarding kokunu v5.5.0 surumunden kur.
Kurulumdan sonra Projects/AGENTS.md ve Projects/onboarding-guide.md dosyalarini oku.

Once bu ana Projects klasorunde onboarding akisini baslat:
1. Codex App plugin checklist'ini bana yaptir.
2. Benden reusable marketer profilimi topla ve .pa/marketer-profile.md olarak kaydet. Standart
   sorular disinda gonullu paylastigim ek bilgileri `Ek kullanici baglami` altinda koru.
3. Bundan sonra yeni proje istedigimde Windows'ta create-project.ps1, macOS'ta create-project.sh
   akisini kullanarak Projects/<proje-adi> klasorunu olustur.

Yeni proje olustururken `.pa/onboarding-install.json` icindeki repo URL'sini ve v5.5.0 surumunu
kullan.
Olusan proje klasorune Marketing Agent paketini kur, release-manifest.json
dogrulamasini yap ve mevcut dosyalarimi silme.
```

### 5. Plugin checklist'ini tamamlayin

Codex onboarding sirasinda sizden Codex App pluginlerini kontrol etmenizi ister. Kurulacak
pluginler:

1. Google Drive
2. Google Calendar
3. Gmail
4. Canva
5. Figma
6. GitHub

Bu pluginleri Codex App icinden elle kurun. Plugin kurulumu tamamlanmadan da bazi isler
yapilabilir, ama sistemden tam verim almak icin bu listeyi tamamlamak daha dogrudur.

Belirsiz fikir, kampanya yonu, teklif veya strateji konusmalari icin `brainstorming` skill'i de
aktifse kullanilabilir.

### 6. Marketer profilinizi doldurun

Codex size kisa bir profil formu sorar. Bu profil her yeni projede tekrar tekrar ayni bilgileri
anlatmamaniz icin kullanilir.

Tipik olarak sunlari sorar:

- yasadiginiz sehir/ulke veya calisma lokasyonunuz
- mesleginiz veya ana isiniz
- uzmanlik alanlariniz
- marketing, satis, is gelistirme, icerik, topluluk veya saha tecrubeniz
- mevcut network, kitle, musteri erisimi veya kanallariniz
- haftalik zaman ve yaklasik butce araliginiz

Bilmediginiz veya paylasmak istemediginiz alanlara `belirtmek istemiyorum` yazabilirsiniz.

Profil kaydedildikten sonra ana `Projects/` klasorunde su dosya olusur:

```text
Projects/.pa/marketer-profile.md
```

### 7. Ilk projenizi olusturun

Profil tamamlandiktan sonra Codex'e yeni proje olusturmasini soyleyin:

```text
x-projesi isminde yeni proje olustur.
```

Ya da daha acik yazmak isterseniz:

```text
Bu Projects klasorunun altinda x-projesi isminde yeni bir PersonalAutonomy proje workspace'i
olustur. Windows'ta resmi create-project.ps1 akisini, macOS'ta create-project.sh akisini kullan.
GitHub repo kaynagi olarak daha once verdigim repo URL'sini ve latest surumu kullan. Proje
olusunca bana hangi klasoru Codex'te acmam gerektigini soyle.
```

Codex bu adimda scripti calistirir. Script sunlari yapar:

- `Projects/x-projesi/` klasorunu olusturur.
- `PROJE.md`, `DURUM.md`, `KARARLAR.md` dosyalarini olusturur.
- proje klasor yapisini kurar.
- ana profili projeye kopyalar.
- `.pa/agent/` altina Marketing Agent paketini kurar.
- release manifest hashlerini dogrular.
- baslangic haftalik plan iskeletini olusturur.

### 8. Proje klasorunu yeni Codex workspace olarak acin

Proje olustuktan sonra ana `Projects/` klasorunde calismaya devam etmeyin.

Codex'in soylemesi gereken yonlendirme sudur:

```text
Projeye devam etmek icin Codex'te Projects/x-projesi klasorunu ac ve yeni bir Codex oturumu baslat.
```

Siz de Codex App'te yeni workspace/root olarak su klasoru acin:

```text
Projects/x-projesi/
```

Bu proje icin yeni bir Codex thread baslatin. Bundan sonra fikir degerlendirme, arastirma, PRD,
kampanya, satis, haftalik plan ve diger tum isler bu klasorde yapilir.

### 9. Proje klasorunde ilk mesaji verin

Yeni proje klasorunu actiktan sonra Codex'e sunu yazabilirsiniz:

```text
Bu proje workspace'ini incele. PROJE.md, DURUM.md, KARARLAR.md ve 01-baglam klasorunu oku.
Once fikri mi degerlendirecegiz, proje baglamini mi tamamlayacagiz, yoksa direkt bir cikti mi
uretecegiz bana sor.
```

Eger hazir fikriniz varsa:

```text
Bu fikri denemeye deger mi diye degerlendir. Beni memnun etmeye calisma; gercekci, kanitli ve
pragmatik ol. Eksik bilgileri sor, arastirma yap, riskleri yaz ve onerini proje icinde
03-strateji/dogrulama altinda topla.
```

Eger henuz fikriniz yoksa:

```text
Henuz net fikrim yok. Benim profilime, sehir/network avantajima, zamanima ve butceme gore veri,
sikayet, trend ve rakip bosluklarindan denenebilir fikirler bul.
```

### 10. Sonraki projelerde ayni kurulumu tekrar yapmayin

Ana `Projects/` klasorunde profiliniz zaten varsa, yeni proje icin bastan kendinizi anlatmaniz
gerekmez. Sadece ana `Projects/` klasorunu Codex'te acip sunu soyleyin:

```text
y-projesi isminde yeni proje olustur.
```

Codex mevcut `Projects/.pa/marketer-profile.md` dosyasini yeni projeye kopyalar ve proje
klasorunu hazirlar.

### 11. Sorun olursa ne yapmali?

Kurulum veya proje olusturma sirasinda hata olursa ayni komutu tekrar tekrar denemeyin. Codex'ten
kisa hata ozeti isteyin:

```text
Bu kurulum hatasini kisa ve teknik olmayan sekilde ozetle. Hangi adimda kaldik, hangi dosya veya
izin eksik, Burhan Kocak'a ne iletmem gerekiyor yaz.
```

Ozellikle su durumlar hata sebebi olabilir:

- GitHub repo linki yanlis kopyalanmistir.
- Git bilgisayarda kurulu degildir veya PATH uzerinde degildir.
- Google Drive klasoru henuz senkronize olmamistir.
- Hedef proje klasoru bos degildir.
- Codex yanlis klasorde acilmistir.
- Manifest dogrulamasi basarisiz olmustur.
