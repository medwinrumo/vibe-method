# Stratégie de réorganisation — skills, doctrines, dépôts

**Version 4 — 2026-08-05.** Phase 0 faite. Les 62 skills ont leur `description`.
Plus aucune décision bloquante : la collision `log.md` est tranchée.
Les phases 1 à 7 attendent le feu vert.

---

## 1. Le problème

Trois questions posées séparément, une seule réponse cohérente :

1. Des skills sont dans le mauvais dépôt (`/lint` et `/wiki` opèrent sur le second cerveau).
2. Le wiki Obsidian `Vibe-Method/` décroche en permanence — 30 pages périmées le 05/08.
3. Medwin veut fusionner vibe-method dans le wiki second cerveau partagé avec Hermes.

Les traiter dans l'ordre reviendrait à déménager trois fois.

---

## 2. L'idée centrale : supprimer la synchronisation, pas l'automatiser

`Vibe-Method/` existe pour rendre la méthode navigable dans Obsidian. Il produit un résumé par fichier source, et ces résumés décrochent.

Or **une doctrine est du savoir** : migrée comme fiche, elle n'a plus besoin de résumé, elle *est* la page Obsidian. Et **un skill est un exécutable rédigé en prose markdown** : il se lit très bien dans Obsidian tel quel.

Conséquence : `Vibe-Method/` disparaît. Plus de couple source/résumé, plus de champ `source_modified`, plus de lint de fraîcheur. Le problème cesse d'exister au lieu d'être géré.

---

## 3. La cible

**Tout le markdown est à plat et visible dans Obsidian.** Les versions 1 et 2 rangeaient les skills à l'écart — masqués d'abord, en sous-dossier ensuite — ce qui les sortait du catalogue du second cerveau. Le test du 05/08 lève cette contrainte.

```
~/dev/wiki/                      ← dépôt GitHub, partagé Mac ↔ VPS Hermes
├── CLAUDE.md  index.md  log.md  ← infrastructure du vault (déjà exemptés de frontmatter)
│
├── <fiches de savoir>.md        ← vault plat, existant
├── *-doc.md                     ← 12 doctrines migrées (suffixe validé)
├── *-rech.md                    ← recherches et extractions (suffixe validé)
├── <nom-du-skill>.md            ← 55 skills, fiches `type: Procédure`, à plat
├── <nom-de-l-agent>.md          ← 4 agents, idem
│
├── hooks/                       ← shell — non-.md, hors vault Obsidian
└── scripts/                     ← existe déjà (lint-wiki.py), reçoit lint-observabilite.py

~/dev/claude-config/             ← dépôt privé : personnel, non transposable
├── CLAUDE.md                    ← instructions globales (+ le personnel de CLAUDE.global.md)
├── settings.json  install.sh
├── commands/                    ← 7 skills hors méthode + task-observer
├── hooks/                       ← session-start, stop-cavecrew, track-agent-usage
└── observations/

~/.claude/                       ← les 4 dossiers d'extension ne contiennent QUE des liens
├── commands/ → wiki/<skill>.md  +  claude-config/commands/*.md
├── agents/   → wiki/<agent>.md
├── hooks/    → les deux dépôts
└── skills/   → claude-config/skills/
```

Claude Code lit `~/.claude/commands/<nom>.md` ; **le chemin de la cible du lien lui est indifférent**. Un skill peut donc vivre à plat dans le vault, aux côtés des fiches de savoir, et rester invocable par `/deploy`.

### La règle sur `~/.claude`, énoncée correctement

La version 1 disait « que des liens », ce qui est faux. Vérifié le 05/08 :

| Zone | Nature | Règle |
|---|---|---|
| `commands/` `agents/` `hooks/` `skills/` | dossiers d'extension | **Que des liens.** Un fichier réel y est un bug |
| `MEMORY.md` | mémoire globale | Sauvegardée par `claude-memoire` |
| `mcp.json` | secrets | Hors git volontairement, gabarit dans `claude-config` |
| `plugins/` (502 Mo) `projects/` (76 Mo) `cache/` `sessions/` `telemetry/`… | état d'exécution | Géré par Claude Code, régénérable, ne rien y faire |

Violations actuelles : `firecrawl.md` et `.DS_Store` dans `commands/`.

### Frontmatter : testé le 05/08 — une fiche wiki peut être un skill

La version 2 proposait d'exempter skills et agents de frontmatter. **Medwin a refusé et demandé un test** : sans frontmatter, un skill dans le wiki n'est ni typé, ni tagué, ni catalogué — c'est un dossier posé à côté du second cerveau, donc aucun intérêt à l'y mettre. Il avait raison.

**Ce que dit la documentation officielle** (`code.claude.com/docs/en/slash-commands`) : elle liste les champs supportés (`name`, `description`, `when_to_use`, `argument-hint`, `arguments`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `disallowed-tools`, `model`, `effort`, `context`, `agent`, `background`, `hooks`, `paths`, `shell`) et précise « All fields are optional ». Elle ne dit **rien** du sort des champs inconnus. Elle ne tranche donc pas.

**Test empirique, deux chemins :**

| Chemin testé | Résultat |
|---|---|
| Fichier **neuf** portant les 7 champs wiki + `description` | Détecté sans redémarrage de session, `description` correctement lue dans la liste des skills, corps chargé à l'invocation |
| Skill **préexistant** (`/firecrawl`) auquel on ajoute le frontmatter wiki | Corps chargé intégralement, invocation normale |

**Conclusion : les champs inconnus sont ignorés silencieusement. Un skill et un agent peuvent être des fiches wiki complètes** — typés, tagués, catalogués dans `index.md`, reliés par wikiliens, présents dans le graphe.

Le type qui convient existe déjà dans la typologie du wiki : **`Procédure`** (« le comment, les étapes concrètes à suivre »). Un skill n'est pas du savoir, c'est une procédure — la distinction est déjà faite.

`description` devient le seul champ à ajouter aux 58 skills qui n'en ont pas, en plus du frontmatter wiki.

**Effet de bord constaté :** un skill créé ou modifié en cours de session est pris en compte immédiatement, sans redémarrage. Même comportement que `settings.json`.

### La seule collision : `log.md`

Mesuré sur 66 skills et agents contre 127 fiches du wiki : **une seule collision de nom**, entre le skill `/log` et le journal `log.md` du wiki. Aucune autre.

Trois issues, avec leur coût réel :

| Option | Coût mesuré | Conséquence |
|---|---|---|
| **A — renommer le journal du wiki** | 14 références dans `wiki/`, dont 1 dans `lint-wiki.py`, plus le skill miroir Hermes du VPS | Garde le vault plat. Touche un fichier d'infrastructure et une convention ancrée (« logger dans `log.md` ») |
| **B — renommer le skill `/log`** | 13 fichiers, dont `CLAUDE.global.md` et la chaîne documentée | Garde le vault plat. Casse une commande utilisée quotidiennement |
| **C — sous-dossier `skills/`** | 0 renommage | Coûte la platitude du vault et impose les wikiliens en chemin explicite (`[[skills/log]]`) |

**Tranché le 05/08 : option A, sous la forme `journal-log.md`.** Medwin garde la terminologie `log`, à laquelle il est habitué, et la collision disparaît. Le vault reste plat, les commandes restent intactes, les wikiliens restent en forme simple.

Périmètre : 14 références dans `wiki/`, dont 1 dans `lint-wiki.py`, plus le skill miroir `wiki` du VPS Hermes.

### Où va chaque chose — réponse à la question de Medwin

| Contenu actuel | Destination | Forme |
|---|---|---|
| 12 doctrines | racine du vault, `*-doc.md` | fiche complète, frontmatter |
| `flux/chaine-complete.md` | racine, `chaine-complete-doc.md` | fiche — c'est du savoir de navigation |
| 55 skills de méthode | racine du vault | fiche `type: Procédure` + `description` |
| 4 agents | racine du vault | fiche `type: Procédure` + `description` |
| 2 hooks de méthode | `wiki/hooks/` | shell |
| 2 scripts | `wiki/scripts/` | python, rejoint `lint-wiki.py` |
| Recherches, extractions, références | racine, `*-rech.md` | fiche `type: Source` |
| `Vibe-Method/` en entier | **supprimé** | — |
| `_vue-ensemble.md` `index.md` du miroir | fusionnés dans `index.md` du wiki | — |

**Wikiliens :** tout étant à plat, les liens restent en forme simple (`[[deploy]]`, `[[securite-doc]]`). Aucun chemin explicite nécessaire — c'est le bénéfice direct de la résolution de la collision `log.md`.

**Amendement à acter dans `wiki/CLAUDE.md` :** le vault reste plat pour tout le markdown. Seuls `hooks/` et `scripts/`, qui ne contiennent aucun `.md`, sont des sous-dossiers — Obsidian les ignore de toute façon. La typologie s'enrichit d'un usage : `Procédure` couvre désormais aussi les skills et les agents, qui sont exécutables en plus d'être lisibles.

---

## 4. Répartition des skills

### Restent dans la méthode → racine de `wiki/` (55)

`contexte` `brief` `charte` `prd` `prd-update` `prd-validate` `gherkin` `angles-morts`
`design` `archi` `regles` `adr` `stack` `roadmap` `specs` `to-issues` `readyTo-code`
`setup` `prp` `avancement` `sessionCode` `code-review` `code-review-edge-cases`
`repair-edge-cases` `code-review-hostil` `tests` `securite` `doc-tech` `recette`
`debug` `diagnose` `diagnostic-serveur` `commit` `pr` `phase-retrospective` `refacto`
`impact` `party` `grill-me` `zoom-out` `prototype` `askme` `init-projet` `deploy`
`backup` `todo` `maj` `majtodo` `checkpoint` `handoff` `log` `peda` `doc` `spec`
`cgv` `devis`

`diagnostic-serveur`, `backup` et `deploy` sont pleinement de la méthode — elle va jusqu'à la production. `cgv` et `devis` restent : Medwin a suivi la recommandation, ils sont chaînés à `[projet].brief.md`.

### Sortent → `claude-config/commands/` (7)

| Skill | Motif |
|---|---|
| `lint` `wiki` | Objet = le second cerveau, pas la méthode de dev |
| `caveman` | Mode de communication |
| `pdf` `slides` | Générateurs génériques |
| `condense` | Utilitaire générique |
| `firecrawl` | ⚠️ aujourd'hui fichier réel non versionné |

---

## 5. `CLAUDE.global.md` — la scission

| Section | Destination |
|---|---|
| Préférences de communication | `claude-config/CLAUDE.md` |
| Gestion des modèles et agents | `claude-config/CLAUDE.md` |
| Exigence de rigueur professionnelle | **Doctrine** → `rigueur-doc.md` dans le wiki |
| Règles de sécurité non négociables | Déjà dans `securite.md` → remplacer par un renvoi |
| Écosystème de projets (Minou, makeRag) | `claude-config/CLAUDE.md` |
| Commandes de session, artefacts par projet, clôture | Méthode → `methode-doc.md` |

**Attention au doublon** : `claude-config/CLAUDE.md` existe déjà avec une section « Observation des sessions ». La fusion doit produire un seul fichier cohérent, pas deux blocs empilés.

---

## 6. Fichiers de la racine de `vibe-method`

### Supprimés le 05/08 (Corbeille, récupérables)
`## CONDITIONS GÉNÉRALES DE VENTE.md` · `devisType.pdf` · `traite-vibe-coding-eclaire.epub`

### Deviennent des fiches `*-rech`

| Actuel | Devient |
|---|---|
| `cybersecurite-recherche.md` | `cybersecurite-rech.md` |
| `rgpd-research-2026-05-21.md` + `Checklist-RGPD-en-10-points.md` + `Checklist Vercel vs RGPD.md` | `rgpd-fournisseurs-rech.md` (fusion des trois) |
| `apports-traite-vibe-coding.md` + `resume-traite-vibe-coding.md` + `bilan-integration-traite.md` | `traite-vibe-coding-rech.md` (fusion des trois) |
| `apple-hig-react-native.md` | `apple-hig-react-native-rech.md` |
| `appstore.md` | `apple-appstore-rech.md` |
| `claude-design.md` | `claude-design-rech.md` |
| `guide-definition-produit.md` | `guide-definition-produit-rech.md` |
| `audit-doctrine-strategie.md` | `audit-doctrine-strategie-rech.md` |

**Correction v2 sur les checklists RGPD.** Medwin demandait de vérifier avant suppression. Vérification faite : elles ne font **pas** doublon avec `rgpd.md` section 12, qui est une checklist de pré-production. Ces deux fichiers analysent des fournisseurs (Supabase, Vercel, souveraineté, alternatives européennes). Ce sont des recherches → fusion, pas suppression.

### Supprimé
`bmad-comparaison.md` — analyse comparative terminée, conclusions intégrées aux doctrines.

### Restent
`vibe-method.todo.md` `.log.md` `.peda.md` — suivi du dépôt lui-même. À déplacer avec la méthode ou à archiver, selon ce qu'il reste de `vibe-method` à la fin.

---

## 7. `setup.sh` et `install.sh` — tâche d'alignement

**`setup.sh` est versionné** dans `vibe-method`, donc récupérable après un `git clone`.

**« Écrase sans prévenir » :** il pose les liens avec `ln -sf`. Le `-f` remplace la cible existante sans demander ni sauvegarder. Un fichier réel portant le nom d'un skill est détruit définitivement — arrivé le 29/07/2026 avec `grill-me.md`, et `firecrawl.md` est exposé au même sort aujourd'hui.

`claude-config/install.sh` ne fait pas cette erreur : il sauvegarde sous `.remplace-<horodatage>`.

**Tâche actée : fusionner les deux en un seul installateur**, avec le comportement de sauvegarde de `install.sh`, gérant les deux sources (wiki et claude-config). Un seul point d'entrée pour reconstruire une machine.

---

## 8. `scripts/`

Les déplacer avec les autres exécutables est cohérent, et le wiki a **déjà** un `scripts/` (`lint-wiki.py`) — ils s'y rejoignent naturellement.

**Coût :** 11 fichiers citent `lint-observabilite`, dont `/deploy` (chemin en dur dans une commande à copier-coller) et la doctrine `observabilite.md`.

---

## 9. Le coût réel — les dépendances

Mesuré le 05/08 :

| Motif | Fichiers |
|---|---|
| `~/dev/vibe-method` / `dev/vibe-method` | 14 |
| `CLAUDE.global` | 11 |
| `lint-observabilite` | 11 |
| `Vibe-Method/` | 9 |
| `vibe-method/.claude/commands` | 8 |

Plus les 62 skills qui se citent en chaîne, plus les miroirs Hermes du VPS.

Règle applicable (écrite dans `claude-config/README.md` le 05/08) : un déplacement n'est terminé que quand `grep -rn "<ancien-chemin>"` ne renvoie plus rien d'actif.

---

## 10. Sur le suffixe `-gh` pour les dépôts

Medwin propose de renommer les dossiers de dépôt (`vibe-method-gh`) pour les reconnaître.

**Recommandation : ne pas le faire.** Le coût est celui du tableau ci-dessus multiplié par le nombre de dépôts — chaque chemin en dur, chaque lien symbolique, chaque doc, plus le VPS. Pour un bénéfice purement visuel.

**Alternative à coût nul :** après la migration il ne restera que trois dépôts sous `~/dev/` (`wiki`, `claude-config`, `claude-memoire`), tous trois versionnés — la question de les distinguer disparaît d'elle-même. Et pour lister les dépôts à tout moment :

```bash
for d in ~/dev/*/; do [ -d "$d/.git" ] && echo "gh  $(basename $d)" || echo "    $(basename $d)"; done
```

---

## 11. Phases

| # | Phase | Contenu | Risque | État |
|---|---|---|---|---|
| 0 | **Filet de sécurité** | Versionner `firecrawl.md` ; supprimer `~/dev/handoff.md`, les 2 `claude-config-backup-*`, le `.DS_Store` de `commands/` | Nul | **en cours** |
| 1 | **Nettoyage racine** | Fusions et renommages `*-rech`, suppression de `bmad-comparaison.md` | Faible | à valider |
| 2 | **Scission `CLAUDE.global.md`** | Séparer doctrine et personnel, fusionner sans doublon, 11 références | Moyen | à valider |
| 3 | **Répartition des skills** | 7 skills → `claude-config/commands/`, liens refaits | Moyen | à valider |
| 4 | **Doctrines → wiki** | 12 fiches `*-doc`, fusion des deux `rgpd.md` | Moyen | à valider |
| 5 | **Exécutable → wiki** | 55 skills + 4 agents convertis en fiches `Procédure` à plat ; `hooks/` et `scripts/` en sous-dossiers ; chemins en dur | **Élevé** — touche Hermes | à valider |
| 6 | **Suppression de `Vibe-Method/`** | Le miroir n'a plus d'objet | Faible | à valider |
| 7 | **Installateur unique** | Fusion `setup.sh` + `install.sh` | Faible | à valider |

Ordre imposé : phase 0 d'abord, phase 5 en dernier parmi les déplacements.

---

## 12. Décisions prises le 05/08

- Suffixe doctrines : **`-doc`** (ex. `securite-doc.md`)
- Suffixe recherches : **`-rech`** (ex. `rgpd-fournisseurs-rech.md`)
- `cgv` et `devis` : **restent dans la méthode**
- Hermes recevra les skills Claude Code : **bruit acceptable**, pas de dépôt séparé
- Plugins : **rien à faire**, gérés par Claude Code
- Les deux `rgpd.md` (wiki et vibe-method) : **à fusionner** en phase 4
- Suffixe `-gh` : **écarté**, voir §10

## 13. À reprendre plus tard, hors structure

1. **`test_lint_observabilite.py`** — ses cas E-H étaient *tous fail-open* avant correction : le lint laissait passer sans rien dire. Même mode de panne que l'observation 36. À réexaminer une fois la structure stable.
2. **Sauvegarde mémoire en retard de deux jours** — `com.medwinrumo.sync-memory` est chargé, annonce un intervalle de 15 min, son fichier de log n'existe pas, et le fichier écrit le 05/08 au matin n'était pas sauvegardé deux heures plus tard. Cause à établir.

---

## 15. Décisions du 05/08, après le test de frontmatter

**Collision `log.md` → `journal-log.md`.** Le journal du wiki est renommé, la terminologie `log` est conservée. 14 références dans `wiki/` plus le skill miroir Hermes.

**`commands/` et `skills/` unifiés en fichiers plats.** La documentation officielle est explicite : « A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` both create `/deploy` and work the same way. » La forme dossier ne sert qu'à embarquer des fichiers annexes. `task-observer` n'en a aucun — il devient `claude-config/commands/task-observer.md`.

**Coût :** une ligne dans `claude-config/hooks/session-start.sh`, qui code `~/.claude/skills/task-observer/SKILL.md` en dur (ligne 47). `~/.claude/skills/` devient vide et peut disparaître.

**`description` posée sur les 62 skills** (58 ajoutées le 05/08, 4 préexistantes). Le frontmatter wiki complet viendra au moment du déplacement, en phase 5 — inutile de typer `Procédure` un fichier encore hors du vault.

---

## 16. Chantier à ouvrir plus tard — `description` sur toutes les fiches du wiki

Aucune des 127 fiches du wiki n'a de champ `description`. Mais `index.md` porte une **colonne « Résumé »** pour chacune.

Ce résumé existe donc déjà, et vit au mauvais endroit : séparé de la fiche qu'il décrit. C'est le motif exact que la suppression de `Vibe-Method/` élimine — une description qui vit ailleurs que son objet, et qui décroche sans que rien ne le signale.

**Ce que le déplacement apporterait :**
- un agent qui cherche lit la description sans ouvrir l'index
- la colonne « Résumé » de `index.md` devient **générée** depuis les fiches, au lieu d'être maintenue à la main
- `lint-wiki.py` peut vérifier que chaque fiche a sa description

**Charge réelle :** un travail de migration, pas de rédaction — les résumés sont déjà écrits.

**À faire au même moment :** ajouter le champ à `wiki/CLAUDE.md` avec ses règles de rédaction (que dit une bonne description, quelle longueur, quel angle), et modifier le skill `/wiki` pour qu'il le remplisse à chaque création de fiche.

À ouvrir après la migration de structure — pas pendant.
