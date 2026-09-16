Write-Host "🚀 Installation de Config-AI en cours..." -ForegroundColor Cyan

$projectRoot = Get-Location

# 0. Contrôle et sécurité Git
Write-Host "🛡️ Vérification de l'environnement Git..." -ForegroundColor Cyan
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ ATTENTION : Git n'est pas détecté sur votre machine !" -ForegroundColor Red
    Write-Host "👉 Pour l'installer sous Windows : winget install --id Git.Git -e --source winget" -ForegroundColor Yellow
} else {
    $isGit = git rev-parse --is-inside-work-tree 2>$null
    if ($isGit -ne "true") {
        Write-Host "📦 Aucun dépôt Git détecté : initialisation automatique (git init)..." -ForegroundColor Yellow
        git init
        Write-Host "✅ Dépôt Git initialisé avec succès !" -ForegroundColor Green
    } else {
        Write-Host "✅ Dépôt Git actif détecté." -ForegroundColor Green
    }
}

# 1. Claude Code
$claudeSkills = "$projectRoot\.claude\skills"
New-Item -ItemType Directory -Path $claudeSkills -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $claudeSkills -Recurse -Force
if (-not (Test-Path "$projectRoot\CLAUDE.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\CLAUDE.md" -Destination "$projectRoot\CLAUDE.md"
    Write-Host "📄 Template CLAUDE.md installé." -ForegroundColor Gray
}

# 2. Google Antigravity / Gemini
if (-not (Test-Path "$projectRoot\GEMINI.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\GEMINI.md" -Destination "$projectRoot\GEMINI.md"
    Write-Host "📄 Template GEMINI.md installé." -ForegroundColor Gray
}

$antigravitySkills = "$env:USERPROFILE\.gemini\config\skills"
if (Test-Path "$env:USERPROFILE\.gemini") {
    New-Item -ItemType Directory -Path $antigravitySkills -Force | Out-Null
    Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $antigravitySkills -Recurse -Force
    Write-Host "🧠 Compétences déployées pour Antigravity (~/.gemini/config/skills)." -ForegroundColor Gray
}

# 3. Project Context
if (-not (Test-Path "$projectRoot\PROJECT_CONTEXT.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\PROJECT_CONTEXT.md" -Destination "$projectRoot\PROJECT_CONTEXT.md"
    Write-Host "📋 Template PROJECT_CONTEXT.md installé." -ForegroundColor Gray
}

Write-Host ""
Write-Host "✅ Configuration installée avec succès dans votre projet !" -ForegroundColor Green
Write-Host "👈 Prochaines étapes :" -ForegroundColor Cyan
Write-Host "   1. Complétez PROJECT_CONTEXT.md avec les spécificités de votre projet." -ForegroundColor White
Write-Host "   2. Lancez votre agent avec la compétence 'architecture-challenge'." -ForegroundColor White
