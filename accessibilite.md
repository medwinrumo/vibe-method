# accessibilite.md

Doctrine WCAG 2.1 AA — quoi vérifier, et quand. Comparaison `addyosmani/agent-skills` vs vibe-method (2026-07-28, P2 de la roadmap). À enrichir au fil des projets.

---

## Principe fondamental

L'accessibilité n'est pas une passe de polish en fin de projet — elle se vérifie en même temps que le design (`/design`) et la revue de code (`/code-review`), pas ajoutée après coup sur une interface déjà figée.

**Portée** : obligatoire pour toute interface destinée à de vrais utilisateurs. Pas de cérémonie sur un prototype (`/prototype`) — même filtre de portée que l'observabilité et le TDD.

---

## Les 5 catégories

### 1. Clavier
- Tous les éléments interactifs atteignables au Tab
- Ordre de focus qui suit l'ordre visuel/logique
- Focus visible (contour/anneau sur l'élément actif)
- Widgets custom au clavier (Entrée pour activer, Échap pour fermer)
- Pas de piège au clavier (on peut toujours sortir d'un composant au Tab)
- Lien "aller au contenu" en tout début de page

### 2. Lecteurs d'écran
- Texte alternatif sur les images
- Labels sur tous les champs
- Texte de lien/bouton descriptif (pas "cliquez ici")
- Un seul `<h1>` par page
- Annonces dynamiques via `aria-live` pour le contenu qui change sans rechargement

**Table de référence ARIA live :**

| Rôle/attribut | Usage |
|---|---|
| `aria-live="polite"` | Mise à jour de statut, non urgente |
| `aria-live="assertive"` | Erreur, urgente |
| `role="status"` | Équivalent implicite de `polite` |
| `role="alert"` | Équivalent implicite de `assertive` |

### 3. Visuel
- Contraste 4.5:1 (texte normal) / 3:1 (texte large)
- La couleur n'est jamais le seul indicateur (ex : erreur signalée par couleur ET icône/texte)
- Interface utilisable à 200% de zoom

### 4. Formulaires
- Labels visibles (pas juste un placeholder)
- Champs obligatoires indiqués explicitement
- Erreurs spécifiques, liées au champ concerné (pas un message générique en haut de page)
- `autocomplete` renseigné sur les champs standards (email, nom, adresse)

### 5. Contenu
- `lang` déclaré sur le document
- Titre de page pertinent
- Cibles tactiles ≥ 44×44px
- États vides avec un message qui a du sens

---

## Où ça s'accroche dans le workflow

| Phase | Ce qui se passe |
|---|---|
| `/design` (Étape 2, Mode A) | Vérifier contraste et navigation clavier dès la conception du design system |
| `/specs` (nouvelle étape) | Pour toute feature avec interface utilisateur : vérification accessibilité explicite dans la spec |
| `/code-review` (Revue structurelle) | Accessibilité comme dimension de revue, au même titre que sécurité/performance |

**Règle de chaînage** : `/specs` et `/code-review` portent la vérification — Medwin n'a pas besoin de se souvenir d'invoquer cette doctrine lui-même.

---

## Règles non-négociables

- Contraste et navigation clavier vérifiés dès `/design`, pas en fin de projet
- Toute image porte un texte alternatif ou est explicitement marquée décorative
- Doctrine neuve (2026-07-28) — friction à loguer dans `task-observer`, revue en `/maj`

## Liens
[[doctrines/design]] si migré au wiki — voir `design.md`, `.claude/commands/specs.md`, `.claude/commands/code-review.md`
