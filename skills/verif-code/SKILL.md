---
name: verif-code
description: Réalise un audit rigoureux de sécurité, robustesse, performance mobile et propreté du code avec scoring sur 100.
---

# Compétence : Audit de Code & Contrôle Qualité

À invoquer après chaque tâche majeure ou avant chaque fusion/commit critique.

## Grille d'Évaluation (100 Points)

### 1. Sécurité & Données Privées (25 points)
- Zéro clé secrète, service role key ou token en clair côté client.
- Variables d'environnement correctement isolées.
- Politiques d'accès aux données (ex: Supabase Row Level Security) hermétiques.

### 2. Robustesse & Gestion d'Erreurs (25 points)
- États de chargement gérés (loaders, skeletons).
- Scénarios d'erreur réseau, timeout ou mode hors-ligne gérés élégamment avec feedback utilisateur.
- Validation rigoureuse des entrées utilisateurs.

### 3. Performance & Optimisation Mobile (25 points)
- Absence de re-renders infinis ou inutiles.
- Fermeture et nettoyage systématique des abonnements (listeners, WebSocket, timers).
- Listes virtualisées pour les volumes de données importants.

### 4. Propreté & Maintenabilité (25 points)
- Typage strict complet (TypeScript strict, zéro any injustifié).
- Zéro code mort, zéro fonction inutilisée.
- Zéro console.log de débogage résiduel.

## Format du Livrable
- **Note globale :** Ex: 92/100
- **Détail par section**
- **Patchs correctifs immédiats :** Code de remplacement exact pour les points pénalisants.
