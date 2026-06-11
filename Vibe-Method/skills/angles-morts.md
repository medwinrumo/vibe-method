---
type: skill
source: ../.claude/commands/angles-morts.md
source_modified: 2026-06-11
wiki_updated: 2026-06-11
tags: [transversal, gate, prd, architecture, specs, t3]
phase: transversal
---

## Rôle
**`/angles-morts`** — Chasse aux zones d'ombre sur un document (PRD, archi, spec). **T3 — Opus recommandé.**

## Inputs
- Le document à analyser (PRD, archi, spec)

## Output
Rapport de zones d'ombre classées (pas de fichier produit — les décisions alimentent le document source)

## En résumé
Examine ce qui N'EST PAS écrit : hypothèses implicites, scénarios non couverts, décisions non prises, risques non nommés, dépendances cachées. Livré en 5 catégories, chaque item avec Observation / Question à trancher / Impact si ignoré.

## 3 gates d'invocation
- Après [[skills/prd-validate]] — sur le PRD
- Après [[skills/archi]] — sur l'architecture
- Après [[skills/specs]] — sur la spec de la feature

**Précédent :** [[skills/prd-validate]] / [[skills/archi]] / [[skills/specs]] | **Suivant :** étape suivante selon le gate
