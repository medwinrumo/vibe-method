---
type: skill
source: ../.claude/commands/prd-validate.md
source_modified: 2026-06-11
wiki_updated: 2026-06-11
tags: [phase-1, produit, gate, prd]
phase: 1
---

## Rôle
**`/prd-validate`** — Gate de validation PRD avant `/archi` — 8 zones à vérifier.

## Inputs
- `[projet].prd.md` V2

## Output
Rapport GO / BLOCKERS (pas de fichier)

## En résumé
Vérifie la complétude, la traçabilité et la cohérence du PRD avant de passer à l'architecture. Si des BLOCKERS sont identifiés, le PRD doit être revu avant de continuer. C'est la porte d'entrée vers la phase design/architecture.

## 8 zones vérifiées
Complétude, traçabilité des features, cohérence, définitions claires, hors-scope explicite, critères d'acceptation mesurables, niveau de risque sécurité défini, RGPD identifié.

**Précédent :** [[skills/prd-update]] | **Suivant :** [[skills/angles-morts]] (PRD) → [[skills/charte]] / [[skills/archi]]
**Doctrine :** [[doctrines/produit]]
