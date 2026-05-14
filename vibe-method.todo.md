# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-05-14 (session 2)

### Ce qui a été fait

- Tâche 4 — Comparaison BMAD vs vibe-method :
  - Rapport `bmad-comparaison.md` produit (11 points BMAD mieux, 14 vibe-method mieux, 11 lacunes identifiées)
  - 3 skills créés : `/sprint-status` (YAML tracking), `/code-review-edge-cases` (chasse cas non gérés), `/change-request` (impact analysis)
  - Intégrations : `/sessionCode` (sprint status + chaîne), `/recette` (sprint done), CLAUDE.md (chaîne + table)
  - 5 rappels créés pour les points restants (tâches 21-25)

- Tâche 6 — Audit et enrichissement skills :
  - `/archi` Étape 1b : WebSearch obligatoire version Expo avant confirmation stack native
  - `/archi` Étape 1b : implications en cascade listées (→ `/stack`, → roadmap délais stores, → règles sécu mobile)
  - `/archi` Étape 4c : WebSearch obligatoire limites free tier Supabase/Convex avant confirmation backend
  - `/archi` Étape 4c : implications en cascade listées (→ `/stack` connexions simultanées, → risque RGPD Convex, → patterns RLS CLAUDE.md)
  - `securite.md` §1.8 : renvoi explicite vers `architecture.md` section "Backup & conformité RGPD"
  - `/prp` : confrontation avec `prp-doctrine-enrichissement.md` — tous les gaps Haute priorité résolus (sécurité via `archi.md`, règles silo via `archi.md`, règles tests dans `/tests`)

---

## Session précédente — 2026-05-14 (session 1)

### Ce qui a été fait

- Sync `/todo` : tâche 9 (test filtrage dates) supprimée du fichier local, conformément au kanban GH.

---

## Session précédente — 2026-05-13 (session 2)

### Ce qui a été fait — Tâche 5 (audit cohérence, suite) + refonte design

**Corrections audit (D3, G3, I1, I2) :**
- D3 — `design.md` entièrement réécrit : workflow Claude Design (Mode A ↔ /archi → Claude Design → Mode B), NativeWind ajouté, Stitch/Figma retirés de la chaîne systématique (Figma optionnel), Principe réécrit (interface d'abord, logique ensuite), ASCII art documenté comme format de maquette collaboratif, frontend-design retiré (redondant avec design system déjà dans le code)
- G3 — `/specs` Étape 1 et template Étape 5 : source sécurité corrigée (`securite.md` → section Sécurité de `[projet].archi.md`)
- I1 — `tests.md` Anti-auto-validation : Règle b ajoutée (vérifier que les tests échouent avant l'implémentation)
- I2 — `methode.md` Phase 1 : "Identifier les enjeux de sécurité" complété avec `→ /securite analyse`

**Évolutions design & architecture :**
- `/design` Mode B : nouvelle Étape 2 "Extraction du routing" — scan éléments interactifs, tableau Simple/Conditionnel/Action/Non défini, validation Medwin requise, écriture dans `[projet].archi.md`
- `/archi` template : section "Navigation & Routing" ajoutée (complétée par Mode B, disponible dans le PRP)
- `/prp` : `[projet].design.md` retiré des inputs (redondant après Mode B — tokens dans `tailwind.config.ts`, composants dans le codebase)
- `design.md` : routing extrait écrit dans `archi.md` (pas dans `design.md` — non disponible en session de code)

---

## Session précédente — 2026-05-13 (session 1)

### Ce qui a été fait
- Tâche 7 — Skill `/doc-tech` créé : Mode A (`[projet].doc-tech.md` — vue d'ensemble développeur, fin de phase) + Mode B (annotations JSDoc/TSDoc dans le code, après `/tests` avant `/recette`). `/doc` mis à jour : sous-page Développeur supprimée, Utilisateur restructurée. Symlink créé.
- Tâche 8 — Doctrine `refacto.md` créée (discipline autonome : définition, critères, règles non-négociables, types, intégration workflow 3 déclencheurs, lien TDD micro/macro). Skill `/refacto` créé : 4 étapes (vérification session, prérequis, diagnostic, exécution atomique avec verrous anti-dérive). Journal de dette `[projet].refacto-dette.md` défini et intégré. `tests.md` enrichi : Refactor TDD détaillé + renvoi vers `refacto.md`. `methode.md` mis à jour. Symlink créé.
- Tâche 10 — `/sessionCode` enrichi : 7 étapes (was 4). Ajouts : fraîcheur PRP (feature courante vs demandée), chargement obligatoire spec, vérification dette refacto sur le module ciblé, état roadmap + dépendances, détection TDD/Standard, rappel chaîne post-coding.

---

## Session précédente — 2026-05-12

### Ce qui a été fait
- Tâche 11 — Sync GitHub Projects : `/todo` refondu (sync GH Projects au démarrage, GH = source de vérité, setup `.gh-project.local`). `/maj` refondu (Étape 3 GH Projects — tâches terminées + nouvelles tâches).
- Tâche 12 — Skill `/adr` créé : capture décision architecturale en 4 questions, append dans `[projet].adr.md`. Symlink créé. `/archi` (Étape 5b) et `/specs` (Étape 4d) proposent automatiquement `/adr` après décision structurante.
- Tâche 13 — Documentation locale : `/recette` (Étape 6) propose mise à jour `[projet].doc-user.md` après validation de phase. Definition of Done enrichie dans `methode.md` et template `/specs` : `doc-user.md` ajouté.
- Tâche 14 — `/maj` restructuré : pont Notion retiré (plus de mise à jour auto `.peda`, `.log`, `.spec`, `.doc`). Garder : Git + sync sécurité + GitHub Projects + cohérence doctrine. MCP Notion supprimé des allowed-tools.

---

## Session précédente — 2026-05-08

### Ce qui a été fait
- Tâche 14 — Doctrine MCP complétée : chapitre "Dépendances externes — MCP" dans `architecture.md`. Investigation large sur MCP (définition, architecture, cas d'usage). Règle de décision (conversationnel vs déterministe vs mixte). Activation (global / par-projet / on-demand). Intégration étape 3b dans skill `/archi`.
- Configuration voice : langue mise en français, mode switch de "hold" à "tap" (appuyer pour démarrer/arrêter la dictation).

---

## Session précédente — 2026-04-22

### Ce qui a été fait
- Tâche 2 — Skill `/init` créé : Git + Notion (page `.run` + 9 sous-pages). Workflow projet documenté (page projet manuelle → `/init` → `.run`). Symlink créé.
- Renommage skills : `/majspec` → `/spec`, `/majpeda` → `/peda`, `/majlog` → `/log`, `/majdoc` → `/doc`. Symlinks recréés.
- `.voca` → `.gloss` partout (peda.md, CLAUDE.global.md, mémoire)
- Tâche 6 — Corriger `/maj` : déjà propre, clos sans modification
- Tâche 12 — Stack front React + Vite + TS documentée dans `architecture.md` (+ PWA et React Native comme alternatives)
- Règle de rigueur professionnelle ajoutée dans `CLAUDE.global.md` : toutes les options, rien sous silence, qualité avant rapidité
- Contrats d'interface ajoutés dans `/archi` (étape 4b) + template document + bloc CLAUDE.md
- Tâche 13 — Mise en prod : doctrine complète ajoutée dans `architecture.md` (6 couches, 3 niveaux, staging à la demande). Skill `/deploy` créé et symlinké.
- RAMrezo identifié comme premier projet réel de la vibe-method (version personnalisée de SynRezo pour le club RAM)

---

## Session précédente — 2026-04-05

### Ce qui a été fait
- Tâche 5 — Migration outputs → `.md` : `/brief`, `/prd`, `/archi`, `/roadmap` écrivent maintenant dans le repo projet au lieu de Notion. 4 symlinks manquants créés (checkpoint, debug, securite, stack)
- Tâche 7 — ExplorePéda#7 niveau 3 : agent manager et OpenClaw + mémoire partagée traités et clôturés (pas d'intégration nécessaire)
- Tâche 3 — Skill `/design` créé : Mode A (spike stack design + interview + liste features pour Stitch/Figma) + Mode B (intégration export CSS → Tailwind + shadcn). Symlink créé. `/prd` mis à jour (question stack design). `CLAUDE.md` mis à jour (chaîne de skills)

---

## Tâches

### À faire

- ~~17~~
- ~~18~~
- ~~19~~
- ~~20~~
- 3 — Tester Code Design comme outil de génération UI — à évaluer comme alternative/complément à Claude Design. Décision d'intégration dans la stack design après test. **Priorité moyenne.**
- ~~4~~
- ~~5~~
- ~~6~~
- 21 — Gate de readiness avant dev — créer `/readiness-check` : vérifier que PRD, archi, specs et sprint-status sont complets avant de coder la première ligne. Output : rapport GO / BLOCKERS / WARNINGS. **Priorité haute.**
- 22 — Validation PRD avant archi — créer `/prd-validate` : skill standalone qui relit un PRD et valide cohérence interne, traçabilité (feature → critère de succès) et complétude. Déclenché automatiquement après `/prd`. **Priorité haute.**
- 23 — Retrospective post-phase — créer `/phase-retrospective` : analyse après completion d'un ensemble de fonctions (lessons learned, dette, prep phase suivante, action items). **Priorité haute.**
- 24 — Project context dédié LLM — créer `/project-context` : dialogue pour documenter les règles unobvious spécifiques au projet. Output : `[projet].project-context.md`. Déclenché après `/archi`. **Priorité haute.**
- 25 — Adversarial review — créer `/code-review-adversarial` : revue cynique qui assume que le code est mauvais et trouve au minimum 10 problèmes. Complémentaire à `/code-review-edge-cases`. **Priorité moyenne.**
- ~~7~~
- ~~8~~
- ~~10~~
- ~~templates/ dans vibe-method~~ — Décidé de ne pas faire. Chaque skill produit son fichier avec la bonne structure quand il s'exécute.

### Réalisées

- ✅ 4 — Comparaison BMAD vs vibe-method : rapport `bmad-comparaison.md` + 3 skills créés (`/sprint-status`, `/code-review-edge-cases`, `/change-request`) + 5 rappels (tâches 21-25). (2026-05-14)
- ✅ 6 — `/archi` : WebSearch versions (Expo, free tier) + implications en cascade. `securite.md` §1.8 renvoi. `/prp` confrontation : gaps résolus. (2026-05-14)

- ✅ 20 — Intégration traité : tests + POURQUOI — 2 points décidés non intégrables. (2026-05-14)
- ✅ 19 — Intégration traité : posture & philosophie — 5 points décidés non intégrables (redondant/non actionnable). (2026-05-14)
- ✅ 17 — Intégration traité : phase AVANT — cadre 3 phases, 3 règles état d'esprit, template PRD, relire PRD, YOLO first. (2026-05-14)
- ✅ 18 — Intégration traité : architecture — 4 familles + 3 questions dans `architecture.md` + `/archi` Étape 1. (2026-05-14)

- ✅ 7 — Skill `/doc-tech` — Mode A (`[projet].doc-tech.md`) + Mode B (JSDoc/TSDoc). `/doc` restructuré. (2026-05-13)
- ✅ 8 — Doctrine `refacto.md` + skill `/refacto` + journal de dette + enrichissement `tests.md` TDD Refactor. (2026-05-13)
- ✅ 10 — `/sessionCode` enrichi — 7 étapes, dette refacto, roadmap, dépendances, TDD/Standard, fraîcheur PRP. (2026-05-13)

- ✅ 11 — Sync GitHub Projects : `/todo` + `/maj` refondus, setup `.gh-project.local` documenté (2026-05-12)
- ✅ 12 — Skill `/adr` créé : 4 questions, append `[projet].adr.md`, proposé par `/archi` Étape 5b + `/specs` Étape 4d (2026-05-12)
- ✅ 13 — Documentation locale : `doc-user.md` dans Definition of Done + `/recette` Étape 6 propose la mise à jour (2026-05-12)
- ✅ 14 — `/maj` restructuré : pont Notion retiré (plus d'auto `.peda`/`.log`/`.spec`/`.doc`), GH Projects + Git + sécurité uniquement (2026-05-12)

- ✅ 5 — Audit de cohérence interne vibe-method — 10 problèmes traités (D1/C1/C2/D2/G1/G2/D3/G3/I1/I2) + hooks RGPD `/brief` et `/specs`. Points restants reportés en tâche 6. (2026-05-13)
- ✅ 9 — Cybersécurité — `securite.md` refondu : OWASP Top 10 + Mobile Top 10, auth côté serveur, moindre privilège, double audit LLM via `/party`, outils scan CI/CD. Commit 6d0c805 (2026-05-12)
- ✅ 1 — Recherche Claude Design + apple-hig-react-native — `claude-design.md` + `apple-hig-react-native.md` créés (2026-05-11)
- ✅ 2 — Recherche Apple HIG pour React Native + Expo + NativeWind — documentation complète + décision RAMrezo → natif (2026-05-11)

- ✅ 11 — Finir l'étude Radio Vibe Code #6 — intégrer les enseignements dans la vibe-method (2026-05-08)
- ✅ 15 — Agents IA — doctrine complète (`methode.md` + étape 4b `/specs`) (2026-05-08)
- ✅ 16 — BMAD vs vibe-method — étude comparative complète. Intégrations : /prd, /specs, /brief, /archi, /roadmap, /design, methode.md, nouveaux skills /party et /code-review (2026-05-08)

- ✅ 2 — Skill `/init` — complet (Git + Notion, workflow projet documenté) (2026-04-22)
- ✅ 6 — Corriger `/maj` — déjà propre, clos (2026-04-22)
- ✅ 12 — Stack front React + Vite + TS documentée dans `architecture.md` (2026-04-22)
- ✅ 13 — Mise en prod — doctrine `architecture.md` + skill `/deploy` (2026-04-22)
- ✅ 14 — Doctrine MCP — complète. Chapitre "Dépendances externes — MCP" dans `architecture.md` + étape 3b dans skill `/archi` (2026-05-08)
- ✅ Skill `/brief` — complet
- ✅ Skill `/prd` — complet + question stack design ajoutée (2026-04-05)
- ✅ Skill `/prd-update` — complet
- ✅ Skill `/archi` — complet + étape 6b garde-fous free tier
- ✅ Skill `/roadmap` — complet
- ✅ Skill `/specs` — user story A4
- ✅ Skill `/tests` — unit + integration + Playwright
- ✅ Skill `/recette` — Gherkin + validation manuelle
- ✅ Skill `/debug` — diagnostic 3 tentatives + web search
- ✅ Skill `/stack` — spike technique + investigation + Étape 0bis stack de dev
- ✅ Skills session — `/maj` `/todo` `/log` `/peda` `/doc` `/spec` `/majtodo` `/checkpoint` (renommés 2026-04-22)
- ✅ Skill `/deploy` — complet (2026-04-22)
- ✅ Infrastructure Git — symlinks, setup.sh, CLAUDE.global.md versionné
- ✅ `architecture.md` — réécrit complet (2026-03-27) + règle abstraction maximale (2026-03-29)
- ✅ `methode.md` — mise à jour complète (2026-03-27) + Phase 4 stack de dev + Phase 7 /securite (2026-03-29)
- ✅ `design.md` — créé (2026-03-27)
- ✅ `securite.md` — section 2bis gestion ressources ajoutée (2026-03-29)
- ✅ `stack.md` (skill) — Étape 0bis ajoutée (2026-03-29)
- ✅ `majpeda.md` (skill) — mise à jour vers double page .peda + .voca (2026-03-29)
- ✅ ExplorePéda#7 niveau 1 — 1.1, 1.2, 1.3, 1.4 intégrés
- ✅ ExplorePéda#7 niveau 2 — 2.1, 2.2, 2.3 traités
- ✅ 1 — Skill `/securite` — complet (deux modes : analyse + check, intégré Phase 7) (2026-03-29)
- ✅ 3 — Skill `/design` — complet (Mode A + Mode B, symlink, /prd mis à jour) (2026-04-05)
- ✅ 5 — Migration outputs skills → `.md` dans repo projet + 4 symlinks manquants (2026-04-05)
- ✅ 7 — ExplorePéda#7 niveau 3 — agent manager + OpenClaw + mémoire partagée (2026-04-05)

---

## État général du projet

| Élément | État |
|---|---|
| Chaîne de skills complète | ✅ Fonctionnel |
| Skills session (`/maj`, `/todo`, etc.) | ✅ Fonctionnel |
| Infrastructure Git (symlinks, setup.sh) | ✅ Fonctionnel |
| `produit.md` | ✅ Stable |
| `methode.md` | ✅ Mis à jour 2026-03-29 |
| `design.md` | ✅ Créé 2026-03-27 |
| `architecture.md` | ✅ Mis à jour 2026-03-29 |
| `securite.md` | ✅ Mis à jour 2026-03-29 |
| `tests.md` | ✅ Stable |
| `stack.md` | ✅ Stable |
| Skill `/securite` | ✅ Complet (2026-03-29) |
| Skill `/design` | ✅ Complet (2026-04-05) |
| Migration outputs → fichiers `.md` | ✅ Fait (2026-04-05) |
| Skill `/init` | ✅ Complet (2026-04-22) |
| Skill `/deploy` | ✅ Complet (2026-04-22) |
| `templates/` dans vibe-method | ❌ Non créé (attend RAMrezo ou Minou) |

---

## Prochain projet

**RAMrezo** — version personnalisée de SynRezo pour le club RAM. Premier projet réel de la vibe-method. Stack et timeline à définir lors d'une session dédiée. Démarrer depuis `/brief`.

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
