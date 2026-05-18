# vibe-method.peda — Journal pédagogique

---

## Jour 1 — 2026-05-18 — Enrichissement méthode + refactoring Notion

### Session 1 — Intégration skills externes + suppression complète de Notion

#### Ce qu'on a fait et pourquoi

**Évaluation de skills externes**

Trois skills analysés pour intégration dans la méthode :

- **to-prd** : contenait un "Quality Gate" — point de contrôle obligatoire avant de passer à l'étape suivante. Concept intégré dans `/prd` : une section optionnelle "Décisions techniques initiales" dans la gate de validation (étape 5b). L'idée : si des décisions techniques évidentes émergent pendant le PRD (ex : "on sait déjà qu'on utilisera Supabase"), les capturer immédiatement plutôt que de les perdre jusqu'au `/archi`.

- **grill-with-docs** : enrichissait `/grill-me` avec de la lecture de documents. Appliqué dans `/adr` (filtre 3 conditions) et `/prp` (ajout du glossaire). Le principe : avant d'interroger, lire ce qui existe déjà.

- **caveman** : mode de communication ultra-compressé (~75% de tokens en moins). Utile pour les longues sessions de méthode, **jamais** pendant les sessions de code (les actions irréversibles et la sécurité exigent une clarté totale).

**Nouveaux skills créés**

- `/grill-me` : interrogatoire approfondi d'un plan. Différent de `/askme` (rapide, structuré) : ici, Claude descend chaque branche de décision une par une, recommande une réponse, et ne lâche pas avant que tout soit résolu. L'expression française "passer sur le grill" capture exactement le sens.

- `/handoff` : ancre de contexte mid-session avant une compaction de contexte. Sauvegarde dans `handoff.md` à la racine du projet. Écrase à chaque usage — les vieilles entrées sont périmées une fois consommées par la nouvelle fenêtre de contexte. Ne remplace pas `/maj` (clôture officielle), mais permet de reprendre le fil après compaction.

**Refactoring Notion → artefacts locaux (décision structurante)**

Constat : 7 skills écrivaient exclusivement dans Notion sans équivalent local. Notion était le seul endroit où vivaient `.peda`, `.log`, `.doc`, `.spec`, et les checkpoints intermédiaires.

Problème : dépendance externe, friction, et incohérence avec la doctrine "git est la source de vérité".

Décision retenue : **Option A — Notion disparaît entièrement du workflow.** Tous les artefacts vivent dans des fichiers `.md` dans le repo du projet.

#### Comment

- `/peda`, `/log`, `/doc`, `/spec`, `/checkpoint`, `/majtodo`, `/maj`, `/init-projet` → réécrits avec Write tool (changements trop importants pour du patch partiel)
- `CLAUDE.global.md` → section "Notion — second cerveau" supprimée (URLs BDD, règles opérationnelles, convention couleur bleue), remplacée par une table "Artefacts locaux par projet"
- `/maj` → nouvelle étape 2 "Documentation locale" insérée avant le commit Git

#### Décisions prises

- **Collision de nom `/spec`** : le skill `/spec` (singulier) produit désormais `[projet].spec-global.md` pour éviter la collision avec `[projet].spec.[feature].md` produit par `/specs` (pluriel). Deux fichiers distincts, deux niveaux de granularité.
- **Survie de `/checkpoint`** : conservé comme raccourci intermédiaire (`/peda` + `/log` sans Git). `/maj` l'englobe et fait tout le reste.
- **Convention couleur bleue** : supprimée — elle servait à identifier les blocs ajoutés par Claude dans Notion. Sans Notion, elle n'a plus d'objet.

#### Difficultés

- Le fichier `~/dev/CLAUDE.md` est un symlink vers `vibe-method/CLAUDE.global.md`. Write refuse d'écrire à travers un symlink — résolu en passant par le chemin réel (`/Users/medwinrumo/dev/vibe-method/CLAUDE.global.md`).
- La session a subi une compaction de contexte mid-session. `/handoff` n'existait pas encore au moment de la compaction — la reprise s'est faite via le résumé automatique généré par le système.

---

### Session 2 — Intégration de skills externes (suite) + recadrage méthodologique

#### Ce qu'on a fait et pourquoi

**Évaluation de nouveaux skills externes**

Quatre skills supplémentaires analysés :

- **diagnose** : diagnostic discipliné pour bugs difficiles. Notre `/debug` couvre les bugs simples depuis `/recette`. `/diagnose` est l'escalade pour les bugs qui résistent — sa valeur centrale est la Phase 1 : construire une boucle de feedback automatisée et déterministe avant toute hypothèse. Intégré comme skill distinct connecté à `/debug` étape 5.

- **improve-codebase-architecture** : exploration du codebase pour trouver des "deepening opportunities". Apporte trois concepts intégrés dans `/refacto` : le **deletion test** (si on supprime ce module, la complexité disparaît-elle ?), le vocabulaire **Seam/Profondeur**, et un mode **exploration** pour quand aucun module n'est encore identifié.

- **tdd** : apporte deux formulations meilleures que les nôtres — l'anti-pattern "tranches horizontales" (écrire tous les tests puis tout le code = tester un comportement imaginé) et le signal d'alerte "renommer une fonction interne casse des tests = les tests testaient l'implémentation". Intégré dans `/tests`.

- **to-issues** : transforme specs en issues GitHub qualifiées HITL/AFK, découpées en vertical slices. Skills écartés : `triage` (workflow open source, pas adapté à notre usage solo), `setup-matt-pocock-skills` (configurateur de leur suite, pas utile sans leur écosystème complet).

**Recadrage méthodologique important**

En cours de session, Medwin a recadré l'approche d'évaluation des skills :
- L'objectif est **prospectif**, pas opérationnel — recenser le maximum de skills disponibles, même sans cas d'usage immédiat. Un skill écarté aujourd'hui ne sera probablement jamais reconsidéré.
- Les "agents autonomes" c'est nous deux — HITL = Medwin reste dans la boucle, AFK = Claude agit seul. Avec la capacité de spawner des sous-agents, le périmètre d'action peut se démultiplier.

Ce recadrage a conduit à reconsidérer `/to-issues` (initialement écarté "faute de cas d'usage") et à créer le skill.

#### Comment

- `/diagnose` créé, symlink créé, `/debug` modifié (étape 5 → option escalade)
- `/refacto` modifié : section vocabulaire (Seam/Profondeur/Deletion test) + mode exploration
- `/tests` modifié : anti-pattern horizontal slices + signal mauvais test
- `/roadmap` modifié : principe vertical slices + critère Quality Gate
- `/to-issues` créé, symlink créé
- `CLAUDE.md` vibe-method mis à jour à chaque ajout

#### Décisions prises

- **Approche prospective** : intégrer les concepts utiles même sans use case immédiat visible — ils seront disponibles quand le besoin viendra.
- **HITL/AFK** : distinction formalisée dans `/to-issues` et `/roadmap` pour qualifier explicitement ce qu'on délègue vs ce qu'on valide.
- **`/to-issues` dans la chaîne** : après `/specs`, avant `/sessionCode`. Transforme les specs en issues structurées prêtes à exécuter.

---

### Session 3 — Implementation Decisions, /handoff, /zoom-out, /prototype

#### Ce qu'on a fait et pourquoi

**Implementation Decisions + Testing Decisions dans `/prd` et `/archi`**

Partant du skill externe `to-prd`, on a identifié une lacune : le dialogue PRD capturait des intuitions architecturales (un module évident, une contrainte d'interface) mais les perdait — elles n'étaient nulle part dans un artefact que `/archi` pouvait lire.

Trois changements appliqués :
- `/prd` : deux nouvelles sections dans le template (13. Implementation Decisions, 14. Testing Decisions) et deux nouvelles questions en Étape 5b pour les collecter
- `/archi` Étape 0 : lit explicitement la section 13 du PRD dès l'ouverture
- `/archi` Étape 0b : traite ces décisions comme hypothèses de départ à challenger — complétude, alternatives, cohérence — pas comme décisions finales

L'enjeu : éviter que l'archi se contente de prolonger ce que le PRD a pressenti. Elle doit aussi explorer ce qu'il n'a pas pensé.

**`/zoom-out` — réorientation dans un fichier peu familier**

Évaluation du skill externe `zoom-out`. Cas d'usage retenu : arriver dans un module qu'on n'a pas touché depuis longtemps et comprendre comment il s'insère dans l'architecture avant d'y toucher. Pas pour la reprise post-compaction (c'est `/handoff`), mais pour la redécouverte.

Skill créé en version vibe-method : lit `[projet].archi.md` + `[projet].gloss.md`, produit une carte du module (responsabilité, callers, contrat public, termes du domaine). Pas de questions, pas de validation — juste la carte. Transversal.

Au passage : clarification sur comment `gloss.md` se remplit — créé par `/prd`, enrichi par `/peda` (via `/maj` ou `/checkpoint`). C'est Claude qui fait la sélection et la curation, pas Medwin.

**`/handoff` — refonte complète**

Trois itérations sur `/handoff` dans cette session :

1. **Sections enrichies pour toutes les phases** : la version précédente était trop générique pour les sessions de code et ne capturait pas les sessions de conception (PRD, archi, specs). Ajout de "Phase et skill en cours", "Étape précise", "Décisions validées" séparées des actions, "Artefacts modifiés", "Prochaine action précise". Section conditionnelle code uniquement (module, tests, prochaine action dans le code).

2. **Bidirectionnel** : un seul fichier, deux comportements. Fichier vide → sauvegarde. Fichier avec contenu → reprise (affichage + vidage). Pas de delete/recreate — Write écrase, coût nul.

3. **Append + détection par contexte visible** : Medwin a proposé l'accumulation de plusieurs `/handoff` avant une compaction. Résolution du problème de détection save vs restore : si un résumé de compaction est visible dans la conversation + peu d'historique → reprise automatique. Si conversation active → append. Cas ambigu (fichier non vide + session active) → demande explicite.

Point intéressant appris : Claude n'a pas accès au % de remplissage de contexte affiché dans le CLI. C'est une information UI, pas accessible au modèle.

**`/prototype` — code jetable**

Skill externe évalué et intégré. Deux branches : logique (terminal interactif pour tester une machine d'état) et UI (variations switchables). Zéro polish, une commande, supprimé quand la question est résolue. Sortie vers `/adr` si la réponse engage l'architecture.

Intérêt principal pour notre méthode : embrasser le jetable comme pratique de première classe. Notre méthode construit toujours pour durer — le prototype est l'exception assumée.

Déclencheurs ajoutés dans 5 skills : `/archi` (logique d'état complexe), `/design` (directions visuelles multiples), `/prd` (journey difficile à valider), `/specs` (règles métier impossibles à spécifier sans les voir), `/grill-me` (question intraitable abstraitement). Claude suggère — Medwin n'a pas à y penser.

**Hooks Claude Code et monitoring du contexte**

Medwin voulait savoir si les skills pouvaient accéder au % de contexte pour suggérer `/handoff` automatiquement. Délégué à un sous-agent spécialisé.

Résultat : non disponible. Les hooks n'exposent pas de métrique de contexte. Mais le sous-agent a produit une réponse très convaincante avec un numéro d'issue GitHub (#34340), des noms de variables précis (`CLAUDE_CONTEXT_PERCENT`), et des liens — le tout inventé. Corrigé immédiatement, mémoire mise à jour.

#### Décisions prises

- **Implementation Decisions comme hypothèses** : `/archi` ne prolonge pas les intuitions du PRD — il les challenge. Complétude, alternatives, cohérence.
- **`/handoff` append** : plusieurs sauvegardes s'accumulent, une seule reprise vide tout. Fichier vide = save, résumé de compaction visible = restore.
- **`/prototype` transversal** : pas dans la chaîne principale — invocable à tout moment, suggéré par Claude quand le signal apparaît dans un autre skill.
- **Hallucination à signaler immédiatement** : quand un sous-agent produit des détails très précis non vérifiables (URLs, numéros d'issue, noms de variables), traiter ça comme un signal d'alerte — ne pas faire confiance sans vérification.

#### Difficultés

- **Hallucination du sous-agent** : le claude-code-guide a inventé une issue GitHub #34340 avec des détails très convaincants. Medwin a vérifié et signalé l'erreur. C'est une illustration importante : la précision des détails n'est pas un indicateur de vérité — c'est parfois l'inverse.
