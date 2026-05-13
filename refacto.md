# refacto.md — Doctrine refactoring

Le refactoring est une discipline à part entière. Elle a ses propres règles, ses propres risques, son propre workflow — et elle s'intègre dans le workflow de la vibe-method à trois moments précis.

---

## Définition

Refactoriser, c'est améliorer la structure interne du code sans changer ce que l'application fait.

L'app se comporte exactement pareil avant et après. Ce qui change : le code qui produit ce comportement est plus clair, mieux organisé, plus facile à maintenir et à faire évoluer.

**Refactoriser ≠ ajouter une feature. Refactoriser ≠ corriger un bug. Ce sont trois activités incompatibles dans la même session.**

---

## Pourquoi c'est une discipline à part

Le code se dégrade naturellement. Chaque feature ajoutée vite, chaque bug corrigé en urgence, chaque décision "pour l'instant" laisse une trace. Cette accumulation s'appelle la **dette technique** — et elle a un coût concret : plus elle est grande, plus chaque nouvelle feature prend du temps et du risque.

Le refactoring rembourse cette dette. Sans lui :
- Ajouter des features devient exponentiellement plus difficile
- Les bugs deviennent plus fréquents et plus difficiles à isoler
- Le contexte donné à l'IA se dégrade (modules flous, responsabilités mélangées = IA moins fiable)

Avec lui :
- Les modules sont clairs, les responsabilités séparées
- Le contexte minimal donné à l'IA reste minimal — c'est le principe fondateur de l'architecture vibe-method
- Les nouvelles features s'ajoutent sur une base solide

---

## Critères — quand refactoriser

Refactoriser est justifié quand au moins un de ces signaux est présent :

- **Duplication visible** — la même logique est écrite à plusieurs endroits. Modifier un comportement impose de chercher et modifier chaque copie.
- **Module trop gros** — un fichier ou module fait trop de choses. Il est difficile de comprendre son rôle d'un coup d'œil.
- **Nommage trompeur ou flou** — des fonctions ou variables dont le nom ne reflète plus ce qu'elles font réellement.
- **Logique impossible à expliquer** — un bloc de code qu'on ne peut pas décrire en une phrase sans relire ligne par ligne.
- **Responsabilités mélangées** — une logique qui appartient à un module se retrouve dans un autre.
- **Avant une feature sur un module dégradé** — ajouter une feature dans un module qui présente les signaux ci-dessus est risqué. Refactoriser d'abord.

---

## Critères — quand ne pas refactoriser

- Proche d'une deadline
- Sans couverture de tests sur le code concerné
- En même temps qu'une feature ou un bug fix
- Quand le code fonctionne et n'a pas besoin d'être touché (prochain point de contact non planifié)
- Par perfectionnisme — "code propre" n'est pas une justification. Il faut une raison concrète.

---

## Règles non-négociables

**1 — Session dédiée**
Le refactoring ne se mélange pas avec une feature en cours ou un bug fix. Il exige sa propre session, son propre contexte propre. Si une session de feature est en cours → `/maj`, `/clear`, puis `/todo` → refactoring en première action.

**2 — Branche dédiée**
Toujours travailler sur une branche `refacto/[module]` — jamais directement sur `main` ou sur une branche `feat/`. La branche est créée avant de toucher quoi que ce soit.

**3 — Commit de checkpoint avant de commencer**
Un commit propre sur la branche avant la première modification. C'est le point de retour garanti : si quelque chose part mal, `git reset --hard HEAD` ramène à l'état d'avant sans perte.

**4 — Tests passants avant de commencer**
Les tests sont la baseline de détection. Avant de refactoriser : lancer la suite complète, vérifier qu'elle passe. Si des tests échouent avant même de commencer → arrêt complet. Corriger les tests d'abord (session de bug fix), puis revenir au refactoring.
Pourquoi : si les tests passent avant et échouent après, on sait qu'on a changé un comportement. Sans cette baseline, impossible de distinguer ce qui était déjà cassé de ce qu'on a cassé.

**5 — Scope défini en une phrase avant de toucher quoi que ce soit**
Le scope est formulé précisément : "Refactoriser [module X] pour [objectif Y]". Une phrase. Tout ce qui n'est pas dans cette phrase est hors scope — noté dans le journal de dette, pas touché dans cette session.

**6 — Étapes atomiques**
Un changement à la fois. Pas "refactorise ce module" — mais "renomme cette fonction", "extrais ce bloc", "fusionne ces deux fonctions". Chaque étape est annoncée, validée, exécutée, puis vérifiée avant la suivante.

**7 — Commit atomique par étape validée**
Chaque étape validée fait l'objet d'un commit `refacto: [action précise]`. Si une étape ultérieure dérape, `git reset HEAD~1` annule uniquement cette étape — pas tout le travail.

**8 — Tests relancés après chaque étape**
Après chaque commit atomique : relancer les tests. Si un test échoue → arrêt, diagnostic, correction ou revert avant de continuer.

---

## Types de refactoring courants

**Renommage**
Des fonctions, variables, ou fichiers dont le nom ne reflète plus ce qu'ils font. Changement à faible risque, fort gain de lisibilité.

**Extraction**
Un bloc de logique trop long ou répété → devient une fonction séparée avec un nom clair. Réduit la duplication, améliore la testabilité.

**Fusion**
Deux fonctions qui font la même chose ou presque → une seule. Élimine la divergence silencieuse (modifier l'une et oublier l'autre).

**Décomposition**
Un module ou une fonction qui fait trop de choses → découpé en unités plus petites, chacune avec une responsabilité unique.

**Simplification**
Une condition imbriquée sur plusieurs niveaux, une logique alambiquée → rendue lisible, aplanie, exprimée clairement.

**Déplacement**
Une logique qui se trouve dans le mauvais module → déplacée dans celui qui en est responsable selon l'architecture définie dans `[projet].archi.md`.

---

## Lien avec TDD — micro vs macro

Il existe deux niveaux de refactoring dans la vibe-method. Ils partagent les mêmes principes mais ne sont pas le même acte.

**Micro-refactoring TDD** — troisième étape du cycle Red → Green → Refactor.
Se fait immédiatement après le Green, sur le code qui vient d'être écrit, dans la même session, sur la même branche feature. Périmètre : les quelques lignes produites pour satisfaire le test. Pas de branche dédiée, pas de session séparée.

**Macro-refactoring `/refacto`** — ce que décrit cette doctrine.
Session dédiée, déclenchée par un diagnostic de dette accumulée. Branche `refacto/[module]`, étapes atomiques, commits séparés.

**Ce qu'ils ont en commun :**
- Tests verts comme baseline avant de toucher quoi que ce soit
- Comportement externe inchangé — les tests doivent rester verts
- Petits pas, un changement à la fois
- Scope strict — rien hors du périmètre défini

**La règle de distinction :**
Si le code à améliorer vient d'être écrit dans cette session → micro-refactoring TDD, on reste sur la branche feature.
Si le code à améliorer existe depuis une ou plusieurs sessions → macro-refactoring, on ouvre une session `/refacto` dédiée.

Doctrine TDD de référence : `tests.md`

---

## Intégration dans le workflow

Le refactoring peut être déclenché à trois moments :

**1 — Avant une feature (pré-feature)**
Si une feature doit être ajoutée dans un module qui présente des signaux de dégradation → diagnostic d'abord. Si le diagnostic confirme le besoin → session de refactoring dédiée, puis session de feature.
`/refacto (diagnostic) → [si besoin] /refacto (exécution) → /sessionCode (feature)`

**2 — Fin de phase (stabilisation avant release)**
Après que toutes les features d'une phase sont validées par `/recette` → session de refactoring pour stabiliser la base avant la release.
`/recette (dernière feature) → /refacto → release`

**3 — On-demand (ciblé, justifié)**
Quand un signal de dégradation est identifié en dehors des deux moments précédents. Doit rester l'exception, pas la règle — le refactoring n'est pas une activité quotidienne.

Skill de référence : `/refacto`
