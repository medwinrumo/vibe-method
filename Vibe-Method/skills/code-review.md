---
type: skill
source: ../../.claude/commands/code-review.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [phase-7, code-review, sécurité, qualité]
phase: 7
---

## Rôle
**`/code-review`** — Revue structurelle + sécurité avant merge. Bloquant si point critique.

## Inputs
- Code de la feature codée

## En résumé
Revue de la qualité structurelle (architecture, silo, conventions) et de la sécurité. Si un point critique est identifié → bloquant, pas de merge possible. Premier filtre dans la quality chain après le code.

## Points de sécurité vérifiés
- Auth vérifiée côté serveur (pas seulement guard React)
- Policies RLS distinctes par opération
- Mutations avec whitelist de champs
- Security headers dans `vercel.json`
- Packages nouveaux vérifiés sur npmjs.com
- `dangerouslySetInnerHTML` → DOMPurify

**Précédent :** [code] | **Suivant :** [[skills/code-review-edge-cases]]
**Doctrine :** [[doctrines/securite]]
