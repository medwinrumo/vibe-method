---
type: skill
source: ../../.claude/commands/wiki.md
source_modified: 2026-07-27
wiki_updated: 2026-07-27
tags: [wiki, second-cerveau, transversal]
---

## Rôle
**`/wiki`** — Enrichir `~/dev/wiki/` (second cerveau) depuis n'importe quel dossier de travail. Garantit que les règles de `~/dev/wiki/CLAUDE.md` s'appliquent même hors du dossier wiki.

## Inputs
- Une source de contenu à clarifier en premier (conversation en cours, document externe, résultat de crawl, portion ciblée d'échange) — étape 0 obligatoire, sauf si Medwin l'a déjà précisée

## Ce que Claude fait
1. `cd ~/dev/wiki && git pull` avant toute lecture/écriture (anti-collision Hermes)
2. Lit `~/dev/wiki/CLAUDE.md` en entier si pas déjà fait dans la session
3. Lit `~/dev/wiki/index.md` pour repérer les doublons potentiels
4. Applique les règles telles quelles (frontmatter, dédoublonnage, wikilinks, tags canoniques)
5. Logge dans `~/dev/wiki/log.md`
6. Commit + push immédiat — sans attendre

## Règle absolue
Jamais d'écriture dans `~/dev/wiki/` sans avoir lu `CLAUDE.md` au préalable dans la session, même sujet simple.

## À ne pas confondre
Distinct du wiki vibe-method (`Vibe-Method/`, ce vault) — celui-ci est maintenu via la règle de mise à jour automatique de `Vibe-Method/CLAUDE.md`, pas via `/wiki`.

## Liens
- [[doctrines/methode]] — posture de capture de connaissance
- [[skills/lint]] — contrôle qualité du wiki `~/dev/wiki/`
