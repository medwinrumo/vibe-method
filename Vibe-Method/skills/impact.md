---
type: skill
source: ../../.claude/commands/impact.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [transversal, impact, changement, artefacts]
phase: transversal
---

## Rôle
**`/impact`** — Analyse d'impact d'un changement sur tous les artefacts du projet.

## Inputs
- Description du changement envisagé
- Artefacts du projet (PRD, archi, specs, code)

## En résumé
Avant tout changement structurant, identifie tous les artefacts impactés : fichiers sources, specs, tests, documentation, archi. Classe l'impact par criticité. Évite les effets de bord silencieux qui passent inaperçus dans une mise à jour parcellaire.

## Quand l'utiliser
- Avant de modifier une décision d'architecture
- Avant de changer une interface entre modules
- Avant de modifier une règle métier dans les specs

**Transversal — invocable à tout moment**
