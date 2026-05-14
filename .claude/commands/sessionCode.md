# /sessionCode — Démarrage d'une session de code

Tu prépares le contexte pour une session de code sur le projet en cours. Ce skill est le sas d'entrée obligatoire avant d'écrire la première ligne de code.

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — Chargement du PRP + vérification de fraîcheur

Tu lis `[projet].prp.md`.

Si absent → tu t'arrêtes :
> "Le PRP n'existe pas encore pour ce projet. Lance `/prp` d'abord, puis reviens ici."

Si présent → tu lis l'en-tête du PRP :
`_Généré le [date] — feature courante : [nom de la feature]_`

Tu poses ensuite la question de la feature (Étape 2) avant de juger la fraîcheur — la comparaison se fait quand on sait quelle feature est visée.

---

## Étape 2 — Sélection de la feature

> "PRP chargé. Quelle feature codes-tu dans cette session ?"

**Vérification 1 — Feature dans le PRP**
La feature mentionnée est-elle listée dans la section "Features V1" du PRP ?
Si elle n'y est pas → arrêt :
> "Cette feature n'est pas dans le PRP. Elle n'a peut-être pas de spec. Lance `/specs` d'abord."

**Vérification 2 — Fraîcheur du PRP**
La feature demandée correspond-elle à la feature courante dans l'en-tête du PRP ?
- Si non → le PRP a été généré pour une autre feature :
  > "Le PRP a été généré pour la feature '[feature PRP]', pas pour '[feature demandée]'. Lance `/prp` pour le mettre à jour avant de continuer."
- Si oui → PRP à jour, on continue.

**Vérification 3 — Spec existante**
Tu lis `[projet].spec.[feature].md`.
Si absent → arrêt :
> "La spec de cette feature est introuvable (`[projet].spec.[feature].md`). Lance `/specs` d'abord."

**Vérification 4 — Sprint status**
Si `[projet].avancement.yaml` existe → tu lis le statut actuel de cette feature et tu l'affiches :
> "Sprint status : [nom feature] → [statut actuel]"

Si le statut est `done` → signaler :
> "Cette feature est déjà marquée 'done' dans le sprint status. Tu veux la reprendre ?"

Sinon → proposer de passer le statut à `in-progress` :
> "Je mets à jour le sprint status : [feature] → in-progress ?"

---

## Étape 3 — Dette de refactoring sur le module ciblé

Tu lis `[projet].refacto-dette.md` si le fichier existe.

Si absent → continuer sans signaler (pas encore de dette enregistrée).

Si présent → tu vérifies s'il existe des entrées `- [ ]` (non résolues) qui concernent le module ciblé par cette feature.

Si oui → recommandation forte, pas un blocage dur :
> "Il y a une dette de refactoring en attente sur le module [X] :
> - [entrée 1]
> - [entrée 2]
>
> La doctrine recommande de refactoriser avant de coder sur ce module.
> Lance `/refacto` d'abord, puis reviens ici — ou confirme que tu veux coder maintenant malgré la dette."

Medwin décide. Si il choisit de continuer malgré la dette → noter et passer à l'étape suivante.

---

## Étape 4 — État dans la roadmap et dépendances

Tu lis `[projet].Rmap.md`.

Si absent → signaler et continuer sans bloquer :
> "Pas de roadmap trouvée — je ne peux pas vérifier les dépendances. Continue avec prudence."

Si présent :

**État de la feature :**
Tu trouves la feature dans la roadmap et vérifies son statut.
- Si "Done" → signaler :
  > "Cette feature est marquée 'Done' dans la roadmap. Tu veux la reprendre, ou il y a une confusion sur le nom ?"
- Sinon → continuer.

**Dépendances :**
Tu identifies les features dont celle-ci dépend (features listées comme prérequis dans la spec ou la roadmap).
Pour chaque dépendance → vérifier son statut dans la roadmap.
Si une dépendance n'est pas "Done" → signaler avant de continuer :
> "Cette feature dépend de '[feature X]' qui n'est pas encore terminée. Coder cette feature maintenant risque de bloquer ou d'être recodé. Tu veux continuer quand même ?"

---

## Étape 5 — Mode de développement

Tu lis `[projet].archi.md` pour identifier le module concerné par cette feature.

**Si module métier ou module sécurité → Mode TDD :**
> "Cette feature est dans le module [X] — mode TDD.
> Les tests doivent être écrits AVANT le code, depuis les règles de gestion de la spec.
> Si tu n'as pas encore lancé `/tests` pour cette feature → fais-le maintenant avant d'écrire une ligne de code."

**Si module UI ou module technique → Mode Standard :**
> "Cette feature est dans le module [X] — mode Standard.
> Les tests sont écrits après le code."

Si le module n'est pas identifiable → signaler :
> "Je ne trouve pas le module correspondant à cette feature dans `[projet].archi.md`. Vérifie l'architecture avant de continuer."

---

## Étape 6 — Rappel des règles critiques

Tu rappelles en quelques lignes les règles qui s'appliquent à cette session, extraites du PRP et de la spec :

- **Règles silo** : quel module est concerné, ce qu'il peut appeler, ce qui est interdit
- **Règles sécurité** : les contraintes spécifiques à cette feature (RLS, validation, secrets)
- **Contraintes stack** : gotchas ou patterns obligatoires relevés dans le PRP pour ce module

Ne recopie pas tout le PRP — seulement ce qui est pertinent pour cette feature précise.

---

## Étape 7 — Confirmation de démarrage

> "Contexte chargé pour [feature].
> Module : [module]. Mode : [TDD / Standard].
> Chaîne après cette session : `/code-review` → `/code-review-edge-cases` → `/tests` → `/doc-tech` (Mode B) → `/recette`.
> Tu peux commencer."
