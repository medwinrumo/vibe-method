# /code-review-edge-cases — Chasse aux cas non gérés

Tu énumères mécaniquement tous les chemins possibles dans le code soumis et tu signales UNIQUEMENT ceux qui ne sont pas gérés.

**Règle absolue :** tu ne commentes pas la qualité du code, la structure, le nommage, les performances. Une seule question : "ce chemin existe — est-il géré ?"

---

## Quand lancer /code-review-edge-cases

- Après `/code-review` (revue structurelle + sécurité)
- Avant de passer une fonction en `review` dans le sprint status
- Sur tout code qui traite des entrées utilisateur ou des états multiples

---

## Étape 0 — Input

Tu as besoin :
1. **Le code à analyser** — fichier(s) ou fonction(s) spécifique(s)
2. **La spec de la feature** (`[projet].spec.[feature].md`) — pour savoir ce que le code est censé faire

> "Quel fichier ou quelle fonction tu veux que j'analyse ?"

---

## Étape 1 — Inventaire des entrées

Pour chaque fonction / handler / endpoint, tu listes toutes les entrées possibles :

| Entrée | Type attendu | Valeurs limites à tester |
|---|---|---|
| `email` | string | null, vide `""`, trop long (>255), sans `@`, déjà en base |
| `userId` | string/UUID | null, mauvais format, inexistant en base, appartient à un autre user |
| `amount` | number | null, négatif, zéro, non-entier, très grand, NaN |
| `items[]` | array | vide `[]`, un seul élément, très grand nombre d'éléments, doublons |

Tu présentes cet inventaire avant de continuer :
> "Voici les entrées que j'ai identifiées. Il en manque ?"

---

## Étape 2 — Inventaire des branches

Pour chaque `if / else / switch / try/catch / ternaire / return anticipé` dans le code, tu listes :

- La condition testée
- Ce qui se passe si la condition est vraie
- Ce qui se passe si la condition est fausse
- Ce qui se passe si la condition n'est jamais atteinte

Format :
```
if (user.role === 'admin') → admin : [action]
                           → non-admin : [action]
                           → user.role undefined : [???]
```

---

## Étape 3 — Rapport des cas non gérés

Tu produis UNIQUEMENT la liste des chemins qui mènent à un comportement non défini.

Format :
```
[fichier:ligne] [fonction] — [condition] → NON GÉRÉ
```

Exemples :
```
[auth.ts:42]  validateEmail()    — email null           → NON GÉRÉ (crash probable)
[auth.ts:58]  createUser()       — email déjà en base   → NON GÉRÉ (pas de check unicité)
[auth.ts:71]  createUser()       — email > 255 chars    → NON GÉRÉ (pas de validation longueur)
[orders.ts:30] updateOrder()     — user.id ≠ order.userId → NON GÉRÉ (pas de vérification propriétaire)
```

Si aucun cas non géré → 
> "Aucun chemin non géré identifié. Le code gère tous les cas testés."

---

## Étape 4 — Priorisation

Tu classes chaque cas par impact :

| Priorité | Critère |
|---|---|
| **CRITIQUE** | Peut causer une faille de sécurité ou une corruption de données |
| **MOYEN** | Peut causer une erreur visible pour l'utilisateur |
| **BAS** | Cas théorique peu probable en production |

---

## Étape 5 — Décision

> "[N] cas non gérés : [N] critiques, [N] moyens, [N] bas.
>
> Recommandation : corriger les critiques avant de passer en review.
> On corrige maintenant ?"

Si oui → tu corriges un cas à la fois, en présentant le fix avant de l'appliquer.
Si non → tu listes les cas dans un commentaire `// TODO: edge case` dans le code.

---

## Étape 6 — Handoff vers la correction

Une fois le rapport présenté :

> "Détection terminée. Ce skill s'arrête ici.
> Pour corriger ces cas, lance `/repair-edge-cases` avec cette liste."

Tu ne corriges rien dans ce skill. La détection et la réparation sont deux étapes séparées.

---

## Règles

- Reporter UN cas par ligne — pas de regroupement qui cache des problèmes
- Ne jamais corriger un cas sans expliquer le comportement attendu
- Un cas "non géré" n'est pas forcément un bug — parfois c'est un choix assumé. Demander si c'est le cas avant de forcer une correction.
- Ce skill détecte uniquement. `/repair-edge-cases` répare.

---

## Prochaine étape

`/repair-edge-cases` — les cas non gérés sont identifiés, les corriger un par un dans l'ordre de priorité.
