---
type: skill
source: ../.claude/commands/prp.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [gate, prp, contexte, session]
phase: gate
---

## Rôle
**`/prp`** — Agrège tous les outputs en un document condensé ≤ 1 000 tokens, optimisé pour le démarrage de session de code.

## Inputs
- `[projet].brief.md`, `[projet].prd.md`, `[projet].archi.md`
- `CLAUDE.md`, `[projet].stack.md`, `[projet].tests.md`
- `[projet].spec.[feature].md`
- `[projet].gloss.md` (optionnel)

## Output
`[projet].prp.md` (+ `[projet].prp-extended.md` si dépassement)

## En résumé
Extrait uniquement les **décisions et contraintes** de chaque source (jamais les explications). Vérifie la suffisance sur 6 catégories (A-F). Lance un test de simulation : le PRP doit répondre sans ambiguïté aux 4 questions : quoi coder, où, quelles règles ne pas violer, comment vérifier. Rechargé à chaque compaction de contexte.

## Checklist de suffisance (6 catégories)
- A. Objectif immédiat (feature + definition of done)
- B. Pointeurs de code (fichiers, entry points)
- C. Règles critiques (5-15 règles non-évidentes)
- D. Décisions d'archi
- E. Données & invariants
- F. Commandes de dev

**Limite dure : ≤ 1 000 tokens.** Si dépassé et suffisance impossible → core + extended.

**Précédent :** [[skills/setup]] | **Suivant :** [[skills/avancement]] → [[skills/sessionCode]]
