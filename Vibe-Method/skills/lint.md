---
type: skill
source: ../.claude/commands/lint.md
source_modified: 2026-05-26
wiki_updated: 2026-05-26
tags: [2brain, maintenance, lint]
---

## Rôle
**`/lint`** — Contrôle qualité du 2Brain. Distinct du lint wiki vibe-method (étape 5 de `/maj`).

## Inputs
- Aucun input requis — opère sur `~/dev/2Brain/` entier

## Modes

| Mode | Coût tokens | Détecte |
|---|---|---|
| `/lint quick` | Faible — lit `index.md` + frontmatters | Pages orphelines, fichiers obsolètes (`updated` > 6 mois) |
| `/lint` | Élevé — lit tous les fichiers entiers | Contradictions, pages manquantes, orphelines, obsolètes |

## En résumé
Lit le 2Brain et signale 4 types de problèmes : contradictions entre pages, concepts sans leur propre page, pages orphelines, affirmations obsolètes. Chaque correction se fait avec validation de Medwin. Toutes les corrections sont loggées dans `~/dev/2Brain/log.md`.

## Liens
- [[archi]] — pattern de consultation 2Brain avant spike
- [[phase-retrospective]] — enrichit le 2Brain en fin de projet
- [[maj]] — étape 5 : lint wiki vibe-method (distinct)
