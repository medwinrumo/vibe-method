---
type: skill
source: ../../.claude/commands/avancement.md
source_modified: 2026-06-11
wiki_updated: 2026-08-05
tags: [suivi, tracker, yaml, sprint]
phase: transversal
---

## Rôle
**`/avancement`** — Suivi de l'état des features du projet (YAML centralisé). **T1 — Haiku (optionnel).**

## Inputs
- `[projet].Rmap.md`
- `[projet].spec.[feature].md`

## Output
`[projet].avancement.yaml`

## En résumé
Initialise et maintient un tracker YAML de l'état de chaque feature (todo / in-progress / done / blocked). Lu par `/sessionCode` à chaque session pour afficher le sprint status. Mis à jour automatiquement quand une feature passe de statut.

## Usage dans /sessionCode
À chaque démarrage de session, le statut de la feature courante est affiché. Si `done` → signalement. Sinon → proposition de passer à `in-progress`.

**Utilisé par :** [[skills/sessionCode]] | [[skills/maj]]
