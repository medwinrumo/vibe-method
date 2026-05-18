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

## Étape 2 — Confirmation et prochaine étape

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
