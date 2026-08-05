---
type: skill
source: ../../.claude/commands/cgv.md
source_modified: 2026-07-20
wiki_updated: 2026-08-05
tags: [commercial, cgv, contrat]
phase: commercial
---

## Rôle
**`/cgv`** — Génère les CGV (Conditions Générales + Conditions Particulières M1/M2/M3) à partir du brief et du contexte.

## Sources canoniques (déplacées le 20/07/2026)
Les gabarits contractuels vivent désormais dans **`~/dev/wiki/`** — partagé Mac/Hermes — et non plus dans `vibe-method` : `cgv-conditions-generales.md`, `cgv-cp-m1-dev-sur-mesure.md`, `cgv-cp-m2-saas-multiclients.md`, `cgv-cp-m3-notion.md`.

**Miroir côté Hermes** : le skill `cgv-generation` (`/opt/data/skills/productivity/cgv-generation/SKILL.md`, VPS) reproduit cette logique pour que Hermes génère un CGV sans Claude Code. Même source, deux procédures séparées, **aucune synchronisation automatique** — toute évolution ici doit être répercutée là-bas.

## Inputs
- `[projet].brief.md`
- `[projet].context.md` si existant
- Modèle de prestation (M1/M2/M3 défini dans le brief)

## Output
`[projet].cgv.md`

## En résumé
Génère les conditions contractuelles adaptées au modèle de prestation choisi. M1 (dev sur mesure client unique), M2 (SaaS multi-clients), M3 (système Notion). Les CGV couvrent les garanties, les évolutions post-livraison, la propriété intellectuelle, et les responsabilités.

**Précédent :** [[skills/devis]] | **Suivant :** [validation client] → [[skills/charte]]
