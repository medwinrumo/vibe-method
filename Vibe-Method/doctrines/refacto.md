---
type: doctrine
source: ../refacto.md
source_modified: 2026-05-13
wiki_updated: 2026-05-26
tags: [refacto, dette-technique, session, tdd]
---

# Doctrine — Refactoring

## En une ligne
Le refactoring est une discipline à part entière avec ses propres règles — session dédiée, branche dédiée, étapes atomiques. Jamais mélangé avec une feature ou un bug fix.

---

## Définition

Améliorer la structure interne du code **sans changer ce que l'application fait**.
Le comportement avant et après est identique — ce qui change : clarté, organisation, maintenabilité.

**Refactoriser ≠ ajouter une feature. Refactoriser ≠ corriger un bug. Trois activités incompatibles dans la même session.**

---

## Critères — quand refactoriser

- Duplication visible (même logique à plusieurs endroits)
- Module trop gros (impossible à comprendre d'un coup d'œil)
- Nommage trompeur ou flou
- Logique impossible à expliquer en une phrase
- Responsabilités mélangées (logique dans le mauvais module)
- Avant une feature sur un module dégradé

## Critères — quand NE PAS refactoriser

- Proche d'une deadline
- Sans couverture de tests sur le code concerné
- En même temps qu'une feature ou bug fix
- Code fonctionnel sans contact prévu prochainement
- Par perfectionnisme sans raison concrète

---

## 3 déclencheurs dans le workflow

1. **Avant une feature** : module dégradé détecté → `/refacto` d'abord, feature ensuite
2. **Fin de phase** : stabilisation avant release → `/recette (dernière feature)` → `/refacto` → release
3. **On-demand** : signal concret identifié — doit rester l'exception

---

## 8 règles non-négociables

1. **Session dédiée** — jamais mélangé, session propre obligatoire
2. **Branche dédiée** — `refacto/[module]`
3. **Commit checkpoint avant de commencer** — point de retour garanti
4. **Tests passants avant de commencer** — si tests échouent déjà → bug fix d'abord
5. **Scope en une phrase** avant de toucher quoi que ce soit
6. **Étapes atomiques** — un changement annoncé, validé, exécuté, vérifié avant le suivant
7. **Commit atomique par étape** — `refacto: [action précise]`
8. **Tests relancés après chaque étape** — si échec → arrêt, pas de continuation

---

## Micro vs Macro

| | Micro-refactoring TDD | Macro-refactoring `/refacto` |
|---|---|---|
| Quand | Après le Green, même session | Session dédiée |
| Périmètre | Code qui vient d'être écrit | Dette accumulée |
| Branche | Branche feature courante | `refacto/[module]` |
| Commits | Pas séparés | Commit atomique par étape |

**Règle de distinction** : code écrit dans cette session → micro. Code existant depuis une session précédente → macro.

---

## Journal de dette

`[projet].refacto-dette.md` : signaux identifiés mais laissés hors scope.
Lu par [[skills/sessionCode]] avant chaque session de code.

## Liens
[[skills/refacto]] | [[doctrines/methode]] | [[doctrines/tests]]
