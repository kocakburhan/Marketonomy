# PersonalAutonomy Marketing Agent Dağıtım Reposu

Bu repo, marketer'ların kendi proje klasörlerine kuracağı PersonalAutonomy Marketing Agent
paketinin kaynak ve release deposudur. Gerçek müşteri/proje çalışması bu repo kökünde yapılmaz.
Marketer gerçek işi Google Drive ile senkronize edilen `Projects/<proje-adi>/` klasöründe, o
klasörü Codex root olarak açarak yürütür. Ana `Projects/` klasörü yalnızca onboarding, plugin
kontrolü, reusable marketer profili ve yeni proje oluşturma içindir.

## Ana Karar

Bu repoda üç farklı `AGENTS.md` seviyesi vardır:

1. Bu kök `AGENTS.md`: Repo üzerinde çalışan Codex'e kurulum, release ve doğrulama kurallarını
   anlatır.
2. `marketing-agent/AGENTS.md`: Proje workspace'ine `.pa/agent/AGENTS.md` olarak kopyalanan asıl
   Marketing Agent davranış sözleşmesidir.
3. Her proje workspace'inin kökündeki `AGENTS.md`: Kısa bootstrap dosyasıdır;
   Codex'i `.pa/agent/AGENTS.md` dosyasına yönlendirir ve workspace dışına çıkmama kuralını
   taşır.

Asıl agent davranışını repo köküne koyma. Asıl davranış her zaman `marketing-agent/AGENTS.md`
içinde yaşar ve installer tarafından hedef workspace'e `.pa/agent/` altında kurulur.

## Bağlayıcı Kaynaklar

- `mvp/mvp.md`: PersonalAutonomy MVP mimarisi, Drive modeli, workspace yapısı, haftalık plan
  sistemi ve değişmez kapsam kararları için ana kaynak.
- `marketing-agent/AGENTS.md`: Marketing Agent çalışma kuralları.
- `marketing-agent/ARCHITECTURE.md`: Agent paketinin mimari sınırları.
- `marketing-agent/SKILLS.md`: Yerel skill kataloğu ve varsayılan çıktı yolları.
- `marketing-agent/release-manifest.json`: Release dosya listesi ve SHA-256 doğrulama kaydı.
- `marketing-agent/agent-version.json`: Release sürüm bilgisi.

Bu dosyalar çelişirse `mvp/mvp.md` mimari kararları, `marketing-agent/AGENTS.md` ise runtime
agent davranışı için yetkilidir. Çelişkiyi sessizce çözme; kullanıcıya göster.

## Marketer Kurulum Akışı

Marketer bir proje klasörünü, örneğin `x-projesi/`, Codex root olarak açar. Codex'e GitHub repo
linkini verip kurulum ister. Kurulum serbest elle yapılmaz; resmi installer çalıştırılır.

Beklenen güvenli kurulum:

1. Repo geçici bir klasöre klonlanır veya indirilir.
2. Windows'ta `scripts/install-marketing-agent.ps1`, macOS'ta
   `scripts/install-marketing-agent.sh` çalıştırılır.
3. Hedef proje kökü açık Codex workspace'idir.
4. Installer hedefin tam olarak bir geçerli project workspace olduğunu; `PROJE.md` ile
   `.pa/project/state.json` kimliklerinin eşleştiğini kopyalamadan önce doğrular.
5. `marketing-agent/` paketi hedefte `.pa/agent/` altına atomik olarak kopyalanır.
6. Hedef kökte bootstrap `AGENTS.md` oluşturulur veya güvenli şekilde güncellenir.
7. Hedef kökte `.pa/agent-install.json` oluşturulur; repo URL'si, istenen sürüm ve update
   politikası burada saklanır.
8. `release-manifest.json` kaynakta ve hedefte doğrulanır.
9. Kullanıcı dosyaları, proje çıktıları ve mevcut notlar silinmez.

Örnek marketer promptu:

```text
Bu klasör PersonalAutonomy proje workspace'i.

Şu resmi GitHub reposundaki PersonalAutonomy Marketing Agent'ı bu projeye kur:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Windows'ta repodaki scripts/install-marketing-agent.ps1
installer'ını, macOS'ta scripts/install-marketing-agent.sh installer'ını kullan.
Installer'ı Windows'ta -RepoUrl <GITHUB_REPO_URL> -Version latest; macOS'ta
--repo-url <GITHUB_REPO_URL> --version latest parametreleriyle çalıştır.
Hedef proje kökü şu anda Codex'te açık olan klasördür.

Kurulumdan sonra .pa/agent/ paketini, kök AGENTS.md bootstrap dosyasını ve
release-manifest.json doğrulamasını kontrol et. Var olan proje dosyalarımı silme.
```

## Repo Üzerinde Çalışırken

- Önce `mvp/mvp.md` ve ilgili `marketing-agent/` dosyalarını oku.
- Release davranışını değiştirirken `marketing-agent/AGENTS.md`, `ARCHITECTURE.md`, `SKILLS.md`,
  pipeline, agent veya skill dosyalarının birbirini tamamladığını kontrol et.
- Kurulum davranışını değiştirirken `scripts/install-marketing-agent.ps1`,
  `scripts/install-marketing-agent.sh`, `scripts/create-project.ps1`, `scripts/create-project.sh` ve
  `marketing-agent/templates/workspace-bootstrap-AGENTS.md` dosyalarını birlikte düşün.
- Agent update davranışını değiştirirken `marketing-agent/scripts/check-update.ps1`,
  `marketing-agent/scripts/check-update.sh`, `marketing-agent/scripts/update-agent.ps1`,
  `marketing-agent/scripts/update-agent.sh` ve `scripts/test_marketing_agent_install_update.ps1`
  dosyalarını birlikte düşün.
- Kullanıcı verisini temsil eden örnek proje klasörleri oluşturma; gerçek workspace kurulumu
  installer ile hedef klasörde yapılır.
- Eski OpenCode, `sessions/`, `state.md`, Webwright veya Puppeteer tabanlı talimatları geri
  getirme.

## Doğrulama Komutları

Marketing Agent release'i değiştiğinde manifest'i yenile:

```powershell
$agentRoot = (Resolve-Path -LiteralPath marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Sonra zorunlu kontrolleri çalıştır:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_macos_scripts.ps1
```

Installer veya create scriptleri değiştiğinde boş klasöre doğrudan installer çalıştırma.
Installer yalnızca geçerli project workspace kabul eder. Geçici workspace oluşturma testi için:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

## Kritik Sınırlar

- `marketing-agent/` paketinin içindeki kullanıcı davranış kuralları Türkçe ve anlaşılır
  olmalıdır.
- Release manifest güncel değilse kurulum başarılı sayılmaz.
- Installer hedefteki proje dosyalarını silmemeli, sadece `.pa/agent/` paketini ve bootstrap
  `AGENTS.md` dosyasını yönetmelidir.
- Update scripti kullanıcı onayı olmadan çalışmamalı ve yalnızca `.pa/agent/` paketini
  değiştirmelidir; `.pa/project/` ve proje çıktıları korunmalıdır.
- Workspace kökü `AGENTS.md` sabit bootstrap'tır; agent update sırasında asıl davranış
  `.pa/agent/` altında güncellenir.
- Workspace artifact'i görevi açıkça kanıtlıyorsa görev otomatik kapanır ve kullanıcı
  bilgilendirilir. Harici aksiyonlar kullanıcı tamamladığını bildirene kadar bekler. Final yayın
  veya teslim her zaman açık kullanıcı onayı ister.
