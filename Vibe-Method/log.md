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

## [2026-07-27] update | .claude/commands/brief.md → skills/brief.md

Source `/brief` modifiée (3 observations task-observer issues de la session RAMrezo, validées par Medwin) :
- Étape 0.1 — protection d'un `[projet].brief.md` existant : proposer le renommage en `.context.md` avant d'écraser
- Étape 0.2 + section « Sauvegarde d'état » — écriture incrémentale dans `[projet].brief-wip.md` après chaque domaine validé, reprise possible d'une session interrompue
- Domaine 6 — nouvelle question sur les traitements automatiques (cron, rappels, expirations), remontée comme critère de choix pour `/stack`. Ajoutée au format du brief et à la quality gate (16 → 17 cases).

Page wiki `skills/brief.md` resynchronisée (frontmatter `source_modified` et `wiki_updated` au 2026-07-27).

## [2026-07-28] update | methode.md, stack.md, observabilite.md (nouveau), .claude/commands/specs.md, .claude/commands/deploy.md, .claude/commands/maj.md → doctrines/methode.md, doctrines/stack.md, doctrines/observabilite.md (ingest), skills/specs.md, skills/deploy.md, skills/maj.md, index.md

Comparaison `addyosmani/agent-skills` vs vibe-method (session Medwin) — 3 gaps intégrés :
- `doctrines/methode.md` : 10e geste « Le juge impartial » (doubt-driven-development, process CLAIM/EXTRACT/DOUBT/RECONCILE/STOP), note sur le hook `PreToolUse` non confirmé fonctionnel au moment de l'écriture
- `doctrines/stack.md` : section « Vérification documentaire par feature (source-driven) », 8e point d'investigation (observabilité)
- `doctrines/observabilite.md` (nouvelle page, ingest) : doctrine d'instrumentation, chaînage `/specs` → Code → `/deploy`
- `skills/specs.md`, `skills/deploy.md` : Étape 4c-ter / Pre-Launch Gate observabilité
- `skills/maj.md` : resynchronisé après dérive détectée (page décrivait 6 étapes, la source en a 7 depuis l'ajout de la review task-observer — jamais répercuté avant aujourd'hui)
- `index.md` : ligne `doctrines/observabilite` ajoutée, `doctrines/methode` mise à jour (9 → 10 gestes)

Rappel de la règle de mise à jour automatique (`CLAUDE.md` du vault) : appliqué en rattrapage lors du `/maj` de clôture, pas en temps réel pendant la session — écart corrigé (voir entrée suivante, la règle a été réécrite pour refléter ça honnêtement).

## [2026-07-28] update | Vibe-Method/CLAUDE.md, methode.md → Vibe-Method/CLAUDE.md, doctrines/methode.md

Deux corrections suite à task-observer :
- **Obs. 8** : `Vibe-Method/CLAUDE.md` section "Règle de mise à jour" réécrite — ne prétend plus un déclenchement "automatique en temps réel" (qui dépendait en pratique de la mémoire de l'agent, jamais appliqué ainsi). Rattachée explicitement à `/maj` Étape 5, décision de Medwin.
- **Obs. 9** : hook `PreToolUse` doubt-driven confirmé non fonctionnel après 4 tests (2 sessions). Retiré de `settings.json`, script archivé. `doctrines/methode.md` mis à jour : mécanisme retenu = bloc CLAIM écrit par l'agent dans sa réponse chat avant tout commit non trivial.

## [2026-07-28] ingest | .claude/agents/{code-reviewer,security-auditor,test-engineer,web-performance-auditor}.md → agents/*.md (nouvelles pages), CLAUDE.md, index.md

**Obs. 11** : nouveau type `agent` créé dans le schéma du wiki (`CLAUDE.md` — type enum, dossier `agents/`, table `## Sources`). 4 pages créées, une par persona déclinée des 4 agents Osmani, chacune documentant la différence avec le skill vibe-method existant le plus proche (`/code-review`, `/securite`, `/tests` — pas d'équivalent pour `web-performance-auditor`, seul vrai gap). `index.md` : nouvelle table "Agents — personas à contexte isolé". Note fusion future ajoutée dans `CLAUDE.md` : `agent` → `procédure` + tag `agent` au moment de fusionner avec le second cerveau (décision Medwin, capturée aussi en mémoire `project_fusion_wiki_vibemethod`).
