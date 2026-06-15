# Drive Link MVP Tasarimi

## Amac

Web app Drive API veya OAuth kullanmadan Google Drive baglantilarini guvenli bicimde kaydetsin,
proje aktivasyonunu kullanici onayli kurulum checklist'iyle yonetsin ve proje uyelerinin Drive
erisim durumunu web app uyeliginden ayri izlesin.

## Kararlar

- Web app yalnizca izin verilen Google Drive/Docs alan adlarini ve beklenen link turunu
  dogrular; linki sunucu tarafinda acip erisim testi yapmaz.
- Proje `Aktif` olmadan once `create-project.ps1` basarisi, Drive senkronizasyonu ve klasor
  linki ayri ayri onaylanir.
- Ortak degerlendirme klasoru tum kullanicilara Viewer; degerlendiren marketer'in alt klasoru
  kendisine Editor yetkisi verir.
- Proje ekip uyeleri proje klasorunde Editor olur. Bu yetkinin silme, tasima ve paylasma
  gucu verdigi kullaniciya acikca bildirilir.
- Yeni uye Drive erisimi dogrulanana kadar `Drive Erisimi Bekliyor` kalir.
- Ayrilan uyenin Drive erisiminin kaldirilmasi zorunlu manuel is olarak izlenir.
- Host marketer ayrilirsa host devir islemi tamamlanana kadar erisim uyarisi acik kalir.
- Google Picker OAuth gerektiren sonraki faz ozelligidir.

