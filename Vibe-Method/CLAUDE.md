# CLAUDE.md — Schéma du wiki vibe-method

Ce vault Obsidian est le wiki de navigation de la vibe-method.
Il est la vue dérivée et navigable du repo source (`~/dev/vibe-method/`).

---

## Ce que je suis

Un wiki LLM : collection de pages markdown structurées, maintenues par Claude, lues dans Obsidian.

**Je ne suis PAS la source de vérité.** Les fichiers sources (`~/dev/vibe-method/`) restent canoniques. Les pages wiki sont des synthèses navigables — elles ne se modifient jamais directement sans que la source ait changé.

---

## Sources

| Catégorie | Localisation source |
|---|---|
| Doctrines | `~/dev/vibe-method/methode.md`, `architecture.md`, `securite.md`, `tests.md`, `design.md`, `stack.md`, `refacto.md`, `produit.md` |
| Skills | `~/dev/vibe-method/.claude/commands/*.md` (un fichier par skill) |
| Méthode | `~/dev/vibe-method/CLAUDE.md`, `CLAUDE.global.md` |

---

## Structure du wiki

```
Vibe-Method/
├── CLAUDE.md              ← ce fichier (schéma)
├── index.md               ← catalogue de toutes les pages
├── log.md                 ← journal des opérations wiki
├── _vue-ensemble.md       ← synthèse globale de la méthode
├── flux/
│   └── chaine-complete.md ← la chaîne de skills avec liens
├── doctrines/             ← une page par fichier doctrine source
└── skills/                ← une page par skill
```

---

## Frontmatter — format obligatoire

```yaml
---
type: skill | doctrine | concept | flux | infrastructure
source: [chemin relatif vers le fichier source]
source_modified: YYYY-MM-DD
wiki_updated: YYYY-MM-DD
tags: [tag1, tag2]
---
```

---

## Règle de mise à jour — synchronisée à `/maj`, pas en temps réel

**Constat (2026-07-28, task-observer obs. 8) :** la version précédente de cette règle prétendait un déclenchement "automatique en temps réel, sans y penser" pendant la session. En pratique, ça dépend de la mémoire de l'agent en plein milieu d'édition — même défaut que les réflexes non forcés de `doctrines/methode.md`. Corrigé : le point de déclenchement fiable est `/maj` Étape 5 (`.claude/commands/maj.md`), qui tourne à chaque clôture de session sur ce repo et détecte mécaniquement les sources modifiées via `git diff --name-only [dernier commit]`.

**À `/maj`, si le répertoire courant est `vibe-method/` et que des sources ont changé :**
1. Identifier les pages wiki qui dérivent de ces sources (via le champ `source:` dans le frontmatter)
2. Relire chaque source modifiée
3. Mettre à jour les pages wiki concernées pour refléter les changements
4. Mettre à jour `source_modified` et `wiki_updated` dans le frontmatter
5. Ajouter une entrée dans `log.md` : `## [date] update | [source] → [pages mises à jour]`

Une mise à jour spontanée en cours de session reste bienvenue si elle vient naturellement — mais `/maj` est le filet qui garantit que ça se fait, pas une option de secours.

---

## Opérations

### Update (automatique)
- **Déclencheur** : fichier source modifié dans la session
- **Action** : relire → identifier changements → mettre à jour pages wiki → logger

### Query
- **Déclencheur** : question posée sur la méthode
- **Action** : lire `index.md` → identifier pages pertinentes → lire ces pages → synthétiser
- **Option** : si la synthèse est réutilisable, la filer en nouvelle page wiki

### Lint
- **Déclencheur** : `lint wiki` explicite
- **Action** : vérifier cohérence inter-pages, liens orphelins, pages stales (`source_modified` > `wiki_updated`), concepts non couverts

### Ingest
- **Déclencheur** : nouveau fichier source ajouté à vibe-method
- **Action** : lire le fichier → créer page(s) wiki → mettre à jour `index.md` → logger

---

## Conventions

- **Liens Obsidian** : `[[page]]` sans extension
- **Liens inter-dossiers** : `[[doctrines/securite]]` vs `[[skills/securite]]` pour lever les ambiguïtés
- **Nommage** : slugs kebab-case (`code-review-edge-cases.md`)
- **Format log** : `## [YYYY-MM-DD] opération | détail`
- **Pages skills** : une page = un skill, concise, centrée sur les inputs/outputs/liens
- **Pages doctrines** : une page = un fichier doctrine, centrée sur les principes clés et règles non-négociables
