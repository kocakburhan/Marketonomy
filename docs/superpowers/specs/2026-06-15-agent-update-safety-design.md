# Agent Guncelleme Guvenligi Tasarimi

## Amac

Marketing agent release'lerini tum PersonalAutonomy projelerine proje verisini bozmadan,
proje bazinda atomik ve geri alinabilir sekilde dagitmak.

## Kararlar

- Kok `AGENTS.md` degismeyen bootstrap dosyasidir ve aktif talimatlar icin
  `.pa/agent/AGENTS.md` dosyasina yonlendirir.
- Release tum projeler taranmadan once bir kez dogrulanir.
- Yalnizca PersonalAutonomy proje isaretlerini tasiyan klasorler islenir.
- Ayni surum atlanir; surum dusurme sadece `-AllowDowngrade` ile yapilir.
- Her proje hedefle ayni dosya sistemi uzerindeki proje disi gecici alan ve backup kullanilarak
  atomik guncellenir.
- Bir proje basarisiz olursa eski surume dondurulur ve diger projelere devam edilir.
- Dosya kilidi veya Drive senkronizasyon sorunu olan proje atlanir ve raporlanir.
- Kullanici dostu ozet ve tarihli teknik log uretilir.

## Basari Olcutu

Her proje ya yeni release'i tamamen kullanir ya da eski calisan surumunde kalir. Hicbir
proje yarim guncellenmis `.pa/agent` klasoruyla birakilmaz.
