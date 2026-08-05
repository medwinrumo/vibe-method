# Stratégie de réorganisation — skills, doctrines, dépôts

**Statut : proposition, non exécutée.** Rédigé le 2026-08-05 à la demande de Medwin.
Aucune étape ci-dessous n'est appliquée tant qu'il ne l'a pas validée.

---

## 1. Le problème, en une page

Trois questions se sont posées séparément et n'ont qu'une seule réponse cohérente :

1. **Des skills sont dans le mauvais dépôt** — `/lint` et `/wiki` opèrent sur le second cerveau, pas sur la méthode de dev. `/caveman`, `/pdf`, `/slides`, `/condense` sont des utilitaires génériques.
2. **Le wiki Obsidian `Vibe-Method/` décroche en permanence** — 30 pages périmées constatées le 05/08, parce que rien ne synchronise une page de résumé avec sa source.
3. **Medwin veut fusionner vibe-method dans le wiki second cerveau** partagé avec Hermes via GitHub.

Traiter (1) puis (2) puis (3) revient à déménager trois fois. La cible ci-dessous les absorbe ensemble.

---

## 2. L'idée centrale : supprimer la synchronisation au lieu de l'automatiser

Le sous-dossier `Vibe-Method/` existe pour une seule raison : rendre la méthode navigable dans Obsidian. Il produit un résumé par fichier source, et ces résumés décrochent.

**Une doctrine est du savoir.** `securite.md`, `tests.md`, `rgpd.md` sont exactement ce qu'un wiki second cerveau contient. Migrées comme fiches, elles n'ont plus besoin de résumé : elles *sont* la page Obsidian.

**Un skill est un exécutable, mais rédigé en prose markdown.** `deploy.md` se lit très bien dans Obsidian tel quel. Il n'a pas besoin d'un résumé non plus — au pire d'un index.

Conséquence : **`Vibe-Method/` disparaît entièrement.** Plus de couple source/résumé, donc plus de champ `source_modified`, plus de lint de fraîcheur, plus de 30 pages à rattraper. Le problème n'est pas résolu, il cesse d'exister.

C'est la réponse à la question 7 : ni « les liens pointent vers le wiki » ni « le wiki pointe vers les skills » — **un seul fichier, lu par les deux usages**.

---

## 3. La cible

```
~/dev/wiki/                      ← dépôt GitHub, partagé Mac ↔ VPS Hermes
├── CLAUDE.md  index.md  log.md  ← infrastructure du vault
├── <fiches>.md                  ← vault plat : savoir existant
│                                  + 12 doctrines migrées
│                                  + fichiers de recherche/extraction convertis
└── .claude/                     ← exécutable. Masqué d'Obsidian par le point
    ├── commands/                ← skills de la méthode uniquement
    ├── agents/                  ← 4 personas
    ├── hooks/                   ← stop-cloture.sh, track-repo.sh
    └── scripts/                 ← lint-observabilite.py + son test

~/dev/claude-config/             ← dépôt privé : personnel, non transposable
├── CLAUDE.md                    ← instructions globales (+ ce qui vient de CLAUDE.global.md)
├── settings.json
├── commands/                    ← skills hors méthode
├── hooks/                       ← session-start, stop-cavecrew, track-agent-usage
├── skills/task-observer/
└── observations/

~/.claude/                       ← points d'entrée. Que des liens, jamais de fichier réel
├── commands/ → wiki/.claude/commands/  +  claude-config/commands/
├── agents/   → wiki/.claude/agents/
├── hooks/    → les deux dépôts
└── skills/   → claude-config/skills/
```

**Règle qui gouverne tout :** un fichier réel dans `~/.claude/` est un bug. Ce dossier ne contient que des points d'entrée vers des dépôts versionnés. Aujourd'hui `firecrawl.md` viole cette règle — c'est le seul fichier de skill de la machine qui ne soit sauvegardé nulle part.

### Réponse à « faut-il versionner la racine de `~/.claude` ? »

Non — et la question ne se pose plus avec cette cible. On ne versionne pas `~/.claude`, on fait en sorte qu'il n'y ait rien d'unique dedans. Tout fichier réel est déplacé vers l'un des deux dépôts et remplacé par un lien.

---

## 4. Répartition des skills

### Restent dans la méthode → `wiki/.claude/commands/`

La chaîne complète, plus la gestion de session, plus l'infrastructure projet :

`contexte` `brief` `charte` `prd` `prd-update` `prd-validate` `gherkin` `angles-morts`
`design` `archi` `regles` `adr` `stack` `roadmap` `specs` `to-issues` `readyTo-code`
`setup` `prp` `avancement` `sessionCode` `code-review` `code-review-edge-cases`
`repair-edge-cases` `code-review-hostil` `tests` `securite` `doc-tech` `recette`
`debug` `diagnose` `diagnostic-serveur` `commit` `pr` `phase-retrospective` `refacto`
`impact` `party` `grill-me` `zoom-out` `prototype` `askme` `init-projet` `deploy`
`backup` `todo` `maj` `majtodo` `checkpoint` `handoff` `log` `peda` `doc` `spec`

**Correction actée le 05/08 :** `diagnostic-serveur`, `backup` et `deploy` sont pleinement de la méthode — la méthode va jusqu'à la production. Les avoir qualifiés de « défendables » était une hésitation injustifiée.

### Sortent → `claude-config/commands/`

| Skill | Pourquoi |
|---|---|
| `lint` | Opère sur `~/dev/wiki` — son objet est le second cerveau |
| `wiki` | Idem |
| `caveman` | Mode de communication, préférence personnelle |
| `pdf` | Générateur générique |
| `slides` | Générateur générique |
| `condense` | Utilitaire générique |
| `firecrawl` | ⚠️ aujourd'hui fichier réel non versionné dans `~/.claude/commands/` |

**Cas particulier `lint` et `wiki` :** ils sortent de la méthode, mais leur objet — le wiki — devient le dépôt qui héberge la méthode. Le rangement reste correct : ils traitent du vault en tant que base de connaissance, pas de la méthode de développement.

### À trancher — `cgv` et `devis`

Medwin a indiqué ne pas faire ce travail dans le cadre de la vibe-method. Mais la chaîne documentée dans `CLAUDE.md` les place en phase 0 commerciale, et `/devis` consomme `[projet].brief.md` produit par `/brief`.

**Recommandation : les garder dans la méthode.** Ils sont chaînés à des artefacts de la méthode, et un tiers qui adopterait le workflow client complet en aurait besoin. Si Medwin préfère les sortir, il faudra retirer la phase 0 de la chaîne documentée et couper la dépendance `/brief` → `/devis`.

---

## 5. `CLAUDE.global.md` — la scission

Le fichier est chargé dans toutes les sessions via `~/dev/CLAUDE.md`. Il mélange deux natures.

| Section | Destination |
|---|---|
| Préférences de communication | `claude-config/CLAUDE.md` |
| Gestion des modèles et agents | `claude-config/CLAUDE.md` |
| Exigence de rigueur professionnelle | **Doctrine** → fiche wiki `methode-rigueur.md`, transposable |
| Règles de sécurité non négociables | Déjà dans `securite.md` — remplacer par un renvoi |
| Écosystème de projets (Minou, makeRag) | `claude-config/CLAUDE.md` |
| Commandes de session, artefacts par projet | Méthode → reste avec la méthode |
| Process de clôture | Méthode |

**Attention au doublon** que Medwin a repéré : `claude-config/CLAUDE.md` existe déjà. La fusion ne doit pas empiler deux fichiers d'instructions globales — il faut une seule section « Observation des sessions » et une seule liste de préférences.

---

## 6. Fichiers de la racine de `vibe-method`

### Déjà supprimés le 05/08 (mis à la Corbeille, récupérables)
`## CONDITIONS GÉNÉRALES DE VENTE.md` · `devisType.pdf` · `traite-vibe-coding-eclaire.epub`

### À convertir en fiches wiki `type: Source`

Medwin a demandé que recherche, extraction et savoir deviennent des fiches. Renommage proposé avec préfixe explicite :

| Fichier actuel | Devient | Type |
|---|---|---|
| `cybersecurite-recherche.md` | `recherche-cybersecurite.md` | Source |
| `rgpd-research-2026-05-21.md` | `recherche-rgpd-fournisseurs.md` | Source |
| `apports-traite-vibe-coding.md` | `extraction-traite-vibe-coding.md` | Source |
| `resume-traite-vibe-coding.md` | fusionner dans le précédent | — |
| `bilan-integration-traite.md` | fusionner dans le précédent | — |
| `apple-hig-react-native.md` | `reference-apple-hig-react-native.md` | Source |
| `appstore.md` | `reference-apple-appstore.md` | Source |
| `claude-design.md` | `reference-claude-design.md` | Source |
| `guide-definition-produit.md` | `guide-definition-produit.md` | Concept |
| `audit-doctrine-strategie.md` | `audit-doctrine-strategie.md` | Source |

**Sur la référence Apple :** ce n'est pas un skill, c'est de la documentation externe. Elle nourrit `/deploy` étape 2bis (soumission stores) et `[projet].stack.md`. Elle devient une fiche `Source`, et `/deploy` la cite comme il cite déjà le wiki.

### À supprimer
- `bmad-comparaison.md` — la comparaison a produit ses conclusions, intégrées dans les doctrines
- `Checklist-RGPD-en-10-points.md` et `Checklist Vercel vs RGPD.md` — **à vérifier avant** : confirmer que leurs points sont bien tous dans `rgpd.md` section 12. Si oui, supprimer ; sinon, compléter d'abord

### Restent tels quels
`vibe-method.todo.md` `.log.md` `.peda.md` — artefacts de suivi du dépôt lui-même
`setup.sh` — voir ci-dessous

---

## 7. `setup.sh` — ce qu'il faut savoir

**Il est versionné** dans `vibe-method`, donc sur GitHub. Une machine perdue le retrouve avec le `git clone`. C'est ce que Medwin supposait, et c'est exact.

**« Écrase sans prévenir » veut dire ceci :** le script pose les liens avec `ln -sf`. Le `-f` remplace la cible existante *sans demander et sans sauvegarder*. Si un fichier réel porte le même nom qu'un skill de vibe-method — cas de `firecrawl.md` aujourd'hui — il est détruit, définitivement. C'est arrivé le 29/07/2026 avec `grill-me.md`.

`claude-config/install.sh` ne fait pas cette erreur : il sauvegarde d'abord sous `.remplace-<horodatage>`.

**À faire dans la migration :** `setup.sh` est réécrit pour la nouvelle structure, et aligné sur le comportement de `install.sh` — sauvegarde avant remplacement. Ou fusionné avec lui, puisqu'il n'y aura plus qu'une logique d'installation à deux sources.

---

## 8. `scripts/` — réponse à la question 9

Oui, les déplacer dans `.claude/scripts/` avec `agents/`, `commands/` et `hooks/` est cohérent : ce sont des exécutables de la méthode, au même titre qu'un hook.

**Coût :** 11 fichiers citent `lint-observabilite`, dont `/deploy` (étape 5bis, chemin en dur dans une commande à copier-coller) et la doctrine `observabilite.md`. Tous à mettre à jour.

**Réservé pour plus tard, à ne pas oublier :** l'en-tête de `test_lint_observabilite.py` indique que les cas E-H, trouvés par le sous-agent `code-reviewer`, étaient *tous fail-open avant correction* — le lint laissait passer sans rien dire. C'est le même mode de panne que l'observation 36. À réexaminer une fois la structure stabilisée.

---

## 9. Le coût réel — les dépendances

Mesuré le 05/08 par recherche textuelle :

| Motif à mettre à jour | Fichiers concernés |
|---|---|
| `~/dev/vibe-method` / `dev/vibe-method` | 14 |
| `CLAUDE.global` | 11 |
| `lint-observabilite` | 11 |
| `Vibe-Method/` | 9 |
| `vibe-method/.claude/commands` | 8 |

À quoi s'ajoutent les 62 skills, qui se citent les uns les autres en chaîne (`Précédent :` / `Suivant :`), et le miroir Hermes sur le VPS.

**Ce n'est pas un détail, c'est le gros du travail.** La règle écrite dans `claude-config/README.md` le 05/08 s'applique intégralement : un déplacement n'est terminé que quand `grep -rn "<ancien-chemin>"` ne renvoie plus rien d'actif.

---

## 10. Phases proposées

Chaque phase est autonome et laisse le système fonctionnel. Aucune ne démarre sans validation.

| # | Phase | Contenu | Risque |
|---|---|---|---|
| 0 | **Filet de sécurité** | Versionner `firecrawl.md`. Vérifier que `sync-memory` fonctionne. Supprimer les 2 dossiers de backup obsolètes, `~/dev/handoff.md` | Nul |
| 1 | **Nettoyage racine** | Convertir recherche/extraction en fiches, vérifier puis supprimer les checklists RGPD et `bmad-comparaison` | Faible |
| 2 | **Scission `CLAUDE.global.md`** | Séparer doctrine et personnel, fusionner avec `claude-config/CLAUDE.md` sans doublon, mettre à jour les 11 références | Moyen — fichier chargé partout |
| 3 | **Répartition des skills** | Sortir les 7 skills hors méthode vers `claude-config/commands/`, refaire les liens | Moyen |
| 4 | **Migration des doctrines vers le wiki** | 12 doctrines → fiches wiki avec le mapping de types déjà décidé (type fin → type large + tag) | Moyen |
| 5 | **Bascule de l'exécutable** | `commands/`, `agents/`, `hooks/`, `scripts/` → `wiki/.claude/`. Mise à jour des chemins en dur | **Élevé** — touche le VPS Hermes |
| 6 | **Suppression de `Vibe-Method/`** | Le miroir n'a plus d'objet | Faible |
| 7 | **Réécriture de `setup.sh`** | Nouvelle structure, sauvegarde avant remplacement | Faible |

**Ordre imposé :** la phase 0 d'abord, toujours. La phase 5 en dernier parmi les déplacements, parce qu'elle implique Hermes et le dépôt partagé.

---

## 11. Décisions qui manquent avant de commencer

1. **`cgv` et `devis`** — dans la méthode ou hors méthode ?
2. **Les doctrines dans le wiki plat** — 12 fiches de plus dans un vault de 126, avec des noms génériques (`securite.md`, `tests.md`). Faut-il un préfixe (`methode-securite.md`) pour éviter la collision avec une fiche de savoir sur le même thème ? Il existe déjà `rgpd.md` dans le wiki **et** `rgpd.md` dans vibe-method — deux fichiers différents sur le même sujet, collision certaine.
3. **Hermes** — le dépôt wiki partagé recevra `.claude/` avec 55 skills Claude Code dont Hermes n'a aucun usage. Acceptable comme bruit, ou faut-il un dépôt séparé pour l'exécutable ?
4. **Les plugins** (`exa`, `caveman`) restent gérés par Claude Code dans `~/.claude/plugins/` — installés, mis à jour et supprimés par l'outil. Ils ne rentrent dans aucun dépôt. C'est normal et il n'y a rien à faire.
5. **Les miroirs Hermes** (`cgv-generation`, `wiki`, `wiki-lint` sur le VPS) — recopies manuelles, sans synchronisation. Le problème est le même que `Vibe-Method/`, à traiter une fois la structure Mac stabilisée.
