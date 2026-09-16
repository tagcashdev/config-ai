Write-Host "🚀 Installation de Config-AI en cours..." -ForegroundColor Cyan

$projectRoot = Get-Location

# Fonction de rafraîchissement du PATH dans la session courante (Idempotente)
function Refresh-SessionPath {
    $machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machinePath;$userPath"

    # Vérification des emplacements standards de Git sous Windows
    $commonGitPaths = @(
        "C:\Program Files\Git\cmd",
        "C:\Program Files\Git\bin",
        "$env:LOCALAPPDATA\Programs\Git\cmd",
        "$env:ProgramFiles(x86)\Git\cmd"
    )
    foreach ($path in $commonGitPaths) {
        if ((Test-Path $path) -and ($env:Path -notlike "*$path*")) {
            $env:Path = "$path;$env:Path"
        }
    }
}

# 0. Contrôle, installation autonome et sécurité Git (Idempotent)
Write-Host "🛡️ Vérification de l'environnement Git..." -ForegroundColor Cyan
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Refresh-SessionPath
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ Git non détecté. Tentative d'installation automatique et autonome..." -ForegroundColor Yellow

    $installed = $false

    # 1. Tentative via winget (standard Windows moderne)
    if (-not $installed -and (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "📦 Installation silencieuse de Git via winget..." -ForegroundColor Cyan
        try {
            $proc = Start-Process -FilePath "winget" -ArgumentList "install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements" -NoNewWindow -PassThru -Wait
            Refresh-SessionPath
            if (Get-Command git -ErrorAction SilentlyContinue) { $installed = $true }
        } catch {
            Write-Warning "Échec de l'installation via winget."
        }
    }

    # 2. Tentative via Chocolatey
    if (-not $installed -and (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "📦 Installation silencieuse de Git via Chocolatey..." -ForegroundColor Cyan
        try {
            $proc = Start-Process -FilePath "choco" -ArgumentList "install git -y --no-progress" -NoNewWindow -PassThru -Wait
            Refresh-SessionPath
            if (Get-Command git -ErrorAction SilentlyContinue) { $installed = $true }
        } catch {
            Write-Warning "Échec de l'installation via Chocolatey."
        }
    }

    # 3. Tentative via Scoop
    if (-not $installed -and (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Host "📦 Installation silencieuse de Git via Scoop..." -ForegroundColor Cyan
        try {
            $proc = Start-Process -FilePath "scoop" -ArgumentList "install git" -NoNewWindow -PassThru -Wait
            Refresh-SessionPath
            if (Get-Command git -ErrorAction SilentlyContinue) { $installed = $true }
        } catch {
            Write-Warning "Échec de l'installation via Scoop."
        }
    }

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "⚠️ Impossible d'installer Git automatiquement en mode non-administrateur." -ForegroundColor Red
        Write-Host "👉 Installez Git manuellement : https://git-scm.com/download/win" -ForegroundColor Yellow
    } else {
        Write-Host "✅ Git a été installé et configuré avec succès dans la session !" -ForegroundColor Green
    }
}

# Initialisation Git idempotente
if (Get-Command git -ErrorAction SilentlyContinue) {
    $isGit = git rev-parse --is-inside-work-tree 2>$null
    if ($isGit -ne "true") {
        Write-Host "📦 Aucun dépôt Git détecté : initialisation automatique (git init)..." -ForegroundColor Yellow
        git init
        Write-Host "✅ Dépôt Git initialisé avec succès !" -ForegroundColor Green
    } else {
        Write-Host "✅ Dépôt Git actif détecté (déjà initialisé)." -ForegroundColor Green
    }
}

# 1. Claude Code (Idempotent : mise à jour des skills, préservation des configs existantes)
$claudeSkills = "$projectRoot\.claude\skills"
New-Item -ItemType Directory -Path $claudeSkills -Force | Out-Null
Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $claudeSkills -Recurse -Force
if (-not (Test-Path "$projectRoot\CLAUDE.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\CLAUDE.md" -Destination "$projectRoot\CLAUDE.md"
    Write-Host "📄 Template CLAUDE.md installé." -ForegroundColor Gray
} else {
    Write-Host "ℹ️ CLAUDE.md existant conservé (idempotence)." -ForegroundColor DarkGray
}

# 2. Google Antigravity / Gemini (Idempotent)
if (-not (Test-Path "$projectRoot\GEMINI.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\GEMINI.md" -Destination "$projectRoot\GEMINI.md"
    Write-Host "📄 Template GEMINI.md installé." -ForegroundColor Gray
} else {
    Write-Host "ℹ️ GEMINI.md existant conservé (idempotence)." -ForegroundColor DarkGray
}

$antigravitySkills = "$env:USERPROFILE\.gemini\config\skills"
if (Test-Path "$env:USERPROFILE\.gemini") {
    New-Item -ItemType Directory -Path $antigravitySkills -Force | Out-Null
    Copy-Item -Path "$PSScriptRoot\..\skills\*" -Destination $antigravitySkills -Recurse -Force
    Write-Host "🧠 Compétences déployées pour Antigravity (~/.gemini/config/skills)." -ForegroundColor Gray
}

# 3. Project Context (Idempotent : ne jamais écraser un contexte déjà documenté)
if (-not (Test-Path "$projectRoot\PROJECT_CONTEXT.md")) {
    Copy-Item -Path "$PSScriptRoot\..\templates\PROJECT_CONTEXT.md" -Destination "$projectRoot\PROJECT_CONTEXT.md"
    Write-Host "📋 Template PROJECT_CONTEXT.md installé." -ForegroundColor Gray
} else {
    Write-Host "ℹ️ PROJECT_CONTEXT.md existant conservé (idempotence)." -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "✅ Configuration installée et à jour avec succès dans votre projet !" -ForegroundColor Green
Write-Host "👈 Prochaines étapes :" -ForegroundColor Cyan
Write-Host "   1. Complétez PROJECT_CONTEXT.md si ce n'est pas déjà fait." -ForegroundColor White
Write-Host "   2. Lancez votre agent avec la compétence 'architecture-challenge'." -ForegroundColor White
