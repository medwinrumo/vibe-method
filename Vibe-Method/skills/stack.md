---
type: skill
source: ../../.claude/commands/stack.md
source_modified: 2026-07-27
wiki_updated: 2026-07-27
tags: [phase-4, stack, spike, investigation, couts-caches]
phase: 4
---

## Rôle
**`/stack`** — Spike technique time-boxé : investigation stack, free tier, gotchas.

## Inputs
- `[projet].archi.md` (stack choisie)
- `[projet].brief.md`

## Output
`[projet].stack.md`

## En résumé
Pour chaque outil de la stack : version actuelle, limites free tier, gotchas critiques, sécurité spécifique, APIs clés, compatibilité entre outils. Ajoute une section "Risques sécu" par outil. Document vivant — tout gotcha découvert en dev y est ajouté immédiatement.

**Étape 2bis — Coûts cachés transverses** : une fois les outils investigués individuellement, vérifier systématiquement emailing transactionnel, monitoring d'erreurs, limites de collaboration multi-utilisateurs, rappel plafond de prélèvement CB. Voir [[doctrines/stack]] section Coûts cachés.

## Wiki
- **Lecture** (Étape 0ter) : lit les fichiers outils existants dans le Wiki avant le spike
- **Écriture** (Étape 6) : enrichit ou crée un fichier par outil dans `~/dev/wiki/` après le spike — tags `[stack, outil]`, source `[projet]`

## Ce que les autres skills consomment
- `/roadmap` → limites free tier (éviter features hors quota en V1)
- `/specs` → gotchas → critères d'acceptation réalistes
- `/tests` → patterns auth et mock
- `/sessionCode` → contraintes critiques rappelées à chaque session

**Précédent :** [[skills/regles]] | **Suivant :** [[skills/roadmap]]
**Doctrine :** [[doctrines/stack]]
