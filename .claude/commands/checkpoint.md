---
description: Documentation intermédiaire de session — Notion uniquement, sans clôture Git
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Documente ce qui s'est passé depuis le dernier checkpoint (ou depuis le début de la session si c'est le premier). Sans clôture Git, sans interruption du travail.

À utiliser :
- Quand la session devient longue et que la compaction du contexte approche
- Avant une pause imprévue
- Après un bloc de travail significatif

---

## Étape 1 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

---

## Étape 2 — Lecture des pages existantes

Avant d'écrire quoi que ce soit :
1. Récupérer le contenu actuel de `[projet].peda` dans Notion
2. Récupérer le contenu actuel de `[projet].log` dans Notion
3. Identifier ce qui est déjà documenté — repérer la dernière entrée de session
4. Ne documenter que l'incrément depuis cette dernière entrée

**Convention couleur :** tout contenu ajouté dans une page existante doit être coloré en bleu (`{color="blue"}`).

Si les pages n'existent pas → les créer, reliées à `[projet].exe` dans la DB Projets.

---

## Étape 3 — Documentation de l'incrément

### Page `[projet].peda`

Rédiger uniquement ce qui s'est passé depuis le dernier point documenté.

Structure :
```
▶ Jour N — [date] — [objectif de la session]
    ▶ Session N — [résumé en une phrase]
        - Ce qu'on a fait et pourquoi (contexte, intention, décision)
        - Comment (outils, commandes, méthodes utilisées)
        - Difficultés rencontrées et comment elles ont été résolues
        - Points qui méritent compréhension ou recul
```

Si le menu du jour courant existe déjà → ajouter le contenu dans ce menu, dans un nouveau sous-menu de session. Jamais dans le menu d'une session précédente.

### Page `[projet].log`

Entrées courtes et factuelles depuis le dernier point documenté. Même structure de menus imbriqués.

---

## Étape 4 — Confirmation et reprise

> "Checkpoint effectué — `[projet].peda` et `[projet].log` à jour jusqu'à maintenant. On continue."

Le travail reprend immédiatement après. Aucune action Git requise.
