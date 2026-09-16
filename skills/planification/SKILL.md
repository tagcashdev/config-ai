---
name: planification
description: À utiliser lorsqu'un document de spécification ou un ensemble d'exigences est disponible, avant toute modification de code. Génère des plans d'implémentation granulaires, détaillés, sans placeholders et découpés en tâches autonomes testables et idempotentes.
---

# Planification d'Implémentation

La compétence `planification` permet d'élaborer un plan d'action d'ingénierie ultra-détaillé et rigoureux à partir d'un document de spécification de design ou d'un cahier des charges.

> [!IMPORTANT]
> **Annonce initiale** : Au démarrage de la planification, annoncer explicitement :
> *"J'utilise la compétence `planification` pour élaborer le plan d'implémentation."*

---

## Principes Fondamentaux

1. **Aucune ambiguïté** : Le plan doit être écrit comme si le développeur qui l'exécute ne connaissait pas le projet. Chaque étape doit montrer le code exact, la commande exacte à exécuter et le résultat attendu.
2. **Découpage fin (Bite-sized Tasks)** : Chaque tâche doit être une unité minimale de travail (2 à 5 minutes par étape) se terminant par un livrable testable de manière autonome.
3. **Approche TDD (Test-Driven Development)** : Les étapes doivent privilégier l'écriture du test échouant en premier, la vérification de l'échec, le code minimal pour réussir, la vérification du succès et le commit Git.
4. **Zéro Placeholder (Règle Absolue)** : Interdiction stricte des placeholders ("TODO", "TBD", "implémenter plus tard", "gérer les erreurs appropriées", "ajouter des tests pour ce qui précède" sans le code).
5. **Idempotence des Tâches & Commandes** : Chaque étape, script de migration ou modification de fichier doit être formulé pour être strictement ré-exécutable (idempotent) sans effet de bord destructif en cas d'interruption ou de retry.

---

## Emplacement des Plans

Enregistrer le fichier de plan dans :
`docs/plans/YYYY-MM-DD-<nom-de-la-fonctionnalite>.md`

---

## Modèle Standard de Plan d'Implémentation

Chaque plan d'implémentation généré doit respecter scrupuleusement le format suivant :

```markdown
# Plan d'Implémentation - [Nom de la Fonctionnalité]

> **Pour l'agent d'exécution :** Suivre les tâches étape par étape. Utiliser les cases à cocher (`- [ ]`) pour suivre la progression.

**Objectif :** [Une phrase décrivant précisément ce qui est construit]

**Architecture :** [2-3 phrases sur l'approche technique choisie]

**Stack Technologique :** [Technologies, langages et bibliothèques clés]

## Contraintes Globales

- [Contrainte 1 copiée verbatim de la spec : versions minimales, règles de nommage, etc.]
- [Contrainte 2 : Idempotence des opérations et des scripts]

---

## Tâches d'Implémentation

### Tâche 1 : [Nom du composant / module]

**Fichiers :**
- Créer : `chemin/exact/vers/fichier.py`
- Modifier : `chemin/exact/vers/existant.py:45-60`
- Test : `tests/chemin/exact/vers/test_fichier.py`

**Interfaces :**
- Consomme : [Signatures exactes des fonctions/composants produits par les tâches précédentes]
- Produit : [Noms de fonctions, paramètres et types de retour fournis aux tâches suivantes]

- [ ] **Étape 1 : Écrire le test qui échoue**

```python
def test_comportement_specifique():
    resultat = fonction_cible(input_test)
    assert resultat == resultat_attendu
```

- [ ] **Étape 2 : Vérifier que le test échoue**

Commande : `pytest tests/path/test_fichier.py::test_comportement_specifique -v`
Résultat attendu : ÉCHEC avec "NameError: name 'fonction_cible' is not defined"

- [ ] **Étape 3 : Écrire l'implémentation minimale**

```python
def fonction_cible(input_test):
    return resultat_attendu
```

- [ ] **Étape 4 : Vérifier que le test réussit**

Commande : `pytest tests/path/test_fichier.py::test_comportement_specifique -v`
Résultat attendu : SUCCÈS (PASSED)

- [ ] **Étape 5 : Effectuer le Commit Git**

```bash
git add tests/path/test_fichier.py src/path/fichier.py
git commit -m "feat: ajouter l'implémentation minimale de fonction_cible"
```
```

---

## Procédure d'Auto-Revue du Plan (Self-Review)

Avant de présenter le plan à l'utilisateur, l'agent doit effectuer une auto-revue minutieuse :

1. **Couverture de la spécification** : Parcourir chaque exigence du document de design et vérifier qu'une tâche du plan la réalise.
2. **Scan Anti-Placeholder** : S'assurer qu'aucun "TODO", "à venir" ou extrait de code incomplet ne subsiste.
3. **Cohérence des signatures et types** : Vérifier que les noms de fonctions, paramètres et types réutilisés dans les tâches ultérieures correspondent exactement à ceux définis dans les tâches précédentes.
4. **Vérification d'Idempotence** : S'assurer que les migrations SQL (ex: `IF NOT EXISTS`), les scripts d'initialisation et les étapes de configuration peuvent être rejoués N fois sans créer de doublons ou d'anomalies.

Si des erreurs sont détectées, les corriger immédiatement dans le fichier de plan.

---

## Transmission pour Exécution (Execution Handoff)

Après enregistrement du plan validé, proposer le choix d’exécution à l'utilisateur :

> *"Plan d'implémentation complété et enregistré dans `docs/plans/<nom-du-fichier>.md`. Deux options d'exécution sont disponibles :"*
> 1. **Exécution Étape par Étape (Recommandée)** : Progression tâche par tâche avec points de contrôle de revue.
> 2. **Exécution Guidée par Sous-Agent** : Délégation autonome de chaque tâche à un agent d'exécution dédié avec validation de sécurité à chaque étape.
