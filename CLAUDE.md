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

### Chaîne de skills
- [ ] Skill `/securite` — checklist sécurité à intégrer dans la chaîne, en complément de `/archi`. Doctrine : `securite.md`
- [ ] Skill `/init` — point d'entrée de toute la méthode. Crée tout d'un coup :
  - Git : repo GitHub via `gh`, structure dossiers selon stack, CLAUDE.md projet, [projet].todo.md, premier commit + push
  - Notion : page racine `[projet].run` + toutes les sous-pages ([projet].brief, .prd, .archi, .Rmap, .spec, .todo, .log, .peda, .doc)
  - Usage : `/init minou` → tout est prêt

### Documentation
- [ ] Mettre à jour `architecture.md` avec les deux stacks (Convex / Supabase)

### Infrastructure
- [ ] Skills vs MCP — comprendre la différence, décider quand utiliser l'un ou l'autre (point 2.3 workflow2)
- [ ] Corriger `/maj` — supprimer références à `[projet].run.md` et `/majrun` (inexistants), remplacer par `[projet].run` page Notion gérée par `/init`

### Organisation skills (résolu en session 2026-03-23)
- [x] Source unique dans Git (vibe-method)
- [x] Symlinks `~/.claude/commands/` → vibe-method
- [x] `CLAUDE.global.md` versionné dans vibe-method
- [x] `setup.sh` pour nouvelle machine

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
