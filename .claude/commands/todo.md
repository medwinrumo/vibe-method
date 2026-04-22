---
description: Lecture de l'état du projet en début de session — affiche ce qui reste à faire et propose de choisir par où commencer
allowed-tools: Bash(cat *), mcp__claude_ai_Notion__notion-query-database-view
---

Lis `[projet].todo.md` et interroge le Kanban Notion du projet pour présenter un résumé de démarrage de session.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Ce que tu affiches

1. **Dernière session** — une ou deux lignes sur ce qui a été fait (depuis la section "Dernière session" du fichier local)
2. **Tâches actives** — requête le Kanban Notion (URL dans le fichier local, section "Kanban Notion") pour afficher les tâches "En cours" et "Bloqué" en priorité, puis "À faire"
3. **Lien Kanban** — affiche l'URL Notion pour accès direct
4. **Question** : "Par quoi on commence ?"

## Format de présentation

```
--- [projet].todo — [date dernière session] ---

Dernière session : [résumé court]

Bloqué :
  — [tâche] ([priorité])

En cours :
  — [tâche] ([priorité])

À faire :
  — [tâche] ([priorité])

Kanban : [URL Notion]

Par quoi on commence ?
```

## Règles

- Si le Kanban Notion n'est pas accessible, afficher les tâches depuis le fichier local en fallback.
- Pas de reformulation, pas d'analyse — données brutes.
- Si le fichier local n'existe pas, le signaler et proposer de lancer `/majtodo` pour le créer.
