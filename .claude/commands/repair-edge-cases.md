# /repair-edge-cases — Correction des chemins non gérés

Tu prends la liste produite par `/code-review-edge-cases` et tu corriges chaque cas non géré, un par un, dans l'ordre de priorité.

Ce skill ne détecte pas. Il répare.

---

## Quand lancer /repair-edge-cases

Immédiatement après `/code-review-edge-cases`, quand la liste des cas non gérés est prête.

---

## Étape 0 — Input

Tu as besoin de la liste des cas non gérés produite par `/code-review-edge-cases`.

Si la liste n'est pas fournie → arrêt :
> "Lance `/code-review-edge-cases` d'abord pour obtenir la liste des cas à corriger."

Tu tris la liste par priorité : CRITIQUE d'abord, MOYEN ensuite, BAS en dernier.

---

## Étape 1 — Traitement cas par cas

Pour chaque cas, dans l'ordre de priorité :

**Présentation du cas :**
> "Cas [N]/[total] — [priorité]
> Fichier : [fichier:ligne]
> Fonction : [nom de la fonction]
> Chemin non géré : [condition] → [ce qui se passe actuellement]"

**Proposition du handler :**

Tu proposes un handler adapté au contexte. Il y a trois types de réponse possibles pour un cas non géré :

- **Rejet explicite** : valider l'entrée et retourner une erreur claire avant de continuer
- **Valeur par défaut** : si le cas est bénin, définir un comportement par défaut sûr
- **Propagation contrôlée** : attraper l'erreur et la remonter proprement (pas de crash silencieux)

Tu présentes la correction avant de l'appliquer :
> "Proposition : [description de la correction en une ligne]
> ```[code proposé]```
> J'applique ?"

**Attente de validation :** tu n'appliques rien sans accord de Medwin.

**Après application :** tu passes au cas suivant.

---

## Étape 2 — Cas BAS : décision

Pour les cas de priorité BAS :
> "Ce cas est peu probable en production. Deux options :
> 1. On le corrige maintenant (2 lignes max)
> 2. On pose un TODO : `// TODO: edge case — [condition non gérée]`
> Ton choix ?"

---

## Étape 3 — Vérification par les tests

Une fois tous les cas CRITIQUE et MOYEN corrigés :

> "Les corrections sont en place. Pour chaque cas corrigé, il faut un test qui le couvre.
> Lance `/tests` et ajoute un test pour :
> [liste des cas corrigés]"

Tu ne lances pas `/tests` toi-même — tu indiques à Medwin ce qu'il faut couvrir.

---

## Étape 4 — Rapport de clôture

```
--- repair-edge-cases — [feature] — [date] ---

CRITIQUE : [N] cas → [N] corrigés / [N] reportés
MOYEN    : [N] cas → [N] corrigés / [N] reportés
BAS      : [N] cas → [N] corrigés / [N] TODO

Tests à ajouter : [liste des cas corrigés sans test]

Verdict : [prêt pour /code-review-hostil / corrections en attente]
```

---

## Règles

- Un cas à la fois. Jamais deux corrections en parallèle.
- Aucune correction sans avoir expliqué le comportement attendu.
- Un cas BAS non corrigé → toujours un TODO dans le code. Jamais laissé silencieux.
- Si une correction introduit une nouvelle branche → signaler immédiatement (nouveau chemin potentiellement non géré).
