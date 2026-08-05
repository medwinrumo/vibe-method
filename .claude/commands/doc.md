---
description: Met à jour la documentation utilisateur et d'exploitation du projet
---

# /doc — Documentation structurée

Met à jour le fichier `[projet].doc.md` pour le projet en cours.

**Note :** la documentation destinée aux développeurs (architecture, JSDoc, .env, conventions, maintenance) est dans `[projet].doc-tech.md` — généré par `/doc-tech`. Ce skill ne couvre pas ce périmètre.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Structure cible de [projet].doc.md

Le fichier contient deux sections fixes :

| Section | Audience | Contenu typique |
|---|---|---|
| `## Utilisateur` | Utilisateur final non-technique | Vue d'ensemble, puis par feature : ce qu'elle fait, comment l'utiliser |
| `## Exploitation` | Opérateur / installateur | Prérequis système, installation, déploiement, configuration serveur, maintenance |

Si le fichier n'existe pas → le créer avec l'en-tête `# [projet].doc — Documentation` et les deux sections vides.

## Processus de mise à jour

### 1. Lire avant d'écrire

Lire l'état actuel de `[projet].doc.md`. Ne jamais modifier sans avoir lu l'existant — pas d'écrasement, pas de duplication.

### 2. Poser la bonne question

> **Ce qui a été produit pendant la session change-t-il ce qu'un lecteur de cette section peut comprendre ou faire ?**

Si la réponse est non, ne pas toucher.

### 3. Cibler la bonne section

- Comportement visible, fonctionnalité nouvelle ou modifiée, guide d'utilisation → **`## Utilisateur`**
- Procédure de déploiement, dépendance système, variable serveur → **`## Exploitation`**
- Décision d'architecture, `.env`, route API, schéma de données, convention → **`/doc-tech`**, pas ce skill

Un même changement peut justifier une mise à jour dans les deux sections.

### 4. Modifier sans dégrader

- Mettre à jour les sections existantes plutôt qu'en empiler de nouvelles
- Réorganiser si la structure actuelle ne correspond plus au contenu réel
- Ne pas recopier ce qui est dans `.log` — le `.doc` n'est pas un journal, c'est un état stable

## Feedback

Ne rien signaler pour les modifications mineures (reformulation, ajout d'un paramètre, correction).

Signaler uniquement si la modification est majeure : nouvelle fonctionnalité documentée, restructuration d'une section, création du fichier.

Format : `.doc mis à jour — [section] : [description en une ligne]`
