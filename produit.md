# produit.md

Méthode pour définir ce qu'on construit — du brief au PRD, du backlog aux user stories.
À enrichir au fil des sessions.

---

## Hiérarchie

```
Brief → PRD → Backlog → User Story → Specs (critères d'acceptation) → Tests
```

---

## Brief

Point de départ. Description brute d'un besoin ou d'une idée, avant toute structuration.

---

## PRD — Product Requirements Document

Document qui structure le brief : objectif du produit, utilisateurs cibles, features prioritaires, contraintes techniques.

**Méthode de construction :**
1. Envoyer le brief à une IA → premier jet de PRD
2. Envoyer ce PRD aux autres IA pour critique croisée
3. Renvoyer les retours au premier modèle
4. Itérer jusqu'à satisfaction
5. Donner le PRD final à Claude pour générer la roadmap

---

## Backlog

Liste ordonnée et priorisée de tout ce qu'il y a à construire (features, bugs, améliorations).

---

## User Story — Format Story A4

- **Titre** : une phrase courte et explicite
- **Description** : En tant que [acteur], je souhaite [objectif] afin de [bénéfice]
- **Règles de gestion** : les cas métier précis qui définissent le comportement attendu
- **Cas limites** : les situations inhabituelles que la feature doit gérer (données manquantes, droits insuffisants, valeurs extrêmes...)
- **Cas d'échec** : les façons dont la feature peut échouer (erreur de saisie, service indisponible, règle métier non respectée...)

Règle : tout doit tenir sur une feuille A4 — force la concision et le bon découpage.

Le skill `/specs` produit le format complet : il ajoute un "Contexte d'implémentation" (module, dépendances, contraintes sécurité) et une "Definition of Done" autour de cette user story.

---

## Specs — Critères d'acceptation (Pattern Gherkin)

Les critères d'acceptation sont rédigés en Gherkin pour être précis et testables.

```gherkin
Scenario: [titre du scénario]
  Given [contexte initial]
  When [action déclenchante]
  Then [résultat attendu]
```

Signal de découpage — deux critères complémentaires, mesurés à deux moments différents :
- **Au moment des specs** (`/specs`) : plus de 5 règles de gestion distinctes → story probablement trop large
- **Au moment de la recette** (`/recette`) : plus de 15-20 scénarios Gherkin pour une même story → story confirmée trop large

Dans les deux cas, c'est Medwin qui décide du découpage — le signal n'est pas un blocage.
