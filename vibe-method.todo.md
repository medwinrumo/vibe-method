# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-05-08

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

- 4 — `templates/` dans vibe-method — à créer lors du lancement de RAMrezo ou Minou. **Priorité moyenne.**
- 8 — Tester Lovable comme outil de génération UI — à évaluer comme alternative/complément à Stitch + Figma. Décision d'intégration dans la stack design après test.
- 17 — Backups de projets — stratégie, outils, automatisation, documentation. Ressource : #8 vibe method - backup (local). **Priorité moyenne.**
- ✅ 15 — Agents IA — doctrine complète. Ajoutée dans `methode.md` + étape 4b dans skill `/specs` (2026-05-08)
- ✅ 16 — BMAD vs vibe-method — étude comparative complète. Intégrations : /prd (NFR, User Journeys, Advanced Elicitation, Quality Gate), /specs (auto-contenues, fichier par feature, DoD), /brief (brainstorming anti-biais, Quality Gate), /archi (cohérence PRD, Advanced Elicitation, Quality Gate), /roadmap (Quality Gate), /design (Mode 0 Design Thinking), methode.md (DoD, Greenfield/Brownfield, /code-review), nouveaux skills /party et /code-review (2026-05-08)
- 9 — Audit et enrichissement des skills existants — les skills peuvent contenir : exemples de code, URLs de doc, scripts de validation, chemins de fichiers précis, versions de librairies. **Priorité haute — à ne pas lancer avant que toute la doctrine soit verrouillée.**
- 10 — Skill `/prp` — agrège tous les outputs existants (PRD + archi + CLAUDE.md + roadmap + specs) en un document unique, précis, optimisé pour le LLM comme contexte de démarrage. **Priorité haute — à ne pas lancer avant tâche 9.**
- ✅ 11 — Finir l'étude Radio Vibe Code #6 — intégrer les enseignements dans la vibe-method (2026-05-08) :
  - ✅ 1. Stack — Supabase vs Xano évalués au cas par cas lors du `/archi`. Pas de décision figée.
  - ✅ 2. Règle back-end — Documentée dans `architecture.md` + intégrée dans skill `/archi`. Trois garde-fous : schéma validé + sécurité + recette.
  - ✅ 3. Modélisation — Approche : discuter ensemble → définir dans `/archi` → générer Mermaid visuel si besoin.
  - ✅ 4. Lovable — Remplacé par Code Design (nouveau, à intégrer dans la méthode).
  - ✅ 5. Méthodo — Analyse faite. Trous → tâches 12-14 réalisées, tâche 15 en cours.

### Réalisées

- ✅ 15 — Agents IA — doctrine complète (`methode.md` + étape 4b `/specs`) (2026-05-08)

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
