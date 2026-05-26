---
type: skill
source: ../.claude/commands/adr.md
source_modified: 2026-05-12
wiki_updated: 2026-05-26
tags: [architecture, décision, adr]
phase: transversal
---

## Rôle
**`/adr`** — Capture d'une décision architecturale en 4 questions. Filtre 3 conditions avant création.

## Inputs
- Décision architecturale identifiée (depuis `/archi` ou `/specs`)

## Output
`[projet].adr.md` (append — une entrée par décision)

## En résumé
Filtre obligatoire avant création : la décision est-elle structurante ? Irréversible ou coûteuse à changer ? Non évidente pour un nouvel intervenant ? Si oui aux 3 → ADR créé. Structure : contexte, options considérées, décision, conséquences. Proposé automatiquement par `/archi` (étape 5b) et `/specs` (étape 4d).

**Déclenché par :** [[skills/archi]] ou [[skills/specs]]
**Doctrine :** [[doctrines/architecture]]
