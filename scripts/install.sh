#!/usr/bin/env bash
set -e

echo "⚡ Installation de Config-AI en cours..."

PROJECT_ROOT=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Claude Code
mkdir -p "$PROJECT_ROOT/.claude/skills"
cp -r "$SCRIPT_DIR/../skills/"* "$PROJECT_ROOT/.claude/skills/"

if [ ! -f "$PROJECT_ROOT/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/../templates/CLAUDE.md" "$PROJECT_ROOT/CLAUDE.md"
fi

# Antigravity
ANTIGRAVITY_SKILLS="$HOME/.gemini/config/skills"
if [ -d "$HOME/.gemini" ]; then
    mkdir -p "$ANTIGRAVITY_SKILLS"
    cp -r "$SCRIPT_DIR/../skills/"* "$ANTIGRAVITY_SKILLS/"
fi

# Context
if [ ! -f "$PROJECT_ROOT/PROJECT_CONTEXT.md" ]; then
    cp "$SCRIPT_DIR/../templates/PROJECT_CONTEXT.md" "$PROJECT_ROOT/PROJECT_CONTEXT.md"
fi

echo "✅ Configuration installée avec succès !"
