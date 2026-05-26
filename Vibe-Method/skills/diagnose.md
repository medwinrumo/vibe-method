---
type: skill
source: ../.claude/commands/diagnose.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [phase-7, debug, diagnostic-approfondi]
phase: 7
---

## Rôle
**`/diagnose`** — Diagnostic approfondi pour bugs difficiles : boucle de feedback + hypothèses falsifiables. Escalade de `/debug`.

## Inputs
- Rapport de bug complet
- Ce qui a déjà été essayé (sans succès dans `/debug`)

## En résumé
Escalade de `/debug` quand les tentatives standards ne débloquent pas. Approche systématique : hypothèses ordonnées par probabilité, tests de falsification, boucle de feedback. Peut impliquer un changement de modèle (Le singe change de branche) ou une recherche web (Le faucon en chasse).

**Déclenché par :** [[skills/debug]] (après échec) | **Doctrine :** [[doctrines/methode]]
