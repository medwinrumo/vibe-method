---
type: doctrine
source: ../tests.md
source_modified: 2026-05-13
wiki_updated: 2026-05-26
tags: [tests, tdd, vitest, playwright, gherkin]
---

# Doctrine — Tests

## En une ligne
Tester = vérifier que ça fonctionne techniquement ET que c'est correct du point de vue utilisateur — ces deux dimensions ne se confondent pas.

---

## Les 3 niveaux

| Niveau | Type | Outil | Quand |
|---|---|---|---|
| 1 | Tests unitaires + intégration | Vitest | Après code (ou avant en TDD) |
| 2 | Tests E2E automatisés | Playwright | Depuis scénarios Gherkin |
| 3 | Recette manuelle | — | Dernier filtre humain |

---

## TDD — Test-Driven Development

Cycle **Red → Green → Refactor** :
- **Red** : écrire le test (échoue — le code n'existe pas)
- **Green** : écrire le minimum de code pour que le test passe
- **Refactor** : améliorer sans changer le comportement (tests restent verts)

**Obligatoire pour :**
- Tous les modules métier (logique connue avant le code, vient du spec)
- Tous les modules de sécurité

**Ne pas appliquer pour :**
- Modules UI (comportement visuel se découvre en codant)
- Modules techniques (config, api, shared)

**Lien avec /specs** : les règles de gestion du spec → tests unitaires ; les cas d'échec → tests négatifs.

---

## Ordre d'exécution

**Mode TDD (modules métier/sécurité) :**
```
/specs → /tests (Red) → code → /tests (Green + refactor) → /tests (non-régression)
→ /code-review → /recette → /tests (Playwright) → /securite → /recette (validation)
```

**Mode Standard (modules UI/techniques) :**
```
code → /tests (unitaire + intégration) → /tests (non-régression Playwright)
→ /code-review → /recette → /tests (Playwright feature) → /securite → /recette (validation)
```

---

## Anti-auto-validation — 3 règles

**Règle a** : Ne jamais demander "code ET tests" en un prompt — séparer la génération.

**Règle b** : Lancer les tests AVANT le code. S'ils passent sans code → test mal écrit.

**Règle c** : Demander explicitement des tests négatifs (inputs incorrects, cas limites, actions non autorisées).

---

## Format Gherkin (référence)

```
Étant donné [contexte]
Lorsque [action utilisateur]
Alors [résultat attendu]
```

Un scénario Gherkin = un test Playwright. Produit par [[skills/recette]].

---

## Rapport de bug (format)

```
OÙ      → quelle page, quel rôle
QUOI    → quelle action exactement
RÉSULTAT → ce qui s'est passé (+ message d'erreur)
ATTENDU  → ce qui aurait dû se passer
```

## Liens
[[skills/tests]] | [[skills/recette]] | [[skills/gherkin]] | [[doctrines/methode]] | [[doctrines/refacto]]
