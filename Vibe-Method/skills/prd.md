---
type: skill
source: ../../.claude/commands/prd.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-1, produit, prd]
phase: 1
---

## Rôle
**`/prd`** — Du brief au PRD V1 en dialogue (cross-pollination entre IA).

## Inputs
- `[projet].brief.md`

## Output
`[projet].prd.md` V1

## En résumé
Construit le PRD en dialogue à partir du brief. La méthode est la cross-pollination : le PRD V1 est ensuite soumis à d'autres IA pour critique croisée, dont les retours sont intégrés par `/prd-update` pour produire le V2. Questions sur le stack design posées à cette étape.

## Contenu du PRD
- Objectif du produit
- Utilisateurs cibles
- Features prioritaires V1
- Contraintes techniques
- Questions ouvertes

**Précédent :** [[skills/brief]] | **Suivant :** [[skills/prd-update]]
**Doctrine :** [[doctrines/produit]]
