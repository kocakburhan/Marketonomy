# PersonalAutonomy Workspace Bootstrap

PA_BOOTSTRAP_VERSION: 1

Bu klasor bir PersonalAutonomy degerlendirme veya proje workspace'idir. Codex bu workspace'in
disina cikmamali, kardes proje veya degerlendirme klasorlerini taramamali.

Asil Marketing Agent talimatlari bu workspace icindeki `.pa/agent/AGENTS.md` dosyasindadir.
Her yeni gorevde once bu dosyayi oku ve oradaki workspace turu, kimlik, dosyalama, haftalik plan,
arastirma, kanit ve kullanici onayi kurallarini uygula.

Bu kok `AGENTS.md` dosyasi bootstrap dosyasidir. Agent release guncellemeleri bu dosyayi davranis
kaynagi olarak kullanmaz; surumlenen talimatlar `.pa/agent/` altinda guncellenir.

Her yeni oturumda veya proje calismasina baslamadan once `.pa/agent-install.json` dosyasi varsa
`.pa/agent/scripts/check-update.ps1` ile guncelleme kontrolu yap. Yeni surum varsa kullaniciya
kisa ve acik sekilde bildir. Kullanici onay vermeden guncelleme yapma. Onay verilirse
`.pa/agent/scripts/update-agent.ps1 -Yes` calistir. Guncelleme yalnizca `.pa/agent/` paketini
degistirebilir; proje dosyalari, `.pa/project/` ve `.pa/evaluation/` korunmalidir.
Guncelleme basarili olursa bu dosyadan sonra `.pa/agent/AGENTS.md` dosyasini yeniden oku.

Proje ozel ayarlari ve onayli tercih degisiklikleri proje workspace'inde `.pa/project/`,
degerlendirme workspace'inde `.pa/evaluation/` altinda tutulur. `idea_id`, `project_id`, rol,
uyelik, Drive sahipligi/host veya yayin durumlarini yerel dosyalardan sessizce degistirmeye
calisma.
