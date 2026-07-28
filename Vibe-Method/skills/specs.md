---
type: skill
source: ../../.claude/commands/specs.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [phase-5, specs, user-story, a4, observabilite]
phase: 5
---

## Rôle
**`/specs`** — User story auto-contenue — un fichier par feature. Format A4.

## Inputs
- `[projet].prd.md`
- `[projet].archi.md` (module ciblé, contraintes sécu)
- `[projet].stack.md` (gotchas → critères réalistes)

## Output
`[projet].spec.[feature].md`

## En résumé
Produit une user story auto-contenue qui tient sur une A4 : qui fait quoi dans quel but, règles de gestion, cas limites, cas d'échec, contexte d'implémentation, Definition of Done. Question systématique en fin de spec : cette tâche justifie-t-elle un agent IA ? Si oui → documenté dans la spec avec checklist de vérification.

## Signaux de découpage
- > 5 règles de gestion → story probablement trop large
- > 15-20 scénarios Gherkin à la recette → story confirmée trop large

## Déclenche /adr automatiquement
Après toute décision structurante identifiée dans la spec → `/adr` proposé.

## Vérification observabilité (Étape 4c-ter)
Si la feature est prod-critique (vrais utilisateurs, pas un `/prototype`) : 2-4 questions on-call + section "Signaux à instrumenter" obligatoire dans la spec, champ "Observabilité : Requise/Non requise". Vérifié mécaniquement par `/deploy` via `scripts/lint-observabilite.py`. Voir [[doctrines/observabilite]].

**Précédent :** [[skills/roadmap]] | **Suivant :** [[skills/angles-morts]] (spec) → [[skills/gherkin]] (Mode Specs)
**Doctrine :** [[doctrines/produit]] | [[doctrines/observabilite]]
