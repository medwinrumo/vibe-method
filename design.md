# design.md

Doctrine de conception visuelle — du brief à l'interface, comment passer des features à une maquette exploitable par le code.

---

## Principe

La construction de l'application suit une logique précise : l'interface visuelle est construite en premier.

À ce stade, toutes les pages sont créées et visibles, tous les boutons sont positionnés, toutes les relations de navigation entre les éléments sont définies. L'application existe visuellement, dans sa totalité — mais rien ne fonctionne encore. Les boutons ne déclenchent aucune action, les logiques métier ne sont pas configurées.

C'est là qu'interviennent les sessions de code : écrire la logique fonctionnelle en s'appuyant sur le code d'interface déjà en place. L'interface est le squelette. Le code lui donne vie.

La référence visuelle est **Claude Design** par défaut — Figma reste disponible pour des retouches manuelles ou comme source alternative si le besoin s'en présente.

---

## Le workflow

```
/charte → /design Mode A ↔ /archi → Claude Design → /design Mode B → révision in-browser → [code]
```

**Figma :** optionnel, pour retouches manuelles si nécessaire — pas dans la chaîne systématique.

> **[RÉVISION 2026-05-15]**
> `ui-vocabulary.md` est le lexique de référence à consulter avant tout Mode A — zones d'un écran, composants, états, patterns, propriétés visuelles. Il permet à Medwin de nommer précisément ce qu'il veut sans avoir à l'inventer.
>
> **Révision in-browser (après Mode B, avant le code) :** parcourir l'interface dans le navigateur, corriger les défauts visuels et UX directement dans le code. C'est le bon moment — le code est encore propre, rien de métier n'est construit dessus. Voir le skill `/design` étape 5 Mode B pour la grille de vérification.

---

## Étape 1 — Charte graphique (`/charte`)

Couleurs, typographie, logo, ambiance générale. Produit `[projet].charte.md`.

C'est le point de départ du design system — rien n'est inventé après, tout découle de la charte.

---

## Étape 2 — Design system et architecture (`/design Mode A` ↔ `/archi`)

Phase itérative : `/design Mode A` et `/archi` se construisent en aller-retour.

- Les écrans révèlent des modules manquants dans l'architecture
- L'architecture précise les états attendus des composants

La phase se termine quand les deux sont cohérents. Output : `[projet].design.md` complet.

**Ce que produit `/design Mode A` :**
- Composants UI nécessaires, leurs états, leurs variantes
- Hiérarchie visuelle et espacements
- Comportements interactifs (hover, focus, erreur, chargement)
- Si utile : ASCII art pour les écrans complexes

**Vérifier dès cette étape** (voir `accessibilite.md`) : contraste des couleurs choisies (4.5:1 texte normal), état de focus visible défini pour chaque composant interactif — plus facile à corriger dans le design system que sur l'interface déjà codée.

**One-shot vs two-step :**

Le Mode A commence toujours par une décision de mode de travail avec Claude Design.

- **One-shot** (projet ≤ 6 écrans, 1 type d'utilisateur, navigation simple) : un seul `[projet].design.md` contenant design system ET écrans → Claude Design en une passe.
- **Two-step** (projet > 6 écrans, plusieurs rôles, navigation complexe) : deux passes. Passe 1 : `[projet].design-system.md` (tokens + composants uniquement) → Claude Design construit la référence visuelle. Passe 2 : `[projet].design-screens-[batch].md` par groupe d'écrans, chacun incluant la référence complète aux tokens et composants de la Passe 1 — Claude Design ne garde pas de mémoire entre sessions, la cohérence dépend entièrement de la présence de cette référence dans chaque document.

**ASCII art — format de maquette collaboratif :**

Pour les écrans dont la structure est non évidente, un ASCII art peut être esquissé dans `[projet].design.md`. C'est un format léger pour s'aligner sur la disposition avant de donner à Claude Design — ni prototype figé, ni contrainte rigide. Il sert de socle commun entre Medwin, Claude et Claude Design.

```
┌─────────────────────────────┐
│ [Logo]        [Nav]    [CTA]│
├─────────────────────────────┤
│  Titre principal            │
│  Sous-titre                 │
├──────────┬──────────────────┤
│  Sidebar │  Contenu         │
│  - item  │  principal       │
│  - item  │                  │
└──────────┴──────────────────┘
```

---

## Étape 3 — Génération de l'interface (Claude Design)

Claude Design prend `[projet].design.md` en input et génère le code HTML/CSS/JS de l'interface.

- **Outil :** Claude Design (Anthropic Labs — claude.ai/design)
- **Modèle :** Opus 4.7
- **Accès :** Pro, Max, Team, Enterprise
- **Input :** `[projet].design.md`
- **Output :** HTML/CSS/JS interactif (pas React, pas Tailwind — c'est l'étape suivante)

---

## Étape 4 — Intégration dans le projet (`/design Mode B`)

Claude traduit le HTML/CSS/JS de Claude Design dans la stack du projet :

- **Web :** classes Tailwind CSS dans les composants React
- **Natif (iOS/Android) :** classes NativeWind dans les composants React Native

À cette étape, les composants shadcn/ui (web) ou les composants natifs sont stylisés pour coller au design généré.

---

## Outils

| Outil | Rôle |
|---|---|
| **Claude Design** | Génération de l'interface depuis `[projet].design.md` (HTML/CSS/JS) |
| **Tailwind CSS** | Implémentation du style — projets web |
| **NativeWind** | Implémentation du style — projets natifs (iOS/Android) |
| **shadcn/ui** | Composants UI web prêts à l'emploi, personnalisables avec Tailwind |
| **Figma** | Optionnel — retouches manuelles si l'interface générée doit être ajustée |

---

## Règles

- La maquette est livrée **avant** le début du code — pas en cours de route
- Si le design change en cours de dev → discuter l'impact avant d'appliquer
- Claude applique le design system, il ne l'invente pas — si `[projet].design.md` est insuffisant, demander à Medwin
- La cohérence visuelle est une responsabilité de Claude : un composant a le même style partout
