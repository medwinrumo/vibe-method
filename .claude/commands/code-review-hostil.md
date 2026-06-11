# /code-review-hostil — Revue de code hostile

Tu assumes que le code est cassé. Ton rôle est de trouver ce qui ne va pas — pas de valider ce qui marche.

Ce n'est pas une revue de courtoisie. C'est une attaque structurée sur le code. Si le code tient, tant mieux. S'il ne tient pas, mieux vaut le savoir maintenant.

Minimum 10 problèmes. Si tu en trouves moins, tu n'as pas regardé assez fort.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Quand lancer /code-review-hostil

Après `/code-review` et `/code-review-edge-cases`, avant `/tests`. Sur un module critique ou avant un merge sur `main`. Peut aussi être déclenché à la demande sur n'importe quel fichier.

---

## Étape 0 — Périmètre

Tu demandes si aucun fichier n'est précisé :
> "Quel fichier ou module veux-tu soumettre à la revue adversariale ?"

Tu lis tous les fichiers du périmètre.

---

## Étape 1 — Angle 1 : Sécurité offensive

Tu assumes qu'un attaquant a accès à l'input utilisateur. Tu cherches :

- Injection (SQL, commande, template, path traversal)
- Fuite de données (logs, réponses d'erreur, headers)
- Contournement d'authentification (bypass de middleware, token non vérifié)
- Contournement d'autorisation (accès à des ressources d'autres utilisateurs)
- Secrets dans le code ou les variables d'environnement front

Pour chaque problème trouvé → noter `[fichier:ligne] — [description du vecteur d'attaque]`

---

## Étape 2 — Angle 2 : Logique métier inversée

Tu assumes que les règles métier sont mal implémentées. Tu cherches :

- Conditions inversées (vrai quand faux, faux quand vrai)
- Opérateurs de comparaison incorrects (`>` au lieu de `>=`, `===` au lieu de `==`)
- Ordre d'opérations problématique (vérification après usage, init après utilisation)
- Cas limites de la logique métier non gérés (que se passe-t-il à zéro, à la limite, au maximum ?)

---

## Étape 3 — Angle 3 : Gestion des erreurs

Tu assumes que tout va échouer. Tu cherches :

- Exceptions non catchées
- Erreurs silencieuses (catch vide, erreur ignorée)
- Messages d'erreur qui exposent des informations sensibles (stack traces, chemins de fichiers, requêtes SQL)
- Absence de cleanup en cas d'erreur (connexions ouvertes, transactions non rollbackées, fichiers temporaires)
- Codes de retour HTTP incorrects (200 sur une erreur, 500 pour une validation utilisateur)

---

## Étape 4 — Angle 4 : État et concurrence

Tu assumes que plusieurs utilisateurs frappent le code en même temps. Tu cherches :

- Race conditions (opération read-modify-write non atomique)
- État partagé mutable (variables globales modifiées, caches incorrectement partagés)
- Opérations non-idempotentes appelées plusieurs fois (création en double, débit en double)
- Absence de gestion du cas "déjà fait" pour les opérations critiques

---

## Étape 5 — Angle 5 : Données et validation

Tu assumes que les inputs sont malformés. Tu cherches :

- Absence de validation côté serveur (validation uniquement front)
- Types non vérifiés (string reçue au lieu d'int, null non géré)
- Longueurs non bornées (champ texte sans limite, tableau sans limite)
- Encodages non gérés (UTF-8, caractères spéciaux, emoji)
- Données nullable utilisées sans vérification préalable

---

## Étape 6 — Angle 6 : Dépendances et couplage

Tu assumes que les dépendances externes vont changer ou tomber. Tu cherches :

- Appels externes sans timeout
- Absence de gestion du cas "service indisponible"
- Couplage fort à une implémentation spécifique (difficile à remplacer)
- Version de dépendance non fixée (peut casser sur mise à jour)
- Import de modules internes depuis des couches qui ne devraient pas y accéder (violation silo)

---

## Étape 7 — Angle 7 : Performance

Tu assumes que ce code tourne sous charge. Tu cherches :

- N+1 queries (boucle avec requête DB à chaque itération)
- Chargement de données inutiles (SELECT * quand 2 colonnes suffisent)
- Calculs redondants (résultat recalculé à chaque appel)
- Absence de pagination sur une liste potentiellement grande
- Opérations synchrones bloquantes dans un contexte asynchrone

---

## Étape 8 — Angle 8 : Tests et observabilité

Tu assumes que ce code va tomber en prod et que personne ne saura pourquoi. Tu cherches :

- Chemins critiques sans test
- Assertions de test trop larges (vérifient que "quelque chose a marché" sans vérifier le résultat exact)
- Absence de logging sur les opérations critiques (authentification, paiement, modification de données)
- Logs insuffisants pour diagnostiquer un bug en prod

---

## Étape 9 — Angle 9 : Maintenabilité et dette

Tu assumes que quelqu'un d'autre va maintenir ce code dans 6 mois. Tu cherches :

- Logique dupliquée (même calcul ou même vérification en 2 endroits)
- Noms trompeurs (variable `isActive` qui contient un entier, fonction `getUser` qui modifie un état)
- Constantes magiques non expliquées (pourquoi 86400 ? pourquoi 3 tentatives ?)
- Complexité cyclomatique excessive (fonction qui fait trop de choses)
- Dead code (code jamais atteint, variables jamais utilisées)

---

## Étape 10 — Angle 10 : Conformité et contrat

Tu assumes que le code ne respecte pas ce qui a été spécifié. Tu cherches :

- Divergences avec la spec (`[projet].spec.[feature].md`) — comportement implémenté ≠ comportement spécifié
- Divergences avec l'archi (`[projet].archi.md`) — violation des règles silo, des patterns obligatoires
- Divergences avec le project-context (`[projet].regles.md`) — patterns interdits utilisés, patterns obligatoires absents
- RGPD : données personnelles collectées sans justification, stockées sans nécessité, non supprimables

---

## Étape 11 — Rapport

```
--- Revue Adversariale — [fichier(s)] ---

Angle 1  Sécurité       : [N] problèmes
Angle 2  Logique        : [N] problèmes
Angle 3  Erreurs        : [N] problèmes
Angle 4  Concurrence    : [N] problèmes
Angle 5  Données        : [N] problèmes
Angle 6  Dépendances    : [N] problèmes
Angle 7  Performance    : [N] problèmes
Angle 8  Observabilité  : [N] problèmes
Angle 9  Maintenabilité : [N] problèmes
Angle 10 Conformité     : [N] problèmes

Total : [N] problèmes identifiés
```

Pour chaque problème :

```
[BLOQUANT / IMPORTANT / À SURVEILLER]
Angle [N] — [fichier:ligne]
Problème : [description du problème]
Risque    : [ce qui peut arriver si non corrigé]
Fix       : [correction proposée — courte]
```

**BLOQUANT** : doit être corrigé avant le merge.
**IMPORTANT** : doit être corrigé cette semaine.
**À SURVEILLER** : à noter, non bloquant immédiatement.

---

## Règles

- Minimum 10 problèmes. Si tu en trouves moins de 10, tu n'as pas regardé assez fort — revenir sur les angles où tu as trouvé zéro.
- Si vraiment le code est irréprochable sur un angle → le noter explicitement : "Angle 3 — Aucun problème trouvé après analyse complète."
- Tu ne valides pas le code — tu cherches des problèmes. La validation se fait dans `/code-review`.
- Chaque problème a un fichier et une ligne. Les problèmes génériques sans localisation ne comptent pas.
- Les problèmes BLOQUANT bloquent le merge. Point.

---

## Prochaine étape

`/tests` — la revue hostile est passée, générer et faire tourner les tests.
