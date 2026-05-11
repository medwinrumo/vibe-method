# Claude Design + frontend-design — Documentation de référence
_Recherche effectuée le 2026-05-11_

---

## 1. Claude Design

### Ce que c'est

Produit officiel **Anthropic Labs** (branche expérimentale d'Anthropic), lancé le 17 avril 2026. Ce n'est pas un mode Claude, ce ne sont pas les Artifacts, ce n'est pas un skill Claude Code. C'est un **espace de travail visuel distinct**, accessible depuis claude.ai, avec un canvas dédié séparé de l'interface chat.

Moteur : **Claude Opus 4.7**
Statut : **research preview** (pas de date de disponibilité générale)
Accès : **Pro, Max, Team, Enterprise uniquement**

### Comment ça fonctionne

Interface combinant un chat et un canvas de design. Workflow :

1. Input fourni (voir section suivante)
2. Claude génère une première version sur le canvas
3. Raffinement par conversation, commentaires inline, éditions directes
4. Export ou handoff direct vers Claude Code

**Design system :** pendant l'onboarding, Claude lit le codebase ou un fichier `DESIGN.md` et extrait les tokens (couleurs, typographie, composants). Ces tokens sont appliqués à tous les projets suivants.

### Inputs supportés

| Type | Format |
|---|---|
| Prompt texte | Description naturelle |
| Fichier Markdown | `DESIGN.md`, `brand-guidelines.md` — format de facto pour un design system |
| Images | Upload direct |
| Documents | DOCX, PPTX, XLSX |
| Codebase | Lier un dépôt (éviter les monorepos volumineux — lier un sous-répertoire) |
| Web capture | Outil intégré pour capturer des éléments d'un site existant |

**Le fichier `[projet].design.md` produit par `/design` Mode A est exactement le format attendu par Claude Design.** L'instruction à donner : "Voici le design system en markdown — construis-le en respectant chaque composant et état défini."

### Outputs produits

- Prototypes interactifs HTML/CSS/JS (rendu live sur canvas)
- Décks de slides
- One-pagers / marketing assets
- Maquettes UI — composants, écrans, états

Formats d'export : URL interne, PDF, PPTX, HTML standalone, Canva, **handoff bundle vers Claude Code**.

**Le code produit est du HTML/CSS/JS — pas du React ni du Tailwind nativement.** C'est pourquoi `/design` Mode B existe : pour traduire ce code en Tailwind (web) ou NativeWind (native).

### Limites documentées

- **Research preview** : produit non stabilisé, rough edges
- **Commentaires inline** : peuvent disparaître avant que Claude les lise → coller le texte dans le chat directement
- **Compact layout mode** : peut provoquer des erreurs de sauvegarde → passer en full view
- **Grands repos** : monorepo volumineux = lag ou crash navigateur → lier un sous-répertoire
- **Collaboration** : basique, pas multiplayer
- **Modèle** : uniquement Opus 4.7, pas de choix
- **Accès** : plan gratuit exclu

### Best practices

- Préparer `[projet].design.md` complet avant d'ouvrir Claude Design : couleurs (hex), typographie, espacements, composants avec états, ambiance. Plus le fichier est précis, moins Claude improvise.
- Pour les prototypes à partir d'un site existant : utiliser le web capture tool plutôt que de décrire textuellement.
- Pour la cohérence de marque : demander à Claude d'analyser les assets existants (logos, screenshots, PDF de marque) pour générer le design system.

### Sources

- [Introducing Claude Design — Anthropic Labs](https://www.anthropic.com/news/claude-design-anthropic-labs)
- [Get started with Claude Design — Claude Help Center](https://support.claude.com/en/articles/14604416-get-started-with-claude-design)
- [TechCrunch — Claude Design launch](https://techcrunch.com/2026/04/17/anthropic-launches-claude-design-a-new-product-for-creating-quick-visuals/)
- [DESIGN.md format avec Claude Design](https://www.branding5.com/claude-design-anthropic-labs-brand-guidelines)

---

## 2. frontend-design (plugin Claude Code)

### Ce que c'est

Plugin **officiel Anthropic** pour Claude Code, distribué dans `anthropics/claude-code`. Ce n'est pas un skill built-in natif — il doit être installé. 277 000+ installations (mars 2026).

**Ce n'est pas la même chose que Claude Design.** Rôles distincts dans le workflow.

### Installation et invocation

```bash
# Installation
claude plugins add frontend-design@claude-code-plugins

# Invocation explicite
/frontend-design [description de l'interface]
```

Invocation automatique quand on demande à Claude Code de construire une interface frontend.

### Ce que ça fait

Injecte un **cadre de conception** dans Claude Code avant la génération de code. Force Claude à :

1. Définir un objectif (quel problème résout cette interface ?)
2. Choisir une direction esthétique précise parmi : brutalisme minimaliste, maximalisme, rétro-futuriste, organique, luxe, ludique, éditorial, art déco, doux/pastel, industriel
3. Identifier les contraintes techniques
4. Définir la différenciation mémorable

Règles concrètes appliquées par le skill :
- **Typographie** : éviter Inter, Roboto, Arial — choisir des polices distinctives
- **Couleur** : variables CSS, dominant colors + accents tranchants
- **Motion** : animations CSS-only pour HTML, Motion library pour React
- **Composition** : asymétrie, chevauchements, éléments qui cassent la grille
- **Backgrounds** : gradient meshes, textures de bruit, ombres dramatiques

Ce qu'il interdit : dégradés violet sur fond blanc, polices système génériques, layouts prévisibles.

### Outputs

Code fonctionnel HTML/CSS/JS ou React/Vue, visuellement distinctif, production-grade.

### Limites

- **Ne lit pas `[projet].design.md`** — choisit sa propre direction esthétique
- Ne génère pas d'images ni d'assets visuels — code uniquement
- Pas de canvas visuel — tout passe par le code
- La direction esthétique est choisie par Claude, pas nécessairement alignée avec la charte projet

**Point de friction avec la vibe-method :** pour éviter une incohérence avec la charte graphique, passer les tokens clés (couleurs hex, polices, border-radius) dans le prompt avant invocation, ou donner `[projet].design.md` en contexte.

### Sources

- [SKILL.md frontend-design — GitHub anthropics/claude-code](https://github.com/anthropics/claude-code/blob/main/plugins/frontend-design/skills/frontend-design/SKILL.md)
- [Page plugin officielle](https://claude.com/plugins/frontend-design)

---

## 3. Comparatif

| Dimension | Claude Design | frontend-design |
|---|---|---|
| Nature | Produit Anthropic Labs (espace de travail visuel) | Plugin officiel Anthropic pour Claude Code |
| Interface | Canvas visuel + chat sur claude.ai | Dans Claude Code, terminal |
| Accès | Pro/Max/Team/Enterprise | Tout utilisateur Claude Code (installation requise) |
| Input | Prompt, Markdown, images, docs, codebase, web capture | Prompt texte |
| Output | HTML/CSS/JS interactif, PDF, PPTX, handoff bundle | Code HTML/CSS/JS ou React/Vue |
| Design system | Lit et applique `[projet].design.md` | Choisit sa propre direction esthétique |
| Prototype visuel | Oui — rendu live sur canvas | Non — code seulement |
| Statut | Research preview (avril 2026) | Disponible (277k+ installations) |
| Modèle | Opus 4.7 obligatoire | Hérite du modèle Claude Code en cours |
| Cas d'usage vibe-method | Prototypage UI depuis `[projet].design.md` | Élever la qualité du code frontend en phase de code métier |

---

## 4. Positionnement dans la vibe-method

```
/charte → /design Mode A → Claude Design → /design Mode B → [code] → frontend-design
```

- **Claude Design** reçoit `[projet].design.md` et génère les prototypes HTML/CSS/JS
- **`/design` Mode B** traduit ce code en Tailwind (web) ou NativeWind (native)
- **`frontend-design`** intervient pendant la phase de code métier pour élever la qualité esthétique du code produit par Claude Code — **après** Mode B, pas avant

Les deux outils ne sont pas interchangeables. Claude Design = prototypage. frontend-design = qualité du code frontend en développement.

---

## 5. Points non documentés ou incertains

- **Longueur maximale de `[projet].design.md`** : aucune limite officielle. Opus 4.7 = 200k tokens — un design.md de projet ne devrait pas approcher cette limite.
- **Qualité du code Claude Design** : HTML/CSS/JS de bonne qualité mais "pas du code React production" — code de prototype, Mode B reste nécessaire.
- **Contenu exact du handoff bundle** vers Claude Code : non détaillé dans la documentation officielle.
- **Tarification** : inclus dans Pro/Max/Team/Enterprise ou token-based — non précisé.
- **Date de disponibilité générale** : aucune date annoncée.
