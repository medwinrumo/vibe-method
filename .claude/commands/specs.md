# /specs — Rédiger les specs d'une feature

Tu guides Medwin dans la rédaction des specs d'une feature : user story au format A4.
Tu produis le document `[projet].spec.md` dans le repo du projet.

Les scénarios Gherkin ne font pas partie des specs — ils sont générés par `/recette` à partir des User Stories.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La feature à specer** — une feature identifiée dans la roadmap (pas une idée vague)
3. **Les documents du projet** : `[projet].prd`, `[projet].archi`, `[projet].Rmap` dans Notion

Si un document manque → tu t'arrêtes :
> "Pour specer cette feature, j'ai besoin de `[document manquant]`. Lance `/[skill]` d'abord."

---

## Étape 1 — Cadrage depuis les documents

Tu lis `[projet].archi`, `[projet].prd` et `[projet].Rmap`. Tu proposes les réponses suivantes et tu demandes confirmation :

> "Depuis les documents du projet, voici ce que je vois pour cette feature :
> - Module concerné : [module]
> - Dépendances : [features ou modules qui doivent exister avant]
> - La feature touche : [un seul module / plusieurs modules]
>
> C'est correct ?"

**Si aucun module ne correspond à la feature** → tu t'arrêtes :
> "Cette feature n'a pas de module défini dans l'architecture. Il faut retourner dans `/archi` avant de continuer."

**Si la feature touche plusieurs modules** → tu signales le risque silo :
> "Cette feature touche plusieurs modules ([liste]). C'est possible, mais vérifions que les interactions respectent la règle silo — un module peut appeler un autre, pas modifier son code. On continue ?"

---

## Étape 2 — Extraction guidée

Tu poses les questions une par une pour extraire toutes les informations nécessaires.

**Les acteurs :**
> "Qui interagit avec cette feature ? (visiteur non connecté, utilisateur connecté, admin, système automatique...)"

**Les règles métier :**
Tu extrais du PRD les règles déjà connues et tu les présentes :
> "Dans le PRD, je vois ces règles métier pour cette feature : [liste]. Est-ce qu'il y en a d'autres que le PRD ne mentionne pas ?"

**Les cas limites :**
> "Quels cas particuliers ou situations inhabituelles pourraient se produire ? (données manquantes, droits insuffisants, états exceptionnels, caractères spéciaux...)"

**Les cas d'échec :**
> "Quelles sont les façons dont cette feature peut échouer ? (erreur de saisie, service indisponible, règle métier non respectée...)"

Tu notes toutes les réponses — elles alimentent directement le format A4.

---

## Étape 3 — Rédaction du format A4

Tu rédiges la user story et tu la présentes à Medwin pour validation :

```markdown
## [Titre court et explicite]

**Description**
En tant que [acteur], je souhaite [objectif] afin de [bénéfice].

**Règles de gestion**
- [règle métier 1]
- [règle métier 2]
- [...]

**Cas limites**
- [cas limite 1]
- [cas limite 2]

**Cas d'échec**
- [cas d'échec 1]
- [cas d'échec 2]
```

> "Voilà la user story. Les règles de gestion, les cas limites et les cas d'échec sont-ils complets et corrects ?"

---

## Étape 4 — Vérification

Avant de finaliser, tu vérifies trois points :

1. **La story tient sur A4 ?** Si elle dépasse une page → trop large, à découper.
2. **Chaque règle de gestion est claire et testable ?** Une règle vague ne peut pas être vérifiée — tu demandes de la préciser.
3. **Le bénéfice est formulé ?** Le "afin de [bénéfice]" doit exprimer une valeur réelle pour l'acteur — pas "afin de pouvoir le faire".

**Signal de découpage :** si la story génère plus de 5 règles de gestion distinctes, tu t'arrêtes :
> "Cette feature est peut-être trop large. Je recommande de la découper en [liste de sous-features proposées]. Tu veux le faire avant de continuer ?"

---

## Étape 5 — Génération du document

Tu génères le document final et tu l'ajoutes à `[projet].spec.md` dans le repo du projet. Si le fichier n'existe pas → tu le crées.

```markdown
# Specs — [Nom du projet]
_[Feature] — [date]_

## Module
[module concerné]

## User Story — [Titre]

**Description**
En tant que [acteur], je souhaite [objectif] afin de [bénéfice].

**Règles de gestion**
- [règle 1]
- [règle 2]

**Cas limites**
- [cas limite 1]
- [cas limite 2]

**Cas d'échec**
- [cas d'échec 1]
- [cas d'échec 2]
```

Tu confirmes :
> "User Story ajoutée à `[projet].spec.md`. Les scénarios Gherkin correspondants seront générés par `/recette`."

---

## Étape 6 — Sync Notion

1. Chercher `[projet].exe` dans la DB Projets (ID : `153a67fe703a81e38489eabe2c8d076c`)
2. Chercher `[projet].spec` dans Notes & Docs (ID : `153a67fe703a817a9d8fe523fcbce297`)
3. Si absente → créer et relier à `[projet].exe`
4. Si existante → ajouter la nouvelle spec à la suite (ne jamais écraser les specs existantes)
5. Confirmer : "Specs sauvegardées dans Notion → `[projet].spec`"

---

## Ton

Tu guides Medwin étape par étape. Tu proposes, il valide. Tu signales les problèmes (feature trop large, silo à risque, règle ambiguë) avant qu'ils deviennent des bugs. Les specs appartiennent à Medwin — ton rôle est de t'assurer qu'elles sont complètes et cohérentes.
