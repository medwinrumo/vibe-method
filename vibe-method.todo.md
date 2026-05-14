# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## Dernière session — 2026-05-13 (session 2)

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

- 9 — Test filtrage de dates /todo — tâche de validation : début 2026-05-14, fin 2026-05-14. Vérifier : (1) non affichée le 2026-05-13 car début > aujourd'hui, (2) visible le 2026-05-14, (3) passage en Late si fin dépassée sans clôture. **Test.**
- 17 — Intégration traité : phase AVANT — 5 points non intégrés : cadre 3 phases AVANT/PENDANT/APRÈS, 3 règles d'état d'esprit (contrôle/concentration/notes), template prompt PRD 4 sections, règle relire le PRD avant de coder, prototype exploratoire jetable (YOLO first). Cibles : `methode.md`, `/prd`, `/prp`. **Priorité moyenne.**
- ~~18~~
- 19 — Intégration traité : posture et philosophie — 5 points non intégrés : le généraliste a l'avantage, work slop (livrer du vérifié pas du généré), deskilling (danger de déléguer sans comprendre), vibe = domaine non-expert, FOMO des outils. Cibles : `methode.md` section Posture, `stack.md`. **Priorité moyenne.**
- 20 — Intégration traité : tests + POURQUOI — 2 points : ouvrir la console navigateur au premier chargement (`tests.md` + `/recette`), étendre la règle "documenter le POURQUOI" au-delà de `/adr` (code, commits, PRD). **Priorité basse.**
- 3 — Tester Code Design comme outil de génération UI — à évaluer comme alternative/complément à Claude Design. Décision d'intégration dans la stack design après test. **Priorité moyenne.**
- 4 — Évaluation comparative vibe-method vs BMAD — avec BMAD installé localement dans `~/dev/bmad-method/`, comparer point par point chaque phase et skill de vibe-method contre l'équivalent BMAD. Identifier : (a) ce que BMAD couvre mieux, (b) ce que vibe-method couvre mieux, (c) les lacunes dans vibe-method à combler. Produire un rapport de décision pour chaque point. **Priorité moyenne — après tâche 5.**
- ~~5~~
- 6 — Audit et enrichissement des skills existants — les skills peuvent contenir : exemples de code, URLs de doc, scripts de validation, chemins de fichiers précis, versions de librairies. Points spécifiques à traiter dans `/archi` : (a) vérification des versions de technologie par WebSearch au moment où une décision est documentée ; (b) vérification des implications en cascade — après chaque décision majeure, identifier explicitement quelles autres décisions elle déclenche ou modifie. Inclure : enrichissement `/prp` avec règles critiques des doctrines — analyse déjà produite dans `prp-doctrine-enrichissement.md`. **Points supplémentaires issus de l'audit tâche 5 :** `securite.md` sections 1.6 (Données sensibles) et 1.8 (Backup) marquées "À enrichir" — compléter ou renvoyer explicitement. Protocole complet `audit-doctrine-strategie.md` Sessions 1-5 (WebSearch OWASP, CNIL, free tier, Playwright). **Priorité haute.**
- 7 — Skill `/doc-tech` — documentation technique dans le code : JSDoc, README technique, commentaires d'architecture. Définir quand déclencher, quoi documenter, comment. Créer la page Notion `[projet].doc-tech` associée. Distinct de `/doc` (documentation utilisateur). **Priorité moyenne.**
- 8 — Doctrine refactoring + skill `/refacto` — définir ce qu'est le refactoring, quand le faire, selon quels critères, quelles règles pour ne pas casser ce qui marche. Décider si nouvelle doctrine (`refacto.md`) ou enrichissement d'une doctrine existante. Créer le skill une fois la doctrine établie. **Priorité moyenne.**
- 10 — Enrichir `/sessionCode` — connecter le skill au planning et à la démarche complète : vérifier l'état de la feature dans la roadmap, charger la spec de la feature (`[projet].spec.[feature].md`), rappeler les tests attendus si TDD, vérifier les dépendances entre features, détecter si le PRP est à jour ou doit être régénéré. **Priorité moyenne — après tâche 5.**
- ~~templates/ dans vibe-method~~ — Décidé de ne pas faire. Chaque skill produit son fichier avec la bonne structure quand il s'exécute.

### Réalisées

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
