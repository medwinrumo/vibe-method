---
description: Met à jour [projet].peda et [projet].gloss dans Notion pour la session en cours
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour deux pages Notion pour le projet en cours : `[projet].peda` (journal pédagogique) et `[projet].gloss` (glossaire).

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

---

## Étape 1 — Mise à jour de `[projet].peda`

### Rôle de la page `.peda`

Journal d'apprentissage à glosstion pédagogique. Rédigée avec une intention professorale — comme si on expliquait à Medwin ce qui s'est passé, pourquoi les choses ont été faites ainsi, ce qu'il faut avoir compris. Le ton est celui d'un formateur qui documente pour que l'apprenant puisse relire sans avoir vécu la session. Les difficultés, les erreurs, les doutes méritent autant d'attention que les succès.

### Structure `.peda`

Ajouter un menu dépliant pour la session courante, imbriqué dans le menu du jour s'il existe, sinon créer le menu du jour :

```
▶ Jour N — [date] — [objectif de la session]
    ▶ Session N — [résumé en une phrase]
        - Ce qu'on a fait et pourquoi (contexte, intention, décision)
        - Comment (outils, commandes, méthodes utilisées)
        - Difficultés rencontrées et comment elles ont été résolues
        - Points qui méritent compréhension ou recul
```

Règle absolue : chaque session dans son propre menu dépliant. Jamais dans le menu d'une session précédente.

---

## Étape 2 — Mise à jour de `[projet].gloss`

### Rôle de la page `.gloss`

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

**Les doublons sont acceptés et souhaitables.** Un terme peut avoir une entrée courte dans `.gloss` ET une entrée longue dans `.peda`. Dans ce cas, ajouter dans `.gloss` un lien hypertexte vers la section `.peda` correspondante.

### Structure d'une entrée `.gloss`

```
**[Terme]**
[Définition en 1 à 3 phrases.]
→ Voir aussi : [lien vers la section .peda si une explication longue existe]
```

### Processus pour `.gloss`

1. Identifier dans la session tous les termes introduits ou utilisés qui méritent une définition
2. Chercher la page `[projet].gloss` dans Notion — la créer si elle n'existe pas (dans Notes & Docs, liée au projet)
3. Lire le contenu existant — ne pas dupliquer les termes déjà définis
4. Ajouter uniquement les nouveaux termes, dans l'ordre alphabétique si possible
5. Pour les termes qui ont une entrée longue dans `.peda` : ajouter le lien hypertexte

---

## Règle de non-duplication

Lire les deux pages avant d'écrire. N'ajouter que ce qui n'y est pas encore.

## Convention couleur

Tout contenu ajouté dans une page existante doit être coloré en bleu (`{color="blue"}`).
