# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-04-22

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
- 12 — Stack front recommandée — documenter React + Vite + TypeScript comme combo de référence dans `methode.md` et/ou `architecture.md`, sans rigidité (autres outils possibles si justifiés). *Source : Radio Vibe Code #6.*
- 13 — Mise en prod — comprendre et documenter les enjeux : hébergement, variables d'environnement, migrations BDD, domaine, monitoring. Décider si un skill `/deploy` est pertinent dans la chaîne. **Nécessite une session de discussion avant toute écriture.**
- 14 — MCP — comprendre et établir une doctrine : qu'est-ce qu'un MCP, quand en utiliser dans nos projets, lesquels, comment éviter de surcharger le contexte. **Nécessite une session de discussion avant toute écriture.**
- 15 — Agents IA — comprendre et établir une doctrine : qu'est-ce qu'un agent, ce que ça implique, dans quel type de projet, comment ça se construit, comment l'intégrer dans la vibe-method. **Nécessite une session de discussion avant toute écriture.**
- 16 — BMAD vs vibe-method — étude comparative. BMAD (Breakthrough Method for Agile AI-Driven Development) est un framework open source qui orchestre des agents IA spécialisés (PM, archi, dev, QA) comme une feature team. Approche spec-driven + "Agent as Code" (agents définis en Markdown). Questions à traiter : (1) est-ce qu'on réinvente la roue ou on fait mieux/différemment ? (2) quelle est la vraie différence entre un skill et un agent ? (3) qu'est-ce qu'il vaut la peine de récupérer de BMAD ? **Inclure dans la session de la tâche 15 ou session dédiée.**
- 9 — Audit et enrichissement des skills existants — les skills peuvent contenir : exemples de code, URLs de doc, scripts de validation, chemins de fichiers précis, versions de librairies. **Priorité haute — à ne pas lancer avant que toute la doctrine soit verrouillée.**
- 10 — Skill `/prp` — agrège tous les outputs existants (PRD + archi + CLAUDE.md + roadmap + specs) en un document unique, précis, optimisé pour le LLM comme contexte de démarrage. **Priorité haute — à ne pas lancer avant tâche 9.**
- 11 — Finir l'étude Radio Vibe Code #6 — intégrer les enseignements dans la vibe-method :
  - ✅ 1. Stack — Supabase remis en cause. Xano s'impose comme back-end recommandé. À intégrer dans `architecture.md` et la stack B.
  - ✅ 2. Règle back-end — La vibe-method permet à l'IA de piloter le back-end précisément parce qu'elle pose les garde-fous absents ailleurs : /archi (schéma validé par Medwin) + /securite + /recette. Position actée et différenciante.
  - ✅ 3. Modélisation — Schéma BDD dans Notion (BDD Modélisation > Schéma Mermaid > tables indépendantes) avant tout code. Règle actée. À intégrer dans `architecture.md` et skill `/archi`.
  - ✅ 4. Lovable — Déjà documenté en tâche 8 (tests à faire). Clos ici.
  - ✅ 5. Méthodo — Analyse faite. Trous identifiés → tâches 12, 13, 14, 15 ci-dessous.

### Réalisées

- ✅ 2 — Skill `/init` — complet (Git + Notion, workflow projet documenté) (2026-04-22)
- ✅ 6 — Corriger `/maj` — déjà propre, clos (2026-04-22)
- ✅ 12 — Stack front React + Vite + TS documentée dans `architecture.md` (2026-04-22)
- ✅ 13 — Mise en prod — doctrine `architecture.md` + skill `/deploy` (2026-04-22)
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
