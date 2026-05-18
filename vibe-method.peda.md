# vibe-method.peda — Journal pédagogique

---

## Jour 1 — 2026-05-18 — Enrichissement méthode + refactoring Notion

### Session 1 — Intégration skills externes + suppression complète de Notion

#### Ce qu'on a fait et pourquoi

**Évaluation de skills externes**

Trois skills analysés pour intégration dans la méthode :

- **to-prd** : contenait un "Quality Gate" — point de contrôle obligatoire avant de passer à l'étape suivante. Concept intégré dans `/prd` : une section optionnelle "Décisions techniques initiales" dans la gate de validation (étape 5b). L'idée : si des décisions techniques évidentes émergent pendant le PRD (ex : "on sait déjà qu'on utilisera Supabase"), les capturer immédiatement plutôt que de les perdre jusqu'au `/archi`.

- **grill-with-docs** : enrichissait `/grill-me` avec de la lecture de documents. Appliqué dans `/adr` (filtre 3 conditions) et `/prp` (ajout du glossaire). Le principe : avant d'interroger, lire ce qui existe déjà.

- **caveman** : mode de communication ultra-compressé (~75% de tokens en moins). Utile pour les longues sessions de méthode, **jamais** pendant les sessions de code (les actions irréversibles et la sécurité exigent une clarté totale).

**Nouveaux skills créés**

- `/grill-me` : interrogatoire approfondi d'un plan. Différent de `/askme` (rapide, structuré) : ici, Claude descend chaque branche de décision une par une, recommande une réponse, et ne lâche pas avant que tout soit résolu. L'expression française "passer sur le grill" capture exactement le sens.

- `/handoff` : ancre de contexte mid-session avant une compaction de contexte. Sauvegarde dans `handoff.md` à la racine du projet. Écrase à chaque usage — les vieilles entrées sont périmées une fois consommées par la nouvelle fenêtre de contexte. Ne remplace pas `/maj` (clôture officielle), mais permet de reprendre le fil après compaction.

**Refactoring Notion → artefacts locaux (décision structurante)**

Constat : 7 skills écrivaient exclusivement dans Notion sans équivalent local. Notion était le seul endroit où vivaient `.peda`, `.log`, `.doc`, `.spec`, et les checkpoints intermédiaires.

Problème : dépendance externe, friction, et incohérence avec la doctrine "git est la source de vérité".

Décision retenue : **Option A — Notion disparaît entièrement du workflow.** Tous les artefacts vivent dans des fichiers `.md` dans le repo du projet.

#### Comment

- `/peda`, `/log`, `/doc`, `/spec`, `/checkpoint`, `/majtodo`, `/maj`, `/init-projet` → réécrits avec Write tool (changements trop importants pour du patch partiel)
- `CLAUDE.global.md` → section "Notion — second cerveau" supprimée (URLs BDD, règles opérationnelles, convention couleur bleue), remplacée par une table "Artefacts locaux par projet"
- `/maj` → nouvelle étape 2 "Documentation locale" insérée avant le commit Git

#### Décisions prises

- **Collision de nom `/spec`** : le skill `/spec` (singulier) produit désormais `[projet].spec-global.md` pour éviter la collision avec `[projet].spec.[feature].md` produit par `/specs` (pluriel). Deux fichiers distincts, deux niveaux de granularité.
- **Survie de `/checkpoint`** : conservé comme raccourci intermédiaire (`/peda` + `/log` sans Git). `/maj` l'englobe et fait tout le reste.
- **Convention couleur bleue** : supprimée — elle servait à identifier les blocs ajoutés par Claude dans Notion. Sans Notion, elle n'a plus d'objet.

#### Difficultés

- Le fichier `~/dev/CLAUDE.md` est un symlink vers `vibe-method/CLAUDE.global.md`. Write refuse d'écrire à travers un symlink — résolu en passant par le chemin réel (`/Users/medwinrumo/dev/vibe-method/CLAUDE.global.md`).
- La session a subi une compaction de contexte mid-session. `/handoff` n'existait pas encore au moment de la compaction — la reprise s'est faite via le résumé automatique généré par le système.

---

### Session 2 — Intégration de skills externes (suite) + recadrage méthodologique

#### Ce qu'on a fait et pourquoi

**Évaluation de nouveaux skills externes**

Quatre skills supplémentaires analysés :

- **diagnose** : diagnostic discipliné pour bugs difficiles. Notre `/debug` couvre les bugs simples depuis `/recette`. `/diagnose` est l'escalade pour les bugs qui résistent — sa valeur centrale est la Phase 1 : construire une boucle de feedback automatisée et déterministe avant toute hypothèse. Intégré comme skill distinct connecté à `/debug` étape 5.

- **improve-codebase-architecture** : exploration du codebase pour trouver des "deepening opportunities". Apporte trois concepts intégrés dans `/refacto` : le **deletion test** (si on supprime ce module, la complexité disparaît-elle ?), le vocabulaire **Seam/Profondeur**, et un mode **exploration** pour quand aucun module n'est encore identifié.

- **tdd** : apporte deux formulations meilleures que les nôtres — l'anti-pattern "tranches horizontales" (écrire tous les tests puis tout le code = tester un comportement imaginé) et le signal d'alerte "renommer une fonction interne casse des tests = les tests testaient l'implémentation". Intégré dans `/tests`.

- **to-issues** : transforme specs en issues GitHub qualifiées HITL/AFK, découpées en vertical slices. Skills écartés : `triage` (workflow open source, pas adapté à notre usage solo), `setup-matt-pocock-skills` (configurateur de leur suite, pas utile sans leur écosystème complet).

**Recadrage méthodologique important**

En cours de session, Medwin a recadré l'approche d'évaluation des skills :
- L'objectif est **prospectif**, pas opérationnel — recenser le maximum de skills disponibles, même sans cas d'usage immédiat. Un skill écarté aujourd'hui ne sera probablement jamais reconsidéré.
- Les "agents autonomes" c'est nous deux — HITL = Medwin reste dans la boucle, AFK = Claude agit seul. Avec la capacité de spawner des sous-agents, le périmètre d'action peut se démultiplier.

Ce recadrage a conduit à reconsidérer `/to-issues` (initialement écarté "faute de cas d'usage") et à créer le skill.

#### Comment

- `/diagnose` créé, symlink créé, `/debug` modifié (étape 5 → option escalade)
- `/refacto` modifié : section vocabulaire (Seam/Profondeur/Deletion test) + mode exploration
- `/tests` modifié : anti-pattern horizontal slices + signal mauvais test
- `/roadmap` modifié : principe vertical slices + critère Quality Gate
- `/to-issues` créé, symlink créé
- `CLAUDE.md` vibe-method mis à jour à chaque ajout

#### Décisions prises

- **Approche prospective** : intégrer les concepts utiles même sans use case immédiat visible — ils seront disponibles quand le besoin viendra.
- **HITL/AFK** : distinction formalisée dans `/to-issues` et `/roadmap` pour qualifier explicitement ce qu'on délègue vs ce qu'on valide.
- **`/to-issues` dans la chaîne** : après `/specs`, avant `/sessionCode`. Transforme les specs en issues structurées prêtes à exécuter.
