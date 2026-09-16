---
name: ui-ux-pro-max
description: Intelligence de design UI/UX pour le web et le mobile. Recherche dans une base de données locale contenant 84 styles, 192 palettes de couleurs, 74 associations de typographies, 192 types de produits, 98 directives UX, 104 banques d'icônes, 16 préconfigurations d'animations GSAP et 25 types de graphiques sur 22 stacks (React, Next.js, Vue, Nuxt, Svelte, Astro, SwiftUI, React Native, Flutter, Tailwind, shadcn/ui, Jetpack Compose, Angular, Laravel, JavaFX, WPF, WinUI, Avalonia, Uno, UWP, Three.js et HTML/CSS). À utiliser lors de la conception, de la création ou de la révision d'interfaces UI/UX (pages, composants, systèmes de couleurs, typographie, mise en page, accessibilité, animation ou visualisation de données).
---

# UI/UX Pro Max - Intelligence de Design UI/UX

UI/UX Pro Max fournit une base de données locale recherchable avec recommandations basées sur des priorités et règles de raisonnement design pour 22 stacks technologiques.

## Description et Objectif

Cette compétence permet à l'agent d'accéder instantanément à des règles de design UI/UX éprouvées, des palettes de couleurs harmonieuses (conformes WCAG AAA/AA), des combinaisons typographiques avec liens Google Fonts, des architectures de mise en page, des modèles d'animations GSAP et des checklists de contrôle qualité pré-livraison.

## Quand Utiliser cette Compétence

À utiliser dès que la tâche implique la structure visuelle, l'expérience utilisateur, l'ergonomie ou le design visuel :
- Conception de nouvelles pages web ou d'applications mobiles.
- Création ou refactorisation de composants UI (boutons, formulaires, cartes, modales, etc.).
- Choix d'un système de couleurs, typographies, espacements et grilles de mise en page.
- Audit UX / Accessibilité (contraste, navigation au clavier, cibles tactiles).
- Intégration d'animations fluides (GSAP, transitions CSS) et de visualisations de données (graphiques).

*Note : Ignorer cette compétence pour la logique backend pure, la gestion des bases de données ou DevOps.*

---

## Directives et Catégories de Règles par Priorité

Respecter l'ordre de priorité 1 à 10 pour arbitrer les choix de design. Les règles détaillées se trouvent dans `references/quick-reference.md` et `references/pro-rules.md`.

| Priorité | Catégorie | Impact | Domaine | Vérifications Clés (Obligatoire) | Anti-Patterns (À Éviter) |
|---|---|---|---|---|---|
| **1** | Accessibilité | CRITIQUE | `ux` | Contraste ≥ 4.5:1, Textes `alt`, Navigation clavier, Labels ARIA | Supprimer le ring de focus, Boutons icône sans label |
| **2** | Tactile & Interaction | CRITIQUE | `ux` | Cible min 44x44px, Espacement ≥ 8px, Feedback de chargement | Dépendance exclusive au survol (`hover`), Changements d'état 0ms |
| **3** | Performance | HAUT | `ux` | WebP/AVIF, Lazy loading, Réservation d'espace (CLS < 0.1) | Modulations de layout intempestives, Décalage de contenu (CLS) |
| **4** | Sélection de Style | HAUT | `style`, `product` | Cohérence avec le produit, Icônes SVG (Heroicons/Lucide) | Mélange plat/squeuomorphe, Emojis en guise d'icônes |
| **5** | Layout & Réactivité | HAUT | `ux` | Mobile-first, Breakpoints clairs, Pas de scroll horizontal | Container en largeur fixe (`px`), Désactivation du zoom |
| **6** | Typographie & Couleur | MOYEN | `typography`, `color` | Base 16px, Line-height 1.5, Tokens sémantiques | Corps de texte < 12px, Gris sur gris, Code Hex brut |
| **7** | Animation | MOYEN | `ux`, `gsap` | Durée 150-300ms, Animation porteuse de sens, Continuité spatiale | Animation purement décorative, Animer width/height |
| **8** | Formulaires & Feedback | MOYEN | `ux` | Labels visibles, Erreurs près du champ, Divulgation progressive | Label uniquement en placeholder, Erreurs uniquement en haut |
| **9** | Navigation | HAUT | `ux` | Bouton retour prévisible, Bottom nav ≤ 5, Deep linking | Navigation surchargée, Rupture du retour arrière |
| **10** | Graphiques & Données | FAIBLE | `chart` | Légendes claires, Tooltips, Couleurs accessibles | Se reposer uniquement sur la couleur pour véhiculer du sens |

---

## Utilisation de l'Outil de Recherche Python

Le script de recherche réside dans le dossier `scripts/` de la compétence.

```bash
# Commande générale (Windows PowerShell)
python "<SKILL_DIR>/scripts/search.py" "<requête>" --domain <domaine>

# Sur Linux / macOS
python "<SKILL_DIR>/scripts/search.py "<requête>" --domain <domaine>
```

---

## Workflow Pas à Pas

### Étape 1 : Analyser les Besoins Utilisateur
Identifier :
- **Type de produit** : SaaS, e-commerce, portfolio, dashboard, outil, productivité, etc.
- **Mots-clés de style** : minimaliste, sombre, moderne, dynamique, entreprise, etc.
- **Stack technologique** : `react`, `nextjs`, `vue`, `svelte`, `astro`, `swiftui`, `react-native`, `flutter`, `html-tailwind`, `shadcn`, `angular`, `laravel`, etc.

### Étape 2 : Générer le Design System Global (Obligatoire pour nouveau projet/page)
Exécuter l'option `--design-system` (`-ds`) :

```bash
python "<SKILL_DIR>/scripts/search.py" "<type_produit> <industrie> <mots_clés>" --design-system -p "NomDuProjet"
```

Pour persister le système de design dans le projet :
```bash
python "<SKILL_DIR>/scripts/search.py" "<requête>" --design-system --persist -p "NomDuProjet" --output-dir "<chemin-racine-projet>"
```
*Crée `design-system/<slug>/MASTER.md` comme source unique de vérité.*

### Étape 3 : Ajuster les Curseurs de Design (Optionnel)
- `--variance <1-10>` : 1 = minimaliste/centré, 10 = audacieux/asymétrique.
- `--motion <1-10>` : 1 = micro-interactions subtiles, 10 = animations complexes GSAP.
- `--density <1-10>` : 1 = aéré/spacieux, 10 = compact/dashboard.

### Étape 4 : Recherche Ciblée par Domaine ou Stack (Au besoin)

```bash
# Exemple : Recherche de typographie
python "<SKILL_DIR>/scripts/search.py" "dashboard analytics" --domain typography

# Exemple : Directives spécifiques Next.js / Tailwind
python "<SKILL_DIR>/scripts/search.py" "performance bundle" --stack nextjs
```

---

## Domaines de Recherche Disponibles

- `product` : Recommandations par type de produit
- `style` : Styles UI (glassmorphism, brutalism, etc.) + Mots-clés CSS
- `color` : Palettes de couleurs ajustées WCAG
- `typography` : Combinaisons de polices + liens Google Fonts
- `google-fonts` : Recherche de polices Google Fonts
- `landing` : Structure de landing page & stratégies CTA
- `chart` : Recommandations de graphiques et bibliothèques
- `ux` : Bonnes pratiques et anti-patterns UX
- `icons` : Recommandations d'icônes SVG (Phosphor, Heroicons, Lucide)
- `gsap` : Snippets d'animation GSAP par niveau d'intensité
- `react` / `web` : Directives de performance et composants réactifs

---

## Arbre de Décision et Résolution de Problèmes

- **Besoin d'un Design System complet ?** -> Exécuter avec `--design-system`.
- **Problème de contraste / Mode Sombre ?** -> Consulter `references/quick-reference.md` (§6 Couleur).
- **Problème d'animation saccadée ?** -> Consulter `references/quick-reference.md` (§7 Animation) et utiliser `--domain gsap`.
- **Formulaire difficile à utiliser ?** -> Consulter `references/quick-reference.md` (§8 Formulaires).
- **0 résultat lors d'une recherche ?** -> Élargir les mots-clés ou consulter les valeurs par défaut dans le tableau de priorités ci-dessus.
