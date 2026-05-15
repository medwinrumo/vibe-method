# methode.md

Le process de travail — dans quel ordre construire, comment passer d'une étape à la suivante.
À enrichir au fil des sessions.

---

## Posture fondatrice

Le vibe coding éclairé, c'est la posture du **chef d'orchestre** : comprendre la partition sans jouer chaque instrument. On ne sait pas forcément écrire chaque ligne de code — mais on comprend ce qu'on construit, on sait quand quelque chose ne va pas, et on prend les décisions.

Deux erreurs symétriques à éviter :
- **Le touriste** : accepte tout ce que l'IA produit sans comprendre. Le projet dérive lentement, invisiblement.
- **L'ingénieur fantôme** : veut tout contrôler, tout relire, tout valider ligne par ligne. Perd l'avantage de l'IA.

La vibe-method est conçue pour la posture du milieu : des garde-fous à chaque étape, pas du micro-management.

**"You don't know what you don't know"** — sans compréhension minimale de ce qu'on construit, impossible de poser les bonnes questions à l'IA. L'IA répond aux questions qu'on lui pose. Si on ne sait pas qu'une question existe, on ne la posera jamais.

**3 règles d'état d'esprit — à garder en tête avant chaque session :**
1. **Être en contrôle** — savoir où on en est dans le projet à tout moment. Lire le todo, le PRP, la spec de la feature avant d'ouvrir l'outil.
2. **Travailler concentré** — pendant que l'IA travaille, préparer la prochaine instruction. Chaque distraction coûte du contexte.
3. **Prendre des notes** — capturer les décisions, ce qui marche, ce qui ne marche pas, les termes découverts. C'est ce qui permet de ne pas repartir de zéro à chaque session.

---

## Greenfield ou Brownfield ?

Première question à poser au démarrage de tout projet. La réponse change le workflow.

**Greenfield** — projet qui part de zéro. Aucune codebase existante.
Workflow standard : `/brief → /prd → /archi → /stack → /roadmap → /specs → [/tests TDD si module métier/sécurité] → code → /tests → /recette`

**Brownfield** — reprise d'un projet existant (migration, refonte, ajout de features sur une base existante).
Exemples : Minou V2 (Firebase → Convex), fork d'une app existante, reprise d'un projet abandonné.

### Workflow Brownfield — étapes obligatoires avant tout changement

1. **Inventaire de la codebase** — lire et documenter ce qui existe : modules, dépendances, patterns utilisés, dette technique visible. Ne rien supposer.
2. **Couverture de régression** — écrire les tests sur le comportement existant AVANT de toucher au code. C'est le filet de sécurité. Si les tests n'existaient pas, ils se créent maintenant.
3. **Architecture adaptateur** — définir comment le nouveau système s'interface avec l'existant. Pas de remplacement brutal : on branche le nouveau sur l'ancien, on migre progressivement, on coupe l'ancien quand le nouveau est stable.
4. **Seulement ensuite** : `/archi → /roadmap → /specs → code`

**Règle absolue brownfield :** aucune modification du code existant sans couverture de régression préalable. Un bug introduit sur l'existant est invisible sans filet — et coûteux à trouver.

---

## Les phases

Les 7 phases se regroupent en 3 temps :
- **AVANT** (phases 1–4) — préparer : comprendre le projet, définir le produit, l'architecture et la stack
- **PENDANT** (phases 5–6) — construire : planifier et coder
- **APRÈS** (phase 7) — valider et livrer : tests, recette, mise en production

### Phase 1 — Produit
> Définir ce qu'on construit avant de toucher au code.

- Rédiger le brief
- Construire le PRD (cross-pollination entre IA)
- Définir le backlog et les user stories
- Identifier les enjeux de sécurité → `/securite analyse` (une fois par projet, avant `/archi`)

Fichiers de référence : `produit.md`, `securite.md`

---

### Phase 2 — Design
> Traduire les features en interface visuelle avant de toucher au code.

1. Export des features depuis le PRD — liste structurée :
   - Nom de la feature
   - Composant UI associé (bouton, liste déroulante, onglet, champ texte...)
   - Comportement de base si nécessaire (ex : "clic → déroule un panneau")
2. Medwin travaille dans Stitch (génération maquette) puis Figma (affinage)
3. Medwin livre l'export Figma (CSS + captures) — Claude reprend

**Règle :** étape manuelle. Claude produit l'export features, Medwin fait la maquette.
Claude ne reprend qu'à la réception de l'export Figma.

Fichier de référence : `design.md`

---

### Phase 3 — Architecture
> Décider comment le code est organisé.

- Choisir le pattern d'architecture (ex : modulaire)
- Définir les modules et leurs responsabilités
- S'assurer qu'ils sont indépendants

Fichier de référence : `architecture.md`

---

### Phase 4 — Stack
> Investiguer les outils avant de construire — deux niveaux : la stack applicative et la stack de dev.

**Stack applicative** — les outils qui font tourner l'app :
- Spike technique sur chaque outil (Convex, Supabase, Vercel, APIs externes...)
- Cartographier les limites du free tier
- Identifier les gotchas et les contraintes critiques
- Documenter les patterns recommandés pour l'IA

**Stack de dev** — les outils avec lesquels on code :
- Évaluer la complexité du projet pour choisir le bon couple outil + modèle
- Un projet CRUD simple n'a pas besoin du même outil qu'une app temps réel multi-modules
- Ne pas payer une stack overkill : choisir la stack nécessaire, pas la meilleure
- Possibilités : Claude Code + Opus, Claude Code + Sonnet, Kilo Code + Kimi K2.5 via OpenRouter, Cursor + modèle, etc.
- Décision documentée dans `[projet].stack.md`

Fichier de référence : `stack.md`

---

### Phase 5 — Planification
> Construire la roadmap d'exécution.

- Donner le PRD, le design et l'architecture pour générer la roadmap en markdown
- Découper en features parallélisables
- Chaque bloc = la plus petite feature possible

**Option — prototype exploratoire jetable (YOLO first) :** sur une feature dont l'architecture est incertaine, construire d'abord un prototype rapide sans tests ni commits — uniquement pour comprendre comment l'IA organise le code. Jeter ensuite, recommencer proprement. Ce n'est pas du temps perdu : c'est de la compréhension gagnée avant de s'engager.

---

### Phase 6 — Code
> Coder feature par feature, en respectant les règles établies.

- Une feature à la fois, validée contre ses critères d'acceptation
- Appliquer les règles de sécurité et d'architecture en continu
- Rien n'est ajouté silencieusement sans validation de Medwin

**TDD obligatoire pour les modules métier et sécurité :** avant d'écrire le code, `/tests` est lancé depuis le spec pour générer les tests. Le code doit satisfaire ces tests. Voir `tests.md` — section TDD.

Règle de contexte :
- Planification (PRD, archi, roadmap) : contexte large, tous les documents du projet
- Exécution (code) : contexte minimal — CLAUDE.md + module ciblé + specs de la feature
Ces deux modes ne se mélangent pas dans la même session.

Fichiers de référence : `securite.md`, `architecture.md`, `tests.md`

### Pilotage de la session de code

Ces règles s'appliquent en temps réel, pendant la Phase Code. Pas des étapes de process — des réflexes à intérioriser.

**L'archer immobile — Discuter avant de coder**
Avant toute implémentation, commencer en mode discussion. Décrire la feature et demander à l'IA comment elle compte s'y prendre : quels fichiers elle va modifier, quelles étapes elle va suivre. Si elle prévoit de toucher 10 fichiers pour ajouter un bouton, elle part dans la mauvaise direction — rectifier avant qu'elle n'écrive une ligne. Cette validation prend 2 minutes et évite des heures de correction.

**Le tranchant de la main — Surveiller et interrompre immédiatement**
Pendant que l'IA travaille, surveiller ce qu'elle fait. Si elle modifie des fichiers hors scope, installe des dépendances non prévues, ou refait ce qui n'a pas été demandé — l'interrompre immédiatement, sans la laisser finir. Plus elle avance dans la mauvaise direction, plus le code erroné s'accumule dans le contexte et plus il sera difficile de revenir en arrière.

**La mue du serpent — Si la première itération est mauvaise, recommencer, ne pas corriger**
Quand une première itération va dans la mauvaise direction, résister à la tentation de corriger. Le code bancal reste dans le contexte et l'IA s'appuie dessus pour la suite — chaque correction s'appuie sur une base défaillante. Recommencer depuis zéro avec un prompt amélioré. Deux ou trois tentatives pour trouver le bon point de départ, c'est un investissement, pas une perte.

**Vérifier les modifications non demandées**
Après chaque session, demander à l'IA : "Liste tous les fichiers que tu viens de modifier et ce que tu y as changé." L'IA modifie régulièrement des fichiers hors scope sans le signaler — c'est la seule façon de le détecter. Si une modification non demandée est trouvée → la faire annuler avant de continuer.

**Le souffle neuf — Gestion du contexte, une conversation par lot**
La fenêtre de contexte d'un LLM est limitée. Quand une conversation s'allonge, les éléments anciens en sortent — l'IA oublie l'architecture, mélange les noms de composants, perd la cohérence. Règle : une conversation par lot du PRD, maximum 2-3h. Quand le contexte est saturé (erreurs déjà corrigées qui réapparaissent, concepts mélangés) → ouvrir une nouvelle conversation avec un résumé propre de l'état du projet.

**Quand on est bloqué — protocole d'escalade**
Ne jamais s'entêter au-delà de deux essais sur le même problème. Escalade en 5 étapes :

1. **L'œil de l'aigle — Analyse globale** — "Relis tout le code lié à cette feature. Analyse le problème dans son ensemble. Propose des hypothèses avant de modifier quoi que ce soit." Passe l'IA du mode correction locale au mode diagnostic global.
2. **Le bond du tigre — Revenir en arrière + contraintes négatives** — Git reset au dernier commit propre. Relancer en précisant ce que l'IA ne doit PAS faire ("ne touche pas à X", "ne passe pas par Y"). Contraindre par le négatif est souvent plus efficace que prescrire le positif.
3. **Le singe change de branche — Changer de modèle** — chaque modèle a été entraîné différemment. Ce qui est insoluble pour Claude peut être trivial pour GPT ou Gemini.
4. **Le faucon en chasse — Recherche web** — les modèles ont une date de péremption. Demander à l'IA de chercher les bonnes pratiques actuelles, les incompatibilités de versions connues. S'applique aussi en préventif : avant d'intégrer un service externe, chercher la documentation à jour avant de coder.
5. **Le souffle neuf — Nouvelle conversation** — contexte propre, redémarrer avec le PRD, l'état du projet, et le problème rencontré + ce qui n'a pas fonctionné.

Si aucune étape ne débloque → reporter la feature et continuer. Ce n'est pas un échec, c'est du pragmatisme.

**Le kiai — Dicter les prompts complexes**
Pour les sujets complexes, dicter le prompt plutôt que le taper. Les prompts dictés sont naturellement plus riches : on développe, on donne du contexte, on explique le pourquoi en plus du quoi.

**Référence rapide — Les 9 gestes**

| Geste | Ce que c'est | Quand |
|---|---|---|
| L'archer immobile | Plan avant code — discuter, pas écrire | Avant chaque feature |
| Le tranchant de la main | Interrompre l'IA dès qu'elle dérive | Pendant le code |
| La mue du serpent | Recommencer depuis zéro, ne pas corriger | Première itération ratée |
| Le kiai | Dicter les prompts complexes | Prompts longs ou techniques |
| Le souffle neuf | Nouvelle conversation = contexte propre | Contexte saturé ou feature terminée |
| L'œil de l'aigle | Analyse globale avant toute correction | Bloqué après 2 essais |
| Le bond du tigre | Git reset + contraintes négatives | Bloqué après analyse globale |
| Le singe change de branche | Changer de modèle (Claude → GPT → Gemini) | Insoluble après reset |
| Le faucon en chasse | Recherche web — doc à jour, bonnes pratiques | Avant d'intégrer un service / après 2 tentatives |

---

### Phase 7 — Vérification
> S'assurer que ce qui est construit est correct — techniquement et fonctionnellement.

Ordre d'exécution pour chaque feature :

**Modules métier et sécurité (TDD) :**
```
1. /tests         → tests depuis le spec (Red — avant le code)
2. Code           → feature implémentée pour satisfaire les tests (Green)
3. /tests         → refactor + non-régression Playwright
4. /code-review   → revue structurelle + sécurité → bloquant si point critique
5. /recette       → génération du cahier de recettes (Gherkin)
6. /tests         → Playwright sur la nouvelle feature → corrections
7. /securite check → vérification sécurité → bloquant si point en échec
8. /recette       → validation manuelle finale
```

**Modules UI et techniques (Standard) :**
```
1. Code           → feature implémentée
2. /tests         → tests unitaires + intégration (Vitest)
3. /tests         → non-régression (batterie Playwright sur les features existantes)
4. /code-review   → revue structurelle + sécurité → bloquant si point critique
5. /recette       → génération du cahier de recettes (Gherkin)
6. /tests         → Playwright sur la nouvelle feature → corrections
7. /securite check → vérification sécurité → bloquant si point en échec
8. /recette       → validation manuelle finale
```

L'étape /code-review filtre les problèmes de structure et de sécurité — bloquante si point critique. L'étape /securite check filtre les failles — bloquante, pas de merge tant qu'un point est en échec. Medwin arrive en dernier pour réexécuter l'intégralité du cahier de recettes manuellement.

- Bug détecté en recette → `/debug` déclenché automatiquement
- Bug non résolu = bloquant — recette suspendue jusqu'à résolution
- Feature "Done" uniquement quand tous les critères de la Definition of Done sont satisfaits

### Definition of Done

Une feature n'est "Done" que si toutes ces cases sont cochées. Aucune exception.

- [ ] Tests unitaires et intégration passants (Vitest)
- [ ] Non-régression Playwright verte sur les features existantes
- [ ] `/securite` check validé sur la feature (bloquant)
- [ ] Recette manuelle validée par Medwin
- [ ] Aucune valeur hardcodée (tokens, clés API, URLs, credentials)
- [ ] Code sur branche `feat/[feature]`, prêt à merger
- [ ] `[projet].doc-user.md` mis à jour (entrée rédigée en langage utilisateur)

Si un critère n'est pas atteint → la feature reste "In Progress". Pas de merge.

Fichier de référence : `tests.md`

### GitHub Actions — automatisation optionnelle

À évaluer au démarrage du projet : superflu pour un V1 solo, utile dès qu'on veut un filet de sécurité automatique.

Usages typiques :
- Lancer la batterie Playwright à chaque push sur `main`
- Bloquer un merge si des tests échouent
- Lancer les tests la nuit sur la branche de dev

Règle : projet solo et petit → pas de GitHub Actions, Vercel suffit. Plusieurs contributeurs ou app critique → mettre en place dès le départ.

La question se pose lors du `/stack` ou du `/archi`.

---

## Règles Git — projets applicatifs

- `main` = toujours stable, jamais de code non validé
- Une branche par feature : `feat/[nom-feature]`
- **Un commit par feature validée** — un seul commit propre sur la branche `feat/`, après validation `/recette`. Pas de commits intermédiaires pendant le dev.
- Merge dans `main` après validation `/recette` ✅
- Branche supprimée après merge
- PR (Pull Request) optionnelle en solo — recommandée pour forcer une relecture avant merge

---

## Doctrine — Agents IA

### Skill ou agent ?

Un skill suffit quand on peut écrire les étapes avant de commencer.
Un agent se justifie quand l'exécution elle-même révèle les étapes — boucles, dépendances aux résultats intermédiaires, itérations longues.

### Cas d'usage dans le dev d'une appli

Dans la construction d'une appli, un agent se justifie surtout pour des tâches transverses, volumineuses et répétitives — pas pour construire les features une par une.

Cas typiques :
- Migration de codebase
- Audit (sécurité, code mort, incohérences)
- Génération de documentation
- Génération de tests en masse

### Point de décision dans la chaîne

La décision se prend au moment du `/specs`. C'est là qu'on sait exactement ce qu'on doit produire. Si une tâche correspond aux critères ci-dessus, on le note dans la spec : "cette tâche sera traitée par un agent".

Question systématique en fin de `/specs` : est-ce que l'une de ces tâches justifie un agent ?

Si oui :
- Le documenter dans la spec
- Définir la checklist de vérification avant de lancer l'agent

### Règles opérationnelles

- Un agent co-construit avec Medwin doit avoir une checklist de vérification définie avant lancement
- Claude vérifie le résultat de chaque agent avant de valider
- Pour les sous-agents spawned par Claude : modèle choisi selon la complexité (Haiku / Sonnet / Opus), retour en Sonnet après la sous-tâche

---

## Refactoring

Le refactoring est une discipline à part entière avec ses propres règles et son propre workflow. Doctrine complète : `refacto.md`. Skill d'exécution : `/refacto`.

Trois déclencheurs dans le workflow :

**Avant une feature** — si le module ciblé présente des signaux de dégradation (duplication, logique floue, responsabilités mélangées) → diagnostic d'abord, refactoring si confirmé, feature ensuite.
`/refacto → /sessionCode (feature)`

**Fin de phase** — après validation de toutes les features de la phase par `/recette`, avant release. Session de stabilisation.
`/recette (dernière feature) → /refacto → release`

**On-demand** — ciblé, justifié par un signal concret. Doit rester l'exception.

**Règle absolue :** le refactoring exige sa propre session dédiée. Jamais mélangé avec une feature en cours ou un bug fix. Si une session est en cours → `/maj`, `/clear`, puis `/todo` → refactoring en première action.

---

## Skills transversaux

Ces skills peuvent être invoqués à tout moment dans le workflow, quelle que soit la phase :

| Skill | Quand l'utiliser |
|---|---|
| `/party` | Sur toute décision structurante où une seule perspective risque d'être incomplète (choix archi, priorisation, découpage V1/V2) |
| `/securite` | Analyse sécurité du PRD ou vérification sécurité d'une feature |
| `/debug` | Dès qu'un bug bloque la progression |
| `/refacto` | Avant une feature sur un module dégradé, fin de phase, ou on-demand |

---

## Règle transversale

Rien n'entre dans le système (fichiers, règles, code) sans discussion préalable et validation explicite de Medwin.
