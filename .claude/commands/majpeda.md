---
description: Met à jour uniquement la page [projet].peda dans Notion pour la session en cours
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour la page `[projet].peda` dans Notion pour le projet en cours de travail.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de la page `.peda`

Journal d'apprentissage à vocation pédagogique. Elle n'est pas un simple compte-rendu : elle est rédigée avec une intention professorale, comme si on expliquait à Medwin — qui est en phase d'apprentissage — ce qui s'est passé, pourquoi les choses ont été faites ainsi, ce qu'il faut avoir compris. Le ton est celui d'un formateur qui documente pour que l'apprenant puisse relire et comprendre sans avoir vécu la session. Les difficultés, les erreurs, les doutes méritent autant d'attention que les succès.

## Structure

Ajouter un menu dépliant pour la session courante, imbriqué dans le menu du jour s'il existe, sinon créer le menu du jour :

```
▶ Jour N — [date] — [objectif de la session]
    ▶ Session N — [résumé en une phrase]
        - Ce qu'on a fait et pourquoi (contexte, intention, décision)
        - Comment (outils, commandes, méthodes utilisées)
        - Difficultés rencontrées et comment elles ont été résolues
        - Points qui méritent compréhension ou recul
```

Règle absolue : chaque session dans son propre menu dépliant. Jamais dans le menu d'une session précédente.
