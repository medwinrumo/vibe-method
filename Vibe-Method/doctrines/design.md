---
type: doctrine
source: ../design.md
source_modified: 2026-05-15
wiki_updated: 2026-05-26
tags: [design, ui, claude-design, tailwind, nativewind]
---

# Doctrine — Design

## En une ligne
Interface d'abord, logique ensuite : l'app existe visuellement dans sa totalité avant qu'une ligne de code métier soit écrite.

---

## Le workflow

```
/charte → /design Mode A ↔ /archi → Claude Design → /design Mode B → révision in-browser → [code]
```

Figma est optionnel — pour retouches manuelles si nécessaire, pas dans la chaîne systématique.

---

## Étape 1 — Charte (`/charte`)

Couleurs, typographie, logo, ambiance générale → `[projet].charte.md`.
Point de départ du design system — tout découle de la charte.

Consulter `ui-vocabulary.md` avant tout Mode A pour nommer précisément les zones et composants.

---

## Étape 2 — Design system (`/design Mode A ↔ /archi`)

Phase itérative : les écrans révèlent des modules manquants dans l'archi ; l'archi précise les états des composants.

**One-shot** (≤ 6 écrans, 1 type d'utilisateur) : `[projet].design.md` unique.
**Two-step** (> 6 écrans, rôles multiples) :
- Passe 1 : `[projet].design-system.md` (tokens + composants)
- Passe 2 : `[projet].design-screens-[batch].md` par groupe d'écrans — **chaque fichier inclut la référence complète aux tokens** (Claude Design n'a pas de mémoire entre sessions)

**ASCII art** : format de maquette collaboratif pour les écrans complexes — alignement avant Claude Design.

---

## Étape 3 — Claude Design (outil externe)

- URL : claude.ai/design
- Modèle : Opus 4.7
- Input : `[projet].design.md`
- Output : HTML/CSS/JS interactif (pas React, pas Tailwind — étape suivante)

---

## Étape 4 — Intégration (`/design Mode B`)

Traduction HTML/CSS/JS → stack du projet :
- Web : classes Tailwind CSS dans composants React
- Natif : classes NativeWind dans composants React Native

Extraction du routing à cette étape : scan des éléments interactifs → tableau Simple/Conditionnel/Action → validation Medwin → écrit dans `[projet].archi.md`.

---

## Révision in-browser (avant code)

Après Mode B, parcourir l'interface dans le navigateur, corriger les défauts visuels et UX. C'est le bon moment — le code est encore propre, rien de métier n'est construit dessus.

---

## Règles

- La maquette est livrée **avant** le début du code
- Consulter `ui-vocabulary.md` avant toute session Mode A
- Si le design change en cours de dev → analyser l'impact avant d'appliquer
- Claude applique le design system, il ne l'invente pas

## Liens
[[skills/charte]] | [[skills/design]] | [[skills/archi]] | [[doctrines/architecture]]
