---
type: skill
source: ../../.claude/commands/backup.md
source_modified: 2026-07-27
wiki_updated: 2026-08-05
tags: [infrastructure, backup, rgpd, sécurité]
phase: infrastructure
---

## Rôle
**`/backup`** — Mise en place de la stratégie de backup définie à l'archi : dump chiffré, GitHub Actions, miroir GitLab, DPA, UptimeRobot, test de restauration.

## Inputs
- `[projet].archi.md` (niveau de criticité des données 1/2/3)

## En résumé
Exécute la stratégie de backup définie à l'archi. Pour les niveaux 2 et 3 : GitHub Actions (dump quotidien chiffré GPG), miroir GitLab, signature DPA Supabase/Convex, configuration UptimeRobot, test de restauration initial. Prend le relais de `/archi` pour l'exécution.

**Précédent :** [[skills/archi]] | **Doctrine :** [[doctrines/architecture]]
