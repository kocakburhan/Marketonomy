param(
    [string]$AgentRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Continue"
$requiredFailures = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

function Test-RequiredPath([string]$RelativePath) {
    $path = Join-Path $AgentRoot $RelativePath
    if (Test-Path -LiteralPath $path) {
        Write-Output "OK       $RelativePath"
    } else {
        Write-Output "FAIL     $RelativePath"
        $requiredFailures.Add($RelativePath)
    }
}

Write-Output "Marketing Agent Codex healthcheck"
Write-Output "Agent root: $AgentRoot"
Write-Output ""

Write-Output "[Required release structure]"
@(
    "AGENTS.md", "ARCHITECTURE.md", "SKILLS.md", "agents", "pipelines", "skills",
    "scripts", "templates", "mcps.json", "agent-version.json", "release-manifest.json"
) | ForEach-Object { Test-RequiredPath $_ }

Write-Output ""
Write-Output "[JSON]"
foreach ($jsonName in @("mcps.json", "agent-version.json", "release-manifest.json")) {
    $path = Join-Path $AgentRoot $jsonName
    try {
        [System.IO.File]::ReadAllText($path) | ConvertFrom-Json | Out-Null
        Write-Output "OK       $jsonName"
    } catch {
        Write-Output "FAIL     $jsonName : $($_.Exception.Message)"
        $requiredFailures.Add($jsonName)
    }
}

Write-Output ""
Write-Output "[Skills]"
$skillDirs = Get-ChildItem -LiteralPath (Join-Path $AgentRoot "skills") -Directory
$invalidSkills = 0
foreach ($skillDir in $skillDirs) {
    if (-not (Test-Path -LiteralPath (Join-Path $skillDir.FullName "SKILL.md")) -or
        -not (Test-Path -LiteralPath (Join-Path $skillDir.FullName "agents\openai.yaml"))) {
        Write-Output "FAIL     $($skillDir.Name)"
        $invalidSkills++
    }
}
if ($invalidSkills -eq 0) {
    Write-Output "OK       $($skillDirs.Count) skill, SKILL.md ve agents/openai.yaml mevcut"
} else {
    $requiredFailures.Add("$invalidSkills gecersiz skill")
}

Write-Output ""
Write-Output "[Optional local capabilities]"
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Output "AVAILABLE node $(node --version)"
} else {
    Write-Output "OPTIONAL  Node.js bulunamadi; app-store MCP yerel calistirilamaz."
    $warnings.Add("Node.js")
}

$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) {
    Write-Output "AVAILABLE $(& python --version 2>&1)"
} else {
    Write-Output "OPTIONAL  Python PATH uzerinde bulunamadi; Python yardimci scriptleri calistirilamaz."
    $warnings.Add("Python")
}

$appStoreServer = Join-Path $AgentRoot "vendor\mcp-appstore\server.js"
if (Test-Path -LiteralPath $appStoreServer) {
    Write-Output "AVAILABLE optional app-store MCP payload"
} else {
    Write-Output "OPTIONAL  app-store MCP vendor payload'i yok; web veya manuel fallback kullanilir."
    $warnings.Add("app-store MCP")
}

Write-Output ""
if ($requiredFailures.Count -gt 0) {
    Write-Output "SONUC: BASARISIZ - $($requiredFailures.Count) zorunlu sorun."
    exit 1
}

Write-Output "SONUC: HAZIR - zorunlu release yapisi gecerli; $($warnings.Count) opsiyonel capability uyarisi."
exit 0
