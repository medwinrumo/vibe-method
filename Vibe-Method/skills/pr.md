---
type: skill
source: ../.claude/commands/pr.md
source_modified: 2026-06-11
wiki_updated: 2026-06-11
tags: [phase-6, git, github, pull-request, t1]
phase: 6
---

## Rôle
**`/pr`** — Pull Request générée depuis la spec de la feature. **T1 — Haiku optionnel.**

## Inputs
- `[projet].spec.[feature].md`
- `git log`

## Output
Pull Request créée sur GitHub via `gh pr create` (pas de fichier .md)

## En résumé
Génère titre + corps formatés (description, changements, checklist de tests, référence spec), attend validation, exécute `gh pr create --title --body --base main`.

**Précédent :** [[skills/commit]] | **Suivant :** [[skills/phase-retrospective]]
