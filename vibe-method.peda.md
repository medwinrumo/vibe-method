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
