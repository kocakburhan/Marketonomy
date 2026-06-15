# PersonalAutonomy MVP Tutarlilik Denetimi Tasarimi

## Amac

`mvp/mvp.md` dosyasini tek ve baglayici MVP spesifikasyonu olarak korurken klasor modeli,
Codex izolasyonu, Marketing Agent dagitimi, web app workflow'u, Google Drive erisimi, roller,
bildirimler ve haftalik operasyon akislari arasindaki celiski ve belirsizlikleri kaldirmak.

## Yaklasim

Mevcut 13 bolum korunacak. Yalnizca gorunen hatalari yamamak veya konulari ayri MVP
dokumanlarina bolmek yerine, tum bolumler ayni kimlik, rol, klasor, durum ve veri sahipligi
modeline gore birlikte duzeltilecek.

## Kullanici ve Rol Modeli

- Sistem acik kayit kabul etmeyecek; yalnizca Burhan Kocak tarafindan davet edilen e-posta
  adresleri kaydolabilecek.
- Davet, kullanicinin secebilecegi `Marketer`, `Coder` veya iki rolu birlikte sinirlayacak.
- Yonetici rolu yalnizca sunucu tarafinda sabitlenen Burhan Kocak hesabinda bulunacak.
- Kullanici rollerini daha sonra yalnizca yonetici degistirebilecek.
- Aktif olumlu degerlendirmesi veya Drive host sorumlulugu bulunan marketer'in rolu,
  sorumluluklari devredilmeden kaldirilamayacak.
- Kisisel Google Drive calisma alani yalnizca marketer'larda bulunacak.
- Yalnizca Coder rolundeki kullaniciya kisisel Drive klasoru acilmayacak; coder sadece
  katildigi proje klasorlerine erisecek.

## Google Drive Klasor Modeli

```text
PersonalAutonomy/
  shared/
    agent-releases/
    tools/
      create-evaluation.ps1
      create-project.ps1
      update-all-agents.ps1
    templates/
    logs/

  marketers/
    <kullanici>/
      idea-workspace/
        <fikir-id>-<kisa-baslik>/
      projects/
        <proje-klasoru>/
```

- `shared/logs/` yalnizca Burhan Kocak tarafindan okunabilir ve yazilabilir olacak.
- Kullanilmayan `update-project-agent.ps1` yapidan kaldirilacak.
- `shared/idea-evaluations/` kaldirilacak.
- Marketer'lar yalnizca kendi kullanici klasorlerini gorecek.
- Proje klasoru, proje uyelerine tek tek paylasilacak; tum `marketers/` alani acilmayacak.

## Fikir Degerlendirme Workspace'i

- Her marketer bir fikri Marketing Agent ile incelemeden once kendi alaninda ayri bir
  degerlendirme workspace'i olusturacak.
- Workspace yolu `idea-workspace/<fikir-id>-<kisa-baslik>/` olacak.
- Her degerlendirme workspace'i ayri Codex root ve ayri Codex thread olarak kullanilacak.
- `create-evaluation.ps1`; fikir ID'sini ve kisa basligi alacak, guvenli klasor adini uretecek,
  degerlendirme sablonlarini, durum dosyalarini ve bagimsiz `.pa/agent` paketini kuracak.
- Ayni marketer ve fikir ID'si icin ikinci workspace olusturulmayacak; mevcut klasore
  yonlendirme yapilacak.
- Ham notlar ve calisma dosyalari marketer'in kisisel workspace'inde kalacak.
- Web app yalnizca degerlendirme sonucunu, istege bagli aciklamayi ve rapor linkini saklayacak.
- Marketer Drive raporu yayimlamak isterse dosyayi sistem kullanicilarina Viewer olarak
  paylasacak ve linkini degerlendirmeye ekleyecek.

## Fikirden Projeye Gecis

- `Denenmeye Deger` ve `Olumsuz` degerlendirmelerini marketer veya yonetici yapabilecek.
- Yonetici degerlendirmesi gorus kaydidir; tek basina Project Pool kaydi olusturmayacak.
- Yalnizca marketer'in `Denenmeye Deger` karari fikri Project Pool'a gecirecek.
- Olumlu marketer tek transaction icinde projeye esit yetkili marketer olarak eklenecek.
- Ayni fikir icin sonraki olumlu marketer'lar mevcut projeye katilacak; ikinci proje
  olusturulmayacak.
- `Marketer Bekliyor` proje durumu kaldirilacak; Project Pool'daki her projede en az bir olumlu
  marketer bulunacak.

## Proje Klasoru ve Kimlik Baglantisi

- Ilk olumlu marketer otomatik olarak `Drive host marketer` olacak.
- Proje klasorunu yalnizca Drive host marketer olusturabilecek.
- `create-project.ps1`; degismez `project_id`, bagli `idea_id` ve proje adini parametre olarak
  alacak.
- Script bu kimlikleri `.pa/project/state.json` ve gerekli insan-okunabilir proje dosyalarina
  yazacak.
- Ayni `project_id` ile daha once olusturulmus klasor varsa ikinci klasor olusturulmayacak;
  kullanici mevcut klasore yonlendirilecek.
- Proje ancak script basarisi, Drive senkronizasyonu ve canonical Drive klasor linki
  checklist'i tamamlaninca `Aktif` olacak.

## Drive Host ve Uyelik

- Drive host rolu, marketer'in degerlendirme sonucundan ayri bir operasyonel sorumluluk olacak.
- Host marketer olumlu kararini degistirse bile acik devir tamamlanana kadar Drive host olarak
  kalacak.
- Host devrini mevcut host veya Burhan Kocak baslatabilecek; yeni host aktif marketer olmak
  zorunda olacak.
- Coder ve ek marketer'lar web app uyeligiyle otomatik Drive erisimi kazanmayacak.
- Drive paylasimi ve erisim kaldirma islemleri host marketer veya sistem sahibi tarafindan
  manuel yapilacak.

## Olumlu Marketer Kalmamasi

- Son olumlu marketer da degerlendirmesini `Olumsuz` yaparsa proje silinmeyecek.
- Proje `Yeniden Degerlendiriliyor` durumuna gececek ve web app'te dondurulacak.
- Dondurulmus projede yeni coder katilimi, normal alan duzenleme ve ileri durum gecisleri
  engellenecek.
- Proje, dosyalar ve gecmis tum kullanicilar tarafindan okunmaya devam edecek.
- Drive klasoru eski host marketer'da ve mevcut izinleriyle kalacak; web app Drive'in salt
  okunur oldugunu varsaymayacak.
- Yeni bir marketer `Denenmeye Deger` dediginde projeye katilacak ve Drive kurulum durumuna
  gore proje yeniden etkinlesecek.

## Bildirim Modeli

- MVP'de tanimlanan kritik workflow olaylari tum kullanicilara Web Push ve uygulama ici
  bildirim olarak gonderilecek.
- Islemi yapan kullanici da bildirimi alacak; actor istisnasi uygulanmayacak.
- Push izni olmayan veya desteklenmeyen cihazlar olaylari bildirim merkezinde gorecek.
- Push teslim hatasi ana islemi geri almayacak.

## Agent Guncelleme Modeli

- `update-all-agents.ps1` hem `projects/*/.pa/agent` hem de
  `idea-workspace/*/.pa/agent` paketlerini tarayacak.
- Her iki workspace turu ayni release dogrulama, SHA-256, backup, atomik degisim ve rollback
  kurallarina tabi olacak.
- Proje ve degerlendirme verileri guncelleme kapsami disinda kalacak.

## Haftalik Plan Modeli

- `create-project.ps1` guncel ISO haftasi icin bos plan sablonu olusturacak.
- Proje hafta ortasinda aktif olursa ilk plan aktivasyondan sonra kalan gunler icin hemen
  marketer ve agent tarafindan birlikte doldurulacak.
- Sonraki haftalarin plani her Pazartesi hazirlanacak.
- Script kullanici adina baslangic gorevleri yazmayacak.
- Bir gorev yalnizca kullanicinin acik tamamlanma onayiyla tamamlanacak.

## Veri Sahipligi

- Web app workflow, rol, uyelik, durum, checklist, link, bildirim ve gecmis verisinin ana
  kaynagi olacak.
- Google Drive gercek degerlendirme ve proje dosyalarinin ana kaynagi olacak.
- Web app Drive dosyalarini okumayacak, tasimayacak, silmeyecek veya izinlerini otomatik
  degistirmeyecek.
- Drive ile web app celisirse sistem otomatik varsayim yapmayacak; uyari ve acik kullanici
  onayi isteyecek.

## MVP Dosyasinda Yapilacak Duzeltmeler

- Giris ve temel bilesenler davetli kullanici, marketer-only kisisel Drive alani ve coder erisim
  modelini aciklayacak.
- Bolum 2-3 yeni `idea-workspace/`, tools ve logs yapisiyla guncellenecek.
- Bolum 4 degerlendirme workspace'i ile proje workspace'inin farkini netlestirecek.
- Bolum 5 Codex root kurallarini iki workspace turu icin tanimlayacak.
- Bolum 6 `create-evaluation.ps1` ve kimlik baglantili `create-project.ps1` akislarini kapsayacak.
- Bolum 7-8 her iki workspace turunun agent dagitim ve guncelleme modelini kapsayacak.
- Bolum 9 dosya sahipligi ve talimat onceligini workspace turlerine gore netlestirecek.
- Bolum 10 davet, rol yonetimi, yonetici degerlendirmesi, durum makinesi, dondurma ve bildirim
  kararlarini uygulayacak.
- Bolum 11 ortak rapor klasorunu kaldiracak; rapor paylasimi ve Drive host devrini duzeltecek.
- Bolum 12 gunluk kullanim akislarini yeni degerlendirme ve proje olusturma sirasiyla yazacak.
- Bolum 13 tum kararlarla ayni nihai modeli ozetleyecek.

## Kabul Kriterleri

- Ana bolumler 1-13 olarak sirali ve benzersiz kalmali.
- `Marketer Bekliyor`, `shared/idea-evaluations/`, `update-project-agent.ps1` ve actor push
  istisnasi dosyada kalmamali.
- Coder icin kisisel Drive klasoru oldugunu ima eden ifade bulunmamali.
- Yonetici degerlendirmesinin proje olusturmadigi acik olmali.
- `create-evaluation.ps1`, `project_id`, `idea_id`, Drive host ve dondurma kurallari ilgili tum
  bolumlerde ayni anlamda kullanilmali.
- Durum gecisleri, gunluk akislar ve nihai karar birbiriyle uyumlu olmali.
- Markdown code fence'leri dengeli, bolum referanslari gecerli ve `git diff --check` temiz olmali.
