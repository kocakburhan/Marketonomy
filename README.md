# PersonalAutonomy Marketing Agent

PersonalAutonomy Marketing Agent, marketer'larin Codex App icinde proje klasorleriyle calismasini
saglayan agentic pazarlama sistemidir. Ilk product fazi web app'e bagli degildir; Codex App,
Google Drive for desktop ve onayli PowerShell scriptleriyle calisir.

## Aktif Model

Kullanici tek bir ana `Projects` klasoru acar:

```text
Projects/
  .pa/
    marketer-profile.md
  x-projesi/
  y-projesi/
```

Ana `Projects` klasoru sadece:

- onboarding
- Codex App plugin kurulumu
- reusable marketer profili
- yeni proje olusturma

icin kullanilir.

Gercek calisma her zaman `Projects/<proje-adi>/` klasorunde yapilir. Her proje ayri Codex
workspace ve ayri Codex thread olarak acilir.

## Fikir Degerlendirme

Fikir degerlendirme kabiliyeti korunur, ancak ayri workspace tipi degildir. Kullanici proje
klasorunu actiginda isterse ilk is olarak fikri acimasizca degerlendirir; isterse proje baglami,
arastirma, PRD, kampanya, satis, yatirimci hazirlik veya haftalik plana gecer.

Fikir degerlendirme izleri proje icinde tutulur:

- `02-arastirma/fikir-degerlendirme/`
- `03-strateji/dogrulama/`
- `KARARLAR.md`
- `DURUM.md`

## Proje Olusturma

Gelistirme ortaminda:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\create-project.ps1 `
  -TargetRoot "G:\Drive\PersonalAutonomy\Projects\x-projesi" `
  -Title "X Projesi" `
  -SourceAgentRoot .\marketing-agent
```

Marketer tarafinda Codex, resmi GitHub kaynagindan ayni approved create flow'u calistirir.
Script proje klasorunu olusturur, `.pa/agent/` paketini kurar, root `AGENTS.md` bootstrap
dosyasini yazar ve manifest hashlerini dogrular.

## Kurulum Ve Update

Installer yalnizca gecerli proje workspace'ine kurulur:

```text
PROJE.md + .pa/project/state.json
```

Update sadece `.pa/agent/` paketini degistirir. `PROJE.md`, `DURUM.md`, `KARARLAR.md`,
`.pa/project/`, haftalik planlar, notlar, kaynaklar ve ciktilar korunur.

## Zorunlu Kontroller

Marketing Agent release'i degistiginde manifest'i yenile:

```powershell
$agentRoot = (Resolve-Path -LiteralPath marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Sonra:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

## Baglayici Kaynaklar

- `mvp/mvp.md`: MVP mimarisi ve workspace sozlesmesi
- `marketing-agent/AGENTS.md`: runtime agent davranisi
- `marketing-agent/ARCHITECTURE.md`: paket mimarisi
- `marketing-agent/SKILLS.md`: yerel skill katalogu
- `marketing-agent/release-manifest.json`: release hash kaydi
