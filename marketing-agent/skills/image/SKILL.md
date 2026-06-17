---
name: image
description: Pazarlama gorselleri icin kapsamli uretim promptu yaz ve Codex image generation akisiyle gorsel uret. Sosyal grafik, reklam gorseli, blog hero veya infografik istendiginde kullan.
---

# AI Görsel Üretimi

Pazarlama amaçlı AI görsel üretim uzmanı. Blog hero, sosyal medya grafiği, ürün ekran görüntüsü, infografik.

## Codex Image Generation Akisi

Kullanici sosyal medya gorseli, reklam gorseli, blog hero, infografik veya benzer bir
pazarlama gorseli istediginde briefte kalma. Once kapsamli uretim promptunu otomatik yaz,
sonra Codex icindeki aktif image generation akisini kullanarak gorseli uret.

Uretim promptu su bilgileri tek promptta birlestirmeli:
- Marka/urun adi, hedef kitle ve ana vaat
- Platform ve format: Instagram feed/story, LinkedIn, X, reklam, blog hero vb.
- Boyut/oran: 1080x1080, 1080x1350, 1200x627, 1200x675, 1200x630 vb.
- Kompozisyon: odak nesne, arka plan, negatif alan, metin icin bosluk
- Stil: fotografik, editorial, minimal, 3D, flat illustration, premium SaaS UI vb.
- Renk paleti, isik, duygu ve marka tonu
- Okunabilir metin gerekiyorsa tam metin ve yerlesim; metin gerekmiyorsa "no text"
- Kacinilacaklar: bozuk eller/yuzler, okunaksiz yazi, sahte logo, telifli karakter, marka disi stil

Image generation araci aktif degilse gercek uretim yapildigini iddia etme; kapsamli promptu,
tasarim briefini ve kullanicinin manuel olarak hangi Codex image akisiyle uretmesi gerektigini
kaydet. Arac aktifse gorseli uret ve ciktiya promptu, varyasyon notlarini ve uretim dosyasi
yolunu ekle.

## Sosyal Medya Icin Zorunlu Davranis

`social` skill veya Content Creator sosyal post urettiginde ve post formatinda gorsel varsa:
1. Her post icin gorsel briefi yaz.
2. Bu briefi platforma uygun kapsamli image promptuna donustur.
3. Codex image generation akisini kullanarak gorseli uret.
4. Post dosyasina gorsel promptunu ve olusan gorsel dosya yolunu ekle.

## Görsel Tipleri

| Tip | Boyut | Kullanım |
|-----|-------|----------|
| Blog hero | 1200x630 (16:9) | Blog yazısı, sosyal paylaşım |
| Sosyal grafik | 1080x1080 (1:1) veya 1080x1350 (4:5) | Instagram, LinkedIn |
| Infografik | 800x2000 (dikey) | Blog, Pinterest |
| Thumbnail | 1280x720 (16:9) | YouTube |
| Reklam banner'ı | 1200x628 | Google Display, Meta |

## Prompt Yazımı

### Midjourney Prompt Formülü
```
[Konu] + [Stil] + [Kompozisyon] + [Renk paleti] + [Teknik detaylar] --ar [en-boy] --v 6
```

**Örnek:**
```
Futuristic project management dashboard with AI holograms, clean interface, 
blue and purple gradient, minimalist style, isometric view --ar 16:9 --v 6
```

### DALL-E Prompt Formülü
```
[Detaylı sahne açıklaması], [stil], [aydınlatma], [renk], [kompozisyon]
```

## Görsel Stratejisi

- **Tutarlılık:** Tüm görseller aynı stil, renk paleti, tipografi
- **Marka:** Logo, renkler, font
- **Duygu:** Hangi duyguyu uyandırmalı?
- **Hikaye:** Görsel ne anlatıyor?

## Kullanım Kanalları

| Kanal | Optimal Boyut | Format |
|-------|-------------|--------|
| Blog | 1200x630 | JPEG/WebP |
| LinkedIn | 1200x627 | JPEG |
| Instagram Feed | 1080x1080 | JPEG |
| Instagram Story | 1080x1920 | JPEG |
| Twitter/X | 1200x675 | JPEG |
