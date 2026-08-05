---
type: skill
source: ../../.claude/commands/phase-retrospective.md
source_modified: 2026-06-24
wiki_updated: 2026-08-05
tags: [phase-7, rétrospective, fin-de-phase]
phase: 7
---

## Rôle
**`/phase-retrospective`** — Rétrospective de fin de phase ou de fin d'ensemble. **T3 — Opus.**

## Inputs
- `[projet].log.md`
- `[projet].avancement.yaml`
- Métriques estimé vs réel

## Output
`[projet]-retrospective.md`

## Deux modes

**Mode Léger (fin de phase) :** 5 questions retro, suivi de la retro précédente, action items, preview phase suivante, gestion dette.

**Mode Complet (fin d'ensemble) :** analyse complète des logs, calibration estimé vs réel par phase, dette accumulée, bilan global.

## Wiki
- **Écriture** (Mode Complet uniquement — C7) : extrait les leçons cross-projets vers `~/dev/wiki/` — estimation, bugs-patterns, patterns d'archi — tags `[retours]`

**Précédent :** [[skills/recette]] (dernière feature de la phase)
**Suivant :** [[skills/doc-tech]] (Mode A) ou phase suivante
**Doctrine :** [[doctrines/methode]]
