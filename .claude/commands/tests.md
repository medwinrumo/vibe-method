# /tests — Générer et faire tourner les tests d'une feature

Tu génères les tests unitaires et d'intégration d'une feature depuis ses specs Gherkin.
Tu fais tourner les tests et tu signales ce qui échoue.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La feature testée** — la même feature dont les specs viennent d'être rédigées avec `/specs`
3. **Les specs de la feature** — dans `[projet].spec` (Notion) ou collées ici
4. **Le code de la feature** — déjà implémenté dans le module concerné

Si les specs sont absentes → tu t'arrêtes :
> "Pour générer les tests, j'ai besoin des specs Gherkin de la feature. Lance `/specs` d'abord."

Si le code est absent → tu t'arrêtes :
> "La feature n'est pas encore implémentée. Les tests se génèrent après le code."

---

## Étape 1 — Analyse des specs

Tu lis les specs Gherkin et tu identifies :
- Les fonctions à tester en unit test
- Les interactions entre modules à tester en integration test
- Le nombre de scénarios → un test par scénario

Tu présentes l'analyse :
> "Pour cette feature, je vais générer :
> - [N] unit tests — fonctions concernées : [liste]
> - [N] integration tests — interactions : [liste]
>
> Chaque scénario Gherkin aura un test correspondant. On continue ?"

---

## Étape 2 — Génération des unit tests

Pour chaque fonction impliquée dans la feature, tu génères les tests unitaires.

Règles :
- Un test par scénario Gherkin
- Chaque test est indépendant — pas de dépendance entre tests
- Les données de test sont isolées (pas de vraie base de données)
- Nommage explicite : `"[comportement attendu] quand [condition]"`

```javascript
// Exemple
test("retourne un hash valide quand le mot de passe est correct", () => {
  const hash = hashPassword("monmotdepasse")
  expect(hash).toHaveLength(60)
  expect(hash).not.toBe("monmotdepasse")
})

test("lève une erreur quand le mot de passe est vide", () => {
  expect(() => hashPassword("")).toThrow("Mot de passe requis")
})
```

---

## Étape 3 — Génération des integration tests

Pour chaque interaction entre modules identifiée à l'étape 1, tu génères les tests d'intégration.

Règles :
- On teste le comportement observable, pas l'implémentation interne
- On utilise une base de données de test — jamais la base de production
- On nettoie les données après chaque test

```javascript
// Exemple
test("l'utilisateur est créé en base après inscription réussie", async () => {
  const result = await createUser("test@test.com", "motdepasse")
  const userInDb = await db.findUserByEmail("test@test.com")
  expect(userInDb).toBeDefined()
  expect(userInDb.email).toBe("test@test.com")
  await db.deleteUser(userInDb.id) // nettoyage
})
```

---

## Étape 4 — Vérification de la couverture

Avant de lancer les tests, tu vérifies que chaque scénario Gherkin a un test correspondant.

Tu présentes la correspondance :
> "Couverture :
> - Scénario 'Connexion réussie' → test ✅
> - Scénario 'Mot de passe incorrect' → test ✅
> - Scénario 'Compte bloqué après 3 tentatives' → test ✅
>
> Tous les scénarios sont couverts. Je lance les tests."

Si un scénario n'a pas de test → tu le génères avant de continuer.

---

## Étape 5 — Exécution des tests

Tu lances les tests et tu rapportes les résultats.

**Si tous les tests passent :**
> "Tous les tests passent ✅ — [N] unit tests, [N] integration tests. La feature est validée."

**Si des tests échouent :**
Tu listes les échecs avec le diagnostic :
> "Tests échoués :
> - [nom du test] — attendu [X], reçu [Y]
> - [nom du test] — [erreur]
>
> Cause probable : [analyse]. Je corrige ?"

Tu corriges le code (pas les tests) et tu relances jusqu'à ce que tout passe.

---

## Ton

Direct. Les tests ne mentent pas — si ça échoue, il y a un problème dans le code, pas dans les tests. Tu corriges le code pour faire passer les tests, jamais l'inverse.
