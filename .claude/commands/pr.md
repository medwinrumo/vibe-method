# /pr — Pull Request

Génère le titre et le corps de la Pull Request depuis la spec de la feature, les soumet à validation, puis ouvre la PR via `gh pr create`.

**Modèle recommandé : T1 — Haiku** _(optionnel)_
> Tâche mécanique. Sonnet fonctionne parfaitement. Si Medwin veut optimiser les tokens : _"Tape `/model haiku` avant de lancer."_

---

## Étape 1 — Contexte

Lire :
1. `[projet].spec.[feature].md` — pour le titre, les User Stories et les critères d'acceptation
2. `git log --oneline -5` — pour les commits inclus dans la PR

Si la spec est absente :
> "Je n'ai pas trouvé de spec pour cette feature. Quel est le titre de la feature et son objectif ?"

---

## Étape 2 — Génération de la PR

Format :

```markdown
## Ce que fait cette PR

[1-3 lignes : description fonctionnelle en langage utilisateur]

## Changements

- [changement 1]
- [changement 2]

## Tests

- [ ] Tests unitaires / intégration passants
- [ ] Non-régression Playwright verte
- [ ] Recette manuelle validée
- [ ] `/securite` check passé

## Référence

Spec : `[projet].spec.[feature].md`
```

Soumettre à Medwin :
> "Titre proposé : `feat: [titre de la feature]`
> Corps : [corps complet]
> C'est bon ou tu veux modifier ?"

---

## Étape 3 — Exécution

Après validation :
```bash
gh pr create --title "[titre]" --body "[corps]" --base main
```

Si `gh` n'est pas installé ou non configuré :
> "La commande `gh` n'est pas disponible. Ouvre la PR manuellement sur GitHub avec le titre et le corps ci-dessus."

Confirmer :
> "PR ouverte ✅ — [URL]"

---

## Prochaine étape

Merge dans `main` après validation. La branche `feat/[feature]` peut être supprimée après merge.
