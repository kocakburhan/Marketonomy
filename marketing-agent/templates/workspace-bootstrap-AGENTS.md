# PersonalAutonomy Workspace Bootstrap

PA_BOOTSTRAP_VERSION: 1

Bu klasör bir PersonalAutonomy değerlendirme veya proje workspace'idir. Codex bu workspace'in
dışına çıkmamalı, kardeş proje veya değerlendirme klasörlerini taramamalıdır.

Asıl Marketing Agent talimatları bu workspace içindeki `.pa/agent/AGENTS.md` dosyasındadır.
Her yeni görevde önce bu dosyayı oku ve oradaki workspace türü, kimlik, dosyalama, haftalık plan,
araştırma, kanıt ve kullanıcı onayı kurallarını uygula.

Bu kök `AGENTS.md` dosyası bootstrap dosyasıdır. Agent release güncellemeleri bu dosyayı
davranış kaynağı olarak kullanmaz; sürümlenen talimatlar `.pa/agent/` altında güncellenir.

Her yeni oturumda veya proje çalışmasına başlamadan önce `.pa/agent-install.json` dosyası varsa
`.pa/agent/scripts/check-update.ps1` ile güncelleme kontrolü yap. Yeni sürüm varsa kullanıcıya
kısa ve açık şekilde bildir. Kullanıcı onay vermeden güncelleme yapma. Onay verilirse
`.pa/agent/scripts/update-agent.ps1 -Yes` çalıştır. Güncelleme yalnızca `.pa/agent/` paketini
değiştirebilir; proje dosyaları, `.pa/project/` ve `.pa/evaluation/` korunmalıdır.
Güncelleme başarılı olursa bu dosyadan sonra `.pa/agent/AGENTS.md` dosyasını yeniden oku.

Proje özel ayarları ve onaylı tercih değişiklikleri proje workspace'inde `.pa/project/`,
değerlendirme workspace'inde `.pa/evaluation/` altında tutulur. Web app tarafından üretilen
`idea_id`, `project_id`, rol, üyelik, Drive host veya yayın durumlarını yerel dosyalardan
değiştirmeye çalışma.
