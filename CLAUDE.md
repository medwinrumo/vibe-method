# CLAUDE.md — vibe-method

Ce repo contient la méthode de développement vibe coding de Medwin.
Il n'est pas une app — c'est un ensemble de documents et de skills.

**Statut : dépôt d'archive.** Décidé le 07/08/2026 — le contenu actif de la
méthode a migré dans `~/dev/wiki/` (voir ci-dessous). Ce qui reste ici est le
journal historique du chantier de réorganisation : `migration-structure.md`,
les 3 journaux de session, et l'outillage minimal (`scripts/audit-dependances.sh`).
Rien ne s'y construit plus — consulter, pas y ajouter de contenu doctrinal.

---

## Ce qu'il reste ici

```
vibe-method/
├── .claude/
│   └── settings.local.json
├── scripts/            → audit-dependances.sh
├── migration-structure.md
└── vibe-method.{todo,log,peda}.md
```

Arbre vérifié le 07/08/2026 — `.claude/hooks/` n'existe plus (les hooks vivent
désormais dans `~/.claude/hooks/`, liés par `install.sh`). L'ancienne mention
listait des fichiers qui n'étaient déjà plus là.

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

`bash ~/dev/claude-config/install.sh` recrée les liens sur une machine neuve.
C'est l'installateur **unique** depuis le 05/08/2026 (phase 7) : il lit les
deux dépôts, wiki et claude-config. `setup.sh` a disparu — il visait le même
`~/.claude/hooks/` qu'`install.sh` sans le savoir, et « le dernier lancé
gagne » était un comportement documenté, pas voulu.

Il n'écrase rien sans sauvegarde : un fichier réel part sous
`.remplace-<horodatage>` avant d'être remplacé.

## Règles de travail

- **Rien n'entre dans une doctrine sans discussion et validation de Medwin.**
- La chaîne complète du workflow est dans `wiki/workflow-doc.md` — c'est le seul
  endroit où vit désormais l'ordre des skills, la table qui était ici ayant été
  retirée. Remis à jour le 06/08/2026 : les 5 skills manquants (`init-projet`,
  `to-issues`, `diagnose`, `backup`, `deploy`) ajoutés, `/condense` retiré.

---

## Stack technique par défaut (projets vibe-method)

**Stack A — Convex** (real-time fort : chat, collaboration)
- React + Vite + TypeScript + Convex + Vercel + GitHub

**Stack B — Supabase** (projets standards)
- React + Vite + TypeScript + Supabase + Vercel + GitHub

Choix défini au moment du `/archi`.

---

## Ce qui reste à construire

**Tout est dans `vibe-method.todo.md`, section « RESTE À FAIRE ».** Établie le
05/08/2026 à la fin du chantier de réorganisation : travail éditorial sur les
212 fiches du vault, défauts du lint lui-même, 8 observations ouvertes,
propagation vers le VPS Hermes, dettes techniques et résidus à trancher.
Chaque ligne y est vérifiée sur pièces.

---

## Prochain projet à démarrer

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
