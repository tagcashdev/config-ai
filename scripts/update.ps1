# Script de mise à jour rapide Config-AI (Windows PowerShell)
# Exécutable depuis le dépôt ou n'importe quel dossier projet : .\scripts\update.ps1

[CmdletBinding()]
param (
    [string]$SourcePath = "",
    [string]$RepoUrl = "https://github.com/tagcashdev/config-ai.git"
)

$scriptSync = Join-Path $PSScriptRoot "..\skills\update-config\scripts\sync-config-ai.ps1"

if (Test-Path $scriptSync) {
    if (-not $SourcePath) {
        $SourcePath = (Resolve-Path "$PSScriptRoot\..").Path
    }
    & $scriptSync -SourcePath $SourcePath -RepoUrl $RepoUrl
} else {
    Write-Error "Script de synchronisation introuvable à l'emplacement : $scriptSync"
}
