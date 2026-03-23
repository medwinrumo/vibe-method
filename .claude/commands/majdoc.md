---
description: Met à jour la documentation structurée [projet].doc dans Notion — sous-pages Utilisateur, Développeur, Exploitation
allowed-tools: mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Met à jour la page `[projet].doc` dans Notion et ses sous-pages de documentation structurée.

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Structure cible de [projet].doc

La page `[projet].doc` est une page parent contenant trois sous-pages fixes :

| Sous-page | Audience | Contenu typique |
|---|---|---|
| 👤 Utilisateur | Utilisateur final non-technique | Fonctionnalités disponibles, guides d'utilisation, comportements attendus, limitations connues |
| 🛠️ Développeur | Toi / Claude Code / futur contributeur | Architecture, décisions techniques, variables d'environnement, routes API, schémas de données, conventions |
| ⚙️ Exploitation | Opérateur / installateur | Prérequis système, installation, déploiement, configuration serveur, maintenance |

Si une sous-page n'existe pas encore, la créer avant de la mettre à jour.

## Processus de mise à jour

### 1. Lire avant d'écrire

Fetch l'état actuel de chaque sous-page potentiellement concernée. Ne jamais modifier sans avoir lu l'existant — pas d'écrasement, pas de duplication.

### 2. Poser la bonne question

> **Ce qui a été produit pendant la session change-t-il ce qu'un lecteur de cette sous-page peut comprendre ou faire ?**

Si la réponse est non, ne pas toucher.

### 3. Cibler la bonne sous-page

- Comportement visible, fonctionnalité nouvelle ou modifiée → **👤 Utilisateur**
- Décision d'architecture, nouveau paramètre `.env`, route API, schéma de données, convention → **🛠️ Développeur**
- Procédure de déploiement, dépendance système, variable serveur → **⚙️ Exploitation**

Un même changement peut justifier une mise à jour dans plusieurs sous-pages.

### 4. Modifier sans dégrader

- Mettre à jour les sections existantes plutôt qu'en empiler de nouvelles
- Réorganiser si la structure actuelle ne correspond plus au contenu réel
- Ne pas recopier ce qui est dans `.log` — le `.doc` n'est pas un journal, c'est un état stable

## Feedback

Ne rien signaler pour les modifications mineures (reformulation, ajout d'un paramètre, correction).

Signaler uniquement si la modification est majeure : nouvelle fonctionnalité documentée, restructuration d'une sous-page, création d'une nouvelle sous-page.

Format : `📄 .doc mis à jour — [nom sous-page] : [description en une ligne]`
