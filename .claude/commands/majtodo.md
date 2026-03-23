---
description: Met à jour [projet].todo.md dans Git et la page [projet].todo dans Notion
allowed-tools: Bash(cat *), Bash(git *), mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour le fichier `[projet].todo.md` dans le dépôt Git et son miroir `[projet].todo` dans Notion.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de [projet].todo

État exécutif du projet — lu en priorité pour se remettre dans le contexte à l'ouverture d'une session. Ce n'est pas un journal : c'est une photo de l'état actuel et de ce qui reste à faire. Il remplace la lecture du CLAUDE.md complet pour le quotidien.

## Structure cible
```
# [projet].todo.md — État exécutif du projet [Nom]

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — [date]

### Ce qui a été fait
- [liste factuelle des avancées]

---

## Tâches

### À faire
- 3 — [description]
- 5 — [description]

### Réalisées
- 1 — [description]
- 2 — [description]
- 4 — [description]

---

## État général du projet

| Élément | État |
|---|---|
| [composant] | ✅ Fonctionnel / 🔧 En cours / ❌ Non implémenté |
```

## Règles sur les numéros de tâches

Les numéros sont fixes et permanents. Une tâche garde son numéro pour toujours, qu'elle soit à faire ou réalisée. L'ordre dans la liste n'a pas d'importance — on peut très bien avoir "À faire : 1, 3" si 2 est déjà réalisée.

Quand une nouvelle tâche émerge : lui attribuer le prochain numéro disponible (jamais réutiliser un numéro existant).
Quand une tâche est terminée : la déplacer de "À faire" vers "Réalisées" sans changer son numéro.

## Processus
0. Vérifier si `[projet].todo.md` existe dans le répertoire courant. Si non, le créer avec la structure cible avant toute autre action.
1. Lire l'état actuel du fichier `.todo.md` existant
2. Mettre à jour "Dernière session" avec ce qui s'est passé cette session
3. Déplacer dans "Réalisées" les tâches terminées pendant la session
4. Ajouter en "À faire" les nouvelles tâches qui émergent (nouveaux numéros)
5. Mettre à jour le tableau d'état si des éléments ont changé
6. Commiter et pousser le fichier mis à jour (`git add [projet].todo.md && git commit -m "chore: update todo" && git push`)
7. Faire la même mise à jour sur la page `[projet].todo` dans Notion (créer si inexistante)

Le contenu Notion est identique au fichier Git — c'est un miroir, pas une version différente.
