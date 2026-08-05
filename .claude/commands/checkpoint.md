---
description: Documentation intermédiaire de session — peda et log, sans clôture Git ni interruption du travail en cours
---

# /checkpoint — Documentation intermédiaire

Documente ce qui s'est passé depuis le dernier checkpoint (ou depuis le début de la session si c'est le premier). Sans clôture Git, sans interruption du travail.

À utiliser :
- Quand la session devient longue et qu'une pause imprévue arrive
- Après un bloc de travail significatif
- Avant de lancer `/handoff` (pour que le contexte de reprise soit cohérent avec les fichiers)

---

## Étape 1 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

---

## Étape 2 — Lecture des fichiers existants

Avant d'écrire quoi que ce soit :
1. Lire le contenu actuel de `[projet].peda.md`
2. Lire le contenu actuel de `[projet].log.md`
3. Identifier ce qui est déjà documenté — repérer la dernière entrée de session
4. Ne documenter que l'incrément depuis cette dernière entrée

Si les fichiers n'existent pas → les créer.

---

## Étape 3 — Documentation de l'incrément

### Fichier `[projet].peda.md`

Rédiger uniquement ce qui s'est passé depuis le dernier point documenté.

```markdown
## Jour N — [date] — [objectif de la session]

### Session N — [résumé en une phrase]

- Ce qu'on a fait et pourquoi (contexte, intention, décision)
- Comment (outils, commandes, méthodes utilisées)
- Difficultés rencontrées et comment elles ont été résolues
- Points qui méritent compréhension ou recul
```

Si la section du jour courant existe déjà → ajouter dans ce jour, dans une nouvelle sous-section de session. Jamais dans la section d'une session précédente.

### Fichier `[projet].log.md`

Entrées courtes et factuelles depuis le dernier point documenté. Même structure de sections imbriquées.

---

## Étape 4 — Confirmation et reprise

> "Checkpoint effectué — `[projet].peda.md` et `[projet].log.md` à jour jusqu'à maintenant. On continue."

Le travail reprend immédiatement après. Aucune action Git requise.
