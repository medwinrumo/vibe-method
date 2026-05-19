# /init-projet — Initialisation d'un nouveau projet

Initialise l'environnement complet d'un nouveau projet : repo Git local + GitHub.

## Usage

```
/init-projet
```

Pas d'arguments. Le nom du projet est déduit du dossier courant.
Lancer depuis le dossier du projet : `cd ~/dev/[nom_projet]` puis `/init-projet`.

---

## Étape 0 — Identification du projet

```bash
basename $(pwd)
```

Tu affiches le nom détecté et tu demandes confirmation avant de continuer :

> "Projet détecté : **[nom_projet]**. Je vais initialiser Git, créer le repo GitHub et les fichiers de base. On y va ?"

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
   - `CLAUDE.md` — créé avec un template minimal (voir ci-dessous)
   - `[nom_projet].todo.md` — vide, alimenté par `/majtodo`
   - `[nom_projet].log.md` — vide, alimenté par `/log`
   - `[nom_projet].context.md` — pré-rempli avec les sections (voir ci-dessous)

**Contenu de `CLAUDE.md` à la création :**

```markdown
# CLAUDE.md — [nom_projet]
_Contexte projet — mis à jour progressivement par les skills_

<!-- Sections ajoutées automatiquement : /contexte → /brief → /charte → /prd → /securite → /design → /archi → /regles → /stack → /adr -->
<!-- Chaque section renvoie vers son artefact pour les détails complets. -->
```

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

## Étape 2 — GitHub Projects

Créer et configurer le kanban du projet.

### 2a — Vérifier les scopes (une fois par machine)

```bash
gh auth refresh -h github.com -s read:project,project
```

### 2b — Créer le projet

```bash
gh project create --owner medwinrumo --title "[nom_projet]"
```

Récupérer le numéro **N** retourné par la commande.

### 2c — Configurer les colonnes de statut

Le champ "Status" est créé automatiquement avec Todo / In Progress / Done.  
Ajouter l'option **Late** manuellement :  
→ `https://github.com/users/medwinrumo/projects/[N]/settings` → champ Status → "Add an option" → "Late"

### 2d — Ajouter les champs date

Dans les settings du projet (`/settings`), ajouter :
- Champ `Début` (type : Date)
- Champ `Fin` (type : Date)

### 2e — Récupérer les IDs internes

```bash
gh project field-list [N] --owner medwinrumo --format json
```

### 2f — Créer `.gh-project.local`

Créer le fichier dans le repo du projet avec les valeurs récupérées :

```
project_number=N
owner=medwinrumo
project_id=PVT_xxx
field_status_id=PVTSSF_xxx
option_todo_id=xxx
option_in_progress_id=xxx
option_done_id=xxx
option_late_id=xxx
field_debut_id=PVTF_xxx
field_fin_id=PVTF_xxx
```

### 2g — Protéger le fichier

```bash
echo ".gh-project.local" >> .gitignore
git add .gitignore
git commit -m "chore: add .gh-project.local to gitignore"
git push
```

Confirmer : "GitHub Projects configuré → `https://github.com/users/medwinrumo/projects/[N]`"

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
```

Puis suggérer la suite :

> "Prochaine étape → `/context`.
>
> Tu peux d'abord renseigner `[nom_projet].context.md` directement (notes de réunion, contexte client, contraintes) — puis lancer `/context` pour que je lise le fichier, le complète et te challenge sur les angles manquants.
>
> On y va maintenant ou tu veux remplir le fichier d'abord ?"
