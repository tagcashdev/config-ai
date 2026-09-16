---
name: architecture-challenge
description: Audite et challenge les choix technologiques, l'idempotence, les besoins réels et la cohérence de l'architecture logicielle avant toute écriture de code.
---

# Compétence : Architecture Challenge & Audit Technique

À utiliser obligatoirement avant d'arrêter un choix technologique ou de démarrer un nouveau projet.

## Missions de l'Agent
1. **Analyse des Contraintes Mobiles, Métier & Résilience :**
   - Évalue si l'application nécessite : du hors-ligne (offline-first), de la synchronisation de données, de la gestion de retry réseau, des notifications push, du temps réel, ou des mécanismes d'idempotence (paiements, webhooks, double-soumission).
2. **Audit Critique de la Stack Envisagée :**
   - Repère les incohérences (ex: technos inadaptées au smartphone ou au cloud ciblé).
   - Identifie les redondances ou la sur-ingénierie (ex: empiler trop de frameworks pour un MVP).
   - Compare objectivement les options (ex: React Native vs Flutter, BaaS vs serveur custom).
3. **Recommandation d'une Architecture Cible Résiliente :**
   - Propose une architecture claire : Client, Gestion des données & Auth, Logique métier, et mécanismes d'idempotence aux points de contact critiques.
4. **Identification des Risques :**
   - Liste les 3 risques majeurs (scalabilité, complexité de déploiement, sécurité, corruption d'état) et comment les contourner.

## Protocole
- Ne commence jamais par donner une réponse dogmatique.
- Pose 3 à 5 questions techniques précises à l'utilisateur sur son modèle de données, ses flux critiques et ses contraintes avant de valider la stack.
