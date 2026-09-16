Write-Host "🚀 Installation de Config-AI en cours..." -ForegroundColor Cyan

$projectRoot = Get-Location

# Claude Code
$claudeSkills = "$projectRoot\.claude\skills"
New-Item -ItemType Directory -Path $claudeSkills -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $claudeSkills -Recurse -Force
if (-not (Test-Path "$projectRoot\CLAUDE.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\CLAUDE.md" -Destination "$projectRoot\CLAUDE.md"
}

# Antigravity
$antigravitySkills = "$env:USERPROFILE\.gemini\config\skills"
if (Test-Path "$env:USERPROFILE\.gemini") {
    New-Item -ItemType Directory -Path $antigravitySkills -Force | Out-Null
    Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $antigravitySkills -Recurse -Force
}

# Project Context
if (-not (Test-Path "$projectRoot\PROJECT_CONTEXT.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\PROJECT_CONTEXT.md" -Destination "$projectRoot\PROJECT_CONTEXT.md"
}

Write-Host "✅ Configuration installée avec succès dans votre projet !" -ForegroundColor Green
Write-Host "👈 Remplissez PROJECT_CONTEXT.md puis lancez votre IQ avec la compétence 'architecture-challenge'." -ForegroundColor Yellow
