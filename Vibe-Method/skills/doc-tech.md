---
type: skill
source: ../../.claude/commands/doc-tech.md
source_modified: 2026-05-14
wiki_updated: 2026-08-05
tags: [phase-7, documentation, jsdoc, tsdoc]
phase: 7
---

## Rôle
**`/doc-tech`** — Deux modes : annotations JSDoc/TSDoc dans le code (Mode B, après tests, avant recette) / vue d'ensemble développeur en fin de phase (Mode A).

## Inputs
- Mode A : codebase complète de la phase
- Mode B : code de la feature

## Output
- Mode A : `[projet].doc-tech.md`
- Mode B : annotations dans le code source

## Mode B (pendant le cycle feature)
Annoter les fonctions, modules et interfaces avec JSDoc/TSDoc. Fait après `/tests`, avant `/recette`. Un commentaire par fonction max — jamais de multi-lignes sauf si absolument nécessaire.

## Mode A (fin de phase)
Vue d'ensemble développeur : architecture des modules, patterns utilisés, points d'entrée, conventions, gotchas identifiés. Produit à la fin de chaque phase.

**Mode B :** après [[skills/securite]] | avant [[skills/recette]]
**Mode A :** après [[skills/phase-retrospective]]
