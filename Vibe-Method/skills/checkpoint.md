---
type: skill
source: ../../.claude/commands/checkpoint.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [session, documentation, intermédiaire]
phase: session
---

## Rôle
**`/checkpoint`** — Documentation intermédiaire en cours de session : met à jour `.peda.md` et `.log.md` sans clôture Git.

## En résumé
Version allégée de `/maj` : met à jour la documentation locale (journal pédagogique + log de bord) sans commit ni push. Utile lors de sessions longues pour ne pas perdre les apprentissages en cas de coupure. Si `/checkpoint` a été utilisé en cours de session, `/maj` ne documente que l'incrément restant.

**Transversal — invocable en cours de session**
