# vibe-method.peda — Journal pédagogique

---

## Jour 1 — 2026-05-18 — Création du skill /devis + intégration Exa

### Session 4 — /devis : du brief à la proposition commerciale

#### Ce qu'on a fait et pourquoi

**Skill `/devis` — création complète**

Constat de départ : la vibe-method couvrait tout le cycle de développement mais pas la phase commerciale qui le précède. Un client doit accepter un prix avant qu'on investisse dans un PRD complet. `/devis` comble ce manque.

Le skill couvre 6 étapes :
- Étape 0 : vérification des prérequis (context.md + brief.md)
- Étape 1 : qualification client via `exa:search` (8 angles de recherche)
- Étape 2 : architecture légère (stack, hébergeur, coûts récurrents)
- Étape 3 : découpage en blocs fonctionnels (grille P/M/G, TJM 400€/j)
- Étape 4 : calibrage valeur (interne — jamais dans le document client)
- Étape 5 : conditions contractuelles
- Étape 6 : génération de `[projet].proposition.md`

Position dans la chaîne : `/brief` → `/devis` → [validation client] → `/prd`

**Intégration Exa MCP**

Pattern appris : Exa s'installe une fois dans `~/.claude/mcp.json` (API key stockée là, jamais dans le contexte de conversation). On le connecte à la demande via `/mcp` quand besoin, on déconnecte après. Même logique que `notion-local`.

Tentative OAuth : le flux `auth.exa.ai` a échoué (URL tronquée dans le chat → paramètres manquants). Solution : ajout direct de la clé API dans `mcp.json` par Medwin (sans passer par le chat — bonne pratique sécurité). Le skill `/devis` guide maintenant le connect/disconnect au bon moment.

**Itérations sur l'Étape 1 (qualification client)**

V1 : une seule requête générique → résultats pauvres, équivalents à pappers.fr manuellement.

V2 : 8 angles parallèles (légal, financier, maturité digitale, profil décideur, signaux d'achat, actualités, réputation, SaaS concurrents). Meilleur, mais trop "aspirateur à données" — pas de hiérarchie des sources, objectif vague.

V3 (retenue) : suite au challenge ChatGPT 5.5 de Medwin. Trois améliorations structurantes :
- Objectif décisionnel explicite ("est-ce un bon prospect ?") pas descriptif
- Hiérarchie des sources (prioritaires / secondaires / si nécessaire)
- Sortie avec scoring sur 6 dimensions + recommandation A/B/C/écarter + angle de prospection complet (message LinkedIn, email, objection probable)

Test sur Hygeia Group : la société est dans le nettoyage (NAF 81.21Y), pas la santé — le nom "Hygeia" (grec : hygiène) avait induit en erreur. Exa a trouvé le SIRET et l'adresse officielle (Courtry 77181, pas Champs-sur-Marne 77420 comme dit par Medwin). Fondateur non trouvé dans les bases publiques.

**Étape 4 — Calibrage valeur refaite**

Ancienne version : questions vagues sur la valeur et un calcul plancher/plafond sans lien avec les données collectées en Étape 1.

Nouvelle version : grille de lecture commerciale qui traduit chaque signal de l'Étape 1 en décision (favorable / neutre / risque) + trois sorties obligatoires (profil d'acheteur, fourchette de prix défendable, arguments clés pour la proposition).

**Correction structure fichiers**

Le skill avait été créé dans deux mauvais emplacements (`~/.claude/commands/devis.md` en dur + `vibe-method/devis.md` à la racine). Corrigé : source de vérité dans `vibe-method/.claude/commands/devis.md`, symlink depuis `~/.claude/commands/`.

**Analyse des CGV**

Les CGV actuelles (28 articles) ont été rédigées pour un projet Notion spécifique ("gestion de matériel événementiel"). Pour des projets applicatifs, au moins 7 articles sont inadaptés (1, 2, 6, 9, 14, 16, 17) + 1 point critique sur la propriété intellectuelle (article 7 : "droit d'usage non exclusif" alors que les clients app s'attendent à posséder le code source). Signalé dans le skill via note CGV à l'Étape 5. La réécriture des CGV reste un chantier séparé.

#### Décisions prises

- **Exa : connect/disconnect via `/mcp`** — jamais installé/désinstallé entre projets. Clé API dans `mcp.json`, jamais dans le chat.
- **Plugins officiels uniquement** — `claude-plugins-official` seulement. Jamais buildwithclaude.com, tonsofskills.com ou autre marketplace tiers.
- **Brief de qualification orienté décision** — la sortie de l'Étape 1 doit répondre à "on contacte ou pas ?" avec scoring et angle de prospection. Pas une fiche encyclopédique.
- **Étape 4 interne absolue** — le calibrage valeur ne figure jamais dans le document client.
- **CGV applicatif = chantier séparé** — `/devis` le signale à chaque fois mais ne l'embarque pas.

#### Difficultés

- Le flux OAuth Exa a échoué à cause de l'URL tronquée dans l'interface chat. Contourné par ajout direct dans `mcp.json`.
- Les fichiers ont été créés aux mauvais endroits (deux fois) avant de corriger la structure symlink.

---

## Jour 1 — 2026-05-18 — CGV M1/M2/M3 + /brief refonte

### Session 5 — Système CGV dynamique + refonte /brief + /cgv skill

#### Ce qu'on a fait et pourquoi

**Contexte**

Session 4 avait révélé que les CGV existantes étaient inadaptées aux projets applicatifs. Session 5 a construit le système CGV complet depuis zéro.

**Architecture CGV — tronc commun + conditions particulières par modèle**

Trois types de prestations → trois jeux de conditions particulières :
- **M1 — Développement sur mesure** : cession de PI complète (L131-3 CPI) après paiement intégral ; maintenance corrective + écosystème incluse sans facturation ; casse client exclue ; accès Git maintenu post-mission ; hébergement/DB/services retirés à la fin de mission
- **M2 — SaaS** : licence d'accès non exclusive ; SLA défini ; réversibilité + portabilité des données (Data Act) ; DPA si données personnelles traitées ; abonnement mensuel
- **M3 — Notion** : droit d'usage non exclusif (Medwin peut vendre le même système à d'autres clients) ; réversibilité export CSV/JSON ; pas de cession de PI

M4 écarté : M3 couvre déjà les marketplace Notion (licence non exclusive = multi-clients possible).

**Tronc commun (cgv.cg.md) — 18 articles**

Couverture : identification des parties, objet, durée, prix, facturation, délai de paiement, PI (renvoi aux CP), accès, obligations réciproques, confidentialité, force majeure, responsabilité, résiliation, litiges, loi applicable. Stable pour tous les modèles — seule la section PI varie via les CP.

**Skill `/cgv` — assemblage automatique**

Claude lit `[projet].brief.md` + `[projet].proposition.md`, identifie le modèle M1/M2/M3, assemble CG + CP correspondants, personnalise les variables (parties, objet, durée, prix, jalons), génère `[projet].cgv.md`.

**Refonte `/brief` — domaine 6 ajouté**

L'architecture légère et le modèle de prestation (M1/M2/M3) doivent être clarifiés au brief — avant le devis, pas pendant. Ajouté en domaine 6 : stack, services tiers, coûts récurrents estimés.

Quality gate enrichie pour couvrir le nouveau domaine.

#### Décisions prises

- **CGV = CG tronc commun + CP par modèle** — la variabilité est localisée, les 18 articles communs n'ont pas à être rediscutés à chaque projet
- **M1 maintenance incluse sans facturation** — bugs + dépendances + sécurité + plateforme ; casse client exclue ; coûts récurrents (hébergement, DB, services) restent clients
- **Redistribution commerciale M1** — App Store, marketplace : client doit obtenir accord préalable du Prestataire
- **Devis ≠ proposition commerciale** — deux documents distincts. CGV partent avec les deux, jamais l'un sans l'autre.
- **Réserve de propriété M1** — PI ne passe pas tant que tout le prix n'est pas payé

#### Difficultés

Aucune difficulté technique. La complexité était juridique : distinguer les trois modèles de prestation, comprendre les implications de "cession" vs "licence" vs "droit d'usage".

---

## Jour 1 — 2026-05-18 — /devis estimation complète + calibration rétrospective + Notion

### Session 6 — /devis étape 3a+3b + /phase-retrospective C0b + guide workflow + Notion

#### Ce qu'on a fait et pourquoi

**Contexte — trois lacunes identifiées**

1. `/devis` ne produisait pas de récapitulatif utilisable pour remplir le devis PDF formel
2. `/devis` n'estimait pas les phases du workflow — seulement les blocs de dev
3. `/phase-retrospective` ne capturait pas le temps réel par phase de manière fiable

**Récapitulatif devis (`proposition.md` en deux parties)**

En tête du fichier, avant la proposition narrative :
- **Tableau 1** : lignes de devis client (Désignation | Qté | Prix unitaire | Total HT). Lignes "Inclus" et "Récurrents" exclues du Total HT.
- **Tableau 2** : détail par phase (à supprimer avant envoi PDF).

Décision clé : le développement = N jours × TJM pour le client, pas de décomposition en blocs. Les blocs sont l'outil d'estimation interne (étape 3b), pas un livrable client.

**Étape 3 scindée en 3a (workflow) + 3b (dev)**

3a : calibration des phases workflow depuis les paramètres du brief — modèle M1/M2/M3, sécurité, nombre de features, stack, distribution, RGPD. Chaque phase avec base + ajustements + incertitude concrète (pas de "Y" générique). 12 phases couvertes.

3b : blocs de développement depuis une table de référence par pattern. 5 catégories (auth, CRUD, temps réel, UI, intégrations) × Supabase vs Convex. Mobile Expo × 1,5 à 2. Grille P/M/G en fallback pour patterns non listés.

Ce découpage répond à une question critique posée en session : "sur quoi tu t'appuies pour estimer ?". Réponse honnête : les patterns dev sont des durées connues (données réelles) ; les phases workflow sont des educated guesses qui seront calibrés par la boucle rétrospective.

**`/phase-retrospective` — C0b (analyse des logs)**

Mode Léger conservé intact (4 questions, journal 4 lignes). Mode Complet enrichi :
- C0b ajouté : lecture de `[projet].log.md` session par session, identification de la phase depuis le sujet de chaque session, cumul des durées par phase.
- Cross-référence avec `[projet].proposition.md` pour la colonne Estimé (ou "—" si absent).
- Session couvrant deux phases → les deux comptées (c'est la réalité du travail).
- Tableau calibration présenté à Medwin pour correction avant écriture.
- Section "Calibration — Estimé vs Réel" ajoutée dans le template C5.

Raisonnement : les dates de Rmap sont fragiles (elles bougent dès qu'on prend du retard). Les logs contiennent le sujet travaillé → c'est un ancrage robuste pour la phase.

**Mise à jour du guide workflow**

`VIBE-METHOD — GUIDE COMPLET DU WORKFLOW.md` mis à jour : chaîne enrichie (/devis + /cgv), PARTIE 1 à 8 skills, /brief 9 domaines, sections /devis et /cgv insérées complètes, /phase-retrospective Mode Léger vs Complet + C0b.

**Mise à jour Notion**

Page `Vibe-Method.WORKFLOW` synchronisée via API Notion directe (Python + requests). La mise à jour via le MCP `notion-local` a échoué : le tool `update-a-block` envoie `{"type": {"heading_4": {...}}}` au lieu de `{"heading_4": {...}}` — incompatibilité avec l'API Notion (bug de mapping MCP). Contourné en appelant l'API directement avec le token du `mcp.json`.

#### Décisions prises

- **Incertitude concrète par phase** : "±Y j" générique remplacé par des valeurs réelles (0 à 2j) par phase
- **Mode Léger conservé** : ne pas tout reporter sur l'analyse des logs — les 4 questions rapides capturent l'immédiat pendant que c'est frais
- **Logs comme source de vérité calibration** : plus robuste que les dates de planning
- **API Notion directe si MCP échoue** : token dans `~/.claude/mcp.json`, appel via Python+requests

#### Difficultés

- "Y" non défini dans la grille de calibration → signalé par Medwin, corrigé avec valeurs concrètes
- MCP update-a-block incompatible Notion → bug identifié, contournement via API directe
- Boucle de calibration encore théorique : aucun projet n'a encore fait un cycle complet /devis → code → /phase-retrospective. Le vrai test sera sur un projet réel.

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
