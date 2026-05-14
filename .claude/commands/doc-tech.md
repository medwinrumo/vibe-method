# /doc-tech — Documentation technique

Tu génères et maintiens la documentation technique du projet : vue d'ensemble développeur (`[projet].doc-tech.md`) et annotations dans le code (JSDoc/TSDoc).

Deux modes disponibles dans un seul skill.

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — Sélection du mode

> "Quel mode ?
> (A) `[projet].doc-tech.md` — vue d'ensemble développeur (fin de phase)
> (B) Annotations JSDoc/TSDoc dans le code (après `/tests`, avant `/recette`)
> (A+B) Les deux"

---

## Mode A — [projet].doc-tech.md

**Quand le lancer :** fin de phase, avant release — une fois que toutes les features de la phase sont validées par `/recette`.

### Étape A1 — Lecture du code et des documents existants

Tu lis :
- `[projet].archi.md` — modules, responsabilités, décisions
- `[projet].adr.md` — décisions architecturales (si existant)
- La structure de dossiers et les fichiers source principaux
- `[projet].doc-tech.md` si existant — pour mise à jour incrémentale, pas écrasement

### Étape A2 — Proposition du draft

Tu construis un draft depuis ce que tu as lu. Tu ne poses des questions que pour ce que tu n'as pas pu déduire.

Tu présentes section par section :
> "Voici ce que j'ai trouvé pour [section]. Est-ce complet ? Manque-t-il quelque chose ?"

**Structure du fichier produit :**

```markdown
# Documentation technique — [Nom du projet]
_[date]_

## Vue d'ensemble technique
[2-3 phrases : rôle de l'app côté code, choix techniques structurants]

## Architecture — modules
| Module | Responsabilité | Fichiers principaux |
|---|---|---|

## Installation locale (environnement dev)
1. Prérequis
2. Clone + install des dépendances
3. Configuration .env
4. Lancement

## Variables d'environnement
| Variable | Rôle | Requis | Valeur exemple |
|---|---|---|---|

## Conventions
- Naming : [règles de nommage]
- Patterns : [patterns utilisés]
- Règles de style : [formatage, linter, config]

## Routes / API
[Liste des endpoints si applicable — méthode, path, rôle, authentification requise]

## Schémas de données
[Modèles principaux — nom, champs clés, relations, contraintes]

## Points d'attention maintenance
- [Ce qui peut casser et pourquoi]
- [Dépendances critiques ou fragiles]
- [Ce à ne pas modifier sans comprendre l'ensemble]

## Décisions architecturales
→ Voir `[projet].adr.md` pour le détail des décisions structurantes.
```

### Étape A3 — Génération du fichier

Tu génères `[projet].doc-tech.md` dans le repo du projet.

Si le fichier existe déjà → mise à jour incrémentale : tu ajoutes les sections manquantes et mets à jour les sections qui ont changé. Tu ne proposes pas une réécriture totale sans confirmation.

---

## Mode B — Annotations JSDoc/TSDoc dans le code

**Quand le lancer :** après `/tests`, avant `/recette` — le code est stable, les annotations se font pendant que la logique est encore fraîche.

### Étape B1 — Identification des éléments à annoter

Tu parcours les fichiers source et identifies ce qui mérite une annotation.

**À annoter :**
- Fonctions non triviales : logique complexe, algorithme, règle métier
- Fonctions avec effets de bord : appels API, écriture en base, mutations d'état global
- Modules : description du rôle du fichier en en-tête
- Types et interfaces custom : champs non-évidents, contraintes implicites

**À ne PAS annoter :**
- Getters/setters triviaux
- Fonctions auto-documentées par leur nom (`getUserById`, `formatDate`, `isLoggedIn`)
- Code généré automatiquement
- Composants UI purement visuels sans logique propre

Si une annotation semble nécessaire parce que le code est obscur → signaler plutôt que d'annoter :
> "Cette fonction est difficile à décrire sans paraphraser le code. Elle mériterait peut-être d'être refactorisée pour être plus lisible. Je la documente quand même ?"

### Étape B2 — Proposition des annotations

Tu présentes les annotations proposées, fichier par fichier, avant d'écrire quoi que ce soit :

> "Dans `[fichier]`, voici ce que je propose :
> - `[fonction]` : [description + @param + @returns]
> - `[module]` : [description du rôle]
> Tu valides ?"

**Format TSDoc (projets TypeScript) :**

```typescript
/**
 * [Description — le POURQUOI et le comportement non-évident, pas une paraphrase du code]
 *
 * @param userId - [description du paramètre]
 * @returns [description du retour]
 * @throws [condition qui déclenche une erreur]
 *
 * @example
 * // [exemple si l'usage n'est pas évident]
 */
```

**Format JSDoc (projets JavaScript) :**

```javascript
/**
 * [Description]
 *
 * @param {string} userId - [description]
 * @returns {Promise<User>} [description]
 * @throws {Error} [condition]
 */
```

### Étape B3 — Écriture dans les fichiers

Après validation → tu modifies les fichiers source pour insérer les annotations.

Tu confirmes : "Annotations ajoutées dans [liste des fichiers modifiés]."

---

## Règles

- Toujours lire avant d'écrire — pas d'écrasement sans lecture préalable
- `[projet].doc-tech.md` est un fichier vivant — mise à jour incrémentale à chaque phase
- Jamais de synchronisation Notion — fichier local uniquement
- Ce skill ne produit pas de documentation utilisateur — pour ça : `/doc`

---

## Prochaine étape

**Mode B** (après `/tests`) : `/recette` — les annotations sont en place, valider manuellement la feature.
**Mode A** (fin de phase) : merge dans `main` — le doc développeur est prêt.
