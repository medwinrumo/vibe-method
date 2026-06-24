---
type: infrastructure
source: ../CLAUDE.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags:
  - index
  - catalogue
  - overview
---

# Index — Wiki vibe-method

Catalogue de toutes les pages. Mis à jour à chaque ingest ou nouvelle page wiki.
→ [[_vue-ensemble]] pour la synthèse globale | → [[flux/chaine-complete]] pour la navigation par étape

---

## Infrastructure

| Page | Description |
|---|---|
| [[CLAUDE.md]] | Schéma du wiki — règles, opérations, conventions |
| [[_vue-ensemble]] | Synthèse globale de la méthode vibe-method |
| [[flux/chaine-complete]] | Chaîne complète des skills avec inputs/outputs/liens |
| [[index]] | Ce fichier — catalogue de toutes les pages |
| [[log]] | Journal chronologique des opérations wiki |

---

## Doctrines

| Page | Principe fondateur |
|---|---|
| [[doctrines/methode]] | Chef d'orchestre — 7 phases, 9 gestes, protocole d'escalade |
| [[doctrines/architecture]] | Contexte minimal = IA performante — modulaire + silos |
| [[doctrines/securite]] | Zero Trust — code IA = 2× plus de vulnérabilités |
| [[doctrines/tests]] | Vérifier fonctionnement ET correction — TDD + 3 niveaux |
| [[doctrines/design]] | Interface d'abord, logique ensuite — Claude Design workflow |
| [[doctrines/stack]] | Anticiper, pas réagir — spike technique time-boxé |
| [[doctrines/refacto]] | Discipline séparée — session dédiée, étapes atomiques |
| [[doctrines/produit]] | Brief → PRD → Story A4 → Gherkin |

---

## Skills — Phase 1 : Produit

| Skill | Rôle | Output |
|---|---|---|
| [[skills/contexte]] | Contexte projet (optionnel) | `[projet].context.md` |
| [[skills/brief]] | De l'intention au brief structuré | `[projet].brief.md` |
| [[skills/prd]] | Du brief au PRD V1 | `[projet].prd.md` |
| [[skills/prd-update]] | Intégration retours cross-pollination → PRD V2 | `[projet].prd.md` |
| [[skills/prd-validate]] | Gate PRD — 8 zones à valider | Rapport GO/BLOCKERS |
| [[skills/angles-morts]] | Zones d'ombre sur un doc (3 gates) — T3 Opus | Rapport (pas de fichier) |
| [[skills/gherkin]] | Révèle zones floues PRD (Mode PRD) / scénarios specs (Mode Specs) | `[projet].gherkin.[feature].md` |

## Skills — Commercial (projets client)

| Skill | Rôle | Output |
|---|---|---|
| [[skills/devis]] | Du brief à la proposition commerciale | `[projet].proposition.md` |
| [[skills/cgv]] | CGV adaptées au modèle M1/M2/M3 | `[projet].cgv.md` |

## Skills — Phase 2 : Design

| Skill | Rôle | Output |
|---|---|---|
| [[skills/charte]] | Charte graphique (couleurs, typo, ambiance) | `[projet].charte.md` |
| [[skills/design]] | Mode A : design system / Mode B : intégration Tailwind/NativeWind | `[projet].design.md` |

## Skills — Phase 3 : Architecture

| Skill | Rôle | Output |
|---|---|---|
| [[skills/archi]] | Architecture modulaire + silos + stack | `[projet].archi.md` + `CLAUDE.md` |
| [[skills/regles]] | Règles non-évidentes pour LLM | `[projet].regles.md` |
| [[skills/adr]] | Capture décision architecturale | `[projet].adr.md` |

## Skills — Phase 4 : Stack

| Skill | Rôle | Output |
|---|---|---|
| [[skills/stack]] | Spike technique — free tiers, gotchas | `[projet].stack.md` |

## Skills — Phase 5 : Planification

| Skill | Rôle | Output |
|---|---|---|
| [[skills/roadmap]] | Roadmap + planning | `[projet].Rmap.md` |
| [[skills/specs]] | User story auto-contenue (format A4) | `[projet].spec.[feature].md` |
| [[skills/to-issues]] | Specs → issues GitHub HITL/AFK | Issues GitHub |

## Skills — Gates

| Skill | Rôle | Output |
|---|---|---|
| [[skills/readyTo-code]] | Gate readiness avant code | Rapport GO/BLOCKERS |
| [[skills/setup]] | Bootstrap technique | Repo initialisé |
| [[skills/prp]] | Contexte condensé ≤ 1 000 tokens | `[projet].prp.md` |
| [[skills/avancement]] | Tracker YAML des features | `[projet].avancement.yaml` |

## Skills — Phase 6 : Code

| Skill | Rôle |
|---|---|
| [[skills/sessionCode]] | Sas obligatoire avant chaque session de code |

## Skills — Phase 7 : Vérification

| Skill | Rôle | Output |
|---|---|---|
| [[skills/code-review]] | Revue structurelle + sécurité | Rapport (bloquant si critique) |
| [[skills/code-review-edge-cases]] | Chasse aux cas non gérés | Liste énumérée |
| [[skills/repair-edge-cases]] | Correction des cas non gérés | Corrections atomiques |
| [[skills/code-review-hostil]] | Revue cynique — 10+ problèmes | Rapport BLOQUANT/IMPORTANT |
| [[skills/tests]] | Tests Vitest + Playwright | Tests + non-régression |
| [[skills/securite]] | Check sécurité feature | Rapport (bloquant si échec) |
| [[skills/doc-tech]] | Mode A : vue dev / Mode B : JSDoc/TSDoc | `[projet].doc-tech.md` |
| [[skills/recette]] | Cahier de recettes + validation manuelle | `[projet].recette.md` |
| [[skills/debug]] | Diagnostic et résolution de bug | — |
| [[skills/diagnose]] | Diagnostic approfondi (escalade de /debug) | — |
| [[skills/commit]] | Commit Conventional Commits depuis diff Git — T1 Haiku opt. | Commit Git |
| [[skills/pr]] | Pull Request depuis la spec — `gh pr create` — T1 Haiku opt. | PR GitHub |
| [[skills/phase-retrospective]] | Rétrospective fin de phase | `[projet]-retrospective.md` |

## Skills — Transversaux

| Skill | Rôle |
|---|---|
| [[skills/party]] | Multi-perspectives — sous-agents parallèles |
| [[skills/impact]] | Analyse d'impact d'un changement |
| [[skills/grill-me]] | Interrogatoire d'un plan — stress-test |
| [[skills/zoom-out]] | Carte du module courant |
| [[skills/prototype]] | Code jetable pour valider une décision |
| [[skills/askme]] | Questions contextuelles rapides |
| [[skills/refacto]] | Refactoring guidé — session dédiée |
| [[skills/condense]] | Condensation d'un document long en inputs exploitables — T2 Sonnet |
| [[skills/lint]] | Contrôle qualité du Wiki — modes quick et complet |

## Skills — Gestion de session

| Skill | Rôle |
|---|---|
| [[skills/todo]] | Début de session — sync GH Projects |
| [[skills/maj]] | Clôture de session — Git + GH Projects |
| [[skills/majtodo]] | Mise à jour `[projet].todo.md` |
| [[skills/checkpoint]] | Documentation intermédiaire |
| [[skills/handoff]] | Ancre de contexte mid-session |
| [[skills/log]] | Journal de bord `[projet].log.md` |
| [[skills/peda]] | Journal pédagogique + glossaire |
| [[skills/doc]] | Documentation utilisateur |
| [[skills/spec]] | Spec globale du projet |

## Skills — Infrastructure & Utilitaires

| Skill | Rôle |
|---|---|
| [[skills/init-projet]] | Bootstrap Git + Notion nouveau projet |
| [[skills/deploy]] | Mise en production guidée |
| [[skills/backup]] | Stratégie de backup (dump chiffré, DPA, tests) |
| [[skills/slides]] | Génération présentation Marp |
| [[skills/pdf]] | Génération document PDF professionnel |
| [[skills/caveman]] | Mode communication compressé |

---

## Concepts

| Page | Description |
|---|---|
| [[skills/prp-skill]] | Le PRP — Project Ready Prompt (concept, pas skill) |
