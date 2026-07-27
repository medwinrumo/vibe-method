---
type: skill
source: ../../.claude/commands/roadmap.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-5, planification, roadmap]
phase: 5
---

## Rôle
**`/roadmap`** — Roadmap + planning global à partir du PRD, du design et de l'architecture.

## Inputs
- `[projet].prd.md`
- `[projet].design.md`
- `[projet].archi.md`
- `[projet].stack.md` (limites free tier)

## Output
`[projet].Rmap.md`

## En résumé
Découpe les features en blocs parallélisables. Chaque bloc = la plus petite feature possible. Calibrée sur les limites du free tier. Inclut la question agent IA : certaines tâches (migrations, audits, génération de tests en masse) justifient un agent plutôt qu'un skill — à noter dans la roadmap.

**Précédent :** [[skills/stack]] | **Suivant :** [[skills/specs]]
**Doctrine :** [[doctrines/methode]]
