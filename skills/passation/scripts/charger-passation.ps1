# Script de chargement automatique de passation (Windows PowerShell)
# Utilisable comme hook de début de session pour Claude Code ou Antigravity.
# Si passation.md existe à la racine du projet, son contenu est injecté dans la nouvelle session.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$dir = if ($env:CLAUDE_PROJECT_DIR) { 
    $env:CLAUDE_PROJECT_DIR 
} elseif ($env:WORKSPACE_ROOT) {
    $env:WORKSPACE_ROOT
} else { 
    (Get-Location).Path 
}

$fichier = Join-Path $dir "passation.md"

if (-not (Test-Path $fichier)) { 
    exit 0 
}

Write-Output "Une note de passation de la session précédente a été trouvée ($fichier)."
Write-Output "Active la compétence passation en Mode 2 (Reprendre) : annonce brièvement ce que tu as compris et les écueils à éviter, puis enchaîne immédiatement sur la première prochaine étape."
Write-Output ""
Write-Output "----- DÉBUT passation.md -----"
Get-Content -Path $fichier -Encoding UTF8 -Raw
Write-Output "----- FIN passation.md -----"
