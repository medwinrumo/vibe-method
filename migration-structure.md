# Stratégie de réorganisation — skills, doctrines, dépôts

**Version 7 — 2026-08-05.**
Phases 0, 1, 1bis, 2 et 3 **faites**. Phases 4 à 7 en attente.
Aucune décision bloquante. Ce document est le point de reprise : une session
neuve peut continuer à partir de lui seul, sans l'historique de conversation.

---

## 0. Reprendre ce chantier dans une session neuve

Tout est commité et poussé. Ce document suffit à continuer — l'historique de conversation n'est pas nécessaire.

**Pour reprendre :**

1. `cd ~/dev/vibe-method && git pull` puis lire ce fichier en entier
2. `bash scripts/audit-dependances.sh` — état de référence avant toute modification
3. Prochaine phase : **4** (§11). Les phases 0, 1, 1bis, 2 et 3 sont faites, leur journal est aux §18, §19 et §20
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
