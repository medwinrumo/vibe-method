---
description: Met à jour le journal pédagogique et le glossaire des termes métier du projet
---

# /peda — Journal pédagogique et glossaire

Met à jour deux fichiers locaux pour le projet en cours : `[projet].peda.md` (journal pédagogique) et `[projet].gloss.md` (glossaire).

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

---

## Étape 1 — Mise à jour de `[projet].peda.md`

### Rôle de `.peda`

Journal d'apprentissage à vocation pédagogique. Rédigé avec une intention professorale — comme si on expliquait à Medwin ce qui s'est passé, pourquoi les choses ont été faites ainsi, ce qu'il faut avoir compris. Le ton est celui d'un formateur qui documente pour que l'apprenant puisse relire sans avoir vécu la session. Les difficultés, les erreurs, les doutes méritent autant d'attention que les succès.

### Structure `.peda`

Si le fichier n'existe pas → le créer avec l'en-tête `# [projet].peda — Journal pédagogique`.

Ajouter une section pour la session courante, imbriquée dans le jour courant s'il existe, sinon créer la section du jour :

```markdown
## Jour N — [date] — [objectif de la session]

### Session N — [résumé en une phrase]

- Ce qu'on a fait et pourquoi (contexte, intention, décision)
- Comment (outils, commandes, méthodes utilisées)
- Difficultés rencontrées et comment elles ont été résolues
- Points qui méritent compréhension ou recul
```

Règle absolue : chaque session dans sa propre section. Jamais dans la section d'une session précédente.

---

## Étape 2 — Mise à jour de `[projet].gloss.md`

### Rôle de `.gloss`

Glossaire du projet. Chaque entrée = un mot ou une expression + sa définition en 1 à 3 phrases maximum. Conçu pour être lu rapidement, sans contexte. Ce n'est pas un lieu d'explication longue — c'est un dictionnaire de référence.

### Ce qui relève de `.gloss` (et non de `.peda`)

Un terme va dans `.gloss` si :
- C'est un mot technique, un acronyme, un concept nommé (ex : RLS, TTL, CRUD, PRP, silo, free tier...)
- Une définition courte suffit à le comprendre
- Il est susceptible d'être réutilisé dans d'autres sessions ou projets

Un concept va dans `.peda` (et pas seulement dans `.gloss`) si :
- Il nécessite une explication de contexte, une démonstration, un exemple de code, une nuance
- Il y a eu une incompréhension ou une difficulté à le saisir pendant la session
- Comprendre POURQUOI est aussi important que comprendre QUOI

**Les doublons sont acceptés et souhaitables.** Un terme peut avoir une entrée courte dans `.gloss` ET une entrée longue dans `.peda`.

### Structure d'une entrée `.gloss`

```markdown
**[Terme]**
[Définition en 1 à 3 phrases.]
```

### Processus pour `.gloss`

1. Identifier dans la session tous les termes introduits ou utilisés qui méritent une définition
2. Lire `[projet].gloss.md` — le créer s'il n'existe pas avec l'en-tête `# [projet].gloss — Glossaire`
3. Ne pas dupliquer les termes déjà définis
4. Ajouter uniquement les nouveaux termes, dans l'ordre alphabétique si possible

---

## Règle de non-duplication

Lire les deux fichiers avant d'écrire. N'ajouter que ce qui n'y est pas encore.
