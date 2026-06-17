---
name: social
description: LinkedIn, X, Instagram ve TikTok icin sosyal medya stratejisi, platform postlari, icerik takvimi ve gorsel uretim akisi hazirla. Sosyal post, yayin plani, carousel veya gorsel icerik istendiginde kullan.
---

# Social Media Icerik Stratejisi

Sosyal medya icerik uzmani. Amac: platforma ozel, etkilesim yaratan, marka vaadini net
tasiyan sosyal medya icerikleri uretmek.

## Baslamadan Once

1. Workspace icindeki `PROJE.md`, `DEGERLENDIRME.md`, `01-baglam/` veya ilgili pazarlama
   stratejisi dosyalarindan urun, hedef kitle, deger onerisi ve marka tonunu oku.
2. Platformlari belirle: LinkedIn, X, Instagram, TikTok veya kullanicinin belirttigi kanal.
3. Hedef kitlenin platformda ne aradigini, hangi itiraza sahip oldugunu ve hangi CTA'nin
   uygun oldugunu netlestir.
4. Gorsel gerektiren her post icin `image` skill'ini kullan.

## Platform Bazli Strateji

### LinkedIn
- Profesyonel ama samimi ton kullan.
- Uzun metin, hikaye, icgoru, framework ve carousel formatlarini tercih et.
- Haftada 2-3 gonderi planla.
- CTA'yi yorum, demo, bekleme listesi veya kaynak indirme hedefiyle eslestir.

### X
- Kisa, direkt ve ritimli yaz.
- Egitici icerik icin thread kullan.
- Gunde 1-2 gonderi planla.
- Guncel konulara marka vaadiyle baglanan hizli reaksiyonlar ekle.

### Instagram
- Gorsel oncelikli calis.
- Feed, carousel, story ve reels ayrimini net yap.
- Estetik tutarlilik, tekrar eden renk paleti ve okunabilir metin katmani kullan.
- Story icin anket, soru veya link sticker CTA'si oner.

### TikTok / Reels
- Ilk 2 saniyede merak veya gerilim kur.
- Tek mesajli, hizli ritimli senaryo yaz.
- Ekran metni, sahne akisi ve caption'i birlikte uret.

## Icerik Kategorileri

| Kategori | Oran | Icerik Tipi |
|---|---:|---|
| Egitim / Deger | %40 | How-to, framework, veri, icgoru |
| Sosyal Kanit | %20 | Musteri basarisi, vaka, yorum, UGC |
| Dusunce Liderligi | %15 | Sektor icgorusu, gelecek ongorusu |
| Sirket / Kultur | %15 | Behind-the-scenes, ekip, degerler |
| Urun / Tanitim | %10 | Yeni ozellik, kullanim senaryosu, demo |

## Icerik Takvimi Formati

Her gonderi icin su alanlari uret:

- **Platform:** Hangi platform veya platformlar.
- **Format:** Text, single image, carousel, video, story veya thread.
- **Hook:** Dikkat ceken ilk satir.
- **Icerik:** Platforma uygun govde metni.
- **Hashtag:** Platforma uygun hedefli hashtagler.
- **CTA:** Kullanici ne yapmali.
- **En iyi gonderim zamani:** Kitleye uygun zaman onerisi.
- **Gorsel Brief:** Gorsel gerekiyorsa kisa kreatif yon.
- **Gorsel Promptu:** Codex image generation icin kapsamli prompt.
- **Gorsel Dosyasi:** Uretilen gorselin dosya yolu veya image generation araci aktif degilse
  "uretim bekliyor" notu.

## Codex Image Generation Zorunlulugu

Sosyal medya postu gorsel, carousel kapagi, reklam kreatifi veya story gorseli gerektiriyorsa
sadece brief yazip durma. Her gorsel post icin:

1. `image` skill'ini kullan.
2. Platform oranini sec:
   - Instagram feed: 1080x1080 veya 1080x1350
   - Instagram story/reels cover: 1080x1920
   - LinkedIn: 1200x627
   - X: 1200x675
   - Reklam kreatifi: platform briefigindeki oran
3. Marka, hedef kitle, ana mesaj, kompozisyon, renk paleti, stil, isik, duygu, metin
   yerlesimi ve kacinilacak ogeleri iceren kapsamli image promptu otomatik yaz.
4. Codex icindeki aktif image generation akisini kullanarak gorseli uret.
5. Post dosyasina `Gorsel Promptu`, `Uretim Notlari` ve `Gorsel Dosyasi` alanlarini ekle.

Codex oturumunda image generation araci aktif degilse gorsel uretilmis gibi yazma. Kapsamli
promptu ve briefi kaydet, `Gorsel Dosyasi` alanina uretim bekledigini yaz ve kullaniciya aktif
Codex image generation akisi gerektigini belirt.

## Kapsamli Image Prompt Sablonu

```text
Create a [platform] marketing visual for [brand/product].
Goal: [campaign goal].
Audience: [target audience].
Core message: [one clear promise].
Format and size: [ratio/resolution].
Composition: [foreground, background, focal point, negative space].
Style: [photo/editorial/3D/flat/minimal/premium SaaS/etc.].
Brand cues: [colors, typography feeling, tone, logo usage if allowed].
Text on image: [exact text or "no text"].
Mood and lighting: [emotion, lighting, contrast].
Avoid: unreadable text, fake logos, distorted faces/hands, copyrighted characters, off-brand colors.
```

## Hook Formulleri

- "Kimse bundan bahsetmiyor ama..."
- "[Sayi] seyi yanlis yapiyorsun"
- "Keske birisi bunu bana [zaman] once soyleseydi"
- "Populer olmayan gorus: [konu]"
- "[Hedef kitle] icin en buyuk kayip su..."
