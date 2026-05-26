---
type: skill
source: ../.claude/commands/deploy.md
source_modified: 2026-05-13
wiki_updated: 2026-05-26
tags: [infrastructure, déploiement, prod, vercel]
phase: infrastructure
---

## Rôle
**`/deploy`** — Mise en production guidée, pas à pas, selon le niveau défini dans `[projet].archi.md`.

## Inputs
- `[projet].archi.md` (niveau de déploiement 1/2/3)

## En résumé
Guide la mise en production selon le niveau défini à l'archi : Niveau 1 (proto — pas de staging), Niveau 2 (app client — staging à la demande, migrations versionnées), Niveau 3 (app critique — rollback auto, validation humaine). Checklist de sécurité obligatoire avant go-live.

**Précédent :** [[skills/recette]] (validation complète) | **Doctrine :** [[doctrines/architecture]]
