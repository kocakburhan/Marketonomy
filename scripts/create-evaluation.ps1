param(
    [Parameter(Mandatory = $true)]
    [string]$TargetRoot,
    [string]$Title = "Yeni Degerlendirme",
    [string]$IdeaId,
    [string]$SourceAgentRoot,
    [string]$RepoUrl,
    [string]$Version = "latest",
    [string]$MarketerProfilePath
)

$ErrorActionPreference = "Stop"
$Utf8 = [System.Text.UTF8Encoding]::new($false)

function Write-Utf8([string]$Path, [string]$Content) {
    $parent = Split-Path -Parent $Path
    if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, $Utf8)
}

function Assert-SafeTarget([string]$Root) {
    if (Test-Path -LiteralPath $Root) {
        $item = Get-Item -LiteralPath $Root
        if (-not $item.PSIsContainer) { throw "TargetRoot klasor olmali: $Root" }
        $children = Get-ChildItem -LiteralPath $Root -Force
        if ($children.Count -gt 0) {
            throw "TargetRoot bos olmali; mevcut proje dosyalari uzerine workspace olusturulmaz: $Root"
        }
    } else {
        New-Item -ItemType Directory -Force -Path $Root | Out-Null
    }
    return (Resolve-Path -LiteralPath $Root).Path
}

function New-LocalId([string]$Prefix) {
    return "$Prefix-" + (Get-Date -Format "yyyyMMddHHmmss") + "-" + ([guid]::NewGuid().ToString("N").Substring(0, 8))
}

function Get-MarketerRootProfilePath([string]$Target) {
    $resolvedTarget = if (Test-Path -LiteralPath $Target) {
        (Resolve-Path -LiteralPath $Target).Path
    } else {
        [System.IO.Path]::GetFullPath($Target)
    }
    $parent = Split-Path -Parent $resolvedTarget
    if (-not $parent) { return $null }

    $parentName = Split-Path -Leaf $parent
    $marketerRoot = if ($parentName -in @("idea-workspace", "projects")) {
        Split-Path -Parent $parent
    } else {
        $parent
    }
    if (-not $marketerRoot) { return $null }

    $profilePath = Join-Path $marketerRoot ".pa\marketer-profile.md"
    if (Test-Path -LiteralPath $profilePath) { return $profilePath }
    return $null
}

if ([string]::IsNullOrWhiteSpace($IdeaId)) {
    $IdeaId = New-LocalId "idea"
}

$target = Assert-SafeTarget $TargetRoot
$now = Get-Date

if (-not $MarketerProfilePath) {
    $MarketerProfilePath = Get-MarketerRootProfilePath $target
}

foreach ($folder in @("kaynaklar", "ciktilar", "notlar", ".pa\evaluation")) {
    New-Item -ItemType Directory -Force -Path (Join-Path $target $folder) | Out-Null
}

Write-Utf8 (Join-Path $target "DEGERLENDIRME.md") @"
# $Title

idea_id: $IdeaId

## Ozet
- Durum: Yeni degerlendirme workspace'i
- Olusturma tarihi: $($now.ToString("yyyy-MM-dd"))
- Olusturma akisi: approved create flow, Codex + Google Drive first

"@

Write-Utf8 (Join-Path $target "DURUM.md") @"
# Durum

- Workspace turu: Evaluation
- Aktif is: Baslangic hazirligi
- Sonraki adim: Fikri ve kaynaklari degerlendirme akisiyle incele.

"@

Write-Utf8 (Join-Path $target "RAPOR.md") "# Degerlendirme Raporu`n`nTaslak rapor burada olusturulur.`n"
Write-Utf8 (Join-Path $target ".pa\evaluation\active-task.md") "# Active Task`n`nDurum: Bos`n"
Write-Utf8 (Join-Path $target ".pa\evaluation\settings.json") "{`"timezone`":`"Europe/Istanbul`"}`n"

$state = [ordered]@{
    schema_version = "1.0"
    workspace_type = "evaluation"
    idea_id = $IdeaId
    title = $Title
    created_at = $now.ToString("o")
    created_by = "scripts/create-evaluation.ps1"
}
Write-Utf8 (Join-Path $target ".pa\evaluation\state.json") (($state | ConvertTo-Json -Depth 6) + "`n")

if ($MarketerProfilePath) {
    $profileSource = Resolve-Path -LiteralPath $MarketerProfilePath -ErrorAction Stop
    Copy-Item -LiteralPath $profileSource.Path -Destination (Join-Path $target ".pa\evaluation\marketer-profile.md") -Force
}

$installer = Join-Path (Split-Path -Parent $PSScriptRoot) "scripts\install-marketing-agent.ps1"
$installArgs = @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $installer, "-TargetRoot", $target, "-Version", $Version)
if ($SourceAgentRoot) { $installArgs += @("-SourceAgentRoot", $SourceAgentRoot) }
if ($RepoUrl) { $installArgs += @("-RepoUrl", $RepoUrl) }
& powershell @installArgs | Out-String | Write-Verbose
if ($LASTEXITCODE -ne 0) { throw "Marketing Agent kurulumu basarisiz oldu." }

Write-Output "SONUC: Evaluation workspace olusturuldu."
Write-Output "Path: $target"
Write-Output "idea_id: $IdeaId"
