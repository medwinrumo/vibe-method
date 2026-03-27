# tests.md

Doctrine de test — principes, niveaux et règles à appliquer dans tous les projets vibe-method.
À enrichir au fil des sessions.

---

## Principe fondamental

Tester, c'est vérifier que ce qui a été produit correspond à ce qui a été demandé.
Il y a deux dimensions à vérifier : que ça **fonctionne** techniquement, et que c'est **correct** du point de vue de l'utilisateur. Ces deux dimensions ne se confondent pas — une feature peut fonctionner et être mauvaise, ou être bien conçue et contenir un bug.

---

## Les trois niveaux de tests

### Niveau 1 — Tests unitaires et d'intégration

Tests au niveau du code, exécutés automatiquement.

**Tests unitaires** — vérifient qu'une fonction isolée produit le bon résultat pour des entrées données. Exemple : la fonction `calculerTotal(articles, remise)` avec 3 articles à 10€ et une remise de 10% doit retourner 27€. Rien d'autre n'est testé — pas l'interface, pas la base de données.

**Tests d'intégration** — vérifient que deux modules fonctionnent correctement ensemble. Exemple : le module panier communique-t-il correctement avec le module paiement ?

Outil de référence : **Vitest** (projets Vite/React).

Ces tests sont exécutés via `/tests` immédiatement après le développement d'une feature, avant toute validation manuelle.

### Niveau 2 — Tests automatisés d'interface (E2E)

Un programme simule les actions d'un utilisateur réel dans un navigateur : navigation, clics, saisies, soumissions de formulaires. Le programme prend des captures d'écran et peut enregistrer une vidéo de l'exécution.

Outil de référence : **Playwright**.

Ces tests sont générés depuis les scénarios Gherkin du cahier de recettes. Ils sont exécutés automatiquement avant la validation manuelle finale.

**Test de non-régression** — après chaque nouvelle feature, toute la batterie Playwright existante est relancée pour vérifier que rien n'a été cassé dans les features précédentes.

Intégration CI/CD possible : Playwright peut être intégré dans GitHub Actions pour bloquer automatiquement un déploiement si des tests échouent.

### Niveau 3 — Recette manuelle

Validation humaine en conditions réelles. C'est le dernier filtre — celui que l'automatisation ne peut pas remplacer.

L'automatisation vérifie que ça fonctionne techniquement. La recette manuelle vérifie que c'est correct du point de vue de l'expérience utilisateur : cohérence visuelle, fluidité, logique de navigation, ressenti global.

Exécutée via `/recette`.

---

## Ordre d'exécution dans un projet

```
1. Feature développée
2. /tests        → tests unitaires + intégration
3. /tests        → non-régression (batterie Playwright sur les features existantes)
4. /recette      → génération du cahier de recettes (Gherkin depuis User Stories)
5. /tests        → Playwright sur la nouvelle feature → exécution auto → corrections
6. /recette      → validation manuelle finale (cahier complet présenté)
```

Les étapes 2, 3 et 5 filtrent les bugs avant que l'humain intervienne. L'humain arrive en dernier, avec le meilleur contexte possible, pour valider ce que l'automatisation ne peut pas juger.

---

## Gherkin — format de référence

Le Gherkin est le format standard pour décrire les scénarios de test. Il est le miroir opérationnel de la User Story : la User Story dit ce qu'on veut construire, le Gherkin dit comment on vérifie que c'est construit correctement.

**Les Gherkin sont générés par `/recette` à partir des User Stories, et stockés uniquement dans `[projet].recette.md`.** Ils ne figurent pas dans les specs.

Format :
```
Étant donné [contexte initial — qui est l'utilisateur, dans quel état est le système]
Lorsque [action de l'utilisateur]
Alors [résultat attendu — ce qui doit se passer]
```

Exemple (feature de connexion) :
```
Étant donné que je suis sur la page de connexion et que j'ai un compte actif
Lorsque je saisis mon email et mon mot de passe corrects et que je clique sur "Se connecter"
Alors je suis redirigé vers mon tableau de bord et mon prénom apparaît dans la navigation
```

Il y a autant de scénarios Gherkin que de User Stories — plus les cas limites associés à chacune.

---

## Edge cases — ne jamais faire confiance à l'utilisateur

Chaque feature doit être testée au-delà du parcours heureux. Les cas limites à couvrir systématiquement :

- Champs vides soumis
- Caractères spéciaux (apostrophes, accents, symboles monétaires)
- Espaces en début ou fin de champ
- Type de données incorrect (texte là où un nombre est attendu)
- Actions hors séquence (accéder à une page protégée sans être connecté)
- Mauvais identifiants, mauvais mot de passe
- Valeurs extrêmes (nombre très grand, chaîne très longue)

Chaque cas limite a son propre scénario Gherkin dans le cahier de recettes.

---

## Anti-auto-validation

L'IA a tendance à générer des tests qui passent toujours, parce qu'elle choisit des données qui garantissent le succès. Ces tests ne détectent rien.

**Règle a — Séparer la génération du code et la génération des tests**

Ne jamais demander en un seul prompt "développe cette feature ET écris les tests". D'abord le code. Ensuite, dans un contexte séparé, les tests.

**Règle c — Demander explicitement des tests négatifs**

Toujours inclure dans la demande de génération : "Génère également des scénarios qui doivent échouer — inputs incorrects, cas limites, actions non autorisées. Les tests doivent vérifier que l'application rejette correctement ces cas, pas seulement qu'elle les accepte."

---

## Audit et auto-évaluation

Après génération des tests, avant exécution, poser systématiquement ces deux questions à l'IA :

1. "Relis ces tests. Les données que tu as utilisées représentent-elles de vrais cas d'usage, ou garantissent-elles simplement que les tests passent ?"
2. "Quels scénarios ces tests ne couvrent-ils pas ?"

Ces deux questions forcent l'identification des angles morts avant qu'ils deviennent des bugs en production.

---

## Couverture fonctionnelle

Avant de valider la batterie de tests Playwright, vérifier que chaque scénario Gherkin du cahier de recettes a un test automatisé correspondant.

Règle : **un scénario Gherkin = un test Playwright**.

Si un scénario n'a pas de test → le générer avant de continuer.

---

## Outils de référence

| Outil | Usage |
|---|---|
| Vitest | Tests unitaires et d'intégration |
| Playwright | Tests d'interface automatisés (E2E) |
| GitHub Actions | CI/CD — intégration des tests dans le pipeline de déploiement |

---

## Remontée de bug

Quand un bug est détecté lors de la recette manuelle, le skill `/debug` est déclenché automatiquement. Il collecte les informations nécessaires via un questionnaire structuré, tente la résolution en deux passes, puis lance une recherche web si le bug persiste.

Un bug non résolu est bloquant : la recette ne peut pas continuer tant qu'il n'est pas corrigé.

Doctrine de debug : intégrée au skill `/debug`.
