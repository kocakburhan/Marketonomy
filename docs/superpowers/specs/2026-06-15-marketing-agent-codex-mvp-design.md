# Marketing Agent Codex ve MVP Uyum Tasarimi

## Amac

Mevcut `marketing-agent/` paketini pazarlama uzmanliklarini, 11 uzman rolunu, 9 pipeline'ini
ve mevcut skill kapsamlarini koruyarak Codex App ve `mvp/mvp.md` icindeki PersonalAutonomy
workspace mimarisiyle uyumlu hale getirmek.

## Temel Kararlar

1. Paket tek basina proje veya session olusturmaz. Gercek calisma yalnizca onayli scriptlerin
   olusturdugu degerlendirme ya da proje workspace'inde yapilir.
2. Workspace kokundeki sabit `AGENTS.md`, Codex'i `.pa/agent/AGENTS.md` dosyasina yonlendirir.
   Surumlenen marketing-agent paketi yalnizca `.pa/agent/` altinda guncellenir.
3. Eski `sessions/`, `_index.md`, `state.md` ve paket icindeki `product-context.md` hafiza
   modeli kaldirilir. Degerlendirme durumu `.pa/evaluation/`; proje durumu `DURUM.md`,
   `.pa/project/` ve haftalik planlarda tutulur.
4. Uzman agent dosyalari korunur ve Codex tarafindan goreve gore okunan rol playbook'lari
   olur. Codex subagent'lari yalnizca kullanici acikca paralel delegasyon istediginde
   kullanilir; normal calisma bunlara bagimli olmaz.
5. Skill'ler Codex Agent Skills standardina uyar: yalnizca `name` ve acik tetikleme kapsami
   iceren `description` frontmatter'i kullanilir. Eksik frontmatter'lar tamamlanir.
6. Tum ciktilar MVP klasor sozlesmesine yazilir. Arastirma `02-arastirma/`, strateji
   `03-strateji/`, PRD ve coder briefleri `04-urun/`, uygulamalar
   `06-pazarlama-uygulamalari/`, raporlar `08-raporlar/`, final teslimler `10-final/`
   altinda tutulur.
7. Degerlendirme workspace'i ve proje workspace'i ayri baslangic, kimlik, durum ve cikti
   kurallari tasir. Agent workspace turunu isaret dosyalarindan belirler.
8. `project_id` ve `idea_id` degismezdir. Markdown kimlikleri ile state JSON kimlikleri
   celisirse normal calisma durur ve Yonetici Burhan Kocak'a yonlendirilir.
9. Proje override degisiklikleri SHA-256 ve kullanici onayi akisini izler. Haftalik gorevler
   yalnizca acik kullanici onayiyla tamamlanir.
10. Operasyonel saat dilimi `Europe/Istanbul`; haftalik planlar Pazartesi-Pazar ISO hafta
    bicimindedir.

## Codex Entegrasyonu

- `AGENTS.md` kalici ve zorunlu calisma kurallarini yukler.
- Repo/workspace skill kesfi icin release skill'leri workspace olusturma scripti tarafindan
  `.agents/skills/` konumuna da yayinlanabilir; `.pa/agent/skills/` canonical release
  kopyasi olarak kalir. Agent, canonical skill dosyalarini acikca okuyarak da calisabilir.
- MCP bagimliliklari host Codex yapilandirmasidir. `mcps.json` release manifesti ve kurulum
  rehberidir; bir MCP'nin sadece bu dosyada listelenmesi kurulu oldugu anlamina gelmez.
- Web arastirmasi Codex'in mevcut Browser/Chrome veya web araclariyla yapilir. Eski
  Webwright, Puppeteer ve WebFetch komutlarina bagimlilik bulunmaz.

## Guvenlik ve Dosya Sahipligi

- Agent workspace kokunun disina cikmaz ve kardes workspace'leri taramaz.
- Kullanici icerigi veya gizli veri teknik loglara yazilmaz.
- Agent kullanici tarafindan yonetilen dosyalari onaysiz degistirmez; agent tarafindan
  yonetilen durum dosyalari ise kullanici talebiyle ve aciklanan etkiyle guncellenir.
- Web app rol, uyelik, Drive host, yayin ve kimlik kararlarinin ana kaynagidir. Yerel agent
  bunlari kendiliginden degistiremez.

## Dogrulama

Statik denetim asagidakileri kontrol eder:

- zorunlu release dosyalari ve dizinleri
- OpenCode/Webwright/Puppeteer ve eski session modeli referanslarinin yoklugu
- tum skill'lerde gecerli Codex frontmatter'i
- MVP workspace yollarinin ana talimatlarda bulunmasi
- release manifesti hash tutarliligi
- healthcheck ve Python scriptlerinin temel calisabilirligi
