$ErrorActionPreference = 'Stop'
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $RepoRoot) { $RepoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$Errors = 0

function Fail($msg) {
    Write-Error "FAIL: $msg"
    $script:Errors++
}

# --- JSON file validation ---
Write-Host "Validating JSON files..."
foreach ($f in @(
    '.claude-plugin/plugin.json',
    'package.json'
)) {
    $path = Join-Path $RepoRoot $f
    if (-not (Test-Path $path)) {
        Fail "Missing JSON file: $f"
    } else {
        try { Get-Content $path -Raw | ConvertFrom-Json | Out-Null }
        catch { Fail "Invalid JSON: $f" }
    }
}

# --- Required files ---
Write-Host "Validating required files..."
foreach ($f in @(
    'skills/scm-ai-score/SKILL.md',
    'commands/scm-ai-score.md',
    'LICENSE',
    'README.md'
)) {
    $path = Join-Path $RepoRoot $f
    if (-not (Test-Path $path)) { Fail "Missing required file: $f" }
}

# --- Frontmatter validation ---
Write-Host "Validating frontmatter..."
function Check-Frontmatter($filePath) {
    $lines = Get-Content $filePath
    if ($lines.Count -eq 0 -or $lines[0].Trim() -ne '---') {
        Fail "Missing frontmatter: $filePath"; return
    }
    $termIdx = -1
    for ($i = 1; $i -lt $lines.Count; $i++) {
        if ($lines[$i].Trim() -eq '---') { $termIdx = $i; break }
    }
    if ($termIdx -lt 0) { Fail "Missing frontmatter terminator: $filePath"; return }
    $fm = ($lines[1..($termIdx-1)]) -join "`n"
    if ($fm -notmatch '(?m)^name:\s*.+') { Fail "Missing 'name' in frontmatter: $filePath" }
    if ($fm -notmatch '(?m)^description:\s*\|') { Fail "Missing block 'description' in frontmatter: $filePath" }
}

Check-Frontmatter (Join-Path $RepoRoot 'skills/scm-ai-score/SKILL.md')
Check-Frontmatter (Join-Path $RepoRoot 'commands/scm-ai-score.md')

# --- Eval harness validation ---
Write-Host "Validating eval harness..."
$evalFile = Join-Path $RepoRoot 'tests/eval-anchors.md'
if (-not (Test-Path $evalFile)) {
    Fail "Missing eval harness: tests/eval-anchors.md"
} else {
    $evalContent = Get-Content $evalFile -Raw
    foreach ($anchor in @('ANCHOR_A', 'ANCHOR_B', 'ANCHOR_C')) {
        if ($evalContent -notmatch $anchor) {
            Fail "Eval harness missing anchor: $anchor"
        }
    }
}

# --- Result ---
if ($Errors -gt 0) {
    Write-Host "Validation FAILED with $Errors error(s)."
    exit 1
}

Write-Host "Validation passed."
