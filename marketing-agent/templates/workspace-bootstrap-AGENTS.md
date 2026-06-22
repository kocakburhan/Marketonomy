# PersonalAutonomy Workspace Bootstrap

PA_BOOTSTRAP_VERSION: 1

Bu klasor bir PersonalAutonomy proje workspace'idir. Codex bu workspace'in disina cikmamali ve
kardes proje klasorlerini taramamali.

Asil Marketing Agent talimatlari bu workspace icindeki `.pa/agent/AGENTS.md` dosyasindadir. Her
yeni gorevde once bu dosyayi oku ve oradaki kimlik, dosyalama, haftalik plan, arastirma, kanit ve
kullanici onayi kurallarini uygula.

Bu kok `AGENTS.md` dosyasi bootstrap dosyasidir. Agent release guncellemeleri bu dosyayi davranis
kaynagi olarak kullanmaz; surumlenen talimatlar `.pa/agent/` altinda guncellenir.

Her yeni oturumda veya proje calismasina baslamadan once `.pa/agent-install.json` dosyasi varsa
`.pa/agent/scripts/check-update.ps1` ile guncelleme kontrolu yap. Yeni surum varsa kullaniciya
kisa ve acik sekilde bildir. Kullanici onay vermeden guncelleme yapma. Onay verilirse
`.pa/agent/scripts/update-agent.ps1 -Yes` calistir. Guncelleme yalnizca `.pa/agent/` paketini
degistirebilir; proje dosyalari ve `.pa/project/` korunmalidir. Guncelleme basarili olursa bu
dosyadan sonra `.pa/agent/AGENTS.md` dosyasini yeniden oku.

Fikir degerlendirme ayri workspace degildir; proje klasoru icindeki bir calisma modudur. `idea_id`,
`project_id`, rol, uyelik, Drive sahipligi/host veya yayin durumlarini yerel dosyalardan sessizce
degistirmeye calisma.
