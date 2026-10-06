# Contradictions d'ordre dans la vibe-method — mesure du 06/10/2026

**Statut : constat. Rien n'a été modifié.** Aucun skill, aucune doctrine. Medwin tranche, une décision à la fois.

État lu : dépôt `~/dev/wiki`, commit `bc88ae5` (06/10/2026), arbre propre au moment de la mesure.

## Ce qui a été comparé

Trois endroits disent quelle étape vient après une autre :

1. **Le graphe** — le champ `apres` de l'en-tête de chaque skill. Le lint en déduit la chaîne de 50 étapes et la juge cohérente.
2. **Le texte du skill** — sa section `## Prochaine étape`, et les phrases du type « tu peux passer à… ».
3. **`workflow-doc.md`** — la ligne « Fin : prochaine étape… » de chaque skill.

Le lint ne contrôle que le premier, plus un bloc généré dans `methode-doc.md` et `workflow-doc.md`. Un agent qui exécute un skill lit le deuxième.

**Méthode.** Script `scripts/mesure-ordre-prose.py` (dans ce dépôt, lecture seule sur le wiki) : il relève les affirmations d'ordre dans 59 skills et 12 doctrines, et les classe contre le graphe. 150 affirmations relevées. Les 20 inversions candidates, les 22 annonces d'étape suivante qui sautent des étapes et les 45 sections `## Prochaine étape` ont été lues une par une.

## Chaîne selon le graphe

`/init-projet` → `/contexte` → `/brief` → `/angles-morts` (brief) → `/devis` → `/cgv` → `/charte` → `/prd` → `/prd-update` → `/prd-validate` → `/angles-morts` (PRD) → `/securite` (analyse) → `/gherkin` (Mode PRD) → `/design` (Mode A) → `/archi` → `/angles-morts` (archi) → `/stack` → `/setup` → `/design` (Mode B) → `/regles` → `/backup` (dispositif) → `/roadmap` → `/specs` → `/angles-morts` (spec) → `/gherkin` (Mode Specs) → `/prp` → `/to-issues` → `/avancement` (init) → `/readyTo-code` → `/sessionCode` → `/tests` (TDD) → code → `/code-review` → `/code-review-edge-cases` → `/repair-edge-cases` → `/code-review-hostil` → `/tests` (Standard) → `/securite` (check) → `/doc-tech` (Mode B) → `/recette` → `/debug` → `/diagnose` → `/commit` → `/pr` → `/phase-retrospective` (Léger) → `/doc-tech` (Mode A) → `/phase-retrospective` (Complet) → `/backup` (vérification) → `/securite` (audit) → `/deploy`

## A — Dix contradictions franches

Le texte envoie vers une étape que le graphe place ailleurs.

| # | Après… | Le graphe dit | Le skill dit | `workflow-doc.md` dit |
|---|---|---|---|---|
| 1 | `/regles` | `/backup` (dispositif) | `/stack` — `regles.md:176`. Le même fichier dit ligne 38 : « après `/setup` et `/design` Mode B, avant `/backup` et `/roadmap` » | `/stack` — ligne 197 |
| 2 | `/stack` | `/setup` | `/roadmap` — `stack.md:487` | `/roadmap` — ligne 205 |
| 3 | `/archi`, puis `/angles-morts` sur l'archi | `/stack` | `/regles` — `archi.md:771`, `angles-morts.md:489` | `/regles` — ligne 189 |
| 4 | `/design` Mode B | `/regles` | `/roadmap` — `design.md:543`, et lignes 497 et 511. `setup.md:282` dit au contraire « `/design` Mode B, puis `/regles` » | `/roadmap` — ligne 180 |
| 5 | `/charte` | `/prd` | `/design` Mode A — `charte.md:225` | `/design` Mode A — ligne 122 |
| 6 | `/gherkin` Mode PRD | `/design` Mode A | `/archi` — `gherkin.md:124` et `:238` | `/archi` — ligne 167 |
| 7 | `/gherkin` Mode Specs | `/prp` (et `/to-issues`) | deux réponses : `/sessionCode` — `gherkin.md:225` ; `/readyTo-code` — `gherkin.md:238` | `/readyTo-code` — ligne 231 |
| 8 | toutes les specs prêtes | `/prp` → `/avancement` → `/readyTo-code` ; `/setup` est bien plus haut, après `/stack` | « → `/readyTo-code` → `/setup` → `/prp` » — `specs.md:349` | — |
| 9 | `/angles-morts` sur le PRD | `/securite` (analyse), puis `/gherkin` Mode PRD | `/archi` — `angles-morts.md:488`. `prd-validate.md:132` dit : `/angles-morts` → `/gherkin` Mode PRD → `/archi` | « avant de passer en architecture » — ligne 146 |
| 10 | `/phase-retrospective` | `/doc-tech` Mode A vient après le mode **Léger**, pas après le Complet | « Mode Complet : `/doc-tech` Mode A » — `phase-retrospective.md:316` | — |

Les contradictions 1 à 4 forment un seul bloc : le texte porte un ancien ordre du tronçon architecture → roadmap, le graphe en porte un autre.

| | Ordre |
|---|---|
| Texte des skills et de `workflow-doc` | `/archi` → `/angles-morts` → `/regles` → `/stack` → `/roadmap` ; et `/design` Mode B → `/roadmap` |
| Graphe | `/archi` → `/angles-morts` → `/stack` → `/setup` → `/design` Mode B → `/regles` → `/backup` (dispositif) → `/roadmap` |

**Hypothèse sur l'origine, non vérifiée dans l'historique Git :** le graphe a été réordonné vers le 20/08/2026 et les textes n'ont pas tous suivi. Indices : `setup.md:32` porte « Déplacé le 20/08/2026 » ; le rapport `ordre-chaine-vibe-method.md` de ce dossier notait déjà, ligne 462, « seul le renvoi "Prochaine étape → `/stack`" est à corriger » pour `/regles` — il ne l'est pas. Ce qui la réfuterait : `git log -p` sur le champ `apres` de `regles.md`, `stack.md`, `setup.md` et sur leur section `## Prochaine étape`.

Pour 5 et 6, rien n'indique lequel du graphe ou du texte porte la bonne décision.

## B — Étapes sautées

Le texte renvoie plus loin dans le bon sens, en omettant des étapes du graphe.

| Où | Ce que dit le texte | Étapes du graphe omises |
|---|---|---|
| `brief.md:595`, `angles-morts.md:487`, `devis.md:703`, `workflow-doc.md:114` | après le brief ou les CGV : `/prd` | `/charte`. Aucun texte n'envoie vers `/charte` ; `cgv.md:199` ne nomme aucune suite |
| `prp.md:250` | `/avancement`, puis `/sessionCode` | `/readyTo-code` |
| `to-issues.md:119` | `/sessionCode` | `/avancement`, `/readyTo-code`. Dans le graphe, rien ne suit `/to-issues` |
| `sessionCode.md:187` | `/code-review` → `/code-review-edge-cases` → `/repair-edge-cases` → `/tests` → `/doc-tech` B → `/recette` | `/code-review-hostil`, `/securite` (check) |
| `tests.md:301` | `/doc-tech` Mode B | `/securite` (check). Le texte ne distingue pas le mode TDD, que le graphe place avant le code |
| `doc-tech.md:203` | Mode A : « merge dans `main` » | `/backup` (vérification), `/securite` (audit), `/deploy` |
| `workflow-doc.md:468` | après `/backup` : `/deploy` | `/securite` (audit) |
| `recette.md:239` | phase validée : `/phase-retrospective` Léger | `/commit`, `/pr` |

## C — Limites du graphe lui-même

- **Il ne sait pas dire « si ».** `/debug` et `/diagnose` y figurent comme des étapes obligatoires entre `/recette` et `/commit`, alors qu'elles n'ont lieu qu'en cas de bug. Les retours en arrière (`/prd-validate` → `/prd-update` si blocage) n'y sont pas.
- **Il ne sait pas dire « à chaque feature » ou « à chaque phase ».** `pr.md:108` renvoie vers `/sessionCode` pour la feature suivante, `phase-retrospective.md:316` vers `/specs` pour la phase suivante. Le graphe est une ligne.
- **`/to-issues` est une impasse** : il suit `/gherkin` Mode Specs en parallèle de `/prp`, et rien ne le suit.

## Écarté après lecture

- 10 des 20 lignes d'inversion candidates étaient des erreurs de lecture du script : la phrase « avant `/x` » avait été comprise à l'envers. Les textes concernés concordent avec le graphe (`backup.md:50`, `readyTo-code.md:39`, `regles.md:38`, `setup.md:32`, `to-issues.md:29`, `prd.md:498`, `workflow-doc.md:235`).
- 7 lignes, sur cinq endroits, sont des retours en arrière légitimes en cas de blocage (`prd-validate.md:38` et `:102`, `gherkin.md:121`, `workflow-doc.md:146`, `archi.md:704`).
- `init-projet.md:77` est un commentaire listant les skills qui écrivent une section du `CLAUDE.md` d'un projet, pas une séquence — déjà jugé ainsi le 14/08/2026.
- Les 2 lignes restantes sont réelles et figurent au tableau A : `specs.md:349` (n° 8) et `workflow-doc.md:197` (n° 1). Les huit autres contradictions du tableau A ne viennent pas de cette liste : elles ont été trouvées en lisant les sections « Prochaine étape ».

## Ce que la mesure ne couvre pas

- Une contradiction formulée autrement que par une section « Prochaine étape », une flèche ou « passer à » n'est pas vue.
- 53 flèches classées « raccourci » (dont 13 dans `workflow-doc.md`, 10 dans `angles-morts.md`, 7 dans `gherkin.md`, 6 dans `doc-tech.md`) n'ont pas été relues une par une.
- Non lus : `~/.claude/CLAUDE.md`, les `CLAUDE.md` de projets, les trois cartes Canvas, les 4 agents.
- `vibe-method/CLAUDE.md` a été lu après la mesure. Il affirme que `wiki/workflow-doc.md` est « le seul endroit où vit désormais l'ordre des skills ». C'est devenu inexact : l'ordre vit dans le champ `apres` des skills, et les lignes « Fin : prochaine étape » de `workflow-doc.md` le contredisent sur sept points du tableau A (1 à 7). Il annonce aussi 56 skills ; le wiki en compte 59.
- Les sections de `workflow-doc.md` entre les lignes 239 et 413 (de `/prp` à `/recette`) n'emploient pas la formule « Fin : prochaine étape » ; leur suite n'a pas été extraite.

## Pour suivre la correction

Relancer après chaque correction ; les nombres doivent baisser :

```bash
cd ~/dev/wiki && python3 ~/dev/vibe-method/scripts/mesure-ordre-prose.py /tmp/ordre.tsv
```

Sortie du 06/10/2026 : 150 affirmations — 45 concordantes, 75 raccourcis, 20 inversions candidates, 10 hors chaîne.
