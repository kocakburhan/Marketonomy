# PersonalAutonomy Marketing Agent Dağıtım Reposu

Bu repo, marketer'ların kendi proje klasörlerine kuracağı PersonalAutonomy Marketing Agent
paketinin kaynak ve release deposudur. Gerçek müşteri/proje çalışması bu repo kökünde yapılmaz.
Marketer gerçek işi Google Drive ile senkronize edilen ilgili değerlendirme veya proje
workspace'inde, o klasörü Codex root olarak açarak yürütür.

## Ana Karar

Bu repoda üç farklı `AGENTS.md` seviyesi vardır:

1. Bu kök `AGENTS.md`: Repo üzerinde çalışan Codex'e kurulum, release ve doğrulama kurallarını
   anlatır.
2. `marketing-agent/AGENTS.md`: Proje workspace'ine `.pa/agent/AGENTS.md` olarak kopyalanan asıl
   Marketing Agent davranış sözleşmesidir.
3. Her değerlendirme veya proje workspace'inin kökündeki `AGENTS.md`: Kısa bootstrap dosyasıdır;
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
2. `scripts/install-marketing-agent.ps1` çalıştırılır.
3. Hedef proje kökü açık Codex workspace'idir.
4. `marketing-agent/` paketi hedefte `.pa/agent/` altına atomik olarak kopyalanır.
5. Hedef kökte bootstrap `AGENTS.md` oluşturulur veya güvenli şekilde güncellenir.
6. `release-manifest.json` kaynakta ve hedefte doğrulanır.
7. Kullanıcı dosyaları, proje çıktıları ve mevcut notlar silinmez.

Örnek marketer promptu:

```text
Bu klasör PersonalAutonomy proje workspace'i.

Şu resmi GitHub reposundaki PersonalAutonomy Marketing Agent'ı bu projeye kur:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Repodaki scripts/install-marketing-agent.ps1 installer'ını kullan.
Hedef proje kökü şu anda Codex'te açık olan klasördür.

Kurulumdan sonra .pa/agent/ paketini, kök AGENTS.md bootstrap dosyasını ve
release-manifest.json doğrulamasını kontrol et. Var olan proje dosyalarımı silme.
```

## Repo Üzerinde Çalışırken

- Önce `mvp/mvp.md` ve ilgili `marketing-agent/` dosyalarını oku.
- Release davranışını değiştirirken `marketing-agent/AGENTS.md`, `ARCHITECTURE.md`, `SKILLS.md`,
  pipeline, agent veya skill dosyalarının birbirini tamamladığını kontrol et.
- Kurulum davranışını değiştirirken `scripts/install-marketing-agent.ps1` ve
  `marketing-agent/templates/workspace-bootstrap-AGENTS.md` dosyalarını birlikte düşün.
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
```

Installer değiştiğinde en azından geçici bir klasöre kurulum testi yap:

```powershell
$tmp = Join-Path $env:TEMP ("pa-install-test-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null
powershell -ExecutionPolicy Bypass -File .\scripts\install-marketing-agent.ps1 -TargetRoot $tmp
```

## Kritik Sınırlar

- `marketing-agent/` paketinin içindeki kullanıcı davranış kuralları Türkçe ve anlaşılır
  olmalıdır.
- Release manifest güncel değilse kurulum başarılı sayılmaz.
- Installer hedefteki proje dosyalarını silmemeli, sadece `.pa/agent/` paketini ve bootstrap
  `AGENTS.md` dosyasını yönetmelidir.
- Workspace kökü `AGENTS.md` sabit bootstrap'tır; agent update sırasında asıl davranış
  `.pa/agent/` altında güncellenir.
- Haftalık görevler dosya üretildi diye tamamlanmış sayılmaz; yalnızca kullanıcı açıkça
  onayladığında tamamlanır.
