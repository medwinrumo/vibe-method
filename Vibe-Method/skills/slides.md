---
type: skill
source: ../../.claude/commands/slides.md
source_modified: 2026-05-08
wiki_updated: 2026-08-05
tags: [utilitaire, présentation, marp]
phase: utilitaire
---

## Rôle
**`/slides`** — Génération de présentation au format Marp (markdown → slides).

## Inputs
- Contenu à présenter (wiki pages, specs, roadmap)

## Output
Fichier `.md` au format Marp, lisible avec le plugin Obsidian Marp ou exportable en PDF/HTML.

## Images — règles obligatoires (2026-05-08)
1. **Toujours respecter le ratio source.** Récupérer les dimensions réelles avant insertion (`sips -g pixelWidth -g pixelHeight`), puis calculer `h` depuis `w` : `h = w * (pixelHeight / pixelWidth)`. Ne jamais fixer `w` et `h` indépendamment — l'image se déforme.

## En résumé
Transforme du contenu structuré en présentation Marp. Utile pour partager les outputs de la méthode (PRD, roadmap, architecture) sous forme de slides. Obsidian a un plugin Marp pour la prévisualisation.

**Utilitaire — invocable à tout moment**
