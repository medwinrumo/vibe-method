# teamtasks.design.md
> Test du workflow Claude Design — app fictive "TeamTasks"
> React + Tailwind CSS

---

## Charte graphique

**Couleurs**
- Primaire : `#1E3A5F` (bleu marine profond)
- Accent : `#3B82F6` (bleu vif — actions, liens, focus)
- Succès : `#10B981` (vert — tâche terminée)
- Danger : `#EF4444` (rouge — priorité haute)
- Attention : `#F59E0B` (orange — priorité normale)
- Fond : `#F8FAFC` (gris très clair)
- Surface : `#FFFFFF` (blanc — cards, modals)
- Texte principal : `#0F172A`
- Texte secondaire : `#64748B`
- Bordure : `#E2E8F0`

**Typographie**
- Titres : Inter Bold
- Corps : Inter Regular
- Petits labels : Inter Medium
- Taille base : 16px

**Ambiance**
Productive, épurée, professionnelle. Pas de gradients. Peu de décorations. La lisibilité prime. Inspiré de Linear et Notion.

---

## Écran 1 — Liste des tâches

**Composants présents :**
- Header avec titre du projet + icône de filtre (droite)
- 3 onglets de filtre : Toutes / En cours / Terminées
- Liste de TaskCards scrollable
- FAB (bouton flottant) en bas à droite pour créer une tâche

**TaskCard — états et variantes :**
- État normal : titre, badge priorité, avatar assigné, date d'échéance
- État terminé : titre barré, badge vert "Terminée", opacité réduite
- État en retard : date d'échéance en rouge
- Hover sur une card → affiche deux boutons d'action (supprimer en rouge, marquer terminée en vert)

**Comportements interactifs :**
- Tap sur une card → navigue vers Écran 2
- Tap sur FAB → ouvre Écran 3
- Tap sur onglet → filtre la liste avec animation de transition
- Pull-to-refresh → rechargement de la liste

**ASCII art — structure de la liste :**

```
┌─────────────────────────────┐
│ ← TeamTasks          🔽     │  ← Header (primaire #1E3A5F, texte blanc)
├─────────────────────────────┤
│ [Toutes] [En cours] [Faites]│  ← Onglets, onglet actif souligné accent
├─────────────────────────────┤
│ ┌─────────────────────────┐ │
│ │ 🔴 Refaire le brief     │ │  ← TaskCard
│ │    👤 Alice  📅 16 mai  │ │
│ └─────────────────────────┘ │
│ ┌─────────────────────────┐ │
│ │ 🟡 Préparer la démo     │ │
│ │    👤 Bob    📅 18 mai  │ │
│ └─────────────────────────┘ │
│ ┌─────────────────────────┐ │
│ │ ✅ Valider les maquettes │ │  ← Tâche terminée (opacité 50%, titre barré)
│ │    👤 Alice  📅 14 mai  │ │
│ └─────────────────────────┘ │
│                             │
│                        [+]  │  ← FAB accent #3B82F6
└─────────────────────────────┘
```

---

## Écran 2 — Détail d'une tâche

**Composants présents :**
- Header avec bouton retour + titre tronqué + bouton options (⋯)
- Section infos : statut, priorité, assigné, date d'échéance (layout 2 colonnes)
- Description (texte scrollable)
- Séparateur
- Section commentaires : liste de CommentBubbles
- Barre de saisie fixe en bas (input + bouton envoyer)

**CommentBubble — états :**
- Normal : avatar + nom + texte + heure
- Propre (utilisateur courant) : fond accent léger, aligné à droite

**Comportements interactifs :**
- Clic sur statut → dropdown de sélection (Backlog / En cours / Terminée)
- Clic sur assigné → dropdown de sélection d'un membre
- Clic sur date → input date HTML natif
- Barre de saisie commentaire fixe en bas de la zone de contenu

**ASCII art — structure du détail :**

```
┌─────────────────────────────┐
│ ←   Refaire le brief    ⋯  │  ← Header
├─────────────────────────────┤
│ Statut      │ Priorité      │
│ [En cours]  │ [🔴 Haute]    │  ← Badges cliquables
│ Assigné     │ Échéance      │
│ [👤 Alice]  │ [📅 16 mai]   │
├─────────────────────────────┤
│ Le brief actuel ne couvre   │
│ pas les cas mobiles...      │  ← Description
├─────────────────────────────┤
│ Commentaires (2)            │
│ ┌─────────────────────────┐ │
│ │ 👤 Bob · 14h30          │ │
│ │ J'ai commencé hier soir │ │
│ └─────────────────────────┘ │
│       ┌─────────────────────┤
│       │ 👤 Moi · 15h00    │ │  ← Commentaire propre, aligné droite
│       │ OK, je continue   │ │
│       └─────────────────────┤
├─────────────────────────────┤
│ [Ajouter un commentaire...] │  ← Barre fixe en bas
└─────────────────────────────┘
```

---

## Écran 3 — Formulaire de création

**Composants présents :**
- Header : "Nouvelle tâche" + bouton Annuler (gauche) + bouton Créer (droite, accent, désactivé si titre vide)
- Champ Titre (obligatoire, autofocus à l'ouverture)
- Champ Description (optionnel, multiline, max 3 lignes visibles)
- Sélecteur Assigné (ouvre un dropdown avec liste des membres)
- Sélecteur Échéance (input date HTML natif)
- Sélecteur Priorité : 3 boutons radio visuels (Haute / Normale / Basse)

**États du formulaire :**
- Titre vide → bouton Créer grisé, non cliquable
- Titre rempli → bouton Créer actif (bleu accent)
- Champ en focus → bordure accent #3B82F6
- Erreur (titre trop court) → bordure rouge + message sous le champ

**Comportements interactifs :**
- Autofocus sur le champ Titre à l'ouverture
- Clic Annuler → ferme la modal
- Clic Créer → spinner sur le bouton pendant la création, puis fermeture modal + ajout en tête de liste

**ASCII art — structure du formulaire :**

```
┌─────────────────────────────┐
│ Annuler  Nouvelle tâche  [Créer] │  ← Header, Créer désactivé si vide
├─────────────────────────────┤
│ Titre *                     │
│ ┌─────────────────────────┐ │
│ │ Ex : Préparer la démo   │ │  ← Autofocus, bordure accent si focus
│ └─────────────────────────┘ │
│ Description                 │
│ ┌─────────────────────────┐ │
│ │                         │ │  ← Multiline, placeholder gris
│ └─────────────────────────┘ │
│ Assigné                     │
│ [👤 Choisir un membre    >] │  ← Tap → bottom sheet
│ Échéance                    │
│ [📅 Choisir une date     >] │  ← Tap → date picker natif
│ Priorité                    │
│ [🔴 Haute][🟡 Normale][🟢 Basse] │  ← Radio buttons, Normale sélectionné par défaut
└─────────────────────────────┘
```

---

## Navigation entre écrans

| Depuis | Action | Vers |
|---|---|---|
| Écran 1 | Tap sur une TaskCard | Écran 2 |
| Écran 1 | Tap sur FAB [+] | Écran 3 (modal) |
| Écran 2 | Tap ← retour | Écran 1 |
| Écran 3 | Tap Annuler | Écran 1 (dismiss modal) |
| Écran 3 | Tap Créer (succès) | Écran 1 (dismiss modal + nouvelle tâche en tête de liste) |

---

## Ce que Claude Design doit produire

HTML/CSS/JS interactif pour les 3 écrans, en respectant :
- La charte graphique ci-dessus
- Les ASCII arts comme structure de référence (pas une contrainte rigide)
- Les états et variantes de chaque composant
- Les comportements interactifs (hover, focus, états désactivés)

Priorité : fidélité au style (couleurs, espacements, typographie) > fidélité aux comportements dynamiques.

> **Mode B cible : React + Tailwind CSS** — l'output HTML/CSS/JS sera traduit en composants React avec classes Tailwind.
