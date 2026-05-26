---
type: doctrine
source: ../produit.md
source_modified: 2026-05-13
wiki_updated: 2026-05-26
tags: [produit, brief, prd, user-story, backlog]
---

# Doctrine — Produit

## En une ligne
Brief → PRD → Backlog → User Story → Specs → Tests : chaque niveau précise le précédent, rien ne saute une étape.

---

## La hiérarchie

```
Brief → PRD → Backlog → User Story (format A4) → Specs (Gherkin) → Tests
```

---

## Brief

Point de départ. Description brute d'un besoin ou d'une idée.
Produit par [[skills/brief]] en 9 domaines : problème, utilisateurs, fonctions, hors-scope, contraintes, architecture légère, règles métier, niveau de risque, RGPD.

---

## PRD — Product Requirements Document

Structure le brief : objectif, utilisateurs cibles, features prioritaires, contraintes.

**Méthode de construction (cross-pollination) :**
1. Brief → IA → premier jet PRD
2. PRD envoyé aux autres IA pour critique croisée
3. Retours envoyés au premier modèle
4. Itérer jusqu'à satisfaction

Produit par [[skills/prd]], enrichi par [[skills/prd-update]], validé par [[skills/prd-validate]].

---

## Backlog

Liste ordonnée et priorisée de tout ce qu'il y a à construire.

---

## User Story — Format A4

Chaque story tient sur une feuille A4 (force la concision et le bon découpage).

- **Titre** : une phrase courte et explicite
- **Description** : En tant que [acteur], je souhaite [objectif] afin de [bénéfice]
- **Règles de gestion** : cas métier précis définissant le comportement attendu
- **Cas limites** : situations inhabituelles (données manquantes, droits insuffisants)
- **Cas d'échec** : façons dont la feature peut échouer

**Signal de découpage :**
- > 5 règles de gestion au moment des specs → story probablement trop large
- > 15-20 scénarios Gherkin à la recette → story confirmée trop large

---

## Specs — Critères d'acceptation

Rédigés en Gherkin pour être précis et testables :

```
Scenario: [titre]
  Given [contexte initial]
  When [action déclenchante]
  Then [résultat attendu]
```

Produits par [[skills/specs]], enrichis par [[skills/gherkin]].

**Les scénarios Gherkin de recette** sont dans `[projet].recette.md` uniquement — pas dans les specs.

## Liens
[[skills/brief]] | [[skills/prd]] | [[skills/specs]] | [[skills/gherkin]] | [[skills/recette]]
