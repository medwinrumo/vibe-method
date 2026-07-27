---
type: skill
source: ../../.claude/commands/repair-edge-cases.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [phase-7, code-review, edge-cases, correction]
phase: 7
---

## Rôle
**`/repair-edge-cases`** — Correction des cas non gérés identifiés par `/code-review-edge-cases`, un par un dans l'ordre de priorité.

## Inputs
- Code de la feature
- Liste des cas non gérés (output de `/code-review-edge-cases`)

## En résumé
Traite les cas non gérés par ordre de criticité. Un cas à la fois : announcé, corrigé, vérifié. Jamais de correction en lot. Chaque correction fait l'objet d'une validation avant de passer au suivant.

**Précédent :** [[skills/code-review-edge-cases]] | **Suivant :** [[skills/code-review-hostil]]
