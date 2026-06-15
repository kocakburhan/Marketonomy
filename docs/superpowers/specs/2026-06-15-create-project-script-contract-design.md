# Create Project Script Sozlesmesi Tasarimi

## Amac

Yeni marketing projesini Codex'in serbest bicimde dosya olusturmasi yerine deterministik,
dogrulanabilir ve teknik olmayan kullanicilar icin anlasilir bir PowerShell script'i ile
olusturmak.

## Sorumluluk Dagilimi

- Codex kullanicinin talebini anlar, proje adini alir ve `create-project.ps1` script'ini cagirir.
- Script tum on kontrolleri yapar ve MVP Bolum 4'te tanimlanan yapinin tamamini olusturur.
- Codex klasor ve dosyalari elle olusturmaz; script sonucunu kullaniciya aciklar.

## Guvenlik Kararlari

- Gecersiz proje adi icin guvenli bir klasor adi onerilir ve kullanici onayi alinir.
- Ayni isimde proje varsa hicbir dosyaya dokunulmaz ve kullanicidan yeni ad istenir.
- Agent release veya zorunlu sablonlar bulunamazsa proje olusturulmaz ve kullanici
  Yonetici Burhan Kocak ile iletisime gecmeye yonlendirilir.
- Proje gecici klasorde hazirlanir, eksiksizligi dogrulanir ve ancak sonra kalici konuma tasinir.
- Hata halinde gecici dosyalar temizlenir ve yarim proje birakilmaz.

## Baslangic Deneyimi

- Guncel ISO haftasi icin `YYYY-WNN.md` haftalik plan sablonu olusturulur.
- Sablon gorevlerle otomatik doldurulmaz.
- `DURUM.md` ve basari mesaji kullaniciyi once proje baglamini tamamlamaya, sonra agent ile
  haftalik plani hazirlamaya yonlendirir.

