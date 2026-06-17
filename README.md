# PersonalAutonomy Marketing Agent

Bu repo, PersonalAutonomy Marketing Agent paketini marketer'ların kendi proje workspace'lerine
kurması için hazırlanmıştır.

## Marketer İçin Kurulum

1. Google Drive for desktop ile senkronize olan proje klasörünü aç. Örnek: `x-projesi/`.
2. Bu klasörü Codex App içinde workspace/root olarak aç.
3. Codex'e aşağıdaki promptu ver ve `<GITHUB_REPO_URL>` alanına bu repo linkini ekle:

```text
Bu klasör PersonalAutonomy proje workspace'i.

Şu resmi GitHub reposundaki PersonalAutonomy Marketing Agent'ı bu projeye kur:
<GITHUB_REPO_URL>

Kurulumu serbest elle yapma. Repodaki scripts/install-marketing-agent.ps1 installer'ını kullan.
Hedef proje kökü şu anda Codex'te açık olan klasördür.

Kurulumdan sonra .pa/agent/ paketini, kök AGENTS.md bootstrap dosyasını ve
release-manifest.json doğrulamasını kontrol et. Var olan proje dosyalarımı silme.
```

Kurulum bittiğinde proje klasöründe şunlar oluşur:

- `AGENTS.md`: Kısa workspace bootstrap dosyası
- `.pa/agent/`: Marketing Agent paketi
- `.pa/agent/AGENTS.md`: Asıl agent davranış sözleşmesi
- `.pa/agent/release-manifest.json`: Kurulan release doğrulama manifesti

## Codex İçin Kural

Bu repo gerçek proje çalışması için kullanılmaz. Gerçek çalışma marketer'ın kendi
değerlendirme veya proje workspace'inde yapılır. Bu repo yalnızca agent paketi, installer,
şablonlar ve doğrulama araçlarını taşır.

## Geliştirici Doğrulaması

Release değiştiğinde:

```powershell
$agentRoot = (Resolve-Path -LiteralPath marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
```

Installer testi:

```powershell
$tmp = Join-Path $env:TEMP ("pa-install-test-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null
powershell -ExecutionPolicy Bypass -File .\scripts\install-marketing-agent.ps1 -TargetRoot $tmp
```
