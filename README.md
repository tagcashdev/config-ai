# 🚀 Config AI : Skills & Standards pour Claude Code et Google Antigravity

Un ensemble de compétences modulaires (**Skills**) et de standards d'ingénierie logicielle pour transformer votre agent IA en **CTO & Développeur Senior en binôme**.

> **Principe Cardinal : Idempotence Universelle.**  
> Tout le processus — de l'installation de Config-AI à la planification, aux scripts et au code produit par l'agent — est conçu pour être **strictement idempotent** : chaque opération peut être exécutée N fois d'affilée sans effet de bord destructif, sans duplication d'état et sans régression.

---

## ⚡ Installation Automatique en 1 Prompt (Autonome & Idempotent)

Ouvrez **Claude Code** (Desktop ou Terminal) ou **Google Antigravity** dans le dossier de **votre propre projet**, puis collez simplement ce prompt :

```text
Tu es mon assistant d'ingénierie logicielle. Configure mon environnement de travail de manière 100% autonome et strictement idempotente (l'exécution répétée ne doit rien casser ni rien écraser d'existant).

Voici le dépôt source de configuration : https://github.com/tagcashdev/config-ai.git

Exécute les actions suivantes pas à pas et de façon autonome :
1. Filet de sécurité Git (Prérequis Zéro & Autonome) :
   - Vérifie si Git est installé.
   - Si Git est absent : installe-le silencieusement et de manière autonome (ex: winget install --id Git.Git -e --source winget --silent sous Windows, ou sudo apt-get install -y git sous Linux), puis rafraîchis ton PATH.
   - Vérifie si le projet courant est un dépôt Git ("git rev-parse --is-inside-work-tree"). Si non, initialise-le immédiatement avec "git init". Si oui, n'y touche pas (idempotence).
2. Détection de l'environnement : Détermine si tu opères sous Claude Code ou sous Google Antigravity.
3. Récupération des ressources : Récupère les fichiers du dépôt ci-dessus.
4. Déploiement Idempotent :
   - Si Claude Code : Installe templates/CLAUDE.md à la racine (uniquement s'il n'existe pas déjà) et déploie/mets à jour les dossiers de skills/ dans .claude/skills/.
   - Si Google Antigravity : Installe templates/GEMINI.md à la racine (uniquement s'il n'existe pas déjà) et déploie/mets à jour les dossiers de skills/ dans .gemini/config/skills/.
5. Fiche Contexte : Si aucun fichier PROJECT_CONTEXT.md n'existe à la racine, copie templates/PROJECT_CONTEXT.md. S'il existe déjà, conserve-le intact.
6. Remplissage guidé :
   - Uniquement si PROJECT_CONTEXT.md vient d'être créé ou est encore vide, pose-moi les questions du template une par une pour le compléter, puis valide avec moi.
7. Nettoyage : Supprime les éventuels fichiers temporaires de clone.
8. Diagnostic de démarrage :
   - Vérifie si le projet comporte une interface (UI/UX) ou des besoins spécifiques tiers, puis propose de lancer l'interrogatoire d'architecture avec la compétence architecture-challenge !
```

---

## 🤖 Instructions pour l'IA (Agent Setup Contract)

Si un utilisateur te fournit ce dépôt pour configurer son projet, respecte scrupuleusement le protocole suivant :
1. **Autonomie & Sécurité Git préalable :** Vérifie la présence de Git. Installe-le de manière autonome via le gestionnaire de paquets du système si manquant. Initialise le dépôt (`git init`) si non versionné. Aucune modification de code ne doit être effectuée sans contrôle de version actif.
2. **Strict Respect de l'Idempotence Universelle :**
   - Ne jamais réinitialiser un dépôt Git déjà existant.
   - Ne jamais écraser un fichier `CLAUDE.md`, `GEMINI.md` ou `PROJECT_CONTEXT.md` déjà présent ou personnalisé par l'utilisateur.
   - Mettre à jour les compétences (`skills/`) sans détruire les éventuelles compétences tierces déjà installées.
   - **Exigence sur le code produit :** Tout code, migration SQL (`IF NOT EXISTS`), script de seed, route d'API ou modification de fichier généré par l'agent doit être strictement idempotent.
3. **Détection de l'environnement :** Détecte si le projet tourne sous Claude Code (`CLAUDE.md` / `.claude/`) ou Google Antigravity (`GEMINI.md` / `.gemini/`).
4. **Installation des Directives & Compétences :**
   - Pour Claude Code : `templates/CLAUDE.md` à la racine + dossiers dans `.claude/skills/`.
   - Pour Google Antigravity : `templates/GEMINI.md` à la racine + dossiers dans `~/.gemini/config/skills/`.
5. **Fiche Projet & Diagnostic :** Si `PROJECT_CONTEXT.md` est neuf, guide l'utilisateur pour le renseigner, puis propose d'activer `architecture-challenge`.

---

## 📦 Les Compétences Incluses

| Compétence | Rôle & Objectif |
| :--- | :--- |
| **architecture-challenge** | Audite et challenge la viabilité, la résilience, la gestion de pannes et l'idempotence de la stack technique en mode *« Grill Me »*. |
| **brainstorming** | Cadre le périmètre du MVP, élimine les fonctionnalités superflues et dessine les flux utilisateurs (Happy Path). |
| **planification** | Découpe le projet en tâches atomiques (15-30 min) testables immédiatement et **strictement ré-exécutables (idempotentes)** sans aucun placeholder (`// TODO`). |
| **verif-code** | Évalue le code produit sur un barème strict de 100 points (sécurité, robustesse & **idempotence des opérations**, perfs mobiles, propreté). |
| **ui-ux-pro-max** | Moteur de design UI/UX complet (palettes, styles modernes, micro-animations, typographies) pour des interfaces pros. |
| **skill-finder** | Chasseur de compétences certifiées : explore explicitement les répertoires communautaires, audite la sécurité (antivirus IA) et installe de manière **idempotente** à la demande. |

---

## 🛠️ Alternative : Installation manuelle par script

Les scripts sont **100% autonomes et strictement idempotents** : ils installent Git silencieusement si absent, rafraîchissent le `PATH` en mémoire, initialisent le projet sans réécraser l'existant, et mettent à jour les compétences :

**Sous Windows (PowerShell) :**
```powershell
.\scripts\install.ps1
```

**Sous Mac / Linux :**
```bash
bash scripts/install.sh
```
