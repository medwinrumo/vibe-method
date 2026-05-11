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

- 1 — Recherche Claude Design + skill `frontend-design` — comprendre le fonctionnement réel de chaque outil : inputs attendus, outputs, limites, différences entre les deux. À faire avant d'utiliser l'un ou l'autre sur un vrai projet. **Priorité haute — avant premier projet avec design system.**
- 2 — Recherche documentation Apple HIG pour React Native + Expo + NativeWind — lire les guidelines Apple et la doc Expo pour comprendre les contraintes de développement iOS natif avec cette stack. Alimentera la décision d'orientation RAMrezo (app native vs PWA). **Priorité haute — avant démarrage RAMrezo.**
- 3 — Tester Code Design comme outil de génération UI — à évaluer comme alternative/complément à Claude Design. Décision d'intégration dans la stack design après test. **Priorité moyenne.**
- 4 — Évaluation comparative vibe-method vs BMAD — avec BMAD installé localement dans `~/dev/bmad-method/`, comparer point par point chaque phase et skill de vibe-method contre l'équivalent BMAD. Identifier : (a) ce que BMAD couvre mieux, (b) ce que vibe-method couvre mieux, (c) les lacunes dans vibe-method à combler. Produire un rapport de décision pour chaque point. **Priorité moyenne — après tâche 5.**
- 5 — Audit de cohérence interne vibe-method — vérifier que tous les fichiers `.md` de doctrine et tous les skills sont alignés : pas de contradiction entre eux, pas de référence à un skill ou fichier inexistant, pas de règle dans un skill qui contredit un autre. Grille d'évaluation et stratégie d'audit déjà produites dans `audit-doctrine-strategie.md`. **Priorité haute.**
- 6 — Audit et enrichissement des skills existants — les skills peuvent contenir : exemples de code, URLs de doc, scripts de validation, chemins de fichiers précis, versions de librairies. Points spécifiques à traiter dans `/archi` : (a) vérification des versions de technologie par WebSearch au moment où une décision est documentée ; (b) vérification des implications en cascade — après chaque décision majeure, identifier explicitement quelles autres décisions elle déclenche ou modifie. Inclure : enrichissement `/prp` avec règles critiques des doctrines — analyse déjà produite dans `prp-doctrine-enrichissement.md`. **Priorité haute.**
- 7 — Skill `/doc-tech` — documentation technique dans le code : JSDoc, README technique, commentaires d'architecture. Définir quand déclencher, quoi documenter, comment. Créer la page Notion `[projet].doc-tech` associée. Distinct de `/doc` (documentation utilisateur). **Priorité moyenne.**
- 8 — Doctrine refactoring + skill `/refacto` — définir ce qu'est le refactoring, quand le faire, selon quels critères, quelles règles pour ne pas casser ce qui marche. Décider si nouvelle doctrine (`refacto.md`) ou enrichissement d'une doctrine existante. Créer le skill une fois la doctrine établie. **Priorité moyenne.**
- 9 — Cybersécurité des apps et sites construits avec la vibe-method — refonte et enrichissement de `securite.md` + stratégie par projet. Points identifiés comme manquants : (a) auth toujours côté serveur — jamais côté client ; (b) principe du moindre privilège en base de données — LLMs configurent trop large par défaut ; (c) inventaire complet OWASP Top 10 + Mobile Top 10 appliqué à la stack vibe-method ; (d) double audit LLM — enrichir `/securite` avec un second modèle indépendant (pattern /party appliqué à la sécurité) ; (e) outils de scan automatique de vulnérabilités à intégrer dans le pipeline CI/CD (Dependabot, Snyk, plugins ESLint sécurité) — checklist concrète à venir depuis source externe. Bases de travail : `cybersecurite-recherche.md` (recherche en cours) + checklist livre (à intégrer quand disponible). **Priorité haute.**
- ~~templates/ dans vibe-method~~ — Décidé de ne pas faire. Chaque skill produit son fichier avec la bonne structure quand il s'exécute.

### Réalisées

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
