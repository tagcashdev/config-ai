# Guide d'Installation et Configuration de la Passation

La compétence `passation` peut être utilisée de manière autonome ou automatisée via des hooks de démarrage de session.

---

## 1. Reprise Automatique sous Claude Code

Pour injecter automatiquement `passation.md` dans toute session neuve après un `/clear`, configurez vos paramètres Claude Code.

### Sous Windows (PowerShell)
Ajouter dans `~/.claude/settings.json` (ou fusionner dans la section `"hooks"` existante) :

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "clear",
        "hooks": [
          {
            "type": "command",
            "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"~/.claude/skills/passation/scripts/charger-passation.ps1\""
          }
        ]
      }
    ]
  }
}
```

### Sous Linux / macOS (Bash)
Ajouter dans `~/.claude/settings.json` :

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "clear",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/skills/passation/scripts/charger-passation.sh"
          }
        ]
      }
    ]
  }
}
```

> [!TIP]
> Le matcher `"clear"` ne déclenche le hook qu'après la commande `/clear`. Pour injecter la passation également au tout premier démarrage d'une session, vous pouvez ajouter une seconde entrée avec `"matcher": "startup"`.

---

## 2. Reprise Automatique sous Google Antigravity

Sous Google Antigravity, les hooks peuvent être déclarés dans `~/.gemini/config/hooks.json` ou dans `.agents/hooks.json` :

```json
{
  "hooks": {
    "SessionStart": [
      {
        "type": "command",
        "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"~/.gemini/config/skills/passation/scripts/charger-passation.ps1\""
      }
    ]
  }
}
```

---

## 3. Utilisation Sans Hook (Reprise Manuelle)

Si aucun hook n'est configuré :
1. Dans la session courante : invoquer `/passation` → `passation.md` est généré à la racine.
2. Faire `/clear` ou ouvrir un nouveau fil / session.
3. Dans la nouvelle session : dire simplement *"reprends la passation"* ou *"/passation reprendre"*. L'agent lira directement `passation.md` et enchaînera le travail.

---

## 4. Recommandation Git (.gitignore)

Il est vivement conseillé d'ajouter `passation.md` à votre fichier `.gitignore` afin de ne pas polluer l'historique du dépôt avec des notes temporaires de transition :

```gitignore
# Notes temporaires de passation
passation.md
```
