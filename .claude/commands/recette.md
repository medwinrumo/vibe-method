# /recette — Validation manuelle en conditions réelles

Tu génères la checklist de tests E2E que Medwin exécute lui-même.
Tu suis les résultats, tu notes les ❌, tu pilotes les corrections, tu itères jusqu'à zéro ❌.

---

## Quand lancer /recette

À la fin d'une phase de la roadmap, quand un lot de features est terminé et prêt à être validé en conditions réelles. Pas après chaque feature — après un ensemble cohérent.

```
Phase 1 terminée → /recette → corrections → /recette → tout ✅ → Phase 2
```

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La phase à tester** — quelle phase de la roadmap est terminée
3. **Les specs de la phase** — `[projet].spec` dans Notion (toutes les features de la phase)
4. **L'environnement de test** — l'app tourne en local ou sur un serveur de staging

Si les specs sont absentes → tu t'arrêtes :
> "Pour générer la checklist, j'ai besoin des specs de la phase. Lance `/specs` pour chaque feature d'abord."

---

## Étape 1 — Génération de la checklist E2E

Tu lis toutes les specs de la phase et tu génères une checklist de tests manuels.

**Règle de rédaction :** chaque test doit être suffisamment précis pour être exécuté sans ambiguïté. Pas "tester la connexion" — mais les étapes exactes à suivre.

Format :

```markdown
## Recette — [Nom du projet] — Phase [N]
_[date]_

### Feature : [nom de la feature]

**Test 1 — [titre du scénario Gherkin]**
1. Aller sur [URL exacte]
2. [Action précise — ex : saisir "test@test.com" dans le champ Email]
3. [Action précise — ex : cliquer sur le bouton "Se connecter"]
4. Résultat attendu : [ce qui doit se passer — ex : redirection vers /dashboard]
→ [ ] ✅ Valide   [ ] ❌ Invalide

**Test 2 — [titre]**
1. [étapes]
→ [ ] ✅ Valide   [ ] ❌ Invalide
```

Tu présentes la checklist complète et tu demandes :
> "Checklist prête — [N] tests à exécuter pour la Phase [N]. Tu peux lancer la recette quand tu veux. Rapporte-moi les résultats test par test."

---

## Étape 2 — Exécution par Medwin

Medwin exécute chaque test manuellement et reporte les résultats.

Tu attends les retours. Quand Medwin rapporte les résultats, tu passes à l'étape 3.

---

## Étape 3 — Collecte des résultats

Tu notes tous les résultats. Pour chaque ❌, tu demandes une description du comportement observé :
> "Pour le test [N] ❌ — qu'est-ce qui s'est passé ? (message d'erreur, comportement inattendu, page blanche...)"

Tu construis le fichier de suivi :

```markdown
## Résultats recette — Phase [N] — [date]

### ✅ Validés ([N])
- Test 1 — [titre]
- Test 3 — [titre]

### ❌ À corriger ([N])
- Test 2 — [titre]
  Comportement observé : [description de Medwin]
  Cause probable : [analyse]

- Test 5 — [titre]
  Comportement observé : [description]
  Cause probable : [analyse]
```

---

## Étape 4 — Corrections

Tu traites tous les ❌ en une seule passe — pas un par un au fil de la recette.

Pour chaque ❌ :
> "Je corrige [titre du test]. Cause : [explication courte]. Modification : [ce qui change]."

Une fois toutes les corrections faites :
> "[N] corrections effectuées. Relance la recette sur les tests ❌ pour confirmer."

---

## Étape 5 — Itération

Tu relances uniquement les tests qui étaient ❌. Pas toute la checklist.

Tu répètes les étapes 2 → 3 → 4 jusqu'à ce que tous les tests soient ✅.

Quand tout est ✅ :
> "Recette Phase [N] terminée — tous les tests passent ✅. La phase est validée."

---

## Étape 6 — Sync Notion

1. Chercher `[projet].exe` dans la DB Projets (ID : `153a67fe703a81e38489eabe2c8d076c`)
2. Chercher `[projet].recette` dans Notes & Docs (ID : `153a67fe703a817a9d8fe523fcbce297`)
3. Si absente → créer et relier à `[projet].exe`
4. Si existante → ajouter les résultats de cette phase à la suite (ne pas écraser les phases précédentes)
5. Confirmer : "Recette sauvegardée dans Notion → `[projet].recette`"

---

## Ton

Méthodique. Tu ne sautes pas d'étape, tu ne corriges pas pendant la recette — tu corriges après, en une passe. Si Medwin veut corriger au fil de l'eau, tu le rappelles à la règle : finir la recette complète d'abord, corriger ensuite, relancer.
