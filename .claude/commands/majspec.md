---
description: Met à jour uniquement la page [projet].spec dans Notion
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour la page `[projet].spec` dans Notion pour le projet en cours de travail.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de la page `.spec`

Référence vivante de ce que le projet doit faire et comment il doit le faire. Elle reflète l'état des décisions à date — pas l'état initial du brief, pas l'état du code implémenté.

Frontières à respecter :
- `.spec` ≠ CLAUDE.md : CLAUDE.md est le brief initial de référence. `.spec` est la spec évolutive, mise à jour session après session. En cas de divergence, `.spec` a priorité sur CLAUDE.md pour les décisions prises après le lancement.
- `.spec` ≠ `.doc/Développeur` : `.doc/Développeur` documente ce qui est implémenté. `.spec` documente ce qui est décidé — y compris ce qui n'est pas encore codé.

## Structure cible
```
## Fonctionnalités

| Fonctionnalité | État | Notes |
|---|---|---|
| [nom] | Spécifiée / En cours / Implémentée / Abandonnée | [décision ou contrainte] |

## Architecture

[Décisions d'architecture actives — format libre, daté si utile]

## Contraintes

[Contraintes techniques, métier ou d'usage en vigueur]

## Décisions abandonnées

[Ce qui a été écarté et pourquoi — évite de reconsidérer les mêmes options]
```

## Processus de mise à jour

1. Lire l'état actuel de la page avant toute modification
2. Identifier ce qui a changé pendant la session : nouvelle fonctionnalité spécifiée, décision d'architecture, contrainte levée ou ajoutée, fonctionnalité abandonnée
3. Mettre à jour les sections concernées — ne pas empiler, modifier l'existant
4. Si une décision est abandonnée, la déplacer dans "Décisions abandonnées" plutôt que de la supprimer

Ne pas toucher si la session n'a produit aucun changement de spec.
