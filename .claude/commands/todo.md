---
description: Lecture de l'état du projet en début de session — sync GitHub Projects puis affichage de l'état courant
allowed-tools: Bash(cat *), Bash(gh *), Bash(git *)
---

Ouvre la session de travail : sync depuis GitHub Projects puis affiche l'état du projet.

## Étape 0 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Étape 0bis — Mise à jour locale

    git pull

Récupère les commits pushés depuis la dernière session (autre machine, modifications manuelles, etc.) avant toute lecture de fichier local.

---

## Étape 1 — Sync GitHub Projects

**GitHub Projects = source de vérité.** Les changements faits dans le kanban entre les sessions ont priorité sur le fichier local.

Si `.gh-project.local` existe dans le répertoire courant :

### 1a — Récupérer tous les items via GraphQL

`item-list` ne retourne pas les champs custom (dates, body). Utiliser GraphQL :

    gh api graphql -f query='
    {
      node(id: "$project_id") {
        ... on ProjectV2 {
          items(first: 50) {
            nodes {
              id
              content { ... on DraftIssue { id title body } }
              fieldValues(first: 10) {
                nodes {
                  ... on ProjectV2ItemFieldSingleSelectValue {
                    name
                    field { ... on ProjectV2SingleSelectField { name } }
                  }
                  ... on ProjectV2ItemFieldDateValue {
                    date
                    field { ... on ProjectV2Field { name } }
                  }
                }
              }
            }
          }
        }
      }
    }'

Extraire pour chaque item : `title`, `body`, `status`, `début`, `fin`, `pvti_id`, `di_id`.

### 1b — Détection des tâches "Late"

Pour chaque item dont le statut est **Todo** ou **In Progress** :
- Si `fin` est défini ET `fin < aujourd'hui` → passer le statut à "Late" dans GH Projects :

      gh project item-edit --id [pvti_id] --project-id $project_id \
        --field-id $field_status_id --single-select-option-id $option_late_id

- Mettre à jour `.todo.md` local en conséquence.

### 1c — Sync Done → local

Pour chaque item avec Status "Done" → si la tâche est encore "À faire" dans `.todo.md` → la déplacer en "Réalisées".

### 1d — Découverte de nouvelles tâches

Pour chaque item présent dans GH mais absent de `.todo.md` (titre non trouvé) → l'ajouter en section "À faire" avec son body comme description.

### 1e — Commit si modifications

Si `.todo.md` a été modifié :

    git add [projet].todo.md && git commit -m "chore: sync todo from gh projects" && git push

Si `.gh-project.local` absent → ignorer silencieusement, continuer avec le fichier local.

---

### Setup GitHub Projects (une fois par projet)

    # 1. Activer le scope nécessaire (une fois par machine)
    gh auth refresh -h github.com -s read:project,project

    # 2. Récupérer le numéro du projet
    gh project list --owner medwinrumo

    # 3. Récupérer les IDs des champs
    gh project field-list [N] --owner medwinrumo --format json

Créer `.gh-project.local` dans le repo :

    project_number=N
    owner=medwinrumo
    project_id=PVT_xxx
    field_status_id=PVTSSF_xxx
    option_todo_id=xxx
    option_in_progress_id=xxx
    option_done_id=xxx
    option_late_id=xxx
    field_debut_id=PVTF_xxx
    field_fin_id=PVTF_xxx

Ajouter `.gh-project.local` au `.gitignore`.

---

## Étape 2 — Affichage

Lis `.todo.md` (maintenant synchronisé) et présente le résumé de démarrage.

**Règles de présentation par statut et dates :**
- **Late** → toujours afficher en premier, avec mention explicite du retard et de la date de fin prévue
- **In Progress** → afficher en deuxième
- **Todo sans dates** → afficher normalement
- **Todo avec `début` > aujourd'hui** → ne pas afficher (tâche pas encore planifiée)
- **Todo avec `début` ≤ aujourd'hui** → afficher normalement

Format de présentation :

```
--- [projet].todo — [date dernière session] ---

Dernière session : [résumé court]

En retard :
  — [tâche] (prévue jusqu'au [fin])

En cours :
  — [tâche]

À faire :
  — [tâche] ([priorité])

Par quoi on commence ?
```

## Règles

- Jamais de Notion, jamais de MCP — GitHub Projects ou fichier local uniquement.
- Pas de reformulation, pas d'analyse — données brutes.
- Si `.todo.md` n'existe pas → signaler et proposer `/majtodo` pour le créer.
