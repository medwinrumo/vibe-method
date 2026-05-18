# vibe-method.log — Journal de bord

---

## Jour 1 — 2026-05-18

### Session 1 — Enrichissement méthode + refactoring Notion

- Intégré concept "Quality Gate" dans `/prd` (section décisions techniques initiales)
- Ajouté filtre 3 conditions dans `/adr`
- Ajouté support `[projet].gloss.md` dans `/prp`
- Créé `/grill-me` — interrogatoire approfondi, une question à la fois
- Créé `/caveman` — mode communication compressé (jamais en session code)
- Créé `/handoff` — ancre de contexte mid-session avant compaction
- Refactorisé 8 skills : Notion → fichiers `.md` locaux (`/peda`, `/log`, `/doc`, `/spec`, `/checkpoint`, `/majtodo`, `/maj`, `/init-projet`)
- Nettoyé `CLAUDE.global.md` : section Notion supprimée, table artefacts locaux ajoutée
- Résolu collision de nom : `/spec` produit `[projet].spec-global.md`
- Corrigé titre `/caveman` (anciennement `/kavman`)
- Commité et pushé : `a044fdb`

### Session 2 — Intégration skills externes (suite)

- Créé `/diagnose` — escalade de `/debug` pour bugs difficiles (boucle feedback + hypothèses falsifiables)
- Enrichi `/refacto` — vocabulaire Seam/Profondeur/Deletion test + mode exploration
- Enrichi `/tests` — anti-pattern tranches horizontales + signal mauvais test
- Enrichi `/roadmap` — principe vertical slices + critère Quality Gate
- Créé `/to-issues` — specs → issues GitHub qualifiées HITL/AFK
- Recadrage : approche prospective confirmée, distinction HITL/AFK formalisée
- Commits : `96ff58e`, `24370a8`, `b5761bb`, `fedec66`
