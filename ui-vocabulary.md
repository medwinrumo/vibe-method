# ui-vocabulary.md
> Lexique de référence UI/UX — zones, composants, états, patterns
> À consulter avant tout `/charte` ou `/design` Mode A

---

## Les zones d'un écran

Tout écran mobile ou web se découpe en zones. Certaines sont fixes (elles ne bougent pas pendant le scroll), d'autres sont scrollables.

```
┌─────────────────────────────┐
│         HEADER              │  ← Fixe en haut
│  (titre, navigation, back)  │
├─────────────────────────────┤
│                             │
│                             │
│      ZONE DE CONTENU        │  ← Scrollable
│    (le corps de l'écran)    │
│                             │
│                             │
├─────────────────────────────┤
│        BOTTOM BAR           │  ← Fixe en bas
│  (navigation ou input)      │
└─────────────────────────────┘
```

| Zone | Nom | Fixe ou scrollable | Usage typique |
|---|---|---|---|
| Haut | **Header** / **App bar** | Fixe | Titre de la page, bouton retour, actions |
| Milieu | **Zone de contenu** / **Main** | Scrollable | Tout le contenu de la page |
| Bas | **Bottom bar** / **Tab bar** | Fixe | Navigation principale ou barre de saisie |
| Popup | **Modal** / **Dialog** | Superposée | Confirmation, formulaire rapide |
| Panneau bas | **Bottom sheet** | Superposée (glisse du bas) | Sélection, options, filtres — mobile |
| Panneau côté | **Drawer** / **Sidebar** | Superposée (glisse du côté) | Menu de navigation |
| Fond obscurci | **Overlay** / **Backdrop** | Superposé | Fond sombre derrière une modal |

### Le sticky header

Quand le header reste visible pendant que la zone de contenu défile en dessous.

```
┌─────────────────────────────┐
│  HEADER (reste en place)    │  ← position: sticky
├─────────────────────────────┤
│  contenu qui défile         │
│  ↑ passe sous le header     │
│                             │
└─────────────────────────────┘
```

---

## Fond de page vs surface

```
┌─────────────────────────────────────┐
│                                     │
│  BACKGROUND (fond de page)          │
│  ┌───────────────────────────────┐  │
│  │  SURFACE / CARD               │  │  ← Posée sur le background
│  │  (fond blanc ou légèrement    │  │
│  │   différent, avec bordure     │  │
│  │   ou ombre)                   │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

| Terme | Ce que c'est | Signal visuel |
|---|---|---|
| **Background** | Couleur de fond de la page entière | Pas de bordure, s'étend jusqu'aux bords |
| **Surface** / **Card** | Bloc posé sur le background | Bordure fine, ombre légère, coins arrondis |

> **Règle :** si le fond et la card ont la même couleur, la hiérarchie visuelle disparaît. Toujours choisir deux couleurs distinctes ou utiliser une ombre.

---

## Les composants courants

### Boutons

```
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│  [ Valider ] │   │  [ Annuler ] │   │  [ Créer ]   │
│  Primary     │   │  Secondary   │   │  Destructive │
│  (couleur    │   │  (contour    │   │  (rouge)     │
│  principale) │   │  seulement)  │   │              │
└──────────────┘   └──────────────┘   └──────────────┘
```

| Type | Usage |
|---|---|
| **Primary** | Action principale de la page — un seul par écran |
| **Secondary** | Action secondaire, moins importante |
| **Ghost** / **Outlined** | Action tertiaire, très discret |
| **Destructive** | Suppression, action irréversible — rouge |
| **FAB** (Floating Action Button) | Bouton flottant — action principale sur mobile |

### Inputs (champs de saisie)

```
Label *
┌─────────────────────────────┐
│ Valeur saisie               │  ← État normal
└─────────────────────────────┘

Label *
┌─────────────────────────────┐
│ Valeur saisie               │  ← État focus (bordure colorée)
└─────────────────────────────┘ ← bordure accent

Label *
┌─────────────────────────────┐
│ Valeur saisie               │  ← État erreur (bordure rouge)
└─────────────────────────────┘
⚠ Message d'erreur ici
```

| Type d'input | Usage |
|---|---|
| **Text** | Saisie courte (nom, email) |
| **Textarea** | Saisie longue (description, commentaire) |
| **Select** / **Dropdown** | Choix dans une liste |
| **Date picker** | Sélection de date |
| **Checkbox** | Case à cocher — plusieurs choix possibles |
| **Radio** | Bouton rond — un seul choix parmi plusieurs |
| **Toggle** / **Switch** | Activer / désactiver |
| **Search** | Champ de recherche avec icône loupe |

### Card

```
┌─────────────────────────────┐
│ Titre                       │  ← Card simple
│ Sous-titre ou description   │
│ [Action]         [Action]   │
└─────────────────────────────┘
```

Une card regroupe des informations liées dans un bloc visuel délimité. Elle peut être cliquable (navigate vers un détail) ou statique.

### Badge / Tag / Chip

```
[● En cours]   [🔴 Haute]   [Alice]   [Design]
```

Petits éléments visuels inline pour indiquer un statut, une priorité, une catégorie, une personne assignée.

### Avatar

```
┌───┐   ┌───┐
│ AB│   │ 👤│   ← Initiales ou photo, forme ronde
└───┘   └───┘
```

Représentation visuelle d'un utilisateur. Souvent accompagné d'un nom.

### Tabs (onglets)

```
[Toutes] [En cours] [Terminées]
  ─────
```

Navigation horizontale entre plusieurs vues de la même page. L'onglet actif est souligné ou en surbrillance.

### Separator

```
─────────────────────────────
```

Ligne horizontale pour séparer visuellement deux sections.

### Skeleton / Loader

```
┌─────────────────────────────┐
│ ░░░░░░░░░░░░░░░░░           │  ← Placeholder gris animé
│ ░░░░░░░░                    │     pendant le chargement
└─────────────────────────────┘
```

---

## Les états d'un composant

Tout composant interactif a plusieurs états. Les spécifier dans le `design.md` évite que Claude Design les invente.

| État | Ce que c'est | Signal visuel typique |
|---|---|---|
| **Default** | État normal au repos | Couleur de base |
| **Hover** | Souris au-dessus (web) | Légère surbrillance ou changement de fond |
| **Focus** | Élément sélectionné au clavier ou au tap | Bordure colorée (ring) |
| **Active** / **Pressed** | Pendant le clic / tap | Légèrement plus foncé |
| **Disabled** | Non cliquable | Opacité réduite (50%), curseur interdit |
| **Loading** | En attente d'une réponse | Spinner ou skeleton |
| **Error** | Valeur invalide | Bordure rouge, message d'erreur |
| **Success** | Action réussie | Vert, icône check |
| **Empty** | Aucune donnée à afficher | Illustration ou message "Aucun résultat" |

---

## Les couleurs et leur rôle

| Nom | Rôle |
|---|---|
| **Primary** | Couleur de la marque — boutons principaux, éléments clés |
| **Secondary** | Couleur d'appui — actions secondaires, accents |
| **Accent** | Couleur qui attire l'œil — focus, liens, CTA |
| **Background** | Fond de page |
| **Surface** | Fond des cards et composants posés sur le background |
| **Border** | Couleur des bordures et séparateurs |
| **Foreground** / **Text** | Couleur du texte principal |
| **Muted** | Texte secondaire, placeholders, labels |
| **Destructive** | Rouge — suppression, erreur |
| **Success** | Vert — validation, confirmation |
| **Warning** | Orange — attention, alerte non critique |

---

## Les patterns de navigation

| Pattern | Description | ASCII |
|---|---|---|
| **Stack** | Les écrans s'empilent, bouton retour pour revenir | Écran 1 → Écran 2 → Écran 3 ← ← |
| **Tabs** | Navigation principale par onglets en bas (mobile) ou en haut (web) | [🏠 Home] [📋 Tasks] [👤 Profil] |
| **Drawer** | Menu latéral qui glisse depuis le bord | ☰ → panneau latéral |
| **Modal** | Écran superposé par-dessus l'écran courant | Fond obscurci + popup centré |
| **Bottom sheet** | Panneau qui glisse depuis le bas (mobile) | Glisse du bas vers le haut |

---

## Propriétés visuelles clés

| Propriété | Ce que c'est | Exemple de valeur |
|---|---|---|
| **border-radius** | Arrondi des coins | `0` = carré, `8px` = légèrement arrondi, `9999px` = pill |
| **shadow** | Ombre portée — donne de la profondeur | `0 2px 8px rgba(0,0,0,0.1)` |
| **padding** | Espace intérieur d'un composant | `16px` tout autour |
| **gap** | Espace entre les éléments dans une liste | `8px` entre chaque card |
| **opacity** | Transparence | `50%` = disabled |
| **z-index** | Ordre de superposition | Modal au-dessus du contenu |

---

## Échelle de state management

Comparaison `addyosmani/agent-skills` vs vibe-method (2026-07-28, P4). Choisir l'approche la plus simple qui marche — ne pas sauter à un store global par réflexe.

```
State local (useState)              → état UI propre au composant
State levé                          → partagé entre 2-3 composants frères
Context                             → theme, auth, locale (lu souvent, écrit rarement)
State d'URL (searchParams)          → filtres, pagination, état partageable par lien
State serveur (React Query, SWR)    → données distantes avec cache
Store global (Zustand, Redux)       → state client complexe partagé dans toute l'app
```

**Éviter le prop drilling au-delà de 3 niveaux.** Si des props traversent des composants qui ne les utilisent pas, passer en Context ou restructurer l'arbre.

---

## Breakpoints de test

Tester systématiquement à ces largeurs : **320px, 768px, 1024px, 1440px.**

---

## Éviter l'esthétique IA

Une UI générée par IA a des patterns reconnaissables. Les éviter tous :

| Défaut IA | Pourquoi c'est un problème | Qualité prod |
|---|---|---|
| Violet/indigo partout | Palette "sûre" par défaut, rend toutes les apps identiques | Utiliser la charte du projet |
| Gradients excessifs | Bruit visuel, clash avec la plupart des design systems | Plat ou dégradé subtil cohérent avec la charte |
| Tout arrondi (`rounded-2xl` partout) | Ignore la hiérarchie de rayons de coin d'un vrai design | Border-radius cohérent avec la charte |
| Hero sections génériques | Layout template, aucun lien avec le contenu réel | Layout piloté par le contenu |
| Texte lorem-ipsum | Cache les vrais problèmes de layout (longueur, retour à la ligne, débordement) | Contenu de substitution réaliste |
| Padding surdimensionné partout | Détruit la hiérarchie visuelle, gaspille l'espace | Échelle d'espacement cohérente |
| Grilles de cards uniformes | Ignore la priorité de l'information | Layout piloté par la priorité |
| Ombres partout | Concurrence le contenu, ralentit le rendu sur appareils bas de gamme | Ombre subtile ou absente, sauf si la charte le prévoit |

---

## Chargement et transitions

- **Skeleton loading**, pas de spinner générique pour du contenu qui a une forme connue (liste, carte) — donne une impression de vitesse perçue plus juste
- **Optimistic updates** — mettre à jour l'UI immédiatement sur une action utilisateur probable (ex : cocher une tâche), annuler silencieusement si le serveur refuse
