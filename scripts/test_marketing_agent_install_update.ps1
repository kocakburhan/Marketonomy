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

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) {
        New-Item -ItemType Directory -Force -Path $parent | Out-Null
    }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Copy-AgentFixture([string]$SourceAgentRoot, [string]$Version) {
    $fixture = Join-Path $env:TEMP ("pa-agent-fixture-" + [guid]::NewGuid().ToString("N"))
    Copy-Item -LiteralPath $SourceAgentRoot -Destination $fixture -Recurse -Force
    $versionPath = Join-Path $fixture "agent-version.json"
    $versionJson = Read-Utf8 $versionPath | ConvertFrom-Json
    $versionJson.version = $Version
    $versionJson.release_status = "test"
    [System.IO.File]::WriteAllText($versionPath, (($versionJson | ConvertTo-Json -Depth 6) + "`n"), $Utf8)
    powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $fixture "scripts\build_release_manifest.ps1") -AgentRoot $fixture -Version $Version | Out-Null
    return $fixture
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) {
        Add-Failure $Message
    }
}

function Assert-Equal([object]$Actual, [object]$Expected, [string]$Message) {
    if ($Actual -ne $Expected) {
        Add-Failure "$Message Beklenen: $Expected, gercek: $Actual"
    }
}

$sourceAgentRoot = Join-Path $RepoRoot "marketing-agent"
$installer = Join-Path $RepoRoot "scripts\install-marketing-agent.ps1"
$workspace = Join-Path $env:TEMP ("pa-workspace-test-" + [guid]::NewGuid().ToString("N"))
$invalidWorkspace = Join-Path $env:TEMP ("pa-invalid-workspace-test-" + [guid]::NewGuid().ToString("N"))
$oldAgent = $null
$newAgent = $null

try {
    $oldAgent = Copy-AgentFixture -SourceAgentRoot $sourceAgentRoot -Version "v5.0.0"
    $newAgent = Copy-AgentFixture -SourceAgentRoot $sourceAgentRoot -Version "v5.1.0"
    New-Item -ItemType Directory -Force -Path $invalidWorkspace | Out-Null
    $invalidInstallRejected = $false
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
            -TargetRoot $invalidWorkspace `
            -SourceAgentRoot $oldAgent `
            -Version "v5.0.0" 2>&1 | Out-Null
    } catch {
        $invalidInstallRejected = $true
    }
    Assert-True $invalidInstallRejected "Installer kimlik dosyalari olmayan hedefi reddetmeli."
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $invalidWorkspace ".pa\agent"))) "Gecersiz hedefte agent paketi olusmamali."

    Write-Utf8 (Join-Path $invalidWorkspace "PROJE.md") "project_id: project-conflict`nidea_id: idea-conflict`n"
    Write-Utf8 (Join-Path $invalidWorkspace ".pa\project\state.json") "{`"project_id`":`"project-conflict`",`"idea_id`":`"idea-conflict`"}`n"
    Write-Utf8 (Join-Path $invalidWorkspace "DEGERLENDIRME.md") "idea_id: idea-conflict`n"
    $mixedWorkspaceRejected = $false
    try {
        powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
            -TargetRoot $invalidWorkspace `
            -SourceAgentRoot $oldAgent `
            -Version "v5.0.0" 2>&1 | Out-Null
    } catch {
        $mixedWorkspaceRejected = $true
    }
    Assert-True $mixedWorkspaceRejected "Installer karisik veya yarim kalmis workspace isaretlerini reddetmeli."
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $invalidWorkspace ".pa\agent"))) "Karisik hedefte agent paketi olusmamali."

    New-Item -ItemType Directory -Force -Path $workspace | Out-Null

    Write-Utf8 (Join-Path $workspace "PROJE.md") "project_id: project-a`nidea_id: idea-a`n`nKullanici proje ilerlemesi`n"
    Write-Utf8 (Join-Path $workspace "DURUM.md") "Calisma devam ediyor`n"
    Write-Utf8 (Join-Path $workspace ".pa\project\state.json") "{`"project_id`":`"project-a`",`"idea_id`":`"idea-a`"}`n"

    powershell -NoProfile -ExecutionPolicy Bypass -File $installer `
        -TargetRoot $workspace `
        -SourceAgentRoot $oldAgent `
        -RepoUrl "https://github.com/example/personalautonomy-mvp" `
        -Version "v5.0.0" | Out-Null

    $installMetadataPath = Join-Path $workspace ".pa\agent-install.json"
    Assert-True (Test-Path -LiteralPath $installMetadataPath) ".pa/agent-install.json olusmali"
    if (Test-Path -LiteralPath $installMetadataPath) {
        $installMetadata = Read-Utf8 $installMetadataPath | ConvertFrom-Json
        Assert-Equal $installMetadata.repo_url "https://github.com/example/personalautonomy-mvp" "Repo URL metadata'ya yazilmali."
        Assert-Equal $installMetadata.installed_version "v5.0.0" "Kurulan surum metadata'ya yazilmali."
        Assert-Equal $installMetadata.update_policy "ask" "Varsayilan update policy ask olmali."
    }

    Assert-True (Test-Path -LiteralPath (Join-Path $workspace ".pa\agent\scripts\check-update.ps1")) "check-update.ps1 release paketinde olmali"
    Assert-True (Test-Path -LiteralPath (Join-Path $workspace ".pa\agent\scripts\update-agent.ps1")) "update-agent.ps1 release paketinde olmali"

    $bootstrap = Read-Utf8 (Join-Path $workspace "AGENTS.md")
    Assert-True ($bootstrap -match "check-update\.ps1") "Bootstrap update kontrol kuralini icermeli."
    Assert-True ($bootstrap -match "update-agent\.ps1") "Bootstrap update script kuralini icermeli."

    $beforeProject = Read-Utf8 (Join-Path $workspace "PROJE.md")
    $beforeState = Read-Utf8 (Join-Path $workspace ".pa\project\state.json")
    Write-Utf8 (Join-Path $workspace ".pa\agent\LOCAL_MARKER.txt") "Bu dosya update sonrasi kalmamali`n"

    $updateScript = Join-Path $workspace ".pa\agent\scripts\update-agent.ps1"
    powershell -NoProfile -ExecutionPolicy Bypass -File $updateScript `
        -TargetRoot $workspace `
        -SourceAgentRoot $newAgent `
        -Version "v5.1.0" `
        -Yes | Out-Null

    $afterVersion = Read-Utf8 (Join-Path $workspace ".pa\agent\agent-version.json") | ConvertFrom-Json
    Assert-Equal $afterVersion.version "v5.1.0" "Update sonrasi agent surumu yeni surum olmali."
    Assert-True (-not (Test-Path -LiteralPath (Join-Path $workspace ".pa\agent\LOCAL_MARKER.txt"))) "Update .pa/agent paketini temiz kopyayla degistirmeli."
    Assert-Equal (Read-Utf8 (Join-Path $workspace "PROJE.md")) $beforeProject "PROJE.md update sirasinda korunmali."
    Assert-Equal (Read-Utf8 (Join-Path $workspace ".pa\project\state.json")) $beforeState ".pa/project/state.json update sirasinda korunmali."

    $updatedMetadata = Read-Utf8 $installMetadataPath | ConvertFrom-Json
    Assert-Equal $updatedMetadata.installed_version "v5.1.0" "Update metadata surumunu yenilemeli."
    Assert-True ([bool]$updatedMetadata.updated_at) "Update metadata updated_at yazmali."

    $checkScript = Join-Path $workspace ".pa\agent\scripts\check-update.ps1"
    $checkOutput = powershell -NoProfile -ExecutionPolicy Bypass -File $checkScript `
        -TargetRoot $workspace `
        -SourceAgentRoot $newAgent `
        -Version "v5.1.0" `
        -Json
    $check = ($checkOutput -join "`n") | ConvertFrom-Json
    Assert-Equal $check.status "up-to-date" "Ayni surum check-update sonucu guncel olmali."
} catch {
    Add-Failure $_.Exception.Message
} finally {
    foreach ($path in @($workspace, $invalidWorkspace, $oldAgent, $newAgent)) {
        if ($path -and (Test-Path -LiteralPath $path)) {
            Remove-Item -LiteralPath $path -Recurse -Force
        }
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) install/update davranis hatasi bulundu."
    exit 1
}

Write-Output "SONUC: Install/update davranis testleri gecti."
exit 0
