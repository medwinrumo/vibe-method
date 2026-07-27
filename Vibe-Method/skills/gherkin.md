---
type: skill
source: ../../.claude/commands/gherkin.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-1, phase-5, tests, gherkin, specs]
phase: 1 + 5
---

## Rôle
**`/gherkin`** — Deux modes : révéler les zones floues du PRD (Mode PRD) ou générer les scénarios complets depuis les specs (Mode Specs).

## Inputs
- Mode PRD : `[projet].prd.md`
- Mode Specs : `[projet].spec.[feature].md`

## Output
- Mode PRD : zones floues et questions identifiées (pas de fichier)
- Mode Specs : `[projet].gherkin.[feature].md`

## Mode PRD — révélateur d'ambiguïtés
Utilisé après `/prd-validate` pour identifier les features mal définies, les comportements non spécifiés, les contradictions. Force à préciser le PRD avant l'architecture.

## Mode Specs — définition de "done"
Utilisé après `/specs` pour produire les scénarios Gherkin complets (happy path + cas limites + cas d'échec). Ces scénarios deviennent la base des tests Playwright.

```
Étant donné [contexte]
Lorsque [action]
Alors [résultat]
```

**Précédent :** [[skills/prd-validate]] (Mode PRD) ou [[skills/specs]] (Mode Specs)
**Suivant :** [[skills/charte]] (Mode PRD) ou [[skills/readyTo-code]] (Mode Specs)
**Doctrine :** [[doctrines/tests]] | [[doctrines/produit]]
