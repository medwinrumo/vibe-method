# vibe-method.log — Journal de bord

---

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
