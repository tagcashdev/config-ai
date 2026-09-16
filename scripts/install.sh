#!/usr/bin/env bash
set -e

echo "🚀 Installation de Config-AI en cours..."

PROJECT_ROOT=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# 0. Contrôle et sécurité Git
echo "🛡️ Vérification de l'environnement Git..."
if ! command -v git >/dev/null 2>&1; then
    echo "⚠️ ATTENTION : Git n'est pas détecté sur votre machine !"
    echo "👉 Pour l'installer : sudo apt-get install git (Linux) ou brew install git (macOS)"
else
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "📦 Aucun dépôt Git détecté : initialisation automatique (git init)..."
        git init
        echo "✅ Dépôt Git initialisé avec succès !"
    else
        echo "✅ Dépôt Git actif détecté."
    fi
fi

# 1. Claude Code
mkdir -p "$PROJECT_ROOT/.claude/skills"
cp -r "$SCRIPT_DIR/../skills/"* "$PROJECT_ROOT/.claude/skills/"

if [ ! -f "$PROJECT_ROOT/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/../templates/CLAUDE.md" "$PROJECT_ROOT/CLAUDE.md"
    echo "📄 Template CLAUDE.md installé."
fi

# 2. Google Antigravity / Gemini
if [ ! -f "$PROJECT_ROOT/GEMINI.md" ]; then
    cp "$SCRIPT_DIR/../templates/GEMINI.md" "$PROJECT_ROOT/GEMINI.md"
    echo "📄 Template GEMINI.md installé."
fi

ANTIGRAVITY_SKILLS="$HOME/.gemini/config/skills"
if [ -d "$HOME/.gemini" ]; then
    mkdir -p "$ANTIGRAVITY_SKILLS"
    cp -r "$SCRIPT_DIR/../skills/"* "$ANTIGRAVITY_SKILLS/"
    echo "🧠 Compétences déployées pour Antigravity (~/.gemini/config/skills)."
fi

# 3. Context
if [ ! -f "$PROJECT_ROOT/PROJECT_CONTEXT.md" ]; then
    cp "$SCRIPT_DIR/../templates/PROJECT_CONTEXT.md" "$PROJECT_ROOT/PROJECT_CONTEXT.md"
    echo "📋 Template PROJECT_CONTEXT.md installé."
fi

echo ""
echo "✅ Configuration installée avec succès dans votre projet !"
echo "👈 Prochaines étapes :"
echo "   1. Complétez PROJECT_CONTEXT.md avec les spécificités de votre projet."
echo "   2. Lancez votre agent avec la compétence 'architecture-challenge'."
