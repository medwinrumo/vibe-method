# /spec — Référence de spec globale

Met à jour le fichier `[projet].spec-global.md` pour le projet en cours de travail.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de `.spec-global`

Référence vivante de ce que le projet doit faire et comment il doit le faire. Elle reflète l'état des décisions à date — pas l'état initial du brief, pas l'état du code implémenté.

Frontières à respecter :
- `.spec-global` ≠ `CLAUDE.md` : CLAUDE.md est le brief initial de référence. `.spec-global` est la spec évolutive, mise à jour session après session. En cas de divergence, `.spec-global` a priorité sur CLAUDE.md pour les décisions prises après le lancement.
- `.spec-global` ≠ `[projet].doc.md` : `.doc` documente ce qui est implémenté du point de vue utilisateur. `.spec-global` documente ce qui est décidé — y compris ce qui n'est pas encore codé.
- `.spec-global` ≠ `[projet].spec.[feature].md` : les specs de feature (produites par `/specs`) documentent une user story précise et auto-contenue. `.spec-global` documente l'état global du projet.

## Structure cible

Si le fichier n'existe pas → le créer avec cette structure.

```markdown
# [projet].spec-global — Référence de spec

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

1. Lire l'état actuel du fichier avant toute modification
2. Identifier ce qui a changé pendant la session : nouvelle fonctionnalité spécifiée, décision d'architecture, contrainte levée ou ajoutée, fonctionnalité abandonnée
3. Mettre à jour les sections concernées — ne pas empiler, modifier l'existant
4. Si une décision est abandonnée, la déplacer dans "Décisions abandonnées" plutôt que de la supprimer

Ne pas toucher si la session n'a produit aucun changement de spec.
