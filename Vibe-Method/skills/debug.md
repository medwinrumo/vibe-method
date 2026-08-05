---
type: skill
source: ../../.claude/commands/debug.md
source_modified: 2026-06-24
wiki_updated: 2026-08-05
tags: [phase-7, debug, bug]
phase: 7
---

## Rôle
**`/debug`** — Diagnostic et résolution de bug. Déclenché automatiquement par `/recette`.

## Inputs
- Rapport de bug (OÙ / QUOI / RÉSULTAT / ATTENDU + message d'erreur)

## En résumé
3 tentatives de résolution avec hypothèses falsifiables. Si non résolu après 2 essais → protocole d'escalade de `methode.md` (L'œil de l'aigle → Le bond du tigre → etc.). Un bug non résolu est bloquant — `/recette` suspendue.

## Format de rapport de bug requis
```
OÙ      → quelle page, quel rôle
QUOI    → quelle action exactement
RÉSULTAT → ce qui s'est passé
ATTENDU  → ce qui aurait dû se passer
+ message d'erreur complet (console)
```

## Wiki
- **Écriture** (si résolution via web search) : propose de noter le bug pattern dans `~/dev/wiki/bugs-patterns.md` — tags `[retours, debug]`

**Déclenché par :** [[skills/recette]] | **Escalade :** [[skills/diagnose]]
**Doctrine :** [[doctrines/methode]]
