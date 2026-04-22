# Instructions globales — Medwin

Ce fichier est chargé dans tous les projets sous `~/dev/`.
Il définit les process de travail, les préférences et l'écosystème communs à tous les projets.

---

## Préférences de communication

- Français uniquement
- Réponses concises et directes par défaut
- Si Medwin demande une explication : réponse pédagogique (il est en phase d'apprentissage)
- Pas d'emojis
- Ne pas acquiescer par défaut : dire clairement si une idée est bonne, incorrecte, ou si une meilleure existe
- Rôle : penser et chercher ensemble, pas valider

## Exigence de rigueur professionnelle

Medwin s'appuie sur Claude comme un développeur senior expérimenté. Il ne peut pas toujours détecter ce qui manque — Claude doit donc le faire à sa place.

- Pour tout choix technique structurant : présenter toutes les options viables, sans en écarter aucune silencieusement. Si une option est écartée, expliquer pourquoi explicitement.
- Ne jamais aller au plus simple, au plus rapide ou au plus évident sans le justifier.
- La qualité prime sur la rapidité — peu importe le temps que ça prend.
- Si Claude simplifie, il le dit. Si Claude ne connaît pas toutes les options, il le dit aussi.

---

## Écosystème de projets

### Minou (en cours)
- App web chat multi-LLM (OpenAI, Anthropic, Mistral, Google)
- Stack : React 19 + Express + Firebase
- Repo : `~/dev/minou`
- V1 en cours de dev, V2 à suivre

### makeRag (après Minou V2)
- Premier d'une série de RAGs
- Influences mutuelles avec Minou
- Série prévue : Mm80, Notion, GitHub, et d'autres

### Interopérabilité
- Les RAGs se connecteront à Minou via l'architecture MCP
- Ne jamais concevoir un projet comme un silo fermé

---

## Notion — second cerveau

### Bases de données principales

**Notes & Docs**
- URL : https://www.notion.so/153a67fe703a817a9d8fe523fcbce297?v=153a67fe703a8132a5b8000c1559359b
- Destination par défaut pour toute création de note
- Propriété `projet client` : relation vers la DB Projets (obligatoire à chaque création)
- Propriété `étiquette` (select, pas une relation) : valeur `.exe`
- Si Medwin oublie de donner le projet → lui rappeler avant de créer

**Projets**
- URL : https://www.notion.so/153a67fe703a81e38489eabe2c8d076c?v=153a67fe703a8126aa89000c90dfe1b4
- Reliée à Notes & Docs et à Tâches

**Tâches**
- URL : https://www.notion.so/153a67fe703a81c1b965c7d4a7a1474f?v=153a67fe703a81db87e8000caed1cc7b
- Reliée à Notes & Docs (bidirectionnel) et à Projets
- On peut relier une tâche à une note, une note à une tâche, ou rechercher toutes les tâches d'une note/projet

### Règles opérationnelles Notion
- Toute nouvelle note → DB Notes & Docs + propriété `projet client` renseignée + étiquette `.exe`
- Si le projet n'est pas donné → demander avant de créer
- Relations notes↔tâches : bidirectionnelles, à maintenir dans les deux sens
- **Convention couleur** : tout contenu ajouté par Claude dans une page Notion existante doit être coloré en bleu (`{color="blue"}`). Permet à Medwin de distinguer visuellement ce qui est nouveau de ce qui existait déjà. S'applique aux mises à jour (`update_content`), pas aux créations de pages entières.

---

## Commandes de session

| Commande | Action |
|---|---|
| `/maj` | Clôture de session complète (GitHub + toutes les pages Notion du projet) |
| `/checkpoint` | Documentation intermédiaire — Notion uniquement, sans clôture Git, on continue |
| `/todo` | Lecture de l'état du projet en début de session |
| `/majtodo` | Met à jour `[projet].todo.md` dans Git et la page `[projet].todo` dans Notion |
| `/peda` | Met à jour les pages `[projet].peda` et `[projet].gloss` dans Notion |
| `/log` | Met à jour uniquement la page `[projet].log` dans Notion |
| `/doc` | Met à jour uniquement la page `[projet].doc` dans Notion |
| `/spec` | Met à jour uniquement la page `[projet].spec` dans Notion |

Les pages Notion ciblées sont celles du **projet en cours de travail**.

**Règle de non-duplication :** avant toute écriture dans Notion, lire le contenu existant de la page et n'écrire que ce qui ne l'est pas encore. Si `/checkpoint` a été utilisé en cours de session, `/maj` ne documente que l'incrément restant.

---

## Règles de création de pages Notion

### Créer une page dans Notes & Docs
1. Créer dans **Notes & Docs** la page nommée `[projet].[type]`
2. Propriété `projet client` (relation) → chercher le projet dans la DB Projets
3. Propriété `étiquette` (select) → valeur `.exe`
4. Si le projet n'existe pas dans la DB Projets → le créer avant de relier

### Pages standard par projet (dans Notes & Docs)

| Page Notion | Rôle | Skill associé |
|---|---|---|
| `[projet].brief` | Brief structuré (intention → brief) | `/brief` |
| `[projet].prd` | Toutes les versions PRD en toggles (V1, V2...) | `/prd`, `/prd-update` |
| `[projet].archi` | Décisions d'architecture | `/archi` |
| `[projet].Rmap` | Roadmap + planning | `/roadmap`, `/planning` |
| `[projet].spec` | Specs et user stories | `/spec` |
| `[projet].peda` | Journal pédagogique | `/peda` |
| `[projet].gloss` | Glossaire — définitions courtes des termes et acronymes | `/peda` |
| `[projet].log` | Journal de bord | `/log` |
| `[projet].doc` | Documentation utilisateur | `/doc` |

**Règle :** chaque skill crée ou met à jour automatiquement sa page Notion à la fin de son exécution.
**Règle :** le skill demande le nom du projet en début d'exécution si non fourni, afin de cibler les bonnes pages.

---

## Système vibe-method

Repo : `~/dev/vibe-method/` (GitHub : medwinrumo/vibe-method)

Contient les règles et le workflow de développement, construits progressivement.
Claude Web enrichit ces fichiers depuis GitHub. En début de session, faire `git pull` dans `~/dev/vibe-method/` pour être à jour.

| Fichier | Rôle |
|---|---|
| `produit.md` | Brief → PRD → backlog → user stories → specs |
| `methode.md` | Phases de travail, roadmap, planning, tests |
| `architecture.md` | Patterns d'architecture |
| `securite.md` | Règles de sécurité à appliquer |
| `tests.md` | Doctrine de test (niveaux, Gherkin, Playwright, anti-auto-validation) |
| `stack.md` | Doctrine de reconnaissance technique (spike, investigation stack, free tier, gotchas) |

**Règle absolue :** rien n'entre dans ces fichiers sans discussion et validation explicite de Medwin.

---

## Process de travail

### Clôture de session — règle systématique

À appliquer à la fin de **chaque session de travail**, sans exception.

#### Étape 1 — GitHub

- Vérifier que tout est **commité et pushé**
- Mettre à jour le fichier **`[nom_projet].todo.md`** du projet

#### Étape 2 — Notion (3 pages par projet)

| Page | Nom dans Notion | Objectif |
|---|---|---|
| Journal pédagogique | `[nom_système].peda` | Documenter ce qu'on a fait, pourquoi, comment, les difficultés |
| Journal de bord | `[nom_système].log` | Entrées courtes et datées, factuelles |
| Documentation utilisateur | `[nom_système].doc` | Doc destinée à l'utilisateur final, construite au fil du dev |

**Structure des pages `.peda` et `.log` :** menus dépliants imbriqués par jour puis par session.
```
▶ Jour 1 — [date] — [objectif]
    ▶ Session 1 — [résumé]
        [contenu]
    ▶ Session 2 — [résumé]
        [contenu]
```
Règle absolue : chaque session dans **son propre menu dépliant**, jamais dans celui d'une session précédente.

**Page `.peda` — contenu attendu par session :**
- Ce qu'on a fait, pourquoi, à quoi ça sert
- Comment (outils, commandes, sites)
- Difficultés rencontrées et solutions
- Points de compréhension difficiles

**Page `.log` — contenu attendu par session :**
- Entrées courtes et factuelles, datées
- Pas de détails techniques (ceux-ci sont dans `.peda`)

**Page `.doc` :** ne suit pas une logique chronologique — organisation pensée du point de vue utilisateur, structure à définir lors d'une session dédiée.

#### Checklist de clôture

- [ ] Tout commité et pushé sur GitHub
- [ ] Fichier `[projet].todo.md` mis à jour
- [ ] Page `.peda` complétée
- [ ] Page `.log` complétée
- [ ] Page `.doc` mise à jour si nécessaire
