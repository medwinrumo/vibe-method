# Stratégie de réorganisation — skills, doctrines, dépôts

**Version 2 — 2026-08-05**, après retours de Medwin.
Phase 0 en cours d'exécution ; les phases 1 à 7 attendent validation.

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

**Aucun dossier masqué dans le wiki.** Tout est visible dans Obsidian — c'était l'incohérence de la version 1, qui rangeait les skills dans un `.claude/` invisible tout en prétendant les rendre navigables.

```
~/dev/wiki/                      ← dépôt GitHub, partagé Mac ↔ VPS Hermes
├── CLAUDE.md  index.md  log.md  ← infrastructure du vault (déjà exemptés de frontmatter)
│
├── <fiches de savoir>.md        ← vault plat, existant
├── doc-*.md                     ← 12 doctrines migrées (préfixe validé)
├── rec-*.md                     ← recherches et extractions (préfixe validé)
│
├── skills/                      ← VISIBLE. 55 skills de la méthode
├── agents/                      ← VISIBLE. 4 personas
├── hooks/                       ← shell — Obsidian ignore les non-.md
└── scripts/                     ← existe déjà (lint-wiki.py), reçoit lint-observabilite.py

~/dev/claude-config/             ← dépôt privé : personnel, non transposable
├── CLAUDE.md                    ← instructions globales (+ le personnel de CLAUDE.global.md)
├── settings.json  install.sh
├── commands/                    ← 7 skills hors méthode
├── hooks/                       ← session-start, stop-cavecrew, track-agent-usage
├── skills/task-observer/
└── observations/

~/.claude/                       ← les 4 dossiers d'extension ne contiennent QUE des liens
├── commands/ → wiki/skills/*.md  +  claude-config/commands/*.md
├── agents/   → wiki/agents/*.md
├── hooks/    → les deux dépôts
└── skills/   → claude-config/skills/
```

Claude Code lit `~/.claude/commands/<nom>.md` ; **le chemin de la cible du lien lui est indifférent**. Un skill peut donc vivre dans `wiki/skills/` et rester invocable par `/deploy`.

### La règle sur `~/.claude`, énoncée correctement

La version 1 disait « que des liens », ce qui est faux. Vérifié le 05/08 :

| Zone | Nature | Règle |
|---|---|---|
| `commands/` `agents/` `hooks/` `skills/` | dossiers d'extension | **Que des liens.** Un fichier réel y est un bug |
| `MEMORY.md` | mémoire globale | Sauvegardée par `claude-memoire` |
| `mcp.json` | secrets | Hors git volontairement, gabarit dans `claude-config` |
| `plugins/` (502 Mo) `projects/` (76 Mo) `cache/` `sessions/` `telemetry/`… | état d'exécution | Géré par Claude Code, régénérable, ne rien y faire |

Violations actuelles : `firecrawl.md` et `.DS_Store` dans `commands/`.

### Frontmatter : skills et agents exemptés

Question posée par Medwin, et elle est décisive. Constat : **4 skills sur 62 ont un frontmatter** (`description`, `allowed-tools`) ; les 58 autres n'en ont aucun.

Leur imposer le frontmatter du vault (`type`, `tags`, `created`, `updated`, `sources`) modifierait 58 fichiers exécutables pour un gain de catalogage, avec un risque non testé côté Claude Code.

**Décision : `skills/` et `agents/` sont exemptés de frontmatter**, au même titre que `CLAUDE.md`, `index.md` et `log.md` le sont déjà. Un skill est un exécutable qui se trouve être en markdown, pas une fiche de savoir. `scripts/lint-wiki.py` doit exclure ces deux dossiers.

Les **doctrines**, elles, prennent le frontmatter complet : ce sont bien du savoir.

### Où va chaque chose — réponse à la question de Medwin

| Contenu actuel | Destination | Forme |
|---|---|---|
| 12 doctrines | racine du vault, `doc-*.md` | fiche complète, frontmatter |
| `flux/chaine-complete.md` | racine, `doc-chaine-complete.md` | fiche — c'est du savoir de navigation |
| 62 skills | `wiki/skills/` | fichier exécutable inchangé, exempté |
| 4 agents | `wiki/agents/` | idem |
| 2 hooks de méthode | `wiki/hooks/` | shell |
| 2 scripts | `wiki/scripts/` | python, rejoint `lint-wiki.py` |
| Recherches, extractions, références | racine, `rec-*.md` | fiche `type: Source` |
| `Vibe-Method/` en entier | **supprimé** | — |
| `_vue-ensemble.md` `index.md` du miroir | fusionnés dans `index.md` du wiki | — |

**Wikiliens :** `skills/` et `agents/` étant des sous-dossiers, les liens s'écrivent en chemin explicite (`[[skills/deploy]]`), comme le fait déjà le miroir. Nécessaire pour éviter l'ambiguïté — il existe un `log.md` skill et un `log.md` journal du wiki.

**Amendement à acter dans `wiki/CLAUDE.md` :** le vault cesse d'être strictement plat. Quatre sous-dossiers d'exécutables s'ajoutent aux fichiers de savoir, qui restent plats entre eux.

---

## 4. Répartition des skills

### Restent dans la méthode → `wiki/skills/` (55)

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
| Exigence de rigueur professionnelle | **Doctrine** → `doc-rigueur.md` dans le wiki |
| Règles de sécurité non négociables | Déjà dans `securite.md` → remplacer par un renvoi |
| Écosystème de projets (Minou, makeRag) | `claude-config/CLAUDE.md` |
| Commandes de session, artefacts par projet, clôture | Méthode → `doc-methode.md` |

**Attention au doublon** : `claude-config/CLAUDE.md` existe déjà avec une section « Observation des sessions ». La fusion doit produire un seul fichier cohérent, pas deux blocs empilés.

---

## 6. Fichiers de la racine de `vibe-method`

### Supprimés le 05/08 (Corbeille, récupérables)
`## CONDITIONS GÉNÉRALES DE VENTE.md` · `devisType.pdf` · `traite-vibe-coding-eclaire.epub`

### Deviennent des fiches `rec-*`

| Actuel | Devient |
|---|---|
| `cybersecurite-recherche.md` | `rec-cybersecurite.md` |
| `rgpd-research-2026-05-21.md` + `Checklist-RGPD-en-10-points.md` + `Checklist Vercel vs RGPD.md` | `rec-rgpd-fournisseurs.md` (fusion des trois) |
| `apports-traite-vibe-coding.md` + `resume-traite-vibe-coding.md` + `bilan-integration-traite.md` | `rec-traite-vibe-coding.md` (fusion des trois) |
| `apple-hig-react-native.md` | `rec-apple-hig-react-native.md` |
| `appstore.md` | `rec-apple-appstore.md` |
| `claude-design.md` | `rec-claude-design.md` |
| `guide-definition-produit.md` | `rec-guide-definition-produit.md` |
| `audit-doctrine-strategie.md` | `rec-audit-doctrine-strategie.md` |

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
| 1 | **Nettoyage racine** | Fusions et renommages `rec-*`, suppression de `bmad-comparaison.md` | Faible | à valider |
| 2 | **Scission `CLAUDE.global.md`** | Séparer doctrine et personnel, fusionner sans doublon, 11 références | Moyen | à valider |
| 3 | **Répartition des skills** | 7 skills → `claude-config/commands/`, liens refaits | Moyen | à valider |
| 4 | **Doctrines → wiki** | 12 fiches `doc-*`, fusion des deux `rgpd.md` | Moyen | à valider |
| 5 | **Exécutable → wiki** | `skills/` `agents/` `hooks/` `scripts/`, chemins en dur | **Élevé** — touche Hermes | à valider |
| 6 | **Suppression de `Vibe-Method/`** | Le miroir n'a plus d'objet | Faible | à valider |
| 7 | **Installateur unique** | Fusion `setup.sh` + `install.sh` | Faible | à valider |

Ordre imposé : phase 0 d'abord, phase 5 en dernier parmi les déplacements.

---

## 12. Décisions prises le 05/08

- Préfixe doctrines : **`doc-`**
- Préfixe recherches : **`rec-`**
- `cgv` et `devis` : **restent dans la méthode**
- Hermes recevra les skills Claude Code : **bruit acceptable**, pas de dépôt séparé
- Plugins : **rien à faire**, gérés par Claude Code
- Les deux `rgpd.md` (wiki et vibe-method) : **à fusionner** en phase 4
- Suffixe `-gh` : **écarté**, voir §10

## 13. À reprendre plus tard, hors structure

1. **`test_lint_observabilite.py`** — ses cas E-H étaient *tous fail-open* avant correction : le lint laissait passer sans rien dire. Même mode de panne que l'observation 36. À réexaminer une fois la structure stable.
2. **Sauvegarde mémoire en retard de deux jours** — `com.medwinrumo.sync-memory` est chargé, annonce un intervalle de 15 min, son fichier de log n'existe pas, et le fichier écrit le 05/08 au matin n'était pas sauvegardé deux heures plus tard. Cause à établir.
