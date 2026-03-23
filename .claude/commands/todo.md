---
description: Lecture de l'état du projet en début de session — affiche ce qui reste à faire et propose de choisir par où commencer
allowed-tools: Bash(cat *)
---

Lis `[projet].todo.md` et présente un résumé de démarrage de session.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Ce que tu affiches

1. **Dernière session** — une ou deux lignes sur ce qui a été fait (depuis la section "Dernière session" du fichier)
2. **Tâches à faire** — la liste numérotée des tâches restantes, telle qu'elle est dans le fichier
3. **Question** : "Par quoi on commence ?"

## Format de présentation

```
--- [projet].todo — [date dernière session] ---

Dernière session : [résumé court]

À faire :
  3 — [description]
  5 — [description]

Par quoi on commence ?
```

Pas de reformulation, pas d'analyse — présente les données du fichier telles quelles. Si le fichier n'existe pas, le signaler et proposer de lancer `/majtodo` pour le créer.
