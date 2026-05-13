# /prp — Project Ready Prompt

Tu génères `[projet].prp.md` : un document unique, condensé, optimisé pour être donné à l'IA comme contexte de démarrage d'une session de code.

Ce fichier est rechargé à chaque compaction de contexte pendant les sessions longues. Il doit être court. Chaque source ne contribue que ses décisions et contraintes — jamais ses explications. Ce qui est non-évident survit toujours à la condensation.

---

## Quand lancer /prp

- Après `/specs`, avant de démarrer le code d'une feature
- Quand une nouvelle feature démarre (pour mettre à jour la spec courante)
- Après un changement d'architecture significatif

Place dans la chaîne : `/specs` → `/prp` → code

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La feature en cours** — nom de la spec à charger comme contexte courant
3. Les fichiers suivants dans le repo projet :
   - `[projet].brief.md`
   - `[projet].prd.md`
   - `[projet].archi.md`
   - `CLAUDE.md`
   - `[projet].stack.md`
   - `[projet].tests.md`
   - `[projet].spec.[feature].md`

Si un fichier est absent → le signaler et continuer sans lui. Ne pas bloquer sur un fichier optionnel (tests) si le projet n'en a pas encore.

---

## Étape 1 — Lecture et extraction

Tu lis chaque fichier source et en extrais **uniquement** :

**`[projet].brief.md`** → 2 lignes max
- Ce que fait l'app
- Pour qui, quel problème ça résout

**`[projet].prd.md`** → liste des features V1
- 1 ligne par feature : nom + ce qu'elle fait
- Rien d'autre

**`[projet].archi.md`** → structure du code + sécurité
- Carte des modules (nom + responsabilité en quelques mots)
- Règles silo : quel module peut appeler quoi, ce qui est interdit
- Contraintes techniques structurantes (ex : région BDD, niveau de déploiement si critique)
- Section Sécurité complète : règles universelles + règles projet (secrets, tables RLS, endpoints, blocs conditionnels)

**`CLAUDE.md`** → règles du projet
- Conventions de code non-évidentes
- Fichiers ou modules à ne pas toucher
- Tout ce que l'IA ferait mal sans le lire

**`[projet].stack.md`** → contraintes critiques uniquement
- Gotchas connus (comportements contre-intuitifs, pièges documentés)
- Versions avec breaking changes pertinents
- Patterns obligatoires ou interdits explicitement
- Rien sur le free tier, rien sur l'histoire de l'investigation

**`[projet].tests.md`** → patterns de test
- Quoi tester et à quel niveau (unitaire / intégration / E2E)
- Outils et patterns utilisés dans ce projet
- Ce qu'on ne teste pas et pourquoi

**`[projet].spec.[feature].md`** → feature en cours
- User story condensée (qui fait quoi, dans quel but)
- Critères d'acceptance uniquement
- Rien sur le contexte ou la justification

---

## Étape 2 — Vérification de complétude

Avant d'écrire le fichier, tu vérifies :
- Toutes les règles non-évidentes sont présentes (si quelque chose peut surprendre une IA généraliste → ça reste)
- Aucune explication ou justification n'a glissé dans le document (si une phrase commence par "parce que" ou "afin de" → la supprimer)
- Le document tient en moins de 1 000 tokens — sinon, recondenser

---

## Étape 3 — Génération de `[projet].prp.md`

```markdown
# PRP — [Nom du projet]
_Généré le [date] — feature courante : [nom de la feature]_

## App
[2 lignes : ce que fait l'app, pour qui]

## Features V1
- [feature] — [description en une ligne]
[répéter pour chaque feature]

## Modules
- [module] — [responsabilité courte]
[répéter pour chaque module]

## Règles silo
- [règle 1]
- [règle 2]
[liste courte]

## Conventions
[depuis CLAUDE.md — règles non-évidentes uniquement]

## Sécurité
[Depuis [projet].archi.md — section Sécurité complète, telle quelle]

## Stack — contraintes critiques
- [gotcha ou contrainte 1]
- [gotcha ou contrainte 2]
[liste courte — si rien de critique : "Aucune contrainte critique identifiée"]

## Tests — patterns
- [pattern 1]
- [pattern 2]
[si tests.md absent : omettre cette section]

## Feature en cours — [nom]
[User story condensée]

Critères d'acceptance :
- [critère 1]
- [critère 2]
```

---

## Étape 4 — Confirmation

> "`[projet].prp.md` généré.
> À régénérer quand la feature change ou après un changement d'architecture."

Tu proposes immédiatement :
> "Lance `/sessionCode` pour démarrer la session de code."

---

## Règles

- **Décisions et contraintes uniquement** — pas d'explications, pas de justifications
- **Non-évident préservé toujours** — ce qu'une IA généraliste raterait sans ce fichier
- **< 1 000 tokens** — si le document dépasse, recondenser avant de sauvegarder
- **Document vivant** — relancer `/prp` après tout changement d'architecture ou de feature
- **Ne pas bloquer sur un fichier absent** — signaler et continuer
