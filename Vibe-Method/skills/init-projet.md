---
type: skill
source: ../../.claude/commands/init-projet.md
source_modified: 2026-05-26
wiki_updated: 2026-05-26
tags: [infrastructure, git, bootstrap, obsidian, wiki]
phase: infrastructure
---

## Rôle
**`/init-projet`** — Initialisation d'un nouveau projet : Git + GitHub + vault Obsidian + règles Wiki.

## En résumé
Bootstrap complet d'un nouveau projet en 3 étapes : repo Git local + GitHub (privé), fichiers de base (`CLAUDE.md` avec section Wiki, `.todo.md`, `.log.md`, `.context.md`), vault Obsidian `Wiki-[projet]/` prêt à être ouvert dans Obsidian, kanban GitHub Projects configuré. Point de départ avant `/brief`.

## Ce que crée /init-projet
- `CLAUDE.md` — avec section Wiki (règles lecture/écriture, skills concernés)
- `[projet].todo.md` / `.log.md` / `.context.md`
- `Wiki-[projet]/` — vault Obsidian local (CLAUDE.md schéma, index.md, log.md)
- `.gh-project.local` — config kanban (gitignorée)

## Wiki
- Injecte les règles d'accès au Wiki dans le `CLAUDE.md` du projet dès la création

## Workflow projet
1. `/init-projet` → infrastructure complète
2. Ouvrir `Wiki-[projet]/` comme vault dans Obsidian
3. `/brief` → début du workflow

**Précédent :** (début de projet) | **Suivant :** [[skills/brief]]
