---
description: Condense tous les artefacts du projet en un contexte de démarrage de session de code, sous 1 000 tokens
---

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
   - `[projet].gloss.md` _(optionnel — glossaire des termes métier du projet)_

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
- Entry points concernés par la feature en cours (fichiers/dossiers/routes)

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

**`[projet].gloss.md`** _(si présent)_ → termes métier canoniques
- Liste complète des termes acté : terme → définition courte
- Permet à Claude de poliser le vocabulaire pendant la session

---

## Étape 2 — Évaluation de suffisance

Avant d'écrire le fichier, tu évalues si le contenu extrait permet de démarrer une session sans relire le reste.

### Checklist de suffisance (6 catégories)

| Catégorie | Ce qu'elle couvre | Statut |
|---|---|---|
| A. Objectif immédiat | Feature en cours + définition de done (1-3 lignes) | OK / Manquant |
| B. Pointeurs de code | Fichiers/dossiers concernés + 2-5 entry points concrets | OK / Manquant |
| C. Règles critiques | 5-15 règles non-évidentes (sécurité, pièges, interdits) | OK / Partiel / Manquant |
| D. Décisions d'archi | 3-7 décisions qui impactent directement l'implémentation | OK / Partiel / Manquant |
| E. Données & invariants | Modèles/entités touchées + invariants métier | OK / N/A / Manquant |
| F. Commandes de dev | 3-8 commandes essentielles (dev, test, lint, migrate) | OK / Manquant |

**Si une catégorie est "Manquant"** → chercher l'information dans les fichiers sources. Si elle est absente des sources → signaler explicitement à Medwin que l'artefact correspondant est incomplet (ex : `/regles` n'a pas encore été fait).

**Si ≥ 2 catégories sont "Manquant" ou "Partiel"** → alerter :
> "PRP incomplet — [N] catégories insuffisantes. Risque de bloquer au démarrage de session sur : [liste]. Recommandation : [action]."

### Test de simulation (obligatoire)

Avant de sauvegarder, vérifie que le PRP permet de répondre sans ambiguïté à ces 4 questions :

1. **Qu'est-ce que je code maintenant ?** (objectif de session)
2. **Où je le code ?** (fichiers et entry points)
3. **Quelles règles je ne dois pas violer ?** (sécurité, pièges, interdits)
4. **Comment je vérifie que ça marche ?** (tests ou commande)

Si une question ne peut pas être répondue depuis le PRP seul → le PRP est insuffisant, quelle que soit sa taille.

---

## Étape 3 — Contrôle de taille

**Cible : ≤ 1 000 tokens.**

Estimer la taille du PRP produit (approximation acceptable : 1 token ≈ 0,75 mot).

- **≤ 1 000 tokens** → OK, continuer.
- **> 1 000 tokens** → recondenser. Si impossible sans perdre des éléments de la checklist de suffisance : produire deux versions :
  - `[projet].prp.md` — version core ≤ 1 000 tokens (objectif, pointeurs, règles critiques)
  - `[projet].prp-extended.md` — version complète sans contrainte de taille

La version core est chargée par défaut. La version extended est disponible pour les sessions complexes.

---

## Étape 4 — Génération de `[projet].prp.md`

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

## Commandes de dev
- [commande 1] — [rôle]
- [commande 2] — [rôle]

## Glossaire _(si [projet].gloss.md présent)_
- [terme] — [définition courte]
[répéter pour chaque terme — omettre la section si le fichier est absent]

## Feature en cours — [nom]
[User story condensée]

Entry points : [fichiers/dossiers concernés]

Critères d'acceptance :
- [critère 1]
- [critère 2]
```

---

## Étape 5 — Confirmation

Message de fin obligatoire :

> "PRP estimé : [X] tokens / limite : 1 000 — [OK / Dépassement : version core + extended générées]
>
> Suffisance :
> A=[statut] — B=[statut] — C=[statut] — D=[statut] — E=[statut] — F=[statut]
>
> [Si tout OK] : PRP prêt. Lance `/avancement` pour initialiser le tracker, puis `/sessionCode` pour démarrer.
>
> [Si alerte] : Risque de bloquer au démarrage sur [catégories]. Recommandation : [action concrète — ex : +250 tokens, compléter /regles, ajouter entry points]."

---

## Règles

- **Décisions et contraintes uniquement** — pas d'explications, pas de justifications
- **Non-évident préservé toujours** — ce qu'une IA généraliste raterait sans ce fichier
- **≤ 1 000 tokens (hard)** — si impossible sans sacrifier la suffisance : core + extended
- **Suffisance prime sur la taille** — un PRP court mais insuffisant est inutile
- **Document vivant** — relancer `/prp` après tout changement d'architecture ou de feature
- **Ne pas bloquer sur un fichier absent** — signaler et continuer

---

## Prochaine étape

`/avancement` (init) — initialiser le suivi des features, puis `/sessionCode` pour démarrer la première session de code.
