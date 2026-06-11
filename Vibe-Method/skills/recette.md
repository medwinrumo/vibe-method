---
type: skill
source: ../.claude/commands/recette.md
source_modified: 2026-06-11
wiki_updated: 2026-06-11
tags: [phase-7, recette, gherkin, validation-manuelle]
phase: 7
---

## Rôle
**`/recette`** — Génère le cahier de recettes depuis les user stories (Gherkin) + coordination de la validation manuelle par Medwin.

## Inputs
- `[projet].spec.[feature].md`
- `[projet].gherkin.[feature].md` (si existant)

## Output
`[projet].recette.md`

## En résumé
Génère les scénarios Gherkin depuis les user stories, organise le cahier de recette. La validation manuelle par Medwin est le dernier filtre — ce que l'automatisation ne peut pas juger (cohérence visuelle, fluidité, ressenti global). Un bug détecté → `/debug` déclenché automatiquement.

## Définition de "done" feature
La feature est Done uniquement quand le cahier de recette est validé manuellement par Medwin.

## Propose la mise à jour de doc-user.md
Après validation de phase → `/recette` (étape 6) propose de mettre à jour `[projet].doc-user.md`.

**Précédent :** [[skills/doc-tech]] (Mode B) | **Suivant :** [[skills/debug]] (si bug) → [[skills/commit]] → [[skills/pr]] → [[skills/phase-retrospective]] (si phase terminée)
**Doctrine :** [[doctrines/tests]]
