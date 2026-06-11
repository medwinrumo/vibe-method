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
4 étapes : (1) lit la spec + `git log`, (2) génère titre `feat:` + corps formaté (description, changements, checklist tests, référence spec), attend validation, (3) exécute `gh pr create`, (4) merge manuel sur GitHub — ouvrir l'URL, relire le diff, cliquer Merge pull request → Confirm merge, puis Delete branch. Le merge n'est pas automatique — c'est un acte de validation humaine intentionnel.

**Précédent :** [[skills/commit]] | **Suivant :** [[skills/phase-retrospective]]
