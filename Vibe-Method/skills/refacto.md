---
type: skill
source: ../../.claude/commands/refacto.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [refacto, session-dédiée, dette]
phase: transversal
---

## Rôle
**`/refacto`** — Refactoring guidé : diagnostic + exécution étape par étape. Session dédiée obligatoire.

## Inputs
- Module ciblé (signaux de dégradation)
- Tests existants (doivent passer avant de commencer)

## En résumé
4 étapes : vérification que la session est dédiée au refactoring (pas de feature en cours), prérequis (branche `refacto/[module]`, commit checkpoint, tests passants), diagnostic (scope en une phrase, signaux identifiés), exécution atomique (un changement à la fois, commit + tests après chaque étape).

## 3 déclencheurs
1. Avant une feature sur un module dégradé
2. Fin de phase (stabilisation avant release)
3. On-demand (signal concret identifié)

**Verrous anti-dérive :** scope en une phrase, étapes atomiques, arrêt si test échoue.

**Doctrine :** [[doctrines/refacto]]
