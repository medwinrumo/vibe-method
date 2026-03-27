# /tests — Générer et faire tourner les tests d'une feature

Tu génères les tests unitaires, d'intégration et Playwright d'une feature depuis ses specs.
Tu fais tourner les tests, tu corriges ce qui échoue, tu signales ce qui bloque.

Doctrine de référence : `tests.md`

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La feature testée** — la même feature dont les specs viennent d'être rédigées avec `/specs`
3. **Les User Stories de la feature** — dans `[projet].spec.md` du repo projet
4. **Le cahier de recettes** — dans `[projet].recette.md` du repo projet (pour les scénarios Gherkin)
5. **Le code de la feature** — déjà implémenté dans le module concerné

Si les User Stories sont absentes → tu t'arrêtes :
> "Pour générer les tests, j'ai besoin des User Stories de la feature. Lance `/specs` d'abord."

Si le cahier de recettes est absent → tu t'arrêtes :
> "Pour générer les tests Playwright, j'ai besoin des scénarios Gherkin. Lance `/recette` d'abord pour générer le cahier."

Si le code est absent → tu t'arrêtes :
> "La feature n'est pas encore implémentée. Les tests se génèrent après le code."

---

## Étape 1 — Analyse

Tu lis les User Stories et les scénarios Gherkin. Tu identifies :
- Les fonctions à tester en unit test
- Les interactions entre modules à tester en integration test
- Les scénarios Gherkin à couvrir avec Playwright

Tu présentes l'analyse :
> "Pour cette feature, je vais générer :
> - [N] unit tests — fonctions concernées : [liste]
> - [N] integration tests — interactions : [liste]
> - [N] tests Playwright — un par scénario Gherkin
>
> On continue ?"

---

## Étape 2 — Génération des unit tests

Pour chaque fonction impliquée dans la feature, tu génères les tests unitaires.

**Règles anti-auto-validation :**
- Les tests unitaires sont générés dans un contexte séparé de la génération du code — jamais dans le même prompt
- Tu génères des tests positifs (happy path) ET des tests négatifs (inputs incorrects, cas limites, actions interdites)
- Les données de test représentent de vrais cas d'usage — jamais des données choisies pour garantir que les tests passent

Règles de forme :
- Un test par scénario
- Chaque test est indépendant — pas de dépendance entre tests
- Les données de test sont isolées (pas de vraie base de données)
- Nommage explicite : `"[comportement attendu] quand [condition]"`

---

## Étape 3 — Génération des integration tests

Pour chaque interaction entre modules identifiée à l'étape 1, tu génères les tests d'intégration.

Règles :
- On teste le comportement observable, pas l'implémentation interne
- On utilise une base de données de test — jamais la base de production
- On nettoie les données après chaque test
- Tests négatifs obligatoires : que se passe-t-il si un module appelle l'autre avec des données incorrectes ?

---

## Étape 4 — Audit et auto-évaluation

Avant d'exécuter quoi que ce soit, tu relis les tests générés aux étapes 2 et 3 et tu réponds à ces deux questions :

1. "Les données utilisées dans ces tests représentent-elles de vrais cas d'usage, ou garantissent-elles simplement que les tests passent ?"
2. "Quels scénarios ces tests ne couvrent-ils pas ?"

Si tu identifies des angles morts → tu génères les tests manquants avant de continuer.

---

## Étape 5 — Génération des tests Playwright

Pour chaque scénario Gherkin dans `[projet].recette.md`, tu génères un test Playwright correspondant.

Règles :
- Un scénario Gherkin = un test Playwright
- Le test simule les actions exactes décrites dans le Gherkin (navigation, clics, saisies)
- Les tests couvrent le happy path ET les cas limites — chaque scénario Gherkin a son test
- Mode headless par défaut (pas d'affichage du navigateur)

**Vérification de couverture :** avant de lancer, tu vérifies explicitement que chaque scénario Gherkin a un test Playwright. Si un scénario n'a pas de test → tu le génères avant de continuer.

---

## Étape 6 — Non-régression

Tu lances la batterie Playwright complète — pas seulement les tests de la nouvelle feature, mais tous les tests Playwright existants.

Objectif : vérifier que la nouvelle feature n'a pas cassé une feature précédente.

Si des tests d'une autre feature échouent → tu signales immédiatement :
> "La feature [X] régresse — [description de l'échec]. Je traite ça avant de continuer."

Tu corriges et relances jusqu'à ce que toute la batterie passe.

---

## Étape 7 — Exécution des unit tests et integration tests

Tu lances les tests unitaires et d'intégration de la nouvelle feature.

**Si tous les tests passent :**
> "Tous les tests passent ✅ — [N] unit tests, [N] integration tests, [N] tests Playwright. La feature est prête pour la recette manuelle."

**Si des tests échouent :**
Tu listes les échecs avec le diagnostic et tu corriges le code (pas les tests), puis tu relances.

Règle absolue : on ne modifie jamais un test pour le faire passer. On corrige le code.

---

## Étape 8 — Mise à jour du fichier de tests

Tu mets à jour `[projet].tests.md` dans le repo du projet avec :
- La liste des tests générés pour cette feature
- Le résultat de la batterie de non-régression
- La date d'exécution

---

## Ton

Direct. Les tests ne mentent pas — si ça échoue, il y a un problème dans le code. Tu corriges le code pour faire passer les tests, jamais l'inverse. Tu signales clairement ce qui échoue et pourquoi avant de corriger.
