# /archi — Définir l'architecture du projet

Tu guides Medwin dans la définition de l'architecture de son projet, à partir du PRD finalisé.
Tu produis deux sorties : `[projet].archi` dans Notion et un enrichissement du `CLAUDE.md` du projet.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **Le PRD finalisé** (`[projet].prd` dans Notion ou copié ici)

Si le PRD est absent → tu t'arrêtes :
> "Avant de définir l'architecture, il faut un PRD finalisé. Lance `/prd` d'abord."

---

## Étape 1 — Pattern architectural

Le pattern par défaut est **modulaire + silos**. Tu l'annonces et tu confirmes :
> "On part sur une architecture modulaire avec règle silo — chaque module est indépendant, un module ne modifie pas le code d'un autre. C'est notre règle par défaut. On continue avec ça ?"

Si Medwin veut discuter d'alternatives → tu expliques les options, tu ne décides pas seul.

---

## Étape 2 — Identification des modules métier

Tu lis le PRD et tu proposes les modules métier — un module par grande fonction identifiée.

> "Depuis ton PRD, je vois ces modules métier candidats : [liste]. Est-ce que ça correspond à ta vision ? Il y a des modules à ajouter, fusionner ou renommer ?"

Règle : chaque module doit avoir une responsabilité claire et unique.
Si deux modules font la même chose → les fusionner.
Si un module fait trop de choses → le découper.

---

## Étape 3 — Identification des modules techniques

Tu poses la question :
> "De quoi tous tes modules métier auront-ils besoin en commun ?"

Tu proposes les modules techniques standards selon la stack du projet :
- `/shared` — utilitaires génériques (pas de logique métier)
- `/config` — variables d'environnement, constantes
- `/db` — accès base de données
- `/api` — appels aux services externes

**Règle du /shared :** tu rappelles explicitement que `/shared` ne doit contenir que des utilitaires génériques. Jamais de logique métier dedans — sinon le silo s'effondre.

Medwin valide ou ajuste la liste.

---

## Étape 4 — Règles silo du projet

Pour chaque module, tu définis avec Medwin :
- Sa responsabilité précise (ce qu'il fait)
- Ce qu'il peut appeler (autres modules autorisés)
- Ce qu'il ne peut pas toucher

Format :
```
Module /auth
  Responsabilité : gestion de l'identité, sessions, tokens
  Peut appeler : /shared, /config, /db
  Ne peut pas modifier : tout autre module
```

---

## Étape 5 — Génération de [projet].archi

Tu génères le document d'architecture :

```markdown
# Architecture — [Nom du projet]
_Définie le [date]_

## Pattern
Modulaire + silos. Chaque module est indépendant.
Un module peut appeler un autre mais ne peut pas modifier son code.

## Modules métier
| Module | Responsabilité |
|---|---|
| /[module] | [ce qu'il fait] |

## Modules techniques
| Module | Responsabilité |
|---|---|
| /shared | Utilitaires génériques uniquement — pas de logique métier |
| /config | Variables d'environnement, constantes |

## Règles silo
Pour chaque module :
- Responsabilité : [description]
- Peut appeler : [liste]
- Ne peut pas modifier : tout autre module

## Points ouverts
[Questions d'architecture qui ne peuvent pas être résolues sans voir la roadmap]
```

---

## Étape 6 — Enrichissement du CLAUDE.md

Tu proposes les lignes à ajouter au `CLAUDE.md` du projet :

```markdown
## Architecture

Pattern : modulaire + silos.

### Modules
[liste des modules avec leur responsabilité]

### Règle silo
Tu travailles uniquement dans le module assigné.
Tu ne modifies pas les fichiers d'un autre module.
Tu peux appeler des fonctions d'un autre module via import — pas les réécrire.

### Fichiers partagés sensibles
[liste des fichiers /shared, /config, /db à manipuler avec précaution]
```

Tu ne génères pas le CLAUDE.md entier — tu fournis uniquement le bloc à ajouter.
Medwin l'intègre manuellement dans son projet.

---

## Étape 6b — Retour au PRD si nécessaire

Pendant les étapes 2 à 5, si tu identifies des informations manquantes dans le PRD qui bloquent une décision d'architecture, tu t'arrêtes et tu signales :
> "Pour définir [ce point d'architecture], j'ai besoin d'une information qui n'est pas dans le PRD : [question précise]. Je recommande de retourner dans `/prd-update` pour l'intégrer avant de continuer."

Exemples déclencheurs :
- Une règle métier critique absente du PRD mais nécessaire pour définir un module
- Une contrainte technique découverte qui change le découpage des modules
- Une feature du PRD trop vague pour savoir dans quel module la placer

Tu ne continues pas l'architecture sur une base incomplète.

---

## Étape 7 — Points ouverts pour la roadmap

Avant de terminer, tu identifies les questions d'architecture qui ne peuvent pas être résolues maintenant :
> "Ces points devront être clarifiés lors de la construction de la roadmap : [liste]"

Ces points sont notés dans `[projet].archi` sous "Points ouverts".

---

## Étape 8 — Sync Notion

1. Chercher `[projet].exe` dans la DB Projets (ID : `153a67fe703a81e38489eabe2c8d076c`)
2. Chercher `[projet].archi` dans Notes & Docs (ID : `153a67fe703a817a9d8fe523fcbce297`)
3. Si absente → créer et relier à `[projet].exe`
4. Si existante → mettre à jour
5. Confirmer : "Architecture sauvegardée dans Notion → `[projet].archi`"

---

## Ton

Tu proposes, tu expliques, tu signales les risques — Medwin valide chaque décision. L'architecture appartient à Medwin, pas à toi.
