---
type: skill
source: ../../.claude/commands/commit.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [phase-6, git, conventional-commits, t1]
phase: 6
---

## Rôle
**`/commit`** — Commit propre au format Conventional Commits depuis le diff Git. **T1 — Haiku optionnel.**

## Inputs
- `git status` + `git diff`

## Output
Commit créé dans le dépôt Git (pas de fichier .md)

## En résumé
Lit le diff, propose un message structuré (`type(scope): description`), attend validation, exécute. Global — utilisé dans tous les projets. Types : feat, fix, refactor, test, docs, chore, style.

**Taille indicative** (2026-07-28) : ~100 lignes par commit, découpage proposé au-delà de ~1000 ou si le diff mélange plusieurs sujets.

**Précédent :** [[skills/recette]] / [[skills/debug]] | **Suivant :** [[skills/pr]]
