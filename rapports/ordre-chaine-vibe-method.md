> **Provenance — fichier reconstruit le 20/08/2026.** Original écrit le 14/08/2026 dans un
> scratchpad de session depuis effacé. Rejeu du `Write` initial puis des 23 `Edit` enregistrés
> dans `~/.claude/projects/-Users-medwinrumo-dev-RAMrezo/a44f168c-.../subagents/agent-a427612b823a13308.jsonl`.
> 22 edits sur 23 appliqués ; le seul en échec portait sur les tiers de `/archi` et `/setup` et
> son texte cible est présent dans le fichier (ligne ~688), produit par un edit ultérieur.
> Aucun `old_string` ambigu. 1 213 lignes — décompte identique à celui inscrit au
> `RAMrezo.todo.md` le 14/08.
>
> **Réserve de lecture** : le §1.4 « il y avait quatre chaînes » a été **réfuté le soir même**.
> `init-projet.md:68` est un commentaire HTML listant les skills qui écrivent une section du
> `CLAUDE.md`, pas une séquence d'exécution. Il y avait deux chaînes, divergentes d'un seul
> maillon. Voir `RAMrezo.todo.md`, section « 4 — Un bug réel dans le premier geste d'un projet neuf ».

---

# Ordre de la chaîne vibe-method — proposition

**Statut : proposition. Rien n'a été modifié.** Aucun skill, aucune doctrine, aucun fichier
de projet n'a été touché pour produire ce document. Medwin tranche.

Établi le 14/08/2026 par lecture des skills de `~/dev/wiki/`, des doctrines associées, et
de l'état réel du projet RAMrezo.

---

## En bref

**Le problème n'est pas l'ordre, c'est que la chaîne n'est pas exécutable.** La chaîne à
treize nœuds corrigée le 14/08 s'arrête à son troisième nœud : `/design` refuse de démarrer
sans `/charte`, qui n'y figure pas. Sept autres skills omis sont dans le même cas — chacun
fait s'arrêter ou avertir un skill aval (§1.1-1.2).

**Il n'y avait pas deux chaînes divergentes, il y en avait quatre** (§1.4). La quatrième est
dans `init-projet.md` : c'est elle qui est écrite dans le `CLAUDE.md` de chaque nouveau
projet. Tant qu'elle n'est pas corrigée, la correction du 14/08 ne survit pas au prochain
projet.

**Sur `/setup` : oui, l'avancer — juste après `/stack`.** Fait décisif, vérifié par `grep` :
`setup.md` ne lit que `archi.md` et `stack.md`, et ne contient **aucune** occurrence de
`Rmap`, `roadmap`, `spec.` ou `prd`. Le périmètre dont il a besoin est celui des *modules*,
pas celui des *fonctions*. L'objection « monter un projet avant de connaître le périmètre »
n'a donc aucun appui dans le skill (§5.2).

**Les sept changements**, par ordre de rentabilité décroissante :

| # | Changement | § |
|---|---|---|
| 1 | `/setup` remonte après `/stack` | §5 |
| 2 | `init-projet.md` corrigé en même temps que `methode-doc.md` | §1.4, §6.1 |
| 3 | `/design` compte pour deux nœuds (Mode A conception, Mode B après `/setup`) | §1.3, §4.4 |
| 4 | `/backup` se coupe en deux passes (0-6 après `/setup`, 7-8 avant `/deploy`) | §5.4 |
| 5 | `/charte`, `/securite analyse`, `/gherkin PRD`, `/regles`, `/prp`, `/avancement`, `/readyTo-code`, `/prd-validate` réintègrent la chaîne | §1.2 |
| 6 | Cinq maillons déclarés non implémentés à corriger (dont STRIDE absent d'`/archi`) | §3 |
| 7 | `/regles` passe après `/setup` | §3.7 |

**Une chaîne unique n'est pas le bon objet** — mais les variantes n'ont pas à être inventées :
dix gardes conditionnels existent déjà **à l'intérieur des skills** et sont invisibles depuis
une liste de flèches (§7.1). Le bon objet est un graphe qui fait foi, avec des vues linéaires
dérivées et datées.

**Ce que dit la littérature (§10).** Elle corrobore l'avancement de `/setup` par trois chemins
indépendants — l'horizon de pensée de Cockburn, le « R&D mode » de Shape Up, et la réserve du
SEI sur la *baseline architecture*. Elle **tempère la forme** de la recommandation : aucun
auteur de source primaire ne prescrit une position fixe, seulement un critère. Et elle
**renforce le verdict négatif** sur RAMrezo — COCOMO II : « High Assurance: rightward », on
n'allège pas la conception d'un projet en risque Élevé pour tenir une date.

**Un avertissement.** L'épreuve du terrain RAMrezo est **en partie négative** : le
réordonnancement ne crée pas de temps, et le facteur limitant au 4 septembre est le périmètre
V1, pas l'ordre (§9).

---

## 0. Convention de preuve

Toute affirmation de ce document porte une étiquette. Elle indique **comment** je le sais,
pas à quel point j'y crois.

| Étiquette | Signification |
|---|---|
| `[grep]` | Vérifié par recherche mécanique sur le fichier. Le plus fort — une absence constatée par `grep` sur un terme unique et non ambigu (`STRIDE`) est une absence. |
| `[lu]` | Vérifié par lecture de la section concernée du fichier réel. |
| `[inféré]` | Déduction à partir de ce qu'un skill **écrit** ou **exige**, non déclarée par lui. Contestable. |

Ce que je n'ai **pas** fait, et qui limite ce document :

- Je n'ai lu intégralement que les skills du cœur de chaîne. `/code-review*`, `/repair-edge-cases`,
  `/phase-retrospective`, `/doc-tech`, `/refacto`, `/impact`, `/party`, `/prototype` n'ont été lus
  que via leur description et leur passage dans `workflow-doc.md`. Une dépendance déclarée dans
  leur corps m'aurait échappé.
- Je n'ai pas exécuté `lint-wiki.py` ni `lint-observabilite.py`. J'ai constaté leur présence sur
  disque, pas leur comportement.
- J'ai cherché les porteurs de chaîne par `grep` sur les motifs de flèches entre skills. Cela
  a ramené **quatre** versions (§1.4), dont une que je n'avais pas vue à la première passe.
  La recherche porte sur une écriture en flèches : **une chaîne décrite en prose, sans flèches,
  y échapperait** — c'est précisément le mode de défaut que `conduite-de-chantier` §3 décrit.
  Je ne peux donc pas affirmer qu'il n'y en a que quatre.

---

## 1. Le constat qui prime : la chaîne corrigée aujourd'hui n'est pas exécutable

La mission part de l'hypothèse que l'ordre est mauvais. **L'ordre est un problème secondaire.**
Le problème premier est que la chaîne à treize nœuds, telle qu'écrite après la correction du
14/08, ne peut pas être parcourue jusqu'au bout : elle s'arrête au troisième nœud.

### 1.1 — `/design` s'arrête net faute de `/charte`, absent de la chaîne

`design.md` Étape 0 (Mode A) `[lu]` :

> Si la charte est absente → tu t'arrêtes :
> « La charte graphique n'est pas définie. Lance `/charte` d'abord. »

`/charte` **ne figure dans aucune des deux chaînes alignées le 14/08** `[grep]`. La chaîne
canonique passe de `/prd` à `/design`. Le troisième nœud de la chaîne corrigée s'arrête donc
sur une instruction de lancer un skill que la chaîne ne mentionne pas.

### 1.2 — Ce n'est pas un oubli isolé : c'est la classe entière des skills retirés

Chaque skill présent dans `workflow-doc.md` et absent de la liste à treize nœuds est un skill
dont l'absence **fait s'arrêter ou avertir un skill situé en aval** `[lu]` :

| Skill absent de la chaîne à 13 nœuds | Ce qui casse en aval |
|---|---|
| `/charte` | `/design` Mode A s'arrête (§1.1) |
| `/prd-validate` | `/readyTo-code` Étape 1 vérifie « PRD validé par `/prd-validate` (mention dans le fichier) » |
| `/securite analyse` | Déclaré « après `/prd`, avant `/archi` » — c'est l'entrée de l'étape `/archi` 3c, celle-là même où STRIDE manque (§3.1) |
| `/gherkin` Mode PRD | Déclaré porte avant `/archi` : « Fin si GO : prochaine étape `/archi` » |
| `/regles` | `/readyTo-code` Étape 4 → Warning ; `/sessionCode` rappelle « les 5 règles les plus importantes de `[projet].regles.md` » |
| `/prp` | `/readyTo-code` Étape 5 → **Blocker** ; `/sessionCode` Étape 1 s'arrête sans lui |
| `/avancement` | `/readyTo-code` Étape 6 → Warning ; `/sessionCode` Vérification 2 le lit |
| `/readyTo-code` | La seule porte mécanique entre « on a conçu » et « on code » |

Le nœud « code » de la chaîne à treize nœuds recouvre à lui seul `/readyTo-code`, `/prp`,
`/avancement`, `/sessionCode`, quatre skills de revue et `/commit`. Ce n'est pas un raccourci
de présentation : c'est ce qui a permis à `/setup` d'être mal placé sans que ça se voie.

### 1.3 — `methode-doc.md` se contredit à l'intérieur d'une seule phase

`methode-doc.md`, Phase 2 — Design `[lu]` :

> 3. `/design` Mode A + `/archi` en aller-retour
> 4. Claude Design (outil externe) reçoit le(s) fichier(s) → produit le code HTML/CSS
> 5. `/design` Mode B — intégration dans Tailwind (web) ou NativeWind (natif)
> 6. Révision in-browser obligatoire — corriger les défauts visuels et UX **directement dans
>    le code**, [...] **avant de passer à la Phase 3**

Trois défauts dans ces quatre lignes :

- **La Phase 2 contient `/archi` (étape 3), et la Phase 3 *est* l'architecture.** La phase
  suivante est déjà faite quand on y arrive.
- **L'étape 5 intègre du code Tailwind dans un projet, et l'étape 6 l'ouvre dans un navigateur.**
  Or le projet n'existe qu'au `/setup`, huitième nœud de la chaîne, trois phases plus loin.
  La Phase 2 exige donc un projet qui tourne cinq étapes avant que la chaîne ne le crée.
- **`design.md` place Mode B ailleurs** : « Mode B intervient après que Claude Design a produit
  le code — **après `/stack`**, avant le code métier » `[lu]`. `workflow-doc.md` place la révision
  in-browser encore ailleurs : « avant de passer à `/roadmap` » `[lu]`. Trois emplacements pour
  la même étape, dans trois fichiers, dont deux sont la même doctrine.

C'est la démonstration la plus économique que la chaîne n'est pas exécutable : **il n'existe
aucune lecture de `methode-doc.md` sous laquelle sa Phase 2 puisse être menée à bien.**

### 1.4 — Il n'y avait pas deux chaînes divergentes, il y en avait quatre

La mission décrit deux chaînes alignées le 14/08. Il en existe deux autres.

La troisième est **liée depuis `methode-doc.md` lui-même** (ligne 21 : « Guide skill par skill
de toute la chaîne : `[[workflow-doc]]` ») `[lu]`.

La quatrième est la plus conséquente, et je ne l'ai trouvée qu'en cherchant explicitement s'il
en existait d'autres `[grep]`. Elle est dans `init-projet.md`, à l'intérieur du **gabarit de
`CLAUDE.md` écrit dans chaque nouveau projet à sa création** `[lu]` :

```
<!-- Sections ajoutées automatiquement : /contexte → /brief → /charte → /prd →
     /securite → /design → /archi → /regles → /stack → /adr -->
```

| Source | Date | Nœuds | `/charte` | `/securite` | Position de `/setup` | Position de `/backup` |
|---|---|---|---|---|---|---|
| `methode-doc.md` | 14/08/2026 | 13 | absent | absent | après `/specs` | après `/setup` |
| `CLAUDE.md` RAMrezo | 14/08/2026 | 13 | absent | absent | après `/specs` | après `/setup` |
| `workflow-doc.md` | 06/08/2026 | ~30 | présent | présent | après `/readyTo-code` | Partie 8, avec `/deploy` |
| **`init-projet.md`** | — | **10** | **présent** | **présent** | **absent** | **absent** |

Trois observations, dans l'ordre d'importance :

- **La quatrième chaîne est le mécanisme de propagation.** `/init-projet` l'écrit dans le
  `CLAUDE.md` de tout nouveau projet. C'est donc elle qui sème la chaîne que chaque projet
  édite ensuite pour son compte — ce qui explique qu'un `CLAUDE.md` de projet ait pu diverger
  de la doctrine sans que rien ne le signale. Corriger `methode-doc.md` sans corriger
  `init-projet.md` garantit que le prochain projet redémarre sur la version périmée.
- **Elle s'arrête à `/adr`.** Ni roadmap, ni specs, ni setup, ni backup, ni code, ni tests, ni
  recette, ni deploy. Un projet créé aujourd'hui reçoit une chaîne qui s'arrête avant le
  premier artefact d'exécution.
- **Elle est pourtant la seule des quatre à porter `/charte` *et* `/securite` au bon endroit**
  — c'est-à-dire les deux skills dont §1.1 et §1.2 montrent que leur absence casse l'aval.
  La chaîne la plus courte est celle dont le début est le plus juste.

`workflow-doc.md` n'a pas été mis à jour par la correction du 14/08. Elle porte donc encore
`/backup` en toute fin de chaîne, à l'endroit exact que la correction visait à changer.

**C'est `conduite-de-chantier.md` §3 en action** : « une phrase qui *décrit* une organisation
[...] est invisible à un `grep` de chemin, et survit intacte à la migration qui la rend
fausse ». La correction du 14/08 a modifié deux listes de flèches ; elle n'a pas touché le
document de 60 Ko qui décrit la même chaîne en prose, et que `methode-doc.md` désigne comme
sa référence détaillée.

**Conséquence pour cette mission :** réordonner la liste à treize nœuds sans traiter ce point
produira une quatrième version divergente. La recommandation de §6 en tient compte.

---

## 2. Carte des dépendances réelles

### 2.1 — Note de méthode : ceci corrige une table existante, n'en crée pas une quatrième

`workflow-doc.md` se termine déjà par une table `Artefact / Skill producteur / Consommateurs`
`[lu]`. C'est un graphe de dépendances en germe. Il est **incomplet de façon vérifiable** :

> `[projet].stack.md` | `/stack` | `/roadmap, /specs, /prp`

Or `setup.md` Étape 0 s'arrête si `stack.md` est absent `[lu]`, et `tests.md` Étape 0 le
lit pour les patterns de mock `[lu]`. Deux consommateurs manquants sur une ligne de quatre.

La table ci-dessous est donc proposée **en remplacement de celle-là, au même endroit**, pas
comme un nouveau document. Une table de plus serait une source de vérité de plus.

### 2.2 — Entrées, sorties, comportement en cas d'absence

Colonne « Si l'entrée manque » = comportement **déclaré par le skill lui-même**, verbatim
condensé. `STOP` = le skill refuse de démarrer.

| Skill | Entrées déclarées (Étape 0) | Sortie | Si l'entrée manque |
|---|---|---|---|
| `/init-projet` | nom du dossier courant | dépôt Git local + GitHub, `CLAUDE.md`, `.todo.md`, `.log.md`, `.context.md` | — |
| `/contexte` | `.context.md` existant (optionnel) | `[projet].context.md` | démarre de zéro |
| `/brief` | `.context.md` (opt.), `.brief-wip.md` (reprise) | `[projet].brief.md` + `.brief-wip.md` incrémental | continue sans |
| `/devis` | `.context.md` **et** `.brief.md` | `[projet].proposition.md` | — |
| `/cgv` | `.brief.md` + `.proposition.md` | `[projet].cgv.md` | — |
| `/charte` | `.brief.md` | `[projet].charte.md` | **continue**, pose plus de questions |
| `/prd` | `.brief.md` | `[projet].prd.md` V1 | **STOP** — « Lance `/brief` » |
| `/prd-update` | `.prd.md` + retours cross-pollination | `.prd.md` V2 (V1 préservée) | — |
| `/prd-validate` | `.prd.md` | aucun — verdict GO / BLOCKERS | **STOP** — « Lance `/prd` » |
| `/securite analyse` | `.prd.md` | **aucun fichier déclaré** — alimente `/archi` | demande le PRD |
| `/gherkin` Mode PRD | `.prd.md` | aucun — verdict GO / RETOUR PRD | — |
| `/angles-morts` | `.prd.md` / `.archi.md` / `.spec.*.md` | **« aucun » déclaré** — voir §3.5 | — |
| `/design` Mode A | **`.charte.md`**, `.prd.md`, `.archi.md` (si dispo) | `[projet].design.md` | **STOP** — « Lance `/charte` » |
| `/archi` | `.prd.md` | `[projet].archi.md` + 2 blocs dans `CLAUDE.md` | — |
| `/regles` | `.prd.md`, `.archi.md`, `CLAUDE.md` | `[projet].regles.md` | — |
| `/stack` | **la stack choisie, définie dans `/archi`** | `[projet].stack.md` + section `CLAUDE.md` | **STOP** — « Lance `/archi` d'abord pour choisir entre Stack A et Stack B » |
| `/design` Mode B | `.design.md` + code Claude Design collé | `tailwind.config.ts`, `globals.css`, `theme/tokens.ts` — **dans le projet** | — |
| `/roadmap` | `.prd.md`, `.archi.md`, `.context.md` (si présent) | `[projet].Rmap.md` | **STOP** ×2 |
| `/specs` | `.prd.md`, `.archi.md`, `.Rmap.md` | `[projet].spec.[feature].md` | **STOP** |
| `/gherkin` Mode Specs | `.spec.[feature].md` | `[projet].gherkin.[feature].md` | — |
| `/to-issues` | `.Rmap.md`, `.spec.*.md` | issues GitHub | — |
| `/prp` | `.brief`, `.prd`, `.archi`, `CLAUDE.md`, `.stack`, `.tests`, `.spec.[feature]`, `.gloss` (opt.) | `[projet].prp.md` ≤ 1 000 tokens | **signale et continue** — « ne pas bloquer sur un fichier absent » |
| `/readyTo-code` | `.prd`, `.archi`, `.spec.*`, `.project-context.md`, `.prp`, `.avancement.yaml` | aucun — verdict GO / BLOCKERS | Blocker sur PRD, archi, specs, PRP ; Warning sur les 2 autres |
| **`/setup`** | **`.archi.md` + `.stack.md`, et rien d'autre** `[grep]` | projet qui tourne, structure de dossiers, `tsconfig` aliases, `.env.example`, `.gitignore`, 1er commit | **STOP** ×2 |
| `/avancement` | `.Rmap.md` **et** `.prd.md` (mode init) | `[projet].avancement.yaml` | propose de créer depuis la roadmap |
| `/backup` | `.archi.md` § « Backup & RGPD » | workflows GitHub Actions, dépôts miroir GitHub + GitLab | **STOP** ; **Niveau 1 → arrêt volontaire** |
| `/sessionCode` | `.prp.md`, `.spec.[feature].md`, `.avancement.yaml` | aucun | **STOP** ×3 |
| `/tests` | `.spec.[feature].md`, `.archi.md`, `.stack.md` | fichiers de test + `[projet].tests.md` | **STOP** sans User Stories ; continue sans `.stack.md` |
| `/securite check` | code de la feature | verdict **bloquant** | — |
| `/recette` | `.spec.md` *(sic — voir §3.4)*, `.gherkin.[feature].md`, **une app qui tourne** | `[projet].recette.md` | **STOP** |
| `/deploy` | `.archi.md` (niveau 1/2/3), `CLAUDE.md` | `[projet].deploy.md` | **STOP** si niveau non défini |

### 2.3 — Ce que la carte révèle immédiatement

**Trois skills seulement exigent un projet qui tourne** : `/design` Mode B `[inféré]`,
`/recette` `[lu` — « l'app tourne en local ou sur un serveur de staging »`]`, et le code
lui-même. Un quatrième l'exige à moitié : `/backup`, dont les étapes 7 et 8 seules en
dépendent (§4.3).

**`/setup` n'a que deux entrées, toutes deux disponibles avant `/roadmap`.** `[grep]` : le
fichier `setup.md` ne contient **aucune** occurrence de `Rmap`, `roadmap`, `spec.` ou `prd`.
Ses étapes 3, 5 et 6 (dépendances, structure de dossiers, variables d'environnement)
dérivent toutes de la liste de modules de l'archi et de la liste d'outils du stack. C'est le
fait qui tranche la question de §4.

**La stack est décidée par `/archi`, pas par `/stack`.** `stack.md` Étape 0 : « Si la stack
n'est pas définie → tu t'arrêtes : *Lance `/archi` d'abord pour choisir entre Stack A
(Convex) et Stack B (Supabase)* » `[lu]`. `/stack` **investigue** une décision déjà prise. Le
`CLAUDE.md` de RAMrezo dit l'inverse : « Stack backend à définir : **via `/stack`** — options
Convex, Supabase, Firebase » `[lu]`. Le projet réel a inversé la relation déclarée. Voir §5.4.

---

## 3. Dépendances déclarées et non implémentées

Une doctrine ou un skill annonce un maillon ; le skill censé le porter ne le porte pas.
Ces trous ne se voient pas à l'usage — ils produisent un livrable d'apparence complète.

### 3.1 — STRIDE : `securite-doc.md` §6.2 en exige six, `archi.md` en pose cinq

`securite-doc.md` §6.2 « Phase /archi », **Questions obligatoires** `[lu]` : six questions
numérotées. La sixième est un **threat modeling STRIDE sur chaque frontière de confiance**,
avec l'insistance explicite : « Un passage systématique, pas juste "on verra à l'usage" ».

`archi.md` Étape 3c — Questions de sécurité structurantes `[lu]` : cinq questions —
rôles/permissions, multi-tenant, webhooks entrants, requêtes serveur vers URLs utilisateur,
app mobile. Correspondance exacte avec les questions 1 à 5 de la doctrine.

**La sixième est absente.** `[grep]` : zéro occurrence de `STRIDE` ou de `threat model` dans
`archi.md`.

Aggravation : `securite-doc.md` §0 utilise STRIDE comme argument d'autorité contre une
rationalisation courante — « Toute frontière où une donnée non fiable entre est une frontière
de confiance, interne ou pas (**voir STRIDE §6.2**) » `[lu]`. La doctrine renvoie donc à une
grille que le skill chargé de l'appliquer n'applique pas.

Portée sur RAMrezo : niveau de risque **Élevé**, multi-tenant, sous-traitant RGPD. C'est le
profil pour lequel la question 6 a été écrite.

### 3.2 — Observabilité : le maillon `/stack` n'existe pas

`observabilite-doc.md` déclare quatre points d'accroche `[lu]` :

| Phase déclarée | Implémenté ? |
|---|---|
| `/stack` (Phase 4) — « Décision d'outillage, une fois par projet », « documenté dans `[projet].stack.md` **section observabilité** » | **NON** `[grep]` |
| `/specs` Étape 4c-ter | **OUI** — `specs.md:196` « Étape 4c-ter — Vérification observabilité » `[grep]` |
| Code (Phase 6) | doctrine, pas de skill dédié |
| `/deploy` Pre-Launch Gate | **OUI** — `deploy.md:215` Étape 5bis + `lint-observabilite.py`, script présent sur disque `[grep]` |

`[grep]` : zéro occurrence de `observabilit`, `instrument` ou `signaux à` dans `stack.md`.
Le gabarit de `[projet].stack.md` généré à l'Étape 5 de `stack.md` ne comporte aucune section
observabilité `[lu]`.

Ce que ça produit concrètement : `/specs` demandera les 2 à 4 questions d'instrumentation, et
`/deploy` vérifiera mécaniquement qu'elles ont une réponse — mais **personne n'aura décidé
avec quel outil** on les instrumente. La décision se prendra au moment de coder le premier
signal, hors de tout artefact, ou pas du tout.

Nuance : `stack.md` Étape 2bis demande « Le projet aura-t-il un monitoring d'erreurs (Sentry
ou équivalent) ? Quel quota gratuit ? » `[lu]`. C'est une question de **coût caché**, pas la
décision d'outillage que la doctrine réclame, et elle n'atterrit pas dans une section
observabilité. Le maillon est effleuré, pas implémenté.

### 3.3 — `/readyTo-code` cherche un fichier qu'aucun skill ne produit

`readyTo-code.md` Étape 4 — Project context : « Tu lis `[projet].project-context.md` » `[lu]`.

Aucun skill ne produit ce nom. Trois noms voisins circulent :

- `/contexte` produit `[projet].context.md` `[lu]`
- `/regles` produit `[projet].regles.md` `[lu]`
- `/readyTo-code` cherche `[projet].project-context.md` `[lu]`

Et `regles.md` Étape 0 mélange les deux lui-même : il teste l'existence de
`[projet].regles.md` puis annonce « Un **project-context** existe déjà pour [projet] » `[lu]`.
Le nom `project-context` est un ancien nom du fichier de `/regles` qui a survécu à son
renommage dans deux fichiers.

Effet réel : l'Étape 4 est un Warning, pas un Blocker. Elle produira donc **toujours** un
Warning « absent — recommandé », y compris sur un projet où `/regles` a été fait correctement.
Un avertissement qui se déclenche toujours est un avertissement qu'on cesse de lire —
`observabilite-doc.md` Étape 3 nomme exactement ce mode de panne : « un signal toujours actif
et un signal absent ont la même valeur informative — zéro — mais le premier donne l'illusion
d'une surveillance ».

### 3.4 — `/recette` se contredit à deux étapes d'intervalle

`recette.md` Étape 0 `[lu]` : « Les User Stories de la phase — dans `[projet].spec.md` » puis
« Si `[projet].spec.md` est absent → tu t'arrêtes ».

`recette.md` Étape 1 `[lu]` : « Tu génères les scénarios depuis les User Stories dans
`[projet].spec.[feature].md` ».

`/specs` ne produit **que** des fichiers par feature — « UN FICHIER PAR FEATURE, jamais un
fichier monolithique » `[lu]`. `[projet].spec.md` n'est produit par aucun skill. La porte
d'entrée de `/recette` s'arrête donc sur un fichier qui n'existe jamais, alors que son étape
suivante sait lire le bon.

### 3.5 — `/angles-morts` déclare ne rien produire ; la pratique produit un registre

`angles-morts.md` et `workflow-doc.md` déclarent tous deux : « **Fichier produit : aucun**
(les décisions alimentent le document source) » `[lu]`.

Sur RAMrezo, la passe a produit `RAMrezo.angles-morts.md`, **909 lignes**, et le `CLAUDE.md`
du projet lui donne autorité : « Le registre fait foi : `RAMrezo.angles-morts.md`, qui porte
l'état de chaque point, les décisions consignées, les angles morts nés en instruction et les
contradictions internes » `[lu]`.

Ce n'est pas un défaut, c'est l'inverse : la pratique a trouvé quelque chose que le skill ne
prévoyait pas. Un `/angles-morts` sur un document réel ouvre 17 points qui ne se traitent pas
en une séance ; sans registre persistant, l'état se perd entre les sessions. **C'est
exactement le coût que la mission demande d'optimiser — la perte de contexte entre sessions.**
Le skill devrait déclarer cette sortie.

### 3.5 bis — `/securite analyse` ne déclare aucune sortie, et `/archi` est censé la consommer

Même classe que §3.5, mais avec une conséquence plus lourde.

`securite.md` mode `analyse` `[lu]` : « **Quand :** après `/prd`, avant `/archi`. **Rôle :**
lire le PRD et identifier les enjeux de sécurité spécifiques à CE projet [...] une analyse
ciblée **qui alimente `/archi`**. » Le skill produit un questionnaire structuré (Données,
Utilisateurs et rôles, Exposition, Mobile) — mais **aucun fichier n'est déclaré en sortie**,
ni dans `securite.md`, ni dans la table des artefacts de `workflow-doc.md` `[lu]`.

Conséquence : le passage de `/securite analyse` à `/archi` Étape 3c se fait **par le contexte
de conversation**, pas par un artefact. Sur un projet dont les deux étapes tombent dans des
sessions différentes — le cas normal en solo, et le cas de RAMrezo — l'analyse est perdue. Il
n'existe alors plus rien qui puisse constater qu'elle a eu lieu ni ce qu'elle a conclu.

**C'est ce qui rend le trou STRIDE de §3.1 difficile à voir.** La doctrine exige six
questions ; `/archi` en pose cinq ; et la seule étape qui aurait pu apporter la sixième
n'écrit rien qu'on puisse relire. Un contrôle sur les artefacts ne détectera jamais l'absence,
puisqu'aucun artefact n'est attendu.

Réserve : les questions du mode `analyse` recoupent en partie celles de `/archi` 3c (rôles,
multi-tenant, webhooks, SSRF, mobile). Il est possible que l'intention soit que `/archi`
rejoue l'analyse plutôt que de la consommer. Dans ce cas le maillon déclaré « alimente
`/archi` » est trompeur et c'est lui qu'il faut corriger — pas ajouter un fichier.

---

### 3.6 — `/setup` renvoie vers `/prp` alors que `/prp` peut le précéder

`setup.md` Étape 9 et « Prochaine étape » : « `/prp` — le projet tourne en local, générer le
document de contexte condensé » `[lu]`.

Mais `prp.md` déclare « Place dans la chaîne : `/specs` → `/prp` → code » `[lu]`, et **ses
huit entrées sont toutes des documents** — brief, prd, archi, `CLAUDE.md`, stack, tests, spec,
gloss `[lu]`. Aucune n'exige un projet qui tourne. `/prp` peut donc s'exécuter avant `/setup`.

C'est ce qui résout la circularité apparente relevée en lisant `readyTo-code.md` : ce skill
déclare « Avant `/setup` ou le premier `/sessionCode` » tout en posant un **Blocker** sur
`.prp.md`. Si `/prp` venait nécessairement après `/setup`, `/readyTo-code` ne pourrait jamais
passer avant `/setup`. Il n'y a pas de cycle : **c'est le renvoi de `setup.md` vers `/prp` qui
est le résidu**, hérité de l'époque où `/setup` précédait immédiatement le code.

---

### 3.7 — `/regles` demande de mémoire ce que `/stack` va chercher aux sources

Défaut trouvé en relisant ma propre recommandation, qui plaçait d'abord `/regles` avant
`/stack` comme les quatre chaînes existantes. Il est **interne à `regles.md`** `[lu]` :

- Étape 2, **Question 2 — Pièges de la stack** : « Avec la stack actuelle ([stack depuis
  archi]), quels sont les gotchas que tu as déjà rencontrés ou que tu veux éviter ? »
- « Prochaine étape » : « `/stack` — les règles sont posées, **investiguer la stack et ses
  gotchas**. »

Le skill demande donc à Medwin de fournir de mémoire les gotchas que le skill suivant a pour
mission d'aller chercher dans les sources primaires. Or `/stack` est précisément le skill qui
porte la doctrine « Aucun verdict sans source primaire » `[lu]`, et son Étape 2 point 3 est
intitulée « Gotchas et pièges connus ».

Deux conséquences, dans l'ordre :

1. `[projet].regles.md` est écrit avant que les gotchas réels soient connus, et rien ne
   déclenche sa mise à jour quand `/stack` les découvre. Le fichier que **tous les LLMs lisent
   à chaque session de code** `[lu]` est donc figé sur la version mémorielle.
2. Le vrai gisement de gotchas n'est ni la mémoire ni la recherche web : c'est le bootstrap.
   Une incompatibilité de versions, une CLI qui refuse une région, un package qui ne s'installe
   pas — ça se découvre au `/setup`, pas avant.

**Proposition : `/regles` après `/setup`**, une fois que `stack.md` existe *et* que le projet
a démarré. Sa fenêtre déclarée le permet sans modification — « après `/archi` et avant le
premier `/sessionCode` » `[lu]` — et son caractère de passe enrichissable en continu (§4.2)
le rend peu coûteux à déplacer. Seul le renvoi « Prochaine étape → `/stack` » est à corriger.

**Réserve :** je n'ai pas de constat d'usage montrant que `/regles` produit effectivement un
fichier pauvre à cause de ce placement. L'argument est structurel, tiré des textes des deux
skills. Si Medwin a l'expérience inverse, elle prime.

---

## 4. Ce que l'ordre linéaire cache

Une chaîne écrite en flèches affirme trois choses fausses : que chaque étape a un seul
prédécesseur, que le franchissement se constate, et qu'un retour est un échec. Aucune des
trois ne tient.

### 4.1 — Les portes (franchissement vérifiable)

Une porte émet un **verdict** — un état binaire qu'on peut constater sans se fier à son propre
jugement. La méthode en a huit, dont trois seulement sont dans la chaîne à treize nœuds.

| Porte | Verdict | Dans la chaîne à 13 nœuds ? |
|---|---|---|
| `/prd-validate` | GO / BLOCKERS | non |
| `/gherkin` Mode PRD | GO / RETOUR PRD | non |
| `/angles-morts` | décision par point : traiter / accepter / hors scope | non |
| `/readyTo-code` | GO / BLOCKERS sur 6 artefacts | non |
| **`/setup` Étape 7** | **l'app se lance, oui ou non** | oui (mal placé) |
| **`/backup` Étape 8** | **le dump se restaure, oui ou non** | oui (mal placé) |
| `/securite check` | bloquant — pas de merge | non |
| `/deploy` Étape 5bis | `lint-observabilite.py` passe ou non | oui |

Les deux portes en gras sont les seules de toute la méthode dont le verdict vient du **monde
réel** et non d'une relecture. Toutes les autres sont un jugement porté sur du texte par le
même agent qui l'a écrit. C'est l'argument central de §5 : ces deux-là méritent d'être
franchies tôt, parce qu'elles sont les seules qui puissent contredire.

Les Quality Gates internes (`/brief` 16 critères, `/prd` 9, `/archi` 12, `/roadmap` 6) `[lu]`
ne sont pas des portes au même sens : le skill s'auto-évalue à la fin de son propre travail.

### 4.2 — Les passes (parallélisables ou reprenables)

- **`/charte`** — ne bloque pas sur le brief (« continue quand même ») `[lu]`. Peut se faire
  en parallèle de tout le rail produit, dès que le brief existe.
- **`/devis` + `/cgv`** — rail commercial. Ne consomment que le brief, ne produisent rien que
  la conception consomme. Parallélisables à `/prd` en entier.
- **`/regles`** — « peut être enrichi à n'importe quel moment quand une règle non-évidente
  émerge » `[lu]`. Passe permanente déguisée en étape.
- **`/adr`** — filtre de 3 conditions, invocable à tout moment `[lu]`.
- **`/avancement`, `/angles-morts`, `/impact`, `/party`, `/prototype`, `/zoom-out`** —
  transversaux déclarés.
- **`/specs`** — passe **par feature**, pas étape unique. Rien n'oblige à écrire les 29 specs
  de RAMrezo avant la première ligne de code : `roadmap.md` produit des phases, `specs.md`
  traite « une feature à la fois », `/readyTo-code` Étape 3 n'exige une spec que « pour la
  phase à coder » `[lu]`. **La chaîne linéaire suggère le contraire, et c'est son coût le
  plus lourd sur un projet à échéance.**

### 4.3 — Les boucles légitimes (déclarées par les skills eux-mêmes)

Ce ne sont pas des échecs. Trois d'entre elles sont **explicitement écrites** dans les skills :

- **`/design` Mode A ↔ `/archi`** — `design.md` : « Mode A commence avant `/archi` et se
  construit en aller-retour avec lui. Les features révèlent les composants, l'archi précise
  les états » `[lu]`. Boucle nommée « phase itérative », avec critère de sortie
  (« à la sortie : `[projet].design.md` complet »).
- **`/stack` → `/archi`** — `stack.md` Étape 4 : « **Architecture :** si un gotcha critique
  oblige à revoir une décision d'archi » `[lu]`. La boucle que la mission cite en exemple est
  déjà déclarée par le skill.
- **`/stack` → `/roadmap`** — même étape : « **Roadmap :** si une limite free tier oblige à
  revoir le périmètre V1 » `[lu]`.
- **`/gherkin` Mode PRD → `/prd`** — verdict RETOUR PRD `[lu]`.
- **`/recette` → `/debug` → `/recette`** — déclenchement automatique, reprise au point
  d'arrêt `[lu]`.
- **`/specs` → `/roadmap`** — « si la story génère plus de 5 règles de gestion → la feature
  est trop large, il faut la découper » `[lu]`.
- **`/prp` → relance** — « Document vivant : relancer `/prp` après tout changement
  d'architecture ou de feature » `[lu]`.

### 4.4 — Les allers-retours parasites

Ceux qui ne viennent pas de la nature du travail mais du placement. Ce sont ceux que Medwin
veut supprimer.

**P1 — `/design` Mode B est placé avant l'existence du projet qu'il modifie.**
Mode B écrit `tailwind.config.ts`, `globals.css`, `theme/tokens.ts` `[lu]`. Ces fichiers vont
dans un projet créé par `/setup`. Trois placements déclarés (§1.3), tous antérieurs au
`/setup` de la chaîne. Conséquence : soit on fait Mode B tard et la « révision in-browser
obligatoire avant la Phase 3 » de `methode-doc` est impossible, soit on la fait au moment
prescrit et il n'y a pas de navigateur à ouvrir. **Parasite, et il est intégralement dû à ce
que `/design` compte pour un nœud alors qu'il en occupe deux, séparés par un outil externe.**

**P2 — `/stack` peut invalider l'`/archi` qui l'a produit.**
`/archi` choisit la stack, `/stack` l'investigue et peut la contredire `[lu]`. La boucle est
légitime (§4.3) — mais dans la chaîne actuelle elle est franchie avant `/roadmap` et
`/specs`, donc son coût est borné. **Rien à corriger ici** : c'est le seul endroit où l'ordre
actuel est bon, et c'est un argument contre déplacer `/stack`.

**P3 — `/setup` après `/roadmap` et `/specs` : le retravail est maximal.**
Ce que seul un `/setup` peut révéler et qu'aucune recherche web ne donne : le bootstrap
échoue, deux packages de la stack ont des versions incompatibles, la CLI du backend refuse la
région demandée, l'app ne démarre pas. Ces découvertes invalident l'archi ou la stack — donc
la roadmap et les specs déjà écrites dessus. **C'est le seul aller-retour de la chaîne dont le
coût croît avec le retard, et c'est l'objet de §5.**

**P4 — `/backup` en fin de chaîne dépendait de `/setup`, lui-même tardif.**
Constaté par Medwin le 14/08 (angle mort 3.2) `[lu]`. Traité en partie ; voir §5.4 pour la
moitié qui ne l'est pas.

**P5 — `/readyTo-code` déclaré « avant `/setup` » avec un Blocker sur `/prp`.**
Résolu en §3.6 : pas un cycle, un renvoi résiduel dans `setup.md`.

---

## 5. La question `/setup` — tranchée

### 5.1 — Recommandation : oui, avancer `/setup` — mais après `/stack`, pas juste après

**`/setup` doit venir immédiatement après `/stack`, avant `/roadmap`.**

Position actuelle : `… /stack → /roadmap → /specs → /setup → /backup → code …`
Position proposée : `… /stack → /setup → /design Mode B → /backup(0-6) → /roadmap → /specs → …`

### 5.2 — Justification, dépendance par dépendance

**(a) Les entrées déclarées le permettent, sans exception.** `setup.md` Étape 0 consomme
`archi.md` et `stack.md`, et `[grep]` confirme l'absence totale de `Rmap`, `roadmap`, `spec.`
et `prd` dans le fichier. Les étapes qui pourraient sembler dépendre du périmètre n'en
dépendent pas :

| Étape de `/setup` | Ce dont elle dérive |
|---|---|
| 3 — dépendances | liste d'outils de `stack.md` |
| 4 — `tsconfig` path aliases | « Les aliases correspondent exactement aux modules de l'archi » `[lu]` |
| 5 — structure de dossiers | « Tu lis les modules de `[projet].archi.md` » `[lu]` |
| 6 — `.env.example` | « services identifiés dans `[projet].stack.md` » `[lu]` |

**Le périmètre dont `/setup` a besoin est le périmètre des *modules* (archi), pas celui des
*fonctions* (roadmap, specs).** L'objection « monter un projet avant de connaître le périmètre
exact » ne trouve donc aucun appui dans les entrées déclarées du skill.

> **Précision sur ce que cet argument ne dit pas.** J'avais d'abord invoqué ici le **Blocker**
> de `/readyTo-code` Étape 2 (« feature dans PRD mais sans module dans archi ») comme garantie
> que la liste de modules est figée au moment du `/setup`. **C'est faux dans ma propre
> recommandation** : §5.3 perte 3 déplace `/readyTo-code` juste avant `/sessionCode`, donc
> après le `/setup`. La garantie ne serait pas en vigueur au moment où on s'en réclamerait.
> L'argument tient sans elle : la liste de modules est la sortie déclarée de `/archi`, et si
> elle se révèle incomplète plus tard, le coût est celui de la perte 2 — un `mkdir` et un
> `index.ts`. C'est le fait `[grep]` (setup ne lit qu'archi et stack) qui porte la
> recommandation, pas cette garantie-là.

**(b) C'est la seule position où `/design` Mode B devient exécutable.** Mode B écrit dans le
projet `[lu]` et se place « après `/stack` » `[lu]`. Avec `/setup` juste après `/stack`, la
séquence `/stack → /setup → /design Mode B → révision in-browser` est la première lecture
cohérente des trois placements contradictoires de §1.3 — et elle satisfait l'intention
commune aux trois : réviser l'interface « pendant que le code est encore propre, avant que
quoi que ce soit de métier ne soit construit dessus » `[lu]`.

**(c) Elle avance la seule porte qui peut contredire.** `/setup` Étape 7 est un verdict du
monde réel (§4.1). Le placer avant l'écriture de la roadmap et des specs, c'est retirer le
risque de stack **avant** de produire le papier qui en dépend, et non après. Sur RAMrezo :
29 fonctions à specer contre une stack backend non encore éprouvée.

**(d) Elle débloque `/backup` sans le forcer.** Voir §5.4.

**(e) Elle réduit la perte de contexte entre sessions** — le coût que la mission désigne comme
dominant en solo. Un dépôt qui tourne est un état persistant que la session suivante retrouve
sans le recharger. Une roadmap et 29 specs sont un état qu'il faut relire.

### 5.3 — Ce qu'on perd (il y a toujours quelque chose)

**Perte 1 — la discipline d'installation se relâche après le `/setup`.** `setup.md` pose
« Pas de créativité. Les dépendances sont celles du stack. Je n'ajoute rien » `[lu]`. Plus
`/setup` est tôt, plus il y aura de `npm install` ultérieurs — et ceux-là ne passent par aucun
skill, ne sont tracés nulle part, et échappent à cette règle. Coût faible en effort, réel en
traçabilité. Mitigation possible : que `stack.md` devienne le journal des ajouts, ce qu'il
prévoit déjà (« Le document est vivant — tout gotcha découvert pendant le développement est
ajouté immédiatement » `[lu]`), étendu aux dépendances.

**Perte 2 — la structure de dossiers peut être périmée.** Si `/roadmap` ou `/specs` révèle un
module manquant, la structure créée à l'Étape 5 est incomplète. Coût réel : un `mkdir` et un
`index.ts`. Faible.

**Perte 3 — `/readyTo-code` perd son cadrage « avant `/setup` ».** Il doit se replacer juste
avant `/sessionCode`. C'est de toute façon sa place cohérente : il pose des Blockers sur
`.prp.md` et des Warnings sur `.avancement.yaml`, deux artefacts qui n'existent qu'à la fin de
la planification. Le cadrage actuel est un résidu du même mouvement que §3.6.

**Perte 4 — un dépôt qui tourne invite à coder trop tôt.** C'est la perte la plus sérieuse, et
c'est un risque de discipline, pas de dépendance. La méthode a déjà les deux garde-fous :
`/readyTo-code` (porte) et `/sessionCode` (sas obligatoire, s'arrête sans spec `[lu]`). Ils
gardent leur position. **À dire explicitement : je ne peux pas mesurer ce risque, et il porte
sur le comportement de Medwin, pas sur les fichiers. C'est le seul point de §5 que je ne
sais pas trancher par la preuve.**

### 5.4 — `/backup` : ne pas revenir sur la décision du 14/08, la couper en deux

La décision de Medwin — `/backup` juste après `/setup` — est **bonne pour six de ses neuf
étapes**. Elle est inapplicable pour deux, et la lecture des étapes le montre :

| Étapes | Contenu | Exécutable après `/setup` ? |
|---|---|---|
| 0 – 6 | vérification archi, DPA, création des dépôts miroir, passphrase GPG, secrets GitHub Actions, workflow de dump, miroir code → GitLab | **Oui.** Configuration pure. Le dépôt et les Actions existent dès `/setup` Étape 8. |
| 7 | UptimeRobot — « URL : **[URL de l'API du projet]** » `[lu]` | **Non.** Il n'y a pas d'URL avant `/deploy`. |
| 8 | Test de restauration réel sur un projet de test | **Non — et c'est le point important.** |

**Pourquoi l'étape 8 est le vrai sujet.** Exécutée juste après `/setup`, elle passerait : la
base est vide, le dump est vide, il se « restaure » parfaitement. Le workflow tourne, le
fichier `.gpg` arrive, `head -30` affiche du SQL. **Une opération réussie qui n'a pas produit
l'effet voulu** — `verification.md` §2 mot pour mot. Et l'angle mort 3.2 pose déjà le critère
qui l'invalide : « une sauvegarde jamais restaurée compte-t-elle comme une sauvegarde ? » `[lu]`.
Une sauvegarde restaurée à vide non plus.

**Proposition :** `/backup` porte déjà un branchement (« Si Niveau 1 → tu t'arrêtes » `[lu]`).
Lui en ajouter un second : deux passes déclarées.

- **`/backup` passe 1** — étapes 0 à 6, **juste après `/setup`**. Le dispositif est armé dès
  que la base existe, ce qui est exactement l'intention de la décision du 14/08.
- **`/backup` passe 2** — étapes 7 et 8, **avant `/deploy`**, sur une base portant un schéma
  et des données de test. Porte réelle (§4.1) : elle peut échouer.

Cela conserve l'intention de Medwin (« dès que la base existe, pas au moment du déploiement »)
sans faire reposer la conformité d'un projet en risque Élevé sur un test qui ne peut pas
échouer.

### 5.5 — L'alternative que j'écarte, et pourquoi

**Alternative : laisser `/setup` où il est, et le faire précéder d'un prototype jetable.**
`methode-doc.md` Phase 5 porte déjà cette option — « prototype exploratoire jetable (YOLO
first) [...] sans tests ni commits — uniquement pour comprendre comment l'IA organise le
code » `[lu]` — et un skill `/prototype` existe.

**Motif du rejet** : le prototype est déclaré pour trancher une incertitude *d'architecture*
(`prototype.md`, description : « code jetable pour trancher une décision qu'on ne peut pas
prendre sans la voir tourner » `[lu]`), pas pour éprouver la stack réelle. Il ne produit ni
`.env.example`, ni structure conforme à l'archi, ni premier commit, ni les aliases `tsconfig`.
Surtout : **ses découvertes meurent avec lui**, alors que la moitié de la valeur du `/setup`
précoce est que l'état survit à la session. On paierait le coût du bootstrap deux fois pour
n'en garder les acquis aucune fois.

Deux autres alternatives écartées, avec motif :

- **Fondre `/setup` dans `/archi`.** Motif : supprime `/stack` comme porte indépendante entre
  les deux, alors que c'est le seul endroit où l'ordre actuel est correct (§4.4 P2). Et les
  deux skills n'ont ni le même tier (`/archi` T3-Opus, déclaré dans `archi.md` même ; `/setup`
  T2, déclaré dans la table des tiers de `methode-doc.md` et **non** dans `setup.md`) `[lu]` ni le même mode de
  travail — `/setup` repose sur « Je lis, tu exécutes », Medwin au clavier `[lu]`.
- **Avancer `/setup` avant `/stack`.** Motif : `setup.md` s'arrête explicitement sans
  `stack.md` `[lu]`, et bootstrapper avant l'investigation reviendrait à installer une stack
  dont on ignore les gotchas et les limites de palier gratuit — sur RAMrezo, où les paliers
  gratuits sont une contrainte de conception contractuelle, c'est disqualifiant.

---

## 6. L'ordre recommandé

### 6.1 — Le principe : le graphe fait foi, la chaîne est une vue

**Ne pas produire une quatrième liste de flèches.** §1.4 montre ce que ça coûte : trois
versions coexistent, la plus détaillée est celle que la correction du 14/08 n'a pas touchée.

Proposition de structure :

1. **La table de §2.2 devient la source de vérité**, remplaçant la table `Artefacts produits`
   de `workflow-doc.md`. C'est le seul objet vérifiable mécaniquement : chaque ligne est
   contrôlable contre l'Étape 0 du skill correspondant.
2. **`methode-doc.md` garde une chaîne courte**, mais annotée comme **vue dérivée**, avec la
   mention de ce qu'elle omet. Medwin la lit ; la supprimer serait une perte.
3. **`workflow-doc.md` cesse de porter sa propre version de la chaîne** et renvoie à la table.
4. **`init-projet.md` est le point le plus urgent** (§1.4). C'est lui qui sème la chaîne dans
   le `CLAUDE.md` de chaque nouveau projet. Tant qu'il n'est pas corrigé, chaque projet créé
   redémarre sur une chaîne à dix nœuds qui s'arrête à `/adr`. **Corriger `methode-doc.md`
   seul ne change rien pour les projets futurs.**

### 6.2 — Vue greenfield, projet client livré (profil complet)

Les portes sont en gras. `↔` = boucle déclarée. `∥` = parallélisable.

```
SOCLE
  /init-projet → /contexte → /brief
                    ∥ /devis → /cgv        (si projet client)
                    ∥ /charte              (dès que le brief existe)

PRODUIT
  /prd → /prd-update → **/prd-validate** → /securite analyse
       → **/gherkin Mode PRD** → **/angles-morts (PRD)**

CONCEPTION
  /design Mode A ↔ /archi → **/angles-morts (archi)**
       → /stack ↔ (retour /archi si finding critique)

AMORÇAGE          ←── le déplacement proposé
  **/setup** → /design Mode B → révision in-browser
       → /regles          ←── déplacé, voir §3.7
       → /backup passe 1 (étapes 0-6)

PLANIFICATION
  /roadmap → /specs → **/angles-morts (spec)** → /gherkin Mode Specs
       ∥ /to-issues (si mode issues)
       → /prp → /avancement → **/readyTo-code**

CODE (par feature, boucle)
  /sessionCode → [/tests TDD si module métier/sécurité] → code → /tests
       → /code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil
       → **/securite check** → /doc-tech B → **/recette** ↔ /debug ↔ /diagnose
       → /commit → /pr → /phase-retrospective → /doc-tech A

LIVRAISON
  /backup passe 2 (étapes 7-8) → **/securite audit** → **/deploy** (dont **Étape 5bis lint-observabilité**)
```

> **`/securite audit` ajouté ici après vérification** `[lu]` : `securite.md` le déclare
> « avant chaque mise en production, **obligatoire** pour les niveaux de risque moyen et
> élevé ». Il ne figurait ni dans la chaîne à treize nœuds, ni dans la Partie 8 de
> `workflow-doc.md`, ni dans ma première rédaction de cette vue. RAMrezo est en risque
> **Élevé** : c'est une étape obligatoire absente des trois chaînes existantes. À traiter au
> même titre que les quatre skills de §6.3 ligne 4.

### 6.3 — Les cinq changements qui portent le poids

| # | Changement | Motif, en une ligne | Preuve |
|---|---|---|---|
| 1 | **`/setup` remonte après `/stack`** | Ses deux seules entrées sont `archi` + `stack` ; rien en aval ne lui manque | `[grep]` §5.2(a) |
| 2 | **`/design` compte pour deux nœuds** (Mode A dans Conception, Mode B après `/setup`) | Mode B écrit dans un projet qui doit exister ; trois emplacements déclarés, tous impossibles | `[lu]` §1.3, §4.4 P1 |
| 3 | **`/backup` se coupe en deux passes** | Étapes 7-8 exigent une URL et des données ; exécutées tôt, elles réussissent à vide | `[lu]` §5.4 |
| 4 | **`/charte` et les 7 autres skills omis reviennent dans la chaîne** | Chacun fait s'arrêter un skill aval ; c'est ce qui rend la chaîne à 13 nœuds inexécutable | `[lu]` §1.1-1.2 |
| 5 | **`init-projet.md` est corrigé en même temps que `methode-doc.md`** | C'est lui qui sème la chaîne dans chaque nouveau projet ; sans lui, la correction ne survit pas au projet suivant | `[grep]` §1.4 |

Le cinquième est le moins visible et probablement le plus rentable : il ne change rien au
projet en cours, et il est le seul qui empêche le défaut de se reproduire.

Sixième, de nature différente : **corriger les maillons déclarés non implémentés** — §3.1
STRIDE, §3.2 observabilité dans `/stack`, §3.3 `project-context.md`, §3.4 `spec.md` de
`/recette`, §3.5 bis sortie de `/securite analyse` — plus l'absence de `/securite audit`
relevée en §6.2. Aucun n'est un problème d'ordre. Mais tous produisent un livrable
**d'apparence complète**, ce qui est pire qu'une étape manquante : une étape absente finit par
se voir, un maillon manquant dans une étape présente, non.

Septième, mineur en effort et non trivial en effet : **`/regles` passe après `/setup`**
(§3.7). Il demande aujourd'hui de mémoire les gotchas que `/stack` va chercher aux sources et
que `/setup` fait apparaître pour de bon — et le fichier qu'il produit est lu par tous les
LLMs à chaque session de code.

### 6.4 — Ce que j'écarte explicitement

| Option écartée | Motif |
|---|---|
| Remplacer la chaîne de `methode-doc` par celle de `workflow-doc` | On perdrait la vue courte, la seule que Medwin lit en pratique. Il faut les deux, dont une dérivée. |
| Construire un script qui calcule le graphe et vérifie l'ordre | `verification.md` §4 : automatiser une règle déplace le risque. Le script deviendrait un document qui périme, lu au moment d'agir, avec autorité. À l'échelle de 30 skills, une table relue est suffisante — et `conduite-de-chantier` §2 s'applique : ce serait une tâche déguisée en outillage. |
| Déplacer `/stack` avant `/archi` pour qu'il décide la stack | Ce serait entériner l'inversion que RAMrezo pratique (§2.3). Mais `/archi` a besoin de la stack pour ses contrats de module, et `/stack` a besoin d'un candidat à investiguer. **Je ne tranche pas ce point** — voir §8. |
| Supprimer `/readyTo-code`, redondant avec `/sessionCode` | Non : `/readyTo-code` vérifie l'existence des artefacts une fois par projet, `/sessionCode` vérifie la fraîcheur du PRP à chaque session. Portées différentes `[lu]`. |
| Fusionner `/gherkin` Mode PRD dans `/prd-validate` | Tentant (deux portes consécutives sur le même artefact), mais les critères diffèrent : `/prd-validate` teste la complétude et la traçabilité, `/gherkin` teste la **testabilité** du « Alors ». Une feature peut passer l'un et échouer l'autre — c'est le cas d'usage déclaré `[lu]`. |

---

## 7. Une chaîne unique est-elle le bon objet ?

**Non. Et la méthode le sait déjà — elle contient les conditions, mais pas la structure qui
les rend visibles.**

### 7.1 — La conditionnalité existe déjà, à l'intérieur des skills

Les variantes n'ont pas à être inventées. Elles sont écrites, testées par les skills, et
invisibles depuis une liste de flèches `[lu]` :

| Garde déclaré | Où | Ce qu'il commande |
|---|---|---|
| Niveau de backup 1 / 2 / 3 | `archi.md`, testé par `backup.md` Étape 0 | « Si Niveau 1 → tu t'arrêtes » — `/backup` disparaît de la chaîne |
| Niveau de déploiement 1 / 2 / 3 | `archi.md`, testé par `deploy.md` Étape 0 | monitoring, feature flags, dashboards |
| Module métier/sécurité ou UI/technique | `archi.md`, testé par `tests.md` | TDD obligatoire ou tests après |
| « prod avec de vrais utilisateurs » | `observabilite-doc.md`, testé par `specs.md` 4c-ter | instrumentation requise ou non |
| Risque Bas / Moyen / Élevé | `brief.md`, testé par `securite.md` | `/securite audit` obligatoire ou non |
| Modèle M1 / M2 / M3 | `brief.md`, testé par `cgv.md` | quelles CP s'appliquent |
| « Obligatoire si : stack nouvelle, API externe critique, free tier non cartographié… » | `stack.md` | `/stack` est facultatif ailleurs |
| One-shot ≤ 6 écrans / two-step | `design.md` Étape 0b | 1 fichier design ou N |
| « Branche optionnelle » | `to-issues.md` | mode issues ou `/sessionCode` direct |
| Filtre à 3 conditions | `adr.md` | ADR ou simple commit |

**La méthode est déjà un graphe gardé.** La liste à treize nœuds en est un rendu avec perte —
elle écrase les gardes, et c'est précisément ce qui a permis à `/setup`, `/backup`, `/design`
et `/deploy` d'être mal placés ou absents sans que ça se remarque.

### 7.2 — Trois profils, dérivés des gardes existants

Pas de nouvelles catégories : des **vues** du même graphe, sélectionnées par des conditions
que la méthode teste déjà.

**Profil A — utilitaire personnel.** Conditions : pas de client (donc pas de `/devis`,
`/cgv`), pas d'utilisateurs tiers (pas d'observabilité, pas de `/recette` formelle), pas de
données personnelles (pas de DPA, backup Niveau 1 → `/backup` s'arrête tout seul), déploiement
niveau 1.

```
/brief → /archi → /stack (si stack nouvelle) → /setup → code → /tests → /deploy
```

Six nœuds. **Rien ici n'est une dérogation** : chaque skill absent l'est parce que son propre
garde l'exclut.

**Profil B — projet client livré.** RAMrezo, Minou. La vue complète de §6.2.

**Profil C — reprise de service** (observation 68). Traité en §7.3.

### 7.3 — « Reprise de service » : ma proposition diffère de l'observation 68

L'observation 68 propose une **troisième catégorie de démarrage** dans `methode-doc.md`, à
côté de greenfield et brownfield, avec ses propres étapes obligatoires sur le modèle du
brownfield `[lu]`. Le constat qui la motive est juste et important : RAMrezo est du code neuf
avec des utilisateurs, des données et des habitudes préexistants, et « en M2, chaque nouveau
client arrivera d'un autre outil avec son historique — c'est la situation ordinaire du
produit » `[lu]`.

**Je propose de ne pas en faire une troisième catégorie, mais de répartir ses quatre étapes
sur les skills dont elles relèvent déjà.** Motif : le brownfield est une catégorie parce
qu'il change le *workflow* (couverture de régression avant toute modification, architecture
adaptateur). La reprise de service ne change pas le workflow — elle ajoute de la **matière** à
quatre artefacts existants. Et `contexte.md` porte déjà la règle de partage qui tranche :
« Si une information relève d'une décision → brief. Si elle relève d'une contrainte donnée →
context » `[lu]`.

| Étape proposée par l'obs. 68 | Où je propose de la placer | Pourquoi |
|---|---|---|
| Inventaire de ce que le client détient déjà (données, contrats, historique) | **`/contexte`** | Contrainte imposée de l'extérieur — définition même du context |
| Décision import / départ à zéro / reprise partielle, avec motif | **`/brief`**, 10ᵉ domaine | C'est une décision, et elle borne le périmètre V1 |
| Période de bascule (première fenêtre de statistiques, dates anniversaires) | **`/roadmap`**, phase 0 | C'est une contrainte d'ordonnancement du développement |
| Conduite du changement auprès des utilisateurs | **`/deploy`** | C'est une étape de mise en service, pas de conception |

Avantage : chacune atterrit dans un artefact qui a déjà un consommateur en aval. Une catégorie
séparée dans `methode-doc.md` risque le sort de la chaîne elle-même — de la prose qui décrit
une organisation, invisible au `grep`, et qu'aucun skill ne va lire.

**Si une seule des quatre devait être retenue : l'inventaire dans `/contexte`.** C'est la
seule des quatre dont le placement est **décidé par une règle déjà écrite** et non par mon
jugement — la frontière de `contexte.md` (« si elle relève d'une contrainte donnée →
context ») tranche sans que j'aie à arbitrer. Ce que le client détient déjà est une contrainte
imposée, par définition. Et c'est la plus en amont : elle informe les trois autres, alors
qu'aucune des trois ne l'informe.

**Réserve honnête, et elle est sérieuse.** L'observation 68 a été écrite par quelqu'un qui
avait le cas sous les yeux ; ma proposition est une réorganisation faite en lisant. Deux
points où elle est plus faible que la sienne :

- **Ma répartition n'a aucun déclencheur mécanique.** Quatre ajouts dans quatre skills, dont
  rien ne teste la présence. Sa catégorie, elle, vit dans le fichier auquel `/brief` renvoie.
  Le test qu'il propose — « le jour du lancement, que se passe-t-il pour les données qui
  existaient avant ? » — mérite d'être posé **mécaniquement**, et ma version ne le garantit
  pas mieux que la sienne.
- **Si Medwin a constaté que la question ne remonte pas d'elle-même** dans `/contexte` et
  `/brief` — et c'est ce que suggère le fait qu'elle ait surgi seulement à la V3 du brief
  RAMrezo, après relecture intégrale `[lu]` — alors l'argument empirique bat le mien, et une
  catégorie visible vaut mieux qu'une répartition élégante.

### 7.4 — Réponse directe : graphe ou liste ?

**Graphe, avec des vues linéaires dérivées — pas un graphe seul.**

Un graphe seul échouerait pour une raison propre au contexte : un développeur solo assisté
d'un agent a besoin, à chaque reprise de session, d'une réponse à « qu'est-ce qu'on fait
maintenant ? ». `workflow-doc.md` le dit en conclusion et c'est son mérite principal : « la
méthode est conçue pour que User ne puisse jamais se demander *qu'est-ce qu'on fait
maintenant ?* » `[lu]`. Un graphe ne répond pas à cette question ; une vue ordonnée si.

L'inversion à opérer est celle de l'autorité : aujourd'hui la liste fait foi et le graphe
n'existe pas ; il faut que le graphe fasse foi et que la liste soit une vue **datée et
marquée comme dérivée**. C'est aussi la seule structure où le défaut de §1.4 ne peut pas se
reproduire : une vue qui diverge de sa source est un bug détectable ; deux listes en prose qui
divergent ne le sont pas.

---

## 8. Ce dont je ne suis pas sûr

Par ordre décroissant d'impact sur la recommandation.

1. **Qui doit décider la stack, `/archi` ou `/stack` ?** Les skills disent `/archi` `[lu]` ; le
   projet réel fait l'inverse `[lu]`. Les deux se défendent : `/archi` a besoin d'un backend
   pour écrire les contrats de module ; `/stack` est le seul à aller chercher les sources
   primaires. Une solution serait que `/archi` produise un **candidat** et `/stack` un
   **verdict** — mais c'est une refonte des deux skills, hors du périmètre de cette mission,
   et je n'ai pas assez lu `/archi` (679 lignes, lues partiellement) pour l'affirmer.
2. **Le risque « un dépôt qui tourne invite à coder trop tôt »** (§5.3, perte 4). Je ne peux
   pas le mesurer. C'est le seul argument sérieux contre la recommandation principale, et il
   porte sur du comportement, pas sur des fichiers. **La recherche documentaire ne le lève
   pas** : §10.9 constate qu'il n'existe aucune critique frontale du walking skeleton en
   source primaire, ni aucune donnée sur le développeur seul. Cette incertitude est donc
   confirmée comme irréductible en l'état, pas réduite.
3. **Le placement de la révision in-browser.** Trois emplacements déclarés (§1.3). Je propose
   le plus tôt qui soit exécutable (après Mode B, donc après `/setup`) — mais je n'ai pas
   d'élément permettant de dire lequel des trois était l'intention d'origine.
4. **Les skills que je n'ai pas lus intégralement** (§0). Une entrée déclarée dans le corps de
   `/code-review`, `/refacto` ou `/phase-retrospective` m'aurait échappé.
5. **`/prp` avant ou après `/setup` (§3.6).** J'affirme qu'il *peut* venir avant, sur la foi
   de ses entrées déclarées. Je n'affirme pas qu'il *doit* — un PRP écrit après le `/setup`
   pourrait citer des chemins réels plutôt que des chemins prévus.
6. **Le déplacement de `/regles` (§3.7)** repose sur la lecture croisée de deux skills, sans
   constat d'usage. C'est le changement le moins étayé empiriquement des sept.

**Un mot sur la manière dont ce document a été produit, qui vaut avertissement.** Ma première
rédaction plaçait `/regles` avant `/stack` — comme les quatre chaînes existantes — alors même
que je venais de lire la Question 2 de `regles.md`. Le défaut ne s'est vu qu'à la relecture
d'une ligne de tableau, exactement le mode de panne que décrit `conduite-de-chantier` §1 :
« une erreur logée dans une ligne de tableau ne se voit pas à la relecture d'ensemble ». Un
document qui diagnostique des défauts d'ordonnancement en reproduit ; les tableaux de §2.2 et
§6.2 méritent une relecture ligne à ligne, pas en diagonale.

---

## 9. Épreuve du terrain — RAMrezo au 14/08/2026

L'ordre recommandé ne vaut que s'il fait avancer le projet réel. Vérification.

**Inventaire constaté** `[grep]` : `context.md`, `brief.md` (V4, 1 416 lignes, **non validé
formellement**), `angles-morts.md` (909 lignes, **4 points traités sur 17**), `dpa.md`,
`email-rgpd.md`, `log`, `peda`, `todo`. **Absents : `charte.md`, `prd.md`, `archi.md`,
`stack.md`.** Échéance : **4 septembre 2026 — trois semaines.**

**Ce que le projet a déjà fait, et qui infirme la chaîne déclarée :**

- `/angles-morts` a été passé **sur le brief**. Le skill ne le prévoit que sur PRD, archi ou
  spec `[lu]`. La passe a produit 17 points dont plusieurs ont modifié le brief et déclenché
  cette mission. **L'ordre réel a trouvé quelque chose que l'ordre déclaré n'aurait pas
  trouvé** — argument de plus pour un graphe gardé plutôt qu'une séquence.
- Deux artefacts hors chaîne existent — `dpa.md`, `email-rgpd.md`. Aucun skill ne les déclare.

**Verdict, et il est en partie négatif.**

L'ordre recommandé aide RAMrezo sur un point précis : `/setup` avant `/roadmap` retire le
risque de stack backend (non tranché à ce jour) **avant** d'écrire les specs de 29 fonctions,
au lieu d'après. Sur un projet dont la contrainte de résidence des données est contractuelle
et dont les paliers gratuits sont une contrainte de conception, c'est le bon endroit pour
découvrir qu'un candidat ne convient pas.

**Mais l'ordre ne crée pas de temps, et ce n'est pas l'ordre qui est contraignant ici.** Le
facteur limitant est 29 fonctions × (`/specs` + `/gherkin` + code + `/tests` + `/recette`).
Aucun réordonnancement ne change ce produit. Deux leviers existent, aucun n'est un levier de
méthode :

1. **Ne pas écrire les 29 specs avant de coder.** `/specs` est une passe par feature (§4.2),
   `/roadmap` produit des phases, `/readyTo-code` n'exige une spec que « pour la phase à
   coder » `[lu]`. La chaîne linéaire suggère le contraire — c'est son coût le plus lourd sur
   ce projet, et le corriger relève de §7.1, pas de §6.
2. **Couper le périmètre V1.** C'est une décision de `/prd`, pas d'ordonnancement.

**Je le dis explicitement plutôt que de laisser croire le contraire : si la question posée est
« comment livrer RAMrezo au 4 septembre », ce document n'y répond pas.** Il répond à « dans
quel ordre les étapes doivent-elles s'enchaîner pour qu'aucune ne travaille sur du papier
invalidé par la suivante ». Ce sont deux questions différentes, et la seconde ne compense pas
la première.

---

## 10. Ce que dit la littérature

**Provenance et limite de cette section.** Les sources ci-dessous ont été réunies et lues en
texte intégral par une recherche documentaire dédiée, menée en parallèle de l'analyse des
skills — **consultation le 14/08/2026**. Je n'ai pas rouvert moi-même chaque source primaire.
Le dossier complet, avec les chemins de vérification et les échecs d'accès déclarés, est dans
`scratchpad/rapport-ordre-methode.md`. Ce qui suit est une **restitution**, pas une
vérification de première main : à traiter comme `[lu par délégation]`, un cran en dessous des
`[grep]` et `[lu]` du reste du document.

### 10.1 — Le constat le plus important est négatif, et il porte contre la forme même de §6.2

**Aucun auteur de source primaire ne prescrit une position fixe pour l'amorçage du projet
dans une chaîne de phases.** Ce n'est pas une lacune de recherche : c'est ce que disent les
textes.

- **Cockburn**, interrogé directement — « À quel stade le walking skeleton doit-il voir le
  jour ? Fin du premier sprint ? » — répond le 07/04/2016 : « **no idea, to either question.
  so sorry, Alistair.** »
- **Cagan** écrit que son modèle est « **process agnostic** » et refuse d'y ajouter du détail
  de processus : « **this is a slippery slope** ».
- **Singer** sépare « basic truths » et « specific practices », et dit qu'une équipe de deux
  ou trois personnes peut « **throw out most of the structure** ».

**Ce que ça fait à ma recommandation.** §6.2 donne une position fixe. La littérature dit que
ce qui se prescrit est un **critère**, pas une date. Je maintiens la position — parce qu'elle
est dérivée des entrées déclarées des skills, ce qui est une contrainte que ces auteurs
n'avaient pas — mais **elle doit être lue comme un défaut, pas comme une règle**. Le critère
qui la gouverne est en §10.2.

### 10.2 — Le critère, en trois formulations convergentes et indépendantes

**(a) L'horizon de pensée — Cockburn, *Crystal Clear* (2004), « Incremental Rearchitecture ».**
Répond littéralement à la question « jusqu'où concevoir avant de faire tourner » :

> Any one person has his personal "thought horizon" […] **The thought horizon on a Crystal
> Clear project is almost certainly reached within a week or two. At that point, the designers
> are probably speculating beyond their thought horizon, and would be better setting up the
> Walking Skeleton.** […] **"Don't overdrive your headlights."**

Le moment dépend de l'expérience du concepteur **sur ce domaine et ces technologies précis**,
pas d'une position dans une chaîne. Et il ajoute l'argument exact de §4.1 : « **The running
system might reveal shortcomings in the architecture that the early thought experiments
didn't catch.** »

**(b) L'inconnu plutôt que la plomberie — Singer, Shape Up ch. 11.** Le premier morceau doit
être *core*, *small* et **novel** : « prefer the thing that you've never done before […] it
wouldn't have eliminated uncertainty ». Et « **Start in the middle** » — ils n'ont pas
construit le login d'abord.

**(c) La question posable ou non sans code — Singer, ch. 5 vs ch. 9.** Tant que le risque se
règle par une conversation, on ne code pas. Quand « **we can't reliably shape what we want in
advance** […] **we have to learn what we want by building it** », on code.

### 10.3 — Shape Up suspend son propre processus pour un produit neuf

C'est la corroboration la plus directe de §5, et elle vient de la méthode dont tout
l'appareil consiste à ne rien engager avant d'avoir bouché les trous. Singer, ch. 9 et
glossaire :

> **R&D mode** : A phase of building a new product where a senior team **spikes the core
> features to define the core architecture**.
> **Production mode** : A phase of building a new product where **the core architecture is
> settled** and we apply the standard Shape Up process.

> we don't expect to ship anything at the end of an R&D cycle. **The aim is to spike, not to
> ship.** […] The goal is to learn what works so we can commit to some **load-bearing
> structure**.

Puis : « we'll eventually reach a point where **the most important architectural decisions are
settled** ». Exemple chiffré : HEY est resté en R&D mode **la première année**.

**Lecture pour vibe-method :** la séquence `brief → … → specs → setup` est **celle du
production mode** — un contexte où l'architecture est déjà acquise. RAMrezo est un produit
neuf dont la stack backend n'est pas tranchée : il est en R&D mode au sens de Singer, et la
chaîne actuelle lui applique le régime de l'autre.

### 10.4 — Le coût du retravail est fonction de la masse construite dessus, pas de la date

Corrobore §4.4 P3, qui était jusqu'ici un raisonnement sans appui externe.

- **Cockburn**, cas de succès : un mapping objet-relationnel qui ne passait pas à l'échelle,
  découvert « after the second delivery », remplacé sans drame « **while the system's
  delivered functionality was still small** ».
- **Cockburn**, contre-cas : une chef de projet « **didn't want the extra rework** » et a tout
  parié sur une architecture neuve sans repli. « In the end, the project was left with no
  running architecture at all, and **no product was ever shipped.** » — refuser le coût du
  retravail a coûté le produit entier.
- **Hunt & Thomas** : « **a small body of code has low inertia — it is easy and quick to
  change** ».

### 10.5 — L'axe qui tranche n'est pas « tôt ou tard » mais « gardé ou jeté »

Corrobore §5.5, où j'écartais le prototype jetable au motif que ses acquis meurent avec lui.
Hunt & Thomas, *The Pragmatic Programmer* :

> **Prototyping generates disposable code. Tracer code is lean but complete, and forms part of
> the skeleton of the final system.**

Le mot « spike » recouvre deux choses opposées : **jetable** chez Cockburn et Beck,
**conservé et porteur** (« load-bearing structure ») chez Singer. Poser « faut-il monter le
projet tôt ? » sans dire si ce qu'on monte doit survivre revient à poser deux questions à la
fois. **Le `/setup` de vibe-method est du tracer code, pas du prototype** — il produit le
premier commit, la structure conforme à l'archi, le `.env.example`. C'est ce qui justifie de
le placer tôt plutôt que d'y substituer un `/prototype`.

### 10.6 — Coordination contre retravail : la littérature confirme la prémisse de la mission

- **Conway** (1968) : « the number of possible communication paths […] is approximately **half
  the square of the number of people** ». Soit **zéro pour une personne**. Il écrit lui-même
  que la coordination « **appears to lower the productivity of the individual** » — un mal
  nécessaire de l'*organisation*, pas une exigence de la *conception*.
- **Singer** : « After you hire more people, all of this fluidity flips from an asset to a
  liability. […] **Coordination starts to eat up more of your time** […] **This is when it
  makes sense to take on the structure** of six-week cycles, cool-downs, and a formal betting
  table. » — la cérémonie existe **à cause du nombre de personnes**, et est explicitement
  dispensée en dessous.
- **Cagan** : « **If you are an early stage startup and you have no customers, then of course
  this is not really an issue** ».

**Ce que ça fait à §7 :** la proportionnalité que je propose n'est pas une facilité, c'est ce
que les auteurs de ces méthodes prescrivent eux-mêmes pour leur propre méthode.

### 10.7 — Le seul chiffrage calibré, et il tranche dans les deux sens

**COCOMO II**, facteur **RESL — « Architecture / Risk Resolution »**, calibré sur 161 projets.
Table I-3 : « Percent of development schedule devoted to establishing architecture » —
5, 10, 17, 25, 33, 40 % de Very Low à Extra High. Second axe, plus opérationnel : « **% significant
module interfaces specified, % significant risks eliminated** » — 20, 40, 60, 75, 90, 100 %.

**Le point décisif est structurel, pas rhétorique : RESL est un *facteur d'échelle*, pas un
multiplicateur.** Il agit sur **l'exposant** de la taille dans la formule d'effort. Conséquence
mathématique : **la pénalité de ne pas faire d'architecture croît avec la taille du projet et
tend vers zéro quand la taille tend vers zéro.** C'est la forme de la fonction, publiée par
Boehm. → appui direct pour le **profil A** de §7.2.

**Mais le même modèle joue contre la minimisation sur RAMrezo.** Supports Boehm (PROMISE
2009) : « Sweet Spot Drivers: **Rapid Change: leftward** ; **High Assurance: rightward** ».
Plus l'assurance requise est haute, **plus** on investit en architecture initiale. RAMrezo est
en risque **Élevé**, sous-traitant RGPD, multi-tenant : il est du côté droit. **C'est un
argument contre l'idée qu'on pourrait alléger sa conception pour tenir la date** — et donc un
appui de plus pour §9, où je conclus que le levier est le périmètre, pas la méthode.

*Réserve déclarée par la recherche : les chiffres qui circulent (14 % de retravail à 10 KSLOC
contre 91 % à 10 000 KSLOC, le « sweet spot ») viennent de Boehm,* Making Software *(O'Reilly,
2010) ch. 10, **chapitre inaccessible (HTTP 403)**. Ne pas les citer comme établis. La table
RESL, elle, a été lue.*

### 10.8 — La contre-épreuve empirique, et sa réserve qui vise exactement notre cas

**Menzies, Nichols, Shull, Layman**, « Are Delayed Issues Harder to Resolve? », arXiv
1609.04886 (2016), publié dans *Empirical Software Engineering* 22(4), 2017. **Nichols et
Shull sont au SEI de Carnegie Mellon** — c'est le SEI qui réexamine son propre héritage.

> This paper tests for the delayed issue effect in **171 software projects** […] **We found no
> evidence for the delayed issue effect.**

Et sur la circularité de la croyance inverse : « the evidence for delayed issue effect is both
**very sparse and very old** […] **nearly every citation** […] could be traced to the seminal
*Software Engineering Economics* ». Leur propre relevé des ratios cités ailleurs mentionne
« **Fictitious example** » à trois reprises.

**Profil de l'échantillon, qui le rend transposable** : équipe **médiane 6**, durée médiane
**61 jours**, **~4 200 lignes** ajoutées ou modifiées en médiane. Ce sont de petits projets —
le résultat n'est pas un résultat de grands systèmes plaqué de force.

**Mais leur réserve explicite vise précisément le choix de stack** :

> **For the baseline architecture, bad decisions made early in the life cycle may be too
> expensive to change and the DIE may still hold.** However, **smaller projects within the
> larger architecture** […] can leverage more agile, interactive development.

**C'est la citation la plus utile du dossier, et elle coupe dans les deux sens.** Elle affirme
que le retravail cher, s'il existe, est **celui de l'architecture de base** — donc pas celui
d'une fonctionnalité. Ce qui (a) **justifie de retirer le risque de stack tôt**, exactement
l'argument de §5.2(c), et (b) **avertit de ne pas traiter les décisions d'archi comme bon
marché à réviser** — donc de ne pas lire §6.2 comme une invitation à bâcler `/archi` parce que
`/setup` viendrait vite après.

Chiffre mesuré cité au passage, seul du dossier sur le retravail architectural (Royce, système
critique d'un million de lignes) : les changements de conception ont coûté « **approximately
twice the effort** » des changements d'implémentation — un facteur **2**, pas 100.

### 10.9 — Ce que la recherche n'a pas trouvé, et qu'il faut savoir

Trois absences déclarées, à traiter comme des absences de recherche et non des preuves
d'inexistence (`verification.md` §1) :

1. **Aucune donnée empirique sur le coût de changer de stack en cours de projet.** C'est
   exactement la quantité que §5 voudrait connaître. Elle n'existe pas dans la littérature
   consultée.
2. **Aucune donnée sur le développeur seul, a fortiori assisté par IA.** §10.6 repose donc sur
   la **décomposition** du coût (Conway, Singer, Cagan), pas sur des mesures de productivité en
   solo.
3. **Aucune critique frontale du walking skeleton en source primaire.** Ce qui existe l'amende
   plutôt qu'il ne le rejette — Gojko Adzic, « Forget the walking skeleton – put it on
   crutches » (09/06/2014), qui écrit par ailleurs « The Walking Skeleton has long been my
   favourite approach », et dont l'objection est que relier les composants d'architecture
   retarde la valeur : « don't worry about making the skeleton walk, **put it on crutches and
   ship out** ».

**Conséquence pour §5.3 (« ce qu'on perd »), la partie que j'annonçais comme la moins
étayée : elle le reste.** La littérature ne fournit pas de critique documentée du coût d'un
squelette monté trop tôt. Le seul contrepoids sérieux qu'elle apporte est celui de §10.7 —
haute assurance, donc davantage d'architecture initiale — et il porte sur `/archi`, pas sur
`/setup`.

---

### 10.10 — Ce que la littérature change au document, en trois lignes

| Section | Effet |
|---|---|
| §5 (avancer `/setup`) | **Corroborée** — Cockburn (horizon de pensée), Singer (R&D mode), Menzies (la réserve « baseline architecture ») convergent. |
| §5.5 (rejet du prototype jetable) | **Corroborée** — la distinction tracer code / prototype de Hunt & Thomas est exactement l'argument utilisé. |
| §6.2 (position fixe) | **Tempérée** — aucune source ne prescrit de position ; ce qui se prescrit est un critère. À lire comme un défaut, pas une règle. |
| §7 (proportionnalité) | **Corroborée et quantifiée** — RESL est un facteur d'échelle : la pénalité tend vers zéro avec la taille. |
| §9 (RAMrezo, verdict négatif) | **Renforcée** — « High Assurance: rightward » : sur un projet en risque Élevé, on n'allège pas la conception pour tenir une date. |
