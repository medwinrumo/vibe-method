# Grille d'évaluation stratégique — Doctrine vibe-method

_Construite le 2026-05-11. Utilisable pour conduire les tâches 5 et 6 du todo._

---

## Rappel des deux tâches cibles

**Tâche 5 — Audit de cohérence interne** : vérifier que tous les fichiers de doctrine et tous les skills sont alignés — pas de contradiction, pas de référence à un skill ou fichier inexistant, pas de règle dans un skill qui contredit un autre.

**Tâche 6 — Audit et enrichissement des skills** : vérifier que les skills contiennent les bonnes références (doc URLs, versions, scripts), que `/archi` vérifie les versions par WebSearch, que les implications en cascade sont explicites. Inclure notamment : ajout de `securite.md` comme source du `/prp`.

---

## Observations préliminaires identifiées à la lecture

Ces points sont des hypothèses à confirmer ou infirmer pendant l'audit — pas des verdicts.

- La doctrine backup est dans `architecture.md` (section "Backup & conformité RGPD"), mais `securite.md` section 1.8 dit "À enrichir lors d'une session dédiée" sans pointer vers `architecture.md`. Risque de doublon ou d'incomplétude selon la perspective d'entrée.
- `securite.md` section 1.6 "Données sensibles" contient une note "À enrichir lors d'une session dédiée" — section volontairement incomplète.
- `securite.md` section 1.7 renvoie vers `rgpd.md` pour la doctrine complète, mais `rgpd.md` section 11 dit "les skills seront mis à jour pour intégrer ces points de vérification — c'est l'objet de la tâche 3". Cette tâche 3 est marquée réalisée dans le todo mais sa complétude est à vérifier.
- Le skill `/prp` ne référence pas `securite.md` dans sa liste d'inputs (tâche 6 le mentionne explicitement comme point à corriger).
- Le skill `/tests` (commande) liste `tests.md` comme doctrine de référence mais ne mentionne pas `stack.md` — pourtant `stack.md` indique que `/tests` doit le lire (tableau "Comment les autres skills utilisent stack.md").
- `design.md` mentionne Stitch (Google) comme outil de génération de maquette. Stitch est un outil récent dont la disponibilité et le périmètre sont à vérifier par WebSearch au moment de l'audit.

---

## Axe 1 — Qualité intrinsèque des règles

### Définition des critères

Un fichier de doctrine est une collection de règles destinées à guider une IA pendant une session de développement. La question centrale : une IA peut-elle opérer correctement sur ces règles sans interprétation ?

| Critère | Définition | Question de test |
|---|---|---|
| **AI-actionable** | La règle dicte une action précise, pas un principe général | "Quelle action concrète cette règle déclenche-t-elle dans un transcript de session ?" |
| **Testable** | On peut vérifier dans le code ou dans le transcript que la règle a été respectée | "Peut-on écrire un scénario Gherkin pour vérifier cette règle ?" |
| **Non-ambiguë** | Une seule interprétation raisonnable | "Deux développeurs interpréteraient-ils cette règle de la même façon ?" |
| **Complète** | La règle couvre tous les cas qu'elle prétend couvrir | "Existe-t-il un cas légal qui violerait l'intention de la règle sans la violer textuellement ?" |
| **Frontière nette** | La règle n'est pas dupliquée ou contredite dans un autre fichier de doctrine | "Cette règle existe-t-elle ailleurs dans un autre fichier avec une formulation différente ?" |

### Grille de notation par règle

Pour chaque règle identifiée comme problématique pendant l'audit :

```
Règle : [citation exacte]
Fichier : [nom du fichier]
Section : [numéro/titre]
AI-actionable : OUI / NON — [justification si NON]
Testable : OUI / NON — [justification si NON]
Non-ambiguë : OUI / NON — [ambiguïté identifiée si NON]
Complète : OUI / NON — [cas non couverts si NON]
Frontière nette : OUI / NON — [doublon ou contradiction identifié si NON]
Action requise : [reformuler / compléter / supprimer / aligner avec [fichier]]
```

### Signaux d'alarme à chercher activement

Lors de la lecture de chaque fichier, noter systématiquement :

- Règles formulées avec "essayer de", "dans la mesure du possible", "si applicable sans autre précision" → ambiguïté
- Règles avec "À enrichir lors d'une session dédiée" → incomplétude actée
- Règles qui posent un principe sans donner la procédure → non-actionnable
- Règles qui se terminent par "etc." → non-complètes
- Deux fichiers qui traitent le même sujet avec des formulations différentes → frontière floue

---

## Axe 2 — Couverture du domaine par fichier

### `securite.md`

**Périmètre attendu** : toutes les règles de sécurité applicables à tout projet web vibe-method, du niveau conception au niveau opérationnel.

**Sources primaires à consulter**
- OWASP Top 10 (2021) : `owasp.org/Top10/`
- OWASP ASVS (Application Security Verification Standard) : `owasp.org/ASVS/`
- CWE Top 25 (Common Weakness Enumeration) : `cwe.mitre.org/top25/`

**Questions d'audit**
- Les 10 catégories OWASP Top 10 sont-elles toutes couvertes ? (A01 Broken Access Control, A02 Cryptographic Failures, A03 Injection, A04 Insecure Design, A05 Security Misconfiguration, A06 Vulnerable Components, A07 Auth Failures, A08 Data Integrity Failures, A09 Logging Failures, A10 SSRF)
- La section 1.6 "Données sensibles" est marquée "À enrichir" — son état actuel est-il suffisant pour guider une IA ?
- La section 1.8 "Stratégie de backup" est marquée "À enrichir" — elle renvoie implicitement vers `architecture.md` mais sans le dire. Ce renvoi est-il explicite ou silencieux ?
- SSRF (Server-Side Request Forgery) est absent du fichier — est-ce un oubli ou un choix ?
- Les règles de la section 2bis "Gestion des ressources" sont-elles de la sécurité ou de l'architecture ? La frontière avec `architecture.md` est-elle nette ?

**Cas limites à vérifier**
- Une IA qui lit `securite.md` en isolation, sans `rgpd.md` : reçoit-elle toutes les règles nécessaires pour un projet avec données personnelles EU ?
- La checklist de la section 3.1 est-elle exhaustive par rapport aux règles des sections 1 et 2 ?

---

### `rgpd.md`

**Périmètre attendu** : doctrine RGPD complète pour les projets vibe-method — applicable en Europe, pour les modèles B2C et SaaS B2B, sur les stacks Supabase et Convex.

**Sources primaires à consulter**
- Texte officiel RGPD : les articles cités dans le fichier (art. 6, 13-14, 15-22, 28, 30, 33-34, 35, 37)
- CNIL : `cnil.fr` (désigné dans le fichier comme source de référence)
- DPF : `dataprivacyframework.gov` (pour vérification des certifications)

**Questions d'audit**
- La section 11 "Hooks avec les skills" dit que "les skills seront mis à jour pour intégrer ces points" (tâche 3 réalisée). Chaque skill mentionné a-t-il effectivement reçu ses points RGPD ? Vérifier : `/brief`, `/archi`, `/specs`, `/stack`, `/deploy`, `/code-review`.
- La checklist section 12 est-elle référencée dans le skill `/deploy` ? (Oui, mais vérifier l'exhaustivité)
- Le cas du consentement dans la checklist section 12 : la case "Bannière de consentement cookies si applicable" — le "si applicable" est-il défini précisément quelque part ?
- La checklist section 12 est-elle disponible dans le `/prp` pour être rappelée à chaque session de code ?

**Cas limites à vérifier**
- Un projet avec uniquement des utilisateurs hors EU : quelles règles ne s'appliquent pas ? Le fichier l'indique-t-il ?
- Un projet niveau 1 (aucune donnée personnelle) : doit-il quand même avoir une politique de confidentialité si une adresse email est collectée pour l'authentification ?

---

### `architecture.md`

**Périmètre attendu** : patterns d'organisation du code (modulaire, silos), stacks de référence, décisions de déploiement, doctrine backup, doctrine MCP. Fichier le plus dense de la doctrine.

**Sources primaires à consulter**
- 12-Factor App : `12factor.net`
- Clean/Hexagonal Architecture : Martin Fowler, Robert Martin
- Spec officielle MCP (Model Context Protocol) : `modelcontextprotocol.io`
- Documentation officielle Convex : `docs.convex.dev`
- Documentation officielle Supabase : `supabase.com/docs`

**Questions d'audit**
- La frontière entre `architecture.md` et `securite.md` section 2bis "Gestion des ressources" est-elle nette ? La section 2bis est dans le fichier sécurité mais traite de performance/architecture.
- La section "Backup & conformité RGPD" dans `architecture.md` et `securite.md` sections 1.7-1.8 sont-elles redondantes ou complémentaires ?
- Les règles silo sont définies dans `architecture.md` ET répétées dans le skill `/archi`. Si les deux divergent un jour, laquelle prime ?
- La règle "Niveau d'abstraction maximal" apparaît à la fois dans `architecture.md` (section "Règles actées") et dans le skill `/archi` (section "Principe directeur"). Cohérence à vérifier.
- La doctrine MCP est récente (tâche 14, mai 2026). Les autres skills qui touchent les dépendances externes ont-ils été mis à jour pour y référer ?

**Cas limites à vérifier**
- Un projet sans base de données (app statique) : les règles backup s'appliquent-elles ? Le fichier l'indique-t-il ?
- Un projet monorepo (mentionné comme option dans `/archi`) : les règles silo s'appliquent-elles différemment ?

---

### `tests.md`

**Périmètre attendu** : doctrine de test complète — niveaux, ordre d'exécution, format Gherkin, règles anti-auto-validation, couverture fonctionnelle.

**Sources primaires à consulter**
- Spécification Gherkin officielle (Cucumber) : `cucumber.io/docs/gherkin/`
- Documentation Playwright : `playwright.dev/docs/`
- Playwright Test Agents : `playwright.dev/docs/test-agents`
- ISTQB Foundation syllabus : `istqb.org`
- Doctrine TDD : Kent Beck, "Test Driven Development by Example"

**Questions d'audit**
- L'ordre d'exécution dans `tests.md` (6 étapes) est-il cohérent avec l'ordre dans `methode.md` Phase 7 (8 étapes) ? Vérifier chaque étape numérotée.
- `tests.md` mentionne Playwright Test Agents (v1.56+). Cette version est-elle la version actuelle ? À vérifier par WebSearch.
- La règle "un scénario Gherkin = un test Playwright" : que se passe-t-il pour les scénarios qui ne peuvent pas être automatisés (ex: validation visuelle subjective) ?
- L'anti-auto-validation a une "Règle a" et une "Règle c" — la règle b est absente. Oubli ou choix ?
- Le fichier ne mentionne pas Vitest dans les "Outils de référence" pour les unit tests (il est dans le tableau mais pas dans la doctrine).

**Cas limites à vérifier**
- Un projet React Native : Playwright ne fonctionne pas nativement sur iOS/Android. Quelle alternative ? Le fichier l'indique-t-il ?
- Un projet sans User Stories (brownfield, reprise d'existant) : comment les Gherkins sont-ils générés ?

---

### `stack.md`

**Périmètre attendu** : méthodologie de spike technique, cadre d'investigation à 7 points, format du document produit, checklists par stack (Convex, Supabase, Playwright).

**Sources primaires à consulter**
- Méthodologie de spike : ThoughtWorks, "Agile Estimating and Planning" (Mike Cohn)
- Limites actuelles Convex free tier : `docs.convex.dev/production/state/limits`
- Limites actuelles Supabase free tier : `supabase.com/docs/guides/platform/billing-faq`
- Playwright current version : `playwright.dev`

**Questions d'audit**
- Les checklists Convex et Supabase sont-elles à jour ? Les limites free tier changent régulièrement. Vérifier par WebSearch.
- Le cadre d'investigation à 7 points dans `stack.md` (doctrine) est-il strictement identique aux 7 étapes dans le skill `/stack` (commande) ? Vérifier la cohérence.
- Le tableau "Comment les autres skills utilisent stack.md" liste `/tests` — mais le skill `/tests` ne mentionne pas explicitement `stack.md`. Cette instruction est-elle dans le skill ?
- La mention "Playwright Test Agents : résultats mesurés 70-80% plus rapide" — cette stat a une source ? À vérifier.

**Cas limites à vérifier**
- Un projet qui utilise une stack hors Convex/Supabase (ex : Firebase pour Minou V1) : le cadre d'investigation s'applique-t-il ? La checklist est absente pour Firebase.
- Un projet qui combine Stack A et Stack B : `stack.md` ne couvre pas ce cas.

---

### `produit.md`

**Périmètre attendu** : méthodologie produit — hiérarchie Brief > PRD > Backlog > User Story > Specs, format User Story A4, format Gherkin.

**Sources primaires à consulter**
- Format Gherkin : spécification Cucumber officielle
- User Story mapping : Jeff Patton, "User Story Mapping"
- Méthode INVEST pour les User Stories

**Questions d'audit**
- `produit.md` est volontairement court. La hiérarchie Brief > PRD > Backlog > User Story est déclarée mais pas détaillée — est-ce suffisant ou les skills se chargent-ils du détail ?
- Le format User Story A4 dans `produit.md` a 4 champs (Titre, Description, Règles de gestion, Critères d'acceptation). Le skill `/specs` produit un format différent (ajoute Cas limites, Cas d'échec, Contexte d'implémentation, Definition of Done). Divergence ou évolution ?
- La méthode de construction PRD (cross-pollination entre IA) est décrite dans `produit.md` mais le skill `/prd` est supposément la source de vérité. Les deux sont-ils cohérents ?

**Cas limites à vérifier**
- Le signal de découpage "15-20 scénarios Gherkin" dans `produit.md` vs "5 règles de gestion" dans le skill `/specs` : deux critères différents pour la même décision. Lequel prime ?

---

### `methode.md`

**Périmètre attendu** : workflow complet de développement — greenfield vs brownfield, 7 phases, règles Git, doctrine agents IA, skills transversaux.

**Sources primaires à consulter**
- Aucune source externe critique (c'est une doctrine interne) — vérification principalement interne : cohérence avec les skills et les autres fichiers de doctrine.

**Questions d'audit**
- La Phase 7 "Vérification" dans `methode.md` liste 8 étapes. `tests.md` en liste 6. `code-review.md` dit "4. /code-review". Les numérotations sont-elles cohérentes ? Vérifier que les étapes sont les mêmes (même si présentées différemment).
- La Phase 4 "Stack" mentionne "stack applicative" et "stack de dev" — le skill `/stack` couvre les deux. Vérifier que l'étape 0bis du skill correspond bien à la "stack de dev" décrite dans `methode.md`.
- La doctrine "Agents IA" dans `methode.md` a-t-elle un skill associé, ou est-elle uniquement doctrinal ?
- La Phase 6 "Code" dit "contexte minimal — CLAUDE.md + module ciblé + specs de la feature". Le skill `/prp` est-il mentionné ici ou ailleurs comme le mécanisme d'implémentation de ce principe ?

**Cas limites à vérifier**
- Workflow brownfield : l'inventaire de codebase et la couverture de régression sont mentionnés mais aucun skill ne les implémente explicitement. Gap ou in-scope ?

---

### `design.md`

**Périmètre attendu** : workflow de conception visuelle — de l'export features au design system, outils (Stitch, Figma, Tailwind, shadcn/ui).

**Sources primaires à consulter**
- Stitch (Google) : vérifier l'état actuel de l'outil par WebSearch (`labs.google/flow/stitch`)
- shadcn/ui : `ui.shadcn.com`
- Tailwind CSS : `tailwindcss.com`
- Documentation Claude Design (Anthropic Labs) : vérifier la disponibilité actuelle

**Questions d'audit**
- Stitch est un outil de recherche (Google Labs). Sa disponibilité et son périmètre doivent être vérifiés par WebSearch — l'outil peut avoir évolué ou être retiré.
- Le skill `/design` Mode A et Mode B : sont-ils cohérents avec la description dans `design.md` ? Le workflow en 4 étapes du fichier correspond-il aux étapes du skill ?
- `design.md` ne mentionne pas Claude Design. Le skill `/design` et `CLAUDE.md` le mentionnent. Incohérence ou `design.md` est volontairement limité à la doctrine ?
- La note dans `CLAUDE.md` dit "Tâche 1 — Recherche Claude Design + skill frontend-design" reste à faire. `design.md` est donc potentiellement incomplet en attendant cette tâche.

**Cas limites à vérifier**
- Un projet React Native : shadcn/ui et Tailwind ne fonctionnent pas nativement. Le fichier ne couvre pas ce cas. NativeWind est mentionné dans `architecture.md` mais pas dans `design.md`.

---

## Axe 3 — Intégration dans le workflow

### Carte des références réelles (skills → doctrine)

Résultat d'investigation directe dans les fichiers skills :

| Skill | Fichiers de doctrine référencés explicitement |
|---|---|
| `/archi` | `architecture.md` (3b + 4c), `rgpd.md` (4c), `stack.md` (indirect via Stack A/B) |
| `/securite` | `securite.md` |
| `/stack` | `stack.md` |
| `/specs` | `securite.md` (contrainte de sécurité dans le template) |
| `/tests` | `tests.md` |
| `/code-review` | `securite.md` |
| `/deploy` | `rgpd.md` (section 12 dans checklist), `architecture.md` (niveau de déploiement) |
| `/prp` | aucun fichier de doctrine référencé (inputs : fichiers projets uniquement) |

### Gaps identifiés — skills qui devraient référencer une doctrine mais ne le font pas

| Skill | Doctrine absente | Impact |
|---|---|---|
| `/prp` | `securite.md` | Les contraintes de sécurité critiques du projet ne sont pas condensées dans le contexte de code. Tâche 6 le mentionne explicitement. |
| `/tests` (skill) | `stack.md` | `stack.md` dit que `/tests` doit lire les "patterns d'authentification et de mock pour savoir quoi tester contre le vrai service vs. mocker". Ce renvoi existe dans la doctrine mais pas dans le skill. |
| `/specs` | `rgpd.md` | La section 11 de `rgpd.md` dit que `/specs` doit déclarer la base légale et la durée de rétention de chaque feature qui collecte une donnée. Le skill ne le fait pas explicitement. |
| `/brief` | `rgpd.md` | Section 11 de `rgpd.md` dit que `/brief` doit identifier le type de données et la population concernée. Le skill `/brief` n'a pas été lu — à vérifier. |

### Présence dans `/prp` — ce qui arrive en contexte de code

Le skill `/prp` agrège : brief, prd, archi, CLAUDE.md du projet, stack, tests, design, spec de la feature en cours. Ce qui n'est PAS dans le `/prp` :
- `securite.md` (doctrine globale, pas fichier projet) → gap confirmé
- `rgpd.md` (doctrine globale) → absent, mais les décisions RGPD sont censées être dans `[projet].archi.md` (qui lui est dans le prp)
- `methode.md`, `architecture.md`, `produit.md`, `design.md`, `tests.md`, `stack.md` (doctrines globales) → absents par conception : c'est leur traduction projet-spécifique qui entre dans le prp

**Conclusion** : la seule doctrine globale qui manque dans le `/prp` et dont les règles ne transitent pas par un fichier projet est `securite.md`. Les règles de sécurité ne sont nulle part dans le contexte de code — ni dans `[projet].archi.md` (qui contient les décisions archi mais pas les règles sécurité générales), ni dans le prp.

---

## Méthode d'audit

### Ordre d'évaluation

Du plus critique au moins critique, selon le coût d'une règle ratée :

| Priorité | Fichier | Justification |
|---|---|---|
| 1 | `securite.md` | Une faille de sécurité en prod est irréversible (breach, données compromises) |
| 2 | `rgpd.md` | Non-conformité légale, amende CNIL, irréversible en cas de violation |
| 3 | `architecture.md` | Fondations structurelles : refactoring coûteux a posteriori, doctrine backup et MCP incluses |
| 4 | `tests.md` | Gate de la Definition of Done — une doctrine de test défectueuse laisse passer des bugs |
| 5 | `stack.md` | Décisions projet-spécifiques, rattrapables au `/stack` du projet concerné |
| 6 | `methode.md` | Process workflow — les skills implémentent la doctrine, les gaps sont moins immédiats |
| 7 | `produit.md` | Court, stable, peu risqué — vérification surtout interne |
| 8 | `design.md` | Visuel — moins bloquant pour la sécurité et la conformité |

### Protocole d'audit par fichier

Pour chaque fichier, dans cet ordre :

**Étape A — Lecture et marquage**
Lire le fichier complet. Marquer chaque règle avec l'un des signaux suivants :
- `[AI-OK]` : rule claire, actionnable, non-ambiguë
- `[AMBIGU]` : interprétation multiple possible
- `[INCOMPLET]` : section marquée "À enrichir" ou cas non couverts identifiés
- `[DOUBLON]` : même règle dans un autre fichier de doctrine
- `[GAP]` : sujet que le fichier devrait couvrir mais ne couvre pas

**Étape B — Vérification contre sources primaires**
Pour les fichiers 1-5, lancer une WebSearch sur les sources primaires listées en Axe 2. Comparer :
- Les règles de sécurité avec OWASP Top 10 (2021) — quel Top 10 n'est pas couvert ?
- Les règles RGPD avec les articles cités — le texte du fichier est-il fidèle aux articles ?
- Les limites de stack avec les pages officielles — les chiffres sont-ils à jour ?

**Étape C — Vérification des intégrations workflow**
Pour chaque fichier, vérifier :
- Quel skill est censé le lire ? (liste en Axe 3)
- Le skill le référence-t-il explicitement ?
- Si non : est-ce un gap à corriger ou un choix assumé ?

**Étape D — Consolidation des findings**
Produire pour chaque fichier :
```
## Findings — [fichier]
Règles AI-OK : [count]
Règles à corriger : [count]
Gaps vs sources primaires : [liste]
Gaps d'intégration workflow : [liste]
Doublons identifiés : [liste]
Actions recommandées : [liste ordonnée par priorité]
```

### Critère de validation — quand un fichier passe l'audit

Un fichier passe l'audit quand toutes ces conditions sont remplies :

1. **Chaque règle est AI-actionable** : on peut écrire "dans un transcript de session, cette règle se traduit par [action concrète]"
2. **Les gaps vs sources primaires sont soit comblés, soit déclarés out-of-scope avec justification** (ex : "SSRF non couvert car la stack cible ne permet pas de construire des requêtes serveur directes")
3. **Chaque règle est référencée par au moins un skill OU est listée comme doctrine stand-alone justifiée** (une règle qui ne transite par aucun skill n'est jamais appliquée)
4. **Pas de doublon non résolu avec un autre fichier de doctrine** — soit la règle est dans un seul endroit, soit les deux fichiers se referencent mutuellement de façon explicite
5. **Les sections "À enrichir" sont soit complétées, soit supprimées avec renvoi explicite vers le fichier qui couvre le sujet**

### Sessions d'audit recommandées

Ce travail ne se fait pas en une session. Découpage suggéré :

| Session | Fichiers | Durée estimée |
|---|---|---|
| Session 1 | `securite.md` + `rgpd.md` | 2-3h (WebSearch OWASP + CNIL) |
| Session 2 | `architecture.md` | 2h (dense, beaucoup de frontières à vérifier) |
| Session 3 | `tests.md` + `stack.md` | 2h (WebSearch Playwright + limites free tier) |
| Session 4 | `methode.md` + `produit.md` + `design.md` | 1-2h (audit interne principalement) |
| Session 5 | Alignement skills → doctrine (tâche 6) | 2-3h (lire chaque skill en regard de sa doctrine) |

### Déclencheurs de ré-audit

L'audit n'est pas un événement unique. Cette grille est reproductible — elle doit être relancée quand la doctrine évolue ou quand l'environnement externe change.

**Déclencheurs automatiques — relancer l'audit du fichier concerné :**

| Événement | Fichier(s) à ré-auditer |
|---|---|
| Modification de `securite.md`, `rgpd.md`, `architecture.md`, `tests.md`, `stack.md`, `produit.md`, `methode.md`, `design.md` | Le fichier modifié + tous les skills qui le référencent (Axe 3) |
| Nouvelle version majeure d'un outil référencé (Playwright, Vitest, Convex, Supabase, Tailwind, shadcn/ui) | `stack.md` + le skill qui utilise l'outil |
| Changement réglementaire RGPD (décision CJUE, recommandation CNIL, nouveau standard DPF) | `rgpd.md` + `/deploy`, `/archi`, `/specs` |
| OWASP publie une nouvelle version du Top 10 | `securite.md` + `/securite`, `/code-review` |
| Ajout d'un nouveau skill dans `.claude/commands/` | Axe 3 — vérifier quelles doctrines le nouveau skill devrait référencer |
| Ajout d'un nouveau fichier de doctrine | Tous les skills — vérifier quels skills devraient le référencer |

**Cadence minimale (sans déclencheur événementiel) :**
- `securite.md` et `rgpd.md` : tous les 6 mois (le paysage légal et les menaces évoluent)
- Autres fichiers : tous les 12 mois, ou avant le démarrage d'un nouveau projet majeur

---

## Axe 4 — Robustesse des skills (tâche 6)

Cet axe complète l'Axe 3. L'Axe 3 vérifie que les skills référencent les bonnes doctrines. L'Axe 4 vérifie que les skills implémentent deux mécanismes de robustesse identifiés dans la tâche 6 : vérification des versions par WebSearch, et gestion explicite des implications en cascade.

### Critère 4a — Vérification des versions par WebSearch

**Principe** : chaque fois qu'un skill fait une décision qui dépend d'une version de technologie (ex : choisir Convex, choisir Playwright, choisir une version de React), il doit déclencher une vérification WebSearch au moment de la décision — pas s'appuyer sur une version hardcodée dans la doctrine.

**Questions d'audit pour chaque skill :**
- Le skill prend-il des décisions de stack ou de technologie ?
- Si oui : existe-t-il une étape explicite "vérifier la version actuelle par WebSearch avant de conclure" ?
- Si non : la version est-elle hardcodée dans la doctrine ou dans le skill ? Si hardcodée → signal d'alarme.

**Skills concernés en priorité :**

| Skill | Décision technologique | Mécanisme WebSearch attendu |
|---|---|---|
| `/archi` | Choix Convex vs Supabase, règles silo | Étape 3b mentionne vérification MCP — vérifier si une vérification de version est dans le skill |
| `/stack` | Investigation stack complète (7 points) | C'est le skill dédié à l'investigation — vérifier que le point 5 "Free tier" inclut une WebSearch obligatoire, pas une lecture de `stack.md` |
| `/tests` | Playwright version, Test Agents disponibilité | Aucune WebSearch identifiée — gap probable |
| `/prp` | Aucune décision technologique | Non concerné |

**Critère de passage** : pour tout skill qui prend une décision technologique, au moins une étape dit explicitement "vérifier [version ou disponibilité] par WebSearch avant de conclure".

### Critère 4b — Implications en cascade

**Principe** : après une décision majeure d'architecture ou de stack, les décisions qui en découlent doivent être identifiées explicitement — pas laissées implicites.

**Définition d'une décision "majeure"** : une décision qui contraint d'autres modules, d'autres skills, ou d'autres fichiers de doctrine. Exemples : choix du backend (Convex vs Supabase), choix de déploiement (Vercel vs autre), activation d'un MCP.

**Questions d'audit pour chaque skill :**
- Après chaque décision majeure, le skill dit-il explicitement "cette décision implique : [liste]" ?
- Ou délègue-t-il cette responsabilité à Medwin sans lui donner d'outil ?

**Skills à vérifier en priorité :**

| Skill | Décision majeure produite | Cascade attendue |
|---|---|---|
| `/archi` | Choix backend (Stack A vs B) | Implique : free tier limits (→ `/stack`), règles silo pour ce backend, doctrine MCP applicable |
| `/archi` | Choix de déploiement (niveau 1/2/3) | Implique : monitoring, backup strategy, coûts estimés |
| `/stack` | Confirmation de stack | Implique : mise à jour `[projet].archi.md` si la stack choisie contredit une décision archi préalable |
| `/prd` | Ajout d'une feature avec données personnelles | Implique : RGPD hooks dans `/specs` pour cette feature |

**Critère de passage** : chaque skill qui produit une décision majeure doit, à l'étape de validation finale, lister explicitement les décisions qu'elle déclenche dans d'autres skills ou dans d'autres modules.

### Critère de validation — quand un skill passe l'audit de robustesse

Un skill passe l'audit de robustesse (Axe 4) quand :

1. **Références doctrine complètes** : chaque doctrine que le skill est censé appliquer (Axe 3) est explicitement citée dans le skill avec sa règle applicable.
2. **WebSearch obligatoire pour les décisions technologiques** (Critère 4a) : si le skill prend une décision qui dépend d'une version ou d'une disponibilité d'outil, une étape WebSearch est dans le texte.
3. **Cascade explicite pour les décisions majeures** (Critère 4b) : si le skill produit une décision structurante, il liste les implications en fin d'étape.
4. **Pas de règle contredite** : aucune règle dans le skill ne contredit une règle dans sa doctrine de référence.
5. **Outputs documentés** : l'output produit par le skill (fichier `.md`, mise à jour Notion) est spécifié dans le skill avec son nom exact et son emplacement.

---

## Périmètre — fichiers satellites

Certains fichiers de la mémoire du projet ne sont pas des fichiers de doctrine à proprement parler. Ils servent de sources primaires ou de notes de travail. Leur statut doit être décidé avant l'audit pour éviter de les évaluer avec les mauvais critères.

### Fichiers identifiés

| Fichier | Nature probable | Décision recommandée |
|---|---|---|
| `appstore.md` (ou équivalent) | Référence technique Apple App Store / Google Play — contraintes de déploiement natif | **Source primaire** : à lire lors de l'audit de `architecture.md` et du skill `/archi`, pas à auditer comme fichier de doctrine |
| Notes `apple-hig-react-native.md` (dans la mémoire) | Notes de recherche sur Apple HIG × React Native — tâche 2 non réalisée | **Note de travail** : hors scope de l'audit doctrine. À intégrer dans `architecture.md` ou `design.md` quand la tâche 2 sera réalisée |
| Notes `claude-design.md` (dans la mémoire) | Notes sur Claude Design (Anthropic Labs, research preview) — positionnement dans la chaîne | **Note de travail** : hors scope de l'audit doctrine. À intégrer dans `design.md` quand la tâche 1 sera réalisée |
| `audit-doctrine-strategie.md` (ce fichier) | Grille d'évaluation — outil de travail | **Hors scope** : ce fichier est l'outil, pas la doctrine |

### Règle de décision pour les fichiers satellites

Un fichier est une **source primaire** si : il documente des contraintes externes (règles App Store, spécification OWASP, texte réglementaire) que la doctrine cite comme références.

Un fichier est une **note de travail** si : il contient des investigations ou des décisions en cours d'élaboration, pas encore stabilisées dans un fichier de doctrine.

Un fichier est **doctrine** si : il contient des règles stabilisées et actées, destinées à être appliquées par l'IA pendant les sessions de développement.

**Conséquence** : seuls les 8 fichiers listés dans le header (`architecture.md`, `securite.md`, `tests.md`, `stack.md`, `rgpd.md`, `produit.md`, `methode.md`, `design.md`) sont dans le périmètre de l'audit de cette grille.

---

*Document vivant. Mettre à jour après chaque session d'audit avec les findings réels.*
