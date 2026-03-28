# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-03-27

### Ce qui a été fait
- `architecture.md` réécrit complet (principe fondateur contexte, silos, modules, CLAUDE.md par projet)
- `methode.md` mis à jour : Phase 2 Design ajoutée, phases renumérotées 1→7, Phase 7 Vérification complète, GitHub Actions ajouté en Phase 6
- `design.md` créé : doctrine workflow Stitch → Figma → export CSS → Tailwind/shadcn
- ExplorePéda#7 niveaux 1 et 2 entièrement traités et intégrés dans vibe-method

---

## Tâches

### À faire

- 1 — Skill `/securite` — vérifier/compléter `securite.md` (doctrine), puis créer le skill. Absent de la chaîne alors que référencé dans `methode.md`. **Priorité haute.**
- 2 — Skill `/init` — création projet complet (Git + Notion) en une commande. Périmètre Git validé, structure sous-pages Notion à valider avec Medwin. **Priorité haute.**
- 3 — Skill `/design` — exporter liste features structurée (feature + composant UI + comportement) depuis le PRD, pour alimenter Stitch. Doctrine : `design.md`. **Priorité moyenne.**
- 4 — `templates/` dans vibe-method — à créer lors du lancement de Minou (Convex d'abord, Supabase ensuite). **Priorité moyenne.**
- 5 — Migration outputs skills vers `.md` dans repo projet — `/brief`, `/prd`, `/archi`, `/roadmap` écrivent encore dans Notion en primaire. **Priorité haute.**
- 6 — Corriger `/maj` — supprimer références à `[projet].run.md` et `/majrun` (inexistants). **Priorité basse.**
- 7 — ExplorePéda#7 niveau 3 — agent manager (3.1), OpenClaw + mémoire partagée (3.2) — pour plus tard.
- 8 — Tester Lovable comme outil de génération UI — à évaluer comme alternative/complément à Stitch + Figma. Décision d'intégration dans la stack design après test.

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
- ✅ Skill `/stack` — spike technique + investigation
- ✅ Skills session — `/maj` `/todo` `/majlog` `/majpeda` `/majdoc` `/majspec` `/majtodo` `/checkpoint`
- ✅ Infrastructure Git — symlinks, setup.sh, CLAUDE.global.md versionné
- ✅ `architecture.md` — réécrit complet (2026-03-27)
- ✅ `methode.md` — mise à jour complète (2026-03-27)
- ✅ `design.md` — créé (2026-03-27)
- ✅ ExplorePéda#7 niveau 1 — 1.1, 1.2, 1.3, 1.4 intégrés
- ✅ ExplorePéda#7 niveau 2 — 2.1, 2.2, 2.3 traités

---

## État général du projet

| Élément | État |
|---|---|
| Chaîne de skills complète | ✅ Fonctionnel |
| Skills session (`/maj`, `/todo`, etc.) | ✅ Fonctionnel |
| Infrastructure Git (symlinks, setup.sh) | ✅ Fonctionnel |
| `produit.md` | ✅ Stable |
| `methode.md` | ✅ Mis à jour 2026-03-27 |
| `design.md` | ✅ Créé 2026-03-27 |
| `architecture.md` | ✅ Réécrit 2026-03-27 |
| `securite.md` | 🔧 Doctrine présente, skill absent |
| `tests.md` | ✅ Stable |
| `stack.md` | ✅ Stable |
| Skill `/init` | ❌ Non implémenté |
| Skill `/securite` | ❌ Non implémenté |
| Skill `/design` | ❌ Non implémenté |
| Migration outputs → fichiers `.md` | ❌ Non fait |
| `templates/` dans vibe-method | ❌ Non créé |

---

## Prochain projet

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
