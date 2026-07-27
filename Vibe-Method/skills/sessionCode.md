---
type: skill
source: ../../.claude/commands/sessionCode.md
source_modified: 2026-05-13
wiki_updated: 2026-05-26
tags: [phase-6, code, session, sas, prp]
phase: 6
---

## Rôle
**`/sessionCode`** — Sas d'entrée obligatoire avant la première ligne de code : charge le PRP, confirme la feature, rappelle les règles critiques.

## Inputs
- `[projet].prp.md`
- `[projet].spec.[feature].md`
- `[projet].avancement.yaml`
- `[projet].Rmap.md`
- `[projet].archi.md`
- `[projet].refacto-dette.md` (si existant)

## En résumé
7 étapes de vérification avant de coder : fraîcheur du PRP (feature courante vs demandée), spec existante, sprint status, dette de refactoring sur le module ciblé, dépendances roadmap, mode de développement (TDD ou Standard), rappel des 5 gestes.

## 7 étapes
1. Chargement PRP + vérification fraîcheur
2. Sélection feature + vérification spec + sprint status
3. Dette de refactoring sur le module ciblé
4. État dans la roadmap + dépendances
5. Santé du module (6 critères) + mode TDD/Standard
6. Rappel règles critiques (silo, sécurité, stack)
7. Confirmation de démarrage + rappel chaîne post-coding + 5 gestes

## Chaîne post-coding rappelée
`/code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil → /tests → /securite → /doc-tech (Mode B) → /recette`

**Précédent :** [[skills/prp]] | **Suivant :** [code] → [[skills/code-review]]
**Doctrine :** [[doctrines/methode]]
