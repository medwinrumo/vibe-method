# methode.md

Le process de travail — dans quel ordre construire, comment passer d'une étape à la suivante.
À enrichir au fil des sessions.

---

## Greenfield ou Brownfield ?

Première question à poser au démarrage de tout projet. La réponse change le workflow.

**Greenfield** — projet qui part de zéro. Aucune codebase existante.
Workflow standard : `/brief → /prd → /archi → /stack → /roadmap → /specs → [/tests TDD si module métier/sécurité] → code → /tests → /recette`

**Brownfield** — reprise d'un projet existant (migration, refonte, ajout de features sur une base existante).
Exemples : Minou V2 (Firebase → Convex), fork d'une app existante, reprise d'un projet abandonné.

### Workflow Brownfield — étapes obligatoires avant tout changement

1. **Inventaire de la codebase** — lire et documenter ce qui existe : modules, dépendances, patterns utilisés, dette technique visible. Ne rien supposer.
2. **Couverture de régression** — écrire les tests sur le comportement existant AVANT de toucher au code. C'est le filet de sécurité. Si les tests n'existaient pas, ils se créent maintenant.
3. **Architecture adaptateur** — définir comment le nouveau système s'interface avec l'existant. Pas de remplacement brutal : on branche le nouveau sur l'ancien, on migre progressivement, on coupe l'ancien quand le nouveau est stable.
4. **Seulement ensuite** : `/archi → /roadmap → /specs → code`

**Règle absolue brownfield :** aucune modification du code existant sans couverture de régression préalable. Un bug introduit sur l'existant est invisible sans filet — et coûteux à trouver.

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

### Phase 2 — Design
> Traduire les features en interface visuelle avant de toucher au code.

1. Export des features depuis le PRD — liste structurée :
   - Nom de la feature
   - Composant UI associé (bouton, liste déroulante, onglet, champ texte...)
   - Comportement de base si nécessaire (ex : "clic → déroule un panneau")
2. Medwin travaille dans Stitch (génération maquette) puis Figma (affinage)
3. Medwin livre l'export Figma (CSS + captures) — Claude reprend

**Règle :** étape manuelle. Claude produit l'export features, Medwin fait la maquette.
Claude ne reprend qu'à la réception de l'export Figma.

Fichier de référence : `design.md`

---

### Phase 3 — Architecture
> Décider comment le code est organisé.

- Choisir le pattern d'architecture (ex : modulaire)
- Définir les modules et leurs responsabilités
- S'assurer qu'ils sont indépendants

Fichier de référence : `architecture.md`

---

### Phase 4 — Stack
> Investiguer les outils avant de construire — deux niveaux : la stack applicative et la stack de dev.

**Stack applicative** — les outils qui font tourner l'app :
- Spike technique sur chaque outil (Convex, Supabase, Vercel, APIs externes...)
- Cartographier les limites du free tier
- Identifier les gotchas et les contraintes critiques
- Documenter les patterns recommandés pour l'IA

**Stack de dev** — les outils avec lesquels on code :
- Évaluer la complexité du projet pour choisir le bon couple outil + modèle
- Un projet CRUD simple n'a pas besoin du même outil qu'une app temps réel multi-modules
- Ne pas payer une stack overkill : choisir la stack nécessaire, pas la meilleure
- Possibilités : Claude Code + Opus, Claude Code + Sonnet, Kilo Code + Kimi K2.5 via OpenRouter, Cursor + modèle, etc.
- Décision documentée dans `[projet].stack.md`

Fichier de référence : `stack.md`

---

### Phase 5 — Planification
> Construire la roadmap d'exécution.

- Donner le PRD, le design et l'architecture pour générer la roadmap en markdown
- Découper en features parallélisables
- Chaque bloc = la plus petite feature possible

---

### Phase 6 — Code
> Coder feature par feature, en respectant les règles établies.

- Une feature à la fois, validée contre ses critères d'acceptation
- Appliquer les règles de sécurité et d'architecture en continu
- Rien n'est ajouté silencieusement sans validation de Medwin

**TDD obligatoire pour les modules métier et sécurité :** avant d'écrire le code, `/tests` est lancé depuis le spec pour générer les tests. Le code doit satisfaire ces tests. Voir `tests.md` — section TDD.

Règle de contexte :
- Planification (PRD, archi, roadmap) : contexte large, tous les documents du projet
- Exécution (code) : contexte minimal — CLAUDE.md + module ciblé + specs de la feature
Ces deux modes ne se mélangent pas dans la même session.

Fichiers de référence : `securite.md`, `architecture.md`, `tests.md`

---

### Phase 7 — Vérification
> S'assurer que ce qui est construit est correct — techniquement et fonctionnellement.

Ordre d'exécution pour chaque feature :

**Modules métier et sécurité (TDD) :**
```
1. /tests         → tests depuis le spec (Red — avant le code)
2. Code           → feature implémentée pour satisfaire les tests (Green)
3. /tests         → refactor + non-régression Playwright
4. /code-review   → revue structurelle + sécurité → bloquant si point critique
5. /recette       → génération du cahier de recettes (Gherkin)
6. /tests         → Playwright sur la nouvelle feature → corrections
7. /securite check → vérification sécurité → bloquant si point en échec
8. /recette       → validation manuelle finale
```

**Modules UI et techniques (Standard) :**
```
1. Code           → feature implémentée
2. /tests         → tests unitaires + intégration (Vitest)
3. /tests         → non-régression (batterie Playwright sur les features existantes)
4. /code-review   → revue structurelle + sécurité → bloquant si point critique
5. /recette       → génération du cahier de recettes (Gherkin)
6. /tests         → Playwright sur la nouvelle feature → corrections
7. /securite check → vérification sécurité → bloquant si point en échec
8. /recette       → validation manuelle finale
```

L'étape /code-review filtre les problèmes de structure et de sécurité — bloquante si point critique. L'étape /securite check filtre les failles — bloquante, pas de merge tant qu'un point est en échec. Medwin arrive en dernier pour réexécuter l'intégralité du cahier de recettes manuellement.

- Bug détecté en recette → `/debug` déclenché automatiquement
- Bug non résolu = bloquant — recette suspendue jusqu'à résolution
- Feature "Done" uniquement quand tous les critères de la Definition of Done sont satisfaits

### Definition of Done

Une feature n'est "Done" que si toutes ces cases sont cochées. Aucune exception.

- [ ] Tests unitaires et intégration passants (Vitest)
- [ ] Non-régression Playwright verte sur les features existantes
- [ ] `/securite` check validé sur la feature (bloquant)
- [ ] Recette manuelle validée par Medwin
- [ ] Aucune valeur hardcodée (tokens, clés API, URLs, credentials)
- [ ] Code sur branche `feat/[feature]`, prêt à merger

Si un critère n'est pas atteint → la feature reste "In Progress". Pas de merge.

Fichier de référence : `tests.md`

### GitHub Actions — automatisation optionnelle

À évaluer au démarrage du projet : superflu pour un V1 solo, utile dès qu'on veut un filet de sécurité automatique.

Usages typiques :
- Lancer la batterie Playwright à chaque push sur `main`
- Bloquer un merge si des tests échouent
- Lancer les tests la nuit sur la branche de dev

Règle : projet solo et petit → pas de GitHub Actions, Vercel suffit. Plusieurs contributeurs ou app critique → mettre en place dès le départ.

La question se pose lors du `/stack` ou du `/archi`.

---

## Règles Git — projets applicatifs

- `main` = toujours stable, jamais de code non validé
- Une branche par feature : `feat/[nom-feature]`
- Merge dans `main` après validation `/recette` ✅
- Branche supprimée après merge
- PR (Pull Request) optionnelle en solo — recommandée pour forcer une relecture avant merge

---

## Doctrine — Agents IA

### Skill ou agent ?

Un skill suffit quand on peut écrire les étapes avant de commencer.
Un agent se justifie quand l'exécution elle-même révèle les étapes — boucles, dépendances aux résultats intermédiaires, itérations longues.

### Cas d'usage dans le dev d'une appli

Dans la construction d'une appli, un agent se justifie surtout pour des tâches transverses, volumineuses et répétitives — pas pour construire les features une par une.

Cas typiques :
- Migration de codebase
- Audit (sécurité, code mort, incohérences)
- Génération de documentation
- Génération de tests en masse

### Point de décision dans la chaîne

La décision se prend au moment du `/specs`. C'est là qu'on sait exactement ce qu'on doit produire. Si une tâche correspond aux critères ci-dessus, on le note dans la spec : "cette tâche sera traitée par un agent".

Question systématique en fin de `/specs` : est-ce que l'une de ces tâches justifie un agent ?

Si oui :
- Le documenter dans la spec
- Définir la checklist de vérification avant de lancer l'agent

### Règles opérationnelles

- Un agent co-construit avec Medwin doit avoir une checklist de vérification définie avant lancement
- Claude vérifie le résultat de chaque agent avant de valider
- Pour les sous-agents spawned par Claude : modèle choisi selon la complexité (Haiku / Sonnet / Opus), retour en Sonnet après la sous-tâche

---

## Skills transversaux

Ces skills peuvent être invoqués à tout moment dans le workflow, quelle que soit la phase :

| Skill | Quand l'utiliser |
|---|---|
| `/party` | Sur toute décision structurante où une seule perspective risque d'être incomplète (choix archi, priorisation, découpage V1/V2) |
| `/securite` | Analyse sécurité du PRD ou vérification sécurité d'une feature |
| `/debug` | Dès qu'un bug bloque la progression |

---

## Règle transversale

Rien n'entre dans le système (fichiers, règles, code) sans discussion préalable et validation explicite de Medwin.
