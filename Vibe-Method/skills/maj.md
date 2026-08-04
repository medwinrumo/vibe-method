---
type: skill
source: ../../.claude/commands/maj.md
source_modified: 2026-08-04
wiki_updated: 2026-08-04
tags: [session, clôture, git, github-projects, task-observer]
phase: session
---

## Rôle
**`/maj`** — Clôture de session complète : Git + GitHub Projects. **T1 — Haiku optionnel** (tâche mécanique).

## En résumé
Clôture systématique à la fin de chaque session. 7 étapes : documentation locale → Git (+ sync sécurité CLAUDE.md) → GitHub Projects → lint wiki (si projet vibe-method et sources modifiées) → cohérence skills/doctrine → **review task-observer** (présente les observations OUVERTES groupées par skill, jamais de modification sans validation explicite). Pont Notion retiré — plus d'auto `.peda`/`.log`/`.spec`/`.doc` (depuis 2026-05-12).

## Table cohérence skills/doctrine (Étape 6)
`stack.md` → `/stack` `/specs` | `observabilite.md` → `/specs` `/deploy` | `accessibilite.md` (nouveau, 2026-07-28) → `/specs` `/design` `/code-review` | `architecture.md` → `/archi` `/specs`

## Ce qui NE fait PAS /maj
- Mettre à jour les fichiers .peda, .log, .spec, .doc (c'est /checkpoint ou les skills dédiés)
- Synchroniser Notion (supprimé)

## Checklist — ajout 2026-08-04
Si la session a déployé quoi que ce soit : `[projet].deploy.md` créé ou à jour, et la source dans un dépôt git local — pas uniquement sur le serveur. Voir [[skills/deploy]] étape 6.

**En fin de chaque session, sans exception**
