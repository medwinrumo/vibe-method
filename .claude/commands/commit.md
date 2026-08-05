---
description: Message de commit au format Conventional Commits depuis le diff Git, soumis à validation avant exécution
---

# /commit — Commit propre

Génère un message de commit au format Conventional Commits depuis le diff Git courant, le soumet à validation, puis exécute le commit.

**Modèle recommandé : T1 — Haiku** _(optionnel)_
> Tâche mécanique. Sonnet fonctionne parfaitement. Si Medwin veut optimiser les tokens : _"Tape `/model haiku` avant de lancer."_

---

## Étape 1 — État du dépôt

```bash
git status
git diff --staged
```

Si rien n'est staged :
```bash
git diff
```

> "Voilà les fichiers modifiés : [liste]. Quels fichiers veux-tu inclure dans ce commit ?"

Medwin confirme → `git add [fichiers]`

**Taille indicative :** viser ~100 lignes par commit pour rester facilement relisible. Au-delà de ~1000 lignes ou si le diff mélange plusieurs sujets sans rapport, proposer un découpage en plusieurs commits avant de continuer.

---

## Étape 2 — Contexte

Identifier le type de changement depuis le diff :
- Lire `[projet].spec.[feature].md` si disponible (pour le scope)
- Lire `[projet].avancement.yaml` si disponible (pour confirmer le statut de la feature)

---

## Étape 3 — Message de commit

Format Conventional Commits :
```
type(scope): description courte en français
```

Types :
- `feat` — nouvelle feature ou comportement utilisateur ajouté
- `fix` — correction de bug
- `refactor` — refactoring sans changement de comportement visible
- `test` — ajout ou modification de tests
- `docs` — documentation uniquement
- `chore` — tâche technique (deps, config, tooling, skills)
- `style` — mise en forme, pas de changement logique

Règles :
- Description en minuscules, sans point final, max 72 caractères
- Scope = nom du module, feature ou projet (ex : `auth`, `dashboard`, `vibe-method`)
- Corps uniquement si plusieurs changements distincts méritent d'être nommés séparément

Soumettre à Medwin :
> "Message de commit proposé :
> `feat(auth): ajouter la validation des emails à l'inscription`
> C'est bon ou tu veux modifier ?"

---

## Étape 4 — Exécution

Après validation de Medwin :
```bash
git commit -m "[message validé]"
```

Confirmer :
> "Commit créé ✅ — `[message]`"

---

## Prochaine étape

> "Commit créé. Lance `/pr` si tu veux ouvrir une Pull Request."
