---
type: agent
source: ../../.claude/agents/test-engineer.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [agent, tests, doubt-driven]
---

## Rôle
**`test-engineer`** — Audit de stratégie de test et analyse de couverture sur du code existant, hors flux TDD. Contexte frais isolé, lecture seule.

## Différence avec `/tests`
`/tests` génère et fait tourner les tests depuis une spec, dans le flux TDD. `test-engineer` **n'écrit jamais de fichier de test** — il analyse et recommande seulement, sur du code déjà là, hors flux TDD normal.

## Outils
Read, Grep, Bash (lecture seule — lance la suite existante, n'écrit rien)

## Sortie
Couverture actuelle, trous identifiés, tests recommandés par priorité.

## Composition
Invocation directe uniquement — jamais depuis une autre persona.

## Liens
[[doctrines/tests]] | [[doctrines/methode]] | [[agents/code-reviewer]]
