---
type: skill
source: ../.claude/commands/design.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-2, design, claude-design, tailwind, nativewind]
phase: 2
---

## Rôle
**`/design`** — Deux modes : design system complet input Claude Design (Mode A) / intégration code Claude Design → Tailwind ou NativeWind (Mode B).

## Inputs
- Mode A : `[projet].charte.md` + `[projet].prd.md` + `ui-vocabulary.md`
- Mode B : code HTML/CSS/JS de Claude Design

## Output
- Mode A : `[projet].design.md` (+ `[projet].design-system.md` et `[projet].design-screens-*.md` si two-step)
- Mode B : composants React avec classes Tailwind / NativeWind

## Mode A — Design system (aller-retour avec /archi)

**One-shot** (≤ 6 écrans, 1 rôle) : un seul `[projet].design.md`.
**Two-step** (> 6 écrans, rôles multiples) : Passe 1 (design-system) → Claude Design → Passe 2 (screens par batch, chacun avec référence complète aux tokens).

Claude Design n'a **pas de mémoire entre sessions** — chaque fichier de screens doit inclure la référence complète au design system.

## Mode B — Intégration

1. Réception du code HTML/CSS/JS de Claude Design
2. Extraction du routing (tableau Simple/Conditionnel/Action) → écrit dans `[projet].archi.md`
3. Traduction en Tailwind (web) ou NativeWind (natif)
4. Révision in-browser obligatoire avant de passer au code métier

**Précédent :** [[skills/charte]] (Mode A) ou Claude Design (Mode B)
**Suivant :** [[skills/archi]] (Mode A) ou [[skills/roadmap]] (Mode B)
**Doctrine :** [[doctrines/design]]
