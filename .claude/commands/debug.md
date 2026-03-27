# /debug — Diagnostic et résolution de bug

Tu es déclenché automatiquement par `/recette` quand un bug est détecté sur une recette.
Tu collectes les informations, tu tentes la résolution en deux passes, tu lances une web search si nécessaire.

Doctrine de référence : `tests.md`

---

## Déclenchement

Ce skill est activé automatiquement par `/recette` dès qu'un ❌ est signalé.
Il ne se lance pas seul — il fait partie du flow de validation.

---

## Étape 1 — Questionnaire de diagnostic

Tu rappelles le contexte et tu collectes les informations nécessaires.

> "Bug détecté sur la Recette [N]-[M].
>
> **Scénario concerné :**
> Étant donné [contexte]
> Lorsque [action]
> Alors [résultat attendu]
>
> **Pour diagnostiquer, j'ai besoin de :**
> 1. Qu'est-ce qui s'est passé à la place du résultat attendu ?
> 2. C'est reproductible ? (oui / non / parfois)
> 3. Navigateur + OS + appareil ? (ex : Chrome 123 / Mac / desktop)
> 4. Tu as une capture d'écran ou un fichier ? (joint-le directement ici si oui)
> 5. Tu vois un message d'erreur quelque part ? (console du navigateur, alerte, page blanche — copie-colle)"

Tu attends les réponses avant de proposer quoi que ce soit.

---

## Étape 2 — Tentative 1

Avec les informations collectées, tu analyses le code concerné et tu proposes une correction.

Tu expliques brièvement ce que tu as identifié et ce que tu changes.

> "Voilà ce que je corrige : [explication concise]. Reteste la Recette [N]-[M] et dis-moi le résultat."

Tu attends le retour de Medwin.

**Si ✅ :** bug résolu → tu le confirmes et tu signales à `/recette` de reprendre.
**Si ❌ :** tu passes à la tentative 2.

---

## Étape 3 — Tentative 2

Tu changes d'angle. Tu ne répètes pas la même approche. Tu relis le code depuis le début du flux concerné pour identifier ce que tu as manqué.

> "La première correction n'a pas suffi. Voilà ce que j'examine maintenant : [explication]. Correction appliquée — reteste."

Tu attends le retour de Medwin.

**Si ✅ :** bug résolu → tu le confirmes et tu signales à `/recette` de reprendre.
**Si ❌ :** tu passes à la web search.

---

## Étape 4 — Web search automatique

Après deux tentatives infructueuses, tu lances une recherche web sans attendre que Medwin te le demande.

> "Deux tentatives sans succès. Je lance une recherche web pour trouver des solutions connues à ce type de bug."

Tu recherches :
- La description précise du comportement observé + le framework/outil concerné
- Les bonnes pratiques pour ce type de feature si l'approche actuelle semble incorrecte

Tu présentes ce que tu as trouvé et tu proposes une troisième correction basée sur les résultats.

> "Voilà ce que j'ai trouvé : [source + résumé]. Correction appliquée — reteste."

Tu attends le retour de Medwin.

**Si ✅ :** bug résolu → tu le confirmes et tu signales à `/recette` de reprendre.
**Si ❌ :** bug déclaré bloquant.

---

## Étape 5 — Bug bloquant

Si le bug persiste après trois tentatives (2 passes + web search), tu le déclares bloquant.

> "Ce bug résiste aux tentatives de correction. Statut : bloquant.
>
> Recette [N]-[M] ne peut pas être validée en l'état.
> La recette est suspendue. Options :
> - Changer d'approche technique (nouvelle session dédiée)
> - Contourner temporairement si la feature n'est pas critique pour la phase
>
> Que veux-tu faire ?"

Tu ne continues pas la recette sans une décision explicite de Medwin.

---

## Règles

- Tu corriges toujours le code, jamais les tests ni les recettes
- Chaque tentative doit être différente — jamais répéter la même correction
- Tu expliques ce que tu fais avant de le faire — pas de modification silencieuse
- Tu rappelles toujours le numéro de la recette concernée et le scénario Gherkin en début de diagnostic
- Après résolution, tu passes la main à `/recette` qui reprend à la recette suivante

---

## Ton

Calme et méthodique. Les bugs font partie du process — ce n'est pas un échec, c'est une étape. Tu diagnostiques avant de corriger, tu expliques avant d'agir, tu valides avant de continuer.
