#!/usr/bin/env bash
set -e

echo "🚀 Installation de Config-AI en cours..."

PROJECT_ROOT=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Fonction de rafraîchissement du PATH dans la session courante (Idempotente)
refresh_session_path() {
    export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/opt/homebrew/bin:/usr/local/git/bin"
}

# 0. Contrôle, installation autonome et sécurité Git (Idempotent)
echo "🛡️ Vérification de l'environnement Git..."
if ! command -v git >/dev/null 2>&1; then
    refresh_session_path
fi

if ! command -v git >/dev/null 2>&1; then
    echo "⚠️ Git non détecté. Tentative d'installation automatique et autonome..."

    installed=false

    # Debian / Ubuntu
    if [ "$installed" = false ] && command -v apt-get >/dev/null 2>&1; then
        echo "📦 Installation silencieuse de Git via apt-get..."
        if [ "$EUID" -ne 0 ]; then
            sudo apt-get update -y && sudo apt-get install -y git && installed=true || true
        else
            apt-get update -y && apt-get install -y git && installed=true || true
        fi
    fi

    # Fedora / RHEL
    if [ "$installed" = false ] && command -v dnf >/dev/null 2>&1; then
        echo "📦 Installation de Git via dnf..."
        sudo dnf install -y git && installed=true || true
    fi

    # CentOS / Older RHEL
    if [ "$installed" = false ] && command -v yum >/dev/null 2>&1; then
        echo "📦 Installation de Git via yum..."
        sudo yum install -y git && installed=true || true
    fi

    # Arch Linux
    if [ "$installed" = false ] && command -v pacman >/dev/null 2>&1; then
        echo "📦 Installation de Git via pacman..."
        sudo pacman -Sy --noconfirm git && installed=true || true
    fi

    # macOS (Homebrew)
    if [ "$installed" = false ] && command -v brew >/dev/null 2>&1; then
        echo "📦 Installation de Git via Homebrew..."
        brew install git && installed=true || true
    fi

    refresh_session_path

    if ! command -v git >/dev/null 2>&1; then
        echo "⚠️ Impossible d'installer Git automatiquement sans privilèges administrateur."
        echo "👉 Installez Git manuellement : https://git-scm.com/"
    else
        echo "✅ Git a été installé et configuré avec succès !"
    fi
fi

# Initialisation Git idempotente
if command -v git >/dev/null 2>&1; then
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "📦 Aucun dépôt Git détecté : initialisation automatique (git init)..."
        git init
        echo "✅ Dépôt Git initialisé avec succès !"
    else
        echo "✅ Dépôt Git actif détecté (déjà initialisé)."
    fi
fi

# 1. Claude Code (Idempotent)
mkdir -p "$PROJECT_ROOT/.claude/skills"
cp -r "$SCRIPT_DIR/../skills/"* "$PROJECT_ROOT/.claude/skills/"

if [ ! -f "$PROJECT_ROOT/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/../templates/CLAUDE.md" "$PROJECT_ROOT/CLAUDE.md"
    echo "📄 Template CLAUDE.md installé."
else
    echo "ℹ️ CLAUDE.md existant conservé (idempotence)."
fi

# 2. Google Antigravity / Gemini (Idempotent)
if [ ! -f "$PROJECT_ROOT/GEMINI.md" ]; then
    cp "$SCRIPT_DIR/../templates/GEMINI.md" "$PROJECT_ROOT/GEMINI.md"
    echo "📄 Template GEMINI.md installé."
else
    echo "ℹ️ GEMINI.md existant conservé (idempotence)."
fi

ANTIGRAVITY_SKILLS="$HOME/.gemini/config/skills"
if [ -d "$HOME/.gemini" ]; then
    mkdir -p "$ANTIGRAVITY_SKILLS"
    cp -r "$SCRIPT_DIR/../skills/"* "$ANTIGRAVITY_SKILLS/"
    echo "🧠 Compétences déployées pour Antigravity (~/.gemini/config/skills)."
fi

# 3. Context (Idempotent)
if [ ! -f "$PROJECT_ROOT/PROJECT_CONTEXT.md" ]; then
    cp "$SCRIPT_DIR/../templates/PROJECT_CONTEXT.md" "$PROJECT_ROOT/PROJECT_CONTEXT.md"
    echo "📋 Template PROJECT_CONTEXT.md installé."
else
    echo "ℹ️ PROJECT_CONTEXT.md existant conservé (idempotence)."
fi

echo ""
echo "✅ Configuration installée et à jour avec succès dans votre projet !"
echo "👈 Prochaines étapes :"
echo "   1. Complétez PROJECT_CONTEXT.md si ce n'est pas déjà fait."
echo "   2. Lancez votre agent avec la compétence 'architecture-challenge'."
