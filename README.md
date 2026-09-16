# 🚀 Config AI : Skills & Standards pour Claude Code et Google Antigravity

Un ensemble de compétences modulaires (**Skills**) et de standards d'ingénierie logicielle pour transformer votre agent IA en **CTO & Développeur Senior en binôme**.

---

## ⚡ Installation Automatique en 1 Prompt (Recommandé)

Ouvrez **Claude Code** (Desktop ou Terminal) ou **Google Antigravity** dans le dossier de **votre propre projet**, puis collez simplement ce prompt :

```text
Tu es mon assistant d'ingénierie logicielle. Je souhaite configurer mon environnement de travail avec les standards d'ingénierie de notre équipe.

Voici le dépôt de configuration : https://github.com/tagcashdev/config-ai.git

Exécute les actions suivantes pas à pas :
1. Détection de l'environnement : Détermine si tu es sous Claude Code ou sous Google Antigravity.
2. Récupération des ressources : Récupère les fichiers du dépôt ci-dessus.
3. Déploiement :
   - Si Claude Code : Copie templates/CLAUDE.md à la racine de mon projet et installe le contenu de skills/ dans .claude/skills/.
   - Si Google Antigravity : Installe le contenu de skills/ dans .gemini/config/skills/.
4. Initialisation : Si aucun fichier PROJECT_CONTEXT.md n'existe à la racine, copie templates/PROJECT_CONTEXT.md.
5. Remplissage guidé du PROJECT_CONTEXT.md :
   - Pose-moi les questions du template une par une (nom du projet, problème résolu, utilisateurs cibles, stack technique, services tiers, etc.).
   - Remplis le fichier avec mes réponses et montre-moi le résultat final pour validation avant de continuer.
6. Nettoyage : Supprime les éventuels fichiers temporaires de clone.
7. Mini-diagnostic de démarrage :
   - Demande-moi en 2 questions simples si mon projet comporte une interface mobile/web (pour activer ui-ux-pro-max) ou des besoins spécifiques tiers (pour utiliser skill-finder).
   - Propose-moi ensuite de lancer l'interrogatoire d'architecture avec la compétence architecture-challenge !
```

---

## 🤖 Instructions pour l'IA (Agent Setup Contract)

Si un utilisateur te fournit ce dépôt pour configurer son projet, respecte le protocole suivant :
1. **Détection de l'environnement :** Détecte si le projet tourne sous Claude Code (CLAUDE.md / .claude/) ou Google Antigravity (.gemini/).
2. **Installation des Compétences :** Déploie les dossiers du répertoire skills/ au bon endroit selon l'agent.
3. **Fiche Projet :** Si aucun fichier PROJECT_CONTEXT.md n'existe à la racine du projet utilisateur, installe le modèle depuis templates/PROJECT_CONTEXT.md.
4. **Remplissage Guidé :** Pose les questions du PROJECT_CONTEXT.md une par une, remplis le fichier avec les réponses de l'utilisateur et demande validation.
5. **Onboarding & Diagnostic :** Pose deux questions d'orientation sur le projet avant de lancer l'audit initial (architecture-challenge).

---

## 📦 Les Compétences Incluses

| Compétence | Rôle & Objectif |
| :--- | :--- |
| **architecture-challenge** | Audite et challenge la viabilité des technologies envisagées par rapport aux contraintes réelles (mobile, offline, scalabilité) en mode *« Grill Me »*. |
| **brainstorming** | Cadre le périmètre du MVP, élimine les fonctionnalités superflues et dessine les flux utilisateurs (Happy Path). |
| **planification** | Découpe le projet en tâches atomiques (15-30 min) testables immédiatement sans aucun placeholder (// TODO). |
| **verif-code** | Évalue le code produit sur un barème strict de 100 points (sécurité, robustesse, perfs mobiles, propreté). |
| **ui-ux-pro-max** | Moteur de design UI/UX complet (palettes, styles modernes, micro-animations, typographies) pour des interfaces pros. |
| **skill-finder** | Chasseur de compétences certifiées : explore explicitement les répertoires sickn33 (1800+ skills), rmyndharis (300+ skills) et mattpocock, audite la sécurité (antivirus IA) et installe à la demande. |

---

## 🛠️ Alternative : Installation manuelle par script

Si vous préférez installer les fichiers sans passer par l'IA :

**Sous Windows (PowerShell) :**
```powershell
.\scripts\install.ps1
```

**Sous Mac / Linux :**
```bash
bash scripts/install.sh
```
