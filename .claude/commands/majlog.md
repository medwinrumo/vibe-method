---
description: Met à jour uniquement la page [projet].log dans Notion pour la session en cours
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour la page `[projet].log` dans Notion pour le projet en cours de travail.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de la page `.log`

Journal de bord factuel et daté. Entrées courtes, sans explication technique — les détails sont dans `.peda`. L'objectif est une trace concise de ce qui s'est passé, consultable d'un coup d'œil.

## Création

Si la page `[projet].log` n'existe pas dans Notion, la créer avant d'y écrire.

## Structure

Ajouter les entrées de la session courante, imbriquées dans le menu du jour :
```
▶ Jour N — [date]
    ▶ Session N — [résumé en une phrase]
        - [entrée factuelle 1]
        - [entrée factuelle 2]
```

Chaque session dans son propre menu dépliant. Jamais dans le menu d'une session précédente.

## Calibrage des entrées

- Bonne entrée : `Implémenté streaming SSE sur POST /api/chat`
- Trop vague : `Travaillé sur le chat`
- Trop technique : `Modifié le handler EventSource pour corriger le flush des chunks en cas de timeout réseau`

Les détails techniques vont dans `.peda`, pas ici.
