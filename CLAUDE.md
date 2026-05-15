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
└── .claude/
    └── commands/       → Skills Claude Code (voir liste ci-dessous)
```

---

## Chaîne de skills — workflow complet

```
/contexte → /brief → /charte → /prd → /prd-update → /prd-validate → /gherkin (Mode PRD) → [/design Mode A ↔ /archi itératif] → /regles → /stack → [/design Mode B] → /roadmap → /specs → /gherkin (Mode Specs) → /readyTo-code → /setup → /prp → /avancement (init) → /sessionCode → [code] → /code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil → /tests → /doc-tech (Mode B) → /recette ↔ /debug → [fin de phase] /phase-retrospective → /doc-tech (Mode A)
```

Skills transversaux (invocables à tout moment) : `/party`, `/securite`, `/impact`, `/avancement`

**Note sur la phase itérative /design ↔ /archi :**
Mode A de /design et /archi se construisent en aller-retour. Les écrans révèlent des modules manquants dans l'archi ; l'archi précise les états des composants. La phase se termine quand les deux sont cohérents. Output : `[projet].design.md` complet → donné à Claude Design pour exécution. Mode B intègre le code produit par Claude Design dans Tailwind (web) ou NativeWind (native).

| Skill | Rôle | Output |
|---|---|---|
| `/contexte` | Contexte projet — écosystème, client, contraintes, notes de réunions | `[projet].context.md` |
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
| `/phase-retrospective` | Rétrospective de fin de phase — analyse, dette, action items, preview phase suivante | `[projet]-retrospective.md` |
| `/refacto` | Refactoring guidé — diagnostic + exécution étape par étape. Déclenché avant une feature sur module dégradé, fin de phase, ou on-demand. Exige une session dédiée. | — |
| `/party` | Multi-perspectives sur une décision (sous-agents parallèles) | — |
| `/adr` | Capture d'une décision architecturale (4 questions → append dans `[projet].adr.md`) | `[projet].adr.md` |

**Règle de stockage :** tous les outputs sont des fichiers `.md` dans le repo du projet — pas dans Notion. Notion est une copie pour la lecture, mise à jour en fin de session via `/maj`.

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
