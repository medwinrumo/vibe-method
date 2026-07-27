# vibe-method.peda — Journal pédagogique

---

## 2026-05-26 — Wiki LLM + Wiki

### Ce qu'on a fait et pourquoi

**Wiki LLM vibe-method**

Constat : la vibe-method est riche mais difficile à naviguer. 55+ skills, 8 doctrines, pas de vue d'ensemble navigable. Solution : un vault Obsidian `Vibe-Method/` comme couche de navigation dérivée des sources — les fichiers sources restent la vérité, le wiki est une projection navigable avec les liens `[[]]` et la vue graphe.

Décision clé : "vue dérivée" (pas de modification directe dans Obsidian). Le wiki est mis à jour automatiquement quand une source change en session.

Structure créée : CLAUDE.md (schéma + 4 opérations), index.md (catalogue), log.md, _vue-ensemble.md, flux/chaine-complete.md, 8 doctrines, 55+ skills.

**Wiki — second cerveau**

Constat : le savoir accumulé sur les outils (gotchas Supabase, patterns Convex, etc.) reste enterré dans les fichiers projet qu'on ne rouvre jamais. Il n'y a pas de capitalisation cross-projets.

Concept : `~/dev/wiki/` — vault plat, bidirectionnel (les skills lisent ET écrivent dedans), accessible depuis Claude Code (natif), Claude Desktop Chat + Cowork (MCP filesystem).

Règle fondamentale : enrichir plutôt que dupliquer. Avant d'aller sur le web, chercher dans le Wiki.

Leçon sur l'architecture : la vibe-method porte les règles (comment faire), le Wiki porte le savoir (ce qu'on sait). Ligne de partage claire.

**MCP filesystem**

Configuré dans Claude Desktop pour `~/dev/` — couvre tous les projets et le Wiki. Claude Chat et Cowork peuvent lire/écrire dans le Wiki sans configuration supplémentaire après redémarrage.

**Skills producteurs**

6 skills modifiés pour écrire dans le Wiki : `/stack` (lecture avant spike + Étape 6 enrichissement), `/archi`, `/regles`, `/deploy`, `/debug` (si résolution via web search), `/phase-retrospective` (Mode Complet — C7).

Principe : chaque skill propose d'enrichir le Wiki, Medwin valide. Pas d'écriture automatique sans validation.

**Obsidian — problème découvert**

Obsidian modifie les fichiers `.md` quand il les affiche (reformatage YAML, changement de type). `chaine-complete.md` a été corrompu (`flux` → `infrastructure`). Solution : fichiers UI Obsidian ajoutés au `.gitignore`, git utilisé comme garde-fou pour détecter et annuler les modifications parasites.

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

---

## Jour 2 — 2026-05-19 — CLAUDE.md : correction structurelle

### Session 7 — CLAUDE.md ownership par skill + GitHub Projects dans /init-projet

#### Ce qu'on a fait et pourquoi

**Déclencheur**

Ouverture d'une session HYGEIA : CLAUDE.md était vide malgré deux /maj effectués. Le diagnostic a révélé un gap structurel dans la méthode : /init-projet crée CLAUDE.md comme stub vide, /maj le met à jour de manière conditionnelle ("si décisions d'architecture"), aucun skill n'a la charge du premier remplissage. Résultat : le fichier reste vide indéfiniment. Correctif immédiat : HYGEIA.CLAUDE.md rempli manuellement et commité.

**GitHub Projects setup : /todo → /init-projet**

Le setup (création projet GH, colonnes Todo/In Progress/Done/Late, champs Début+Fin, récupération des IDs internes, .gh-project.local, .gitignore) était documenté dans /todo sous un titre "Setup (une fois par projet)". C'est logiquement dans /init-projet que ça appartient — tâche d'initialisation, pas de session. /todo ne garde qu'un pointeur d'une ligne.

**Nature du CLAUDE.md**

Clarification structurante issue de la discussion avec Medwin : CLAUDE.md est une convention Anthropic native. Sa vocation d'origine : fournir un contexte de démarrage rapide, pas une documentation exhaustive. Anthropic a conçu ce fichier pour être court et dense — chargé automatiquement en début de session.

Ce qu'on ajoute dans la vibe-method : la couche de navigation via le pointeur `→ Détails : [artefact]`. Le principe "résumé + contexte, pas source exhaustive" était déjà là. La vibe-method avait le fichier mais ne le remplissait pas — c'est le vrai problème corrigé.

**Architecture retenue : upsert incrémental sans stubs**

Trois options évaluées :
- A — /init-projet crée tous les stubs → sections vides non informatives, bruit
- B — chaque skill ajoute sa section → ordre imprévisible, risque doublons
- C (retenue) — upsert : section existante → remplacer, section absente → ajouter en fin de fichier

L'upsert donne des sections dans l'ordre naturel d'exécution de la chaîne (la première fois que chaque skill tourne), et les relectures mettent la section à jour sans doublon.

**Section /charte et Mode B de /design**

/charte : estimé trop volumineux au premier réflexe. Conclusion inverse retenue — le contenu est compact (hex, polices, border-radius, dark mode) et Claude Code en a besoin à chaque génération de composant Tailwind. Section `## Identité visuelle` créée.

Mode B de /design ne produit pas de nouvelle connaissance de design — il traduit en code. Il enrichit `## Identité visuelle` (créée par /charte) en ajoutant les tokens Tailwind et la librairie choisie. Un seul endroit, deux niveaux de lecture (design intent → implémentation code).

#### Décisions prises

- **GitHub Projects setup dans /init-projet** — Étape 2, entre Git init et la confirmation finale
- **CLAUDE.md = résumé + index de navigation** — chaque section renvoie vers son artefact via `→ Détails`
- **Upsert incrémental sans stubs** — pas de section vide, sections dans l'ordre de la chaîne
- **/charte alimente CLAUDE.md** — section `## Identité visuelle`, enrichie par Mode B (tokens Tailwind)
- **/archi : upsert automatique** — plus "Medwin les intègre manuellement dans son projet"
- **/regles : upsert automatique** — plus "À inclure dans ton CLAUDE.md si tu veux"
- **/maj : rôle de cohérence** — vérification que les sections correspondent à leurs artefacts, plus condition vague "si la session a produit des décisions d'architecture"

#### Difficultés

- Les fichiers de commandes sont des symlinks (`~/.claude/commands/` → `vibe-method/.claude/commands/`). L'Edit tool refuse d'écrire via symlink — il faut toujours passer par le chemin réel dans vibe-method.
- CLAUDE.md HYGEIA rempli manuellement (session précédente n'a pas laissé de trace dans le fichier). La correction structurelle dans vibe-method s'appliquera aux prochains projets depuis /init-projet.

---

## Jour 3 — 2026-05-21 — Deep research RGPD : Supabase + Vercel + alternatives EU pour RAMrezo

### Session 8 — Doctrine RGPD : état des lieux + research Exa + task de mise à jour

#### Ce qu'on a fait et pourquoi

**Déclencheur**

Medwin a apporté deux fichiers de checklists RGPD (Vercel en 12 points, Supabase en 10 points) et posé la question centrale : peut-on travailler avec Supabase + Vercel dans un cadre RGPD propre pour RAMrezo ? Et les alternatives européennes souveraines sont-elles réalistement équivalentes ?

**Deep research avec exa:search**

Première utilisation structurée d'exa:search comme orchestrateur de recherche multi-angles. Pattern appris :

- L'orchestrateur analyse la complexité (Extremely Simple / Moderate / Advanced / Complex) avant d'agir
- Pour une requête Complex (multiple entités légales, dimension réglementaire, comparative), il dispatche des subagents Haiku en parallèle — chacun couvre un territoire distinct
- Chaque subagent reçoit un prompt avec : les fichiers de référence Exa à lire, les requêtes précises à exécuter, le format de sortie attendu, et l'instruction `sources_reviewed: N`
- L'orchestrateur compile ensuite et déduplique

**Ce qui a bien fonctionné :** 3 subagents sur 5 ont produit des recherches réelles avec 78+ sources examinées (Supabase RGPD : 31 sources, CNIL/transferts : 35 sources, RAMrezo spécifique : 47 sources).

**Ce qui a échoué :** 2 subagents ont dérapé — au lieu de lancer les recherches directement, ils ont lancé des méta-analyses de la tâche. Cause probable : les outils MCP Exa n'étaient pas disponibles dans leur contexte de subagent. Relancés, ils ont répondu sur training knowledge (non sourcées Exa) — utiles mais de confiance inférieure.

**Leçon Exa :** la disponibilité des outils MCP dans les subagents n'est pas garantie. Si un subagent décroche, le relancer avec une instruction encore plus directe ("run the searches yourself, do NOT spawn subagents") améliore mais ne garantit pas. Pour les requêtes critiques, mieux vaut faire les recherches soi-même dans le contexte principal.

**Résultats substantiels de la research**

Quatre enseignements clés retenus :

1. **Supabase (région Frankfurt) + Vercel = légal pour RAMrezo**, sous conditions documentées. Pas automatique — dossier à construire.

2. **Vercel et Supabase ne sont pas au même niveau RGPD :**
   - Vercel est **certifié DPF** (Data Privacy Framework EU-US) → base légale directe, plus simple
   - Supabase **n'est pas certifié DPF** → régime SCC + TIA obligatoire. Mais il fournit un DPA (mars 2025) et un TIA (mars 2025) prêts à l'emploi

3. **Le DPF est juridiquement fragile.** Premier recours rejeté (Cour UE, septembre 2025), mais appel devant la CJUE en attente. Le Privacy Shield avait été invalidé en 2020 dans les mêmes conditions.

4. **Pas d'alternative EU souveraine clé en main.** Appwrite (Zurich) est la meilleure option BaaS souveraine — mais self-host obligatoire = overhead ops significatif. Scaleway/OVH couvrent l'infra mais pas le BaaS. Pour RAMrezo avec deadline au 4 juin 2026, changer de stack pour de la souveraineté théorique serait un risque d'exécution injustifiable.

**Concept appris : résidence ≠ souveraineté**

Choisir la région Frankfurt pour Supabase garantit que les données restent physiquement en UE (résidence). Ça ne garantit pas que le gouvernement américain ne peut pas y accéder via le CLOUD Act/FISA (souveraineté). Supabase est une Delaware C-corp — le CLOUD Act s'applique. Pour des données sensibles (santé, judiciaire) : problème réel. Pour RAMrezo (annuaire d'entrepreneurs, événements) : risque théorique, pas un blocage pratique.

**Vérification de la doctrine existante**

`rgpd.md` existe — 12 sections, complète. Elle couvrait déjà le modèle SaaS B2B avec RAMrezo en exemple. Trois points inexacts après la research :
- Vercel marqué "à vérifier DPF" → il est certifié
- DPF présenté comme stable depuis 2023 → il est sous pression judiciaire
- URLs DPA/TIA Supabase absentes

**Artefact produit**

`rgpd-research-2026-05-21.md` — intégralité de la research mot à mot (5 sections, ~83 sources). Sert de base à la mise à jour de `rgpd.md` lors de la prochaine session dédiée.

**Task créée**

Task #1 — mise à jour `rgpd.md` avec 3 corrections + 2 ajouts (checklists Vercel/Supabase + section argumentaire cloud US). À traiter lors d'une prochaine session.

#### Décisions prises

- **Supabase Frankfurt + Vercel = stack RAMrezo validée côté RGPD** — avec DPA Supabase signé + TIA joint + DPA Vercel signé + registre des traitements
- **Le dossier RGPD se construit, il ne s'achète pas** — aucun des deux outils ne rend l'app conforme automatiquement. C'est la combinaison DPA + TIA + région EU + implémentation dans l'app (droits utilisateurs) qui constitue la conformité
- **Argumentaire client prêt** — formulation disponible dans `rgpd-research-2026-05-21.md` section 5 pour répondre à un client qui questionne le choix de stack non-souverain

#### Difficultés

- 2 subagents Exa sur 5 ont échoué à exécuter les recherches (dérapé en méta-analyse). Relancés, ils ont répondu sur training knowledge sans accès Exa réel.

---

## 2026-06-11 — Lint Wiki complet + /pr enrichi + pédagogie Git

### Session — Hygiène du Wiki + complétion du workflow Git

#### Ce qu'on a fait et pourquoi

**Lint complet du Wiki**

Premier lint depuis la création massive du vault en mai (55+ pages wiki). La règle `/maj` étape 5 prévoit un lint quand des sources sont modifiées — mais le lint de mai avait eu lieu pendant la création du wiki, pas après. Ce backlog a été soldé aujourd'hui.

5 problèmes trouvés et corrigés :

1. **Contradiction firecrawl** : `firecrawl-outil.md` classait `summary` dans les formats LLM (+4 crédits). `firecrawl-parametres.md` le donnait à 0 crédit. Vérification sur docs.firecrawl.dev : la doc liste explicitement `json`, `question`, `highlights` comme formats +4 crédits — `summary` n'y figure pas. Correction dans `firecrawl-outil.md`.

2. **Structure violée** : `llm-wiki.md` était dans `Clippings/` au lieu de la racine. Le CLAUDE.md du Wiki dit explicitement "vault plat". De plus son frontmatter utilisait des champs non-canoniques (`title`, `source`, `author`, `description` au lieu de `tags`, `sources`). Déplacé, frontmatter corrigé, `Clippings/` supprimé, index mis à jour.

3. **Type invalide** : `firecrawl-configs.md` utilisait `type: référence` — absent du schéma `source | concept | procédure`. Reclassé en `procédure`.

4. **Lien fantôme externe** : `seo-google-search.md` contenait `[[plug-in-seo/Google search central - Documentation]]` pointant vers un dossier hors vault. Supprimé — seul le champ `cerveau-detail:` du frontmatter est conservé comme pointeur.

5. **Affirmations "à venir" vérifiées** : `notion-developer-platform.md` mentionnait deux features annoncées "dans les prochains mois" (webhooks workers, External Agent API). Vérification sur developers.notion.com : les webhooks workers sont sortis (doc officielle avec guide complet). L'External Agent API reste introuvable. Note mise à jour avec date de vérification.

**Leçon sur le lint** : les contradictions naissent quand deux fichiers du même cluster sont rédigés lors de sessions différentes. Le cluster firecrawl (5 fichiers) a été créé en plusieurs passes — la source (firecrawl-outil) et la procédure (firecrawl-parametres) ne se sont pas vérifiées l'une l'autre. Le lint est le seul filet.

**Enrichissement du skill `/pr` — étape 4 merge**

Constat lors d'une question de Medwin : le workflow `/commit → /pr` se terminait sur l'ouverture de la PR sans expliquer ce qui vient ensuite. Le merge n'était mentionné qu'en une ligne vague ("Merge dans main après validation"). Or pour quelqu'un qui apprend, "merge" sans mode d'emploi concret est un trou dans le workflow.

Étape 4 ajoutée : ouvrir l'URL de la PR, relire le diff, cliquer Merge pull request → Confirm merge, cliquer Delete branch. Mention explicite que le merge n'est pas automatique — c'est un acte de validation humaine intentionnel.

**Pédagogie Git**

Quatre concepts expliqués à la demande de Medwin, à partir de questions concrètes :

- **Pull Request** : pas une modification de l'existant — une demande de fusionner une branche dans une autre. Peut être du code 100% nouveau.
- **Diff** : GitHub compare l'état de `main` avec ce que `main` deviendrait après merge. Nouveau code = tout en vert. "Diff" ≠ "modification de l'existant".
- **Commit** : photo de l'état du code à un instant T, sauvegardée dans l'historique. Sauvegarde ≠ commit — il faut stager puis commiter explicitement.
- **Push** : envoyer les commits locaux vers GitHub. Le commit existe sur la machine, le push le met en ligne. Pull = opération inverse.

Ces explications ont été fournies sous forme de texte structuré pour copier-coller dans Notion — à la demande de Medwin qui préfère les intégrer lui-même.

#### Décisions prises

- **Lint = pratique de maintenance obligatoire** : après toute session de création massive dans le Wiki, ne pas attendre `/maj` — planifier un lint dédié.
- **Merge = acte humain explicite dans `/pr`** : jamais automatisé, jamais implicite. L'étape 4 le formalise.
- **Pédagogie Git** : les explications Git ont été données en langage utilisateur (pas développeur) et validées par les questions de Medwin. Format "copier-coller dans Notion" retenu pour ce type de contenu.

#### Difficultés

Aucune difficulté technique. La vérification de `summary` dans Firecrawl a nécessité 4 appels WebFetch avant de trouver la page qui tranchait — la tarification n'est pas centralisée dans un seul endroit de la doc.

---

## 2026-06-11 — Intégration AIDD : 4 nouveaux skills + mise à jour guide + Notion

### Session — 4 skills issus de la session AIDD + synchronisation docs

#### Ce qu'on a fait et pourquoi

**Contexte**

Session précédente (non documentée ici, dans le transcript) : session AIDD (AI-Driven Development) qui avait produit 4 nouveaux skills — `/angles-morts`, `/condense`, `/commit`, `/pr` — et avait introduit le système de tiers T1/T2/T3 pour orienter le choix de modèle. Cette session a documenté et synchronisé ces changements dans tous les supports.

**Guide `VIBE-METHOD — GUIDE COMPLET DU WORKFLOW.md`**

Le guide était la source de vérité principale à mettre à jour. Modifications apportées :
- Date mise à jour : 14 mai 2026 → 11 juin 2026
- Chaînes PARTIE 1/2/3 : `/angles-morts` ajouté à ses 3 gates (après /prd-validate, /archi, /specs)
- Chaîne PARTIE 6 : `→ /commit → /pr` ajouté après /recette
- Transversaux : `/condense` ajouté
- Compteurs mis à jour : "8 skills" → "9 skills" (PARTIE 1), "25 skills + 5 transversaux" → "28 skills + 6 transversaux"
- Blocs Fin mis à jour pour /prd-validate, /archi, /specs (ils pointent maintenant vers /angles-morts), /recette (mentionne /commit → /pr)
- 4 nouvelles fiches insérées aux bons endroits dans le document (avec mention du tier recommandé)

**Système de tiers T1/T2/T3**

Introduit dans chaque nouvelle fiche skill pour orienter le choix de modèle sans imposer :
- T1 — Haiku : tâches mécaniques (/commit, /pr)
- T2 — Sonnet : défaut (/condense et la majorité des skills)
- T3 — Opus : raisonnement profond requis (/angles-morts, /party)

La formulation retenue est "Modèle recommandé : T2 — Sonnet (par défaut)" — pas une contrainte, une indication.

**Mise à jour Notion (page Vibe-Method.WORKFLOW)**

17 opérations API Notion pour synchroniser la page avec le guide .md :
- 11 `update-a-block` : textes des chaînes Vue d'ensemble, headers de section, blocs Fin
- 6 `patch-block-children` : ajout des items de chaîne manquants + sections détaillées des 4 nouveaux skills

Rappel technique important appris lors d'une session précédente : `update-a-block` exige le type du bloc comme paramètre direct (`heading_4: {...}`) et non enveloppé dans `{"type": {...}}` — la Notion API rejette la deuxième forme avec "body.type should be not present".

`patch-block-children` ne supporte que `paragraph` et `bulleted_list_item` pour les nouveaux blocs — pas de `heading_4`. Les titres de sections ont donc été insérés en `paragraph` (visuellement différent des heading_4 existants dans la page, mais seule option disponible via MCP).

#### Décisions prises

- **Option B pour les tiers** : mention du tier uniquement dans la fiche de chaque nouveau skill, pas de tableau récapitulatif global ni de refonte des fiches existantes. Pragmatique — les anciens skills fonctionnent bien, inutile de les toucher.
- **Nouveau format Fin pour /angles-morts** : "invoqu é à 3 gates" — la fiche explique les 3 positions dans le flow (PRD, archi, spec) plutôt que de pointer vers un skill suivant fixe.
- **Commits Conventional Commits** : la session a elle-même utilisé le format introduit par /commit (`docs:` pour le guide).

#### Difficultés

- Les réponses `patch-block-children` retournaient > 100 000 caractères (la page entière est renvoyée). Cela dépassait la limite de tokens du contexte — les 5 premiers appels ont été enregistrés dans des fichiers temporaires. Vérification par grep sur `"object":"error"` : aucun échec.
- La compaction de contexte entre les deux sessions de la conversation a nécessité un `handoff` pour reprendre l'état exact des blocs à modifier (IDs, blocs déjà mis à jour, blocs encore à insérer).
- La distinction résidence/souveraineté est contre-intuitive — on pense naïvement que "données en Europe" = "hors de portée des USA". C'est faux dès qu'il y a une société mère américaine.

---

## 2026-07-05 — Skill /wiki : enrichir le Wiki depuis n'importe quel dossier

### Session — Création du skill /wiki suite à un angle mort identifié pendant la mise en place du wiki partagé Hermes

#### Ce qu'on a fait et pourquoi

**Contexte**

Session longue et distincte, centrée sur le projet `~/dev/wiki` (second cerveau partagé entre Claude et Hermes via repo GitHub `medwinrumo/wiki`) — cette partie est intégralement documentée dans `~/dev/wiki/log.md`, pas dupliquée ici. Un sous-produit de cette session concerne directement vibe-method : la création d'un nouveau skill transversal.

**Le problème identifié**

Medwin a fait remarquer que `~/dev/wiki/CLAUDE.md` (14 règles d'écriture du wiki) n'est chargé automatiquement par Claude Code que si la session travaille dans `~/dev/wiki/` ou un de ses ancêtres (`~/dev/`). Si une session travaille dans un autre dossier (ex. un projet Notion) et que Medwin demande d'enrichir le wiki avec une découverte, Claude Code n'a alors aucun accès automatique aux règles complètes (frontmatter, wikilinks, structure) — risque d'écriture incohérente.

**La solution retenue : un skill plutôt qu'une mémoire ou un renvoi CLAUDE.md**

Options envisagées :
- Mémoire persistante (mais dépend du jugement de rappel, pas garanti)
- Renvoi dans `~/dev/CLAUDE.md` global (mais ne se charge que sous `~/dev/`, pas hors de cette arborescence)
- **Skill dédié** (retenu) — la liste des skills est visible dans **toutes** les sessions, indépendamment du dossier de travail, avec une invocation quasi automatique dès que la description matche la demande

**Skill `/wiki` créé** (`.claude/commands/wiki.md`) :
- Ne duplique pas les 14 règles — pointe vers `~/dev/wiki/CLAUDE.md` comme source de vérité unique (éviter de recréer le problème de redondance identifié et nettoyé ailleurs dans la session, sur le wiki lui-même)
- Intègre le workflow git (`pull` avant / `push` après) car le wiki est maintenant partagé avec Hermes (VPS) via ce même repo GitHub
- Étape 0 ajoutée sur suggestion de Medwin : clarifier la source du contenu à intégrer (conversation entière, document externe, résultat de crawl, portion ciblée des échanges) avant de lancer la procédure — évite l'ambiguïté de périmètre

#### Décisions prises

- Skill créé dans `vibe-method/.claude/commands/wiki.md`, symlinké globalement, documenté dans la table des skills de `CLAUDE.md` et ajouté aux "skills transversaux"
- Le contenu détaillé (frontmatter, format, règles) reste uniquement dans `~/dev/wiki/CLAUDE.md` — le skill est un déclencheur + renvoi, pas une duplication

#### Difficultés

Aucune difficulté technique. Point de vigilance identifié mais non résolu dans cette session : un skill équivalent côté Hermes (miroir de `/wiki`) est envisagé en fonction du résultat d'une clarification demandée à Hermes sur son propre mécanisme de chargement de `CLAUDE.md`. Tâches créées sur le board Kanban `wiki` (`t_d197d6a9`, `t_ab99f7d9`, `t_c4ff0f26`) — à suivre côté Hermes, hors périmètre vibe-method.

## 2026-07-20

### Session — Élimination de la double source de vérité CGV/CGP/propal

**Le point de départ**

Medwin a demandé de retrouver les fichiers sources ayant servi à construire CGV/CGP/propal pour le projet client HYGEIA. Trouvés dans `~/dev/vibe-method/` (`cgv.cg.md`, `cgv.cp-m1/m2/m3.md`, `# **Proposition commerciale**.md`) — mais ce dossier n'est accessible ni à Hermes (VPS) ni à un futur Notion, uniquement à Claude Code sur ce Mac. Dispersion des fichiers de référence identifiée comme le vrai problème.

**Migration vers le wiki**

Décision : migrer ces gabarits vers `~/dev/wiki/` (repo GitHub partagé Mac ↔ Hermes), en conservant le contenu verbatim (règle 14 du wiki — contenu légal/référence, jamais de synthèse qui perdrait une clause). Chaque fichier a reçu un frontmatter `type: source`, `sujet: contrats-medwin`, et une section "Fiches liées" vers les autres pièces du cluster.

Deux exclusions décidées avec Medwin :
- Vieux fichier CGV mono-bloc (pré-modularisation, spécifique Notion) — jugé obsolète, non migré
- RGPD (`rgpd.md`, recherche, checklists) — reporté dans un premier temps par prudence doublon avec le contenu RGPD déjà présent dans le wiki (cluster `notion-rgpd`)

**Le problème découvert après la migration**

Medwin a fait remarquer, à raison, qu'on venait de créer une **double source de vérité** : les fichiers wiki nouvellement créés coexistaient avec les fichiers originaux vibe-method, et le skill `/cgv` (étape 3) lisait toujours ces derniers en dur. Toute future modification d'un côté sans l'autre aurait silencieusement divergé.

Correction : `.claude/commands/cgv.md` repointé pour lire `~/dev/wiki/cgv-*.md`. Les 4 fichiers `cgv.*.md` de vibe-method supprimés (`git rm`, plus dans l'historique Git mais plus dans l'arbre de travail). Le gabarit propal, qui n'était même pas versionné dans vibe-method, supprimé directement (`rm`).

**Le cas RGPD — pourquoi il n'a pas suivi le même chemin**

Question posée : fallait-il migrer aussi `rgpd.md` vers le wiki, puisque les CGP y font référence ? Vérification : `rgpd.md` n'a **aucun lien textuel direct** avec les CGV, mais il est lu en dur par deux autres skills (`/archi` sections 2/3/4, `/deploy` sections 3/12) — c'est une doctrine active du même type que `securite.md`/`tests.md`/`stack.md`, appliquée à chaque nouveau projet, pas un gabarit contractuel figé comme une CGV. Le migrer aurait cassé `/archi` et `/deploy` sans bénéfice réel, et sorti du périmètre "doctrine vibe-method" que le `CLAUDE.md` du repo lui assigne explicitement.

Décision finale : `rgpd.md` reste dans vibe-method. Les CGP wiki (CP.10/CP.12) reçoivent chacune une note pointant vers `~/dev/vibe-method/rgpd.md` en texte simple (pas de `[[wikilink]]`, hors vault — aurait créé un lien mort dans Obsidian) — pas de duplication de contenu, pour ne pas recréer le même problème une deuxième fois.

**L'étape suivante — logique de sélection et d'assemblage**

Une fois la source unifiée, Medwin a demandé : comment Hermes fait-il, lui, pour générer un CGV/une propal ? Réponse : cette logique existe déjà côté Claude Code — c'est justement ce que fait `/cgv` (détermination du modèle M1/M2/M3, collecte des variables, assemblage) et `/devis` (qualification client, estimation, calibrage tarifaire). Mais rien d'équivalent côté Hermes.

**Décision — skills miroirs plutôt que partage de code**

Claude Code lit `.claude/commands/`, Hermes lit `/opt/data/skills/` — deux runtimes sans mécanisme de partage direct. Pattern déjà validé sur ce projet pour `/lint` (Claude Code) ↔ `wiki-lint` (Hermes) : deux fichiers de procédure séparés qui appliquent la même logique sur les mêmes données.

Deux skills Hermes créés en miroir, déployés sur le VPS via SSH direct (`/docker/hermes-agent-8b0z/data/skills/productivity/`) :
- `cgv-generation` — miroir de `/cgv`, lit `/opt/data/wiki/cgv-*.md`
- `devis-generation` — miroir de `/devis`, différence notable : utilise le MCP Exa d'Hermes, déjà actif en permanence, alors que la version Claude Code doit demander à Medwin de connecter Exa via `/mcp` avant de lancer la recherche

Références croisées ajoutées dans les quatre fichiers (`related_skills` côté Hermes, note en tête de fichier côté vibe-method) pour rappeler que toute évolution de la logique doit être répercutée manuellement dans le miroir — pas de synchronisation automatique.

#### Décisions prises

- Wiki devient l'unique source de vérité pour CGV/CGP/propal — vibe-method ne conserve plus de copie
- `rgpd.md` reste hors wiki, référencé par pointeur texte depuis les CGP
- Skills Hermes `cgv-generation` et `devis-generation` créés en miroir strict de `/cgv` et `/devis`
- Synchro entre les paires de skills documentée comme manuelle, à vérifier à chaque modification de l'un des deux côtés

#### Difficultés

Le principal écueil de la session n'était pas technique mais méthodologique : la première migration (fichiers vers le wiki) a été faite sans vérifier si la logique de lecture des skills concernés devait être mise à jour en même temps — d'où la double source de vérité créée puis corrigée. Point de vigilance pour les prochaines migrations de fichiers référencés par un skill : toujours vérifier *qui lit ce fichier en dur* avant de le déplacer, pas seulement où le déplacer.

---

## 2026-07-21

### Session — Skill caveman transmis à Hermes + un cas concret de dérive de miroir détecté et corrigé

**Point de départ**

Medwin a demandé de transmettre à Hermes le contenu du skill `caveman` (mode de communication ultra-compressé, plugin `JuliusBrussee/caveman` installé côté Claude Code) pour qu'Hermes construise l'équivalent pour lui-même. Transmission faite via le canal fichier `hermes_exchange.md` déjà en place — Hermes le lira au prochain "check claude" que Medwin lui donnera.

**Le devis, ensuite**

Question suivante de Medwin : est-ce qu'un skill équivalent à `/devis` existe ? Réponse à partir de la doctrine et de la page wiki : oui, et il fait plus que générer un document — qualification client en 6 dimensions via `exa:search` (8 angles de recherche), estimation en deux blocs (phases workflow calibrées + blocs dev par patterns Supabase/Convex), calibrage tarifaire interne (jamais montré au client), et grille de décision commerciale.

**Le réflexe qui a évité une duplication inutile**

Medwin a ensuite demandé de transmettre aussi ce skill à Hermes. Avant d'exécuter, vérification de l'état du skill Hermes `devis-generation` (créé la veille, 2026-07-20, en miroir de `/devis`) — déjà présent, à jour, quasi identique ligne pour ligne. Envoyer le contenu aurait été redondant.

Mieux : la comparaison fine des deux fichiers a révélé un écart dans le sens inverse de celui attendu. Le miroir Hermes contenait une section "Engagements RGPD" (statut sous-traitant art. 28, destruction des fichiers sources en fin de mission, certification DPF des outils tiers, registre des traitements) totalement absente de la version source `/devis` sur Mac. Cette section avait dû être ajoutée à Hermes à un moment non documenté dans le log vibe-method — signe que la synchro manuelle entre les deux miroirs (actée la veille comme "à vérifier à chaque modification") a un angle mort : elle suppose que les modifications partent toujours du côté Mac, alors qu'ici l'évolution est venue du côté Hermes sans être remontée.

**Décision et correction**

Plutôt que d'écraser le skill Hermes avec la version Mac (ce qui aurait fait perdre la section RGPD), la section a été backportée dans `.claude/commands/devis.md` — les deux miroirs sont maintenant réalignés, dans le sens Hermes → Mac cette fois. Un pointeur texte vers `rgpd.md` a été ajouté en fin de skill, cohérent avec la convention actée la veille (pas de wikilink vers une doctrine hors vault).

**Ce qui reste ouvert**

La synchro manuelle entre `/devis` et `devis-generation` (et entre `/cgv` et `cgv-generation`) n'a toujours pas de garde-fou automatique dans les deux sens. Si Hermes continue à évoluer ses skills de façon autonome sans que ça remonte au log vibe-method, ce type d'écart silencieux se reproduira. Pas de solution actée pour l'instant — juste le constat.

---

## 2026-07-24

### Session — État des lieux vibe-method

**Constat de départ**

Medwin a demandé où en était la vibe-method et si elle était "finie". Réponse : ce n'est pas un projet avec une ligne d'arrivée, c'est une méthode vivante — enrichie session après session. Ce qu'on peut mesurer, c'est l'état de fonctionnement (chaîne de skills complète, 39 skills opérationnels) et l'écart entre `vibe-method.todo.md` et les commits réels.

**L'écart trouvé**

`git log` a montré 6 commits après la dernière mise à jour du todo (2026-05-26) : la migration des gabarits CGV/CGP vers le wiki, la création des miroirs Hermes, le backport RGPD — tout ce travail des sessions du 2026-07-20 et 2026-07-21 documenté dans `.peda`/`.log` mais jamais reporté dans `.todo`. Rappel du rôle de `.todo.md` : ce n'est pas un journal (ça c'est `.log`), c'est une photo de l'état courant pour se réorienter vite en début de session — un écart de deux mois entre les deux le rend trompeur.

**Tâche 28 détaillée**

Medwin a demandé ce qu'était `aidd-orchestrator` (tâche 28, en attente). Explication depuis le `.todo.md` : plugin tiers du marketplace AIDD Framework, agent AFK qui lit une issue GitHub labellisée, implémente, ouvre une PR sans supervision. Point soulevé au passage, pas encore tranché : la règle mémoire "plugins officiels seulement" (`claude-plugins-official`) entre en tension avec ce plugin tiers — à trancher explicitement le jour où la tâche sort de l'attente, pas avant.

**Action**

`/majtodo` lancé pour combler l'écart : nouvelle section "Dernière session" avec le résumé factuel des deux sessions manquantes, tableau d'état enrichi de 2 lignes (CGV/CGP source unique, miroirs Hermes en synchro manuelle). Commit `49fc35c`.

---

## 2026-07-27

### Session — Intégration Radio vibe-method #10 + lint wiki + corrections diverses

**Point de départ**

Medwin a demandé d'analyser un nouveau fichier `Radio vibe-method #10.md` (transcript podcast) pour en extraire ce qui est utile à la méthode. Premier jet d'analyse jugé "brouillon" par Medwin — items présentés sans dire clairement lesquels étaient nouveaux, déjà couverts, ou en contradiction avec la doctrine existante. Leçon : comparer explicitement contre le contenu réel des fichiers avant de proposer, pas juste résumer ce qu'on vient de lire.

**Reprise méthodique**

Relecture de `stack.md`, `securite.md`, `tests.md`, `methode.md`, `design.md` pour classer chaque item du podcast : Tailwind conditionnel (contradiction avec `design.md` — tranché : pas de changement, le workflow `/design` fournit toujours une référence de style donc le cas d'usage du podcast ne se pose pas chez nous), dépendances (précision ajoutée à `stack.md`), coûts cachés (nouveau — ajouté à `stack.md` + étape 2bis du skill `/stack`), limite de prélèvement CB (ajouté à `securite.md`), niveau d'effort par tier (nouveau, absent partout — ajouté à `methode.md`), Chrome DevTools MCP (recherche web faite : ne remplace pas Playwright, complémentaire pour le debug — ajouté au protocole d'escalade), branches en solo (contradiction confirmée, doctrine gardée telle quelle).

**Lint du wiki vibe-method**

Question de Medwin : le wiki vibe-method est-il à jour ? Vérification factuelle plutôt que supposition : les 4 pages wiki correspondant aux fichiers modifiés (`doctrines/stack`, `doctrines/securite`, `doctrines/methode`, `skills/stack`) affichaient encore `wiki_updated: 2026-05-26`. Découverte plus large en creusant : **chaque page doctrine et skill du wiki (68 au total) avait un chemin `source:` cassé** — un `../` manquant depuis la création du wiki, jamais détecté jusqu'ici. Corrigé en masse, plus 3 liens orphelins non qualifiés et une page manquante (`skills/wiki.md`, le skill `/wiki` n'avait jamais eu sa page).

**Synchronisation Notion**

La page Notion "Vibe-Method.WORKFLOW" (guide résumant chaque skill) mise à jour aux mêmes endroits — chemins `source:` non concernés (page Notion, pas de frontmatter fichier), mais ajout des points coûts cachés/dépendances/effort/Chrome DevTools au bon endroit dans la structure existante.

**Bug `.gitignore` découvert par ricochet**

En vérifiant si le wiki était bien sur GitHub (Medwin pensait que non — vérifié faux via `gh api`, il y était depuis le début), découverte que le skill `backup.md` n'était lui, jamais poussé : la règle `*backup*` du `.gitignore` (prévue pour des fichiers de sauvegarde temporaires) matchait par coïncidence le nom du skill. Ni la source (`.claude/commands/backup.md`) ni sa page wiki n'avaient jamais atteint GitHub depuis leur création. Règle resserrée à `*-backup`/`*_backup`, les deux fichiers ajoutés. Un fichier transcript "#8 vibe method - backup" traînait aussi dans le repo pour la même raison — supprimé sur demande de Medwin (jamais commité).

**Paliers de recherche web — doctrine Hermes adoptée**

Medwin a demandé si j'avais accès à la doctrine de recherche d'Hermes (3 niveaux avec mots déclencheurs — Tavily/Exa+Firecrawl/Sonar, trouvée dans `~/dev/hermes/hermes.log.md`). Comparaison faite avec mes propres outils, mapping proposé et validé, sauvegardé en mémoire. Correction en cours de route : première proposition substituait tout par Firecrawl sans vérifier — Medwin l'a relevé, Exa était en fait disponible via skill (`exa:search`/`exa:agent`), pas besoin de tout réinventer.

**Configuration Tavily + Perplexity + Exa**

Medwin a demandé d'ajouter Tavily et Sonar/Perplexity en MCP pour compléter le mapping. Étape bloquante trouvée avant d'agir : les clés `TAVILY_API_KEY` et `PERPLEXITY_API_KEY` d'Hermes étaient marquées comme exposées dans une session Claude Code du 2026-05-27, tâche de rotation jamais faite (`hermes.todo.md`). Signalé explicitement à Medwin avant toute action — décision de sa part : réutiliser les clés telles quelles, supprimer la tâche de rotation. Fait, commité côté `hermes`. Tavily et Perplexity ajoutés en scope `user` (dispo dans toutes les sessions, pas juste le dossier courant — erreur initiale corrigée après un premier essai en scope `local`). Exa authentifié dans la foulée (jusque-là listé comme "needs authentication" dans `claude mcp list`, jamais signalé à Medwin malgré l'avoir vu — reconnu comme un oubli, pas un problème caché).

**IDs de modèles Claude périmés dans la doctrine**

Medwin a demandé si mes données sur les modèles étaient à jour. Réponse honnête : cutoff d'entraînement janvier 2026, on est en juillet. Vérification immédiate contre le tableau des tiers de `methode.md` : `claude-sonnet-4-6` et `claude-opus-4-8` référencés — génération 4.x, alors que la gamme actuelle (donnée fiable, injectée par le système) est la 5. Corrigé en `claude-sonnet-5`/`claude-opus-5`.

**Recherche sur le meilleur modèle pour `/brief` — deux ratés avant la bonne méthode**

Question de Medwin : quel modèle pour faire un `/brief` sur RAMrezo ? Trois itérations avant une réponse solide :
1. Recherche `WebSearch` générique ("meilleurs modèles LLM juillet 2026") — jugée décevante par Medwin à raison : trop vague, ne répond pas à la vraie question (élicitation de besoins, pas benchmark général), et palier pas monté malgré un résultat pourri.
2. Reprise avec `exa:search` (palier 2, 2 sous-agents) — mais scope limité aux IA américaines. Medwin a relevé l'angle mort : la doctrine `/stack` mentionne déjà Kimi K2.5, le podcast du jour parle de DeepSeek/GLM/Qwen — pas les inclure était une vraie lacune, pas un détail.
3. Reprise élargie (DeepSeek, Qwen, GLM, Kimi K2.5 inclus) — mais les benchmarks académiques remontés (ClarifyMT-Bench, ClarQ-LLM) testaient des générations de modèles déjà périmées (GPT-4.1, Claude-Sonnet-4.5, Qwen-2.5). Medwin l'a relevé une seconde fois, plus sec cette fois : j'aurais dû filtrer la fraîcheur moi-même avant de présenter, pas le laisser détecter le problème.

Correction finale : `perplexity_research` (Sonar Deep Research, palier 3) avec consigne explicite de ne garder que juin-juillet 2026 et de flaguer toute source parlant d'une génération périmée. Résultat vérifié par un sous-agent dédié (fraîcheur 9/10, seule source ancienne explicitement écartée par Perplexity lui-même). Verdict final : **Claude Opus 5** en tête pour la clarification proactive de besoins flous (pas Sonnet comme dit initialement) — recommandation ajustée en conséquence pour `/brief` sur RAMrezo : Opus 5, effort high. Pas écrit dans la doctrine — c'était une recommandation ponctuelle pour ce lancement de projet, pas une règle générale actée.

**Leçon retenue sur la méthode de recherche**

Le fil conducteur des trois ratés : je n'ai filtré la fraîcheur et la portée qu'après que Medwin l'ait signalé, jamais avant de présenter un résultat. À appliquer désormais dès la formulation de la requête — nommer explicitement les générations de modèles voulues, pas laisser une recherche générique remonter du contenu daté sans le vérifier moi-même en premier.

**Ce qui reste ouvert**

- Graphify (outil de knowledge graph pour codebase) discuté à la demande de Medwin — jugé prématuré pour RAMrezo (utile au-delà de 100 fichiers, projet pas encore démarré), à ressortir en cours de projet si la complexité le justifie. Rien écrit dans la doctrine, juste une conversation.
- Noms d'outils exacts exposés par les MCP `tavily-remote-mcp` et `perplexity` pas encore vérifiés au moment de leur ajout (nécessitait un redémarrage de session) — confirmés disponibles plus tard dans la session (`mcp__perplexity__*`, `mcp__tavily-remote-mcp__*`).
- `/brief` n'a toujours pas de tier assigné explicitement dans le tableau de `methode.md` — gap identifié, pas comblé (proposé à Medwin, pas encore tranché).
