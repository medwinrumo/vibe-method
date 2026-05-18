# CLAUDE.md — vibe-method

Ce repo contient la méthode de développement vibe coding de Medwin.
Il n'est pas une app — c'est un ensemble de documents et de skills.

---

## Structure du repo

```
vibe-method/
├── produit.md          → Brief → PRD → Backlog → User Story → Specs
├── methode.md          → Phases de travail, roadmap, planning, tests
├── design.md           → Workflow Stitch → Figma → export CSS → intégration Tailwind/shadcn
├── architecture.md     → Patterns d'architecture (modulaire + silos)
├── securite.md         → Règles de sécurité à appliquer
├── rgpd.md             → Doctrine RGPD complète (bases légales, droits, registre, consentement, checklist)
├── tests.md            → Doctrine de test (niveaux, Gherkin, Playwright, anti-auto-validation)
├── stack.md            → Doctrine de reconnaissance technique (spike, investigation stack, free tier, gotchas)
├── ui-vocabulary.md    → Lexique de référence UI/UX — zones, composants, états, patterns (avec ASCII art)
└── .claude/
    └── commands/       → Skills Claude Code (voir liste ci-dessous)
```

---

## Chaîne de skills — workflow complet

```
/contexte → /brief → /devis (si projet client) → /cgv → [validation client] → /charte → /prd → /prd-update → /prd-validate → /gherkin (Mode PRD) → [/design Mode A ↔ /archi itératif] → /regles → /stack → [/design Mode B] → /roadmap → /specs → /gherkin (Mode Specs) → /readyTo-code → /setup → /prp → /avancement (init) → /sessionCode → [code] → /code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil → /tests → /securite → /doc-tech (Mode B) → /recette ↔ /debug → [fin de phase] /phase-retrospective → /doc-tech (Mode A)
```

Skills transversaux (invocables à tout moment) : `/party`, `/impact`, `/avancement`, `/grill-me`, `/zoom-out`, `/prototype`

**Note sur la phase itérative /design ↔ /archi :**
Mode A de /design et /archi se construisent en aller-retour. Les écrans révèlent des modules manquants dans l'archi ; l'archi précise les états des composants. La phase se termine quand les deux sont cohérents. Output : `[projet].design.md` complet → donné à Claude Design pour exécution. Mode B intègre le code produit par Claude Design dans Tailwind (web) ou NativeWind (native).

| Skill | Rôle | Output |
|---|---|---|
| `/contexte` | Contexte projet — écosystème, client, contraintes, notes de réunions | `[projet].context.md` |
| `/devis` | Du brief à la proposition commerciale — qualification client (exa:search), archi légère, estimation blocs, calibrage valeur, conditions | `[projet].proposition.md` |
| `/cgv` | Génère les CGV (Conditions Générales + Conditions Particulières M1/M2/M3) à partir du brief et du contexte | `[projet].cgv.md` |
| `/brief` | De l'intention au brief structuré | `[projet].brief.md` |
| `/charte` | Charte graphique — couleurs, typo, logo, ambiance | `[projet].charte.md` |
| `/prd` | Du brief au PRD V1 (dialogue) | `[projet].prd.md` |
| `/prd-update` | Intégration retours cross-pollination → PRD V2 | `[projet].prd.md` |
| `/prd-validate` | Gate de validation PRD — complétude, traçabilité, cohérence avant `/archi` | — |
| `/gherkin` | Mode PRD : révèle les zones floues du PRD. Mode Specs : scénarios complets depuis les User Stories → définition de "done" | `[projet].gherkin.[feature].md` |
| `/design` | Mode A : design system complet (input Claude Design). Mode B : intégration code Claude Design → Tailwind ou NativeWind | `[projet].design.md` |
| `/archi` | Architecture modulaire + silos + garde-fous | `[projet].archi.md` + `CLAUDE.md` projet |
| `/regles` | Règles non-évidentes du projet optimisées pour LLM — pièges, patterns obligatoires/interdits | `[projet].regles.md` |
| `/stack` | Spike technique — investigation stack, free tier, gotchas | `[projet].stack.md` |
| `/roadmap` | Roadmap + planning global | `[projet].Rmap.md` |
| `/specs` | User story auto-contenue — un fichier par feature | `[projet].spec.[feature].md` |
| `/to-issues` | Transforme specs + roadmap en issues GitHub qualifiées HITL/AFK, découpées en vertical slices | — |
| `/readyTo-code` | Gate avant dev — vérifie que PRD, archi, specs, PRP, avancement sont tous présents et cohérents | — |
| `/setup` | Bootstrap technique — prérequis, dépendances, tooling, structure de dossiers, .env, premier lancement | — |
| `/prp` | Agrège tous les outputs en un document condensé optimisé pour le LLM — contexte de démarrage de session de code | `[projet].prp.md` |
| `/sessionCode` | Sas d'entrée obligatoire avant de coder : charge le PRP, confirme la feature, rappelle les règles critiques | — |
| `/code-review` | Revue structurelle + sécurité avant merge | — |
| `/code-review-edge-cases` | Chasse aux cas non gérés — énumération mécanique de tous les chemins | — |
| `/repair-edge-cases` | Correction des cas non gérés — traitement un par un dans l'ordre de priorité | — |
| `/code-review-hostil` | Revue cynique — 10 angles systématiques, minimum 10 problèmes, assume le code cassé | — |
| `/avancement` | Suivi de l'état des fonctions du projet (YAML centralisé) | `[projet].avancement.yaml` |
| `/impact` | Analyse d'impact d'un changement sur tous les artefacts | — |
| `/tests` | Tests unitaires + intégration + Playwright | `[projet].tests.md` |
| `/doc-tech` | Mode A : `[projet].doc-tech.md` (vue d'ensemble développeur — fin de phase). Mode B : annotations JSDoc/TSDoc dans le code (après `/tests`, avant `/recette`) | `[projet].doc-tech.md` |
| `/recette` | Génère Gherkin depuis User Stories + validation manuelle | `[projet].recette.md` |
| `/debug` | Diagnostic et résolution de bug (déclenché par `/recette`) | — |
| `/diagnose` | Diagnostic approfondi pour bugs difficiles — boucle de feedback + hypothèses falsifiables (escalade de `/debug`) | — |
| `/phase-retrospective` | Rétrospective de fin de phase — analyse, dette, action items, preview phase suivante | `[projet]-retrospective.md` |
| `/refacto` | Refactoring guidé — diagnostic + exécution étape par étape. Déclenché avant une feature sur module dégradé, fin de phase, ou on-demand. Exige une session dédiée. | — |
| `/party` | Multi-perspectives sur une décision (sous-agents parallèles) | — |
| `/grill-me` | Interrogatoire approfondi d'un plan — une question à la fois, recommandation incluse, chaque branche résolue | — |
| `/zoom-out` | Carte du module courant — responsabilité, callers, contrat public, termes du domaine. Pour se réorienter dans un fichier peu familier | — |
| `/prototype` | Code jetable pour valider une décision — branche logique (terminal interactif) ou branche UI (variations switchables). Déclenché par Claude quand une décision ne peut pas être tranchée sans la voir tourner | — |
| `/adr` | Capture d'une décision architecturale — filtre 3 conditions obligatoire avant création | `[projet].adr.md` |

**Règle de stockage :** tous les outputs sont des fichiers `.md` dans le repo du projet — pas dans Notion. Notion est une copie pour la lecture, mise à jour en fin de session via `/maj`.

### Artefact transversal — `[projet].gloss.md`

Fichier de glossaire des termes métier canoniques du projet. Créé lors du `/prd` quand les premiers termes sont stabilisés, enrichi lors de `/archi` et `/specs`.

Format : une entrée par ligne — `**terme** : définition courte`.

Rôle : chargé par `/prp` à chaque session → Claude peut signaler en cours de session si un terme utilisé diffère du vocabulaire acté ("tu dis 'commande' — le glossaire dit 'ordre'. Lequel est canonique ?").

---

## Règles de travail sur ce repo

- **Rien n'entre dans les .md sans discussion et validation de Medwin.**
- Les skills sont dans `.claude/commands/` — un fichier par skill.
- Toujours commiter et pusher après chaque modification de skill.
- Les skills sont accessibles globalement par Claude Code via les symlinks `~/.claude/commands/` → vibe-method.

---

## Infrastructure Git — actée

- Source unique : `vibe-method/.claude/commands/` pour tous les skills
- `~/.claude/commands/` = symlinks vers vibe-method
- `CLAUDE.global.md` versionné dans vibe-method (symlink depuis `~/dev/CLAUDE.md`)
- `setup.sh` dans vibe-method — recrée tous les symlinks sur nouvelle machine

---

## Stack technique par défaut (projets vibe-method)

**Stack A — Convex** (real-time fort : chat, collaboration)
- React + Vite + TypeScript + Convex + Vercel + GitHub

**Stack B — Supabase** (projets standards)
- React + Vite + TypeScript + Supabase + Vercel + GitHub

Choix défini au moment du `/archi`.

---

## Ce qui reste à construire

### Priorité basse
- [ ] Skills vs MCP — comprendre la différence, décider quand utiliser l'un ou l'autre
- [ ] Corriger `/maj` — supprimer références obsolètes

---

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
