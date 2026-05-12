---
description: Lecture de l'état du projet en début de session — sync GitHub Projects puis affichage de l'état courant
allowed-tools: Bash(cat *), Bash(gh *), Bash(git *)
---

Ouvre la session de travail : sync depuis GitHub Projects puis affiche l'état du projet.

## Étape 0 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Étape 1 — Sync GitHub Projects

**GitHub Projects = source de vérité.** Les changements faits dans le kanban entre les sessions ont priorité sur le fichier local.

Si `.gh-project.local` existe dans le répertoire courant :
1. Lire les variables : `project_number`, `owner`, `field_status_id`, `option_done_id`
2. `gh project item-list $project_number --owner $owner --format json 2>/dev/null`
3. Pour chaque item avec Status "Done" → si la tâche est encore "À faire" dans `.todo.md` local → la déplacer en "Réalisées"
4. Mettre à jour `.todo.md` local si des changements ont été détectés
5. Si modifié → `git add [projet].todo.md && git commit -m "chore: sync todo from gh projects" && git push`

Si `.gh-project.local` absent → ignorer silencieusement, continuer avec le fichier local.

### Setup GitHub Projects (une fois par projet)

    # 1. Activer le scope nécessaire
    gh auth refresh -s read:project,project

    # 2. Récupérer le numéro du projet
    gh project list --owner medwinrumo

    # 3. Récupérer les IDs des champs Status
    gh project field-list [N] --owner medwinrumo --format json

Créer `.gh-project.local` dans le repo :

    project_number=N
    owner=medwinrumo
    field_status_id=PVTF_xxx
    option_todo_id=xxx
    option_in_progress_id=xxx
    option_done_id=xxx

Ajouter `.gh-project.local` au `.gitignore`.

---

## Étape 2 — Affichage

Lis `.todo.md` (maintenant synchronisé) et présente le résumé de démarrage.

1. **Dernière session** — une ou deux lignes (depuis la section "Dernière session")
2. **Tâches actives** — "En cours" et "Bloqué" en priorité, puis "À faire"
3. **Question** : "Par quoi on commence ?"

## Format de présentation

```
--- [projet].todo — [date dernière session] ---

Dernière session : [résumé court]

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
