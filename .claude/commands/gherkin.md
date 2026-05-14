# /gherkin — Génération de scénarios Gherkin

Deux modes selon le moment dans le workflow :

- **Mode PRD** — après `/prd-validate` : scénarios légers pour révéler les zones floues du PRD avant l'architecture
- **Mode Specs** — après `/specs` : scénarios complets depuis les User Stories, qui deviennent la définition de "done" pour le développeur

Le Gherkin généré en Mode Specs est réutilisé par `/recette` — on ne régénère pas, on complète.

---

## Quand lancer /gherkin

- **Mode PRD** : juste après `/prd-validate` → avant `/archi`
- **Mode Specs** : juste après `/specs` → avant `/sessionCode`

---

## Étape 0 — Identification du mode

Tu demandes si ce n'est pas précisé :
> "Mode PRD (validation du PRD) ou Mode Specs (guide de développement) ?"

---

## MODE PRD — Validation de la clarté du PRD

### P1 — Input

Tu lis `[projet].prd.md`. Tu extrais la liste des features V1.

---

### P2 — Génération scénario par feature

Pour chaque feature V1, tu tentes d'écrire 1 à 3 scénarios Gherkin minimaux :

```
Étant donné [qui est l'utilisateur, dans quel état est le système]
Lorsque [action de l'utilisateur]
Alors [résultat exact et vérifiable]
```

**Règle du "Alors" :** si tu ne peux pas écrire "Alors" avec un résultat exact et vérifiable, la feature est trop vague. "Alors l'utilisateur est content" n'est pas un résultat vérifiable. "Alors il est redirigé vers /tableau-de-bord" l'est.

---

### P3 — Rapport de clarté

Pour chaque feature :

```
Feature : [nom]
─────────────────────────────
Scénario 1 :
  Étant donné [contexte]
  Lorsque [action]
  Alors [résultat]
→ ✅ Clair

Scénario 2 :
  Étant donné [contexte]
  Lorsque [action]
  Alors ??? — résultat non défini dans le PRD
→ ⚠️ Ambigu : [ce qui manque précisément]
```

---

### P4 — Verdict

```
--- Gherkin PRD — [projet] ---

[N] features analysées
[N] features claires   → peuvent passer en /archi
[N] features ambiguës  → à préciser dans le PRD

Features ambiguës :
  — [feature] : [ce qui manque]
  — [feature] : [ce qui manque]

Verdict : GO / RETOUR PRD
```

**Si RETOUR PRD** → arrêt. Les ambiguïtés listées sont à résoudre dans `/prd-update` avant de passer à `/archi`. Une feature qu'on ne peut pas décrire en Gherkin est une feature qu'on ne sait pas encore ce qu'elle doit faire.

**Si GO** :
> "Toutes les features sont suffisamment claires. Tu peux passer à `/archi`."

Ce mode ne sauvegarde pas de fichier — c'est une validation, pas un livrable.

---

## MODE SPECS — Définition de "done"

### S1 — Input

Tu demandes quelle feature :
> "Mode Specs — quelle feature ?"

Tu lis `[projet].spec.[feature].md`. Si absent → arrêt :
> "Lance `/specs` d'abord pour cette feature."

---

### S2 — Génération des scénarios complets

Pour chaque User Story de la spec, tu génères :

**Happy path** — le cas nominal qui doit toujours fonctionner

**Cas limites** — les cas aux frontières (champs vides, valeurs maximales, actions répétées)

**Cas d'échec** — les erreurs attendues (mauvais identifiants, droits insuffisants, ressource introuvable)

Format :

```gherkin
## Scénario : [titre — ce que ce scénario teste]
**Type : happy path / cas limite / cas d'échec**

Étant donné [contexte initial précis]
Lorsque [action précise de l'utilisateur]
Alors [résultat exact et vérifiable]
[Et [résultat complémentaire si nécessaire]]
```

**Signal de découpage :** si une User Story produit plus de 8 scénarios → signaler :
> "La story '[titre]' a produit [N] scénarios. C'est un signal que la story est trop large. On continue ou on découpe d'abord ?"

---

### S3 — Présentation avant sauvegarde

Tu présentes l'ensemble des scénarios générés :
> "Voilà [N] scénarios pour la feature [X] :
> - [N] happy path
> - [N] cas limites
> - [N] cas d'échec
>
> Ces scénarios deviennent la définition de 'done' pour cette feature.
> Le code sera terminé quand tous ces scénarios passent.
> On valide ?"

Medwin peut demander d'ajouter, modifier ou supprimer des scénarios avant de sauvegarder.

---

### S4 — Sauvegarde

Tu sauvegardes dans `[projet].gherkin.[feature].md` dans le repo du projet :

```markdown
# Gherkin — [Nom du projet] — [Feature]
_Généré le [date] via /gherkin Mode Specs_
_Utilisé par : /tests, /recette_

---

## Feature : [nom complet de la feature]

### Scénario 1 : [titre]
**Type : happy path**

Étant donné [contexte]
Lorsque [action]
Alors [résultat]

### Scénario 2 : [titre]
**Type : cas d'échec**

Étant donné [contexte]
Lorsque [action]
Alors [résultat]

[...]
```

---

### S5 — Lien avec /tests et /recette

> "Scénarios sauvegardés dans `[projet].gherkin.[feature].md`.
>
> Ces scénarios sont maintenant la source de vérité pour :
> - `/tests` → génèrera les tests Playwright depuis ce fichier
> - `/recette` → utilisera ce fichier pour la validation manuelle (sans régénérer)
>
> Tu peux passer à `/sessionCode`."

---

## Règles

- Mode PRD ne sauvegarde rien — c'est une validation
- Mode Specs sauvegarde `[projet].gherkin.[feature].md` — c'est un livrable
- Un scénario dont le "Alors" n'est pas vérifiable n'est pas un scénario — c'est une intention
- `/recette` lit ce fichier, il ne le régénère pas

---

## Prochaine étape

**Mode PRD** : `/archi` — les features sont validées sur le fond, construire l'architecture.
**Mode Specs** : `/readyTo-code` — les scénarios sont prêts, vérifier que tout est en place avant de coder.
