param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)
$failures = [System.Collections.Generic.List[string]]::new()

function Add-Failure([string]$Message) {
    $failures.Add($Message)
    Write-Output "FAIL: $Message"
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { Add-Failure $Message }
}

function Assert-Equal([string]$Actual, [string]$Expected, [string]$Message) {
    if ($Actual -cne $Expected) { Add-Failure $Message }
}

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

$installer = Join-Path $RepoRoot "scripts\install-projects-root.ps1"
$agentRoot = Join-Path $RepoRoot "marketing-agent"
$canonicalGuide = Join-Path $agentRoot "agents\onboarding-guide.md"
$tmpRoot = Join-Path $env:TEMP ("pa-projects-root-test-" + [guid]::NewGuid().ToString("N"))
$projectsRoot = Join-Path $tmpRoot "Projects"

try {
    Assert-True (Test-Path -LiteralPath $installer) "install-projects-root.ps1 bulunmali."
    if (-not (Test-Path -LiteralPath $installer)) {
        throw "Projects root installer olmadan test devam edemez."
    }

    New-Item -ItemType Directory -Force -Path $projectsRoot | Out-Null
    $profileContent = "Profil durumu: Tamamlandi`nEk kullanıcı bağlamı: Ben otistiğim.`n"
    Write-Utf8 (Join-Path $projectsRoot ".pa\marketer-profile.md") $profileContent
    Write-Utf8 (Join-Path $projectsRoot "mevcut-proje\kullanici-notu.md") "korunacak`n"

    powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
        -TargetRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -RepoUrl "https://github.com/kocakburhan/Marketonomy.git" `
        -Version "v5.5.2" | Out-Null

    Assert-True (Test-Path -LiteralPath (Join-Path $projectsRoot "AGENTS.md")) "Projects AGENTS.md olusmali."
    Assert-True ((Read-Utf8 (Join-Path $projectsRoot "AGENTS.md")) -match "onboarding-guide\.md") "Projects bootstrap onboarding-guide.md dosyasina yonlendirmeli."
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot "onboarding-guide.md")) (Read-Utf8 $canonicalGuide) "Projects onboarding guide canonical kaynakla ayni olmali."
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot ".pa\marketer-profile.md")) $profileContent "Mevcut marketer profili korunmali."
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot "mevcut-proje\kullanici-notu.md")) "korunacak`n" "Mevcut proje dosyasi korunmali."

    foreach ($relative in @(
        ".pa\onboarding-install.json",
        ".pa\onboarding\scripts\check-update.ps1",
        ".pa\onboarding\scripts\check-update.sh",
        ".pa\onboarding\scripts\install-projects-root.ps1",
        ".pa\onboarding\scripts\install-projects-root.sh",
        ".pa\onboarding\scripts\update-onboarding.ps1",
        ".pa\onboarding\scripts\update-onboarding.sh"
    )) {
        Assert-True (Test-Path -LiteralPath (Join-Path $projectsRoot $relative)) "Projects onboarding dosyasi olusmali: $relative"
    }

    $metadata = Read-Utf8 (Join-Path $projectsRoot ".pa\onboarding-install.json") | ConvertFrom-Json
    Assert-Equal $metadata.repo_url "https://github.com/kocakburhan/Marketonomy.git" "Onboarding metadata repo URL yazmali."
    Assert-Equal $metadata.requested_version "v5.5.2" "Onboarding metadata requested version yazmali."
    Assert-Equal $metadata.installed_version "v5.5.2" "Onboarding metadata installed version yazmali."
    Assert-Equal $metadata.update_policy "ask" "Onboarding update policy ask olmali."

    Write-Utf8 (Join-Path $projectsRoot "onboarding-guide.md") "eski onboarding`n"
    $updateScript = Join-Path $projectsRoot ".pa\onboarding\scripts\update-onboarding.ps1"
    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -File $updateScript `
            -ProjectsRoot $projectsRoot `
            -SourceRepoRoot $RepoRoot `
            -Version "v5.5.2" *> $null
        $unapprovedUpdateExitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    Assert-True ($unapprovedUpdateExitCode -ne 0) "Onboarding update -Yes olmadan reddedilmeli."

    powershell -NoProfile -ExecutionPolicy Bypass -File $updateScript `
        -ProjectsRoot $projectsRoot `
        -SourceRepoRoot $RepoRoot `
        -Version "v5.5.2" `
        -Yes | Out-Null
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot "onboarding-guide.md")) (Read-Utf8 $canonicalGuide) "Onayli onboarding update canonical guide'i yenilemeli."
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot ".pa\marketer-profile.md")) $profileContent "Onboarding update marketer profilini korumali."
    Assert-Equal (Read-Utf8 (Join-Path $projectsRoot "mevcut-proje\kullanici-notu.md")) "korunacak`n" "Onboarding update proje dosyasini korumali."

    $projectRoot = Join-Path $tmpRoot "invalid-project"
    New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot ".pa\project") | Out-Null
    Write-Utf8 (Join-Path $projectRoot "PROJE.md") "project_id: project-test`nidea_id: idea-test`n"
    Write-Utf8 (Join-Path $projectRoot ".pa\project\state.json") "{`"project_id`":`"project-test`",`"idea_id`":`"idea-test`"}`n"

    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
            -TargetRoot $projectRoot `
            -SourceRepoRoot $RepoRoot `
            -Version "v5.5.2" *> $null
        $invalidExitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    Assert-True ($invalidExitCode -ne 0) "Projects root installer proje workspace'ini reddetmeli."

    $customRoot = Join-Path $tmpRoot "custom-projects"
    New-Item -ItemType Directory -Force -Path $customRoot | Out-Null
    Write-Utf8 (Join-Path $customRoot "AGENTS.md") "kullanici ozel agents`n"
    $ErrorActionPreference = "Continue"
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
            -TargetRoot $customRoot `
            -SourceRepoRoot $RepoRoot `
            -Version "v5.5.2" *> $null
        $customAgentsExitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
    Assert-True ($customAgentsExitCode -ne 0) "Projects root installer ozel AGENTS.md dosyasini onaysiz degistirmemeli."
    Assert-Equal (Read-Utf8 (Join-Path $customRoot "AGENTS.md")) "kullanici ozel agents`n" "Reddedilen kurulum ozel AGENTS.md dosyasini korumali."

    powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
        -TargetRoot $customRoot `
        -SourceRepoRoot $RepoRoot `
        -Version "v5.5.2" `
        -ForceBootstrap | Out-Null
    $agentsBackups = @(Get-ChildItem -LiteralPath $customRoot -Filter "AGENTS.md.pre-pa-projects-install-*.bak")
    Assert-True ($agentsBackups.Count -eq 1) "ForceBootstrap eski AGENTS.md icin bir yedek birakmali."
    if ($agentsBackups.Count -eq 1) {
        Assert-Equal (Read-Utf8 $agentsBackups[0].FullName) "kullanici ozel agents`n" "AGENTS.md yedegi kullanici icerigini korumali."
    }
} catch {
    Add-Failure $_.Exception.Message
} finally {
    if (Test-Path -LiteralPath $tmpRoot) {
        Remove-Item -LiteralPath $tmpRoot -Recurse -Force
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) Projects root onboarding hatasi bulundu."
    exit 1
}

Write-Output "SONUC: Projects root onboarding testleri gecti."
exit 0
