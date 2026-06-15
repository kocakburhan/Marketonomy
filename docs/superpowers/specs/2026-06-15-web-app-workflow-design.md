# PersonalAutonomy Web App Workflow Tasarimi

## Amac

Google Drive'i ana proje dosya sistemi olarak korurken fikir degerlendirme, Project Pool,
ekip uyeligi, durum gecisleri, bildirimler ve gorunurlugu mobil oncelikli bir PWA uzerinden
yonetmek.

## Sistem Siniri

Google Drive PRD, arastirma, rapor, landing page, icerik, haftalik plan ve varliklarin ana
kaynagidir. Web app dosya depolamaz; kullanicilar, roller, fikirler, fikir surumleri,
degerlendirmeler, projeler, ekip uyelikleri, alan gecmisi, bildirimler, aktivite kayitlari,
arsiv kayitlari ve Drive baglantilarini saklar.

## Roller ve Gorunurluk

- Kullanici kayit sirasinda Marketer, Coder veya iki rolu birlikte secebilir.
- Yonetici rolu yalnizca Burhan Kocak hesabinda sabittir; secilemez veya devredilemez.
- Tum kullanicilar butun fikirleri, degerlendirmeleri, projeleri ve aktivite gecmisini gorur.
- Fikirleri Marketer rolundekiler ve yonetici degerlendirebilir.
- Project Pool alanlarini proje marketer'lari, coder'lari ve yonetici duzenleyebilir.
- Fikri ekleyen kisi proje ekibinde degilse proje icin salt okunur erisime sahiptir.

## Fikir ve Surum Akisi

- Her kullanici Idea Pool'a fikir ekleyebilir.
- Fikir sahibi, proje olusmadan once fikri duzenleyebilir.
- Project Pool kaydi olustuktan sonra fikir degisikligi yeni surum olarak saklanir.
- Her degerlendirme belirli fikir surumune baglanir.
- Fikir Project Pool'a gecince Idea Pool'da `Projeye Donustu` etiketi ve proje baglantisiyla
  gorunmeye devam eder.
- Normal kullanicilar fikirleri silemez; fikir sahibi veya yonetici arsivleyebilir.
- Arsivleme geri alinabilir; kalici silme yalnizca yoneticiye aittir.

## Marketer Degerlendirmeleri

- Sonuc `Denenmeye Deger` veya `Olumsuz` olur.
- Sonuc secimi gecerli degerlendirme icin yeterlidir; aciklama ve Drive raporu istege baglidir.
- Bir fikir icin birden fazla marketer bagimsiz degerlendirme yapabilir.
- Olumsuz degerlendirme fikri havuzdan kaldirmaz ve diger marketer'lari engellemez.
- Marketer'in ilk olumlu degerlendirmesi tek bir Project Pool kaydi olusturur ve marketer'i
  esit yetkili proje uyesi yapar.
- Sonraki olumlu marketer degerlendirmeleri yeni proje olusturmaz; degerlendiren marketer'i
  mevcut projeye esit yetkili uye olarak ekler.
- Marketer olumlu sonucunu olumsuza cevirirse ekipten otomatik ayrilir; gecmis ve ciktilar
  korunur.
- Marketer, olumlu degerlendirmesi surerken projeden ayri bir islemle ayrilamaz.
- Degerlendirme degisikligi onceki karari silmez; surumlu gecmiste korunur.
- Tum raporlar esit kayittir; hicbiri otomatik ana rapor olmaz.

Yonetici `Denenmeye Deger` sonucu verebilir. Bu sonuc Project Pool kaydi olusturur ancak
yoneticiyi marketer yapmaz. Proje `Marketer Bekliyor` durumunda kalir. Ilk olumlu marketer
degerlendirmesi marketer'i projeye ekler ve Drive kurulumunu baslatir.

## Project Pool ve Uyelikler

- Bir projede birden fazla esit yetkili marketer ve coder bulunabilir.
- Coder projeye dogrudan katilabilir.
- Yeni uye katilimi gecmise yazilir ve tum kullanicilara bildirilir.
- Coder kendi istegiyle ayrilabilir; ciktilari ve aktivite gecmisi korunur.
- Olumlu marketer degerlendirmesi kalmazsa proje `Yeniden Degerlendiriliyor` olur.
- Yeniden degerlendirilen projeye uyaridan sonra yeni marketer veya coder katilabilir.
- Projeyi proje ekibi veya yonetici arsivleyebilir.
- Arsivleme geri alinabilir; kalici silme yalnizca yoneticiye aittir.

## Drive Modeli

- Degerlendirme raporlari istege bagli olarak
  `shared/idea-evaluations/<fikir-id>/` altinda tutulur ve herkes okuyabilir.
- Proje klasoru ilk marketer'in kisisel Drive alaninda yer alir.
- Diger proje uyelerine yalnizca ilgili proje klasoru paylasilir.
- Web app Google Drive API ile proje klasoru olusturmaz.
- Ilk olumlu marketer degerlendirmesinden sonra proje `Drive Kurulumu Bekliyor` olur.
- Marketer yerel bilgisayarinda Codex araciligiyla `create-project.ps1` calistirir.
- Yerel proje klasoru Google Drive Desktop tarafindan Drive'a senkronize edilir.
- Marketer Drive klasor baglantisini web app'e ekler; proje bundan sonra aktif calisma
  durumuna gecebilir.
- Web app ve Drive arasinda otomatik cift yonlu dosya senkronizasyonu yoktur.

## Durum Makinesi

Fikir durumlari:

```text
Havuzda
Projeye Donustu
Arsivlendi
```

Proje durumlari:

```text
Marketer Bekliyor
Drive Kurulumu Bekliyor
Aktif
Yeniden Degerlendiriliyor
Coding Asamasinda
Lansman Hazirliginda
Yayinda
Duraklatildi
Arsivlendi
```

Temel gecisler:

- Olumlu marketer degerlendirmesi: `Havuzda -> Projeye Donustu -> Drive Kurulumu Bekliyor`
- Olumlu yonetici degerlendirmesi: `Havuzda -> Projeye Donustu -> Marketer Bekliyor`
- Ilk marketer katilimi: `Marketer Bekliyor -> Drive Kurulumu Bekliyor`
- Drive baglantisi: `Drive Kurulumu Bekliyor -> Aktif`
- Coder katilimi: uygun calisma durumundan `Coding Asamasinda`
- Olumlu marketer kalmamasi: `Yeniden Degerlendiriliyor`
- Yeni olumlu marketer: Drive varsa onceki calisma durumu; yoksa `Drive Kurulumu Bekliyor`
- Arsivleme: onceki durum saklanarak `Arsivlendi`
- Arsivden cikarma: onceki gecerli duruma donus

Ayni fikir icin birden fazla Project Pool kaydi olusmasi veritabani benzersizlik kurali ve
transaction ile engellenir. Durum gecisi, degerlendirme ve otomatik uyelik tek transaction
icinde tamamlanir; hata halinde hicbiri yarim birakilmaz.

## Project Pool Alanlari

```text
Proje adi
Bagli fikir ve fikir surumu
Kisa aciklama
Marketer'lar
Coder'lar
Proje durumu
Oncelik
Sonraki adim
Aktif haftalik ilerleme ozeti
Notlar
Drive klasor baglantisi
PRD baglantisi
Analiz baglantilari
Landing page baglantisi
Rapor baglantilari
Olusturulma ve son guncellenme zamani
```

- Haftalik gorevlerin ana kaynagi Drive'daki haftalik plan dosyasidir.
- Web app yalnizca aktif haftanin ozetini ve baglantisini gosterir.
- Alan bazinda son kayit kazanir; bir alandaki degisiklik diger alanlarda ayni anda yapilan
  degisiklikleri ezmez.
- Her alan degisikligi eski deger, yeni deger, kullanici ve zamanla gecmise yazilir.
- Yetkili kullanici eski degeri geri yukleyebilir; geri yukleme de yeni degisikliktir.
- Drive ve web app durumu celisirse sistem sessizce duzeltmez; proje ekibine uyari verir.
- Drive URL'leri bicim ve erisilebilirlik acisindan dogrulanir.

## PWA ve Bildirimler

Web app mobil oncelikli, ana ekrana eklenebilir bir PWA'dir. Service worker ve Web Push
kullanir. E-posta bildirimi MVP kapsaminda degildir.

Tum kullanicilara push ve uygulama ici bildirim gonderilen olaylar:

- yeni fikir ve yeni fikir surumu
- yeni degerlendirme ve degerlendirme degisikligi
- fikrin Project Pool'a gecmesi
- proje durum degisikligi
- marketer veya coder katilimi/ayrilmasi
- Drive klasor baglantisinin eklenmesi
- fikir/proje arsivleme veya geri alma
- kullanicidan onay ya da islem beklenmesi

Kullanici kendi yaptigi islem icin push almaz; olay aktivite akiminda gorunur. Bildirime
dokunuldugunda ilgili kayit acilir. Okundu/okunmadi durumu kullanici bazinda tutulur. Ayni olay
icin yinelenen bildirimler idempotency anahtariyla engellenir. Push desteklemeyen veya izin
vermeyen kullanici olaylari uygulama ici bildirim merkezinden gorur.

## Aktivite, Arsiv ve Yonetim Kayitlari

Her onemli olay kim, ne yapti ve ne zaman bilgisiyle herkesce gorulebilen aktivite akimina
yazilir. Alan degisiklik gecmisi geri alinabilir. Rol degisikligi, kalici silme ve kritik
yonetici islemleri ayri yonetim kaydina yazilir. Kalici silme yalnizca Burhan Kocak hesabina
aittir.

## Hata ve Cakisma Yonetimi

- Eslestirilmis durum gecisleri transaction icinde yapilir.
- Alan guncellemelerinde son kayit kazanir; tum ara degerler gecmiste korunur.
- Ayni fikir icin tek proje zorunlulugu veritabani seviyesinde uygulanir.
- Yetkisiz degisiklik reddedilir ve kullaniciya anlasilir mesaj gosterilir.
- Push teslim hatasi ana islemi geri almaz; bildirim yeniden deneme kuyruguna girer.
- Drive linki gecersizse proje verisi kaybolmaz; baglanti kaydedilmez ve duzeltme istenir.
- Arsivlenmis kayitlarda normal duzenleme ve yeni uyelik engellenir; once arsivden cikarma gerekir.

## MVP Disi

- E-posta bildirimleri
- Web app icinde dosya depolama
- Google Drive API ile otomatik proje klasoru olusturma
- Drive ile otomatik cift yonlu dosya senkronizasyonu
- Gercek zamanli ortak metin editoru
- Performans puani veya calisan siralamasi
