---
description: Initialise un nouveau projet — Git + Notion — en une commande
allowed-tools: Bash(git *), Bash(gh *), Bash(mkdir *), Bash(touch *), Bash(cp *), Bash(ls *), Bash(pwd), Bash(basename *), Write, mcp__claude_ai_Notion__notion-create-pages, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-search
---

Initialise l'environnement complet d'un nouveau projet : repo Git + pages Notion.

## Usage

```
/init
```

Pas d'arguments. Le nom du projet est déduit du dossier courant.
Lancer depuis le dossier du projet : `cd ~/dev/[nom_projet]` puis `/init`.

---

## Étape 0 — Identification du projet

```bash
basename $(pwd)
```

Tu affiches le nom détecté et tu demandes confirmation avant de continuer :

> "Projet détecté : **[nom_projet]**. Je vais initialiser Git, créer le repo GitHub et les pages Notion. On y va ?"

---

## Étape 1 — Git

1. Initialiser le repo local :
```bash
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
   - `[nom_projet].context.md` — pré-rempli avec les sections (voir ci-dessous)

**Contenu de `[nom_projet].context.md` à la création :**

```markdown
# Contexte — [nom_projet]
_Créé le [date] — à compléter avant de lancer /context_

## Écosystème
<!-- Apps, services, acteurs en relation avec ce projet. Ce qui existe déjà. -->

## Client
<!-- Qui est le client. Nature de la relation. Ce qui est signé. Interlocuteurs clés. -->

## Contraintes
<!-- Délais fixés et leur raison. Budget. Dépendances externes. -->

## Notes
<!-- Synthèse de réunions préparatoires. Éléments libres apportés en amont. -->

## Risques identifiés
<!-- Ce qui pourrait bloquer ou compliquer le projet. -->
```

4. Premier commit et push :
```bash
git add .
git commit -m "init: scaffold projet [nom_projet]"
git push -u origin main
```

Confirmer : "Repo GitHub créé et pushé → `github.com/medwinrumo/[nom_projet]`"

---

## Étape 2 — Notion

### Page projet (racine)

Créer une nouvelle entrée dans la DB **Projets** (`153a67fe703a81e38489eabe2c8d076c`) :
- **Titre** : `[nom_projet]`

Retenir l'ID de la page créée — il sera utilisé pour lier les sous-pages.

### Page principale `[nom_projet].run`

Créer dans la DB **Notes & Docs** (`153a67fe703a817a9d8fe523fcbce297`) avec :
- **Titre** : `[nom_projet].run`
- **Template** : `34aa67fe703a80a89161cafb5c431272`
- **Propriétés** :
  - `area` (relation → DB Area) : chercher et relier "Business"
  - `ressource` (relation → DB Ressource) : relier à la page projet créée à l'étape précédente
  - `étiquette` (select) : `vibe-coding`

### 9 sous-pages (enfants de `.run`)

Créer chaque sous-page comme page enfant de `[nom_projet].run`, avec :
- **Template** : `34aa67fe703a80669b09c38e718d20c3`
- **Propriétés identiques** à `.run` sauf `étiquette`

| Titre | Étiquette | Alimentée par |
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

## Étape 3 — Confirmation et prochaine étape

Afficher le récapitulatif :

```
[nom_projet] initialisé.

Git :
  — ~/dev/[nom_projet]/
  — github.com/medwinrumo/[nom_projet]

Fichiers créés :
  — CLAUDE.md
  — [nom_projet].todo.md
  — [nom_projet].log.md
  — [nom_projet].context.md  ← à remplir avant /context

Notion :
  — Page projet créée dans la DB Projets
  — [nom_projet].run (+ 9 sous-pages)
```

Puis suggérer la suite :

> "Prochaine étape → `/context`.
>
> Tu peux d'abord renseigner `[nom_projet].context.md` directement (notes de réunion, contexte client, contraintes) — puis lancer `/context` pour que je lise le fichier, le complète et te challenge sur les angles manquants.
>
> On y va maintenant ou tu veux remplir le fichier d'abord ?"
