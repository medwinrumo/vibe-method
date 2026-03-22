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
- **Description** : En tant que [utilisateur], je souhaite [objectif] afin de [bénéfice]
- **Règles de gestion** : les cas métier précis qui définissent le comportement attendu
- **Critères d'acceptation** : les conditions qui permettent de valider que la story est "Done"

Règle : tout doit tenir sur une feuille A4 — force la concision et le bon découpage.

---

## Specs — Critères d'acceptation (Pattern Gherkin)

Les critères d'acceptation sont rédigés en Gherkin pour être précis et testables.

```gherkin
Scenario: [titre du scénario]
  Given [contexte initial]
  When [action déclenchante]
  Then [résultat attendu]
```

Signal de découpage : si une user story génère plus de 15-20 scénarios Gherkin, elle est trop large et doit être splittée.
