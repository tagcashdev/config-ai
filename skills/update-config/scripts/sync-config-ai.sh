#!/usr/bin/env bash
# Script Bash de synchronisation idempotente des compétences Config-AI (Linux / macOS)
set -e

REPO_URL="https://github.com/tagcashdev/config-ai.git"
SOURCE_PATH="${1:-}"

echo "🔄 Synchronisation des compétences Config-AI en cours..."

TEMP_DIR=""

cleanup() {
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}
trap cleanup EXIT

# 1. Détermination de la source
if [ -n "$SOURCE_PATH" ] && [ -d "$SOURCE_PATH/skills" ]; then
    SOURCE_SKILLS_DIR="$SOURCE_PATH/skills"
    echo "📂 Source locale spécifiée : $SOURCE_SKILLS_DIR"
elif [ -d "$HOME/dev/config-ai/skills" ]; then
    SOURCE_SKILLS_DIR="$HOME/dev/config-ai/skills"
    echo "📂 Source locale détectée : $SOURCE_SKILLS_DIR"
else
    echo "🌐 Récupération des dernières compétences depuis $REPO_URL..."
    TEMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'config-ai-sync')
    git clone --depth 1 "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1
    SOURCE_SKILLS_DIR="$TEMP_DIR/skills"
fi

if [ ! -d "$SOURCE_SKILLS_DIR" ]; then
    echo "❌ Erreur : Impossible de localiser le dossier des compétences sources."
    exit 1
fi

# 2. Détermination des répertoires cibles
TARGET_DIRS=()

# Cible Antigravity globale
ANTIGRAVITY_GLOBAL="$HOME/.gemini/config/skills"
if [ -d "$HOME/.gemini" ]; then
    mkdir -p "$ANTIGRAVITY_GLOBAL"
    TARGET_DIRS+=("$ANTIGRAVITY_GLOBAL")
fi

# Cible Claude Code locale
CURRENT_DIR=$(pwd)
if [ -d "$CURRENT_DIR/.claude" ]; then
    mkdir -p "$CURRENT_DIR/.claude/skills"
    TARGET_DIRS+=("$CURRENT_DIR/.claude/skills")
fi

# Cible Antigravity workspace
if [ -d "$CURRENT_DIR/.agents/skills" ]; then
    TARGET_DIRS+=("$CURRENT_DIR/.agents/skills")
fi

if [ ${#TARGET_DIRS[@]} -eq 0 ]; then
    mkdir -p "$ANTIGRAVITY_GLOBAL"
    TARGET_DIRS+=("$ANTIGRAVITY_GLOBAL")
fi

# 3. Synchronisation
for TARGET in "${TARGET_DIRS[@]}"; do
    echo ""
    echo "🎯 Cible : $TARGET"

    for SKILL_DIR in "$SOURCE_SKILLS_DIR"/*/; do
        [ -d "$SKILL_DIR" ] || continue
        SKILL_NAME=$(basename "$SKILL_DIR")
        DEST="$TARGET/$SKILL_NAME"

        if [ ! -d "$DEST" ]; then
            echo "  🆕 Nouvelle compétence : + $SKILL_NAME"
        else
            echo "  🔄 Mise à jour : ~ $SKILL_NAME"
        fi

        cp -r "$SKILL_DIR" "$TARGET/"
    done
done

echo ""
echo "✅ Synchronisation terminée avec succès !"
