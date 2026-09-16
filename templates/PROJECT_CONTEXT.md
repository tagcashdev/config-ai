# 👉 Contexte du Projet & Architecture

## 1. Vision & Proposition de Valeur
- **Nom du projet :** [Nom de l'application]
- **Problème résolu :** [Quel problème précis cette app résout-elle ?]
- **Utilisateurs cibles :** [Qui sont les utilisateurs types ?]
- **La fonctionnalité magique :** [Quelle est la valeur unique de l'app ?]

## 2. Décisions Techniques Validées
- **Client Mobile / Web :** [ex: React Native avec Expo / Flutter / Next.js]
- **Base de données & Auth :** [ex: Supabase / Firebase / PostgreSQL]
- **Logique Métier & API :** [ex: Supabase Edge Functions / FastAPI / Node]
- **Services Tiers :** [ex: Notifications Push, Stockage de fichiers, Stripe, etc.]

## 3. Règles d'Ingénierie de l'Équipe
- **Zéro placeholder :** Interdiction formelle d'écrire des commentaires `// TODO` ou du code non implémenté.
- **Idempotence Universelle :** Chaque script, migration, tâche ou endpoint d'API doit pouvoir être rejoué sans effet de bord destructif.
- **Validation continue :** Une tâche = un test immédiat = un commit Git.
- **Sécurité stricte :** Aucune clé privée côté client, politiques RLS hermétiques.

## 4. Journal des Décisions (Architecture Decision Log)
- **YYYY-MM-DD :** Initialisation du projet et cadrage de l'architecture.
