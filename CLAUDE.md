# CLAUDE.md — vibe-method

Ce repo contient la méthode de développement vibe coding de Medwin.
Il n'est pas une app — c'est un ensemble de documents et de skills.

---

## Structure du repo

```
vibe-method/
├── produit.md          → Brief → PRD → Backlog → User Story → Specs
├── methode.md          → Phases de travail, roadmap, planning, tests
├── architecture.md     → Patterns d'architecture (modulaire + silos)
├── securite.md         → Règles de sécurité à appliquer
└── .claude/
    └── commands/       → Skills Claude Code (voir liste ci-dessous)
```

---

## Chaîne de skills — workflow complet

```
/brief → /prd → /prd-update → /archi → /roadmap → /specs → /tests → /recette
```

| Skill | Rôle | Sortie Notion |
|---|---|---|
| `/brief` | De l'intention au brief structuré | `[projet].brief` |
| `/prd` | Du brief au PRD V1 (dialogue) | `[projet].prd` toggle V1 |
| `/prd-update` | Intégration retours cross-pollination → PRD V2 | `[projet].prd` toggle V2 |
| `/archi` | Architecture modulaire + silos + garde-fous | `[projet].archi` + CLAUDE.md projet |
| `/roadmap` | Roadmap + planning global | `[projet].Rmap` |
| `/specs` | User story format A4 + critères Gherkin | `[projet].spec` |
| `/tests` | Unit + integration tests depuis specs | local |
| `/recette` | Checklist E2E manuelle + suivi ✅/❌ | `[projet].recette` |

---

## Règles de travail sur ce repo

- **Rien n'entre dans les .md sans discussion et validation de Medwin.**
- Les skills sont dans `.claude/commands/` — un fichier par skill.
- Toujours commiter et pusher après chaque modification de skill.
- Les skills sont accessibles globalement par Claude Web (via GitHub) et par Claude Code (via `.claude/commands/`).

---

## Stack technique par défaut (projets vibe-method)

**Stack A — Convex** (real-time fort : chat, collaboration)
- React + Vite + TypeScript + Convex + Vercel + GitHub

**Stack B — Supabase** (projets standards)
- React + Vite + TypeScript + Supabase + Vercel + GitHub

Choix défini au moment du `/archi`.

---

## Ce qui reste à construire

- [ ] Boilerplate — projet template prêt à cloner (point 2.2 workflow2)
- [ ] Skills vs MCP — point 2.3 workflow2
- [ ] Mettre à jour `architecture.md` avec les deux stacks

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Migrer depuis Firebase V1 vers Convex V2.
