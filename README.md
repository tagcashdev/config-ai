# 🚀 Config AI : Skills & Standards pour Claude Code et Google Antigravity

Un ensemble de compétences modulaires (**Skills**) et de standards d'ingénierie logicielle pour transformer votre agent IA en **CTO & Développeur Senior en binôme**.

---

## ⚡ Installation Automatique en 1 Prompt (Recommandé)

Ouvrez **Claude Code** (Desktop ou Terminal) ou **Google Antigravity** dans le dossier de **votre propre projet**, puis collez simplement ce prompt :

```text
Tu es mon assistant d'ingénierie logicielle. Je souhaite configurer mon environnement de travail avec les standards d'ingénierie de notre équipe.

Voici le dépôt de configuration : https://github.com/tagcashdev/config-ai.git

Exécute les actions suivantes pas à pas :
1. Filet de sécurité Git (Prérequis Zéro) :
   - Vérifie que Git est installé sur la machine.
   - Vérifie si le répertoire actuel est un dépôt Git initialisé. Si non, exécute immédiatement "git init" pour sécuriser le suivi de version avant toute autre action.
2. Détection de l'environnement : Détermine si tu es sous Claude Code ou sous Google Antigravity.
3. Récupération des ressources : Récupère les fichiers du dépôt ci-dessus.
4. Déploiement :
   - Si Claude Code : Copie templates/CLAUDE.md à la racine de mon projet et installe le contenu de skills/ dans .claude/skills/.
   - Si Google Antigravity : Copie templates/GEMINI.md à la racine de mon projet et installe le contenu de skills/ dans .gemini/config/skills/.
5. Initialisation : Si aucun fichier PROJECT_CONTEXT.md n'existe à la racine, copie templates/PROJECT_CONTEXT.md.
6. Remplissage guidé du PROJECT_CONTEXT.md :
   - Pose-moi les questions du template une par une (nom du projet, problème résolu, utilisateurs cibles, stack technique, services tiers, etc.).
   - Remplis le fichier avec mes réponses et montre-moi le résultat final pour validation avant de continuer.
7. Nettoyage : Supprime les éventuels fichiers temporaires de clone.
8. Mini-diagnostic de démarrage :
   - Demande-moi en 2 questions simples si mon projet comporte une interface mobile/web (pour activer ui-ux-pro-max) ou des besoins spécifiques tiers (pour utiliser skill-finder).
   - Propose-moi ensuite de lancer l'interrogatoire d'architecture avec la compétence architecture-challenge !
```

---

## 🤖 Instructions pour l'IA (Agent Setup Contract)

Si un utilisateur te fournit ce dépôt pour configurer son projet, respecte scrupuleusement le protocole suivant :
1. **Sécurité Git préalable :** Contrôle impérativement la présence de Git et initialise le dépôt (`git init`) s'il ne l'est pas déjà. Aucune édition de fichier ne doit être effectuée hors contrôle de version.
2. **Détection de l'environnement :** Détecte si le projet tourne sous Claude Code (`CLAUDE.md` / `.claude/`) ou Google Antigravity (`GEMINI.md` / `.gemini/`).
3. **Installation des Directives & Compétences :**
   - Pour Claude Code : `templates/CLAUDE.md` à la racine + dossiers dans `.claude/skills/`.
   - Pour Google Antigravity : `templates/GEMINI.md` à la racine + dossiers dans `~/.gemini/config/skills/`.
4. **Fiche Projet :** Si aucun fichier `PROJECT_CONTEXT.md` n'existe à la racine du projet utilisateur, installe le modèle depuis `templates/PROJECT_CONTEXT.md`.
5. **Remplissage Guidé :** Pose les questions du `PROJECT_CONTEXT.md` une par une, remplis le fichier avec les réponses de l'utilisateur et demande validation.
6. **Onboarding & Diagnostic :** Pose deux questions d'orientation sur le projet avant de lancer l'audit initial (`architecture-challenge`).

---

## 📦 Les Compétences Incluses

| Compétence | Rôle & Objectif |
| :--- | :--- |
| **architecture-challenge** | Audite et challenge la viabilité des technologies envisagées par rapport aux contraintes réelles (mobile, offline, scalabilité) en mode *« Grill Me »*. |
| **brainstorming** | Cadre le périmètre du MVP, élimine les fonctionnalités superflues et dessine les flux utilisateurs (Happy Path). |
| **planification** | Découpe le projet en tâches atomiques (15-30 min) testables immédiatement sans aucun placeholder (`// TODO`). |
| **verif-code** | Évalue le code produit sur un barème strict de 100 points (sécurité, robustesse, perfs mobiles, propreté). |
| **ui-ux-pro-max** | Moteur de design UI/UX complet (palettes, styles modernes, micro-animations, typographies) pour des interfaces pros. |
| **skill-finder** | Chasseur de compétences certifiées : explore explicitement les répertoires communautaires, audite la sécurité (antivirus IA) et installe à la demande. |

---

## 🛠️ Alternative : Installation manuelle par script

Les scripts vérifient automatiquement la présence de Git, initialisent le projet (`git init`) si nécessaire et déploient les modèles (`CLAUDE.md`, `GEMINI.md`, `PROJECT_CONTEXT.md`) ainsi que les compétences :

**Sous Windows (PowerShell) :**
```powershell
.\scripts\install.ps1
```

**Sous Mac / Linux :**
```bash
bash scripts/install.sh
```
