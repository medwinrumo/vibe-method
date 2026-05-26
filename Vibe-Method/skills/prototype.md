---
type: skill
source: ../.claude/commands/prototype.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [transversal, prototype, décision, jetable]
phase: transversal
---

## Rôle
**`/prototype`** — Code jetable pour valider une décision impossible à trancher sans la voir tourner.

## Deux branches

**Branche logique** : terminal interactif pour tester une logique métier incertaine.
**Branche UI** : variations switchables pour comparer deux approches visuelles.

## En résumé
Déclenché par Claude quand une décision ne peut pas être tranchée par le raisonnement seul. Le prototype est explicitement jetable — pas commité, pas testé, pas documenté. Son seul rôle : produire de la compréhension. Jeter ensuite, recommencer proprement.

Correspond au pattern "YOLO first" de `methode.md` Phase 5.

**Transversal — invocable à tout moment**
