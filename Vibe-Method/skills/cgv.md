---
type: skill
source: ../.claude/commands/cgv.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [commercial, cgv, contrat]
phase: commercial
---

## Rôle
**`/cgv`** — Génère les CGV (Conditions Générales + Conditions Particulières M1/M2/M3) à partir du brief et du contexte.

## Inputs
- `[projet].brief.md`
- `[projet].context.md` si existant
- Modèle de prestation (M1/M2/M3 défini dans le brief)

## Output
`[projet].cgv.md`

## En résumé
Génère les conditions contractuelles adaptées au modèle de prestation choisi. M1 (dev sur mesure client unique), M2 (SaaS multi-clients), M3 (système Notion). Les CGV couvrent les garanties, les évolutions post-livraison, la propriété intellectuelle, et les responsabilités.

**Précédent :** [[skills/devis]] | **Suivant :** [validation client] → [[skills/charte]]
