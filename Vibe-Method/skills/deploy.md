---
type: skill
source: ../../.claude/commands/deploy.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [infrastructure, déploiement, prod, vercel, observabilite]
phase: infrastructure
---

## Rôle
**`/deploy`** — Mise en production guidée, pas à pas, selon le niveau défini dans `[projet].archi.md`.

## Inputs
- `[projet].archi.md` (niveau de déploiement 1/2/3)

## En résumé
Guide la mise en production selon le niveau défini à l'archi : Niveau 1 (proto — pas de staging), Niveau 2 (app client — staging à la demande, migrations versionnées), Niveau 3 (app critique — rollback auto, validation humaine). Checklist de sécurité obligatoire avant go-live.

## Wiki
- **Lecture** : lit les patterns de déploiement existants pour la stack du projet
- **Écriture** : gotchas découverts pendant le déploiement → propose de les écrire dans `~/dev/wiki/[outil]-deploy.md` — tags `[stack, déploiement]`

## Pre-Launch Gate observabilité (Étape 5bis)
Avant toute mise en prod : `scripts/lint-observabilite.py` — vérifie mécaniquement que chaque spec marquée "Observabilité : Requise" a sa section "Signaux à instrumenter" remplie. Bloquant si incomplet, même logique que `/securite audit`. Voir [[doctrines/observabilite]].

## Feature flags et rollout progressif — niveau 3 (2026-07-28)
Cycle de vie du flag (deploy OFF → équipe/beta → 5%→25%→50%→100% → nettoyage sous 2 semaines) + table de seuils avancer/observer/rollback (taux d'erreur, latence p95, erreurs JS, métriques business).

**Précédent :** [[skills/recette]] (validation complète) | **Doctrine :** [[doctrines/architecture]] | [[doctrines/observabilite]]
