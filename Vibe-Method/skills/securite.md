---
type: skill
source: ../.claude/commands/securite.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-7, sécurité, audit, transversal]
phase: 7 + transversal
---

## Rôle
**`/securite`** — Deux modes : analyse sécurité du PRD (avant /archi) / vérification sécurité d'une feature (après code).

## Inputs
- Mode analyse : `[projet].prd.md`
- Mode check : code de la feature

## En résumé
Mode analyse (une fois par projet, avant `/archi`) : identifie les enjeux de sécurité du PRD, propose les mesures préventives, calibre le niveau de risque.
Mode check (après chaque feature) : checklist de la §3.1 de `securite.md`, lance Semgrep + Snyk si configuré. Bloquant si point en échec.

## Checklist mode check
- Auth côté serveur vérifiée ?
- RLS activé + policies distinctes ?
- Clés privées absentes du front ?
- `.env` dans `.gitignore` ?
- Entrées validées côté serveur ?
- Packages nouveaux vérifiés ?

**Précédent :** [[skills/tests]] | **Suivant :** [[skills/doc-tech]]
**Doctrine :** [[doctrines/securite]]
