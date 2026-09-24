#!/usr/bin/env bash
# Script de mise à jour rapide Config-AI (Linux / macOS)
# Exécutable depuis le dépôt : bash scripts/update.sh
set -e

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SYNC_SCRIPT="$SCRIPT_DIR/../skills/update-config/scripts/sync-config-ai.sh"

if [ -f "$SYNC_SCRIPT" ]; then
    bash "$SYNC_SCRIPT" "$SCRIPT_DIR/.."
else
    echo "❌ Erreur : Script de synchronisation introuvable ($SYNC_SCRIPT)."
    exit 1
fi
