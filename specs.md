# specs.md

Méthode pour rédiger le backlog et les user stories.
À enrichir au fil des sessions.

---

## Concepts actés

### Hiérarchie

```
Backlog → User Story (spec) → Critères d'acceptation (Gherkin) → Tests
```

### Backlog
Liste ordonnée et priorisée de tout ce qu'il y a à construire (features, bugs, améliorations).

### User Story — Format Story A4
- **Titre** : une phrase courte et explicite
- **Description** : En tant que [utilisateur], je souhaite [objectif] afin de [bénéfice]
- **Règles de gestion** : les cas métier précis qui définissent le comportement attendu
- **Critères d'acceptation** : les conditions qui permettent de valider que la story est "Done"

Règle : tout doit tenir sur une feuille A4 — force la concision et le bon découpage.

### Critères d'acceptation — Pattern Gherkin
Les critères d'acceptation sont rédigés en Gherkin pour être précis et testables.

```gherkin
Scenario: [titre du scénario]
  Given [contexte initial]
  When [action déclenchante]
  Then [résultat attendu]
```

Signal de découpage : si une user story génère plus de 15-20 scénarios Gherkin, elle est trop large et doit être splittée.

