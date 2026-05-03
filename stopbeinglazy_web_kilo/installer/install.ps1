# SmartWeb Mode Agent Installer — PowerShell (Windows)
# Installs the SmartWeb Mode agent into your Kilo Code configuration.
# Usage: .\install.ps1 [-Global] [-Project "C:\path\to\project"]
param(
  [switch]$Global,
  [string]$Project = ""
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$agentSource = Join-Path $projectRoot ".kilo\agent\smartweb.md"

if (-not (Test-Path $agentSource)) {
  Write-Host "[ERROR] Agent file not found: $agentSource" -ForegroundColor Red
  exit 1
}

# ─── Determine install target ──────────────────────────────────────────

$targetDir = $null
$targetType = ""

if ($Project -ne "") {
  $targetDir = Join-Path $Project ".kilo\agent"
  $targetType = "project ($Project)"
} elseif ($Global) {
  $targetDir = Join-Path $env:USERPROFILE ".config\kilo\agent"
  $targetType = "global ($env:USERPROFILE\.config\kilo)"
} else {
  # Auto-detect: prefer project-level installation if we're in a repo
  $gitDir = git rev-parse --show-toplevel 2>$null
  if ($gitDir) {
    $targetDir = Join-Path $gitDir ".kilo\agent"
    $targetType = "project ($gitDir)"
  } else {
    $targetDir = Join-Path $env:USERPROFILE ".config\kilo\agent"
    $targetType = "global ($env:USERPROFILE\.config\kilo)"
  }
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  SmartWeb Mode Agent Installer v6.3.0   ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Source : $agentSource"
Write-Host "Target : $targetDir  ($targetType)"
Write-Host ""

# Confirm
$confirm = Read-Host "Proceed with installation? [Y/n]"
if ($confirm -ne "" -and $confirm -ne "Y" -and $confirm -ne "y") {
  Write-Host "Installation cancelled." -ForegroundColor Yellow
  exit 0
}

# ─── Backup existing agent if present ──────────────────────────────────

$targetFile = Join-Path $targetDir "smartweb.md"
if (Test-Path $targetFile) {
  $backup = "$targetFile.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
  Copy-Item $targetFile $backup
  Write-Host "[BACKUP] Existing agent saved to: $backup" -ForegroundColor Yellow
}

# ─── Create directories and copy ───────────────────────────────────────

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
Copy-Item $agentSource $targetFile -Force

Write-Host "[SUCCESS] SmartWeb Mode agent installed!" -ForegroundColor Green
Write-Host "         $targetFile" -ForegroundColor Green
Write-Host ""
Write-Host "The SmartWeb Mode will activate on your next session." -ForegroundColor White

# ─── Verify kilo.json references the agent ─────────────────────────────

$jsonFile = Join-Path (Split-Path -Parent $targetDir) "kilo.json"
if (-not (Test-Path $jsonFile)) {
  $jsonFile = Join-Path (Split-Path -Parent $targetDir) "kilo.jsonc"
}

if (Test-Path $jsonFile) {
  Write-Host ""
  Write-Host "[INFO] Existing kilo config found at: $jsonFile" -ForegroundColor Cyan
  Write-Host "       If SmartWeb mode doesn't activate, ensure your config references the agent."
  Write-Host '       Add: "smartweb": { "file": ".kilo/agent/smartweb.md", "mode": "primary" }'
} else {
  Write-Host ""
  Write-Host "[TIP] No kilo.json found. Create one at $(Split-Path -Parent $targetDir)\kilo.json" -ForegroundColor Cyan
  Write-Host '      Example: { "agent": { "smartweb": { "file": ".kilo/agent/smartweb.md", "mode": "primary" } } }'
}

Write-Host ""
