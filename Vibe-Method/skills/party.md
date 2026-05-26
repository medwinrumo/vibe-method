---
type: skill
source: ../.claude/commands/party.md
source_modified: 2026-05-08
wiki_updated: 2026-05-26
tags: [transversal, décision, multi-perspectives, sous-agents]
phase: transversal
---

## Rôle
**`/party`** — Multi-perspectives sur une décision : sous-agents parallèles avec angles distincts.

## Inputs
- La décision à trancher
- Le contexte (PRD, archi, contraintes)

## En résumé
Quand une seule perspective risque d'être insuffisante (choix d'archi, priorisation, découpage V1/V2), spawn des sous-agents en parallèle avec des angles différents. Chaque agent analyse la décision depuis son angle. Les divergences sont les points les plus précieux. Application concrète du double audit LLM de `securite.md`.

## Quand l'utiliser
- Choix structurant d'architecture
- Priorisation features V1/V2
- Découpage du scope
- Audit sécurité croisé (angle sécu)

**Transversal — invocable à tout moment dans la chaîne**
