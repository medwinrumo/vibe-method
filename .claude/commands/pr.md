---
description: Génère titre et corps de Pull Request depuis la spec de la feature, puis ouvre la PR via gh
---

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

## Étape 4 — Merge sur GitHub

Après l'ouverture de la PR, le merge ne se fait pas automatiquement. Il se fait manuellement sur GitHub :

1. Ouvrir l'URL de la PR retournée à l'étape 3
2. Relire le diff — GitHub affiche tous les changements fichier par fichier
3. Si tout est bon : cliquer sur **Merge pull request** → **Confirm merge**
4. Cliquer sur **Delete branch** — la branche `feat/[feature]` a fait son travail, `main` contient maintenant tout son contenu

La feature est dans `main`. Le cycle est terminé.

---

## Prochaine étape

Démarrer la feature suivante : créer une nouvelle branche depuis `main` et relancer `/sessionCode`.
