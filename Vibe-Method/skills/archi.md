---
type: skill
source: ../../.claude/commands/archi.md
source_modified: 2026-06-24
wiki_updated: 2026-08-05
tags: [phase-3, architecture, modules, silos, stack, mcp]
phase: 3
---

## Rôle
**`/archi`** — Architecture modulaire + silos + garde-fous. Se construit en aller-retour avec `/design` Mode A.

## Inputs
- `[projet].prd.md`
- `[projet].design.md` (ou en construction)
- `[projet].brief.md`

## Output
- `[projet].archi.md`
- `CLAUDE.md` du projet

## En résumé
Définit les modules et leurs responsabilités, les règles silo, la stack (Convex ou Supabase), le niveau de déploiement, la stratégie de backup, les décisions RGPD, et les dépendances MCP. Phase itérative avec `/design` Mode A jusqu'à cohérence complète entre design et architecture.

## Sections de `[projet].archi.md`
- Modules métier et responsabilités
- Modules techniques (/shared, /config, /db, /api)
- Règles silo (qui peut appeler quoi)
- Contrats d'interface entre modules
- Navigation & Routing (complété par /design Mode B)
- Stack (Convex ou Supabase, distribution)
- Section Sécurité (schéma des rôles, RLS, endpoints publics/authentifiés)
- Niveau de déploiement (1/2/3)
- Backup (niveau de criticité des données)
- RGPD (base légale, durée de rétention)
- MCP (global / par-projet / on-demand)

## WebSearch obligatoire
Avant confirmation de la stack native (version Expo actuelle) et du back-end (free tier Supabase/Convex actuel).

## Wiki
- **Lecture** : lit les patterns d'archi existants dans le Wiki avant les décisions
- **Écriture** : propose d'écrire les patterns génériques validés dans `~/dev/wiki/` — tags `[patterns]`

**Précédent :** [[skills/design]] Mode A (aller-retour) | **Suivant :** [[skills/angles-morts]] (archi) → [[skills/regles]]
**Doctrine :** [[doctrines/architecture]] | [[doctrines/securite]]
