---
description: Clôture de session complète — GitHub + toutes les pages Notion du projet en cours
allowed-tools: Bash(git *), Bash(cat *), mcp__claude_ai_Notion__notion-search, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-update-page, mcp__claude_ai_Notion__notion-create-pages
---

Effectue la clôture complète de session pour le projet en cours.

## Étape 1 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant (ex : `minou` depuis `/Users/medwinrumo/dev/minou`).

## Étape 2 — GitHub

1. Vérifier que tout est commité (`git status`)
2. Si des modifications non commitées existent, demander confirmation avant de commiter
3. Pousser la branche courante (`git push`)

### Fichier `[projet].run.md`

Suivre les étapes de `/majrun` pour mettre à jour ce fichier et son miroir Notion.

### Fichier `CLAUDE.md`

Mettre à jour si la session a produit des décisions d'architecture, des changements d'implémentation, des corrections de spec, ou tout élément qui modifie la compréhension du projet. C'est une source de vérité — elle doit refléter la réalité du code, pas une version périmée.

Note : `[projet].run.md` et `CLAUDE.md` sont des fichiers Git. Ils sont commités et poussés comme tout autre fichier.

## Étape 3 — Notion

Ces pages vivent uniquement dans Notion, indépendamment de Git. Créer toute page manquante avant d'y écrire.

### Page `[projet].peda`

Journal d'apprentissage à vocation pédagogique. Rédigé avec une intention professorale — comme si on expliquait à Medwin ce qui s'est passé, pourquoi les choses ont été faites ainsi, ce qu'il faut avoir compris. Les difficultés, erreurs et doutes méritent autant d'attention que les succès.

Structure obligatoire :
```
▶ Jour N — [date] — [objectif de la session]
    ▶ Session N — [résumé en une phrase]
        - Ce qu'on a fait et pourquoi (contexte, intention, décision)
        - Comment (outils, commandes, méthodes utilisées)
        - Difficultés rencontrées et comment elles ont été résolues
        - Points qui méritent compréhension ou recul
```
Règle absolue : chaque session dans son propre menu dépliant. Jamais dans le menu d'une session précédente.

### Page `[projet].log`

Journal de bord factuel et daté. Entrées courtes, sans explication technique. Même structure de menus imbriqués par jour et par session.

Calibrage :
- Bonne entrée : `Implémenté streaming SSE sur POST /api/chat`
- Trop vague : `Travaillé sur le chat`
- Trop technique : `Modifié le handler EventSource pour corriger le flush des chunks en cas de timeout réseau`

### Page `[projet].spec`

Mettre à jour si la session a produit une décision de spec : nouvelle fonctionnalité spécifiée, décision d'architecture, contrainte levée ou ajoutée, fonctionnalité abandonnée. Ne pas toucher sinon.

Frontière : `.spec` = ce qui est décidé. `.doc/Développeur` = ce qui est implémenté.

### Page `[projet].doc`

Mettre à jour si la session a produit quelque chose qui change ce qu'un lecteur peut comprendre ou faire. Trois sous-pages cibles :
- 👤 Utilisateur : comportement visible, fonctionnalité nouvelle ou modifiée
- 🛠️ Développeur : architecture implémentée, route API, variable `.env`, convention
- ⚙️ Exploitation : déploiement, dépendance système, configuration serveur

Créer la sous-page si elle n'existe pas.

## Étape 4 — Cohérence skills / doctrine (si projet vibe-method ou si un skill a été modifié)

Si la session a modifié un skill ou un fichier de doctrine (`produit.md`, `methode.md`, `architecture.md`, `securite.md`) :

| Doctrine modifiée | Skill(s) à vérifier |
|---|---|
| `produit.md` | `/brief` `/prd` `/prd-update` `/specs` |
| `architecture.md` | `/archi` |
| `securite.md` | `/securite` |
| `methode.md` | `/roadmap` `/tests` `/recette` |

Pour chaque paire concernée :
1. Lire la doctrine modifiée
2. Lire le skill correspondant
3. Identifier les divergences
4. Proposer la mise à jour à Medwin — ne jamais modifier sans validation explicite

## Checklist finale

- [ ] Tout commité et poussé sur GitHub
- [ ] `CLAUDE.md` mis à jour si nécessaire
- [ ] Cohérence skills / doctrine vérifiée si applicable
- [ ] `[projet].peda` complétée dans Notion
- [ ] `[projet].log` complétée dans Notion
- [ ] `[projet].spec` mise à jour si nécessaire
- [ ] `[projet].doc` mise à jour si nécessaire
