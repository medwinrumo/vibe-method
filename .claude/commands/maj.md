---
description: Clôture de session — Git + sync sécurité + GitHub Projects + cohérence doctrine
allowed-tools: Bash(git *), Bash(cat *), Bash(gh *)
---

Effectue la clôture complète de session pour le projet en cours.

## Étape 1 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant (ex : `minou` depuis `/Users/medwinrumo/dev/minou`).

## Étape 2 — GitHub

1. Vérifier que tout est commité (`git status`)
2. Si des modifications non commitées existent, demander confirmation avant de commiter
3. Pousser la branche courante (`git push`)

### Fichier `CLAUDE.md`

Mettre à jour si la session a produit des décisions d'architecture, des changements d'implémentation, des corrections de spec, ou tout élément qui modifie la compréhension du projet. C'est une source de vérité — elle doit refléter la réalité du code, pas une version périmée.

**Sync sécurité automatique :**
Si `[projet].archi.md` existe et contient une section `## Sécurité` :
1. Lire la section `## Sécurité` de `[projet].archi.md`
2. Lire le bloc `## Sécurité — règles de ce projet` du `CLAUDE.md` projet
3. Si les deux diffèrent → mettre à jour le bloc du `CLAUDE.md` projet pour le remettre en phase avec `archi.md`
Cette sync est silencieuse si aucune différence — elle ne signale que si une mise à jour a été faite.

## Étape 3 — GitHub Projects

Met à jour le kanban du projet.

**Prérequis** : `.gh-project.local` présent dans le répertoire courant (voir `/todo` — setup GitHub Projects).

Si `.gh-project.local` existe :
1. Lire les variables : `project_number`, `owner`, `field_status_id`, `option_todo_id`, `option_in_progress_id`, `option_done_id`
2. `gh project item-list $project_number --owner $owner --format json 2>/dev/null` → état actuel du kanban
3. **Tâches terminées cette session** → trouver l'item correspondant et mettre à jour en "Done" :

       gh project item-edit --id [item-id] --project-id [project-id] \
         --field-id $field_status_id --single-select-option-id $option_done_id

4. **Nouvelles tâches identifiées** → créer les items avec titre + description :

       # Créer l'item (retourne PVTI_xxx)
       gh project item-create $project_number --owner $owner --title "[titre]" --format json

       # Récupérer l'ID DI_ du contenu draft
       gh api graphql -f query='{ node(id: "PVTI_xxx") { ... on ProjectV2Item { content { ... on DraftIssue { id } } } } }'

       # Remplir la description (--title obligatoire avec --body)
       gh project item-edit --id "DI_xxx" --title "[titre]" --body "[description depuis .todo.md]"

5. **Tâches démarrées** → mettre à jour en "In Progress" (même commande avec `$option_in_progress_id`)

Si `.gh-project.local` absent → ignorer cette étape silencieusement.

**Note :** les pages Notion (.peda, .log, .spec, .doc) se mettent à jour manuellement via leurs skills dédiés (`/peda`, `/log`, `/spec`, `/doc`) — non automatisé dans /maj.

## Étape 4 — Cohérence skills / doctrine (si projet vibe-method ou si un skill a été modifié)

Si la session a modifié un skill ou un fichier de doctrine (`produit.md`, `methode.md`, `architecture.md`, `securite.md`) :

| Doctrine modifiée | Skill(s) à vérifier |
|---|---|
| `produit.md` | `/brief` `/prd` `/prd-update` `/specs` |
| `architecture.md` | `/archi` |
| `securite.md` | `/securite` |
| `methode.md` | `/roadmap` `/tests` `/recette` |

Pour chaque paire concernée :
1. Lire la doctrine modifiée
2. Lire le skill correspondant
3. Identifier les divergences
4. Proposer la mise à jour à Medwin — ne jamais modifier sans validation explicite

## Checklist finale

- [ ] Tout commité et poussé sur GitHub
- [ ] `CLAUDE.md` mis à jour si nécessaire
- [ ] Bloc sécurité du `CLAUDE.md` synchronisé avec `archi.md` (si projet avec archi)
- [ ] GitHub Projects mis à jour (tâches terminées + nouvelles tâches)
- [ ] Cohérence skills / doctrine vérifiée si applicable
