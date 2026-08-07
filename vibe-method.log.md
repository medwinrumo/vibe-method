# vibe-method.log — Journal de bord

---

## 2026-07-27 — /brief : protection, reprise de session, traitements automatiques

- Trois observations `task-observer` issues de la session RAMrezo, validées par Medwin, appliquées à `.claude/commands/brief.md`
- **Étape 0.1** — protection contre l'écrasement : détection d'un `[projet].brief.md` existant sans `[projet].context.md`, proposition de renommage avant tout dialogue. Rappel de sécurité ajouté à l'étape d'enregistrement.
- **Étape 0.2 + section « Sauvegarde d'état »** — écriture incrémentale dans `[projet].brief-wip.md` après chaque domaine validé, détection au démarrage pour reprendre au bon domaine, suppression du fichier une fois le brief généré
- **Domaine 6** — nouvelle question sur les traitements automatiques (rappels, relances, envois périodiques, expirations), posée avant le choix de stack. Table ajoutée au format du brief, quality gate 16 → 17 cases, remontée explicite au `/stack`
- Page wiki `Vibe-Method/skills/brief.md` resynchronisée (frontmatter `source_modified` et `wiki_updated` au 2026-07-27) + entrée dans `Vibe-Method/log.md`
- Commit `b0c68e4` poussé

## 2026-06-11 — Lint Wiki + /pr enrichi

- Lint complet Wiki : 5 problèmes corrigés (contradiction firecrawl summary, llm-wiki déplacé vers racine, firecrawl-configs reclassé procédure, lien fantôme seo retiré, notion-developer-platform mis à jour)
- Webhooks workers Notion confirmés sortis (vérifié docs.notion.com) — note mise à jour avec date
- External Agent API toujours introuvable dans la doc officielle au 2026-06-11
- `/pr` skill : étape 4 merge ajoutée (ouvrir PR, relire diff, Merge pull request, Delete branch)
- Sync `/todo` : "Synchronisation guide + Notion — 4 skills AIDD" ajouté aux Réalisées depuis GH Projects
- Commit `66ca23f` pushé

---

## 2026-05-26 — Sessions wiki + Wiki

- Wiki LLM vibe-method créé dans `Vibe-Method/` (vault Obsidian) : CLAUDE.md, index.md, log.md, _vue-ensemble.md, flux/chaine-complete.md, 8 doctrines, 55+ skills
- Frontmatters corrigés : `type: concept` → `type: infrastructure` (index.md, _vue-ensemble.md, log.md) + type `infrastructure` ajouté au schéma
- Lint wiki intégré dans `/maj` étape 5 (déclenché par git diff si sources modifiées)
- Wiki conçu et créé : `~/dev/wiki/` repo git + vault plat + CLAUDE.md (règles enrichir/fusionner/logger/tagger), index.md (12 tags canoniques), log.md
- MCP filesystem configuré dans Claude Desktop (`~/dev/`) — accès Chat + Cowork
- Repo GitHub Wiki créé (privé) et pushé
- 6 skills modifiés pour intégrer Wiki : `/stack` (lecture avant spike + écriture après), `/archi`, `/regles`, `/deploy`, `/debug`, `/phase-retrospective`
- Pages wiki des 6 skills mises à jour
- `/init-projet` modifié : vault Obsidian `Wiki-[projet]/` créé à l'init + section Wiki injectée dans CLAUDE.md projet
- `CLAUDE.global.md` : lecture automatique `~/dev/wiki/index.md` à l'ouverture de session (silencieux)
- `.gitignore` : fichiers UI Obsidian exclus (workspace.json, graph.json, bookmarks.json, *.canvas)

---

## Jour 1 — 2026-05-18 (suite — session 4)

### Session 4 — Skill /devis + intégration Exa

- Créé `/devis` — 6 étapes : qualification client, archi légère, estimation blocs, calibrage valeur (interne), conditions, génération proposition
- Exa plugin installé via `claude-plugins-official`, clé API configurée dans `~/.claude/mcp.json`
- Étape 1 itérée 3 fois : V1 (requête unique) → V2 (8 angles) → V3 (brief décisionnel + scoring 6 dimensions + angle prospection, suite challenge ChatGPT 5.5)
- Étape 4 réécrite : grille de lecture commerciale + 3 décisions (profil acheteur, fourchette prix, arguments clés)
- Test qualification sur Hygeia Group : secteur nettoyage (NAF 81.21Y), SIRET 98467027300015, Courtry 77181
- Règle mémorisée : plugins officiels uniquement (`claude-plugins-official`)
- Correction structure fichiers : symlink `~/.claude/commands/devis.md` → `vibe-method/.claude/commands/devis.md`
- Analyse CGV : 7 articles inadaptés pour l'applicatif (1, 2, 6, 9, 14, 16, 17) + article 7 PI critique
- Commit pushé : `26bd103`

---

## Jour 1 — 2026-05-18 (suite — session 5)

### Session 5 — CGV M1/M2/M3 + /brief refonte

- Créé `cgv.cg.md` — 18 articles tronc commun (Conditions Générales)
- Créé `cgv.cp-m1.md` — dev sur mesure : cession PI L131-3 après paiement intégral, maintenance incluse (bugs + écosystème), casse client exclue, accès Git maintenu post-mission
- Créé `cgv.cp-m2.md` — SaaS : licence d'accès non exclusive, SLA, réversibilité, portabilité, DPA, abonnement
- Créé `cgv.cp-m3.md` — Notion : droit d'usage non exclusif (licence multi-clients), réversibilité export
- Créé `/cgv` skill — assemblage automatique CG + CP selon modèle M1/M2/M3 détecté depuis brief + proposition
- `/brief` refondu : domaine 6 ajouté (architecture légère + modèle de prestation M1/M2/M3), quality gate enrichie
- `/devis` : étape 2 mise à jour (confirmation archi légère depuis brief), étape 5 (validité de la proposition ajoutée)
- `CLAUDE.md` vibe-method mis à jour
- Commit pushé : `e5712af`

---

## Jour 1 — 2026-05-18 (suite — session 6)

### Session 6 — /devis estimation complète + /phase-retrospective calibration + guide + Notion

- `/devis` étape 6 : `proposition.md` restructurée en deux parties — Tableau 1 (récapitulatif lignes devis PDF) + Tableau 2 (détail par phase, supprimable avant envoi) + proposition narrative
- `/devis` étape 3 scindée en 3a + 3b
  - 3a : calibration 12 phases workflow depuis paramètres brief (modèle M1/M2/M3, sécurité, features, stack, distribution, RGPD) — incertitude concrète ± 0 à ± 2j par phase
  - 3b : blocs dev depuis table de référence 5 catégories × Supabase/Convex (auth, CRUD, temps réel, UI, intégrations) — mobile Expo × 1,5 à 2 — grille P/M/G en fallback
- `/phase-retrospective` : C0b ajouté en Mode Complet (lecture logs → identification phase → calibration estimé vs réel) — section "Calibration — Estimé vs Réel" dans template C5 — Mode Léger conservé intact
- `CLAUDE.md` : descriptions /devis et /phase-retrospective mises à jour
- `VIBE-METHOD — GUIDE COMPLET DU WORKFLOW.md` : chaîne enrichie, PARTIE 1 → 8 skills, sections /devis et /cgv insérées, /brief 9 domaines, /phase-retrospective Mode Léger vs Complet + C0b
- Notion page `Vibe-Method.WORKFLOW` mise à jour via API directe Python (MCP update-a-block incompatible — bug mapping `type` key)
- Commits pushés : `d84ac5e`, `8787d9a`, `79002b2`, `42ab843`

---

## Jour 1 — 2026-05-18

### Session 1 — Enrichissement méthode + refactoring Notion

- Intégré concept "Quality Gate" dans `/prd` (section décisions techniques initiales)
- Ajouté filtre 3 conditions dans `/adr`
- Ajouté support `[projet].gloss.md` dans `/prp`
- Créé `/grill-me` — interrogatoire approfondi, une question à la fois
- Créé `/caveman` — mode communication compressé (jamais en session code)
- Créé `/handoff` — ancre de contexte mid-session avant compaction
- Refactorisé 8 skills : Notion → fichiers `.md` locaux (`/peda`, `/log`, `/doc`, `/spec`, `/checkpoint`, `/majtodo`, `/maj`, `/init-projet`)
- Nettoyé `CLAUDE.global.md` : section Notion supprimée, table artefacts locaux ajoutée
- Résolu collision de nom : `/spec` produit `[projet].spec-global.md`
- Corrigé titre `/caveman` (anciennement `/kavman`)
- Commité et pushé : `a044fdb`

### Session 2 — Intégration skills externes (suite)

- Créé `/diagnose` — escalade de `/debug` pour bugs difficiles (boucle feedback + hypothèses falsifiables)
- Enrichi `/refacto` — vocabulaire Seam/Profondeur/Deletion test + mode exploration
- Enrichi `/tests` — anti-pattern tranches horizontales + signal mauvais test
- Enrichi `/roadmap` — principe vertical slices + critère Quality Gate
- Créé `/to-issues` — specs → issues GitHub qualifiées HITL/AFK
- Recadrage : approche prospective confirmée, distinction HITL/AFK formalisée
- Commits : `96ff58e`, `24370a8`, `b5761bb`, `fedec66`

### Session 3 — Implementation Decisions, /handoff, /zoom-out, /prototype

- `/prd` : ajout sections 13 (Implementation Decisions) + 14 (Testing Decisions) dans template + questions Étape 5b
- `/archi` : Étape 0 lit Implementation Decisions du PRD ; Étape 0b challenge obligatoire (hypothèses, pas décisions finales)
- Créé `/zoom-out` — carte du module courant (archi.md + gloss.md), transversal
- `/handoff` refondu : sections enrichies toutes phases + bidirectionnel (save/restore) + append + détection par résumé de compaction visible
- Créé `/prototype` — branche logique (terminal) + branche UI (variations switchables), déclencheurs dans `/archi`, `/design`, `/prd`, `/specs`, `/grill-me`
- Hooks Claude Code : % de contexte non exposé aux hooks — fonctionnalité manquante, mémoire créée
- Hallucination sub-agent : issue GitHub #34340 inventée avec détails précis — corrigée
- Commits : `2087d5e`, `2dab863`, `5b36a0e`, `8c297b9`, `a098913`

---

## Jour 2 — 2026-05-19

### Session 7 — CLAUDE.md ownership par skill + GitHub Projects dans /init-projet

- Diagnostiqué : CLAUDE.md vide après /init-projet + /maj → gap structurel (aucun skill n'avait la charge du remplissage)
- HYGEIA.CLAUDE.md rempli manuellement en correctif immédiat (commit `docs:`)
- GitHub Projects setup : déplacé de /todo (renvoi) vers /init-projet (Étape 2 complète — création projet GH, colonnes Todo/In Progress/Done/Late, champs Début+Fin, IDs internes, .gh-project.local, .gitignore)
- CLAUDE.md : convention Anthropic native — contexte démarrage rapide, pas documentation. Ajout vibe-method : pointeur `→ Détails : [artefact]` vers les fichiers détaillés.
- Pattern upsert défini : section existante → remplacer, section absente → ajouter en fin de fichier
- 12 skills modifiés : /init-projet (template minimal), /contexte, /brief, /charte, /prd, /securite, /design Mode A + Mode B, /archi (upsert auto — plus "Medwin intègre manuellement"), /regles (plus "à inclure si tu veux"), /stack, /adr, /maj (checklist mise à jour)
- Commits pushés : `4fd4c07`, `b6eedd9`

---

## Jour 3 — 2026-05-21

### Session 8 — Deep research RGPD pour RAMrezo + doctrine vibe-method

- Apport de deux fichiers RGPD par Medwin : `Checklist Vercel vs RGPD.md` (12 points) + `Checklist-RGPD-en-10-points.md` (Supabase)
- Deep research exa:search lancée sur 5 angles : Supabase RGPD, Vercel RGPD, alternatives EU souveraines, CNIL/transferts hors UE, RAMrezo spécifique
- 3 subagents avec résultats Exa réels (~83 sources), 2 subagents en échec (training knowledge uniquement)
- Findings clés :
  - Vercel certifié DPF (Data Privacy Framework EU-US) — base légale directe
  - Supabase non certifié DPF mais DPA mars 2025 + TIA mars 2025 disponibles — région Frankfurt obligatoire
  - DPF valide juridiquement (mai 2026) mais fragile — appel CJUE en attente depuis sept. 2025
  - Pas d'alternative EU souveraine clé en main équivalente à Supabase (Appwrite = meilleur candidat, self-host requis)
  - Stack RAMrezo Supabase Frankfurt + Vercel = légal et défendable avec dossier documenté
- Vérifié : `rgpd.md` existe, complète (12 sections), 3 points inexacts identifiés
- Produit : `rgpd-research-2026-05-21.md` — intégralité de la research (5 sections)

---

## 2026-06-11

### Session — Intégration AIDD : 4 nouveaux skills + guide + Notion

- `VIBE-METHOD — GUIDE COMPLET DU WORKFLOW.md` mis à jour : 4 fiches ajoutées (/angles-morts, /commit, /pr, /condense), chaînes PARTIE 1/2/3/6 mises à jour, compteurs 25→28 skills + 5→6 transversaux, tiers T1/T2/T3 mentionnés dans chaque nouvelle fiche
- Blocs Fin mis à jour : /prd-validate, /archi, /specs pointent vers /angles-morts ; /recette mentionne /commit → /pr
- Notion page `325a67fe703a80a2bfebc8cf62187bc2` synchronisée : 11 update-a-block + 6 patch-block-children (17 opérations)
- Commit `b7eaa51` pushé sur main
- Créé : Task #1 — mise à jour `rgpd.md` (3 corrections + 2 ajouts)

---

## 2026-07-05

### Session — Skill /wiki créé (enrichir le Wiki depuis n'importe quel dossier)

- Angle mort identifié : `~/dev/wiki/CLAUDE.md` ne se charge automatiquement que si la session travaille sous `~/dev/` — aucun accès depuis un autre projet
- Skill `/wiki` créé (`.claude/commands/wiki.md`) : pointe vers `~/dev/wiki/CLAUDE.md` comme source de vérité, n'en duplique pas le contenu
- Intègre le workflow git `pull`/`push` (règle 6 du wiki) — le wiki est maintenant partagé avec Hermes via repo GitHub `medwinrumo/wiki`
- Étape 0 ajoutée : clarifier la source du contenu à intégrer (conversation, doc externe, crawl, portion ciblée) avant de lancer la procédure
- `CLAUDE.md` mis à jour : table des skills + liste des skills transversaux
- Commits pushés : `c806689`, `317c952`
- Contexte complet du projet wiki partagé (abandon Syncthing/Karpathy, repo GitHub, gouvernance, Hermes) documenté dans `~/dev/wiki/log.md`, pas ici

## 2026-07-20

### Session — Élimination de la double source de vérité CGV/CGP/propal : migration wiki + miroirs Hermes

- Migration des gabarits contrats depuis `vibe-method/` vers `~/dev/wiki/` (repo partagé Mac/Hermes) : `cgv-conditions-generales.md`, `cgv-cp-m1-dev-sur-mesure.md`, `cgv-cp-m2-saas-multiclients.md`, `cgv-cp-m3-notion.md`, `propal-template.md` — objectif : source unique accessible à Hermes et futur Notion, pas seulement Claude Code
- Vieux fichier CGV mono-bloc pré-modularisation (Notion only) laissé de côté — obsolète, superseded par cgv-conditions-generales + cgv-cp-m3-notion
- RGPD (`rgpd.md`) volontairement **non migré** — reste dans vibe-method, doctrine active lue par `/archi` et `/deploy`, pas un gabarit contractuel statique. Pointeur texte ajouté dans les CP wiki (CP.10/CP.12) au lieu de dupliquer le contenu
- **Double source de vérité découverte a posteriori** : `/cgv` lisait encore `~/dev/vibe-method/cgv.cg.md` etc. en dur — corrigé : `.claude/commands/cgv.md` repointé vers `~/dev/wiki/cgv-*.md`, fichiers vibe-method doublons supprimés (`git rm`, commit `32849cb`)
- Skill Hermes `cgv-generation` créé (`/opt/data/skills/productivity/cgv-generation/SKILL.md`, déployé via SSH) — miroir de `/cgv`, lit `/opt/data/wiki/cgv-*.md`
- Skill Hermes `devis-generation` créé en miroir de `/devis` — qualification client via MCP Exa d'Hermes (déjà actif, pas de préambule `/mcp`), estimation, calibrage, propal
- Références croisées ajoutées : `/cgv` ↔ `cgv-generation`, `/devis` ↔ `devis-generation` — synchro manuelle documentée (pas de mécanisme automatique entre les deux runtimes)
- Commits vibe-method : `32849cb` (suppression doublons + repointage `/cgv`), `7a977cd` (référence croisée `/cgv`), `7957f14` (référence croisée `/devis`)

---

## 2026-07-21

### Session — Transmission skill caveman à Hermes + backport RGPD dans /devis

- Contenu du `SKILL.md` caveman (plugin `JuliusBrussee/caveman`, installé côté Mac) transmis à Hermes via `hermes_exchange.md` (`/opt/data/hermes_exchange.md` côté conteneur) — demande : construire un skill similaire adapté à son propre fonctionnement
- Vérification de l'état du skill Hermes `devis-generation` (miroir de `/devis`, créé le 2026-07-20) avant d'y transmettre quoi que ce soit — déjà à jour et quasi identique ligne pour ligne
- Écart détecté dans l'autre sens : `devis-generation` contenait une section "Engagements RGPD" (sous-traitance art. 28, destruction fichiers sources, DPF, registre des traitements) absente du `/devis` source sur Mac
- Backport de cette section dans `.claude/commands/devis.md` (§ Proposition financière + note de contexte en fin de skill, référence `rgpd.md`) — commit `e0016c0`
- Page wiki `Vibe-Method/skills/devis.md` mise à jour en conséquence (frontmatter + point 6 structure proposition)

---

## 2026-07-24

### Session — État des lieux vibe-method + resync todo

- Point d'avancement demandé par Medwin : chaîne de skills complète et fonctionnelle, `vibe-method.todo.md` en retard de 6 commits (sessions 2026-07-20/21 non reflétées)
- Détail tâche 28 (aidd-orchestrator) donné — reste en attente, conflit noté avec la règle mémoire "plugins officiels seulement" (aidd-framework est un marketplace tiers), à trancher le jour venu
- `/majtodo` exécuté : section "Dernière session" mise à jour (migration CGV/CGP vers wiki, miroirs Hermes, backport RGPD), tableau d'état enrichi de 2 lignes — commit `49fc35c`

---

## 2026-07-27

### Session — Intégration Radio vibe-method #10 + lint wiki + corrections diverses

- Analyse `Radio vibe-method #10.md` : items classés contre la doctrine réelle (nouveau / déjà couvert / contradiction). 4 ajouts actés : coûts cachés + dépendances (`stack.md` + skill `/stack` étape 2bis), limite prélèvement CB (`securite.md`), effort par tier + Chrome DevTools MCP en complément debug (`methode.md`) — commit `b9be180`
- Tailwind conditionnel et branches en solo : contradictions identifiées avec le podcast, doctrine gardée telle quelle après analyse
- Lint wiki vibe-method (`Vibe-Method/`) : 4 pages stales rafraîchies, chemins `source:` cassés sur 68 pages corrigés en masse (bug présent depuis la création du wiki, 2026-05-26), 3 liens orphelins fixés, page manquante `skills/wiki.md` créée — commit `5b80fd7`
- Page Notion "Vibe-Method.WORKFLOW" mise à jour aux mêmes endroits (coûts cachés, dépendances, effort par tier, Chrome DevTools)
- Bug `.gitignore` trouvé : règle `*backup*` bloquait le skill `/backup` (source + page wiki) depuis sa création le 9 mai — jamais poussé sur GitHub. Corrigé (`*-backup`/`*_backup`), fichiers ajoutés — commit `9572d0a`. Fichier transcript orphelin "#8 vibe method - backup" supprimé (jamais commité)
- Doctrine recherche web à 3 paliers d'Hermes (Tavily/Exa+Firecrawl/Sonar) comparée et adoptée en mémoire, mapping ajusté à mes outils
- Tavily + Perplexity ajoutés en MCP scope `user` (clés Hermes réutilisées telles quelles — rotation en attente depuis mai, jamais faite, tâche supprimée sur décision de Medwin, commit `b395ef8` côté repo hermes) ; Exa authentifié (était non-authentifié sans jamais avoir été signalé)
- IDs de modèles périmés trouvés dans `methode.md` (`claude-sonnet-4-6`, `claude-opus-4-8` — génération 4.x) et corrigés en `claude-sonnet-5`/`claude-opus-5`
- Recherche "quel modèle pour `/brief`" reprise 3 fois avant résultat fiable — requête trop vague, puis scope limité aux IA US, puis benchmarks académiques périmés non filtrés. Recherche finale via `perplexity_research` avec consigne de fraîcheur explicite (juin-juillet 2026 uniquement) : Claude Opus 5 en tête pour l'élicitation de besoins — recommandation ponctuelle pour RAMrezo, pas actée en doctrine
- Graphify (outil knowledge-graph codebase) évalué à la demande de Medwin — jugé prématuré pour RAMrezo, pas encore démarré
- Ouvert : `/brief` toujours sans tier assigné dans `methode.md`

## 2026-07-28 — Règle : le ton doit refléter la complétude de la preuve

CLAUDE.global.md, section "Exigence de rigueur professionnelle" : nouvelle règle après quatre revirements dans la même conversation (RAMrezo, choix Convex/Supabase) — chaque conclusion honnête au moment T mais présentée avec une assurance disproportionnée par rapport à l'information réellement vérifiée. Toute recommandation technique doit désormais préciser sur combien de critères elle repose et lesquels restent à vérifier.

---

### Session — Comparaison addyosmani/agent-skills : observabilité, doubt-driven, source-driven

- Comparaison faite sur lecture primaire complète (pas résumé) de 24 skills + 4 personas + 7 checklists du pack externe vs fichiers réels vibe-method — 3 gaps retenus : observability, doubt-driven-development, source-driven-development
- Principe de forçage validé (3 consultations advisor) : artefact + lint mécanique > hook à frontière objective > rappel par tour > prose seule
- `observabilite.md` créé, `/specs` Étape 4c-ter (filtre prod-critique, section "Signaux à instrumenter"), `scripts/lint-observabilite.py` (testé 4 cas), `/deploy` Étape 5bis (Pre-Launch Gate) — commit `5f96fde`
- `methode.md` : 10e geste "Le juge impartial" (doubt-driven, process CLAIM/EXTRACT/DOUBT/RECONCILE/STOP) — commit `5f96fde`
- `stack.md` : section "Vérification documentaire par feature" (source-driven) — pas de mécanique de forçage, surveillance task-observer seuil 3 sauts — commit `5f96fde`
- `maj.md`, `CLAUDE.md`, `CLAUDE.global.md` mis à jour pour cohérence — commit `5f96fde`
- Hook `doubt-commit-reminder.sh` (PreToolUse sur `git commit`) : 3 itérations (JSON/exit 0 → pattern élargi → stderr/exit 1), toujours pas confirmé fonctionnel en fin de session malgré doc officielle et sous-agent affirmant tous deux que `systemMessage` s'affiche pour `PreToolUse` — contredit par le menu `/hooks` lui-même ("stdout/stderr not shown" sur exit 0). Test en session fraîche reporté à la prochaine session
- Fallback `/commit` invalidé par Medwin (jamais invoqué, ni par lui ni par moi) — repli retenu : bloc CLAIM écrit directement dans le chat avant tout commit non trivial, pas encore mis en œuvre
- 2 commits vides de test créés puis retirés proprement (`git reset --soft HEAD~2`, jamais poussés)
- `task-observer` : Observation 7 loguée puis marquée ACTIONNÉ

---

### Session — Résolution hook, cavecrew, 4 personas Osmani

- Obs. 8 tranchée (Medwin) : sync wiki interne rattachée à `/maj` Étape 5, pas "temps réel" — `Vibe-Method/CLAUDE.md` réécrit — commit `5582944`
- Hook doubt-driven confirmé non fonctionnel après 4 tests (2 sessions) — retiré de `settings.json`, script archivé, fallback CLAIM-en-chat documenté dans `methode.md` — obs. 9, commit `216edae`
- Obs. 10 : cavecrew jamais utilisé (Medwin ni l'agent) — décision Medwin : agent commence à s'en servir. Mécanisme de surveillance construit (`track-agent-usage.sh` + `stop-cloture.sh` étendu, alerte une fois/session si agents sans cavecrew) — testé 3 cas synthétiques, commit `c6a9be1`
- `cavecrew-investigator` utilisé en réel sur 3 skills Osmani (deprecation-and-migration, api-and-interface-design, accessibility-checklist)
- Correction Medwin sur les personas : fonction/moment/manière différents des skills existants, pas redondant — rôle de reviewer adversarial pour l'étape DOUBT. 4 agents construits (pas 2) : `code-reviewer`, `security-auditor`, `test-engineer`, `web-performance-auditor` — commit `875862d`
- Test d'invocation `code-reviewer` échoué (`Agent type not found`) — même défaut de chargement que le hook, vérification en session fraîche reportée
- Obs. 11 loguée : catégorie "Agents" absente du schéma wiki interne

---

### Session — Roadmap P1-P5 : clôture complète du chantier agent-skills

- 4 agents confirmés chargés en session fraîche. Test réel `code-reviewer` sur `scripts/lint-observabilite.py` → 4 cas de fail-open trouvés et corrigés (parsing structuré, fail-closed), 8 tests fixtures committés — commit `bc3cf43`
- Feuille de route créée (`vibe-method.todo.md` + kanban Tâches 30-34) suite à demande de Medwin
- P1 : checklists security/performance Osmani vérifiées contre `securite.md`/`stack.md` — 8 gaps patchés (STRIDE, rate limiting login, IA/LLM §2.13, logging requêtes lentes, CSS critique, requestIdleCallback, compression, CDN) — commit `50b1e93`
- P2 : `accessibilite.md` créé (WCAG 2.1 AA) + `architecture.md` enrichi (API/interfaces, deprecation/migration) — commit `901fd7e`
- P3 : `orchestration-patterns` formalisé dans `methode.md` (règle confirmée platform-enforced par Claude Code) + anti-rationalisation tables (`methode.md`, `securite.md`) — commit `7ddb58b`
- P4 : diff des 14 skills restants via 3 sous-agents parallèles — 6 gaps patchés (real>mock, feature flags/rollout, taille commit, state management/breakpoints/anti-esthétique-IA, Three-Tier Boundary). Correction Medwin en cours de route : Three-Tier Boundary écrit en doctrine portable, pas dépendant du système de permissions Claude Code — commit `ed3e665`
- P5 : décision MCP chrome-devtools — installé (`claude mcp add`, scope user) — commit `2c5fb44`
- Roadmap officiellement close, confirmé à Medwin : amélioration réelle de vibe-method, pas juste comparatif
- `handoff.md` vidé (contenu périmé) sur demande de Medwin
- gh auth a perdu ses scopes en cours de session, `gh auth refresh` (device code validé par Medwin) — repris normalement

---

## 2026-08-05 — Réorganisation, phases 3 à 7 : la méthode entre dans le second cerveau

Phases 0 à 2 menées plus tôt dans la journée par une session distincte (journal aux §18-19 de `migration-structure.md`). Cette session a mené tout le reste.

### Phase 3 — Répartition des skills

- 6 skills sortis vers `claude-config/commands/` : `lint` `wiki` `caveman` `pdf` `slides` `condense`. `firecrawl` y était depuis la phase 0. 56 restent dans la méthode
- `task-observer` aplati : `skills/task-observer/SKILL.md` → `commands/task-observer.md`. `~/.claude/skills/` supprimé. `session-start.sh` repointé et relancé pour vérification
- `install.sh` boucle sur `commands/*.md` au lieu de nommer les fichiers
- Effet de fond : `setup.sh` ne peut plus écraser ces 8 skills, sa boucle ne balaie plus leur dossier — mode de panne du 29/07 fermé par construction
- Commits `b10eaf6` (vibe-method), `1fabdfd` (claude-config), `da82464` (wiki)

### Phase 4 — 12 doctrines vers le wiki

- `produit` `methode` `design` `architecture` `securite` `rgpd` `tests` `stack` `observabilite` `accessibilite` `refacto` `ui-vocabulary` → `wiki/<nom>-doc.md`. 10 `Procédure`, 2 `Concept`
- **Décision §12 annulée** : les deux `rgpd.md` ne sont pas fusionnées. `rgpd.md` (`Concept`) dit le règlement, `rgpd-doc.md` (`Procédure`) dit quoi coder. Le `CLAUDE.md` du vault l'interdisait déjà. `sujet: Rgpd` conservé pour rester dans le cluster de 13 fiches
- Piège rattrapé par le lint : la substitution a produit `` `[[securite-doc]]` `` — le lien dans les backticks d'origine, donc du code. 12 fiches auraient été orphelines en paraissant reliées. 39 liens libérés
- 263 références corrigées. Deux substitutions partielles rattrapées à la relecture (`archi.md:411` mélangeait ancien et nouveau chemin dans la même phrase)
- Lint : 140 → 152 fiches, 221 → 243 signalements, 11 axes verts maintenus

### Phase 5 — 56 skills et 4 agents vers le wiki

- **Prérequis d'abord** : `log.md` → `journal-log.md` (collision avec le skill `/log`), `INFRA_FILES` de `lint-wiki.py` dans le même geste, 49 références corrigées. Vérifié avant toute arrivée de skill
- **Décisions de Medwin** : champ `claude-code: commande|agent` comme discriminant de l'installateur ; `sujet` et `cluster` rendus obligatoires (7 champs requis, 5 fiches complétées sur 152)
- Obligation posée dans `lint-wiki.py`, seul fichier partagé avec Hermes — la prose existe en deux copies, le lint en une seule
- Frontmatter **fusionné** dans le bloc existant, jamais préfixé : un second `---` aurait fait passer `allowed-tools` en corps de texte, sans erreur visible
- 8 clusters par phase du workflow plutôt qu'un cluster de 68 membres
- `diagnostic-serveur.md` : frontmatter invalide en YAML strict depuis sa création, corrigé par le quotage
- 86 mentions `/skill` des doctrines converties en `[[nom|/nom]]`, 60 sections « Fiches liées »
- Nœuds fantômes 33 → 2 : les 31 de `workflow-doc.md` se sont fermés seuls
- `setup.sh` réécrit — interroge le frontmatter, sauvegarde avant de remplacer
- Contrôle 11 ajouté à `audit-dependances.sh` : fiches `claude-code:` ↔ liens posés
- **Correction d'après-coup** : `/maj`, `/charte` et `/design` pointaient encore vers vibe-method. `/maj` est le plus grave, il tourne à chaque clôture

### Phase 6 — Suppression du miroir

- `Vibe-Method/` supprimé — 83 fichiers, 404 Ko, par `git rm` donc récupérable
- Les 4 fichiers non dérivés ouverts un par un avant suppression : aucun contenu absent d'ailleurs
- Règle du « corollaire du miroir » de `claude-config/CLAUDE.md` : exemple périmé remplacé
- Deux questions du todo closes, dont « l'infrastructure n'ira jamais dans un wiki » — réfutée par le test de frontmatter

### Phase 7 — Installateur unique

- `vibe-method/setup.sh` supprimé, absorbé par `claude-config/install.sh`. Deux sources : wiki et claude-config
- Les 3 hooks de la méthode rejoignent `wiki/hooks/` — prévu au §3, oublié en phase 5
- Idempotence vérifiée : second passage 0 posé, 78 inchangés, 0 sauvegarde. Hooks testés en entrée réelle
- Le défaut refermé était écrit dans `setup.sh` lui-même depuis une semaine

### Transverse

- **Propagation VPS tranchée** : `hermes-config` est un dépôt de sauvegarde, pousser n'atteint pas le VPS. Le sens inverse est `restaure-skills.sh vps`. **Non lancé** — écrit par SSH en production, décision de Medwin. Risque armé : le VPS journalise encore dans `log.md`, renommé
- 5 observations au carnet (41 à 45)
- Section « RESTE À FAIRE » créée en tête de `vibe-method.todo.md` — 8 rubriques, chaque ligne vérifiée sur pièces
- Défaut du lint découvert : l'extraction du titre H1 n'exclut pas les blocs de code
- État final : wiki 212 fiches, 11 axes verts, 0 lien cassé. 64 commandes, 4 agents, 5 hooks liés, 0 cassé

---

## 2026-08-06/07 — Clôture rubriques A-H du todo post-migration + restauration journal-log.md

### Rubrique A — Défauts du lint
- `extract_title` retirait pas les blocs fencés avant de chercher le H1 : 5 → 2 signalements
- Axe « liens non réciproques » restreint au cluster (`sujet` canonique) : 277 → 69

### Rubrique B — 212 fiches
- Nœuds fantômes comblés : `devis-pdf-workflow.md` (créé, pipeline Firma.dev réel), `ia-locale.md` (créé, chapeaute cluster existant)
- `iloveapi-signature-electronique.md` corrigée — périmée depuis le 03/08 (décision Firma.dev jamais reportée)
- 10 orphelines sur 17 réglées par lien depuis la doctrine qui les a nourries
- 6 skills courts (`zoom-out` `log` `askme` `checkpoint` `spec` `majtodo`) : section « Prochaine étape » ajoutée, trou objectif (38 fiches l'ont, ces 6 en étaient dépourvues)
- Stubs 8 → 5 ; `wikilinks.md` : vrai défaut de mise en forme (fragments orphelins), pas de longueur
- `notion-dpa-texte-integral` ↔ `notion-msa-texte-integral` (95%) : faux positif vérifié — deux contrats distincts, similarité vient du seul titre H1

### Rubrique C — workflow-doc.md
- Diff systématique 57 skills réels vs documentés : 5 manquants (`init-projet` `to-issues` `diagnose` `backup` `deploy`), tous ajoutés. `/condense` retiré (sorti le 05/08)
- Guide passé de 7 à 8 parties (Partie 0 Initialisation, Partie 8 Mise en production)

### Rubrique E — VPS Hermes
- État du todo périmé : VPS déjà propagé (par qui, non déterminé), pas en v1.6.0 comme annoncé
- Régression de version trouvée et corrigée : `research/wiki` 1.7.0 → 1.9.0 (contenu déjà v1.8.0+fix, en-tête mentait)
- Divergence de comportement réelle sur règle 3 (suppression) : `wiki/CLAUDE.md` disait « sans hésiter », le skill Hermes exigeait déjà validation explicite — aligné sur la version Hermes

### Rubrique F — Dettes techniques
- `test_lint_observabilite.py` : 8/8 cas passent, pas de régression
- Sauvegarde mémoire : pas de panne, erreur de lecture du todo (mauvais fichier de log ciblé)
- Doctrine Skill vs MCP ajoutée à `architecture-doc.md`

### Rubrique G — Résidus (décision Medwin)
- `test-claude-design/` et `handoff-out.md` supprimés
- Statut d'archive du dépôt `vibe-method` documenté dans `CLAUDE.md`, 2 infos périmées corrigées au passage (workflow-doc retard faux, arbre `.claude/hooks/` inexistant)

### Incident hors plan — journal-log.md tronqué et désordonné
- Medwin repère `journal-log.md` à 373 lignes commençant au 03/08 — anomalie
- Cause : commit Hermes `6598e2f` (03/08 14h51) a écrasé 921 lignes par les 4 lignes de sa seule nouvelle entrée. Passé inaperçu 5 jours — fichier exempté du lint (`INFRA_FILES`)
- Restauré depuis `a39e0d4` : 924 insertions, 0 suppression vérifié contre HEAD
- Medwin repère ensuite un désordre chronologique (jul→jun→mai→jul→août) — deux restaurations distinctes concaténées sans fusion (la mienne + une restauration partielle antérieure d'Hermes)
- Retrié par script : 134 entrées, checksum multiset identique avant/après, séquence finale strictement monotone du 26/05 au 07/08
- Bug trouvé en triant : 14 en-têtes sans crochets (format `## date` au lieu de `## [date]`) échappaient au premier regex — dont 6 écrites par moi-même dans cette session
- 2 observations loggées (46, 47)

Commits : `dcbb5aa` `acc9ded` (vibe-method), `98ea544` (hermes-config), `c49f9e4` `1dfaf22` + auto-sync (wiki)
