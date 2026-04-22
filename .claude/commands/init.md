---
description: Initialise un nouveau projet — Git + Notion — en une commande
allowed-tools: Bash(git *), Bash(gh *), Bash(mkdir *), Bash(touch *), Bash(cp *), Bash(ls *), Write, mcp__claude_ai_Notion__notion-create-pages, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-search
---

Initialise l'environnement complet d'un nouveau projet : repo Git + pages Notion.

## Usage

```
/init [nom_projet] [page_projet_id]
```

- `nom_projet` — nom court sans espaces (ex : `minou`, `makerag`)
- `page_projet_id` — ID de la page projet Notion que Medwin a créée manuellement (phase pré-build)

Si l'un des deux arguments est manquant, le demander avant de continuer.

---

## Contexte

Medwin crée une page projet dans Notion avant de lancer `/init`. Cette page contient ses notes de réunion, recherches, contexte client — tout ce qui précède la phase de construction. Quand il est prêt à construire, il donne l'ID de cette page et `/init` prend le relais. Le lien entre la page projet et `.run` est établi manuellement par Medwin après l'exécution du skill.

La page projet sert de mise à niveau avant `/brief` — base de discussion, pas vérité absolue. Tout est à vérifier ensemble.

---

## Étape 1 — Git

1. Créer le dossier local :
```bash
mkdir ~/dev/[nom_projet]
cd ~/dev/[nom_projet]
git init
```

2. Créer le repo GitHub (privé par défaut) :
```bash
gh repo create [nom_projet] --private --source=. --remote=origin
```

3. Créer les fichiers de base :
   - `CLAUDE.md` — vide, à remplir au fil des skills
   - `[nom_projet].todo.md` — vide, alimenté par `/majtodo`
   - `[nom_projet].log.md` — vide, alimenté par `/log`

4. Premier commit et push :
```bash
git add .
git commit -m "init: scaffold projet [nom_projet]"
git push -u origin main
```

Confirmer : "Repo GitHub créé et pushé → `github.com/medwinrumo/[nom_projet]`"

---

## Étape 2 — Notion

Créer la page `[nom_projet].run` puis ses 9 sous-pages.

### Page principale `[nom_projet].run`

Créer dans la DB **Notes & Docs** (`153a67fe703a817a9d8fe523fcbce297`) avec :
- **Titre** : `[nom_projet].run`
- **Template** : `34aa67fe703a80a89161cafb5c431272`
- **Propriétés** :
  - `area` (relation → DB Area) : chercher et relier "Business"
  - `ressource` (relation → DB Ressource) : relier à la page projet fournie par Medwin (`page_projet_id`)
  - `étiquette` (select) : `vibe-coding`

### 9 sous-pages (enfants de `.run`)

Créer chaque sous-page comme page enfant de `[nom_projet].run`, avec :
- **Template** : `34aa67fe703a80669b09c38e718d20c3`
- **Propriétés identiques** à `.run` sauf `étiquette`

| Titre de la sous-page | Étiquette | Alimentée par |
|---|---|---|
| `[nom_projet].brief` | `.brief` | `/brief` |
| `[nom_projet].prd` | `.prd` | `/prd`, `/prd-update` |
| `[nom_projet].archi` | `.archi` | `/archi` |
| `[nom_projet].Rmap` | `.Rmap` | `/roadmap` |
| `[nom_projet].spec` | `.spec` | `/specs`, `/spec` |
| `[nom_projet].peda` | `.peda` | `/peda` |
| `[nom_projet].gloss` | `.gloss` | `/peda` |
| `[nom_projet].log` | `.log` | `/log` |
| `[nom_projet].doc` | `.doc` | `/doc` |

---

## Étape 3 — Confirmation

Afficher le récapitulatif :

```
[nom_projet] initialisé.

Git :
  — ~/dev/[nom_projet]/
  — github.com/medwinrumo/[nom_projet]

Notion :
  — [nom_projet].run (+ 9 sous-pages)
  — Lier manuellement .run à la page projet dans Notion

Prochaine étape : /brief
```
