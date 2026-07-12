# Marketing Agent Drive Repair Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Kaynak repodaki create/install/update hatalarını kalıcı olarak düzeltmek ve `H:\My Drive\Marketing` altındaki 5 marketer Drive workspace'ini tek merkezden, dry-run destekli ve geri alınabilir şekilde onarmak.

**Architecture:** Çözüm iki katmanlı olacak: kaynak repoda release davranışı düzeltilir, sonra yeni repair script'i mevcut Drive workspace'lerine uygulanır. Repair script varsayılan olarak sadece rapor üretir; `-Apply` verilmeden dosya değiştirmez, `-CleanupStrayRepo` verilmeden `Marketonomy`, `.git`, `.agents`, `.codex` gibi kalıntıları silmez.

**Tech Stack:** PowerShell 5+/7, Bash script uyumluluğu, JSON, UTF-8 without BOM, mevcut `marketing-agent` release manifest sistemi, Google Drive for desktop yerel filesystem path'leri.

---

## Dosya Sorumluluk Haritası

- `marketing-agent/AGENTS.md`: Runtime davranış sözleşmesi. Türkçe karakter politikası, orchestrator routing ve local skill erişim kuralı burada netleşir.
- `marketing-agent/agents/orchestrator.md`: Her gerçek proje işinde okunacak ana routing playbook'u. Specialist/pipeline/skill dosyalarının nasıl seçileceğini net söyler.
- `marketing-agent/templates/workspace-bootstrap-AGENTS.md`: Proje kökü `AGENTS.md` şablonu. Codex'in ilk okuduğu dosyada `.pa/agent/AGENTS.md`, `agents/orchestrator.md` ve skill kataloğu bağlantısı açık olur.
- `marketing-agent/templates/projects-root-bootstrap-AGENTS.md`: Ana `Projects` kökü bootstrap şablonu. Türkçe karakter sözleşmesini ve onboarding akışını doğru taşır.
- `scripts/create-project.ps1`: Windows proje oluşturma script'i. NUL karakter bug'ı, başlangıç dosyalarındaki Türkçe karakterler ve repo metadata fallback'i burada düzelir.
- `scripts/create-project.sh`: macOS proje oluşturma script'i. Windows ile aynı Türkçe karakter ve metadata davranışını taşır.
- `scripts/install-marketing-agent.ps1`: Windows proje-local agent installer. `repo_url` ve `source_agent_root` metadata davranışı, manifest doğrulaması ve bootstrap güncellemesi burada düzelir.
- `scripts/install-marketing-agent.sh`: macOS proje-local agent installer. PowerShell installer ile aynı sözleşmeye getirilir.
- `marketing-agent/scripts/check-update.ps1` ve `.sh`: Kurulu proje içinde update kaynağı yoksa anlaşılır rapor verir; `repo_url` varsa çalışır.
- `marketing-agent/scripts/healthcheck.ps1`: Kaynak repo healthcheck'i ile kurulu paket self-check'i ayrılır; kurulu `.pa/agent` içinde `../mvp/mvp.md` yok diye false fail üretmez.
- `marketing-agent/scripts/build_release_manifest.ps1`: Release manifest'i günceller. `release-manifest.json` ile gerçek paket dosyaları bire bir tutarlı olmalı.
- `scripts/repair-installed-marketing-agent.ps1`: Yeni idempotent repair tool. `Projects` kökü veya proje kökü alır; dry-run raporu, `-Apply`, `-CleanupStrayRepo` ve doğrulama modları içerir.
- `scripts/test_marketing_agent_workspace_create.ps1`: Create flow regression testi. NUL, mojibake, doğru Türkçe karakter, metadata ve manifest davranışını doğrular.
- `scripts/test_marketing_agent_install_update.ps1`: Installer/update regression testi. `repo_url`, temp `source_agent_root`, manifest eksikliği ve bootstrap güncellemesini doğrular.
- `scripts/test_marketing_agent_macos_scripts.ps1`: macOS script sözleşmesi. Bash tarafında Windows ile aynı davranış maddelerini kontrol eder.
- `scripts/test_repair_installed_marketing_agent.ps1`: Yeni repair script regression testi. Bozuk fixture workspace'leri üretir, dry-run ve apply sonuçlarını doğrular.
- `marketing-agent/release-manifest.json`: Son görevde yeniden üretilir; eksik `scripts/build_release_manifest.ps1` gibi manifest/kopya tutarsızlıkları kalmamalı.

---

## Task 1: Türkçe Karakter ve Routing Sözleşmesini Netleştir

**Files:**
- Modify: `marketing-agent/AGENTS.md`
- Modify: `marketing-agent/agents/orchestrator.md`
- Modify: `marketing-agent/templates/workspace-bootstrap-AGENTS.md`
- Modify: `marketing-agent/templates/projects-root-bootstrap-AGENTS.md`

- [ ] **Step 1: Runtime Türkçe karakter kuralını ekle**

`marketing-agent/AGENTS.md` içinde `Internal operating instructions...` paragrafından sonra şu sözleşmeyi ekle:

```markdown
## Turkish Writing Contract

User-facing Turkish conversation, project files, reports, plans, profile text, decisions, and
deliverables must use correct Turkish characters. Do not ASCII-fold Turkish words. Write
`satış için çok mantıklı`, not `satis icin cok mantikli`; write `kullanıcı`, `çalışma`,
`değerlendirme`, `şirket`, `özgün`, and `ürün` with their proper characters.

Technical identifiers, folder names, script names, JSON keys, and existing canonical paths stay
ASCII when the filesystem contract already defines them that way, for example `03-strateji/`,
`DURUM.md`, `project_id`, and `idea_id`.
```

- [ ] **Step 2: Orchestrator okuma kuralını netleştir**

`marketing-agent/AGENTS.md` içinde `Startup Reading Order` listesinden sonra şu paragrafı ekle:

```markdown
For any real project task beyond a context-free quick advisory, read
`.pa/agent/agents/orchestrator.md` after this file. Treat the orchestrator as the routing table for
specialists, pipelines, and local skills. Do not load every local skill eagerly; read only the
specialist, pipeline, or `.pa/agent/skills/<skill>/SKILL.md` file selected for the user's request.
```

- [ ] **Step 3: Orchestrator dosyasına aynı Türkçe karakter kuralını kısa formda ekle**

`marketing-agent/agents/orchestrator.md` içinde giriş bölümüne şunu ekle:

```markdown
User-facing Turkish must preserve Turkish characters. Do not turn `satış`, `çok`, `kullanıcı`,
`çalışma`, `değerlendirme`, `özgün`, or `ürün` into ASCII-only spellings.
```

- [ ] **Step 4: Workspace bootstrap şablonuna orchestrator ve skill erişim kuralını ekle**

`marketing-agent/templates/workspace-bootstrap-AGENTS.md` içinde `.pa/agent/AGENTS.md` yönlendirmesinden sonra şu metni ekle:

```markdown
Gerçek proje işlerinde `.pa/agent/AGENTS.md` dosyasından sonra
`.pa/agent/agents/orchestrator.md` dosyasını routing sözleşmesi olarak oku. Orchestrator'ın
seçtiği specialist, pipeline veya `.pa/agent/skills/<skill>/SKILL.md` dosyasını yükle; bütün
agent ve skill dosyalarını gereksiz yere topluca okuma.

Kullanıcıya dönük Türkçe konuşmalarda ve Türkçe proje dosyalarında Türkçe karakterleri doğru
kullan. `satış için çok mantıklı` yaz; `satis icin cok mantikli` yazma. Teknik path ve JSON
anahtarları mevcut sözleşmedeki haliyle korunur.
```

- [ ] **Step 5: Projects root bootstrap şablonundaki mojibake metni düzelt**

`marketing-agent/templates/projects-root-bootstrap-AGENTS.md` içinde bozuk görünen Türkçe karakterli paragrafı şu temiz metinle değiştir:

```markdown
Kullanıcıya yönelik Türkçe metinlerde ve Türkçe içerik barındıran dosyalarda Türkçe karakterleri
eksiksiz koru. `ç`, `ğ`, `ı`, `İ`, `ö`, `ş`, `ü` harflerini ASCII karşılıklarına çevirme;
dosyaları UTF-8 olarak yaz ve yazımdan sonra Türkçe karakterlerin gerçekten korunduğunu doğrula.
```

- [ ] **Step 6: Hızlı kaynak taraması çalıştır**

Run:

```powershell
$root = "D:\Projects\PersonalAutonomy-MVP\marketing-agent"
$bad = Get-ChildItem -LiteralPath $root -Recurse -File |
  Where-Object { $_.Extension -in ".md",".json",".ps1",".sh",".yaml",".yml",".txt" } |
  Where-Object {
    $text = [System.IO.File]::ReadAllText($_.FullName, [Text.Encoding]::UTF8)
    $text -match $knownMojibakePattern -or $text.Contains([string][char]0)
  }
$bad | Select-Object FullName
```

Expected: No files from `marketing-agent/` except intentional third-party/vendor files. If any first-party file appears, fix it before continuing.

---

## Task 2: Create Flow Bug'larını Düzelt

**Files:**
- Modify: `scripts/create-project.ps1`
- Modify: `scripts/create-project.sh`
- Modify: `scripts/test_marketing_agent_workspace_create.ps1`

- [ ] **Step 1: Failing assertion ekle**

`scripts/test_marketing_agent_workspace_create.ps1` içinde proje oluşturulduktan sonra şu assertion'ları ekle:

```powershell
Assert-NoControlChars (Join-Path $projectRoot "PROJE.md") "Project PROJE.md kontrol karakteri içermemeli."
Assert-NoControlChars (Join-Path $projectRoot "KARARLAR.md") "Project KARARLAR.md kontrol karakteri içermemeli."

$projectText = Read-Utf8 (Join-Path $projectRoot "PROJE.md")
$decisionsText = Read-Utf8 (Join-Path $projectRoot "KARARLAR.md")
Assert-True ($projectText -match "Fikir Değerlendirme Modu") "PROJE.md doğru Türkçe karakter kullanmalı."
Assert-True ($decisionsText -match "Henüz karar kaydı yok\.") "KARARLAR.md doğru Türkçe karakter kullanmalı."
Assert-True ($projectText -notmatch "Fikir Degerlendirme|Kullanici|arastirma") "PROJE.md Türkçe kullanıcı metnini ASCII'ye çevirmemeli."
```

- [ ] **Step 2: Testi fail olarak çalıştır**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected before implementation: FAIL with `PROJE.md kontrol karakteri`, `Fikir Değerlendirme Modu`, or `Henüz karar kaydı yok` related failures.

- [ ] **Step 3: `create-project.ps1` içinde onboarding metadata fallback'ini düzelt**

Şu koşulu:

```powershell
if (-not $SourceAgentRoot -and -not $RepoUrl) {
```

şuna çevir:

```powershell
if (-not $RepoUrl) {
```

Bu sayede `-SourceAgentRoot` temp klasör olsa bile `Projects/.pa/onboarding-install.json` içindeki `repo_url` proje metadata'sına taşınır.

- [ ] **Step 4: `create-project.ps1` başlangıç dosyalarını doğru Türkçe karakterlerle yaz**

`PROJE.md`, `DURUM.md`, `KARARLAR.md`, `README.md`, haftalık plan, günlük plan, `linkler.md`, bilgi haritası ve overrides metinlerinde kullanıcıya dönük Türkçe cümleleri doğru karakterlerle yaz. `PROJE.md` here-string'inde Markdown backtick'lerini PowerShell escape'i gibi yorumlatmamak için single-quoted here-string + format yaklaşımı kullan:

```powershell
$projectTemplate = @'
# {0}

project_id: {1}
idea_id: {2}

## Özet
- Durum: Yeni proje workspace'i
- Oluşturma tarihi: {3}
- Oluşturma akışı: approved create flow, Codex + Google Drive first

## Fikir Değerlendirme Modu
Bu workspace tek proje çalışma alanıdır. Fikir ayrı bir çalışma klasörüne taşınmaz.
Kullanıcı isterse ilk iş olarak fikir burada acımasızca değerlendirilir; araştırma ve karar
izleri `02-arastirma/fikir-degerlendirme/`, `03-strateji/dogrulama/`, `KARARLAR.md` ve
`DURUM.md` içinde tutulur. Fikir denenmeye değmezse proje dosyaları silinmez; gerekçe ve sonraki
seçenekler kayda geçirilir.

'@
Write-Utf8 (Join-Path $target "PROJE.md") ($projectTemplate -f $Title, $ProjectId, $IdeaId, $now.ToString("yyyy-MM-dd"))
```

`KARARLAR.md` için:

```powershell
Write-Utf8 (Join-Path $target "KARARLAR.md") "# Kararlar`n`nHenüz karar kaydı yok.`n"
```

- [ ] **Step 5: `create-project.sh` metinlerini aynı Türkçe sözleşmeye getir**

Bash tarafında `cat > "$target/PROJE.md" <<EOF` bloğundaki kullanıcıya dönük metinleri Türkçe karakterli yap:

```bash
## Özet
- Durum: Yeni proje workspace'i
- Oluşturma tarihi: $now_date
- Oluşturma akışı: approved create flow, Codex + Google Drive first

## Fikir Değerlendirme Modu
Bu workspace tek proje çalışma alanıdır. Fikir ayrı bir çalışma klasörüne taşınmaz.
Kullanıcı isterse ilk iş olarak fikir burada acımasızca değerlendirilir; araştırma ve karar
izleri \`02-arastirma/fikir-degerlendirme/\`, \`03-strateji/dogrulama/\`, \`KARARLAR.md\` ve
\`DURUM.md\` içinde tutulur. Fikir denenmeye değmezse proje dosyaları silinmez; gerekçe ve sonraki
seçenekler kayda geçirilir.
```

`KARARLAR.md` için:

```bash
printf '# Kararlar\n\nHenüz karar kaydı yok.\n' > "$target/KARARLAR.md"
```

- [ ] **Step 6: Workspace create testini geçir**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
```

Expected: `SONUC: Workspace create testleri gecti.`

---

## Task 3: Installer, Update ve Manifest Tutarlılığını Düzelt

**Files:**
- Modify: `scripts/install-marketing-agent.ps1`
- Modify: `scripts/install-marketing-agent.sh`
- Modify: `marketing-agent/scripts/check-update.ps1`
- Modify: `marketing-agent/scripts/check-update.sh`
- Modify: `marketing-agent/scripts/healthcheck.ps1`
- Modify: `scripts/test_marketing_agent_install_update.ps1`
- Modify: `scripts/test_marketing_agent_macos_scripts.ps1`

- [ ] **Step 1: Installer metadata testlerini genişlet**

`scripts/test_marketing_agent_install_update.ps1` içine şu senaryoyu ekle:

```powershell
$metadata = Read-Utf8 (Join-Path $workspace ".pa\agent-install.json") | ConvertFrom-Json
Assert-Equal $metadata.repo_url "https://github.com/example/personalautonomy-mvp" "Repo URL metadata'da korunmalı."
Assert-True (-not ([string]$metadata.source_agent_root -match "\\AppData\\Local\\Temp|/tmp/")) "Geçici source_agent_root metadata'ya kalıcı kaynak gibi yazılmamalı."
```

- [ ] **Step 2: PowerShell installer metadata davranışını düzelt**

`Write-InstallMetadata` çağrısından önce şunu hesapla:

```powershell
$metadataSourceAgentRoot = ""
if ($SourceAgentRoot -and -not $RepoUrl) {
    $metadataSourceAgentRoot = $SourceAgentRoot
}
```

`Write-InstallMetadata` çağrısında `-SourceAgentRoot $metadataSourceAgentRoot` kullan. Böylece repo URL varsa ölü temp path kalıcı update kaynağı gibi saklanmaz.

- [ ] **Step 3: Bash installer'ı aynı davranışa getir**

`scripts/install-marketing-agent.sh` içinde metadata JSON yazmadan önce aynı mantığı uygula:

```bash
metadata_source_agent_root=""
if [[ -n "$source_agent_root" && -z "$repo_url" ]]; then
  metadata_source_agent_root="$source_agent_root"
fi
```

JSON içinde `source_agent_root` için `$metadata_source_agent_root` yaz.

- [ ] **Step 4: `check-update` hata mesajını güvenli hale getir**

`marketing-agent/scripts/check-update.ps1` içinde kaynak yoksa mevcut throw kalsın ama mesaj kullanıcıya hangi dosyanın düzeltileceğini söylesin:

```powershell
throw "Güncelleme kaynağı bulunamadı. .pa/agent-install.json içinde repo_url yok. Repair script ile repo_url metadata'sını düzelt veya -RepoUrl ver."
```

Bash tarafında eşdeğer mesaj:

```bash
fail "Güncelleme kaynağı bulunamadı. .pa/agent-install.json içinde repo_url yok. Repair script ile repo_url metadata'sını düzelt veya --repo-url ver."
```

- [ ] **Step 5: `healthcheck.ps1` kaynak repo ve kurulu paket modlarını ayır**

`marketing-agent/scripts/healthcheck.ps1` içinde `..\mvp\mvp.md` kontrollerinden önce repo mvp dosyasını bul:

```powershell
$repoMvpPath = Join-Path (Split-Path -Parent $AgentRoot) "mvp\mvp.md"
if (-not (Test-Path -LiteralPath $repoMvpPath)) {
    Write-Output "SKIP     ..\mvp\mvp.md : kurulu agent paketinde repo-level MVP dokümanı yok"
} else {
    Test-RequiredText "..\mvp\mvp.md" "Post-MVP Appendix"
    Test-RequiredText "..\mvp\mvp.md" "web app/PWA"
    Test-RequiredText "..\mvp\mvp.md" "ilk product fazi icin runtime gereksinimi degildir"
}
```

Var olan `Test-RequiredText "..\mvp\mvp.md"` çağrılarını bu blok içine taşı. Kurulu pakette bu eksiklik fail değil skip olmalı.

- [ ] **Step 6: macOS sözleşme testini güncelle**

`scripts/test_marketing_agent_macos_scripts.ps1` içinde şunları doğrula:

```powershell
Assert-FileContains $rootInstall 'metadata_source_agent_root' "macOS installer geçici source_agent_root metadata'sını filtrelemeli."
Assert-FileContains $rootCreate 'onboarding-install\.json' "macOS create script repo_url fallback'ini kullanmalı."
Assert-FileContains $agentCheck 'repo_url yok|Güncelleme kaynağı bulunamadı' "macOS check-update eksik repo_url mesajını açık vermeli."
```

- [ ] **Step 7: Install/update ve macOS testlerini çalıştır**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_macos_scripts.ps1
```

Expected:

```text
SONUC: Install/update davranis testleri gecti.
SONUC: macOS script sozlesme testleri gecti.
```

---

## Task 4: Repair Script'ini Yaz

**Files:**
- Create: `scripts/repair-installed-marketing-agent.ps1`
- Create: `scripts/test_repair_installed_marketing_agent.ps1`

- [ ] **Step 1: Repair script parametrelerini oluştur**

`scripts/repair-installed-marketing-agent.ps1` dosyasını şu parametrelerle başlat:

```powershell
param(
    [string[]]$ProjectsRoot,
    [string[]]$ProjectRoot,
    [string]$SourceRepoRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$SourceAgentRoot,
    [string]$RepoUrl = "https://github.com/kocakburhan/Marketonomy",
    [string]$Version = "v5.5.1",
    [switch]$Apply,
    [switch]$CleanupStrayRepo,
    [switch]$CleanupEmptyCodexArtifacts,
    [switch]$Json
)
```

Varsayılan mod dry-run olmalı: `-Apply` yoksa hiçbir dosya yazma, silme veya taşıma yapılmaz.

- [ ] **Step 2: Workspace discovery fonksiyonlarını yaz**

Script içine şu davranışları ekle:

```powershell
function Find-ProjectWorkspaces([string]$Root) {
    Get-ChildItem -LiteralPath $Root -Force -Directory |
        Where-Object {
            (Test-Path -LiteralPath (Join-Path $_.FullName "PROJE.md")) -and
            (Test-Path -LiteralPath (Join-Path $_.FullName ".pa\project\state.json"))
        } |
        ForEach-Object { $_.FullName }
}
```

`$ProjectsRoot` verilirse altındaki proje workspace'lerini bul. `$ProjectRoot` verilirse doğrudan o workspace'leri kullan.

- [ ] **Step 3: Dry-run issue detector ekle**

Her proje için şu issue kodlarını raporla:

```text
missing-agent-package
missing-manifest-file
missing-manifest-entry-file:scripts/build_release_manifest.ps1
agent-install-missing-repo-url
agent-install-dead-temp-source
project-file-has-nul
decisions-file-has-known-mojibake
workspace-bootstrap-needs-update
```

Her `Projects` kökü için şu issue kodlarını raporla:

```text
projects-bootstrap-needs-update
stray-marketonomy-repo
stray-dot-git
stray-dot-agents
stray-dot-codex
```

- [ ] **Step 4: NUL düzeltmesini güvenli yap**

`PROJE.md` içinde sadece bilinen create bug'ı desenlerini düzelt:

```powershell
$text = $text.Replace(([string][char]0) + "2-arastirma", "`02-arastirma")
$text = $text.Replace(([string][char]0) + "3-strateji", "`03-strateji")
```

Sonrasında hâlâ NUL varsa apply modunda hata ver:

```powershell
if ($text.Contains([string][char]0)) {
    throw "PROJE.md içinde bilinmeyen NUL karakteri kaldı: $ProjectRoot"
}
```

- [ ] **Step 5: Mojibake düzeltmesini sadece bilinen başlangıç metnine uygula**

`KARARLAR.md` içinde yalnızca şu bilinen bozuk metinleri değiştir:

```powershell
$text = $text.Replace("<known double-encoded Henüz variant>", "Henüz karar kaydı yok.")
$text = $text.Replace("<known single-encoded Henüz variant>", "Henüz karar kaydı yok.")
$text = $text.Replace("Henuz karar kaydi yok.", "Henüz karar kaydı yok.")
```

Karar dosyasında başka içerik varsa silme veya yeniden oluşturma yapma.

- [ ] **Step 6: Agent paketini resmi installer ile onar**

Apply modunda her proje için şu komutu script içinden çalıştır:

```powershell
$installer = Join-Path $SourceRepoRoot "scripts\install-marketing-agent.ps1"
$installArgs = @(
    "-NoProfile", "-ExecutionPolicy", "Bypass",
    "-File", $installer,
    "-TargetRoot", $project,
    "-SourceAgentRoot", $SourceAgentRoot,
    "-RepoUrl", $RepoUrl,
    "-Version", $Version
)
& powershell @installArgs
if ($LASTEXITCODE -ne 0) {
    throw "Agent installer başarısız oldu: $project"
}
```

`$SourceAgentRoot` boşsa default olarak `Join-Path $SourceRepoRoot "marketing-agent"` kullan.

- [ ] **Step 7: Kök onboarding dosyalarını onar**

Apply modunda her `Projects` kökü için `scripts/install-projects-root.ps1` çalıştır:

```powershell
$rootInstaller = Join-Path $SourceRepoRoot "scripts\install-projects-root.ps1"
& powershell -NoProfile -ExecutionPolicy Bypass -File $rootInstaller `
    -TargetRoot $root `
    -SourceRepoRoot $SourceRepoRoot `
    -RepoUrl $RepoUrl `
    -Version $Version
```

Bu işlem `.pa/marketer-profile.md` ve proje klasörlerini korumalı.

- [ ] **Step 8: Kalıntı temizliğini açık bayraklara bağla**

`-CleanupStrayRepo` verilirse `Projects/Marketonomy` klasörünü silmeden önce bunun gerçekten kaynak repo olduğunu doğrula:

```powershell
$candidate = Join-Path $root "Marketonomy"
$isRepoClone = (Test-Path (Join-Path $candidate "marketing-agent\AGENTS.md")) -and
               (Test-Path (Join-Path $candidate ".git"))
if ($CleanupStrayRepo -and $Apply -and $isRepoClone) {
    Remove-Item -LiteralPath $candidate -Recurse -Force
}
```

`-CleanupEmptyCodexArtifacts` verilirse `.git`, `.agents`, `.codex` sadece boşsa sil:

```powershell
$artifact = Join-Path $root ".git"
if ((Test-Path $artifact) -and -not (Get-ChildItem -LiteralPath $artifact -Force -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1)) {
    Remove-Item -LiteralPath $artifact -Force
}
```

- [ ] **Step 9: Repair test fixture'ını yaz**

`scripts/test_repair_installed_marketing_agent.ps1` şu fixture'ları üretmeli:

```text
Projects/
  AGENTS.md
  .pa/onboarding-install.json
  broken-agent-missing-file/
  broken-agent-missing-package/
  broken-nul-and-mojibake/
  Marketonomy/
  .git/
  .agents/
  .codex/
```

Test, önce dry-run çalıştırmalı ve dosya değişmediğini doğrulamalı; sonra `-Apply` çalıştırmalı ve şunları doğrulamalı:

```powershell
Assert-True (-not $projectText.Contains([string][char]0)) "Repair NUL karakterlerini temizlemeli."
Assert-True ($decisionText -match "Henüz karar kaydı yok\.") "Repair bilinen mojibake metni düzeltmeli."
Assert-True (Test-Path (Join-Path $project ".pa\agent\AGENTS.md")) "Repair eksik agent paketini kurmalı."
Assert-True ((Get-Content (Join-Path $project ".pa\agent-install.json") -Raw | ConvertFrom-Json).repo_url) "Repair repo_url metadata'sını yazmalı."
```

- [ ] **Step 10: Repair testini çalıştır**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\test_repair_installed_marketing_agent.ps1
```

Expected: `SONUC: Repair script testleri gecti.`

---

## Task 5: Manifest'i Yenile ve Release Testlerini Çalıştır

**Files:**
- Modify: `marketing-agent/release-manifest.json`

- [ ] **Step 1: Manifest'i yeniden üret**

Run:

```powershell
$agentRoot = (Resolve-Path -LiteralPath .\marketing-agent).Path
.\marketing-agent\scripts\build_release_manifest.ps1 -AgentRoot $agentRoot
```

Expected: `Manifest generated: ... files, version v5.5.1`

- [ ] **Step 2: Zorunlu kontrolleri çalıştır**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\test_mvp_compatibility.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\marketing-agent\scripts\healthcheck.ps1 -AgentRoot .\marketing-agent
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_install_update.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_workspace_create.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_marketing_agent_macos_scripts.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\test_repair_installed_marketing_agent.ps1
```

Expected: All commands exit `0`.

- [ ] **Step 3: Kaynak Türkçe karakter taramasını çalıştır**

Run:

```powershell
$root = "D:\Projects\PersonalAutonomy-MVP"
$bad = Get-ChildItem -LiteralPath $root -Recurse -File |
  Where-Object {
    $_.FullName -notmatch "\\.git\\" -and
    $_.FullName -notmatch "\\vendor\\" -and
    $_.FullName -notmatch "\\node_modules\\" -and
    $_.Extension -in ".md",".json",".ps1",".sh",".yaml",".yml",".txt"
  } |
  Where-Object {
    $text = [System.IO.File]::ReadAllText($_.FullName, [Text.Encoding]::UTF8)
    $text -match $knownMojibakePattern -or $text.Contains([string][char]0)
  }
$bad | Select-Object FullName
```

Expected: No first-party source file is listed.

---

## Task 6: 5 Drive Workspace İçin Dry-Run Raporu Al

**Files:**
- No source modification in this task.
- Read target roots:
  - `H:\.shortcut-targets-by-id\1XK89wFXc-5U9AfFuWtzQ_yKfo9zd-apB\Kaan\Projects`
  - `H:\.shortcut-targets-by-id\13RWI4Z3wACipmeiqK_EfKijF4ItbKVBW\Sümeyye Kandemir\Projects`
  - `H:\.shortcut-targets-by-id\1FuGeD6UhsNonn3fZLlx5tn4d_NmgQXi8\Batuhan Dalmış\Projects`
  - `H:\.shortcut-targets-by-id\1hqrGkIiGTpIYaWidsg0MLNcTb-jUCgdO\Basri Taha Pesen\Projects`
  - `H:\.shortcut-targets-by-id\1l1_9kcn41603ArvBc2bZrvdi1VxwMNME\Talha Ali Çimen\Projects`

- [ ] **Step 1: Dry-run komutunu çalıştır**

Run:

```powershell
$roots = @(
  "H:\.shortcut-targets-by-id\1XK89wFXc-5U9AfFuWtzQ_yKfo9zd-apB\Kaan\Projects",
  "H:\.shortcut-targets-by-id\13RWI4Z3wACipmeiqK_EfKijF4ItbKVBW\Sümeyye Kandemir\Projects",
  "H:\.shortcut-targets-by-id\1FuGeD6UhsNonn3fZLlx5tn4d_NmgQXi8\Batuhan Dalmış\Projects",
  "H:\.shortcut-targets-by-id\1hqrGkIiGTpIYaWidsg0MLNcTb-jUCgdO\Basri Taha Pesen\Projects",
  "H:\.shortcut-targets-by-id\1l1_9kcn41603ArvBc2bZrvdi1VxwMNME\Talha Ali Çimen\Projects"
)
powershell -ExecutionPolicy Bypass -File .\scripts\repair-installed-marketing-agent.ps1 `
  -ProjectsRoot $roots `
  -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
  -Version "v5.5.1" `
  -Json
```

Expected report includes the already observed issues:

```text
Kaan/x: missing-manifest-entry-file:scripts/build_release_manifest.ps1
Kaan/yorum isi li: missing-manifest-entry-file:scripts/build_release_manifest.ps1
Basri/evim-takip: missing-agent-package, project-file-has-nul
Talha/TACMNBRHNKCK: agent-install-missing-repo-url, agent-install-dead-temp-source, project-file-has-nul, decisions-file-has-known-mojibake
Batuhan Projects: stray-marketonomy-repo
Basri Projects: stray-marketonomy-repo, stray-dot-git, stray-dot-agents, stray-dot-codex
Talha Projects: stray-marketonomy-repo, stray-dot-git, stray-dot-agents, stray-dot-codex
```

- [ ] **Step 2: Dry-run raporunu kullanıcıya özetle**

Final apply öncesi kullanıcıya şu kararları açıkça sor:

```text
Onarım agent paketlerini yeniden kuracak, NUL/mojibake metinlerini düzeltecek ve metadata repo_url alanlarını yazacak.
Kalıntı Marketonomy/.git/.agents/.codex klasörlerini de temizlememi ister misin?
```

Bu planın mevcut talimatına göre bu ikinci onay alınmadan `-Apply` çalıştırılmaz.

---

## Task 7: Kullanıcı Onayından Sonra Drive Workspace Onarımını Uygula

**Files:**
- Modify only after explicit user approval:
  - Each target `Projects/AGENTS.md`
  - Each target `Projects/onboarding-guide.md`
  - Each target `Projects/.pa/onboarding/`
  - Each target project `AGENTS.md`
  - Each target project `.pa/agent/`
  - Each target project `.pa/agent-install.json`
  - Known corrupt `PROJE.md` and `KARARLAR.md` files
- Preserve:
  - `PROJE.md` identity values
  - `DURUM.md`
  - `.pa/project/`
  - all numbered project folders and user-created outputs

- [ ] **Step 1: Apply without cleanup first**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\repair-installed-marketing-agent.ps1 `
  -ProjectsRoot $roots `
  -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
  -Version "v5.5.1" `
  -Apply
```

Expected: agent packages repaired, metadata repaired, NUL/mojibake fixed. Stray `Marketonomy`, `.git`, `.agents`, `.codex` remain unless cleanup flags are approved.

- [ ] **Step 2: If approved, cleanup stray repo/artifacts**

Run only if user explicitly approves cleanup:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\repair-installed-marketing-agent.ps1 `
  -ProjectsRoot $roots `
  -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
  -Version "v5.5.1" `
  -Apply `
  -CleanupStrayRepo `
  -CleanupEmptyCodexArtifacts
```

Expected: Only verified `Projects/Marketonomy` repo clones and empty `.git`, `.agents`, `.codex` artifacts are removed.

- [ ] **Step 3: Post-apply verification**

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\repair-installed-marketing-agent.ps1 `
  -ProjectsRoot $roots `
  -RepoUrl "https://github.com/kocakburhan/Marketonomy" `
  -Version "v5.5.1" `
  -Json
```

Expected:

```text
No project has missing-agent-package.
No project has project-file-has-nul.
No project has decisions-file-has-known-mojibake.
No project has agent-install-missing-repo-url.
No installed agent package has missing manifest entry files.
```

---

## Task 8: Son Durum Raporu

**Files:**
- No further modifications.

- [ ] **Step 1: Kullanıcıya kısa sonuç raporu ver**

Rapor şu alanları içermeli:

```text
Kaynak repo düzeltmeleri:
- Türkçe karakter sözleşmesi eklendi.
- Create/install/update/healthcheck düzeltildi.
- Repair script eklendi.
- Manifest yenilendi.
- Testler geçti.

Drive onarım sonucu:
- Kaan: x, yorum isi li
- Sümeyye: sadece onboarding
- Batuhan: sadece onboarding + cleanup durumu
- Basri: evim-takip
- Talha: TACMNBRHNKCK

Kalan açık karar:
- Stray repo/artifact cleanup uygulanmadıysa kullanıcı isterse ayrı çalıştırılabilir.
```

---

## Self-Review

**Spec coverage:** Plan, kullanıcının istediği tüm konuları kapsıyor: kaynak sorunları, mevcut 5 Drive workspace, kullanıcıya iş yaptırmadan merkezi uygulama, dry-run, final onay, Türkçe karakterlerin doğru kullanılması, `.pa/agent` erişilebilirliği, orchestrator routing, manifest, update metadata, NUL/mojibake ve kalıntı klasörler.

**Placeholder scan:** Planda `TBD`, `TODO`, `later`, “uygun hata yönetimi ekle” gibi belirsiz uygulama maddesi yok. Her görevde dosya, komut ve beklenen sonuç var.

**Type/signature consistency:** Repair script parametreleri tüm komutlarda aynı: `-ProjectsRoot`, `-ProjectRoot`, `-SourceRepoRoot`, `-SourceAgentRoot`, `-RepoUrl`, `-Version`, `-Apply`, `-CleanupStrayRepo`, `-CleanupEmptyCodexArtifacts`, `-Json`. Test ve apply komutları aynı arayüzü kullanıyor.

**Risk review:**
- En yüksek risk Drive sync üzerinde çok dosyalı `.pa/agent` yeniden kurulumudur. Mitigasyon: önce dry-run, sonra resmi installer, sonra manifest doğrulaması.
- Kullanıcı dosyalarına zarar verme riski `PROJE.md` ve `KARARLAR.md` düzeltmelerinde var. Mitigasyon: sadece bilinen NUL/mojibake desenleri değiştirilecek; kimlik alanları ve karar geçmişi yeniden yazılmayacak.
- Kalıntı repo/artifact silme riski var. Mitigasyon: ayrı bayrak ve ayrı açık onay olmadan cleanup yapılmayacak.
- Türkçe karakter düzeltmesi testlerin ASCII beklentileriyle çakışabilir. Mitigasyon: kullanıcıya dönük metinlerde Türkçe karakter zorunlu, teknik path/JSON alanlarında mevcut ASCII sözleşmesi korunacak.
