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

## Problème non résolu — à traiter en priorité prochaine session

**Organisation des skills : deux emplacements, un problème de cohérence.**

Situation actuelle :
- `~/.claude/commands/` — skills globaux, exécutés par Claude Code dans tous les projets
- `vibe-method/.claude/commands/` — copie versionnée dans git, accessible par Claude Web via GitHub

Le problème : quand un skill est modifié dans l'un, l'autre n'est pas automatiquement mis à jour.

Questions à régler :
1. Faut-il garder les deux emplacements ? Ou choisir une source unique ?
2. Si deux emplacements : quel mécanisme de sync ?
3. Les .md (produit.md, architecture.md...) sont-ils redondants avec les skills ? Les simplifier ?

---

## Ce qui reste à construire

- [ ] Boilerplate + skill `/init` — template de démarrage par stack (Convex / Supabase) + skill qui crée le repo GitHub via `gh`, scaffold la structure, crée le CLAUDE.md projet, crée les pages Notion, premier commit et push
- [ ] Skills vs MCP — point 2.3 workflow2
- [ ] Mettre à jour `architecture.md` avec les deux stacks (Convex / Supabase)
- [ ] Résoudre le problème d'organisation skills (voir ci-dessus)
- [ ] Construire le skill `/securite` — checklist sécurité à intégrer dans la chaîne, en complément de `/archi`

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
