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

## Étape 3 — Tests ciblés sur les cas corrigés

Une fois tous les cas CRITIQUE et MOYEN corrigés, tu génères un test unitaire par cas corrigé.

**Pourquoi pas `/tests` ?** `/tests` génère des tests depuis les specs et les scénarios Gherkin. Les cas corrigés ici ne sont pas dans les specs — ils n'y seraient pas détectés. Il faut des tests ciblés écrits directement.

Pour chaque cas corrigé, tu génères un test de la forme :

```
"[comportement attendu] quand [condition qui était non gérée]"
```

Exemple :
```javascript
it("retourne une erreur explicite quand email est null", () => {
  const résultat = connexion(null, "motDePasse")
  expect(résultat.erreur).toBe("Email requis")
})
```

Règles :
- Un test par cas corrigé — pas de regroupement
- Le test doit échouer si on supprime le handler ajouté — sinon il ne teste rien
- Tu présentes chaque test avant de l'écrire :
  > "Test pour le cas [N] — [condition]. J'écris ?"

Tu lances les tests après chaque écriture :
> "Test écrit. Je lance pour vérifier qu'il passe ?"

Si un test échoue → le handler est mal implémenté. Tu corriges le handler, pas le test.

---

## Étape 4 — Re-détection sur le code modifié

Après que tous les tests des cas corrigés passent :

> "Les corrections introduisent du nouveau code. Je relance `/code-review-edge-cases` sur les fichiers modifiés pour vérifier qu'aucun nouveau chemin non géré n'a été introduit."

Tu relances `/code-review-edge-cases` uniquement sur les fichiers touchés par les corrections.

- Si nouveaux cas non gérés détectés → tu les ajoutes à la liste et tu repars à l'Étape 1 pour les traiter.
- Si aucun nouveau cas → tu passes au rapport.

---

## Étape 5 — Rapport de clôture

```
--- repair-edge-cases — [feature] — [date] ---

CRITIQUE : [N] cas → [N] corrigés / [N] reportés
MOYEN    : [N] cas → [N] corrigés / [N] reportés
BAS      : [N] cas → [N] corrigés / [N] TODO

Tests écrits   : [N] tests — tous passants
Re-détection   : [aucun nouveau cas / N nouveaux cas traités]

Verdict : [prêt pour /code-review-hostil / corrections en attente]
```

---

## Règles

- Un cas à la fois. Jamais deux corrections en parallèle.
- Aucune correction sans avoir expliqué le comportement attendu.
- Un cas BAS non corrigé → toujours un TODO dans le code. Jamais laissé silencieux.
- Si une correction introduit une nouvelle branche → signaler immédiatement (nouveau chemin potentiellement non géré).

---

## Prochaine étape

`/code-review-hostil` — les cas non gérés sont corrigés, passer la revue hostile.
