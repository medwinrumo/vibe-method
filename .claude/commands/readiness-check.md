# /readiness-check — Gate de readiness avant développement

Tu vérifies que tous les artefacts nécessaires sont présents, cohérents et complets avant de lancer la première session de code. C'est le gate entre "on a conçu" et "on code".

Si quelque chose manque → arrêt avec rapport clair. Ne pas coder sur des fondations instables.

---

## Quand lancer /readiness-check

Avant `/setup` ou le premier `/sessionCode` d'un projet. Une seule fois au lancement — ou après un changement majeur d'artefact (ex : refonte de l'archi).

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — PRD

Tu lis `[projet].prd.md`.

| Vérification | Résultat |
|---|---|
| Fichier présent | ✅ / ❌ |
| PRD validé par `/prd-validate` (mention dans le fichier) | ✅ / ❌ / ⚠️ non vérifiable |
| Features V1 listées et numérotées | ✅ / ❌ |
| Critères de succès par feature | ✅ / ❌ |

---

## Étape 2 — Architecture

Tu lis `[projet].archi.md`.

| Vérification | Résultat |
|---|---|
| Fichier présent | ✅ / ❌ |
| Chaque feature V1 du PRD est couverte par un module | ✅ / ❌ |
| Règles silo documentées | ✅ / ❌ |
| Niveau de risque sécurité défini | ✅ / ❌ |
| ADR présent si décisions contestables | ✅ / ❌ / N/A |

Cas manquant : feature dans PRD mais sans module dans archi → **Blocker**.

---

## Étape 3 — Specs

Tu lis tous les fichiers `[projet].spec.*.md` présents.

Pour chaque feature V1 du PRD :
- Fichier spec correspondant présent → ✅ / ❌
- User Stories présentes dans la spec → ✅ / ❌

Si une feature V1 n'a pas de spec → **Blocker** (lance `/specs` d'abord).

---

## Étape 4 — Project context

Tu lis `[projet].project-context.md`.

| Vérification | Résultat |
|---|---|
| Fichier présent | ✅ / ❌ (Warning si absent) |
| Règles LLM-spécifiques au projet documentées | ✅ / ❌ / N/A |

Si absent → **Warning** (recommandé mais pas bloquant — lance `/project-context` avant le premier `/sessionCode`).

---

## Étape 5 — PRP

Tu lis `[projet].prp.md`.

| Vérification | Résultat |
|---|---|
| Fichier présent | ✅ / ❌ |
| Règles silo présentes | ✅ / ❌ |
| Stack documentée | ✅ / ❌ |

Si absent → **Blocker** (lance `/prp` d'abord).

---

## Étape 6 — Sprint status

Tu lis `[projet].sprint-status.yaml`.

| Vérification | Résultat |
|---|---|
| Fichier présent | ✅ / ❌ (Warning si absent) |
| Features V1 listées dans le fichier | ✅ / ❌ |
| Statuts initiaux définis | ✅ / ❌ |

Si absent → **Warning** (lance `/sprint-status` pour l'initialiser).

---

## Étape 7 — Rapport de readiness

```
--- Readiness Check — [nom du projet] ---

PRD          : [✅ complet / ❌ BLOCKER : ...]
Architecture : [✅ couvre toutes les features / ❌ BLOCKER : ...]
Specs        : [N]/[N] features ont une spec / ❌ BLOCKER : features sans spec : ...]
Project ctx  : [✅ présent / ⚠️ absent — recommandé]
PRP          : [✅ présent / ❌ BLOCKER]
Sprint status: [✅ initialisé / ⚠️ absent — recommandé]

Blockers     : [N] — à corriger avant /sessionCode
Warnings     : [N] — à traiter rapidement

Verdict : GO / BLOCKERS
```

---

## Règles

- **BLOCKERS** → arrêt. Ne pas lancer `/sessionCode` avant résolution.
- **WARNINGS** → ne bloquent pas mais doivent être traités avant la fin de la première session.
- Si GO → :
  > "Projet prêt. Tu peux lancer `/sessionCode`. Les Warnings sont à traiter cette semaine."
- Ce check ne remplace pas `/prd-validate` — `/prd-validate` valide le contenu du PRD, ce check valide la présence et la cohérence des artefacts.
