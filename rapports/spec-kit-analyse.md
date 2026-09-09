# Spec Kit (GitHub) — analyse et avis pour la vibe-method

Rédigé le 07/09/2026. Sources lues : le dépôt `github/spec-kit` cloné au commit
`4a0b392`-équivalent amont `4a7341a` du 04/09/2026 (version `1.0.5.dev0`, dernière
release 1.0.4 du 02/09/2026) — `README.md`, `spec-driven.md`, les 5 templates
d'artefacts, les 10 commandes de `templates/commands/`, `docs/concepts/*`,
`docs/guides/*`, `docs/history.md`, la constitution dogfood `.specify/memory/constitution.md`,
le preset `lean`, l'intégration Claude Code (`src/specify_cli/integrations/claude/__init__.py`),
le script `scripts/bash/create-new-feature.sh`. Côté vibe-method : `workflow-doc.md`,
`specs.md`, `readyTo-code.md`, en-têtes de `gherkin`, `angles-morts`, `prd-validate`,
`regles`, `prp`, `to-issues`, `sessionCode`. Le wiki ne connaît Spec Kit que par une
ligne de `traite-vibe-coding-rech.md` (« artillerie lourde »).

Non lu : le code du moteur de workflows, le bundler, les 157 extensions communautaires,
les walkthroughs. L'avis ci-dessous ne porte donc pas sur la robustesse du CLI.

---

## 1. Ce qu'est l'objet

Spec Kit est un **outil en ligne de commande Python** (`specify`, installé par `uv`)
qui pose dans un dépôt un répertoire `.specify/` (templates, scripts, mémoire) et
installe dans l'agent de code choisi une dizaine de commandes slash. Pour Claude Code,
elles arrivent sous `.claude/skills/speckit-*/SKILL.md`. 51 intégrations d'agents.

Il a un an (premier commit 21/08/2025, version 1.0.0 le 21/08/2026). Mainteneur
principal depuis janvier 2026 : Manfred Riem. La communauté a construit dessus un
système d'extensions, de presets, de workflows et de bundles — c'est aujourd'hui la
majeure partie du code.

### Le processus cœur

| Commande | Produit | Rôle |
|---|---|---|
| `/speckit.constitution` | `.specify/memory/constitution.md` | Principes du projet, une fois. Versionné en SemVer avec « Sync Impact Report ». |
| `/speckit.specify` | `specs/NNN-nom/spec.md` | Spec d'une feature : user stories priorisées P1/P2/P3 chacune « testable indépendamment », scénarios Given/When/Then, exigences FR-xxx, critères de succès SC-xxx mesurables et sans technologie, hypothèses. Génère aussi `checklists/requirements.md`. |
| `/speckit.clarify` | modifie `spec.md` | 5 questions max, une à la fois, à choix fermé, recommandation en tête. Chaque réponse est écrite immédiatement dans la spec sous `## Clarifications / ### Session AAAA-MM-JJ` **et** intégrée dans la section concernée, en remplaçant le texte contradictoire. |
| `/speckit.plan` | `plan.md`, `research.md`, `data-model.md`, `contracts/`, `quickstart.md` | Contexte technique, gate constitutionnel, recherche des inconnues, modèle de données, contrats d'interface. |
| `/speckit.tasks` | `tasks.md` | Tâches `- [ ] T001 [P] [US1] description + chemin de fichier`, groupées par phase (Setup → Foundational → une phase par user story → Polish). `[P]` = parallélisable. MVP = US1 seule. |
| `/speckit.analyze` | rapport, lecture seule | Cohérence croisée spec/plan/tasks : doublons, adjectifs vagues, exigences sans tâche, tâches sans exigence, dérive terminologique, violation de la constitution. Tableau de couverture exigence → tâches. Sévérité CRITICAL/HIGH/MEDIUM/LOW. |
| `/speckit.checklist` | `checklists/<domaine>.md` | « Tests unitaires pour de l'anglais » : questions sur la **qualité des exigences** (« "affichage proéminent" est-il quantifié ? »), jamais sur le comportement du code. |
| `/speckit.implement` | code | Exécute toutes les tâches, coche `[X]`, s'arrête sur échec. |
| `/speckit.converge` | ajoute une `## Phase N: Convergence` à `tasks.md` | Compare le **code présent** à spec/plan/tasks, classe les écarts `missing` / `partial` / `contradicts` / `unrequested`, ajoute une tâche traçable par écart. Append-only. Boucle implement → converge jusqu'à « Converged ». |
| `/speckit.taskstoissues` | issues GitHub | Une issue par tâche, dédoublonnage par ID. |

Deux extensions livrées, optionnelles : `bug` (assess → fix → test) et `assess`
(intake → research → define → shape → decide, verdict go / clarifier / tuer).

### Ce que la doc dit d'utile au-delà des commandes

- **Trois modèles de persistance des specs** (`docs/concepts/spec-persistence.md`),
  reprenant la taxonomie de Martin Fowler (spec-first / spec-anchored / spec-as-source)
  et y ajoutant la question de la mutation : *flow-back* (n'importe quel artefact
  s'édite, puis on réconcilie), *flow-forward* (les artefacts finis sont immuables, un
  nouveau répertoire par changement), *living spec* (la spec est le contrat, plan et
  tâches se régénèrent). Spec Kit n'en impose aucun.
- **« Spec of specs »** (`docs/concepts/spec-of-specs.md`) : quand une feature dépasse
  un cycle, une passe de découpage produit un `roadmap.md` (tableau ID / intent /
  frontière / dépendances / statut / lien), chaque tranche a sa propre spec avec
  rétro-lien. C'est une roadmap, comme `[projet].Rmap.md`.
- **Épuisement de contexte pendant `implement`** (`docs/concepts/complex-features.md`) :
  reconnu comme cause principale des dérives ; remèdes : limiter les tâches par
  invocation, déléguer les `[P]` à des sous-agents, découper.
- L'intégration Claude Code a **désactivé le `context: fork`** pour `analyze` : le
  rapport de 300 à 500 lignes réinjecté dans la conversation faisait geler les
  sessions longues (issue #3185, commentaire dans le code).

---

## 2. Mise en regard avec la vibe-method

### 2.1 Périmètre

Spec Kit commence **à la feature**. Son seul artefact de niveau projet est la
constitution. Tout ce que la vibe-method fait avant `/specs` — `/contexte`, `/brief`,
`/devis`, `/cgv`, `/charte`, `/prd` et sa cross-pollination, `/prd-validate`, `/archi`,
`/design`, `/stack`, `/setup`, `/regles`, `/backup`, `/roadmap` — n'a pas d'équivalent.
Le `plan.md` de Spec Kit condense en un fichier par feature ce que `/archi` + `/stack`
font une fois par projet.

Inversement, ce que Spec Kit a et que la vibe-method n'a pas, ou pas sous cette forme :

| Mécanisme Spec Kit | Équivalent vibe-method | Écart réel |
|---|---|---|
| `analyze` : matrice exigence ↔ tâche, exigences orphelines, tâches orphelines, dérive de vocabulaire | `/readyTo-code` vérifie la **présence** des artefacts ; `/prd-validate` la cohérence interne du PRD ; `/gherkin` la testabilité ; `/impact` la propagation d'un changement | **Aucun skill ne vérifie qu'une règle de gestion a une tâche/issue et une scénario Gherkin, et qu'aucune tâche ne sort de la spec.** C'est le trou le plus net. |
| `converge` : écart code ↔ spec après implémentation, classé, transformé en tâches | `/recette` (validation manuelle depuis Gherkin), `/code-review` (qualité), `/tests` | Rien ne lit le code pour dire « FR-003 n'est pas implémenté, la règle 4 l'est à moitié, ce module n'est demandé nulle part ». `/recette` le découvre à la main, plus tard. |
| `clarify` : réponse écrite dans l'artefact **dans le tour**, section datée, texte contradictoire remplacé | `/angles-morts` : « les décisions alimentent le document source » — sans dire comment, ni quand | Le principe est le même ; Spec Kit a le mécanisme, la vibe-method a l'intention. Directement lié à la règle « ce qui est annoncé s'écrit dans le tour ». |
| `checklist` : questions sur la qualité des exigences, par domaine, réutilisables | Quality Gates embarquées dans `/brief` (16), `/prd` (9), `/archi` (12) ; `/angles-morts` (5 catégories) | Recouvrement partiel avec `/angles-morts`. La distinction « tester l'énoncé, pas le comportement » est nette et transférable. |
| `tasks.md` : ID, `[P]`, `[US1]`, chemin de fichier, MVP = US1, checkpoint par story | `/roadmap`, `/to-issues` (HITL/AFK, dépendances), `/avancement` | `/to-issues` est au niveau feature ; Spec Kit descend au fichier. Utile en mode AFK, marginal en HITL. |
| constitution versionnée SemVer + rapport d'impact | `/regles` + `CLAUDE.md` projet + doctrines wiki | La vibe-method a plus de matière ; Spec Kit a le versionnage. |
| modèles de persistance nommés | `/spec` (spec-global vivante) + `/impact` = *living spec* avec réconciliation | Vocabulaire à emprunter, rien à construire. |
| `assess` (idée → go/kill) | `/contexte` + `/brief` + `/devis` | Couvert, et mieux (le devis chiffre). |
| `bug` (assess → fix → test) | `/debug` + `/diagnose` | Couvert. |

### 2.2 Où les philosophies divergent

- **Défauts raisonnables plutôt que questions.** `specify` : « make informed guesses »,
  3 marqueurs `[NEEDS CLARIFICATION]` maximum, le reste est deviné et consigné en
  hypothèses. La vibe-method fait l'inverse : élicitation domaine par domaine, une
  question à la fois, rien décidé seul (règle posée pour Claude Design : « chaque
  décision non prise est une décision prise seul »). Les deux positions sont
  défendables ; elles ne se mélangent pas dans le même skill.
- **`implement` exécute toute la feature d'un trait.** La vibe-method fait `/sessionCode`
  avec un PRP sous 1 000 tokens, un sas par session, `/tests` TDD avant. Spec Kit
  documente lui-même que son approche sature le contexte.
- **Tests optionnels.** `tasks-template.md:12` et `commands/tasks.md:147` : « Tests are
  OPTIONAL - only include them if explicitly requested ». Contradiction interne avec
  `spec-driven.md:312` : « This is NON-NEGOTIABLE: All implementation MUST follow strict
  Test-Driven Development ». L'essai fondateur décrit encore neuf articles
  (Library-First, CLI obligatoire…) que le template de constitution ne prescrit plus.
  La doctrine écrite est en retard sur les templates. `tests-doc.md` de la vibe-method
  est plus stricte et cohérente.
- **Outillage.** Python 3.11 + `uv`, `.specify/`, `specs/NNN-nom/`, scripts bash/ps1/py
  en triple exemplaire, ~60 lignes de prose « extension hooks » dans chacune des dix
  commandes (un cinquième à un tiers de chaque prompt, lu à chaque invocation). La
  vibe-method, ce sont des fiches markdown dans le wiki, liées par `install.sh`,
  lisibles par Hermes. Adopter Spec Kit, c'est adopter un second système de skills à
  côté du premier.

---

## 3. Avis

**Ne pas adopter Spec Kit comme outil.** Il couvre la moitié aval de la méthode avec
moins de matière (pas de PRD, pas d'archi projet, pas de design, pas de devis), il
impose un outillage Python et une arborescence étrangère, et ses commandes portent une
mécanique d'extensions qui ne sert à rien en solo. Ce que la ligne du wiki appelle
« artillerie lourde » est juste : lourd sur l'infrastructure, léger sur le contenu.

**Importer quatre mécanismes**, par ordre de valeur :

1. **Un contrôle de couverture croisée** (calqué sur `analyze`). Lecture seule.
   Pour chaque règle de gestion, cas limite, cas d'échec, NFR du PRD applicable :
   a-t-elle un scénario Gherkin ? une issue ou une ligne de roadmap ? Chaque tâche
   remonte-t-elle à une règle ? Même vocabulaire d'un artefact à l'autre ? Sortie :
   tableau de couverture + écarts classés. Emplacement naturel : une étape 8 de
   `/readyTo-code`, ou un skill à part si le rapport est long — la leçon de
   l'issue #3185 vaut ici : un rapport de 300 lignes réinjecté dans la session coûte
   plus qu'il ne rapporte, écrire sur disque et résumer.
2. **Une passe d'écart code ↔ spec** (calquée sur `converge`), avant `/recette`.
   Lit la spec et le code, classe `manquant / partiel / contredit / non demandé`,
   propose des tâches. Ne touche ni au code ni à la spec. Emplacement : un mode de
   `/code-review`, ou l'ouverture de `/recette`. Compatible avec la doctrine
   anti-auto-validation : c'est une lecture, pas un test qui se déclare vert.
3. **Le mécanisme d'écriture de `clarify` dans `/angles-morts`** : chaque décision
   prise (Traiter / Accepter le risque / Hors scope) s'écrit dans l'artefact source
   **dans le tour**, sous une section `## Clarifications / ### Session JJ/MM/AAAA`,
   et la section concernée est modifiée en remplaçant le texte devenu faux. Aujourd'hui
   `/angles-morts` produit « aucun fichier ». C'est précisément le défaut que la règle
   « ce qui est annoncé s'écrit dans le tour » (conduite-de-chantier §2) vise.
4. **La distinction « tester l'énoncé, pas le comportement »** de `checklist`, comme
   garde-fou écrit dans `/angles-morts` et dans les Quality Gates : une ligne de
   contrôle qui commence par « vérifier que le bouton… » teste le code ; « le délai
   d'annulation est-il quantifié ? » teste la spec. Pas de nouveau skill.

**À prendre comme vocabulaire, sans construire** : les trois modèles de persistance
(la vibe-method pratique *living spec* + réconciliation par `/impact` ; le nommer dans
`methode-doc.md` ou `workflow-doc.md` évite de le redécouvrir).

**À ne pas prendre** : `implement` (contraire à `/sessionCode`), les défauts raisonnables
de `specify` (contraire à l'élicitation), la constitution (redondante avec `/regles` +
CLAUDE.md + doctrines), extensions / presets / bundles / workflows, `assess`, `bug`.

### Ce qui reste à vérifier avant de construire

- Le point 1 suppose que les règles de gestion des specs soient identifiables une à une.
  Le format A4 les liste en puces non numérotées ; Spec Kit numérote (FR-001). Numéroter
  les règles dans `/specs` est un préalable, à décider.
- Le point 2 n'a pas été essayé sur un projet réel ; RAMrezo serait le terrain.
- Je n'ai pas exécuté `specify init` ni lancé une commande : l'avis porte sur les
  prompts et la doc, pas sur le comportement observé.
