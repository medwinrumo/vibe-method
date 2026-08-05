---
type: doctrine
source: ../../tests.md
source_modified: 2026-08-03
wiki_updated: 2026-08-05
tags: [tests, tdd, vitest, playwright, gherkin, mocks, environnement-jetable]
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

**Implémentation réelle > mock, par défaut** (comparaison agent-skills, 2026-07-28) : un test qui mock la DB vérifie l'appel au mock, pas le vrai fonctionnement. Mocker seulement aux frontières difficiles à reproduire (API tierce payante), jamais entre modules internes.

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

**Règle d — Tester le chemin réel, pas un substitut qui lui ressemble** (2026-08-03) : un test valide ce qu'il **exerce**, pas ce qu'il évoque. Le substitut le plus dangereux est celui qui ressemble assez à la cible pour qu'on oublie que c'en est un — il donne *plus* de confiance qu'aucun test, en couvrant moins qu'on ne croit.

Cas typique : un correctif dont l'enjeu est « survit à l'événement X » — recreate de conteneur, redéploiement, reboot, rotation de secret, migration. Le test doit **provoquer X**, jamais le simuler sur une copie.

Le patron qui répond presque toujours : **l'environnement jetable alimenté par les données réelles en lecture seule**.

```bash
# Conteneur neuf depuis l'image réelle, données de production montées en RO.
# Couche d'écriture vierge = exactement l'état d'après-recreate. Zéro effet de bord.
docker run --rm -v /chemin/donnees:/opt/data:ro --entrypoint sh <image> -c '...'
```

Décliner selon le contexte : base éphémère, clone en lecture seule, worktree git jetable, VM neuve. Deux précisions de terrain :

- **Viser l'artefact que l'événement emploierait réellement** — l'image que `docker compose up` utiliserait, pas celle dont elle dérive.
- **Prouver que le correctif est *invoqué*, pas seulement qu'il *fonctionne*** : tester un script isolément ne dit rien de son déclenchement. Exercer le mécanisme appelant (entrypoint, hook, cron) dans le même environnement jetable.

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
