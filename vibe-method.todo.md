# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-03-29

### Ce qui a été fait
- `securite.md` enrichi : section 2bis "Gestion des ressources" ajoutée (connexions simultanées, limite mémoire, DB scaling, cache, frugalité, goulot d'étranglement)
- `architecture.md` enrichi : règle "Niveau d'abstraction maximal" ajoutée
- `methode.md` enrichi : Phase 4 couvre maintenant stack applicative ET stack de dev (outil + modèle)
- `stack.md` (skill) : Étape 0bis ajoutée — évaluation du couple outil + modèle selon complexité projet
- `majpeda.md` (skill) : réécrit pour mettre à jour DEUX pages par session — `.peda` (journal) et `.voca` (glossaire)
- `CLAUDE.global.md` : ligne `.voca` ajoutée dans le tableau des pages standard par projet
- Skill `/securite` créé — deux modes : `analyse` (post-PRD, avant /archi) et `check` (automatique avant merge, bloquant)
- `methode.md` Phase 7 mis à jour : `/securite check` intégré à l'étape 6 du flow de vérification

---

## Tâches

### À faire

- 2 — Skill `/init` — création projet complet (Git + Notion) en une commande. Périmètre Git validé, structure sous-pages Notion à valider avec Medwin. **Priorité haute.**
- 3 — Skill `/design` — exporter liste features structurée (feature + composant UI + comportement) depuis le PRD, pour alimenter Stitch. Doctrine : `design.md`. **Priorité moyenne.**
- 4 — `templates/` dans vibe-method — à créer lors du lancement de Minou (Convex d'abord, Supabase ensuite). **Priorité moyenne.**
- 5 — Migration outputs skills vers `.md` dans repo projet — `/brief`, `/prd`, `/archi`, `/roadmap` écrivent encore dans Notion en primaire. **Priorité haute.**
- 6 — Corriger `/maj` — supprimer références à `[projet].run.md` et `/majrun` (inexistants). **Priorité basse.**
- 7 — ExplorePéda#7 niveau 3 — agent manager (3.1), OpenClaw + mémoire partagée (3.2) — pour plus tard.
- 8 — Tester Lovable comme outil de génération UI — à évaluer comme alternative/complément à Stitch + Figma. Décision d'intégration dans la stack design après test.
- 9 — Audit et enrichissement des skills existants — les skills peuvent contenir : exemples de code, URLs de doc, scripts de validation, chemins de fichiers précis, versions de librairies. **Priorité haute — à ne pas lancer avant que toute la doctrine soit verrouillée.**
- 10 — Skill `/prp` — agrège tous les outputs existants (PRD + archi + CLAUDE.md + roadmap + specs) en un document unique, précis, optimisé pour le LLM comme contexte de démarrage. **Priorité haute — à ne pas lancer avant tâche 9.**

### Réalisées

- ✅ Skill `/brief` — complet
- ✅ Skill `/prd` — complet
- ✅ Skill `/prd-update` — complet
- ✅ Skill `/archi` — complet + étape 6b garde-fous free tier
- ✅ Skill `/roadmap` — complet
- ✅ Skill `/specs` — user story A4
- ✅ Skill `/tests` — unit + integration + Playwright
- ✅ Skill `/recette` — Gherkin + validation manuelle
- ✅ Skill `/debug` — diagnostic 3 tentatives + web search
- ✅ Skill `/stack` — spike technique + investigation + Étape 0bis stack de dev
- ✅ Skills session — `/maj` `/todo` `/majlog` `/majpeda` `/majdoc` `/majspec` `/majtodo` `/checkpoint`
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
| Skill `/init` | ❌ Non implémenté |
| Skill `/design` | ❌ Non implémenté |
| Migration outputs → fichiers `.md` | ❌ Non fait |
| `templates/` dans vibe-method | ❌ Non créé |

---

## Prochain projet

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
