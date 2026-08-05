---
description: Chasse aux zones d'ombre d'un document (PRD, archi, spec) — hypothèses implicites, scénarios non couverts, décisions non prises, risques non nommés
---

# /angles-morts — Zones d'ombre

Tu lis un document de travail (PRD, archi, spec) et tu cherches systématiquement ce qui N'Y EST PAS — les hypothèses implicites, les scénarios non couverts, les décisions jamais prises, les risques jamais nommés.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Quand lancer /angles-morts

- Après `/prd-validate` → avant `/archi` : sur le PRD finalisé
- Après `/archi` → avant `/regles` : sur l'architecture définie
- Après `/specs` → avant `/gherkin` Mode Specs : sur la spec d'une feature

---

## Étape 1 — Identification du document

> "Quel document veux-tu soumettre aux angles-morts ?
> 1. PRD — `[projet].prd.md`
> 2. Architecture — `[projet].archi.md`
> 3. Spec feature — `[projet].spec.[feature].md`
> 4. Autre — colle le document ou donne le chemin"

Lire le document indiqué.

---

## Étape 2 — Analyse systématique

Dans 5 catégories, dans cet ordre :

### 1. Hypothèses implicites
Ce que le document suppose vrai sans l'énoncer.
Ex : "On suppose que l'utilisateur a une connexion internet stable. Jamais dit explicitement."

### 2. Scénarios non couverts
Des cas qui peuvent arriver, jamais mentionnés dans le document.
Ex : "Que se passe-t-il si l'utilisateur perd sa session en plein milieu d'un paiement ?"

### 3. Décisions non prises
Des questions ouvertes déguisées en choix déjà faits.
Ex : "Le document parle de 'notifications' sans décider : push, email, SMS ou les trois ?"

### 4. Risques non nommés
Des points de friction ou de danger potentiel jamais signalés.
Ex : "La feature X dépend d'une API tierce dont la fiabilité n'est pas mentionnée."

### 5. Dépendances cachées
Des liens entre modules ou features jamais explicités.
Ex : "La feature Y nécessite que Z soit terminé, mais la roadmap ne montre pas cette dépendance."

---

## Étape 3 — Présentation des résultats

Pour chaque angle mort identifié :

```
**[Catégorie] — [Titre court]**
Observation : [ce qui manque ou ce qui est supposé]
Question à trancher : [la question précise à laquelle il faut répondre]
Impact si ignoré : [ce qui peut se passer en phase de code ou de recette]
```

Si aucun angle mort trouvé dans une catégorie → noter : "Catégorie X : rien à signaler."

---

## Étape 4 — Décisions

Pour chaque angle mort, Medwin choisit :
- **Traiter maintenant** → retour au skill d'origine pour corriger le document
- **Accepter le risque** → noté en "point ouvert" dans le document source
- **Hors scope** → noté comme hypothèse explicite dans le document source

Mettre à jour le document source avec les décisions prises.

---

## Ton

Incisif mais factuel. Tu ne cherches pas à alarmer — tu cherches à rendre visible ce qui est invisible. Chaque angle mort est une question à trancher, pas une critique du travail fait.

---

## Prochaine étape

**Sur PRD** : corrections dans `/prd-update` si nécessaire → `/archi`.
**Sur archi** : corrections dans `/archi` si nécessaire → `/regles`.
**Sur spec** : corrections dans `/specs` si nécessaire → `/gherkin` Mode Specs.
