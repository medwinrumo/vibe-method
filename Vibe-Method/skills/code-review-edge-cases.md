---
type: skill
source: ../../.claude/commands/code-review-edge-cases.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [phase-7, code-review, edge-cases]
phase: 7
---

## Rôle
**`/code-review-edge-cases`** — Chasse aux cas non gérés : énumération mécanique de tous les chemins d'exécution.

## Inputs
- Code de la feature

## En résumé
Énumère systématiquement tous les chemins d'exécution possibles (pas seulement le happy path) : champs vides, caractères spéciaux, types incorrects, actions hors séquence, valeurs extrêmes, états inattendus. Chaque cas non géré est listé avec sa criticité.

**Précédent :** [[skills/code-review]] | **Suivant :** [[skills/repair-edge-cases]]
**Doctrine :** [[doctrines/tests]]
