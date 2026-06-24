# PersonalAutonomy Workspace Bootstrap

PA_BOOTSTRAP_VERSION: 1

Bu klasor bir PersonalAutonomy proje workspace'idir. Codex bu workspace'in disina cikmamali ve
kardes proje klasorlerini taramamali.

Asil Marketing Agent talimatlari bu workspace icindeki `.pa/agent/AGENTS.md` dosyasindadir. Her
yeni gorevde once bu dosyayi oku ve oradaki kimlik, dosyalama, haftalik plan, arastirma, kanit ve
kullanici onayi kurallarini uygula.

Proje baglamini okumaya baslarken `.pa/project/marketer-profile.md` dosyasi varsa onu da oku.
Bu dosya ana `Projects/.pa/marketer-profile.md` profilinin proje olusturulurken kopyalanan
surumudur. Profildeki kullanicinin gonullu paylastigi ek baglam, calisma bicimi ve erisilebilirlik
tercihlerini koru; hassas bilgi cikarsama veya yeniden teshis etme.

Bu kok `AGENTS.md` dosyasi bootstrap dosyasidir. Agent release guncellemeleri bu dosyayi davranis
kaynagi olarak kullanmaz; surumlenen talimatlar `.pa/agent/` altinda guncellenir.

Her yeni oturumda veya proje calismasina baslamadan once `.pa/agent-install.json` dosyasi varsa
isletim sistemine uygun update kontrolunu yap: Windows'ta `.pa/agent/scripts/check-update.ps1`,
macOS'ta `.pa/agent/scripts/check-update.sh`. Yeni surum varsa kullaniciya kisa ve acik sekilde
bildir. Kullanici onay vermeden guncelleme yapma. Onay verilirse Windows'ta
`.pa/agent/scripts/update-agent.ps1 -Yes`, macOS'ta `.pa/agent/scripts/update-agent.sh --yes`
calistir. Guncelleme yalnizca `.pa/agent/` paketini degistirebilir; proje dosyalari ve
`.pa/project/` korunmalidir. Guncelleme basarili olursa bu dosyadan sonra
`.pa/agent/AGENTS.md` dosyasini yeniden oku.

Fikir degerlendirme ayri workspace degildir; proje klasoru icindeki bir calisma modudur. `idea_id`,
`project_id`, rol, uyelik, Drive sahipligi/host veya yayin durumlarini yerel dosyalardan sessizce
degistirmeye calisma.
