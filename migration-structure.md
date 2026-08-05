# Stratégie de réorganisation — skills, doctrines, dépôts

**Version 11 — 2026-08-05. Chantier terminé.**
Les phases 0 à 7 sont faites. Ce document devient un journal.
Aucune décision bloquante. Ce document est le point de reprise : une session
neuve peut continuer à partir de lui seul, sans l'historique de conversation.

---

## 0. Reprendre ce chantier dans une session neuve

Tout est commité et poussé. Ce document suffit à continuer — l'historique de conversation n'est pas nécessaire.

**Pour reprendre :**

1. `cd ~/dev/vibe-method && git pull` puis lire ce fichier en entier
2. `bash scripts/audit-dependances.sh` — état de référence avant toute modification
3. Il n'y a plus de phase à mener. Le journal complet est aux §18 à §24 — à lire pour comprendre pourquoi les choses sont là où elles sont
4. À la fin de la phase : relancer l'audit, comparer, puis commiter et pousser les dépôts touchés

**Ce qu'il faut savoir avant de toucher à quoi que ce soit :**

- **Comment Claude Code charge les instructions** — il remonte l'arborescence depuis le dossier de travail et concatène tous les `CLAUDE.md` rencontrés, de la racine vers le bas, plus `~/.claude/CLAUDE.md` (portée utilisateur). Un fichier n'est donc « chargé » que s'il est à l'un de ces emplacements. Une fiche wiki ne l'est pas : elle se consulte à la demande. C'est ce qui a invalidé le plan initial du §5.
- **Les skills ne dépendent pas du dossier courant.** Ils vivent dans `~/.claude/commands/` et sont disponibles partout. Seuls leur nom et leur `description` sont chargés au démarrage ; le corps se charge à l'invocation.
- **Rien n'applique la méthode automatiquement.** La documentation officielle est explicite : « Claude treats them as context, not enforced configuration. » Un artefact de projet n'existe que parce que son skill a été invoqué. Vérifié le 05/08 : aucun des quatre projets actifs n'a les 11 artefacts prévus.
- **La règle du grep** (§9) : un déplacement n'est fini que quand `grep -rn "<ancien-chemin>"` ne renvoie plus que des occurrences volontaires.
- **Les mémoires automatiques se corrigent dans `~/.claude/projects/*/memory/`**, jamais dans `claude-memoire` — ce dépôt est une sauvegarde, une correction faite là serait écrasée.

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

**Corrigé le 05/08 — la version précédente de ce tableau était fausse.** Elle envoyait « Exigence de rigueur » vers une fiche wiki `rigueur-doc.md` et « Commandes de session » vers `methode-doc.md`, et remplaçait les règles de sécurité par un renvoi. C'était une dérive de ma part par rapport à la consigne de Medwin, qui était : *« scinder ce qui relève de la doctrine et le laisser dans le CLAUDE.md de vibe-method, sortir tout le reste vers claude-config »*.

Deux raisons de ne pas découper vers le wiki :

1. **Une fiche wiki n'est pas chargée.** Elle se consulte à la demande. Y envoyer une règle permanente la désactive silencieusement — le fichier dit lui-même de ses règles de sécurité : « elles ne nécessitent pas qu'on invoque `/securite` pour être actives ».
2. **Vérifié le 05/08 : les commandes de session s'appliquent partout.** `HYGEIA`, `RAMrezo`, `HERMES` et `minou` portent tous des artefacts de la méthode. Les laisser dans `vibe-method/CLAUDE.md` les rendrait inactives sur ces projets, puisque ce fichier n'est chargé que dans le dépôt vibe-method.

**Décision : le fichier part entier dans `claude-config/CLAUDE.md`.** Aucun découpage, aucune fiche créée, aucune règle perdue.

| Section | Destination |
|---|---|
| **Toutes** — préférences, modèles, rigueur, sécurité, écosystème, commandes de session, artefacts, clôture | `claude-config/CLAUDE.md`, donc `~/.claude/CLAUDE.md` |

**Ce que le déplacement gagne :** `~/.claude/CLAUDE.md` est de portée **utilisateur** — chargé dans toutes les sessions, y compris hors de `~/dev`. Aujourd'hui `~/dev/CLAUDE.md` n'est chargé que parce que `~/dev` est un dossier parent du projet courant. La couverture s'élargit, elle ne se réduit pas.

**Ce qui disparaît :** le lien `~/dev/CLAUDE.md` et le fichier `vibe-method/CLAUDE.global.md`.

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
| 0 | **Filet de sécurité** | `firecrawl.md` versionné dans `claude-config/commands/` et remplacé par un lien ; `~/dev/handoff.md`, les 2 `claude-config-backup-*` et le `.DS_Store` supprimés | Nul | ✅ **faite** |
| 1 | **Nettoyage racine** | Fusions et renommages `*-rech`, suppression de `bmad-comparaison.md` | Faible | à valider |
| 2 | **Déplacement de `CLAUDE.global.md`** | Fichier déplacé entier vers `claude-config/CLAUDE.md` (portée utilisateur), lien `~/dev/CLAUDE.md` supprimé, 6 références corrigées | Moyen | ✅ **faite** |
| 3 | **Répartition des skills** | 7 skills → `claude-config/commands/`, liens refaits ; `task-observer` aplati | Moyen | ✅ **faite** |
| 4 | **Doctrines → wiki** | 12 fiches `*-doc` ; les deux `rgpd.md` **non** fusionnées, voir §21 | Moyen | ✅ **faite** |
| 5 | **Exécutable → wiki** | 56 skills + 4 agents en fiches `Procédure` ; `log.md` → `journal-log.md` ; `setup.sh` réécrit | **Élevé** — touche Hermes | ✅ **faite** |
| 6 | **Suppression de `Vibe-Method/`** | Le miroir n'a plus d'objet | Faible | ✅ **faite** |
| 7 | **Installateur unique** | `setup.sh` absorbé par `claude-config/install.sh` ; les 3 hooks rejoignent le wiki | Faible | ✅ **faite** |

Ordre imposé : phase 0 d'abord, phase 5 en dernier parmi les déplacements.

---

## 12. Décisions prises le 05/08

- Suffixe doctrines : **`-doc`** (ex. `securite-doc.md`)
- Suffixe recherches : **`-rech`** (ex. `rgpd-fournisseurs-rech.md`)
- `cgv` et `devis` : **restent dans la méthode**
- Hermes recevra les skills Claude Code : **bruit acceptable**, pas de dépôt séparé
- Plugins : **rien à faire**, gérés par Claude Code
- ~~Les deux `rgpd.md` : à fusionner en phase 4~~ — **décision annulée le 05/08**, voir §21
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

---

## 17. Audit de dépendances — ce qui manquait au périmètre (05/08)

Medwin a demandé confirmation que toutes les dépendances étaient anticipées. Audit fait plutôt que réponse rassurante. **Le périmètre couvrait environ deux tiers du réel.** Cinq catégories manquaient.

### Ce qui avait été compté
Références textuelles à `dev/vibe-method`, `CLAUDE.global`, `lint-observabilite`, `Vibe-Method/` — mesurées mais sous-estimées, car la recherche portait sur `vibe-method/` seul et non sur tout `~/dev`.

### Ce qui manquait

**1. Le dépôt `hermes-config` — ~140 skills VPS miroir versionnés localement.** Sept d'entre eux citent le wiki ou la méthode : `research/wiki`, `research/wiki-lint`, `research/batch-crawl-operations`, `devops/debug-cron-jobs`, `productivity/cgv-generation`, `productivity/devis-generation`, `notion-content-extraction`. Bonne nouvelle : ils sont **modifiables depuis le Mac**, pas seulement en SSH. Le miroir Hermes n'est donc pas un angle mort inaccessible.

**2. `lint-wiki.py` code `log.md` en dur** — `INFRA_FILES = {"CLAUDE.md", "index.md", "log.md"}`, ligne 31, utilisé à 5 endroits (248, 301, 322, 435). Le renommage en `journal-log.md` casse le script silencieusement : les exemptions ne s'appliqueraient plus, le journal serait traité comme une fiche de savoir et signalé partout.

**3. D'autres dépôts projet citent la méthode** — `RAMrezo/CLAUDE.md`, `RAM-conference/.claude/settings.local.json`, `plug-in-seo`, `HERMES`.

**4. Les mémoires automatiques** — une dizaine de fichiers de `claude-memoire` citent ces chemins. Elles sont **réécrites par la machine** : les corriger dans `~/.claude/projects/*/memory/`, jamais dans le dépôt de sauvegarde, sous peine d'être écrasées au prochain passage.

**5. La configuration Obsidian** (`wiki/.obsidian/`) — `workspace.json` mémorise les fichiers ouverts. Sans gravité, mais un renommage y laisse une entrée morte.

### Ce qui protège, et qu'il faut préserver

`settings.json` déclare les hooks via `~/.claude/hooks/*`, c'est-à-dire **la couche de liens, pas les chemins réels**. Déplacer un hook d'un dépôt à l'autre ne touche donc pas `settings.json` — seul le lien change. Cette indirection est une protection réelle : ne jamais y écrire un chemin de dépôt en dur.

### La garantie mécanique

Un inventaire écrit vieillit. `scripts/audit-dependances.sh` reproduit les dix contrôles ci-dessus en une commande.

**Règle : lancer l'audit avant chaque phase (état de référence) et après (vérification).** Une phase n'est terminée que quand la sortie « après » ne contient plus que des occurrences volontaires — entrées de carnet, journaux, mention d'un incident passé.

C'est l'application du principe déjà retenu pour `/lint` et pour l'observation 38 : une règle qui dépend de la vigilance devient un contrôle qui n'en dépend pas.

---

## 18. Journal d'exécution — 2026-08-05

Ce que les phases ont réellement produit, pour qu'une session neuve reprenne sans l'historique de conversation.

### Phase 0 — Filet de sécurité ✅

- `firecrawl.md` — seul skill non versionné de la machine — copié dans `claude-config/commands/`, remplacé par un lien. Il était exposé au `ln -sf` de `setup.sh`, motif exact de l'incident du 29/07 sur `grill-me.md`
- Supprimés : `~/dev/handoff.md` (0 octet), `claude-config-backup-20260730` et `-31` (contenu vérifié comme couvert ailleurs), `.DS_Store` de `commands/`
- Contrôle en place : `find ~/.claude/{commands,agents,hooks,skills} -maxdepth 1 -type f` doit ne rien renvoyer

### Phase 1bis — `description` sur toutes les fiches ✅

Insérée **avant** les déplacements, pour que les ~70 fiches à venir arrivent conformes plutôt que d'imposer une seconde passe sur 194 fiches.

- 113 descriptions copiées depuis l'index, 11 réécrites (leur résumé était un titre recopié), 7 rédigées pour des fiches d'Hermes absentes de l'index
- Colonne `Résumé` → `Description` dans 6 tableaux
- `wiki/CLAUDE.md` : champ obligatoire + règles de rédaction + contre-exemples
- `/wiki` et le miroir Hermes `research/wiki/SKILL.md` mis à jour
- `lint-wiki.py` : `description` en champ obligatoire, **et nouvel axe de concordance fiche ↔ index**, étendu ensuite à `sujet` et `tags`

Cet axe a trouvé 12 divergences préexistantes, dont 3 créées le jour même en écrivant des entrées d'index divergentes des fiches. Principe retenu : **la fiche fait foi pour ses propres champs, l'index en est la vue.**

### Phase 1 — Nettoyage de la racine ✅

Fusionnée avec la partie « recherches » de la phase 4 : renommer en `-rech` dans vibe-method pour déplacer ensuite était un état intermédiaire sans intérêt. Une seule référence vivante à corriger (`specs.md` ligne 245).

**Fusions verbatim** (titres décalés d'un niveau, aucune reformulation) :
- `traite-vibe-coding-rech.md` ← 3 fichiers · `rgpd-fournisseurs-rech.md` ← 3 fichiers

**Déplacements** : `cybersecurite-rech`, `apple-hig-react-native-rech`, `apple-appstore-rech`, `claude-design-rech`, `guide-definition-produit-rech`, `audit-doctrine-strategie-rech`

**`workflow-doc.md`** — le guide complet du workflow (427 l., sans aucun formatage markdown) converti mécaniquement et complété des 3 tableaux de `chaine-complete.md`, lequel est supprimé avec son dossier `flux/`. Le guide est plus abouti : partage TOI/CLAUDE, exemple, fichier produit et phrase de sortie pour chaque skill.

**Suppressions justifiées :**
- `bmad-comparaison.md` — conclusions intégrées aux doctrines
- 5 transcriptions Radio Vibe Code
- `prp-doctrine-enrichissement.md` — plan de mai 2026. **Ses 20 règles ont été vérifiées une par une comme présentes dans les doctrines et les skills.** La 20e (« RLS désactivé par défaut ») avait d'abord semblé absente : défaut du motif de recherche, elle est bien dans `securite.md` lignes 139 et 153, formulée dans l'ordre inverse

### Décisions actées le 05/08 (au-delà de celles du §12)

- **`handoff.md` → `handoff-out.md`** pour la sortie du skill. Le skill `.claude/commands/handoff.md` et son produit portaient le même nom, ce qui donnait l'impression qu'un skill était ignoré par git. Skill et `.gitignore` mis à jour
- **Cluster `Vibe-Method`** créé, toujours accompagné de **`Dev`** — un cluster est multiple, et la méthode relève aussi du développement
- **La fiche fait foi** pour `description`, `sujet` et `tags` ; l'index est réaligné sur elle, jamais l'inverse

### État des dépôts en fin de journée

| Dépôt | Dernier commit |
|---|---|
| `wiki` | `e41266b` — 140 fiches, lint entièrement vert |
| `vibe-method` | `ef9df87` — racine réduite à 19 fichiers |
| `claude-config` | `8762bc6` |
| `hermes-config` | `7a833f5` |

### Ce qui reste — phases 2 à 7

Inchangé par rapport au §11. La phase 2 (scission de `CLAUDE.global.md`) est la prochaine, et la première à toucher un fichier chargé dans toutes les sessions : lancer `scripts/audit-dependances.sh` avant et après, les 16 références à `CLAUDE.global` sont le périmètre à vider.

---

## 19. Phase 2 — déplacement de `CLAUDE.global.md` ✅ (05/08/2026)

**Déplacement entier, aucun découpage.** Le §5 avait prévu une scission vers des fiches wiki : erreur corrigée avant exécution, voir §5.

**Ce qui a été fait :**
- `vibe-method/CLAUDE.global.md` (200 l.) fusionné dans `claude-config/CLAUDE.md` (25 l.) → 234 lignes, 12 sections
- La section « Observation des sessions » de claude-config insérée entre « Gestion des modèles » et « Exigence de rigueur » — un seul fichier cohérent, pas deux blocs empilés
- En-tête réécrit : le fichier ne dit plus « chargé dans tous les projets sous `~/dev/` » mais « portée utilisateur, chargé au démarrage de toutes les sessions »
- Lien `~/dev/CLAUDE.md` et fichier `CLAUDE.global.md` supprimés

**Ce que le déplacement gagne :** le contenu passe d'un chargement par héritage d'arborescence (`~/dev` parent du projet) à un chargement de portée utilisateur. Il s'applique désormais partout, y compris hors de `~/dev`.

**6 références corrigées :** `setup.sh` (la ligne qui créait le lien n'a plus d'objet), `claude-config/install.sh`, `vibe-method/CLAUDE.md`, `.claude/commands/archi.md` (citait `CLAUDE.global.md` comme adresse des règles universelles), `.claude/settings.local.json`, `Vibe-Method/CLAUDE.md`.

Plus deux corrections que l'audit n'aurait pas signalées comme urgentes :
- La règle « corollaire du miroir » de `claude-config/CLAUDE.md` citait « `CLAUDE.global.md` et son symlink » comme exemple de paire miroir — la paire n'existe plus, exemple retiré
- Une mémoire automatique (`project_checkpoint_skills.md`) décrivait l'ancienne organisation. Corrigée **dans `~/.claude/projects/*/memory/`**, pas dans `claude-memoire` : le dépôt est une sauvegarde, une correction faite là serait écrasée au prochain passage de l'agent de synchronisation.

**Compteur `CLAUDE.global` : 16 → 12.** Les 12 restantes sont volontaires : journaux, carnet d'observations, notes de migration (« a migré depuis… »), et ce document.

**Point d'attention, non bloquant.** Le fichier fait 234 lignes ; la documentation officielle recommande moins de 200 par `CLAUDE.md` (« longer files consume more context and reduce adherence »). Le mécanisme prévu pour alléger sans rien désactiver est `~/.claude/rules/` — des fichiers thématiques de portée utilisateur, chargés à chaque session comme un `CLAUDE.md`. À envisager plus tard, pas maintenant.

---

## 20. Phase 3 — répartition des skills ✅ (05/08/2026)

**Six skills déplacés** de `vibe-method/.claude/commands/` vers `claude-config/commands/` : `lint`, `wiki`, `caveman`, `pdf`, `slides`, `condense`. `firecrawl` y était depuis la phase 0. Les six liens de `~/.claude/commands/` repointés vers le nouveau dépôt.

Reste dans `vibe-method/.claude/commands/` : **56 fichiers**.

**`task-observer` aplati**, en application du §15. `claude-config/skills/task-observer/SKILL.md` devient `claude-config/commands/task-observer.md` ; `claude-config/skills/` et `~/.claude/skills/` sont supprimés. La forme dossier ne servait à rien — elle n'existe que pour embarquer des fichiers annexes, et il n'en avait aucun.

**`hooks/session-start.sh`** lit désormais `~/.claude/commands/task-observer.md`. Le hook a été relancé après modification et vérifié : il injecte bien le contenu du skill, pas l'avertissement de repli. C'est le seul point de la phase qui pouvait casser silencieusement — le hook a un `except OSError` qui laisse démarrer la session en dégradé.

**`install.sh` boucle sur `commands/*.md`** au lieu de nommer les fichiers. Une liste nommée prend du retard en silence dès qu'un skill est ajouté — le motif est déjà documenté dans `setup.sh` pour les hooks. `--dry` confirme les 8 liens en place, aucune sauvegarde déclenchée.

**Références corrigées :**

| Fichier | Ce qui était faux |
|---|---|
| `wiki/CLAUDE.md` | citait `vibe-method/.claude/commands/lint.md` comme adresse de `/lint` |
| `vibe-method/CLAUDE.md` | `/lint` `/wiki` `/condense` dans la table des skills et la liste des transversaux |
| `claude-config/CLAUDE.md` | situait `task-observer` dans `skills/`, chargé à chaque session |
| `claude-config/README.md` | tableau du dépôt, section `commands/`, règle sur les 4 dossiers d'extension |
| `vibe-method/setup.sh` | inventaire de ce que couvre `claude-config` |
| `vibe-method/.claude/commands/maj.md` | cherchait les skills dans `~/.claude/skills/` |
| `vibe-method/vibe-method.todo.md` | listait `task-observer` et `firecrawl` comme non versionnés — les deux le sont |

**Audit avant/après — les cinq écarts sont tous voulus :** `dev/wiki` 57 → 56 fichiers (`wiki/CLAUDE.md` ne cite plus la méthode), `~/.claude/commands` 63 → 64 liens (`task-observer` rejoint les commandes), `~/.claude/skills` 1 → 0 lien (dossier supprimé), un décalage de ligne dans `session-start.sh`, et `wiki/CLAUDE.md` sort du contrôle 10.

**Ce que la phase referme, au-delà du rangement.** `setup.sh` ne peut plus écraser ces huit skills : sa boucle glob ne balaie que `vibe-method/.claude/commands/`, où ils ne sont plus. Le seul dépôt qui les touche est `claude-config`, dont `install.sh` sauvegarde avant de remplacer. C'est le mode de panne du 29/07/2026 sur `grill-me.md`, fermé par construction et non par vigilance.

---

## 21. Phase 4 — les doctrines deviennent des fiches du vault ✅ (05/08/2026)

Les 12 doctrines quittent `vibe-method/` pour `wiki/<nom>-doc.md`, frontmatter complet et ligne d'index concordante. La racine de vibe-method ne contient plus que `CLAUDE.md`, `setup.sh`, `scripts/`, les trois journaux, ce document et deux résidus (`Vibe-Method/` à supprimer en phase 6, `test-claude-design/`).

**Types attribués :** 10 `Procédure`, 2 `Concept` — `architecture-doc` pose des patterns, `ui-vocabulary-doc` définit un lexique. Le second est net ; `architecture` est mixte, ses titres sont pour moitié des principes et pour moitié du « comment ». Choix assumé, une édition de frontmatter suffirait à le revoir.

### La décision du §12 sur RGPD a été annulée

Le §12 actait « les deux `rgpd.md` : à fusionner ». **Faux, corrigé avant exécution.** Les fichiers ont été ouverts, ce qui n'avait pas été fait quand la décision a été écrite — elle reposait sur la seule identité des noms :

- `wiki/rgpd.md` (9,6 Ko, `type: Concept`) — ce que **dit** le règlement. Champ d'application, acteurs, statistiques CNIL, DPO. Sources : cours AFCDP, manuel Mattatia. Ancre d'un cluster de 13 fiches.
- `rgpd-doc.md` (27 Ko, `type: Procédure`) — ce qu'il faut **coder**. Minimisation, DPA des fournisseurs, transferts hors UE, hooks avec les skills, checklist pré-production.

Le `CLAUDE.md` du wiki tranchait déjà, indépendamment de nous : « **Ne pas fusionner des fiches de types différents — l'atomicité par type est intentionnelle.** » Deux fiches donc, avec renvois croisés sur les quatre sections en recouvrement (bases légales, registre, droits, DPO).

**Le champ qui pouvait casser ça en silence :** `sujet` est le ligament du cluster, pas `cluster`. Vérifié sur les 7 fiches du cluster RGPD — toutes portent `sujet: Rgpd`, avec des `cluster:` variés. `rgpd-doc.md` reçoit donc `sujet: Rgpd` et `cluster: [Vibe-Method, Réglementation]`. Un `sujet: Vibe-Method` aurait paru correct et sorti la doctrine du cluster sans qu'aucune erreur n'apparaisse nulle part.

### Ce que le lint a rattrapé, et qu'aucune relecture n'aurait vu

Les doctrines citaient leurs consœurs en code inline — `` `securite.md` ``. La substitution automatique a donc produit `` `[[securite-doc]]` `` : du code, pas un lien. Obsidian ne l'aurait pas rendu, le graphe serait resté vide, et **les 12 fiches auraient été orphelines et sans lien sortant** — visuellement identiques à des fiches correctement liées. Le lint l'a signalé aussitôt : 10 fiches « ne référence aucune autre page ». 39 liens libérés de leurs backticks.

C'est l'argument de fond pour avoir traité `accessibilite` seule d'abord : le motif défaillant s'est révélé à la deuxième passe, pas à la première — celle-ci avait été écrite à la main, hors backticks.

### Les mentions de skills restent en code inline

Volontaire. Les skills n'entrent dans le vault qu'en phase 5 ; tout `[[deploy]]` posé maintenant serait un nœud fantôme pendant tout l'intervalle. **La phase 5 hérite de ce travail** : convertir les mentions `/skill` des 12 fiches en wikiliens une fois les skills arrivés. `workflow-doc.md` porte déjà 32 de ces nœuds fantômes depuis la phase 1 — ils se fermeront au même moment.

### Références corrigées — 263 au total

| Cible | Forme donnée | Nombre |
|---|---|---|
| 4 fiches `-rech` du wiki | wikiliens `[[X-doc]]` | 190 |
| 16 skills, 2 agents, 1 hook, `lint-observabilite.py` | chemin réel `~/dev/wiki/X-doc.md` | 65 |
| `claude-config/CLAUDE.md` | tableau des doctrines réécrit | portée utilisateur |
| `vibe-method/CLAUDE.md` | arborescence du dépôt réécrite | — |
| 5 entrées du carnet task-observer | pointeurs « skill concerné » | 5 |
| `hermes-config` — `research/wiki`, `medwin-wiki` | chemin réel | 3 |

Les 4 fiches `-rech` sortent au passage de « sans wikiliens sortants » (12 → 8) : leurs 190 mentions en code inline étaient invisibles au graphe.

**Deux substitutions partielles rattrapées à la relecture**, dues à un préfixe de chemin que le motif excluait : `archi.md:411` disait « lis `~/dev/wiki/securite-doc.md` dans le repo vibe-method (`~/dev/vibe-method/securite.md`) » — moitié convertie, moitié périmée, dans la même phrase. Et `devis.md:688`.

`test-claude-design/` examiné : que des artefacts `[projet].design.md` et une recommandation de mai 2026 déjà appliquée. Aucun pointeur mort — rien à corriger, le dossier reste un résidu à trancher.

**Faux positifs écartés :** `bmad-method/` et `teamTask/` sont des dépôts tiers portant leurs propres `architecture.md` et `tests.md`. Côté Hermes, `firecrawl-architecture.md`, `web-dashboard-pty-architecture.md` et `api-design.md` n'ont aucun rapport. Et `[projet].stack.md`, `[projet].design.md`, `[projet].tests.md` sont des artefacts de projet, protégés par le motif de substitution — vérifié après coup.

### Une mémoire automatique devenue fausse

`reference_vibe_method_contrats.md` actait le 20/07 : « `rgpd.md` reste dans vibe-method, pas migré », au motif que le déplacer casserait `/archi` et `/deploy`. Les deux skills ont été repointés dans le même mouvement. Mémoire corrigée **dans `~/.claude/projects/*/memory/`**, jamais dans `claude-memoire`.

Elle nommait aussi une « limite connue : Hermes n'a pas accès à `rgpd.md` ». **La migration la lève** — le wiki est le dépôt partagé Mac ↔ VPS. Bénéfice non anticipé : les 12 doctrines sont désormais lisibles par Hermes.

### Vérification

Le lint du wiki est l'acceptation de cette phase, pas seulement l'audit de dépendances — c'est la première phase qui ajoute des fiches au vault.

| | Avant | Après |
|---|---|---|
| Pages | 140 | 152 |
| Signalements | 221 | 243 |
| Liens cassés | 0 | 0 |
| Concordance fiche ↔ index | ✅ | ✅ |
| Frontmatter complet | ✅ | ✅ |
| Conflits de contenu | 0 | 0 |

Les 11 axes verts le restent. Le delta de 22 tient en trois postes : **+25 liens non réciproques** (136 → 161) — le graphe est plus dense, plus de 230 liens neufs, la plupart à sens unique — **+1 quasi-doublon** `refacto-doc` ↔ `tests-doc` à 68 %, qui reflète le recouvrement TDD réel entre deux doctrines distinctes, et **−4 pages sans liens sortants**.

**Note sur le §18.** Il affirme « lint entièrement vert » en fin de phase 1. L'état mesuré aujourd'hui avant toute modification était de 221 signalements, dont `workflow-doc.md` et `rgpd-fournisseurs-rech.md` orphelins — deux fiches créées en phase 1. Ces signalements sont des `⚠️`, pas des erreurs, et les axes `✅` étaient bien tous verts. « Entièrement vert » désignait donc les axes, pas le compteur. Formulation à ne pas reprendre telle quelle : elle laisse croire à un compteur à zéro.

### Ce qui reste — phases 5 à 7

Inchangé au §11. La phase 5 est la plus lourde et la seule à toucher Hermes : 56 skills et 4 agents convertis en fiches `Procédure`, `hooks/` et `scripts/` en sous-dossiers. Elle referme aussi les 32 nœuds fantômes de `workflow-doc.md` et les mentions de skills laissées en code inline par cette phase.

---

## 22. Phase 5 — les exécutables entrent dans le vault ✅ (05/08/2026)

56 skills et 4 agents quittent `vibe-method/.claude/` pour `~/dev/wiki/`, à plat, en fiches `type: Procédure`. Le vault passe de 152 à 212 fiches. `vibe-method/.claude/commands/` et `agents/` sont supprimés.

### Trois décisions prises avec Medwin avant le lot

**1. Le discriminant de l'installateur.** `setup.sh` bouclait sur `.claude/commands/*.md`. Repointé naïvement sur `wiki/*.md`, il aurait fait de chacune des 212 fiches une commande slash. Trois options étaient sur la table : un champ dédié, une valeur de `cluster`, ou des sous-dossiers `wiki/skills/`. **Medwin a tranché pour le champ dédié** — `claude-code: commande` ou `claude-code: agent`, absent sur une fiche de savoir.

Le champ est lu dans le **premier bloc `---` uniquement**. C'est nécessaire : `wiki/CLAUDE.md` documente ce champ en toutes lettres, et une recherche naïve le prendrait pour un exécutable.

**2. `sujet` et `cluster` deviennent obligatoires.** Décision de Medwin, au-delà du périmètre de la phase. Sept champs requis. Coût mesuré : 5 fiches incomplètes sur 152.

L'obligation a été posée dans `lint-wiki.py`, pas seulement dans la prose. **Ce script est le seul fichier réellement partagé entre Claude Code et Hermes** — il vit dans le dépôt du wiki et arrive par `git pull`. La prose, elle, existe en deux copies : `wiki/CLAUDE.md` et le skill `research/wiki` du VPS, qui intègre volontairement les 14 règles pour rester autonome et dit lui-même que « cette copie fait autorité ». Principe retenu : *une règle qu'on veut voir appliquée des deux côtés se met dans le lint ; la prose ne fait que la documenter.*

À noter : la checklist du skill Hermes exigeait **déjà** `sujet` et `cluster`. C'est le lint et le côté Mac qui étaient plus laxistes. La décision aligne les deux.

**3. Huit clusters plutôt qu'un.** Un `sujet: Vibe-Method` sur 68 fiches aurait produit un cluster où la règle 11 impose à chaque membre de lister les 67 autres. Groupement par phase du workflow : `Skill-Conception` (10), `Skill-Architecture` (6), `Skill-Specification` (5), `Skill-Code` (7), `Skill-Revue` (10), `Skill-Documentation` (10), `Skill-Transversal` (8), `Agent-Revue` (4).

### L'ordre imposé : renommer le journal avant tout

`wiki/log.md` — le journal du vault — et le skill `/log` portent le même nom. **Un `ln -sf`, un `cp` ou un `mv` aurait détruit le journal sans un mot.** Renommé `journal-log.md` **avant** toute arrivée de skill, avec `INFRA_FILES` de `lint-wiki.py` mis à jour dans le même geste : ce jeu exempte les fichiers d'infrastructure de frontmatter, d'index et du contrôle d'orphelines, et un nom périmé là les aurait fait remonter sur trois axes à la fois. Vérifié après renommage et avant tout déplacement : `journal-log.md` n'apparaît sur aucun axe.

49 références corrigées hors du vault — 9 skills Hermes, `/lint`, `/regles`, `/stack`, `/debug`, `claude-config/CLAUDE.md`. `~/.hermes/observations/log.md` et les `experiment_log.md` n'ont pas bougé : ce sont d'autres fichiers.

**Effet de bord, et c'est une amélioration :** `[[log.md]]` cité par `workflow-doc.md` apparaît désormais comme nœud fantôme. Il visait le skill `/log`, pas le journal — l'exemption `INFRA_FILES` le masquait par coïncidence de nom. Il s'est fermé quand les skills sont arrivés.

### Le piège de fusion, différent de celui de la phase 4

Les skills portaient **déjà** un frontmatter : `description`, `allowed-tools`, `model`, `tools`, `name`. Le motif de la phase 4 — préfixer un bloc `---` — aurait fait du bloc ajouté le frontmatter et du bloc d'origine du **corps de texte**. `allowed-tools` aurait cessé de s'appliquer, sans erreur, le skill continuant de se charger, d'apparaître dans la liste et de tourner : avec ses restrictions d'outils envolées. Même famille que l'observation 43 — sortie valide, sémantique morte.

Les champs ont donc été insérés **dans** le bloc existant, avec un contrôle après écriture qu'aucune clé d'origine n'ait disparu.

**Un frontmatter invalide découvert au passage :** `diagnostic-serveur.md` portait une description non quotée contenant ` : `. YAML strict la refuse, Claude Code la tolérait, `lint-wiki.py` aussi (parseur maison). Le quotage systématique l'a corrigée. C'est l'argument concret de la règle « guillemets obligatoires » du vault : elle protège d'un fichier que seuls les parseurs stricts rejettent, donc d'une panne qui n'arrive que plus tard et ailleurs.

**Une divergence rattrapée par le lint :** la fusion remplace les guillemets internes de la description par des apostrophes, mais renvoyait la description d'origine pour la ligne d'index. Trois agents en contenaient. L'axe de concordance les a signalés immédiatement.

### Le graphe

| | Avant | Après |
|---|---|---|
| Pages | 152 | 212 |
| Signalements | 243 | 337 |
| Nœuds fantômes | 33 | **2** |
| Orphelines | 17 | **17** |
| Liens cassés | 0 | 0 |
| Concordance fiche ↔ index | ✅ | ✅ |

**Les 31 nœuds fantômes de `workflow-doc.md` se sont fermés seuls.** Ils visaient les skills depuis la phase 1 — le suffixe `-doc` des doctrines les en avait tenus séparés, comme prévu. Aucune édition n'a été nécessaire.

**Orphelines inchangées à 17** : aucune des 60 fiches neuves n'est isolée. C'est l'effet des 60 sections « Fiches liées » et des 86 mentions `/skill` converties en `[[nom|/nom]]` dans les doctrines — première occurrence par doctrine seulement, les 159 auraient fait de `methode-doc` une ferme à liens sans rien ajouter au graphe.

Le delta de 94 est presque entièrement des liens non réciproques (161 → 278), conséquence mécanique de plus de 500 liens neufs.

### `setup.sh` réécrit

Il n'énumère plus un dossier, il interroge le frontmatter. Et il **sauvegarde avant de remplacer** — un fichier réel part sous `.remplace-<horodatage>`, comportement repris de `claude-config/install.sh`. La version précédente utilisait `ln -sf`, qui a coûté `grill-me.md` le 29/07/2026. Le mode de panne est fermé des deux côtés ; la fusion des deux installateurs en un point d'entrée unique reste la phase 7.

**Nouveau contrôle 11 dans `audit-dependances.sh`** : fiches portant `claude-code:` ↔ liens posés, plus la détection des liens pendants. C'est l'invariant que la phase introduit, et ses deux modes de panne sont silencieux — une fiche qui perd le champ voit sa commande disparaître, une fiche renommée laisse un lien mort. Sortie actuelle : 56/56, 4/4, 0 lien cassé.

### Trois vérifications faites après coup, deux ont trouvé quelque chose

**Les collisions de nom avec `claude-config`.** Le contrôle initial comparait les 56 skills de la méthode aux fiches du wiki et avait trouvé `log.md`. Il ne comparait pas les 8 skills de `claude-config` — or les deux installateurs écrivent dans `~/.claude/commands/`, et un nom partagé donne « le dernier lancé gagne », en silence. Vérifié : aucune collision.

**`/maj` envoyait vers un dépôt qui n'a plus les skills.** C'est le plus grave, il tourne à chaque clôture. Il disait de chercher un skill dans `vibe-method/.claude/commands/`, et ne lançait le lint wiki que « si le répertoire courant est `vibe-method/` ». Or une session ouverte sur n'importe quel projet qui modifie un skill modifie désormais le wiki : la condition portait sur le mauvais fait. Son étape 5 décrivait en plus des contrôles de fraîcheur (`source_modified`, `wiki_updated`) hérités du miroir `Vibe-Method/` supprimé — remplacés par l'exécution du lint réel. `/charte` et `/design` disaient « `~/dev/wiki/ui-vocabulary-doc.md` dans vibe-method », phrase devenue contradictoire.

Ces trois-là ont échappé aux substitutions des phases 4 et 5, qui portaient sur des **noms de fichier**. Une phrase qui dit *où vivent les skills* ne contient aucun nom de fichier — elle est invisible à un `grep` de chemin.

**`workflow-doc.md` a du retard.** `vibe-method/CLAUDE.md` affirmait « la chaîne complète du workflow est dans `wiki/workflow-doc.md` » — écrit dans le même mouvement qui en retirait la table des 56 skills. Vérifié : le guide date du 11/06 et ne couvre ni `deploy` ni `init-projet`, tout en documentant encore `/condense`, sorti de la méthode le 05/08. L'affirmation est corrigée et le retard signalé — c'est désormais le seul endroit où vit l'ordre des skills.

### Ce qui reste — phases 6 et 7

- **Phase 6** : supprimer `Vibe-Method/`. Le miroir n'a plus d'objet — ses sources n'existent plus.
- **Phase 7** : fusionner `setup.sh` et `claude-config/install.sh` en un installateur unique.

Deux points hors phases : `test-claude-design/` (résidu à trancher) et la propagation de `hermes-config` vers le `/opt/data/skills/` du VPS, dont le mécanisme n'est pas établi.

---

## 23. Phase 6 — suppression du miroir ✅ (05/08/2026)

83 fichiers, 404 Ko. `Vibe-Method/` produisait un résumé par fichier source ; les sources vivent désormais dans le vault, il n'avait plus d'objet.

**Ce qui a été vérifié avant de supprimer.** 79 de ses fichiers étaient des résumés dérivés — 56 skills, 12 doctrines, 4 agents, plus les flux. Restaient 4 fichiers qui n'étaient dérivés de rien d'évident, ouverts un par un :

| Fichier | Verdict |
|---|---|
| `_vue-ensemble.md` | Version condensée de `methode-doc.md`. Posture (chef d'orchestre, touriste, ingénieur fantôme), 7 phases en 3 temps, greenfield/brownfield : tout présent dans `methode-doc`, en plus développé. La chaîne de skills est dans `workflow-doc`. Les « 5 garde-fous » ne sont que 5 renvois vers des skills |
| `skills/prp-skill.md` | Page de concept sur le PRP. Son « test de suffisance » en 4 questions est dans `prp.md` sous le nom « test de simulation » |
| `index.md` | Catalogue du miroir, remplacé par celui du vault |
| `log.md` | Journal des synchronisations du miroir lui-même. Sans objet une fois le miroir parti |

Supprimé par `git rm`, donc récupérable dans l'historique. Le dossier `.obsidian/` n'était pas versionné : son unique favori était une recherche par tag, et le vrai vault Obsidian est `wiki/.obsidian`.

**Une seule référence vivante restait**, et elle était dans une règle : le « corollaire du miroir » de `claude-config/CLAUDE.md` citait `Vibe-Method/` comme exemple de paire miroir. Remplacé par un exemple qui existe encore — les règles du vault, écrites dans `wiki/CLAUDE.md` **et** recopiées dans le skill `research/wiki` du VPS, lequel déclare que sa copie fait autorité. Même geste qu'en phase 2, où l'exemple était `CLAUDE.global.md`. Une règle illustrée par un exemple périmé garde l'air juste et perd sa prise.

Toutes les autres mentions de `Vibe-Method/` sont des journaux ou ce document.

### Deux questions du todo closes au passage

**« Faut-il conserver le wiki `Vibe-Method/` ? »** — ouverte le 27/07. Elle posait trois destins : conserver, fusionner, supprimer. Elle a été tranchée **par une reformulation du problème**, pas par un choix entre les trois : le miroir existait pour produire des résumés, et un résumé décroche. Migrer les sources supprime le besoin au lieu de le gérer. C'est le §2 de ce document.

**« L'infrastructure n'ira jamais dans un wiki »** — écrit le 29/07 dans un tableau du todo. Faux. L'affirmation reposait sur l'hypothèse qu'un exécutable ne peut pas être une fiche ; le test du 05/08 a montré que Claude Code ignore les champs de frontmatter inconnus. L'hypothèse n'avait jamais été vérifiée et a tenu deux semaines comme un fait, dans un tableau — même lieu et même mode que l'observation 40. Ce qui reste vrai de l'intuition : un exécutable a des contraintes qu'une fiche n'a pas. D'où le champ `claude-code:`, qui les distingue sans les séparer.

### État des dépôts

| Dépôt | Contenu |
|---|---|
| `wiki` | 212 fiches — 56 skills, 4 agents, 12 doctrines, le reste en savoir. `scripts/` : lint-wiki, lint-observabilite et son test |
| `vibe-method` | `CLAUDE.md`, `setup.sh`, `scripts/audit-dependances.sh`, 3 hooks, les journaux, ce document, `test-claude-design/` |
| `claude-config` | `CLAUDE.md` (portée utilisateur), 8 skills hors méthode, hooks, carnet d'observations, `install.sh` |
| `hermes-config` | miroirs VPS, dont `research/wiki` v1.7.0 |

### Reste la phase 7

Fusionner `setup.sh` et `claude-config/install.sh` en un installateur unique. Les deux visent `~/.claude/hooks/` et sauvegardent désormais avant de remplacer, donc le danger est éteint — reste la duplication.

Deux points hors phases : `test-claude-design/` (résidu à trancher) et la propagation de `hermes-config` vers le `/opt/data/skills/` du VPS, dont le mécanisme n'est toujours pas établi.

---

## 24. Phase 7 — l'installateur unique ✅ (05/08/2026)

`vibe-method/setup.sh` est supprimé. `claude-config/install.sh` est le point d'entrée unique : il lit **deux dépôts** et recrée tout `~/.claude`.

**Le défaut que la fusion referme** était documenté dans `setup.sh` lui-même : « `claude-config/install.sh` vise aussi `~/.claude/hooks/`, comme la boucle ci-dessus. Le dernier script lancé gagne, sans avertissement. » Deux scripts qui écrivent au même endroit sans se connaître, et un commentaire qui prévient au lieu d'empêcher.

| Source | Ce qu'il en tire | Comment il le reconnaît |
|---|---|---|
| `~/dev/wiki` | 56 skills, 4 agents | champ `claude-code:` du frontmatter |
| `~/dev/wiki/hooks/` | 2 hooks de la méthode | glob, moins la liste des archivés |
| `~/dev/claude-config` | `CLAUDE.md`, réglages, 8 skills, 3 hooks, `observations/` | glob et liste courte |

**Les 3 hooks de la méthode ont rejoint le wiki**, ce que le §3 prévoyait et que la phase 5 avait oublié. `stop-cloture.sh` rappelle `/maj`, `track-repo.sh` l'alimente : un hook vit avec ce qu'il sert, et `/maj` est dans le vault depuis la phase 5. `hooks/` ne contient aucun `.md`, Obsidian l'ignore, le vault reste plat.

`.claude/` de vibe-method n'a plus que `settings.local.json`.

**Vérifications :** `--dry` puis exécution puis relance. Second passage : **0 posé, 78 inchangés, 0 sauvegarde** — idempotent. 78 = 56 skills + 4 agents + 2 hooks de méthode + 8 skills hors méthode + 3 hooks personnels + 5 entrées de configuration. Les deux hooks déplacés ont été testés en entrée réelle (code de sortie 0), et le contrôle de liens cassés a été observé dans ses deux états : il a signalé les 2 liens rompus par le déplacement avant l'exécution, puis 0 après.

Le script se termine sur deux contrôles qu'il portait chacun séparément avant : aucun fichier réel dans les dossiers d'extension, aucun lien cassé.

---

## 25. La question de la propagation vers Hermes — tranchée

Portée sans réponse dans les journaux des phases 4, 5 et 6. Résolue en ouvrant les scripts de `hermes-config`.

**`hermes-config` est un dépôt de sauvegarde, pas de déploiement.** `sauvegarde.sh` va **instances → dépôt** : il capture l'état réel des deux Hermes avant un commit. Pousser sur GitHub n'atteint donc **pas** le VPS.

Le sens inverse existe et est explicite : `restaure-skills.sh vps` copie **dépôt → instance**, par `scp` vers `root@31.97.199.170`, cible `/docker/hermes-agent-8b0z/data/skills`. Par copie et non par lien, avec sauvegarde préalable de tout skill existant — 138 skills sur 190 sont versionnés, un lien de dossier écraserait les 52 autres.

**Conséquence, et c'est un risque ouvert :** les modifications faites pendant ce chantier — `research/wiki` passé en v1.7.0, les 49 renommages `log.md` → `journal-log.md` dans 9 skills — sont dans le dépôt et **pas sur le VPS**. Hermes tourne encore sur la version qui journalise dans `/opt/data/wiki/log.md`. Ce fichier n'existe plus : il le **recréerait**, et le journal du vault se retrouverait scindé en deux.

La commande est connue, l'exécution appartient à Medwin — elle écrit sur une machine de production par SSH.
