---
type: infrastructure
source: ../CLAUDE.md
wiki_updated: 2026-05-26
tags: [journal, log]
---

# log.md — Journal du wiki vibe-method

Journal chronologique append-only des opérations wiki.
Format : `## [YYYY-MM-DD] opération | détail`

---

## [2026-07-27] lint | Étape 5 /maj — 4 problèmes corrigés

- **Pages stales** : `doctrines/stack.md`, `doctrines/securite.md`, `doctrines/methode.md`, `skills/stack.md` mises à jour suite aux modifs de session (dépendances, coûts cachés, limite CB, effort par tier, Chrome DevTools MCP) — `source_modified`/`wiki_updated` remis à 2026-07-27
- **Chemins `source:` cassés** : bug structurel présent depuis l'init (2026-05-26) sur les 68 pages doctrines+skills — chaque chemin avait un `../` manquant. Corrigé en masse (`../x.md` → `../../x.md` pour doctrines, `../.claude` → `../../.claude` pour skills)
- **Liens orphelins** : `skills/lint.md` — `[[archi]]`, `[[maj]]`, `[[phase-retrospective]]` non qualifiés corrigés en `[[skills/archi]]`, `[[skills/maj]]`, `[[skills/phase-retrospective]]`
- **Page manquante** : `skills/wiki.md` créée (skill `/wiki` existait en source sans page wiki) + entrée ajoutée dans `index.md`

## [2026-05-26] ingest | Nouveau skill `/lint` → `skills/lint.md`

Skill créé : contrôle qualité du Wiki (modes quick et complet).
Artefacts mis à jour : `index.md` (entrée ajoutée), `CLAUDE.md` vibe-method (tableau + liste transversaux).

---

## [2026-06-11] update + ingest | Intégration AIDD — 4 nouveaux skills

**Sources modifiées :**
- `.claude/commands/angles-morts.md`, `commit.md`, `pr.md`, `condense.md` (créés)
- `.claude/commands/archi.md`, `prd-validate.md`, `recette.md`, `specs.md`, `maj.md` (Fin/chaîne mis à jour)
- `CLAUDE.md` (chaîne, table skills, transversaux)

**Pages créées :**
- `skills/angles-morts.md`, `skills/commit.md`, `skills/pr.md`, `skills/condense.md`

**Pages mises à jour (stales) :**
- `skills/archi.md` — Suivant : ajout /angles-morts
- `skills/prd-validate.md` — Suivant : ajout /angles-morts
- `skills/recette.md` — Suivant : ajout /commit → /pr
- `skills/specs.md` — Suivant : ajout /angles-morts
- `skills/maj.md` — mention T1 Haiku

**Index mis à jour :**
- Phase 1 : /angles-morts ajouté
- Phase 7 : /commit + /pr ajoutés
- Transversaux : /condense ajouté

---

## [2026-05-26] init | Création complète du wiki vibe-method

Première ingestion du repo `~/dev/vibe-method/`.

**Sources lues :**
- Doctrines : `methode.md`, `architecture.md`, `securite.md`, `tests.md`, `design.md`, `stack.md`, `refacto.md`, `produit.md`
- Skills lus en détail : `brief.md`, `sessionCode.md`, `prp.md`
- Références : `CLAUDE.md`, `vibe-method.todo.md`

**Pages créées :**
- Infrastructure : `CLAUDE.md`, `index.md`, `log.md`
- Synthèse : `_vue-ensemble.md`, `flux/chaine-complete.md`
- Doctrines (8) : `doctrines/methode.md`, `doctrines/architecture.md`, `doctrines/securite.md`, `doctrines/tests.md`, `doctrines/design.md`, `doctrines/stack.md`, `doctrines/refacto.md`, `doctrines/produit.md`
- Skills (55) : toute la chaîne + transversaux + session management
