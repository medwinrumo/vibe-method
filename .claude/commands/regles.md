---
description: Construit par dialogue les règles non-évidentes du projet, destinées aux LLMs qui y travailleront
---

# /regles — Contexte projet optimisé pour LLM

Tu construis par dialogue le fichier de règles non-évidentes spécifiques au projet. Ce fichier guide tous les LLMs qui travaillent sur ce projet — il documente ce qu'on ne peut pas déduire du code.

Ce n'est pas un résumé de l'archi. C'est la liste des pièges, des conventions implicites, des décisions contra-intuitives qui font qu'un LLM naïf ferait une erreur.

---

## Quand lancer /regles

Après `/archi` et avant le premier `/sessionCode`. Peut être enrichi à n'importe quel moment quand une règle non-évidente émerge.

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

Si `[projet].regles.md` existe déjà → tu le lis et tu proposes de l'enrichir :
> "Un project-context existe déjà pour [projet]. Veux-tu l'enrichir ou le reprendre de zéro ?"

---

## Étape 1 — Chargement du contexte existant

Tu lis silencieusement :
- `[projet].prd.md` — pour connaître les features V1
- `[projet].archi.md` — pour identifier les modules et les règles silo
- `CLAUDE.md` dans le repo projet — pour les règles déjà documentées

Tu n'affiches pas ces fichiers. Tu t'en sers pour poser des questions ciblées à l'Étape 2.

---

## Étape 2 — Dialogue d'élicitation

Tu poses les questions une par une. Tu attends la réponse avant la suivante. Si la réponse est vague, tu reformules.

**Question 1 — Règles de nommage**
> "Y a-t-il des conventions de nommage spécifiques à ce projet ? (fichiers, variables, tables, routes, branches — tout ce qu'un LLM qui débarque pourrait rater)"

**Question 2 — Pièges de la stack**
> "Avec la stack actuelle ([stack depuis archi]), quels sont les gotchas que tu as déjà rencontrés ou que tu veux éviter ? (ex : gestion d'état, appels asynchrones, gestion des erreurs, comportements inattendus de librairies)"

**Question 3 — Règles de gestion non-évidentes**
> "Y a-t-il des règles métier ou des cas-limites qui ne sont pas dans le PRD mais que tout développeur doit connaître ?"

**Question 4 — Patterns interdits**
> "Qu'est-ce qu'un LLM NE doit JAMAIS faire sur ce projet ? (ex : jamais utiliser tel pattern, jamais appeler tel module depuis tel autre, jamais commiter tel type de fichier)"

**Question 5 — Patterns obligatoires**
> "Inversement, y a-t-il des patterns que tu veux TOUJOURS voir appliqués ? (ex : toujours valider côté serveur, toujours logger tel type d'erreur, toujours utiliser telle fonction utilitaire)"

**Question 6 — Environnements**
> "Y a-t-il des spécificités d'environnement à connaître ? (ex : variables d'env obligatoires, différences dev/staging/prod, secrets à ne jamais commiter)"

**Question 7 — Décisions contra-intuitives**
> "Y a-t-il des décisions d'archi ou de code qui semblent étranges mais qui ont une bonne raison d'être ? (ex : 'on n'utilise pas les hooks React Query ici parce que…', 'ce module est volontairement couplé parce que…')"

À chaque réponse substantielle → tu reformules en une ou deux lignes courtes pour confirmer avant de passer à la suivante.

---

## Étape 3 — Génération du fichier

Tu génères `[projet].regles.md` depuis les réponses.

Format :

```markdown
# Project Context — [Nom du projet]
_Généré le [date] via /regles_

> Ce fichier documente les règles non-évidentes du projet. Il complète le PRD et l'archi.
> À lire avant de coder sur [projet].

---

## Nommage
- [règle courte]

## Pièges de la stack
- [piège : description courte + pourquoi c'est un piège]

## Règles métier non-évidentes
- [règle]

## Patterns interdits
- ❌ [pattern interdit — raison]

## Patterns obligatoires
- ✅ [pattern obligatoire — raison]

## Environnements
- [spécificité]

## Décisions contra-intuitives
- [décision] — **Pourquoi** : [raison]
```

Chaque entrée est une ligne courte. Pas de paragraphes. Le fichier doit être lisible en 2 minutes.

Tu présentes le fichier avant de le sauvegarder :
> "Voilà le project-context pour [projet]. [N] règles documentées. Je le sauvegarde dans `[projet].regles.md` ?"

---

## Étape 4 — Sauvegarde

Si Medwin valide → tu sauvegardes `[projet].regles.md` dans le repo projet.

**Mise à jour CLAUDE.md** — upsert de la section `## Règles & pièges` :
- Section existante → remplacer intégralement
- Section absente → ajouter en fin de fichier

Condenser les 5-8 règles les plus critiques depuis `[projet].regles.md` :

```markdown
## Règles & pièges
_→ Détails : `[projet].regles.md`_

- [Règle critique 1]
- [Règle critique 2]
- ❌ [Pattern interdit — raison courte]
- ✅ [Pattern obligatoire — raison courte]
```

---

## Wiki

Après l'Étape 4, pour chaque règle liée à un outil (pas spécifique au projet) :
> "Cette règle sur [outil] est réutilisable. Je la note dans `~/dev/wiki/[outil].md` ?"
Si oui → lire le fichier existant, fusionner, logger dans `~/dev/wiki/log.md`.

---

## Règles

- Ne jamais dupliquer ce qui est déjà dans `CLAUDE.md` ou `[projet].archi.md` — seulement ce qui n'est pas déductible.
- Le fichier est court (idéalement < 60 lignes) — s'il grossit, c'est que les règles sont trop générales.
- Rien n'est écrit sans que Medwin l'ait validé.
- Si une règle est évidente (ex : "toujours écrire du bon code") → ne pas l'inclure.

---

## Prochaine étape

`/stack` — les règles sont posées, investiguer la stack et ses gotchas.
