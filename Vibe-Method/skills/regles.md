---
type: skill
source: ../.claude/commands/regles.md
source_modified: 2026-05-26
wiki_updated: 2026-05-26
tags: [phase-3, règles, contexte, llm]
phase: 3
---

## Rôle
**`/regles`** — Éliciter les règles non-évidentes du projet optimisées pour LLM — pièges, patterns obligatoires/interdits.

## Inputs
- `[projet].archi.md`
- Codebase existante (si brownfield)
- Connaissances domaine de Medwin

## Output
`[projet].regles.md` (aussi appelé `[projet].project-context.md`)

## En résumé
Dialogue en 7 questions pour capturer ce qu'une IA généraliste raterait sans être prévenue : conventions non-standards, pièges connus du domaine, patterns obligatoires, modules à ne pas toucher. Ce fichier est chargé dans le PRP à chaque session de code.

## Wiki
- **Écriture** : pour chaque règle liée à un outil (non spécifique au projet) → propose de l'enrichir dans `~/dev/wiki/[outil].md` — tags `[stack, outil]`

**Précédent :** [[skills/archi]] | **Suivant :** [[skills/stack]]
**Doctrine :** [[doctrines/architecture]]
