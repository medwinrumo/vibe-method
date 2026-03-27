# methode.md

Le process de travail — dans quel ordre construire, comment passer d'une étape à la suivante.
À enrichir au fil des sessions.

---

## Les phases

### Phase 1 — Produit
> Définir ce qu'on construit avant de toucher au code.

- Rédiger le brief
- Construire le PRD (cross-pollination entre IA)
- Définir le backlog et les user stories
- Identifier les enjeux de sécurité

Fichiers de référence : `produit.md`, `securite.md`

---

### Phase 2 — Architecture
> Décider comment le code est organisé.

- Choisir le pattern d'architecture (ex : modulaire)
- Définir les modules et leurs responsabilités
- S'assurer qu'ils sont indépendants

Fichier de référence : `architecture.md`

---

### Phase 3 — Stack
> Investiguer les outils avant de construire.

- Spike technique sur chaque outil de la stack
- Cartographier les limites du free tier
- Identifier les gotchas et les contraintes critiques
- Documenter les patterns recommandés pour l'IA

Fichier de référence : `stack.md`

---

### Phase 4 — Planification
> Construire la roadmap d'exécution.

- Donner le PRD et l'architecture pour générer la roadmap en markdown
- Découper en features parallélisables
- Chaque bloc = la plus petite feature possible

---

### Phase 5 — Code
> Coder feature par feature, en respectant les règles établies.

- Une feature à la fois, validée contre ses critères d'acceptation
- Appliquer les règles de sécurité et d'architecture en continu
- Rien n'est ajouté silencieusement sans validation de Medwin

Règle de contexte :
- Planification (PRD, archi, roadmap) : contexte large, tous les documents du projet
- Exécution (code) : contexte minimal — CLAUDE.md + module ciblé + specs de la feature
Ces deux modes ne se mélangent pas dans la même session.

Fichiers de référence : `securite.md`, `architecture.md`

---

### Phase 6 — Vérification
> S'assurer que ce qui est construit est correct — techniquement et fonctionnellement.

Ordre d'exécution pour chaque feature :

```
1. Feature développée
2. /tests    → tests unitaires + intégration (Vitest)
3. /tests    → non-régression (batterie Playwright sur les features existantes)
4. /recette  → génération du cahier de recettes (Gherkin depuis User Stories)
5. /tests    → Playwright sur la nouvelle feature → corrections
6. /recette  → validation manuelle finale
```

Les étapes 2, 3 et 5 filtrent les bugs avant que l'humain intervienne. Medwin arrive en dernier pour réexécuter l'intégralité du cahier de recettes manuellement — les mêmes vérifications que l'automatisation, du point de vue humain : fonctionnement, fluidité, cohérence visuelle, expérience utilisateur.

- Bug détecté en recette → `/debug` déclenché automatiquement
- Bug non résolu = bloquant — recette suspendue jusqu'à résolution
- Feature "Done" uniquement quand Medwin a validé la recette manuelle

Fichier de référence : `tests.md`

---

## Règles Git — projets applicatifs

- `main` = toujours stable, jamais de code non validé
- Une branche par feature : `feat/[nom-feature]`
- Merge dans `main` après validation `/recette` ✅
- Branche supprimée après merge
- PR (Pull Request) optionnelle en solo — recommandée pour forcer une relecture avant merge

---

## Règle transversale

Rien n'entre dans le système (fichiers, règles, code) sans discussion préalable et validation explicite de Medwin.
