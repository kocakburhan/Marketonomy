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

function Read-Utf8([string]$Path) {
    [System.IO.File]::ReadAllText($Path, $Utf8)
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { Add-Failure $Message }
}

function Assert-FileContains([string]$Path, [string]$Pattern, [string]$Message) {
    if (-not (Test-Path -LiteralPath $Path)) {
        Add-Failure "$Message Dosya yok: $Path"
        return
    }
    $content = Read-Utf8 $Path
    if ($content -notmatch $Pattern) {
        Add-Failure $Message
    }
}

$rootInstall = Join-Path $RepoRoot "scripts\install-marketing-agent.sh"
$rootCreate = Join-Path $RepoRoot "scripts\create-project.sh"
$agentCheck = Join-Path $RepoRoot "marketing-agent\scripts\check-update.sh"
$agentUpdate = Join-Path $RepoRoot "marketing-agent\scripts\update-agent.sh"
$bootstrap = Join-Path $RepoRoot "marketing-agent\templates\workspace-bootstrap-AGENTS.md"
$manifest = Join-Path $RepoRoot "marketing-agent\release-manifest.json"

foreach ($script in @($rootInstall, $rootCreate, $agentCheck, $agentUpdate)) {
    Assert-True (Test-Path -LiteralPath $script) "macOS script bulunmali: $script"
    if (Test-Path -LiteralPath $script) {
        Assert-FileContains $script '^#!/usr/bin/env bash' "macOS script bash shebang ile baslamali: $script"
        Assert-FileContains $script 'set -euo pipefail' "macOS script kati hata modunda calismali: $script"
    }
}

Assert-FileContains $rootInstall 'PROJE\.md' "macOS installer PROJE.md kimligini dogrulamali."
Assert-FileContains $rootInstall '\.pa/project/state\.json' "macOS installer .pa/project/state.json kimligini dogrulamali."
Assert-FileContains $rootInstall 'DEGERLENDIRME\.md|\.pa/evaluation' "macOS installer eski evaluation workspace isaretlerini reddetmeli."
Assert-FileContains $rootInstall 'release-manifest\.json' "macOS installer release manifest dogrulamali."
Assert-FileContains $rootInstall 'sha256sum|shasum -a 256' "macOS installer SHA-256 hash dogrulamasi yapmali."
Assert-FileContains $rootInstall 'agent\.installing' "macOS installer staging klasoruyle atomik kurulum yapmali."
Assert-FileContains $rootInstall 'agent\.backup' "macOS installer rollback icin backup kullanmali."
Assert-FileContains $rootInstall 'agent-install\.json' "macOS installer kurulum metadata dosyasini yazmali."
Assert-FileContains $rootInstall 'workspace-bootstrap-AGENTS\.md' "macOS installer bootstrap sablonunu kullanmali."

Assert-FileContains $rootCreate 'install-marketing-agent\.sh' "macOS create script macOS installer'i cagirmali."
Assert-FileContains $rootCreate '\.pa/marketer-profile\.md' "macOS create script ana marketer profilini otomatik bulmali."
Assert-FileContains $rootCreate 'trap .*cleanup' "macOS create script hata halinde yarim workspace'i temizlemeli."
Assert-FileContains $rootCreate '05-haftalik-planlar' "macOS create script haftalik plan iskeletini olusturmali."
Assert-FileContains $rootCreate '11-notlar/bilgi-haritasi' "macOS create script bilgi-haritasi klasorunu olusturmali."

Assert-FileContains $agentCheck 'agent-install\.json' "macOS check-update metadata repo bilgisini okuyabilmeli."
Assert-FileContains $agentCheck 'git ls-remote' "macOS check-update RepoUrl ile tag kontrolu yapabilmeli."
Assert-FileContains $agentCheck '--json' "macOS check-update JSON cikti opsiyonu sunmali."

Assert-FileContains $agentUpdate '--yes' "macOS update kullanici onayi icin --yes gerektirmeli."
Assert-FileContains $agentUpdate '\.pa/project' "macOS update .pa/project alanini korumali."
Assert-FileContains $agentUpdate 'agent\.updating' "macOS update staging klasoru kullanmali."
Assert-FileContains $agentUpdate 'agent\.backup' "macOS update rollback icin backup kullanmali."
Assert-FileContains $agentUpdate 'release-manifest\.json' "macOS update manifest dogrulamali."

Assert-FileContains $bootstrap 'check-update\.sh' "Bootstrap macOS update kontrol scriptini anlatmali."
Assert-FileContains $bootstrap 'update-agent\.sh' "Bootstrap macOS update scriptini anlatmali."

if (Test-Path -LiteralPath $manifest) {
    $manifestJson = Read-Utf8 $manifest | ConvertFrom-Json
    $manifestPaths = @($manifestJson.files | ForEach-Object { $_.path })
    foreach ($path in @("scripts/check-update.sh", "scripts/update-agent.sh")) {
        Assert-True ($manifestPaths -contains $path) "Release manifest macOS agent scriptini icermeli: $path"
    }
}

if ($failures.Count -gt 0) {
    Write-Output "SONUC: $($failures.Count) macOS script sozlesme hatasi bulundu."
    exit 1
}

Write-Output "SONUC: macOS script sozlesme testleri gecti."
exit 0
