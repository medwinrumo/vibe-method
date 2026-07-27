---
type: skill
source: ../../.claude/commands/readyTo-code.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [gate, démarrage, prp, archi, specs]
phase: gate
---

## Rôle
**`/readyTo-code`** — Gate de readiness avant le premier `/sessionCode` : vérifie que tous les artefacts sont présents et cohérents.

## Inputs
- `[projet].prd.md`
- `[projet].archi.md` + `CLAUDE.md`
- `[projet].spec.[feature].md`
- `[projet].prp.md`
- `[projet].avancement.yaml`

## Output
Rapport GO / BLOCKERS (pas de fichier)

## En résumé
Vérifie la présence et la complétude de tous les artefacts nécessaires au démarrage du code. Si un artefact est absent ou incomplet → BLOCKER signalé avec le skill à lancer pour combler le manque.

**Précédent :** [[skills/to-issues]] / [[skills/specs]] | **Suivant :** [[skills/setup]]
