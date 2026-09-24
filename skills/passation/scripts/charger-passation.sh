#!/usr/bin/env bash
# Script de chargement automatique de passation (Linux / macOS)
# Utilisable comme hook de début de session pour Claude Code ou Antigravity.
# Si passation.md existe à la racine du projet, son contenu est injecté dans la nouvelle session.

DIR="${CLAUDE_PROJECT_DIR:-${WORKSPACE_ROOT:-$(pwd)}}"
FICHIER="$DIR/passation.md"

if [ ! -f "$FICHIER" ]; then
    exit 0
fi

echo "Une note de passation de la session précédente a été trouvée ($FICHIER)."
echo "Active la compétence passation en Mode 2 (Reprendre) : annonce brièvement ce que tu as compris et les écueils à éviter, puis enchaîne immédiatement sur la première prochaine étape."
echo ""
echo "----- DÉBUT passation.md -----"
cat "$FICHIER"
echo ""
echo "----- FIN passation.md -----"
