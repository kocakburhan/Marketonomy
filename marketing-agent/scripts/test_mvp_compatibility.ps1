param(
    [string]$AgentRoot = (Split-Path -Parent $PSScriptRoot),
    [switch]$SkipManifest
)

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure([string]$Message) {
    $failures.Add($Message)
    Write-Output "FAIL: $Message"
}

function Assert-Path([string]$RelativePath) {
    if (-not (Test-Path -LiteralPath (Join-Path $AgentRoot $RelativePath))) {
        Add-Failure "Zorunlu release ogesi eksik: $RelativePath"
    }
}

function Read-Utf8([string]$Path) {
    return [System.IO.File]::ReadAllText($Path, [System.Text.UTF8Encoding]::new($false))
}

function Normalize-Tr([string]$Text) {
    return $Text -replace [char]0x0131,'i' -replace [char]0x0130,'I' -replace [char]0x015F,'s' -replace [char]0x015E,'S' -replace [char]0x011F,'g' -replace [char]0x011E,'G' -replace [char]0x00E7,'c' -replace [char]0x00C7,'C' -replace [char]0x00F6,'o' -replace [char]0x00D6,'O' -replace [char]0x00FC,'u' -replace [char]0x00DC,'U'
}

function Assert-Text([string]$FilePath, [string]$Term, [string]$Label) {
    $content = Read-Utf8 $FilePath
    $normalizedContent = Normalize-Tr $content
    $normalizedTerm = Normalize-Tr $Term
    if ($normalizedContent -notmatch [regex]::Escape($normalizedTerm)) {
        Add-Failure "$Label : $Term"
    }
}

$required = @(
    "AGENTS.md", "ARCHITECTURE.md", "SKILLS.md", "agents", "pipelines", "skills",
    "scripts", "templates", "mcps.json", "agent-version.json", "release-manifest.json"
)
$required | ForEach-Object { Assert-Path $_ }

$scanFiles = Get-ChildItem -LiteralPath $AgentRoot -Recurse -File | Where-Object {
    $_.FullName -notmatch "[\\/]vendor[\\/]" -and
    $_.FullName -notmatch "[\\/]node_modules[\\/]" -and
    $_.Extension -in @(".md", ".json", ".ps1", ".py", ".yaml") -and
    $_.Name -ne "test_mvp_compatibility.ps1"
}

foreach ($file in $scanFiles) {
    $content = Read-Utf8 $file.FullName
    if ($content.IndexOf([char]0) -ge 0) {
        Add-Failure "NUL kontrol karakteri bulundu: $($file.FullName.Substring($AgentRoot.Length + 1))"
    }
}

$forbiddenPatterns = [ordered]@{
    "OpenCode runtime referansi" = "(?i)opencode"
    "Eski sessions hafiza modeli" = "(?i)(sessions/|sessions\\|sessions\[|sessions<|sessions/)"
    "Eski state.md modeli" = "(?i)(?<!active-)state\.md"
    "Webwright runtime bagimliligi" = "(?i)webwright"
    "Puppeteer runtime bagimliligi" = "(?i)puppeteer"
    "WebFetch runtime bagimliligi" = "(?i)webfetch"
    "Sahte Codex browser tool adi" = "(?i)codex browser tools"
    "Sahte slash tool komutu" = "(?i)/(codex|webwright|browser):"
    "Eski product-marketing context dili" = "(?i)[\./]product-marketing-context\.md"
    "Desteklenmeyen repo skill yolu" = "(?i)\.agents/skills"
    "Mekanik placeholder cikti yolu" = "(?i)workspace icindeki uygun MVP"
}

foreach ($entry in $forbiddenPatterns.GetEnumerator()) {
    $hits = foreach ($file in $scanFiles) {
        $content = Read-Utf8 $file.FullName
        if ($content -match $entry.Value) { $file.FullName.Substring($AgentRoot.Length + 1) }
    }
    if ($hits) {
        Add-Failure "$($entry.Key): $($hits -join ', ')"
    }
}

$agentsPath = Join-Path $AgentRoot "AGENTS.md"
foreach ($requiredText in @(
    "DEGERLENDIRME.md",
    "PROJE.md",
    ".pa/evaluation/state.json",
    ".pa/project/state.json",
    "Europe/Istanbul",
    "05-haftalik-planlar",
    "10-final",
    "11-notlar",
    "Do not leave the workspace root",
    "Codex Research and Data Processing Standard",
    "Active Codex Skill Gate",
    "Marketer Profile Intake",
    ".pa/project/marketer-profile.md",
    ".pa/evaluation/marketer-profile.md",
    "Kocak sadakatini takdir ediyor.",
    "Default user-facing language is Turkish",
    "Kaynak ve Kanit Defteri",
    "Veri Isleme Notlari"
)) {
    Assert-Text $agentsPath $requiredText "AGENTS.md zorunlu MVP kurali icermiyor"
}

Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Marketer Profile Intake" "Onboarding marketer profil akisi eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Kocak sadakatini takdir ediyor." "Onboarding sadakat mesaji eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Marketing Agent Capability Orientation" "Onboarding agent kabiliyet oryantasyonu eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Agent ve skill haritasi" "Onboarding agent-skill haritasi eksik"
Assert-Text (Join-Path $AgentRoot "agents\onboarding-guide.md") "Marketing Agent'i zorlamak icin ornek istekler" "Onboarding guclu kullanim ornekleri eksik"
Assert-Text (Join-Path $AgentRoot "agents\orchestrator.md") "Brainstorming Skill Gate" "Aktif brainstorming skill yonlendirmesi eksik"
Assert-Text (Join-Path $AgentRoot "SKILLS.md") "is not counted as a local marketing skill" "Brainstorming aktif Codex skill notu eksik"
Assert-Text (Join-Path $AgentRoot "ARCHITECTURE.md") "Global or plugin Codex skills are optional active capabilities" "Aktif global skill mimari notu eksik"

$skillFiles = Get-ChildItem -LiteralPath (Join-Path $AgentRoot "skills") -Directory |
    ForEach-Object { Join-Path $_.FullName "SKILL.md" }

if ($skillFiles.Count -ne 41) {
    Add-Failure "Beklenen yerel skill sayisi 41, bulunan: $($skillFiles.Count)"
}

foreach ($skillFile in $skillFiles) {
    $relative = $skillFile.Substring($AgentRoot.Length + 1)
    if (-not (Test-Path -LiteralPath $skillFile)) {
        Add-Failure "Skill giris dosyasi eksik: $relative"
        continue
    }

    $content = Read-Utf8 $skillFile
    if ($content -notmatch "(?s)\A---\r?\nname:\s*[^\r\n]+\r?\ndescription:\s*[^\r\n]+(\r?\nmetadata:[^\r\n]*(\r?\n[^\r\n]+)*)?\r?\n---\r?\n") {
        Add-Failure "Codex frontmatter gecersiz veya yalnizca name/description icermiyor: $relative"
    }

    $metadataPath = Join-Path (Split-Path -Parent $skillFile) "agents\openai.yaml"
    if (-not (Test-Path -LiteralPath $metadataPath)) {
        Add-Failure "Skill UI metadata eksik: $($metadataPath.Substring($AgentRoot.Length + 1))"
    } else {
        $metadata = Read-Utf8 $metadataPath
        $skillName = (Split-Path -Leaf (Split-Path -Parent $skillFile))
        $shortMatch = [regex]::Match($metadata, 'short_description:\s*"([^"]+)"')
        if (-not $shortMatch.Success) {
            Add-Failure "Skill UI short_description eksik: $($metadataPath.Substring($AgentRoot.Length + 1))"
        } elseif ($shortMatch.Groups[1].Value.Length -lt 25 -or $shortMatch.Groups[1].Value.Length -gt 64) {
            Add-Failure "Skill UI short_description 25-64 karakter olmali: $skillName"
        }

        $promptMatch = [regex]::Match($metadata, 'default_prompt:\s*"([^"]+)"')
        if (-not $promptMatch.Success) {
            Add-Failure "Skill UI default_prompt eksik: $($metadataPath.Substring($AgentRoot.Length + 1))"
        } elseif ($promptMatch.Groups[1].Value -notmatch "Codex'te") {
            Add-Failure "Skill UI default_prompt Codex baglami icermiyor: $skillName"
        } elseif ($promptMatch.Groups[1].Value -notmatch [regex]::Escape("`$$skillName")) {
            Add-Failure "Skill UI default_prompt `$skillName referansi icermiyor: $skillName"
        }
    }
}

foreach ($agentName in @(
    "analytics-master.md", "brand-guardian.md", "campaign-manager.md", "content-creator.md",
    "growth-hacker.md", "launch-commander.md", "market-scout.md", "outreach-specialist.md",
    "product-architect.md", "schedule-coordinator.md", "strategy-analyst.md"
)) {
    $path = Join-Path $AgentRoot "agents\$agentName"
    Assert-Text $path "PersonalAutonomy Workspace Contract" "Uzman workspace sozlesmesi eksik: agents/$agentName"
}

$imageFlowRequirements = @(
    @{
        Path = "skills\social\SKILL.md"
        Terms = @("Codex Image Generation Mandate", "Generate the visual using the active image generation flow within Codex", "Gorsel Dosyasi")
    },
    @{
        Path = "skills\image\SKILL.md"
        Terms = @("Codex Image Generation Flow", "do not stop at a brief", "generate the visual using the active image generation flow within Codex")
    },
    @{
        Path = "agents\content-creator.md"
        Terms = @("Codex Image Generation Rule", "Automatically write a comprehensive prompt", "visual file path to the post file")
    }
)

foreach ($requirement in $imageFlowRequirements) {
    $path = Join-Path $AgentRoot $requirement.Path
    foreach ($term in $requirement.Terms) {
        Assert-Text $path $term "Codex image generation akisi eksik: $($requirement.Path)"
    }
}

foreach ($pipeline in Get-ChildItem -LiteralPath (Join-Path $AgentRoot "pipelines") -Filter *.md) {
    $path = $pipeline.FullName
    Assert-Text $path "PersonalAutonomy Execution Rules" "Pipeline MVP yurutme kurali eksik: pipelines/$($pipeline.Name)"
}

$ideaDiscoveryPipelines = @(
    "pipelines\idea-discovery.md",
    "pipelines\store-intelligence.md",
    "pipelines\complaint-mining.md",
    "pipelines\competitor-gap.md",
    "pipelines\trend-to-product.md",
    "pipelines\user-advantage-fit.md"
)

foreach ($pipelinePath in $ideaDiscoveryPipelines) {
    Assert-Path $pipelinePath
}

Assert-Text (Join-Path $AgentRoot "pipelines\idea-discovery.md") "Data-Driven Idea Discovery" "Idea discovery ana akisi veri-endeksli degil"
Assert-Text (Join-Path $AgentRoot "pipelines\store-intelligence.md") "Playwright" "Store intelligence Playwright fallback sozlesmesi eksik"
Assert-Text (Join-Path $AgentRoot "pipelines\user-advantage-fit.md") "First 10-50 user" "User advantage fit ilk kullanici erisim kontrolu eksik"

$researchContracts = @(
    @{
        Path = "agents\orchestrator.md"
        Terms = @("Codex Research Gate", "Kaynak ve Kanit Defteri", "Veri Isleme Notlari")
    },
    @{
        Path = "agents\market-scout.md"
        Terms = @("Codex Research Protocol", "Raw reviews", "Veri Isleme Notlari")
    },
    @{
        Path = "agents\analytics-master.md"
        Terms = @("Codex Data Processing Protocol", "Preserve raw data", "formula")
    },
    @{
        Path = "skills\web-research\SKILL.md"
        Terms = @("research backbone", "Kaynak ve Kanit Defteri", "Veri Isleme Notlari")
    },
    @{
        Path = "skills\competitor-profiling\SKILL.md"
        Terms = @("Codex Evidence and Data Rule", "Tahmin", "Kaynak ve Kanit Defteri")
    },
    @{
        Path = "skills\market-competitors\SKILL.md"
        Terms = @("Codex Evidence Matrix", "Veri yok", "Kaynak ve Kanit Defteri")
    },
    @{
        Path = "skills\market-report\SKILL.md"
        Terms = @("Evidence Ledger and Data Separation", "Revenue impact", "Veri Isleme Notlari")
    },
    @{
        Path = "skills\seo-audit\SKILL.md"
        Terms = @("Codex Evidence Rule", "Kontrol gerekli", "Kaynak ve Kanit Defteri")
    },
    @{
        Path = "skills\aso\SKILL.md"
        Terms = @("Codex and MCP Usage", "country/market parameter", "Preserve raw reviews")
    },
    @{
        Path = "skills\ai-seo\SKILL.md"
        Terms = @("Codex Research Rule", "runtime instructions", "Olcum yok")
    }
)

foreach ($contract in $researchContracts) {
    $path = Join-Path $AgentRoot $contract.Path
    foreach ($term in $contract.Terms) {
        Assert-Text $path $term "Codex research/veri sozlesmesi eksik: $($contract.Path)"
    }
}

foreach ($jsonName in @("mcps.json", "agent-version.json", "release-manifest.json")) {
    $jsonPath = Join-Path $AgentRoot $jsonName
    if (Test-Path -LiteralPath $jsonPath) {
        try { Read-Utf8 $jsonPath | ConvertFrom-Json | Out-Null }
        catch { Add-Failure "Gecersiz JSON: $jsonName - $($_.Exception.Message)" }
    }
}

if (-not $SkipManifest -and (Test-Path -LiteralPath (Join-Path $AgentRoot "release-manifest.json"))) {
    $manifest = Read-Utf8 (Join-Path $AgentRoot "release-manifest.json") | ConvertFrom-Json
    foreach ($item in $manifest.files) {
        $path = Join-Path $AgentRoot $item.path
        if (-not (Test-Path -LiteralPath $path)) {
            Add-Failure "Manifest dosyasi bulunamadi: $($item.path)"
            continue
        }
        $actual = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($actual -ne $item.sha256) {
            Add-Failure "Manifest hash uyusmazligi: $($item.path)"
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) uyumluluk hatasi bulundu."
    exit 1
}

Write-Output "SONUC: Marketing Agent Codex ve PersonalAutonomy MVP uyumluluk denetiminden gecti."
exit 0
