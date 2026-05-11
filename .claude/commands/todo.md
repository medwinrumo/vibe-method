---
description: Lecture de l'état du projet en début de session — affiche ce qui reste à faire et propose de choisir par où commencer
allowed-tools: Bash(cat *)
---

Lis `[projet].todo.md` et présente un résumé de démarrage de session.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Ce que tu affiches

1. **Dernière session** — une ou deux lignes sur ce qui a été fait (depuis la section "Dernière session" du fichier local)
2. **Tâches actives** — depuis le fichier local uniquement : "En cours" et "Bloqué" en priorité, puis "À faire"
3. **Question** : "Par quoi on commence ?"

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

Par quoi on commence ?
```

## Règles

- Lecture du fichier local uniquement — jamais de Notion, jamais de MCP.
- Pas de reformulation, pas d'analyse — données brutes.
- Si le fichier local n'existe pas, le signaler et proposer de lancer `/majtodo` pour le créer.
