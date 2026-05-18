# vibe-method.log — Journal de bord

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
