# vibe-method.todo.md — État exécutif du projet vibe-method

> Mis à jour à chaque clôture de session. Lire en priorité pour se remettre dans le contexte.

---

## RESTE À FAIRE — après la migration du 05/08/2026

Établi à la fin du chantier de réorganisation (`migration-structure.md`, phases 0 à 7).
Chaque ligne est vérifiée sur pièces, pas listée de mémoire. Relire cette section
avant d'ouvrir un nouveau chantier.

**Rappel de lecture du lint** : `python3 ~/dev/wiki/scripts/lint-wiki.py --wiki-path ~/dev/wiki`
sort **18 axes**. Depuis les fix du 06/08/2026 (rubrique A), 11 sont verts et les 7
autres totalisent **182 signalements** (2 nœuds fantômes, 17 orphelines, 69 liens non
réciproques intra-cluster, 77 quasi-doublons, 8 stubs, 2 discordances titre, 7 pages
sans lien sortant). La liste réellement actionnable tient en rubrique B, ci-dessous.

---

### A. Défauts du lint lui-même — à traiter en premier

Ils faussent la lecture de tout le reste.

- [x] ~~**L'extraction du titre H1 n'exclut pas les blocs de code.**~~ — corrigé le 06/08/2026 : `extract_title` retire les blocs fencés avant de chercher le H1, même précaution que `extract_wikilinks`. `backup.md`, `deploy.md`, `securite-doc.md` n'ont en réalité aucun H1 (skills : frontmatter `description` seul) — `title=None` désormais, exclus correctement du check. Axe passé de 5 à 2 signalements, les 2 restants réels (`audit-doctrine-strategie-rech.md`, `guide-definition-produit-rech.md`). Commit `9cabfad` (auto-sync wiki).
- [x] ~~**Décider du sort de l'axe « liens non réciproques ».**~~ — tranché le 06/08/2026 : restreint aux paires du même cluster (`sujet` canonique identique), cohérent avec la règle 11 qui n'exige la réciprocité qu'à l'intérieur d'un cluster. 277 → 69 signalements, tous réels (vérifié : `audit-doctrine-strategie-rech.md` ↔ `securite-doc.md`, même `sujet: Vibe-Method`). Commit `9cabfad` (auto-sync wiki).
- [ ] **Vérifier les quasi-doublons créés par l'arrivée des skills.** `code-review` ↔ `code-review-hostil` (75 %), `doc` ↔ `doc-tech` (70 %), `prd` ↔ `produit-doc` (76 %), `notion-help-security-admin` ↔ `security-auditor` (73 %) : ce sont des paires légitimes, pas des doublons. L'axe compare des titres et des structures ; sur des procédures qui suivent le même gabarit, il se déclenche par construction.

### B. Travail éditorial sur le vault — 212 fiches

**Les skills n'ont jamais été jugés éditorialement.** Avant le 05/08 ils n'étaient ni typés, ni tagués, ni indexés, ni reliés — aucun contrôle ne les regardait. Ils sont désormais soumis au même lint que le savoir, et il a déjà trouvé.

- [ ] **6 skills sous 300 mots** — à étoffer ou à assumer comme volontairement brefs :
  `zoom-out` (201), `log` (228), `askme` (229), `checkpoint` (271), `spec` (289), `majtodo` (296).
  `zoom-out` est signalé comme stub par le lint. Un skill mince n'est pas forcément un défaut — mais aucun de ces six n'a jamais été relu sous cet angle.
- [ ] **17 fiches orphelines** — personne ne les cite, donc personne ne les trouvera par navigation :
  8 fiches `-rech` (`cybersecurite`, `traite-vibe-coding`, `apple-hig-react-native`, `apple-appstore`, `claude-design`, `guide-definition-produit`, `audit-doctrine-strategie`, `rgpd-fournisseurs`), `workflow-doc`, puis `docker`, `oauth`, `wikilinks`, `seo-google-search`, `terminal-modificateurs-clavier`, `agent-tools-veille`, `politique-confidentialite`, `firma-dev-signature-electronique`.
  Les `-rech` sont terminales par nature (on les lit, on ne rebondit pas dessus) — la question est de savoir **qui devrait les citer**, pas ce qu'elles devraient citer.
- [ ] **7 fiches sans aucun lien sortant** — culs-de-sac du graphe : `agent-tools-veille`, `apple-appstore-rech`, `apple-hig-react-native-rech`, `claude-design-rech`, `guide-definition-produit-rech`, `llm-wiki`, `politique-confidentialite`.
- [ ] **8 stubs sous 200 mots** : `docker` (138), `oauth` (150), `python-venv-temp` (134), `llm` (103), `wikilinks` (189), `fal-ai-api` (188), `notion-ai-faqs` (192), `zoom-out` (191).
- [ ] **`notion-dpa-texte-integral` ↔ `notion-msa-texte-integral` à 95 % de similarité** — le seul quasi-doublon qui mérite une vérification réelle. Deux textes contractuels intégraux : soit ils diffèrent vraiment, soit l'un est une copie mal nommée.
- [ ] **2 nœuds fantômes assumés** : `[[devis-pdf-workflow]]` (cité par `iloveapi-signature-electronique`) et `[[ia-locale]]` (cité par `llm`). Dette de connaissance déclarée — à combler ou à retirer.

### C. `workflow-doc.md` a du retard

C'est **le seul endroit où vit l'ordre des skills** depuis que la table a quitté `CLAUDE.md`.

- [ ] Le guide date du 11/06/2026. Il ne couvre ni `deploy` ni `init-projet`, et documente encore `/condense`, sorti de la méthode le 05/08 (phase 3).
- [ ] Il est lui-même orphelin — aucune fiche ne le cite.

### D. ~~Observations du carnet — 8 ouvertes~~ — TRAITÉES le 05/08/2026

Revue `task-observer` de `/maj`, étape 7. **0 observation ouverte** sur 45.

- **37** → procédure de lecture d'un artifact partagé ajoutée à `/firecrawl`
- **39** → sans objet : son étape 5 de `/maj` visait les contrôles de fraîcheur du miroir supprimé. Le principe survit dans `rules/verification.md` §2
- **40, 45** → `claude-config/rules/conduite-de-chantier.md`
- **41, 42, 43, 44** → `claude-config/rules/verification.md`
- **43, 44** → aussi une section « Écriture en masse » dans `/wiki` **et** dans le miroir Hermes (v1.8.0)

**`~/.claude/rules/` est ouvert** — mécanisme vérifié sur la documentation officielle avant usage : règles de portée utilisateur chargées à chaque session avec la même priorité que `CLAUDE.md`. Versionnées dans `claude-config/rules/`, liées par `install.sh`.

<details><summary>Formulation d'origine</summary>

`~/.claude/observations/log.md`. Traitement prévu à l'étape 7 de `/maj`.

- [ ] **37** — Artifact Claude illisible par WebFetch, contournement en 2 appels
- [ ] **39** — Trier par volume de changement réel avant une remise à jour de masse
- [ ] **40** — Un plan validé en bloc peut contenir une consigne inversée
- [ ] **41** — Un contrôle automatique donnait la consigne inverse de sa doctrine
- [ ] **42** — Un silence de `--help` lu comme une preuve d'inexistence
- [ ] **43** — Substitution en masse réussie mais inerte *(demande aussi une étape dans `/wiki`)*
- [ ] **44** — Frontmatter juxtaposé au lieu d'être fusionné *(porte une conséquence de sécurité : perte silencieuse d'`allowed-tools`)*
- [ ] **45** — Un commentaire qui documente un danger le laisse intact

**Six des huit sont des règles de raisonnement, pas des modifications de skill.** Leur destination est `claude-config/CLAUDE.md`, section « Exigence de rigueur » — qui fait déjà 234 lignes, au-dessus des 200 recommandées par la documentation officielle. Voir le point F.

</details>

### E. Hermes / VPS — action en attente, avec un risque armé

- [ ] **Propager les corrections vers le VPS** : `cd ~/dev/hermes-config && ./restaure-skills.sh vps --dry` puis sans `--dry`.
  **Urgent tant que ce n'est pas fait.** Le VPS tourne sur `research/wiki` v1.6.0, qui journalise dans `/opt/data/wiki/log.md` — fichier renommé `journal-log.md` en phase 5. À sa prochaine opération wiki, Hermes **recrée** l'ancien, et le journal du vault se scinde en deux sans qu'aucun signal n'apparaisse.
  `hermes-config` est un dépôt de **sauvegarde** : pousser sur GitHub n'atteint pas le VPS. Le sens dépôt → instance est `restaure-skills.sh`, par `scp`.
- [ ] **La divergence de prose est structurelle, pas accidentelle.** Le skill `research/wiki` intègre volontairement les 14 règles et déclare que sa copie fait autorité côté Hermes. Chaque changement de règle demande donc une édition manuelle de ce fichier. Seul `lint-wiki.py` se propage tout seul. À garder en tête : *ce qu'on veut voir appliqué des deux côtés se met dans le lint.*

### F. Dettes techniques

- [x] ~~**`claude-config/CLAUDE.md` fait 234 lignes**~~ — `~/.claude/rules/` ouvert le 05/08/2026 avec deux fichiers thématiques. **`CLAUDE.md` n'a pas été allégé pour autant** : seules les règles neuves y sont allées. Reste à décider si une partie de « Exigence de rigueur » doit migrer.
  <details><summary>Formulation d'origine</summary>

- **`claude-config/CLAUDE.md` fait 234 lignes**, au-dessus des 200 recommandées (« longer files consume more context and reduce adherence »). Le mécanisme prévu est `~/.claude/rules/` — fichiers thématiques de portée utilisateur, chargés comme un `CLAUDE.md`. Les observations 41 à 45 sont l'argument pour l'ouvrir : elles y ajouteraient encore.

  </details>
- [ ] **`test_lint_observabilite.py`** — ses cas E-H étaient *tous fail-open* avant correction : le lint laissait passer sans rien dire. Même mode de panne que l'observation 36. À réexaminer maintenant que la structure est stable. *(Reporté du §13 de `migration-structure.md`.)*
- [ ] **Sauvegarde mémoire en retard de deux jours** — `com.medwinrumo.sync-memory` est chargé, annonce un intervalle de 15 min, son fichier de log n'existe pas, et un fichier écrit le 05/08 au matin n'était pas sauvegardé deux heures plus tard. Cause à établir. *(Reporté du §13.)*
- [ ] **Skills vs MCP** — comprendre la différence, décider quand utiliser l'un ou l'autre. *(Priorité basse, reporté de l'ancien `CLAUDE.md`.)*

### G. Résidus à trancher — décision de Medwin

- [ ] `vibe-method/test-claude-design/` — dossier de test de mai 2026. Examiné en phase 4 : aucun pointeur mort, mais plus aucun objet.
- [ ] `vibe-method/handoff-out.md` — sortie de `/handoff`, à la racine.
- [x] ~~`vibe-method/.DS_Store`~~ — vérifié le 05/08 : déjà couvert par `.gitignore` ligne 22, non versionné. Rien à faire.
- [ ] **Que devient `vibe-method` ?** Le dépôt ne contient plus que `CLAUDE.md`, `scripts/audit-dependances.sh`, les trois journaux et `migration-structure.md`. C'est un dépôt d'archive du chantier. À garder tel quel, ou à absorber.

### H. Le point structurel à connaître

**Le wiki est devenu le point de défaillance unique de la méthode.** Avant, un wiki cassé cassait le second cerveau ; maintenant il casse aussi les 56 skills et les 4 agents. Le chemin de reconstruction existe et il est testé — `git clone` des deux dépôts, puis `claude-config/install.sh` — mais le couplage a changé, et c'est le prix de ce que la migration a gagné.

Contrôle mécanique en place : `bash ~/dev/vibe-method/scripts/audit-dependances.sh`, contrôle 11 — fiches `claude-code:` ↔ liens posés, plus les liens pendants.

---

## Roadmap — comparaison agent-skills vs vibe-method (reste à faire)

Ouverte le 2026-07-28. **Fait et vérifié en conditions réelles** : 3 gaps majeurs (observabilité, doubt-driven-development, source-driven-development) intégrés à `observabilite.md`/`methode.md`/`stack.md` + 4 personas (`code-reviewer`, `security-auditor`, `test-engineer`, `web-performance-auditor`) créées, testées, un bug réel trouvé et corrigé au passage (`lint-observabilite.py`). Voir `vibe-method.peda.md` du 2026-07-28 pour le détail. Reste, par priorité — miroir des cartes GitHub Projects Tâches 30-34 :

### P1 — Vérifications jamais faites — ✅ FAIT (2026-07-28)
- [x] `security-checklist.md` vs `securite.md` — 19/22 déjà couvert. Patché : STRIDE (§6.2), rate limiting login-spécifique (§2.6), sécurité IA/LLM features (§2.13 nouveau)
- [x] `performance-checklist.md` vs `web-performance-auditor`/`stack.md` — patché : CSS critique, `requestIdleCallback`, compression gzip/brotli, CDN, logging requêtes lentes. Commit `50b1e93`.

### P2 — ✅ FAIT (2026-07-28)
- [x] `accessibility-checklist` → `accessibilite.md` créé, chaîné via `/specs`/`/design`/`/code-review`
- [x] `deprecation-and-migration` → section dans `architecture.md`
- [x] `api-and-interface-design` → section dans `architecture.md`. Commit `901fd7e`.

### P3 — ✅ FAIT (2026-07-28)
- [x] `orchestration-patterns.md` formalisé dans `methode.md` (Doctrine Agents IA) — règle confirmée platform-enforced par Claude Code, pas juste convention
- [x] Anti-rationalisation table ajoutée à `methode.md` (Le juge impartial) et `securite.md` (§0). Commit `7ddb58b`.

### P4 — ✅ FAIT (2026-07-28)
Diff des 14 skills fait via 3 sous-agents en parallèle. 6 gaps réels patchés : real>mock (`tests.md`), feature flags + rollout progressif (`deploy.md`), taille de commit (`commit.md`), state management + breakpoints + anti-esthétique-IA (`ui-vocabulary.md`), Three-Tier Boundary portable (`securite.md` §0bis). Le reste : différences philosophiques déjà couvertes ou hors scope (code-simplification = built-in Claude Code, ci-cd-and-automation = scope minimal assumé, spec-driven-development = déjà plus complet chez nous). Commit `ed3e665`.

### P5 — ✅ FAIT (2026-07-28)
- [x] MCP `chrome-devtools` installé (scope user, `claude mcp add`). Mode profond de `web-performance-auditor` référencé en conséquence — à vérifier en session fraîche (MCP chargés au démarrage, pas à chaud). Commit `2c5fb44`.

**Roadmap agent-skills : CLOSE.** P1 à P5 tous faits, 5 commits + 5 cartes kanban Done (Tâches 30-34), en plus des 3 gaps majeurs et 4 personas du début de chantier.

---

## Questions ouvertes — ouvertes le 2026-07-27

### ~~Faut-il conserver le wiki `Vibe-Method/` ?~~ — TRANCHÉ le 05/08/2026 : supprimé

**Option 3 retenue, mais pas pour la raison prévue.** La question posait « conserver / fusionner / supprimer » comme trois destins du miroir. Le vrai problème était en amont : le miroir existait pour produire un *résumé* de chaque source, et un résumé décroche. La réorganisation (`migration-structure.md`) a supprimé le couple source/résumé en migrant les sources elles-mêmes dans `~/dev/wiki` — doctrines en phase 4, skills et agents en phase 5. Le miroir n'avait alors plus d'objet.

Vérifié avant suppression : aucun de ses 4 fichiers non dérivés (`_vue-ensemble.md`, `index.md`, `log.md`, `CLAUDE.md`) ne portait de contenu absent d'ailleurs. `_vue-ensemble.md` était une version condensée de `methode-doc.md`, qui est plus complet. Supprimé par `git rm` — récupérable dans l'historique.

Le point de vigilance de Medwin — « ne pas perdre, dilapider, abîmer, mélanger » — est traité par l'inverse de ce qu'il craignait : la méthode n'est plus une copie dans un vault, elle **est** le vault, typée et contrôlée par un lint.

<details><summary>Formulation d'origine (27/07/2026)</summary>


`Vibe-Method/` est une **vue dérivée** : elle ne contient rien qui n'existe pas déjà dans `~/dev/vibe-method/`. Sa seule valeur ajoutée est le graphe Obsidian.

Trois options :
1. **Le conserver tel quel** — coût : une seconde base à maintenir et à synchroniser, risque de confusion avec `~/dev/wiki`
2. **Le fusionner dans `~/dev/wiki`** — ⚠️ `~/dev/wiki` est synchronisé avec le VPS Hermes via GitHub : cela pousserait toute la méthode sur le VPS. À décider, pas à subir.
3. **Le supprimer** — si la consultation se fait en pratique par Claude Code plutôt que dans Obsidian, la projection ne gagne pas son coût. Aucun risque pour la source, qui reste canonique.

Point de vigilance soulevé par Medwin : la vibe-method est trop importante pour être « perdue, dilapidée, abîmée, mélangée ». Toute option retenue doit préserver le statut canonique des fichiers sources.

</details>

### SESSION D'ARCHITECTURE À PROGRAMMER — frontière contenu / infrastructure

Ouverte le 2026-07-29. **À traiter à froid, en session dédiée** (`/archi` ou `/party`). Question englobante de celle ci-dessus sur `Vibe-Method/` — la trancher d'abord, l'autre en découle.

**Le déclencheur.** Medwin remarque pendant une session HERMES que les corrections issues de la review `task-observer` ne sont jamais commitées. Diagnostic : dans `/maj`, l'étape 3 (commit + push) précède les étapes 6 et 7, qui modifient des skills. Réparé le jour même (étape 8, voir plus bas). Mais l'inventaire fait à cette occasion a révélé un problème plus profond.

**La tension, formulée par Medwin.** « Au départ vibe-method est juste un dossier projet, un espace où je voulais ranger simplement les fichiers qui touchent à ce projet de définition d'une vibe-method. Or on dirait que c'est en train de devenir un espace central de la structure Claude Code / GitHub / Hermes. »

C'est structurellement exact. Le dépôt héberge trois natures :

| Couche | Contenu | Destin |
|---|---|---|
| Doctrine | `methode.md`, `architecture.md`, `securite.md`, `stack.md`, `tests.md`… (racine) | contenu — candidat au second cerveau |
| Wiki interne | `Vibe-Method/` (doctrines, skills, agents, flux, index) | fusion actée avec `~/dev/wiki` (mémoire `project_fusion_wiki_vibemethod`, 2026-07-28) |
| **Infrastructure** | ~~`.claude/commands/` (57 skills), `.claude/agents/` (4), `.claude/hooks/` (4), `setup.sh`, `CLAUDE.global.md`~~ — **plus rien de tout ça n'est ici au 05/08/2026** : skills, agents et hooks sont dans `~/dev/wiki`, `setup.sh` est absorbé par `claude-config/install.sh`, `CLAUDE.global.md` est devenu `claude-config/CLAUDE.md` | ~~exécutable — n'ira **jamais** dans un wiki~~ |

> **Ce « jamais » était faux, et le savoir a coûté un test.** Écrit le 29/07/2026 sur l'hypothèse qu'un exécutable ne peut pas être une fiche. Le test du 05/08 a montré que Claude Code ignore les champs de frontmatter qu'il ne connaît pas : un skill peut donc porter le frontmatter complet du wiki — typé `Procédure`, tagué, indexé, relié — et rester invocable par `/nom`. La phase 5 les a tous migrés. L'hypothèse n'avait jamais été vérifiée ; elle a tenu deux semaines comme un fait.
>
> Ce qui reste vrai de l'intuition : un exécutable a des contraintes qu'une fiche de savoir n'a pas. D'où le champ `claude-code:`, qui les distingue sans les séparer.

Le dépôt porte le nom de la couche 1, mais sa fonction opérationnelle est la couche 3 — via les symlinks vers `~/.claude/`. Ce n'est pas une décision, c'est une dérive par commodité. Le jour où la fusion wiki emporte les couches 1 et 2, il reste un dépôt nommé « vibe-method » qui n'est plus qu'un dossier de configuration Claude Code.

**Ce qui n'est versionné nulle part** (`~/.claude` n'est pas un dépôt git) :

| Fichier | Nature |
|---|---|
| `~/.claude/observations/log.md` | carnet — **versionné depuis le 01/08/2026** dans `claude-config/observations/` |
| ~~`~/.claude/skills/task-observer/SKILL.md`~~ | **résolu le 05/08/2026** — `claude-config/commands/task-observer.md` |
| ~~`~/.claude/commands/firecrawl.md`~~ | **résolu le 05/08/2026** (phase 0) — `claude-config/commands/firecrawl.md` |
| `~/.claude/CLAUDE.md` | instructions globales Claude |
| `~/.claude/settings.json`, `settings.local.json` | hooks, permissions |
| `~/.claude/projects/*/memory/` | mémoires par projet |

Conséquence concrète : une correction `task-observer` portant sur `settings.json` (cas réel — observation 9, sur un hook) n'a **rien à commiter**, quel que soit l'ordre des étapes de `/maj`.

**Piste à instruire, non tranchée.** L'infrastructure Claude Code mérite-t-elle son propre dépôt, séparé du contenu doctrinal ? Si oui, les orphelins ci-dessus ont enfin une maison évidente, et la fusion wiki devient un déménagement propre au lieu d'un démembrement. Si non, assumer et documenter que vibe-method est un dépôt à double fonction.

Contrainte à ne pas perdre de vue : `~/dev/wiki` est synchronisé avec le VPS Hermes via GitHub (cf. option 2 de la question ci-dessus) — toute couche déplacée vers le wiki atterrit sur le VPS.

**Déjà réparé le 2026-07-29, sans engager l'architecture** (formulations volontairement neutres, valables quelle que soit la décision) :
- `maj.md` — étape 8 « Commit final » : recenser les dépôts *réellement touchés* pendant la session (pas de liste figée), les vérifier, et signaler à Medwin toute correction portant sur un fichier hors dépôt. Deux cases ajoutées à la checklist.
- `setup.sh` — hooks et agents désormais liés par glob et non par liste nommée (`track-agent-usage.sh` et les 4 agents manquaient, donc perdus sur une machine neuve). Les fichiers non versionnés y sont listés en commentaire, en attendant cette session.

**À ne pas faire avant la décision** : rapatrier les orphelins dans vibe-method. Ça reviendrait à densifier la couche 3, c'est-à-dire à choisir implicitement l'architecture qui gêne Medwin.

### ~~Hooks de session~~ — **fait le 2026-07-27**

Trois rituels documentés dans le `CLAUDE.md` global échouaient de la même façon : écrits, non appliqués, et leur non-respect invisible tant que Medwin ne posait pas la question.

**Mis en place dans `~/.claude/settings.json`**, scripts dans `~/.claude/hooks/` :

| Hook | Script | Rôle |
|---|---|---|
| `SessionStart` | `session-start.sh` | Injecte le rappel des deux rituels de démarrage : lire `~/dev/wiki/index.md`, invoquer `task-observer`. Ajoute la consigne de **dire à voix haute** toute règle qu'on choisit de ne pas appliquer. |
| `PostToolUse` (`Write\|Edit`) | `track-repo.sh` | Note la racine du repo git de chaque fichier écrit, par session, dans `/tmp/claude-repos-<session_id>`. |
| `Stop` | `stop-cloture.sh` | Si un repo touché a du travail non commité ou non poussé → message à Medwin. Throttle de 20 minutes. |

**Choix de conception.** Un scan de tous les repos de `~/dev` a été écarté : 1,1 seconde par tour, et cinq repos déjà sales en permanence — le rappel serait devenu du bruit dès le lendemain. En ne surveillant que les repos réellement touchés dans la session, le hook tombe à 67 ms et ne parle que de ce qui vient d'être fait.

Voir les observations 4 et 6 de `~/.claude/observations/log.md`.

---

## Dernière session — 2026-07-27

### Ce qui a été fait

- Skill `/brief` amélioré sur trois points, à partir d'observations `task-observer` issues de la première utilisation sur un projet client réel (RAMrezo) :
  - **Étape 0.1** — protection contre l'écrasement d'un `[projet].brief.md` existant : proposition de renommage en `.context.md` avant de démarrer le dialogue
  - **Étape 0.2 + sauvegarde d'état** — écriture incrémentale dans `[projet].brief-wip.md` après chaque domaine validé, reprise possible d'une session interrompue
  - **Domaine 6** — question sur les traitements automatiques (rappels, relances, envois périodiques, expirations), posée avant le choix de stack, remontée au `/stack`. Quality gate 16 → 17 cases.
- Page wiki `Vibe-Method/skills/brief.md` resynchronisée + entrée dans `Vibe-Method/log.md`
- Commit `b0c68e4` poussé

---

## Session précédente — 2026-07-21

### Ce qui a été fait

- Double source de vérité CGV/CGP/propal corrigée : gabarits `cgv.cg.md`, `cgv.cp-m1.md`, `cgv.cp-m2.md`, `cgv.cp-m3.md` supprimés du repo — `/cgv` lit désormais directement `~/dev/wiki/cgv-*.md`. Gabarit propal non versionné supprimé, remplacé par `~/dev/wiki/propal-template.md`
- Skills miroirs Hermes créés : `cgv-generation` et `devis-generation` — répliquent `/cgv` et `/devis` côté VPS Hermes, doivent évoluer en synchro manuelle (référence ajoutée dans les deux skills Claude Code)
- Écart RGPD détecté entre `/devis` et son miroir Hermes `devis-generation` : section "Engagements RGPD" présente côté Hermes, absente ici — backportée dans `.claude/commands/devis.md`
- Skill caveman transmis à Hermes

---

## Session précédente — 2026-05-26

### Ce qui a été fait

- Wiki LLM vibe-method créé dans `Vibe-Method/` (vault Obsidian) :
  - `CLAUDE.md` : schéma du wiki (sources, structure, frontmatter, 4 opérations, règle de mise à jour automatique)
  - `index.md` : catalogue complet de ~69 pages organisées par catégorie
  - `log.md` : journal des opérations wiki
  - `_vue-ensemble.md` : synthèse globale de la méthode (7 phases, posture, garde-fous, doctrines)
  - `flux/chaine-complete.md` : chaîne complète des skills avec inputs/outputs/artefacts
  - `doctrines/` : 8 pages doctrine (methode, architecture, securite, tests, design, stack, refacto, produit)
  - `skills/` : 55+ pages skill couvrant les 7 phases + transversaux + session + infra
- Règle wiki active : toute source modifiée en session → mise à jour automatique des pages wiki correspondantes

---

## Dernière session — 2026-05-18 (session 4)

### Ce qui a été fait

- Skill `/devis` créé : qualification client (exa:search 8 angles + scoring), archi légère, estimation blocs P/M/G, calibrage valeur interne, conditions CGV, génération `[projet].proposition.md`
- Exa MCP configuré dans `mcp.json` — connect/disconnect via `/mcp` à la demande
- Étape 1 challengée par ChatGPT 5.5 → V3 décisionnelle avec scoring 6 dimensions + angle de prospection
- Étape 4 réécrite : grille de lecture commerciale + 3 décisions (profil acheteur, prix, arguments)
- CLAUDE.md mis à jour : `/devis` dans la chaîne et la table des skills
- Analyse CGV : 7 articles inadaptés pour l'applicatif — chantier séparé signalé dans le skill
- Commit `26bd103`

---

## Dernière session — 2026-05-15

### Ce qui a été fait

- Tâche 26 — Les 9 gestes du kung fu : noms attachés aux règles existantes dans `methode.md` (pilotage session de code + protocole d'escalade), tableau de référence rapide ajouté, rappel des 5 gestes de posture dans `/sessionCode` étape 7, step 4 de `/debug` nommé "Le faucon en chasse". Commit pushé.
- Skill `/askme` créé et symlinké : raccourci contextuel pour AskUserQuestion — analyse le contexte en cours, génère 1-4 questions avec options tranchantes.
- Tâche 3 — Test Claude Design sur projet fictif TeamTasks (3 écrans, React + Tailwind) :
  - `test-claude-design/teamtasks.design.md` produit (Mode A complet avec ASCII art 3 écrans)
  - `test-claude-design/notes.md` : 4 lacunes identifiées (one-shot vs two-step, précision absolue, révision in-browser, vocabulaire UI)
  - `ui-vocabulary.md` créé : lexique de référence UI/UX complet avec ASCII art (zones, composants, états, couleurs, patterns, propriétés visuelles)
  - `/design` Mode A : exigence de précision absolue + référence ui-vocabulary.md (bloc [RÉVISION 2026-05-15])
  - `/design` Mode B : étape 5 "Révision in-browser" ajoutée avant /roadmap
  - `/charte` : rappel ui-vocabulary.md avant lancement /design
  - `methode.md` Phase 2 : deux références ajoutées (ui-vocabulary + révision in-browser)
  - `design.md` (doctrine) : workflow et bloc révision mis à jour
  - `CLAUDE.md` : ui-vocabulary.md dans la structure
  - Guide complet : blocs [RÉVISION 2026-05-15] dans /charte et /design Mode A

---

## Session précédente — 2026-05-14 (session 4)

### Ce qui a été fait

- Récap pédagogique vibe-method complet envoyé dans Notion (page Vibe-Method) :
  - 7 parties + transversaux + récapitulatif de tous les fichiers produits
  - Couverture : 25 skills principaux + 6 skills transversaux
  - Pour chaque skill : rôle, qui fait quoi, doctrine, exemples concrets, comment ça se termine
  - Exemples basés sur app RAM réseau et app menu de la semaine

---

## Session précédente — 2026-05-14 (session 3)

### Ce qui a été fait

- Tâches 21-25 — 5 skills BMAD manquants (suite de la tâche 4) :
  - `/prd-validate` : gate de validation PRD avant `/archi` — complétude 8 zones, traçabilité, cohérence, rapport GO/BLOCKERS
  - `/readyTo-code` : gate avant premier `/sessionCode` — vérifie PRD, archi, specs, project-context, PRP, sprint-status
  - `/regles` : dialogue d'élicitation des règles non-évidentes → `[projet].project-context.md` (7 questions)
  - `/phase-retrospective` : rétrospective de fin de phase — analyse features, 5 questions retro, suivi retro précédente, action items, preview phase suivante, gestion dette
  - `/code-review-hostil` : revue cynique 10 angles systématiques, minimum 10 problèmes, BLOQUANT/IMPORTANT/À SURVEILLER
  - Symlinks créés pour les 5 skills
  - CLAUDE.md : chaîne mise à jour (prd-validate, regles, readyTo-code, code-review-hostil, phase-retrospective) + table mise à jour
  - Section "Prochaine étape" ajoutée à tous les skills existants

---

## Session précédente — 2026-05-14 (session 2)

### Ce qui a été fait

- Tâche 4 — Comparaison BMAD vs vibe-method :
  - Rapport `bmad-comparaison.md` produit (11 points BMAD mieux, 14 vibe-method mieux, 11 lacunes identifiées)
  - 3 skills créés : `/avancement` (YAML tracking), `/code-review-edge-cases` (chasse cas non gérés), `/impact` (impact analysis)
  - Intégrations : `/sessionCode` (sprint status + chaîne), `/recette` (sprint done), CLAUDE.md (chaîne + table)
  - 5 rappels créés pour les points restants (tâches 21-25)

- Tâche 6 — Audit et enrichissement skills :
  - `/archi` Étape 1b : WebSearch obligatoire version Expo avant confirmation stack native
  - `/archi` Étape 1b : implications en cascade listées (→ `/stack`, → roadmap délais stores, → règles sécu mobile)
  - `/archi` Étape 4c : WebSearch obligatoire limites free tier Supabase/Convex avant confirmation backend
  - `/archi` Étape 4c : implications en cascade listées (→ `/stack` connexions simultanées, → risque RGPD Convex, → patterns RLS CLAUDE.md)
  - `securite.md` §1.8 : renvoi explicite vers `architecture.md` section "Backup & conformité RGPD"
  - `/prp` : confrontation avec `prp-doctrine-enrichissement.md` — tous les gaps Haute priorité résolus (sécurité via `archi.md`, règles silo via `archi.md`, règles tests dans `/tests`)

---

## Session précédente — 2026-05-14 (session 1)

### Ce qui a été fait

- Sync `/todo` : tâche 9 (test filtrage dates) supprimée du fichier local, conformément au kanban GH.

---

## Session précédente — 2026-05-13 (session 2)

### Ce qui a été fait — Tâche 5 (audit cohérence, suite) + refonte design

**Corrections audit (D3, G3, I1, I2) :**
- D3 — `design.md` entièrement réécrit : workflow Claude Design (Mode A ↔ /archi → Claude Design → Mode B), NativeWind ajouté, Stitch/Figma retirés de la chaîne systématique (Figma optionnel), Principe réécrit (interface d'abord, logique ensuite), ASCII art documenté comme format de maquette collaboratif, frontend-design retiré (redondant avec design system déjà dans le code)
- G3 — `/specs` Étape 1 et template Étape 5 : source sécurité corrigée (`securite.md` → section Sécurité de `[projet].archi.md`)
- I1 — `tests.md` Anti-auto-validation : Règle b ajoutée (vérifier que les tests échouent avant l'implémentation)
- I2 — `methode.md` Phase 1 : "Identifier les enjeux de sécurité" complété avec `→ /securite analyse`

**Évolutions design & architecture :**
- `/design` Mode B : nouvelle Étape 2 "Extraction du routing" — scan éléments interactifs, tableau Simple/Conditionnel/Action/Non défini, validation Medwin requise, écriture dans `[projet].archi.md`
- `/archi` template : section "Navigation & Routing" ajoutée (complétée par Mode B, disponible dans le PRP)
- `/prp` : `[projet].design.md` retiré des inputs (redondant après Mode B — tokens dans `tailwind.config.ts`, composants dans le codebase)
- `design.md` : routing extrait écrit dans `archi.md` (pas dans `design.md` — non disponible en session de code)

---

## Session précédente — 2026-05-13 (session 1)

### Ce qui a été fait
- Tâche 7 — Skill `/doc-tech` créé : Mode A (`[projet].doc-tech.md` — vue d'ensemble développeur, fin de phase) + Mode B (annotations JSDoc/TSDoc dans le code, après `/tests` avant `/recette`). `/doc` mis à jour : sous-page Développeur supprimée, Utilisateur restructurée. Symlink créé.
- Tâche 8 — Doctrine `refacto.md` créée (discipline autonome : définition, critères, règles non-négociables, types, intégration workflow 3 déclencheurs, lien TDD micro/macro). Skill `/refacto` créé : 4 étapes (vérification session, prérequis, diagnostic, exécution atomique avec verrous anti-dérive). Journal de dette `[projet].refacto-dette.md` défini et intégré. `tests.md` enrichi : Refactor TDD détaillé + renvoi vers `refacto.md`. `methode.md` mis à jour. Symlink créé.
- Tâche 10 — `/sessionCode` enrichi : 7 étapes (was 4). Ajouts : fraîcheur PRP (feature courante vs demandée), chargement obligatoire spec, vérification dette refacto sur le module ciblé, état roadmap + dépendances, détection TDD/Standard, rappel chaîne post-coding.

---

## Session précédente — 2026-05-12

### Ce qui a été fait
- Tâche 11 — Sync GitHub Projects : `/todo` refondu (sync GH Projects au démarrage, GH = source de vérité, setup `.gh-project.local`). `/maj` refondu (Étape 3 GH Projects — tâches terminées + nouvelles tâches).
- Tâche 12 — Skill `/adr` créé : capture décision architecturale en 4 questions, append dans `[projet].adr.md`. Symlink créé. `/archi` (Étape 5b) et `/specs` (Étape 4d) proposent automatiquement `/adr` après décision structurante.
- Tâche 13 — Documentation locale : `/recette` (Étape 6) propose mise à jour `[projet].doc-user.md` après validation de phase. Definition of Done enrichie dans `methode.md` et template `/specs` : `doc-user.md` ajouté.
- Tâche 14 — `/maj` restructuré : pont Notion retiré (plus de mise à jour auto `.peda`, `.log`, `.spec`, `.doc`). Garder : Git + sync sécurité + GitHub Projects + cohérence doctrine. MCP Notion supprimé des allowed-tools.

---

## Session précédente — 2026-05-08

### Ce qui a été fait
- Tâche 14 — Doctrine MCP complétée : chapitre "Dépendances externes — MCP" dans `architecture.md`. Investigation large sur MCP (définition, architecture, cas d'usage). Règle de décision (conversationnel vs déterministe vs mixte). Activation (global / par-projet / on-demand). Intégration étape 3b dans skill `/archi`.
- Configuration voice : langue mise en français, mode switch de "hold" à "tap" (appuyer pour démarrer/arrêter la dictation).

---

## Session précédente — 2026-04-22

### Ce qui a été fait
- Tâche 2 — Skill `/init` créé : Git + Notion (page `.run` + 9 sous-pages). Workflow projet documenté (page projet manuelle → `/init` → `.run`). Symlink créé.
- Renommage skills : `/majspec` → `/spec`, `/majpeda` → `/peda`, `/majlog` → `/log`, `/majdoc` → `/doc`. Symlinks recréés.
- `.voca` → `.gloss` partout (peda.md, CLAUDE.global.md, mémoire)
- Tâche 6 — Corriger `/maj` : déjà propre, clos sans modification
- Tâche 12 — Stack front React + Vite + TS documentée dans `architecture.md` (+ PWA et React Native comme alternatives)
- Règle de rigueur professionnelle ajoutée dans `CLAUDE.global.md` : toutes les options, rien sous silence, qualité avant rapidité
- Contrats d'interface ajoutés dans `/archi` (étape 4b) + template document + bloc CLAUDE.md
- Tâche 13 — Mise en prod : doctrine complète ajoutée dans `architecture.md` (6 couches, 3 niveaux, staging à la demande). Skill `/deploy` créé et symlinké.
- RAMrezo identifié comme premier projet réel de la vibe-method (version personnalisée de SynRezo pour le club RAM)

---

## Session précédente — 2026-04-05

### Ce qui a été fait
- Tâche 5 — Migration outputs → `.md` : `/brief`, `/prd`, `/archi`, `/roadmap` écrivent maintenant dans le repo projet au lieu de Notion. 4 symlinks manquants créés (checkpoint, debug, securite, stack)
- Tâche 7 — ExplorePéda#7 niveau 3 : agent manager et OpenClaw + mémoire partagée traités et clôturés (pas d'intégration nécessaire)
- Tâche 3 — Skill `/design` créé : Mode A (spike stack design + interview + liste features pour Stitch/Figma) + Mode B (intégration export CSS → Tailwind + shadcn). Symlink créé. `/prd` mis à jour (question stack design). `CLAUDE.md` mis à jour (chaîne de skills)

---

## Tâches

### À faire

- 28 — aidd-orchestrator (agent AFK GitHub) — à intégrer en phase maintenance d'un projet stable. Voir notes ci-dessous.

  **Ce que fait ce skill :** Labelise une issue GitHub `aidd-run` → un agent lit l'issue, implémente, ouvre une PR sans supervision. Re-label → l'agent applique la review. Mode AFK complet — l'IA travaille pendant que tu fais autre chose.

  **Pourquoi attendre :** Nécessite (1) un projet en prod avec des issues bien spécifiées, (2) GitHub Actions configuré, (3) des specs suffisamment précises pour une exécution sans supervision. Ces conditions ne sont pas réunies sur Minou/RAMrezo en V1.

  **Le bon moment :** Phase de maintenance — bugs mineurs et évolutions répétitives bien documentées sur un projet stable (20+ issues spécifiées).

  **Comment récupérer le skill :** Plugin `aidd-orchestrator` du marketplace AIDD Framework (communauté française, fait en France).
  Commandes : `/plugin marketplace add ai-driven-dev/aidd-framework` puis `/plugin install aidd-orchestrator@aidd-framework`.
  Repo de référence : https://github.com/ai-driven-dev/aidd-framework

- 27 — Test Claude Design deux passes : valider (1) le mécanisme de mémoire du design system entre A1 et A2 (re-référence nécessaire ou non ?), (2) l'organisation du transfer HTML/CSS vers Claude Code (lot unique ou écran par écran). Mettre à jour skill `/design` et guide après test. **Priorité haute — prévu 2026-05-16.**
- Test grandeur nature — /brief → /devis → /cgv sur un vrai projet (ajouté depuis GH Projects)
- ~~26~~
- ~~17~~
- ~~18~~
- ~~19~~
- ~~20~~
- ~~3~~
- ~~4~~
- ~~5~~
- ~~6~~
- ~~21~~
- ~~22~~
- ~~23~~
- ~~24~~
- ~~25~~
- ~~7~~
- ~~8~~
- ~~10~~
- ~~templates/ dans vibe-method~~ — Décidé de ne pas faire. Chaque skill produit son fichier avec la bonne structure quand il s'exécute.

### Réalisées

- ✅ Synchronisation guide + Notion — 4 skills AIDD (angles-morts, commit, pr, condense)
- ✅ 3 — Test Claude Design (TeamTasks) : 4 lacunes identifiées, `ui-vocabulary.md` créé, `/design` Mode A + Mode B enrichis, guide mis à jour. (2026-05-15)
- ✅ 26 — Les 9 gestes du kung fu : noms intégrés dans `methode.md`, `/sessionCode`, `/debug`. (2026-05-15)
- ✅ 21-25 — 5 skills BMAD manquants : `/prd-validate`, `/readyTo-code`, `/regles`, `/phase-retrospective`, `/code-review-hostil`. Symlinks créés. CLAUDE.md chaîne + table mises à jour. (2026-05-14)
- ✅ 4 — Comparaison BMAD vs vibe-method : rapport `bmad-comparaison.md` + 3 skills créés (`/avancement`, `/code-review-edge-cases`, `/impact`) + 5 rappels (tâches 21-25). (2026-05-14)
- ✅ 6 — `/archi` : WebSearch versions (Expo, free tier) + implications en cascade. `securite.md` §1.8 renvoi. `/prp` confrontation : gaps résolus. (2026-05-14)

- ✅ 20 — Intégration traité : tests + POURQUOI — 2 points décidés non intégrables. (2026-05-14)
- ✅ 19 — Intégration traité : posture & philosophie — 5 points décidés non intégrables (redondant/non actionnable). (2026-05-14)
- ✅ 17 — Intégration traité : phase AVANT — cadre 3 phases, 3 règles état d'esprit, template PRD, relire PRD, YOLO first. (2026-05-14)
- ✅ 18 — Intégration traité : architecture — 4 familles + 3 questions dans `architecture.md` + `/archi` Étape 1. (2026-05-14)

- ✅ 7 — Skill `/doc-tech` — Mode A (`[projet].doc-tech.md`) + Mode B (JSDoc/TSDoc). `/doc` restructuré. (2026-05-13)
- ✅ 8 — Doctrine `refacto.md` + skill `/refacto` + journal de dette + enrichissement `tests.md` TDD Refactor. (2026-05-13)
- ✅ 10 — `/sessionCode` enrichi — 7 étapes, dette refacto, roadmap, dépendances, TDD/Standard, fraîcheur PRP. (2026-05-13)

- ✅ 11 — Sync GitHub Projects : `/todo` + `/maj` refondus, setup `.gh-project.local` documenté (2026-05-12)
- ✅ 12 — Skill `/adr` créé : 4 questions, append `[projet].adr.md`, proposé par `/archi` Étape 5b + `/specs` Étape 4d (2026-05-12)
- ✅ 13 — Documentation locale : `doc-user.md` dans Definition of Done + `/recette` Étape 6 propose la mise à jour (2026-05-12)
- ✅ 14 — `/maj` restructuré : pont Notion retiré (plus d'auto `.peda`/`.log`/`.spec`/`.doc`), GH Projects + Git + sécurité uniquement (2026-05-12)

- ✅ 5 — Audit de cohérence interne vibe-method — 10 problèmes traités (D1/C1/C2/D2/G1/G2/D3/G3/I1/I2) + hooks RGPD `/brief` et `/specs`. Points restants reportés en tâche 6. (2026-05-13)
- ✅ 9 — Cybersécurité — `securite.md` refondu : OWASP Top 10 + Mobile Top 10, auth côté serveur, moindre privilège, double audit LLM via `/party`, outils scan CI/CD. Commit 6d0c805 (2026-05-12)
- ✅ 1 — Recherche Claude Design + apple-hig-react-native — `claude-design.md` + `apple-hig-react-native.md` créés (2026-05-11)
- ✅ 2 — Recherche Apple HIG pour React Native + Expo + NativeWind — documentation complète + décision RAMrezo → natif (2026-05-11)

- ✅ 11 — Finir l'étude Radio Vibe Code #6 — intégrer les enseignements dans la vibe-method (2026-05-08)
- ✅ 15 — Agents IA — doctrine complète (`methode.md` + étape 4b `/specs`) (2026-05-08)
- ✅ 16 — BMAD vs vibe-method — étude comparative complète. Intégrations : /prd, /specs, /brief, /archi, /roadmap, /design, methode.md, nouveaux skills /party et /code-review (2026-05-08)

- ✅ 2 — Skill `/init` — complet (Git + Notion, workflow projet documenté) (2026-04-22)
- ✅ 6 — Corriger `/maj` — déjà propre, clos (2026-04-22)
- ✅ 12 — Stack front React + Vite + TS documentée dans `architecture.md` (2026-04-22)
- ✅ 13 — Mise en prod — doctrine `architecture.md` + skill `/deploy` (2026-04-22)
- ✅ 14 — Doctrine MCP — complète. Chapitre "Dépendances externes — MCP" dans `architecture.md` + étape 3b dans skill `/archi` (2026-05-08)
- ✅ Skill `/brief` — complet
- ✅ Skill `/prd` — complet + question stack design ajoutée (2026-04-05)
- ✅ Skill `/prd-update` — complet
- ✅ Skill `/archi` — complet + étape 6b garde-fous free tier
- ✅ Skill `/roadmap` — complet
- ✅ Skill `/specs` — user story A4
- ✅ Skill `/tests` — unit + integration + Playwright
- ✅ Skill `/recette` — Gherkin + validation manuelle
- ✅ Skill `/debug` — diagnostic 3 tentatives + web search
- ✅ Skill `/stack` — spike technique + investigation + Étape 0bis stack de dev
- ✅ Skills session — `/maj` `/todo` `/log` `/peda` `/doc` `/spec` `/majtodo` `/checkpoint` (renommés 2026-04-22)
- ✅ Skill `/deploy` — complet (2026-04-22)
- ✅ Infrastructure Git — symlinks, setup.sh, CLAUDE.global.md versionné
- ✅ `architecture.md` — réécrit complet (2026-03-27) + règle abstraction maximale (2026-03-29)
- ✅ `methode.md` — mise à jour complète (2026-03-27) + Phase 4 stack de dev + Phase 7 /securite (2026-03-29)
- ✅ `design.md` — créé (2026-03-27)
- ✅ `securite.md` — section 2bis gestion ressources ajoutée (2026-03-29)
- ✅ `stack.md` (skill) — Étape 0bis ajoutée (2026-03-29)
- ✅ `majpeda.md` (skill) — mise à jour vers double page .peda + .voca (2026-03-29)
- ✅ ExplorePéda#7 niveau 1 — 1.1, 1.2, 1.3, 1.4 intégrés
- ✅ ExplorePéda#7 niveau 2 — 2.1, 2.2, 2.3 traités
- ✅ 1 — Skill `/securite` — complet (deux modes : analyse + check, intégré Phase 7) (2026-03-29)
- ✅ 3 — Skill `/design` — complet (Mode A + Mode B, symlink, /prd mis à jour) (2026-04-05)
- ✅ 5 — Migration outputs skills → `.md` dans repo projet + 4 symlinks manquants (2026-04-05)
- ✅ 7 — ExplorePéda#7 niveau 3 — agent manager + OpenClaw + mémoire partagée (2026-04-05)

---

## État général du projet

| Élément | État |
|---|---|
| Chaîne de skills complète | ✅ Fonctionnel |
| Skills session (`/maj`, `/todo`, etc.) | ✅ Fonctionnel |
| Infrastructure Git (symlinks, setup.sh) | ✅ Fonctionnel |
| `produit.md` | ✅ Stable |
| `methode.md` | ✅ Mis à jour 2026-03-29 |
| `design.md` | ✅ Créé 2026-03-27 |
| `architecture.md` | ✅ Mis à jour 2026-03-29 |
| `securite.md` | ✅ Mis à jour 2026-03-29 |
| `tests.md` | ✅ Stable |
| `stack.md` | ✅ Stable |
| Skill `/securite` | ✅ Complet (2026-03-29) |
| Skill `/design` | ✅ Complet (2026-04-05) |
| Migration outputs → fichiers `.md` | ✅ Fait (2026-04-05) |
| Skill `/init` | ✅ Complet (2026-04-22) |
| Skill `/deploy` | ✅ Complet (2026-04-22) |
| `templates/` dans vibe-method | ❌ Non créé (attend RAMrezo ou Minou) |
| Wiki Obsidian (`Vibe-Method/`) | ✅ Créé 2026-05-26 |
| CGV/CGP — source unique wiki | ✅ Fait 2026-07-20 (élimine double source de vérité) |
| Skills miroirs Hermes (cgv-generation, devis-generation) | 🔧 En synchro manuelle |

---

## Prochain projet

**RAMrezo** — version personnalisée de SynRezo pour le club RAM. Premier projet réel de la vibe-method. Stack et timeline à définir lors d'une session dédiée. Démarrer depuis `/brief`.

**Minou** — app chat multi-LLM. Démarrer depuis `/brief`.
Stack : Convex (real-time natif pour le chat).
Garder Firebase V1 en ligne pendant la construction de V2 sur Convex.
