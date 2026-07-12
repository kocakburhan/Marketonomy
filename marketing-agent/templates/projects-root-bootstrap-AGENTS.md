# PersonalAutonomy Projects Root Bootstrap

PA_PROJECTS_BOOTSTRAP_VERSION: 1

Bu klasor PersonalAutonomy ana `Projects` kokudur. Gercek proje calismasi burada yapilmaz.
Onboarding, plugin/MCP kontrolu, reusable marketer profili ve yeni proje olusturma disinda bu koke
proje ciktisi yazma.

Her yeni oturumda once bu kokteki `onboarding-guide.md` dosyasini oku ve uygula. Bu dosya
`marketing-agent/agents/onboarding-guide.md` canonical kaynaginin kurulu kopyasidir.

Reusable marketer profili `.pa/marketer-profile.md` yolundadir. Kullanici gonullu olarak standart
sorularin disinda ek baglam paylasabilir; bu bilgiyi anlamini bozmadan profile ekle. Hassas bilgi
cikarsama, teshis isteme veya kullaniciyi paylasmaya zorlama.

Kullanıcıya yönelik Türkçe metinlerde ve Türkçe içerik barındıran dosyalarda Türkçe karakterleri
eksiksiz koru. `ç`, `ğ`, `ı`, `İ`, `ö`, `ş`, `ü` harflerini ASCII karşılıklarına çevirme;
dosyaları UTF-8 olarak yaz ve yazımdan sonra Türkçe karakterlerin gerçekten korunduğunu doğrula.

Yeni proje olustururken `.pa/onboarding-install.json` dosyasindaki repo URL'si ve surumu kullan.
Windows'ta resmi `scripts/create-project.ps1`, macOS'ta `scripts/create-project.sh` akisini gecici
repo kaynagindan calistir. Serbest elle workspace olusturma. Basarili kurulumdan sonra kullaniciya
`Projects/<proje-adi>/` klasorunu yeni Codex workspace ve yeni thread olarak acmasini soyle.

Her yeni oturumda `.pa/onboarding-install.json` varsa salt-okunur update kontrolu yap:
Windows'ta `.pa/onboarding/scripts/check-update.ps1`, macOS'ta
`.pa/onboarding/scripts/check-update.sh`. Yeni surum varsa kullaniciya bildir. Kullanici onay
vermeden update yapma. Onay verilirse Windows'ta
`.pa/onboarding/scripts/update-onboarding.ps1 -Yes`, macOS'ta
`.pa/onboarding/scripts/update-onboarding.sh --yes` calistir.

Onboarding update yalnizca `AGENTS.md`, `onboarding-guide.md`, `.pa/onboarding/` ve
`.pa/onboarding-install.json` alanlarini yonetebilir. `.pa/marketer-profile.md` ve proje
klasorleri korunmalidir.
