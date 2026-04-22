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
├── tests.md            → Doctrine de test (niveaux, Gherkin, Playwright, anti-auto-validation)
├── stack.md            → Doctrine de reconnaissance technique (spike, investigation stack, free tier, gotchas)
└── .claude/
    └── commands/       → Skills Claude Code (voir liste ci-dessous)
```

---

## Chaîne de skills — workflow complet

```
/brief → /prd → /prd-update → [design] → /archi → /stack → /roadmap → /specs → [code] → /tests → /recette ↔ /debug
```

| Skill | Rôle | Output |
|---|---|---|
| `/brief` | De l'intention au brief structuré | `[projet].brief.md` |
| `/prd` | Du brief au PRD V1 (dialogue) | `[projet].prd.md` |
| `/prd-update` | Intégration retours cross-pollination → PRD V2 | `[projet].prd.md` |
| `/design` | Mode A : spike stack design + interview + liste features pour Stitch/Figma. Mode B : intégration export CSS → Tailwind + shadcn | `[projet].design.md` |
| `/archi` | Architecture modulaire + silos + garde-fous | `[projet].archi.md` + `CLAUDE.md` projet |
| `/stack` | Spike technique — investigation stack, free tier, gotchas | `[projet].stack.md` |
| `/roadmap` | Roadmap + planning global | `[projet].Rmap.md` |
| `/specs` | User story format A4 | `[projet].spec.md` |
| `/tests` | Tests unitaires + intégration + Playwright | `[projet].tests.md` |
| `/recette` | Génère Gherkin depuis User Stories + validation manuelle | `[projet].recette.md` |
| `/debug` | Diagnostic et résolution de bug (déclenché par `/recette`) | — |

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

### Priorité haute
- [ ] Skill `/init` — point d'entrée de toute la méthode. Usage : `/init [projet] [page_projet_id]`
  - Git : repo GitHub via `gh`, CLAUDE.md projet, [projet].todo.md, [projet].log.md, premier commit + push
  - Notion : page `[projet].run` (template `34aa67fe703a80a89161cafb5c431272`) + 9 sous-pages enfants (template `34aa67fe703a80669b09c38e718d20c3`)

### Priorité moyenne
- [ ] `architecture.md` — mettre à jour avec les deux stacks (Convex / Supabase)

### Priorité basse
- [ ] Skills vs MCP — comprendre la différence, décider quand utiliser l'un ou l'autre
- [ ] Corriger `/maj` — supprimer références obsolètes

---

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
