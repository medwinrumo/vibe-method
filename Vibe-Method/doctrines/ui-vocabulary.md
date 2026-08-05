---
type: doctrine
source: ../../ui-vocabulary.md
source_modified: 2026-07-28
wiki_updated: 2026-08-05
tags: [design, ui, ux, lexique, composants, state-management, esthétique-ia]
---

# Doctrine — Vocabulaire UI/UX

## En une ligne
Lexique de référence : nommer correctement zones, composants et états avant tout `/charte` ou `/design` Mode A.

Sa fonction est d'éviter le malentendu de vocabulaire. Quand Medwin et Claude ne désignent pas la même chose par « card », « surface » ou « sticky header », le design part de travers sans que personne ne le voie.

---

## Ce que couvre le lexique

| Section | Contenu |
|---|---|
| Les zones d'un écran | Découpage fixe / scrollable, le cas du sticky header |
| Fond de page vs surface | La distinction qui structure toute la profondeur visuelle |
| Composants courants | Boutons, inputs, card, badge/tag/chip, avatar, tabs, separator, skeleton/loader |
| États d'un composant | La grille des états à prévoir systématiquement |
| Couleurs et leur rôle | Ce que chaque couleur fait, pas juste sa valeur |
| Patterns de navigation | Les schémas standard |
| Propriétés visuelles clés | Le vocabulaire des ajustements |

Le fichier source contient de l'ASCII art pour chaque zone et composant — c'est là qu'il faut aller pour lever un doute précis.

---

## Trois règles opérationnelles à retenir

**Échelle de state management** (2026-07-28) — choisir l'approche la plus simple qui marche, ne pas sauter au store global par réflexe :

```
State local (useState)           → état UI propre au composant
State levé                       → partagé entre 2-3 composants frères
Context                          → theme, auth, locale (lu souvent, écrit rarement)
State d'URL (searchParams)       → filtres, pagination, état partageable par lien
State serveur (React Query, SWR) → données distantes avec cache
Store global (Zustand, Redux)    → state client complexe partagé dans toute l'app
```

Éviter le prop drilling au-delà de 3 niveaux.

**Breakpoints de test** — systématiquement 320 / 768 / 1024 / 1440 px.

**Éviter l'esthétique IA** — huit défauts reconnaissables listés avec leur contrepartie de qualité production : violet/indigo par défaut, gradients excessifs, tout arrondi, hero sections génériques, lorem ipsum, padding surdimensionné, grilles de cards uniformes, ombres partout. Le principe commun : ces choix sont des **valeurs par défaut sûres** qui rendent toutes les applications identiques et masquent les vrais problèmes de layout.

**Chargement** — skeleton plutôt que spinner quand la forme du contenu est connue ; optimistic updates sur les actions probables.

---

## Liens
[[skills/charte]] | [[skills/design]] | [[doctrines/design]] | [[doctrines/accessibilite]]
