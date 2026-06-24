# PersonalAutonomy Marketing Agent Quickstart

## Mental Model

Use one central `Projects` folder and one folder per project:

```text
Projects/
  AGENTS.md
  onboarding-guide.md
  .pa/
    marketer-profile.md
    onboarding-install.json
    onboarding/
      scripts/
  x-projesi/
  y-projesi/
```

Open `Projects/` in Codex only for onboarding, plugin checklist, reusable marketer profile, and
creating a new project. Open `Projects/x-projesi/` in Codex for all real work.

## Codex App Plugin Checklist

Install these manually in Codex App:

1. Google Drive
2. Google Calendar
3. Gmail
4. Canva
5. Figma
6. GitHub

For unclear idea shaping, campaign direction, offer design, or strategy discussion, keep the
`brainstorming` skill active when available.

## Install The Projects Root

From the cloned repo on Windows:

```powershell
.\scripts\install-projects-root.ps1 `
  -TargetRoot "G:\Drive\PersonalAutonomy\Projects" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version v5.5.0
```

On macOS:

```bash
./scripts/install-projects-root.sh \
  --target-root "$HOME/Projects" \
  --repo-url "<GITHUB_REPO_URL>" \
  --version v5.5.0
```

This installs root `AGENTS.md`, the canonical `onboarding-guide.md`, onboarding update scripts,
and `.pa/onboarding-install.json`. It preserves `.pa/marketer-profile.md` and project folders.

## Create A Project

From the repo during development:

```powershell
.\scripts\create-project.ps1 `
  -TargetRoot "G:\Drive\PersonalAutonomy\Projects\x-projesi" `
  -Title "X Projesi" `
  -SourceAgentRoot .\marketing-agent
```

From a marketer's `Projects` root, Codex should run the approved create flow with the official
GitHub repo when available:

```powershell
.\scripts\create-project.ps1 `
  -TargetRoot "G:\Drive\PersonalAutonomy\Projects\x-projesi" `
  -Title "X Projesi" `
  -RepoUrl "<GITHUB_REPO_URL>" `
  -Version latest
```

The script creates the project folder, copies `Projects/.pa/marketer-profile.md` byte-for-byte
into `.pa/project/marketer-profile.md` when present, installs `.pa/agent/`, writes root
`AGENTS.md`, and verifies the release manifest. The project bootstrap explicitly reads the copied
profile.

After creation, open `Projects/x-projesi/` as a new Codex workspace and start a new thread.

## Work Inside A Project

A valid project workspace has:

- `PROJE.md`
- `DURUM.md`
- `KARARLAR.md`
- `.pa/project/state.json`
- `.pa/agent/AGENTS.md`
- numbered project folders

Fikir degerlendirme proje icinde yapilir. If the first task is to judge whether the idea is worth
trying, use the idea-to-PRD pipeline and write evidence under `02-arastirma/fikir-degerlendirme/`
and decisions under `03-strateji/dogrulama/` plus `KARARLAR.md`.

## Update Agent

Installed projects check updates from `.pa/agent-install.json`. Codex should run:

```powershell
powershell -ExecutionPolicy Bypass -File .\.pa\agent\scripts\check-update.ps1 -TargetRoot .
```

If there is an update, ask the user. Only after approval:

```powershell
powershell -ExecutionPolicy Bypass -File .\.pa\agent\scripts\update-agent.ps1 -TargetRoot . -Yes
```

Updates replace only `.pa/agent/`. Project files, `.pa/project/`, numbered folders, notes, plans,
and outputs are preserved.

## Starter Prompt For A New Project

```text
Bu proje workspace'ini incele. PROJE.md, DURUM.md, KARARLAR.md ve 01-baglam klasorunu oku.
Once fikri mi degerlendirecegiz, proje baglamini mi tamamlayacagiz, yoksa direkt bir cikti mi
uretecegiz bana sor. Eksik baglamlari sirayla tamamlayalim.
```

## Task Completion

Workspace artifact'i gorevi acikca kanitliyorsa agent gorevi otomatik kapatir ve kullaniciyi
bilgilendirir. Harici aksiyonlar kullanici bildirimi bekler. Final yayin veya teslim acik onay
ister.
