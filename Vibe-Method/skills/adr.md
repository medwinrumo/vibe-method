---
type: skill
source: ../../.claude/commands/adr.md
source_modified: 2026-06-11
wiki_updated: 2026-08-05
tags: [architecture, décision, adr]
phase: transversal
---

## Rôle
**`/adr`** — Capture d'une décision architecturale en 4 questions. Filtre 3 conditions avant création. **T3 — Opus.**

## Inputs
- Décision architecturale identifiée (depuis `/archi` ou `/specs`)

## Output
`[projet].adr.md` (append — une entrée par décision) **+ upsert de la section `## Décisions clés` dans le `CLAUDE.md` du projet** (une ligne par ADR, renvoyant au fichier détaillé)

## En résumé
Structure d'une entrée : contexte, options considérées, décision, conséquences. Proposé automatiquement par `/archi` (étape 5b) et `/specs` (étape 4d).

## Le filtre — les 3 conditions, toutes requises
1. **Difficile à inverser** — changer d'avis plus tard a un coût réel (migration, refonte, dette)
2. **Surprenant sans contexte** — un futur lecteur se demanderait « pourquoi ils ont fait ça ? » sans cette trace
3. **Vrai arbitrage** — il y avait de vraies alternatives ; une a été choisie pour des raisons précises

Si une seule manque → **pas d'ADR**. Décision évidente, facilement réversible, ou sans alternative réelle : un commentaire de code ou un message de commit suffit.

**Déclenché par :** [[skills/archi]] ou [[skills/specs]]
**Doctrine :** [[doctrines/architecture]]
