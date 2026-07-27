---
type: skill
source: ../../.claude/commands/brief.md
source_modified: 2026-05-19
wiki_updated: 2026-05-26
tags: [phase-1, produit, brief]
phase: 1
---

## Rôle
**`/brief`** — De l'intention au brief structuré en 9 domaines.

## Inputs
- Intention verbale de Medwin
- `[projet].context.md` si existant (lu en amont)

## Output
`[projet].brief.md` + mise à jour de la section `## Projet` dans `CLAUDE.md`

## En résumé
Dialogue domaine par domaine (pas de formulaire). Une question ouverte par domaine, relance si vague, résumé + confirmation avant de passer au suivant. Brainstorming anti-biais si les fonctions sont évidentes. Comprend la qualification commerciale (modèle de prestation M1/M2/M3, stack, services tiers, coûts récurrents).

## Les 9 domaines
1. Le problème (pourquoi l'app existe)
2. Les utilisateurs (qui, contexte, niveau tech)
3. Les fonctions essentielles (3 à 5 + brainstorming)
4. Le hors-scope V1
5. Les contraintes techniques (stack, délai, budget, distribution)
6. Architecture légère et modèle de prestation (M1/M2/M3, stack, coûts)
7. Les règles métier (logique domaine)
8. Niveau de risque sécurité (Bas / Moyen / Élevé)
9. Données personnelles et RGPD

## Quality Gate
16 cases à cocher avant enregistrement. Brief incomplet → question manquante posée.

**Précédent :** [[skills/contexte]] | **Suivant :** [[skills/prd]]
**Doctrine :** [[doctrines/produit]]
