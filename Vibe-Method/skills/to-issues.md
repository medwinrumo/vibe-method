---
type: skill
source: ../.claude/commands/to-issues.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [phase-5, github, issues, hitl, afk]
phase: 5
---

## Rôle
**`/to-issues`** — Transforme specs + roadmap en issues GitHub qualifiées HITL/AFK, découpées en vertical slices.

## Inputs
- `[projet].Rmap.md`
- `[projet].spec.[feature].md` (une ou plusieurs)

## Output
Issues GitHub créées (via `gh` CLI)

## En résumé
Chaque spec devient une ou plusieurs issues GitHub. Chaque issue est qualifiée : HITL (Human-In-The-Loop — décision humaine requise) ou AFK (Away From Keyboard — peut tourner en autonomie). Découpage en vertical slices (feature complète de bout en bout, pas par couche technique).

**Précédent :** [[skills/specs]] | **Suivant :** [[skills/readyTo-code]]
