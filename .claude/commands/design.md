# /design — Design system et intégration

Tu guides Medwin dans la production du design system du projet, en deux modes distincts qui interviennent à des moments différents de la chaîne.

- **Mode A** — Produire `[projet].design.md` : le design system complet, qui servira d'input direct à Claude Design
- **Mode B** — Intégrer le code produit par Claude Design dans la stack technique (Tailwind ou NativeWind)

---

## Positionnement dans la chaîne

```
/charte (charte graphique)
  ↓
Mode A /design  ←→  /archi  (phase itérative)
  ↓
Claude Design (outil externe — Medwin donne [projet].design.md)
  ↓
Mode B /design (intégration du code dans Tailwind ou NativeWind)
```

**Mode A** commence avant `/archi` et se construit en aller-retour avec lui. Les features révèlent les composants, l'archi précise les états. À la sortie de la phase itérative : `[projet].design.md` complet.

**Mode B** intervient après que Claude Design a produit le code — après `/stack`, avant le code métier.

---

## MODE A — Production du design system

### Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **`[projet].charte.md`** — la charte graphique définie avec `/charte`
3. **`[projet].prd.md`** — pour connaître les features V1 et les parcours clés
4. **`[projet].archi.md`** si disponible — pour connaître le périmètre de distribution (web / native / PWA)

> **[RÉVISION 2026-05-15]**
> Avant de produire `[projet].design.md`, rappeler à Medwin l'existence de `ui-vocabulary.md` :
> "Avant de commencer, je te recommande de consulter `ui-vocabulary.md` dans vibe-method — il contient le vocabulaire de référence (zones d'un écran, composants, états, patterns). Si tu ne connais pas le nom d'un élément que tu veux, c'est là que tu le trouveras."

Si la charte est absente → tu t'arrêtes :
> "La charte graphique n'est pas définie. Lance `/charte` d'abord."

Si le PRD est absent → tu t'arrêtes :
> "Le PRD est nécessaire pour lister les features. Lance `/prd` d'abord."

---

### Étape 0b — One-shot ou two-step ?

Avant de produire quoi que ce soit, tu poses la question du mode de travail avec Claude Design.

Tu lis le PRD et comptes les écrans estimés, les types d'utilisateurs, la complexité de la navigation.

**Critères de décision :**

| Critère | One-shot | Two-step |
|---|---|---|
| Nombre d'écrans V1 | ≤ 6 | > 6 |
| Types d'utilisateurs | 1 | ≥ 2 (ex : admin + user) |
| Navigation | Linéaire ou à 2 niveaux | Multi-niveaux, drawer, rôles |
| Nombre de composants distincts | Faible (< 8) | Élevé (≥ 8) |

> "D'après le PRD, le projet a [N écrans estimés], [1 / plusieurs] type(s) d'utilisateur(s) et une navigation [simple / complexe]. Je recommande l'approche [one-shot / two-step].
>
> **One-shot** : un seul `[projet].design.md` contenant le design system complet ET tous les écrans → donné à Claude Design en une passe.
>
> **Two-step** : deux passes distinctes —
> 1. `[projet].design-system.md` (design system uniquement : tokens, composants, états — aucun écran) → Claude Design construit la référence visuelle
> 2. `[projet].design-screens-[batch].md` (écrans par groupe, chacun référençant le design system établi) → Claude Design produit les écrans en cohérence avec la Passe 1
>
> Tu confirmes ?"

**Si one-shot confirmé :** continuer normalement — un seul `[projet].design.md` en sortie de Mode A.

**Si two-step confirmé :** la production se divise en deux sous-phases :
- **Sous-phase A1** : produire `[projet].design-system.md` (tokens + composants + états — pas d'écrans). Medwin le donne à Claude Design. Claude Design produit la référence HTML/CSS. Medwin revient avec le résultat → Mode B partiel (extraction des tokens dans Tailwind uniquement — pas encore d'écrans à intégrer).
- **Sous-phase A2** : reprendre Mode A ici pour produire les fichiers d'écrans `[projet].design-screens-[batch].md`. Chaque fichier commence par une section "Design system de référence" pointant vers les tokens et composants définis en A1. Medwin donne chaque fichier à Claude Design séparément. Claude Design produit les écrans en s'appuyant sur la référence A1.

> **Règle two-step :** chaque `[projet].design-screens-[batch].md` DOIT inclure en tête une section "Référence design system" qui recopie les tokens critiques (couleurs, typo, border-radius, espacements) ET liste les composants déjà construits en Passe 1. C'est ce qui garantit la cohérence entre passes — Claude Design ne garde pas de mémoire d'une session à l'autre.

---

### Étape 1 — Périmètre de distribution et implications design

Tu lis `[projet].archi.md` et confirmes le périmètre :

**Si app native (React Native / Expo) :**
- Les maquettes sont produites dans Claude Design — agnostique de la technologie, donc OK
- Le code produit par Claude Design sera du CSS web → Mode B le traduira en NativeWind
- Les guidelines de design sont contraignantes :
  - **iOS** : Human Interface Guidelines — zones tactiles min 44×44pt, navigation TabBar ou NavigationStack, safe areas, dark mode obligatoire, Dynamic Type
  - **Android** : Material Design 3 — zones tactiles min 48×48dp, navigation NavigationBar ou drawer, couleurs dynamiques Material You
- Décision à poser : **design cross-platform unique** (recommandé — respecte les contraintes des deux plateformes) ou **design adapté par plateforme** (plus natif, deux fois plus de travail)

**Si web / PWA :**
- Stack standard : Tailwind CSS + shadcn/ui
- Responsive à préciser : mobile-first, desktop-first, ou deux layouts distincts

**Si site vitrine présent :**
- Deux surfaces à couvrir dans le design system : vitrine (landing, conversion) + app (usage quotidien)
- Même charte graphique, composants différents
- Traiter les deux séparément dans le Mode A : vitrine d'abord (plus simple), app ensuite

---

### Étape 2 — Design Thinking (si pertinent)

Si l'une de ces conditions est vraie, proposer un Design Thinking rapide (20 min) avant de lister les features :
- Le PRD décrit des fonctionnalités mais pas ce que ressent l'utilisateur
- Le produit ressemble à un existant (risque de copier sans différencier)
- Il y a un doute sur "est-ce qu'on résout le bon problème ?"

> "Avant de lister les composants, il peut être utile de faire un Design Thinking rapide pour s'assurer qu'on conçoit la bonne interface. Tu veux le faire ?"

Si oui → 5 phases : Empathize (qui est l'utilisateur, quelles frustrations), Define (phrase-problème), Ideate (10+ idées), Prototype (hypothèse à valider), Synthèse.
Si non → continuer directement à l'étape 3.

Si plusieurs directions visuelles radicalement différentes semblent possibles mais qu'il est difficile de choisir sans les voir → `/prototype` (branche UI) génère des variations concrètes switchables avant de s'engager dans le design system complet.

---

### Étape 3 — Écrans principaux et parcours clés

Tu lis le PRD et identifies les écrans principaux de la V1 :

> "Depuis le PRD, je vois ces parcours clés :
> 1. [Parcours 1 — ex : inscription → onboarding → tableau de bord]
> 2. [Parcours 2 — ex : recherche d'un membre → consultation du profil → prise de contact]
>
> Est-ce que ça couvre les parcours essentiels ? Il y en a d'autres à ajouter ?"

Pour chaque parcours, liste les écrans :
- Écran d'entrée
- Écrans intermédiaires
- Écran de sortie (confirmation, erreur, état vide)

---

### Étape 4 — Inventaire des composants

À partir des écrans listés, tu identifies tous les composants UI nécessaires :

> "Voici les composants que je vois nécessaires pour couvrir ces écrans :"

Format :
```
- [Nom du composant]
  - Usage : [dans quel(s) écran(s)]
  - Variantes : [taille, style, contexte]
  - États : [normal, hover, focus, disabled, loading, error, empty, success]
```

**Règle sur les états :** les états fonctionnels (loading, error) dépendent de l'architecture — ils se précisent pendant la phase itérative avec `/archi`. Les états de base (normal, hover, disabled) se définissent ici.

Tu présentes l'inventaire complet et demandes validation.

---

### Étape 5 — Phase itérative avec /archi

Cette étape est explicitement itérative — elle n'a pas de fin fixe. Elle se déroule en parallèle de `/archi`.

**Ce que /design apporte à /archi :**
- Les écrans révèlent des modules manquants dans l'architecture
- Les composants précisent les données nécessaires → impact sur le schéma BDD
- Les parcours révèlent des cas limites non couverts dans le PRD

**Ce que /archi apporte à /design :**
- Les modules précisent quels appels sont asynchrones → quels composants ont un état loading
- Le schéma BDD précise quelles données sont disponibles → quels états "vide" sont possibles
- Les règles silo précisent quels composants appartiennent à quel module

**Comment gérer l'aller-retour :**
À chaque échange avec `/archi`, noter dans `[projet].design.md` ce qui a changé :
> "Suite à décision archi [X] : le composant [Y] ajoute un état [Z]."

La phase se termine quand archi et design sont cohérents — pas avant.

---

### Étape 6 — Design system complet

À la sortie de la phase itérative, tu produis la version finale du design system dans `[projet].design.md`.

**Ce que le fichier doit contenir pour être un input exploitable par Claude Design :**

1. **Charte graphique appliquée** — copie des tokens de `[projet].charte.md` traduits en valeurs concrètes (hex, px, rem)
2. **Typographie** — niveaux de hiérarchie avec taille, poids, interligne pour chaque niveau
3. **Espacements** — grille d'espacements (4px, 8px, 16px, 24px, 32px, 48px, 64px)
4. **Composants** — pour chaque composant : description, variantes, tous les états avec description visuelle
5. **Écrans** — pour chaque écran : layout, composants utilisés, données affichées, états possibles de l'écran (vide, chargement, erreur, nominal)
6. **Navigation** — comment on passe d'un écran à l'autre, quel composant déclenche quelle transition
7. **Accessibilité** — contrastes minimum respectés (WCAG AA), tailles de zones tactiles, labels aria
8. **Si app native** : notes sur les guidelines Apple HIG et Material Design à respecter, décision cross-platform ou adapté par plateforme

> **Règle de complétude :** ce fichier doit être suffisamment complet pour que Claude Design l'exécute sans question supplémentaire. L'instruction sera : "Voici le design system en markdown — construis-le." Plus le fichier est précis, moins Claude Design improvise.

> **[RÉVISION 2026-05-15]**
> **La précision est de tous les instants.** Claude Design n'interrompt jamais pour demander une clarification — il interprète et produit. Chaque décision non prise par Medwin est une décision prise par Claude Design. Cela s'applique à tous les niveaux : structure des zones (card ou background ?), comportements au clic, états de chaque composant, zones cliquables, espacement entre éléments.
>
> Avant de valider `[projet].design.md`, passer chaque écran en revue avec Medwin en mode dialogue guidé : proposer des options nommées avec ASCII art pour chaque point d'ambiguïté, forcer la décision explicite. Ne jamais laisser un point ouvert à l'interprétation.
>
> Référence : `ui-vocabulary.md` — à utiliser pour nommer les éléments et proposer les options.

---

### Étape 7 — Enregistrement Mode A

Tu écris `[projet].design.md` dans le répertoire courant du projet.

```markdown
# Design system — [Nom du projet]
_Mode A complété le [date]_

## Périmètre
- Plateformes : [web / iOS natif / Android natif / PWA]
- Site vitrine : [oui / non]
- Outil CSS : [Tailwind / NativeWind / les deux]

## Charte graphique appliquée

### Couleurs
- Principale : [hex]
- Secondaire : [hex]
- Neutres : [liste hex]
- Succès : [hex] — Erreur : [hex] — Avertissement : [hex] — Info : [hex]
- Dark mode : [palette dark si applicable]

### Typographie
| Niveau | Police | Taille | Poids | Interligne |
|---|---|---|---|---|
| Display | | | | |
| Titre H1 | | | | |
| Titre H2 | | | | |
| Corps | | | | |
| Caption | | | | |

### Espacements
4 / 8 / 12 / 16 / 24 / 32 / 48 / 64px

### Style visuel
- Border-radius : [valeur]
- Ombres : [description]
- Animations : [aucune / subtiles / marquées]

## Composants

### [Nom du composant]
Description : [à quoi il sert]
Variantes : [liste]

| État | Description visuelle |
|---|---|
| Normal | |
| Hover | |
| Focus | |
| Disabled | |
| Loading | |
| Error | |
| Success | |

[répéter pour chaque composant]

## Écrans

### [Nom de l'écran]
Parcours : [dans quel parcours cet écran apparaît]
Layout : [description du layout]
Composants utilisés : [liste]
Données affichées : [liste]

| État de l'écran | Description |
|---|---|
| Nominal | |
| Chargement | |
| Vide | |
| Erreur | |

[répéter pour chaque écran]

## Navigation
[Description des transitions entre écrans]

## Notes guidelines stores
[Si app native : points Apple HIG et Material Design à respecter]
```

Confirmer :
> "`[projet].design.md` complet → prêt pour Claude Design.
> Instruction à donner à Claude Design : 'Voici le design system en markdown — construis-le en respectant chaque composant et état défini.'
> Une fois Claude Design terminé, reviens avec le code produit → Mode B."

**Mise à jour CLAUDE.md** — upsert de la section `## Design — grandes lignes` :
- Section existante → remplacer intégralement
- Section absente → ajouter en fin de fichier

```markdown
## Design — grandes lignes
_→ Détails : `[projet].design.md`_

- Approche : [one-shot / two-step]
- Écrans V1 : [N] — [liste courte des écrans principaux]
- Composants clés : [liste courte]
- Librairie UI : [shadcn/ui / autre / à confirmer en Mode B]
```

---

## MODE B — Intégration du code Claude Design

### Étape 0 — Réception du code

Tu as besoin de :
1. **`[projet].design.md`** — pour vérifier la cohérence avec ce qui a été demandé
2. **Le code produit par Claude Design** — collé directement dans la conversation

Tu lis le code et identifies :
- Ce qu'il couvre (composants, couleurs, typo)
- Ce qu'il manque par rapport à `[projet].design.md`
- Le format du code (CSS pur, classes Tailwind, variables CSS, autre)

Tu signales les écarts avant de continuer.

---

### Étape 1 — Adaptation selon la plateforme

**Si web / PWA → Tailwind CSS**

Tu génères la configuration `tailwind.config.ts` avec les tokens extraits du code Claude Design :
- Couleurs → `theme.extend.colors`
- Typographie → `theme.extend.fontFamily` + `theme.extend.fontSize`
- Espacements → `theme.extend.spacing` si valeurs custom
- Border-radius → `theme.extend.borderRadius`
- Ombres → `theme.extend.boxShadow`
- Dark mode → `darkMode: 'class'` si applicable

Pour chaque composant shadcn/ui utilisé dans le design system : overrides CSS à appliquer dans `globals.css` ou via le système de variants shadcn.

**Si app native → NativeWind**

Le CSS de Claude Design n'est pas directement utilisable en React Native. Tu extrais les valeurs design et génères :
- La configuration `tailwind.config.js` pour NativeWind
- Les tokens de style (couleurs, typo, espacements) sous forme de constantes TypeScript dans `theme/tokens.ts`
- Pour chaque composant : la transcription des classes CSS en classes NativeWind équivalentes

Signaler tout ce qui n'a pas d'équivalent direct en NativeWind (certains effets CSS avancés, pseudo-éléments) et proposer une alternative React Native.

---

### Étape 2 — Extraction du routing

Tu analyses tous les éléments interactifs du code Claude Design (boutons, liens, icônes cliquables) et tu identifies leur intention de navigation.

**Trois catégories :**

- **Routing simple** — l'élément mène toujours au même endroit, sans condition (ex : "Voir mon profil" → `/profil`). Tu peux le câbler directement.
- **Routing conditionnel** — la destination dépend d'un résultat métier (ex : "Se connecter" → `/dashboard` si succès, message d'erreur si échec). Tu le notes — il sera implémenté pendant les sessions de code métier, depuis les specs.
- **Aucun routing** — l'élément déclenche une action sans navigation (ex : "Sauvegarder", "Supprimer"). Normal — pas de routing à définir.

**Si un élément interactif n'a ni routing identifiable ni action claire** → tu le signales à Medwin :
> "Le bouton '[label]' sur la page '[page]' n'a pas de destination ni d'action définie. Il s'agit d'un routing simple vers une page existante, d'un routing conditionnel, ou d'une action métier ?"

Tu produis un tableau récapitulatif avant de continuer :

```
| Élément | Page | Type | Destination / Action |
|---|---|---|---|
| Bouton "Se connecter" | Login | Conditionnel | Succès → /dashboard / Échec → message erreur |
| Lien "Profil" | Nav | Simple | → /profil |
| Bouton "Sauvegarder" | Formulaire | Action | Soumet le formulaire |
| Bouton "?" | Dashboard | ⚠️ Non défini | À préciser |
```

Tu présentes ce tableau à Medwin et attends sa validation avant de passer à l'étape suivante.

Une fois validé, tu mets à jour la section **Navigation & Routing** de `[projet].archi.md` avec ce tableau. C'est là qu'il sera disponible pendant les sessions de code — archi.md est dans le PRP, design.md ne l'est pas.

---

### Étape 3 — Test d'intégration

Avant de valider, vérifier :
- [ ] Les couleurs s'affichent correctement (nominal + dark mode si applicable)
- [ ] La typographie respecte la hiérarchie définie
- [ ] Les composants principaux s'affichent dans tous leurs états
- [ ] Les zones tactiles respectent les minimums (44pt iOS / 48dp Android) si app native
- [ ] Les safe areas sont respectées si app native

Si un élément ne passe pas → signaler et proposer une correction avant de valider.

---

### Étape 4 — Enregistrement Mode B

Tu mets à jour `[projet].design.md` en ajoutant une section Mode B :

```markdown
## Mode B — [date]

### Outil d'intégration
[Tailwind CSS / NativeWind]

### Configuration générée
[bloc tailwind.config.ts ou équivalent NativeWind]

### Écarts avec le design system
[Ce que Claude Design n'a pas couvert + comment c'est compensé]

### Points d'attention
[Éléments CSS sans équivalent direct → alternative choisie]
```

Confirmer : "Mode B terminé → `[projet].design.md` mis à jour. La config est prête. Tu peux démarrer le code métier."

**Mise à jour CLAUDE.md** — upsert de la section `## Identité visuelle` (enrichissement Mode B) :
- Section existante → remplacer intégralement en ajoutant les tokens Tailwind aux valeurs hex
- Section absente → créer (la charte aurait dû la créer — signaler si absente)

```markdown
## Identité visuelle
_→ Détails : `[projet].charte.md` · `[projet].design.md`_

- Principale : [hex] — classe : `[token Tailwind]`
- Secondaire : [hex] — classe : `[token Tailwind]`
- Typo : [police] — classe : `[token Tailwind]`
- Arrondis : [valeur]px — `[classe Tailwind]`
- Dark mode : `class` strategy — Librairie : [shadcn/ui v[version] / autre]
```

---

> **[RÉVISION 2026-05-15]**
>
> ### Étape 5 — Révision design in-browser
>
> Avant de passer à `/roadmap`, parcourir l'interface dans le navigateur avec Medwin.
>
> C'est le bon moment pour corriger — le code est encore propre, rien de métier n'est construit dessus. Les corrections à ce stade sont cosmétiques (padding, zones cliquables, espacements, états manquants) et sans risque de régression.
>
> **Grille de vérification :**
> - [ ] Tous les écrans sont navigables
> - [ ] Les zones cliquables ont une taille suffisante (min 44px hauteur sur mobile)
> - [ ] La hiérarchie visuelle est lisible (fond ≠ surface, titres distincts du corps)
> - [ ] Les états vides, erreur et chargement sont visibles
> - [ ] La cohérence visuelle est maintenue entre les écrans (mêmes couleurs, mêmes espacements)
>
> Corriger directement dans le code. Valider avec Medwin :
> > "L'interface est correcte visuellement — on peut commencer à coder la logique métier dessus ?"
>
> Si non → corriger et re-vérifier. Si oui → passer à `/roadmap`.

---

## Ton

Mode A : curieux et structuré. Tu creuses pour obtenir une vision complète avant de produire. Si une réponse est vague sur les états ou les parcours, tu relances.
Mode B : technique et direct. Tu extrais, tu traduis, tu signales les manques. Pas de questions ouvertes — tu travailles avec ce qu'on te donne.

---

## Prochaine étape

**Mode A** : retour à `/archi` — itérer jusqu'à cohérence design ↔ architecture.
**Mode B** : `/roadmap` — le code design est intégré, planifier les features.
