# Proje Ozellestirme Yonetimi Tasarimi

## Amac

Proje ozel tercihlerini merkezi agent kurallarindan ve makine tarafindan yonetilen durum
dosyalarindan ayirarak agent davranisini ongorulebilir, kullanici onayli ve denetlenebilir
hale getirmek.

## Kararlar

- `overrides.md` zorunlu proje dosyasidir ve kullaniciya ait davranis tercihlerini tutar.
- Tercih degisikligi agent tarafindan ozetlenir ve acik kullanici onayindan sonra uygulanir.
- Onaylanan degisiklik tarih ve gerekceyle `KARARLAR.md` dosyasina kaydedilir.
- Kullanici dosyayi elle degistirebilir; agent hash degisikligini fark eder ve onay almadan
  yeni kurallari uygulamaz.
- Son onayli icerik `overrides-approved.md` dosyasinda tutulur; reddedilen manuel degisiklik
  bu kopyadan geri alinabilir.
- `state.json`, `active-task.md` ve `settings.json` agent/script tarafindan yonetilir.
- Proje gercekleri `PROJE.md` ve `01-baglam/` altinda tutulur; `overrides.md` icinde tekrar edilmez.
- Overrides; guvenlik, proje izolasyonu, kullanici onayi ve agent guncelleme kurallarini
  gecersiz kilamaz.

## Okuma ve Oncelik

Agent once sabit ve surumlu talimatlari, sonra proje gerceklerini ve kararlarini, ardindan
proje tercihlerini ve teknik ayarlari, en son operasyonel durumu okur. Anlik acik kullanici
talebi dosyalardaki proje tercihlerinden ustundur; guvenlik ve sistem sinirlari ise hicbir
proje tercihiyle degistirilemez.
