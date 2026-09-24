# Script PowerShell de synchronisation idempotente des compétences Config-AI
[CmdletBinding()]
param (
    [string]$SourcePath = "",
    [string]$RepoUrl = "https://github.com/tagcashdev/config-ai.git"
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Synchronisation des compétences Config-AI en cours..." -ForegroundColor Cyan

$tempDir = $null
$sourceSkillsDir = $null

try {
    # 1. Détermination de la source (locale ou GitHub)
    if ($SourcePath -and (Test-Path "$SourcePath\skills")) {
        $sourceSkillsDir = "$SourcePath\skills"
        Write-Host "Source locale spécifiée : $sourceSkillsDir" -ForegroundColor Gray
    } elseif (Test-Path "c:\wamp64\www\dev\config-ai\skills") {
        $sourceSkillsDir = "c:\wamp64\www\dev\config-ai\skills"
        Write-Host "Source locale de développement détectée : $sourceSkillsDir" -ForegroundColor Gray
    } else {
        # Clonage éphémère depuis GitHub
        Write-Host "Récupération des dernières compétences depuis $RepoUrl..." -ForegroundColor Cyan
        $randomSuffix = [System.IO.Path]::GetRandomFileName()
        $tempDir = Join-Path ([System.IO.Path]::GetTempPath()) "config-ai-sync-$randomSuffix"
        
        $cloneResult = git clone --depth 1 $RepoUrl $tempDir 2>&1
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path "$tempDir\skills")) {
            throw "Impossible de cloner le dépôt distant Config-AI ($RepoUrl) : $cloneResult"
        }
        $sourceSkillsDir = "$tempDir\skills"
    }

    # Liste des compétences sources disponibles
    $sourceSkills = Get-ChildItem -Path $sourceSkillsDir -Directory

    if ($sourceSkills.Count -eq 0) {
        Write-Warning "Aucune compétence trouvée dans la source ($sourceSkillsDir)."
        return
    }

    # 2. Détermination des répertoires cibles
    $targetDirs = @()

    # Cible Antigravity globale
    $antigravityGlobal = "$env:USERPROFILE\.gemini\config\skills"
    if (Test-Path "$env:USERPROFILE\.gemini") {
        if (-not (Test-Path $antigravityGlobal)) {
            New-Item -ItemType Directory -Path $antigravityGlobal -Force | Out-Null
        }
        $targetDirs += $antigravityGlobal
    }

    # Cible Claude Code locale (si projet courant ou .claude existe)
    $currentLocation = (Get-Location).Path
    if (Test-Path "$currentLocation\.claude") {
        $claudeSkills = "$currentLocation\.claude\skills"
        if (-not (Test-Path $claudeSkills)) {
            New-Item -ItemType Directory -Path $claudeSkills -Force | Out-Null
        }
        $targetDirs += $claudeSkills
    }

    # Cible Antigravity workspace (.agents)
    if (Test-Path "$currentLocation\.agents\skills") {
        $targetDirs += "$currentLocation\.agents\skills"
    }

    # Si aucun dossier cible standard n'est détecté, cibler au minimum ~/.gemini/config/skills
    if ($targetDirs.Count -eq 0) {
        New-Item -ItemType Directory -Path $antigravityGlobal -Force | Out-Null
        $targetDirs += $antigravityGlobal
    }

    # 3. Synchronisation différentielle et idempotente
    foreach ($target in $targetDirs) {
        Write-Host ""
        Write-Host "Cible : $target" -ForegroundColor Yellow

        $added = @()
        $updated = @()
        $preserved = @()

        $existingSkills = Get-ChildItem -Path $target -Directory | Select-Object -ExpandProperty Name

        foreach ($skill in $sourceSkills) {
            $destPath = Join-Path $target $skill.Name
            $isNew = -not (Test-Path $destPath)

            Copy-Item -Path $skill.FullName -Destination $target -Recurse -Force

            if ($isNew) {
                $added += $skill.Name
            } else {
                $updated += $skill.Name
            }
        }

        # Détecter les compétences tierces ou locales préservées
        foreach ($existing in $existingSkills) {
            if ($existing -notin ($sourceSkills | Select-Object -ExpandProperty Name)) {
                $preserved += $existing
            }
        }

        # Bilan pour cette cible
        if ($added.Count -gt 0) {
            Write-Host "  [+] Nouvelles compétences installées :" -ForegroundColor Green
            foreach ($name in $added) { 
                Write-Host "      + $name" -ForegroundColor Green 
            }
        }

        if ($updated.Count -gt 0) {
            Write-Host "  [*] Compétences mises à jour :" -ForegroundColor Cyan
            foreach ($name in $updated) { 
                Write-Host "      ~ $name" -ForegroundColor Cyan 
            }
        }

        if ($preserved.Count -gt 0) {
            Write-Host "  [=] Compétences locales/tierces préservées :" -ForegroundColor DarkGray
            foreach ($name in $preserved) { 
                Write-Host "      = $name" -ForegroundColor DarkGray 
            }
        }
    }

    Write-Host ""
    Write-Host "Synchronisation terminée avec succès !" -ForegroundColor Green

} catch {
    $err = $_.Exception.Message
    Write-Host "Erreur lors de la synchronisation : $err" -ForegroundColor Red
} finally {
    # 4. Nettoyage du dossier temporaire
    if ($tempDir -and (Test-Path $tempDir)) {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}
