---
type: skill
source: ../.claude/commands/devis.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [commercial, devis, qualification, scoring]
phase: commercial
---

## Rôle
**`/devis`** — Du brief à la proposition commerciale complète.

## Inputs
- `[projet].brief.md`
- `[projet].context.md` si existant

## Output
`[projet].proposition.md`

## En résumé
Qualification client en 6 dimensions + scoring (via exa:search — 8 angles), estimation complète en deux parties : phases workflow calibrées depuis les paramètres du brief + blocs dev par table de référence patterns Supabase/Convex. Décisions commerciales clés : profil acheteur, prix, arguments. Résumé devis + détail par phase.

## Structure de la proposition
1. Qualification et scoring client (6 dimensions)
2. Estimation des phases (calibrée sur le modèle M1/M2/M3, stack, sécurité, features)
3. Blocs dev (table de référence patterns)
4. Récapitulatif commercial
5. Grille de décision (profil acheteur, prix, arguments)

**Précédent :** [[skills/brief]] | **Suivant :** [[skills/cgv]]
**Doctrine :** [[doctrines/produit]]
