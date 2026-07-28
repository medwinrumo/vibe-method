---
type: doctrine
source: ../../accessibilite.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [accessibilite, wcag, a11y]
---

# Doctrine — Accessibilité

## En une ligne
WCAG 2.1 AA vérifié dès `/design`, pas ajouté en polish de fin de projet.

---

## Portée
Obligatoire pour toute interface avec de vrais utilisateurs. Pas de cérémonie sur un prototype — même filtre que le TDD obligatoire.

## Les 5 catégories
1. **Clavier** — tout atteignable au Tab, focus visible, pas de piège
2. **Lecteurs d'écran** — alt text, labels, un seul `<h1>`, `aria-live` pour le contenu dynamique
3. **Visuel** — contraste 4.5:1 (texte normal), couleur jamais seul indicateur
4. **Formulaires** — labels visibles, erreurs liées au champ, `autocomplete`
5. **Contenu** — `lang` déclaré, cibles tactiles ≥ 44×44px

## Où ça s'accroche
`/design` (contraste/focus dès le design system) → `/specs` (Étape 4c-quater) → `/code-review` (dimension de revue).

## Liens
[[doctrines/design]] | [[doctrines/methode]] | [[skills/specs]] | [[skills/code-review]]
