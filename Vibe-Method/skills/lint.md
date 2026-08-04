---
type: skill
source: ../../.claude/commands/lint.md
source_modified: 2026-08-04
wiki_updated: 2026-08-04
tags: [wiki, maintenance, lint]
---

## Rôle
**`/lint`** — Contrôle qualité du Wiki. Distinct du lint wiki vibe-method (étape 5 de `/maj`).

## Inputs
- Aucun input requis — opère sur `~/dev/wiki/` entier

## Modes

| Mode | Coût tokens | Détecte |
|---|---|---|
| `/lint quick` | Faible — lance uniquement `scripts/lint-wiki.py`, aucune lecture LLM | Les 5 axes mécaniques (graphe, doublons/stubs, terminologie, structure, conflits de dates) |
| `/lint` | Élevé — script + lecture intégrale des fiches | Les 5 axes mécaniques + contradictions sémantiques et pages manquantes (non mécanisables) |

Depuis le 08/07/2026 (T16), les axes mécaniques viennent du **script partagé** `~/dev/wiki/scripts/lint-wiki.py` — même détection côté Claude Code et côté Hermes (skill `wiki-lint`), plus de divergence de critères.

## Étape 0 — Vérification du vérificateur (2026-08-04)
Avant d'exploiter un rapport en masse, et après toute modification de `lint-wiki.py` : copier le wiki dans `/tmp`, y fabriquer une violation par axe, confirmer qu'elle ressort. Un axe resté vert sur une violation fabriquée est cassé. Motif : un ✅ peut signifier « rien à signaler » ou « je n'ai rien lu », et la sortie ne les distingue pas — trois axes se sont révélés faux le 03/08/2026, dont un contrôle de tags qui lisait une liste vide et affichait vert depuis sa création. Corollaire : tout chiffre extrême (0 % ou ~100 % des fiches) se traite comme un défaut d'outil avant un défaut de données.

## En résumé
Lance le script sur `~/dev/wiki/`, puis (mode complet) lit les fiches pour ce que le script ne peut pas voir. Chaque correction se fait avec validation de Medwin. Toutes les corrections sont loggées dans `~/dev/wiki/log.md`.

## Liens
- [[skills/archi]] — pattern de consultation Wiki avant spike
- [[skills/phase-retrospective]] — enrichit le Wiki en fin de projet
- [[skills/maj]] — étape 5 : lint wiki vibe-method (distinct)
