# /prd-validate — Validation du PRD avant architecture

Tu lis le PRD et tu valides qu'il est complet, cohérent et traçable avant de passer à `/archi`.

C'est le gate entre "ce qu'on veut faire" et "comment on le construit".

---

## Quand lancer /prd-validate

Après `/prd` ou `/prd-update`, avant `/archi`. Si le PRD a des blockers → retour à `/prd` ou `/prd-update`.

---

## Étape 0 — Input

Tu lis `[projet].prd.md`.
Si absent → arrêt :
> "Pas de PRD trouvé. Lance `/prd` d'abord."

---

## Étape 1 — Complétude

Tu vérifies que le PRD couvre les 8 zones essentielles :

| Zone | Présent ? |
|---|---|
| Contexte / problème à résoudre | ✅ / ❌ |
| Utilisateurs cibles | ✅ / ❌ |
| Fonctions V1 listées | ✅ / ❌ |
| Critère de succès par fonction | ✅ / ❌ |
| Contraintes techniques | ✅ / ❌ |
| Non-fonctions (ce qu'on ne fait pas) | ✅ / ❌ |
| Risques identifiés | ✅ / ❌ |
| Niveau de risque sécurité | ✅ / ❌ |

---

## Étape 2 — Traçabilité

Pour chaque fonction listée :
- A-t-elle un critère de succès clair (comment savoir que c'est terminé ?) → ✅ / ❌
- Est-elle cohérente avec le problème annoncé → ✅ / ❌
- Y a-t-il une fonction qui se chevauche ou fait doublon avec une autre → ✅ / ❌

---

## Étape 3 — Cohérence interne

- Les fonctions V1 sont-elles réalistes ensemble (pas de contradiction) ?
- Y a-t-il des prérequis entre fonctions non mentionnés ?
- Le "non-fonctions" n'est-il pas en contradiction avec une fonction listée ?

---

## Étape 4 — Rapport de validation

```
--- Validation PRD — [nom du projet] ---

Complétude     : [N]/8 zones présentes
Traçabilité    : [N]/[N] fonctions avec critère de succès
Cohérence      : [OK / N problèmes identifiés]

Blockers (à corriger avant /archi) :
  — [zone manquante ou problème bloquant]

Warnings (à surveiller en cours d'archi) :
  — [point à clarifier]

Verdict : GO / BLOCKERS
```

**Si BLOCKERS** → arrêt, retour à `/prd` ou `/prd-update`. Ne pas passer à `/archi` avec un PRD incomplet.

**Si GO** :
> "PRD validé. Lance `/gherkin` en Mode PRD pour vérifier que chaque feature peut s'écrire en scénarios clairs — puis `/archi`. Les Warnings sont à traiter comme 'Points ouverts' dans `[projet].archi.md`."

---

## Règles

- Un PRD avec Blockers ne passe pas à `/archi`
- Les Warnings sont copiés dans la section "Points ouverts" de `[projet].archi.md`
- Si le PRD a déjà été validé sans modification depuis → le signaler et ne pas relancer la validation complète
