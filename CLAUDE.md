# CLAUDE.md — vibe-method

Ce repo contient la méthode de développement vibe coding de Medwin.
Il n'est pas une app — c'est un ensemble de documents et de skills.

---

## Ce qu'il reste ici

```
vibe-method/
├── .claude/
│   ├── hooks/          → stop-cloture.sh, track-repo.sh (+ 1 archivé)
│   └── settings.local.json
├── scripts/            → audit-dependances.sh
├── setup.sh            → recrée les liens de ~/.claude vers le wiki
├── migration-structure.md
└── vibe-method.{todo,log,peda}.md
```

**Le contenu de la méthode a migré dans `~/dev/wiki/` le 5 août 2026.**
Doctrines en phase 4, skills et agents en phase 5. Ce dépôt ne contient plus
que l'outillage de la migration elle-même et les journaux du chantier.

## Où vit quoi, maintenant

| Quoi | Où | Comment on le reconnaît |
|---|---|---|
| 56 skills | `~/dev/wiki/<nom>.md` | `claude-code: commande` dans le frontmatter |
| 4 agents | `~/dev/wiki/<nom>.md` | `claude-code: agent` |
| 12 doctrines | `~/dev/wiki/<nom>-doc.md` | suffixe `-doc` |
| 8 skills hors méthode | `~/dev/claude-config/commands/` | `lint` `wiki` `caveman` `pdf` `slides` `condense` `firecrawl` `task-observer` |
| Instructions globales | `~/dev/claude-config/CLAUDE.md` | portée utilisateur |

Les skills et les agents sont des **fiches du second cerveau** : typés
`Procédure`, tagués, indexés dans `wiki/index.md`, reliés par wikiliens et
groupés en 8 clusters par phase du workflow. Ils se lisent dans Obsidian
comme n'importe quelle fiche, et restent invocables par `/nom`.

Conséquence directe : **Hermes y a accès**. Le wiki est le dépôt partagé
Mac ↔ VPS. Avant la migration, la méthode lui était invisible.

## Modifier un skill

Éditer `~/dev/wiki/<nom>.md` — c'est la source, `~/.claude/commands/<nom>.md`
n'est qu'un lien. Toute modification suit les règles du vault
(`wiki/CLAUDE.md`) : sept champs de frontmatter obligatoires, `description`
identique à celle de `index.md`, opération journalisée dans `journal-log.md`.

`bash setup.sh` recrée les liens sur une machine neuve. Il n'écrase plus rien
sans sauvegarde — un fichier réel est déplacé sous `.remplace-<horodatage>`
avant d'être remplacé.

## Règles de travail

- **Rien n'entre dans une doctrine sans discussion et validation de Medwin.**
- La chaîne complète du workflow est dans `wiki/workflow-doc.md`. **Elle a du retard** :
  le guide date du 11/06/2026 et ne couvre ni `deploy` ni `init-projet`, tout en
  documentant encore `/condense`, sorti de la méthode le 05/08. À reprendre — c'est
  le seul endroit où vit désormais l'ordre des skills, la table qui était ici ayant
  été retirée.

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
