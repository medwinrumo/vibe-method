---
description: Suivi centralisé de l'état des fonctions du projet dans avancement.yaml
---

# /avancement — Suivi de l'état des fonctions du projet

Tu lis et mets à jour `[projet].avancement.yaml` — le fichier de suivi centralisé des fonctions du projet.

**Modèle recommandé : T1 — Haiku** _(optionnel)_
> Tâche mécanique. Sonnet fonctionne parfaitement. Si Medwin veut optimiser les tokens : _"Tape `/model haiku` avant de lancer."_

---

## Quand lancer /avancement

- En début de session de code : voir où en est chaque fonction
- Après avoir terminé une fonction : mettre à jour le statut
- Pour savoir quelle fonction coder ensuite

---

## États possibles

```
backlog → ready-for-dev → in-progress → review → done
                                ↕
                            blocked
```

| Statut | Signification |
|---|---|
| `backlog` | Pas encore planifiée pour cette session |
| `ready-for-dev` | Spec et archi OK — prête à coder |
| `in-progress` | En cours de développement |
| `review` | Codée — en attente de `/code-review` et `/tests` |
| `done` | Revue passée, tests OK, recette validée |
| `blocked` | Bloquée par une dépendance ou un problème |

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — Vérification du fichier

Tu cherches `[projet].avancement.yaml` dans le répertoire du projet.

**Si le fichier existe :** tu le lis et tu passes à l'Étape 2.

**Si le fichier est absent :**
> "Pas de fichier sprint-status trouvé pour ce projet. Je peux en créer un depuis la roadmap (`[projet].Rmap.md`) et les specs existantes. Je fais ça ?"

Si oui → créer le fichier (Étape 1b).
Si non → arrêt.

---

## Étape 1b — Création du fichier depuis la roadmap

Tu lis `[projet].Rmap.md` et `[projet].prd.md`. Tu extrais chaque fonction/feature de V1.

Tu génères `[projet].avancement.yaml` :

```yaml
# [projet].avancement.yaml
# Source de vérité pour l'état des fonctions en développement.
# Mis à jour via /avancement à chaque changement d'état.

projet: "[nom du projet]"
dernière-mise-à-jour: "[date]"

features:
  - id: 1
    nom: "[nom de la fonction]"
    spec: "[projet].spec.[feature].md"
    statut: backlog
    notes: ""
  - id: 2
    nom: "[nom de la fonction]"
    spec: "[projet].spec.[feature].md"
    statut: backlog
    notes: ""
```

Tu demandes confirmation avant de sauvegarder :
> "Voici la liste des fonctions détectées depuis la roadmap. Tu veux ajuster quelque chose avant de créer le fichier ?"

---

## Étape 2 — Affichage de l'état

Tu présentes l'état groupé par statut, dans cet ordre :

```
--- [projet].sprint-status — [date] ---

Bloqué :
  — [fonction] : [notes]

En cours :
  — [fonction]

En review :
  — [fonction]

Prêt à coder :
  — [fonction]

Terminé :
  — [fonction 1]
  — [fonction 2]

Backlog :
  — [fonction] (non planifiée)
```

Si tout est backlog → signaler : "Aucune fonction n'a encore démarré."
Si tout est done → signaler : "Toutes les fonctions sont terminées."

---

## Étape 3 — Mise à jour (optionnelle)

> "Tu veux mettre à jour le statut d'une fonction ?"

Si oui → tu demandes :
1. Quelle fonction ?
2. Quel nouveau statut ?
3. Notes à ajouter ?

Tu mets à jour le YAML, tu enregistres, tu confirmes.

**Règle :** ne jamais faire régresser un statut sans confirmation explicite (ex : `done` → `in-progress` ne peut pas arriver par erreur).

---

## Étape 4 — Intégration avec /sessionCode

Ce skill est appelé automatiquement par `/sessionCode` à l'Étape 2 :
- Afficher le statut actuel de la feature sélectionnée
- Proposer de passer la feature à `in-progress`

Il est appelé automatiquement par `/code-review` à la fin :
- Proposer de passer la feature à `review`

Il est appelé automatiquement par `/recette` à la fin :
- Proposer de passer la feature à `done`

---

## Règles

- Le fichier YAML est la source de vérité — pas Notion, pas le `.todo.md`
- Toute mise à jour → `git add [projet].avancement.yaml && git commit -m "chore: update sprint status"`
- Un statut ne régresse jamais sans confirmation explicite
