---
type: skill
source: ../.claude/commands/tests.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-7, tests, vitest, playwright, tdd]
phase: 7
---

## Rôle
**`/tests`** — Génère et fait tourner les tests d'une feature (unitaires + intégration Vitest + E2E Playwright).

## Inputs
- `[projet].spec.[feature].md` (source des contrats à tester)
- Code de la feature

## En résumé
Mode TDD : génère les tests AVANT le code (Red), depuis les règles de gestion de la spec. Mode Standard : génère les tests après le code. Inclut les tests négatifs explicites et la batterie de non-régression Playwright. Demande systématiquement à l'IA d'auto-évaluer les tests générés (sont-ils de vrais cas d'usage ?).

## Règles anti-auto-validation appliquées
- Génération tests et code en prompts séparés
- Tests lancés avant le code (si TDD)
- Tests négatifs demandés explicitement

**Précédent :** [[skills/code-review-hostil]] | **Suivant :** [[skills/securite]]
**Doctrine :** [[doctrines/tests]]
