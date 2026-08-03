# architecture.md

Décisions d'organisation du code — patterns, structure, indépendance des modules.
À construire ensemble — aucune règle ici sans validation de Medwin.

---

## Principe fondateur

**Plus le contexte donné à l'IA est petit et ciblé, plus elle est performante.**

Toutes les décisions d'architecture découlent de ce principe : modules isolés, fichiers bien délimités, CLAUDE.md ciblé par projet. Un contexte lourd = l'IA oublie des détails, fait des erreurs subtiles. Un contexte minimal = l'IA est focalisée et fiable.

---

## Règle du back-end piloté par l'IA

**La vibe-method permet à l'IA de piloter le back-end en toute sécurité grâce à trois garde-fous :**

1. **Schéma validé par vous** (`/archi`) — l'architecture est définie et validée avant toute implémentation. L'IA ne décide pas, elle exécute.
2. **Sécurité contrôlée** (`/securite`) — chaque décision d'accès, d'authentification, de gestion des données est examinée explicitement avant le code.
3. **Recette fonctionnelle** (`/recette`) — chaque feature est testée en langage métier (Gherkin) avant validation. L'IA n'interprète pas, elle valide contre un cahier des charges.

C'est cette combinaison (archi + sécurité + recette) qui différencie la vibe-method. D'autres approches laissent l'IA coder sans ces garde-fous — d'où les bugs, les failles, les incompréhensions. Ici, chaque étape est cadenassée.

---

## Choisir son architecture — 3 questions + 4 familles

Avant toute décision de stack, 3 questions déterminent la complexité du projet :

1. L'app a-t-elle besoin d'une base de données ?
2. Les utilisateurs doivent-ils s'authentifier ?
3. Y a-t-il des services tiers à connecter ? (clés API, paiement, etc.)

Les réponses situent le projet dans l'une des 4 familles :

| Famille | Description | Cas d'usage |
|---|---|---|
| 1 — Statique | HTML/CSS servi, pas de calcul ni de données | CV, page de présentation |
| 2 — Front dynamique | Logique dans le navigateur, pas de persistance | Simulateur, petit jeu |
| 3 — Full-stack moderne ✅ | Front + back-end no-code (Supabase, Convex) | La majorité des projets vibe-method |
| 4 — Complexe | API custom + BDD + Auth + logique métier | Réservé aux professionnels |

La vibe-method cible la famille 3. Si un projet relève de la famille 4, faire appel à un pro.

---

## Concepts actés

### Architecture modulaire
Chaque fonctionnalité est un module quasi-autonome. Les modules ne dépendent pas les uns des autres.
Avantage : permet de travailler en parallèle sur plusieurs features sans conflit de code.

### Architecture en silos
Règle stricte : un module ne touche pas au code d'un autre. Un module peut appeler les fonctions d'un autre via import — il ne peut pas réécrire ou modifier son code.
Pourquoi : garantit que l'IA reste dans un contexte minimal et ne casse pas ce qui ne la concerne pas.

### Modules métier et modules techniques

**Modules métier** — viennent des features du PRD. Une grande fonction = un module candidat.
Exemples : /auth, /profil, /paiement, /notifications

**Modules techniques** — nécessaires au fonctionnement de tous les autres, ils ne viennent pas des features.
- `/shared` — utilitaires génériques réutilisables partout
- `/config` — variables d'environnement, constantes
- `/db` — accès et connexion à la base de données
- `/api` — appels aux services externes

### Feature vs Module
**Feature** = ce que l'utilisateur fait. Vue de l'extérieur, du point de vue du besoin.
**Module** = comment le code est organisé. Vue de l'intérieur, du point de vue du développeur.
Une feature est implémentée dans un ou plusieurs modules.

### CLAUDE.md par projet
Chaque projet a son propre `CLAUDE.md` à la racine. L'IA le lit à chaque session pour savoir comment travailler dans ce projet spécifique.

Contenu :
- La carte des modules et leurs responsabilités
- La règle silo (quel module peut toucher quoi)
- Les fichiers partagés à risque
- Les conventions de code du projet

Créé lors du skill `/archi`. Document vivant — mis à jour à chaque nouvelle décision.

---

## Conception d'API et d'interfaces

Comparaison `addyosmani/agent-skills` vs vibe-method (2026-07-28, P2 de la roadmap). S'applique à toute frontière : API REST, contrat entre modules (règle silo ci-dessus), props de composant.

### Loi de Hyrum

> Avec assez d'utilisateurs, tout comportement observable d'un système finit par être utilisé par quelqu'un, quel que soit ce que le contrat promet.

Conséquence directe : chaque comportement observable — y compris les bizarreries non documentées, le texte exact des messages d'erreur, l'ordre de retour — devient un contrat de fait dès qu'un consommateur s'appuie dessus. Ne pas exposer de détail d'implémentation qu'on n'est pas prêt à maintenir indéfiniment.

### Règle de la version unique

Éviter de forcer les consommateurs à choisir entre plusieurs versions d'une même dépendance ou API en simultané. Concevoir pour qu'une seule version existe à un instant T — étendre plutôt que forker.

### Process — contrat d'abord

1. **Contrat avant implémentation** — définir l'interface avant de coder derrière
2. **Sémantique d'erreur cohérente** — un seul format d'erreur partout (corps structuré + statut HTTP), pas un format par endpoint
3. **Valider aux frontières** — faire confiance au code interne, valider tout ce qui vient de l'extérieur (voir `securite.md` §2.4)
4. **Additionner plutôt que modifier** — champs optionnels en plus, ne jamais casser l'existant pour un champ nouveau
5. **Nommage prévisible** — endpoints REST sans verbe (`/utilisateurs`, pas `/getUtilisateurs`), paramètres et champs en camelCase, booléens préfixés `is`/`has`/`can`, valeurs d'enum en `UPPER_SNAKE`

### Patterns courants

Pagination (`page`/`pageSize`/`totalItems`), filtrage par query params, `PATCH` pour mise à jour partielle, séparation input/output (ex : `CreateTaskInput` distinct de `Task` qui inclut les champs serveur).

---

## Deprecation et migration

Comparaison `addyosmani/agent-skills` vs vibe-method (2026-07-28, P2). Complète le workflow Brownfield de `methode.md` (couverture de régression avant modification) avec la doctrine de retrait propre d'un système existant.

### Principe

**Le code est un passif, pas un actif.** Chaque ligne coûte en maintenance (tests, doc, patchs de sécurité, montée de version, charge mentale pour quiconque travaille à côté). La valeur vient de la fonctionnalité rendue, pas du code lui-même — si la même fonctionnalité peut être obtenue avec moins de code, l'ancien code doit partir.

**La planification de dépréciation commence à la conception.** En construisant un nouveau système : "comment le retirerait-on dans 3 ans ?" Un système à interfaces propres et surface minimale se dépriécie plus facilement qu'un système qui expose ses détails internes partout (voir Loi de Hyrum ci-dessus — c'est pour ça que le retrait est difficile en pratique, pas juste en théorie).

### Décision — avant de déprécier quoi que ce soit

5 questions, dans l'ordre :
1. Ce système a-t-il encore de la valeur ?
2. A-t-il encore des utilisateurs actifs ?
3. Un remplaçant existe-t-il déjà ?
4. Quel est le coût de la migration ?
5. Quel est le coût de le maintenir tel quel ?

**Advisory vs Compulsory :**

| | Advisory | Compulsory |
|---|---|---|
| Migration | Optionnelle | Obligatoire |
| Déclencheur | Ancien système encore stable | Faille de sécurité, blocage, deadline dure |
| Ce qu'on doit à l'utilisateur | Avertissements, documentation | Outillage de migration fourni |

### Process

Annoncer avec un guide de migration → migrer incrémentalement (identifier les points de contact → mettre à jour → vérifier → retirer) → vérifier zéro usage actif → retirer le code. Jamais de renommage/suppression en place — toujours *expand* puis *contract*.

**Règle du churn :** si on possède l'infrastructure, on migre ses propres utilisateurs ou on fournit des mises à jour rétrocompatibles — la charge ne retombe pas sur eux par défaut.

### Patterns

- **Strangler** — router progressivement de l'ancien vers le nouveau, phase par phase
- **Adapter** — l'ancienne interface enveloppe la nouvelle implémentation
- **Feature Flag** — bascule par consommateur/tenant
- **Expand/Contract** (base de données) — ajouter une colonne nullable → double écriture → backfill → basculer les lectures → retirer la colonne, dans un déploiement séparé de l'ajout

---

## Stacks de référence

### Distribution — trois options

La plateforme de distribution est décidée au `/archi` selon le contexte du projet. Trois options, sans hiérarchie entre elles :

**Web (app ou site vitrine)**
React + Vite + TypeScript + Vercel. Option par défaut pour les apps accessibles via navigateur, les sites vitrines et les interfaces d'administration.

**PWA (Progressive Web App)**
React + Vite + TypeScript + Vercel + Service Worker. App web installable sur l'écran d'accueil, utilisable offline, avec notifications push. Pas d'accès aux APIs natives avancées du téléphone.

**App native**
React Native + Expo + TypeScript + NativeWind. Soumission App Store + Google Play. Accès aux APIs natives, expérience utilisateur native iOS/Android. Requiert le respect des guidelines Apple HIG et Material Design 3.

Règle : le choix est justifié explicitement dans `[projet].archi.md` lors du `/archi`.

---

### Back-end — deux stacks

**Stack A — Convex** : real-time natif. Adapté aux projets avec synchronisation temps réel forte (chat, collaboration, présence).

**Stack B — Supabase** : relationnel + auth + storage. Adapté aux projets standards.

Le choix est tranché au `/archi`. Les détails d'investigation (free tier, gotchas, compatibilité) sont dans `[projet].stack.md`, produit par `/stack`.

---

### Site vitrine + app — deux surfaces

Certains projets combinent un site vitrine (landing, conversion, contenu public) et une app (usage quotidien, authentifié). Ce sont deux surfaces distinctes :

- Même charte graphique — couleurs, typographie, style visuel identiques
- Composants différents — les composants de conversion (hero, pricing, témoignages) ne sont pas les mêmes que les composants d'usage (dashboard, formulaires, listes)
- Design system à couvrir pour les deux — `/design` Mode A traite les deux surfaces séparément

La décision "site vitrine séparé ou dans le même repo" est prise au `/archi`.

---

### Design system — workflow

La charte graphique (couleurs, typographie, logo, ambiance) est définie avec `/charte` → produit `[projet].charte.md`.

Le design system complet est produit avec `/design` Mode A, en aller-retour itératif avec `/archi` → produit `[projet].design.md`, qui sert d'input direct à Claude Design pour la génération des maquettes.

Après génération par Claude Design, `/design` Mode B intègre le code produit dans Tailwind (web/PWA) ou NativeWind (native).

---

## Mise en production — doctrine

La mise en prod couvre 6 couches. Chacune est tranchée au moment du `/archi` et documentée dans `[projet].archi.md`. Le skill `/deploy` lit ces décisions avant d'agir.

### Les 6 couches

**1 — Front** — Vercel prend le repo GitHub, build et publie automatiquement. Chaque `git push` redéploie. Gratuit pour commencer.

**2 — Back-end / BDD** — Supabase et Convex vivent dans le cloud par défaut. Pas de configuration particulière.

**3 — Variables d'environnement** — les secrets (clés API, tokens) vivent dans `.env` en local, jamais sur GitHub. En prod, ils sont déclarés manuellement dans Vercel (Dashboard → Project → Settings → Environment Variables). Claude génère la liste exhaustive des variables à déclarer avec leur source.

**4 — Migrations BDD** — toute modification du schéma en prod doit être faite proprement, sans perdre les données existantes. Voir niveaux ci-dessous.

**5 — Domaine** — pour une app web : achat chez un registrar (OVH, Namecheap, Gandi...) + configuration DNS dans Vercel. SSL inclus automatiquement. Pour une app mobile : bundle ID (iOS) + package name (Android) + compte Apple Developer (99€/an) et/ou Google Play (25€ une fois).

**6 — Monitoring** — surveillance de l'app en prod. Outils : Sentry (erreurs temps réel), UptimeRobot (disponibilité), logs Vercel (investigation). Voir niveaux ci-dessous.

---

### Niveaux de déploiement

Le niveau est décidé au `/archi` selon la nature de l'app et ses utilisateurs. Il est inscrit dans `[projet].archi.md` et lu par `/deploy`.

**Niveau 1 — Proto / app perso**
- Pas de staging
- Migration directe en prod avec sauvegarde manuelle avant
- Monitoring : logs Vercel uniquement

**Niveau 2 — App client standard**
- Staging à la demande (créé avant chaque migration, fermé après)
- Migrations versionnées dans Git
- Sauvegarde automatique avant chaque migration
- Tests post-migration avant ouverture aux utilisateurs
- Monitoring : Sentry + UptimeRobot

**Niveau 3 — App critique (données sensibles, légales, financières)**
- Tout le niveau 2
- Rollback automatique si migration échoue
- Tests automatisés pré-migration
- Validation humaine explicite avant application en prod
- Monitoring avancé : alertes performances + erreurs

**Règle staging :** le staging n'est jamais permanent. Il est créé à la demande avant une migration significative et fermé après validation. Coût limité à la durée de la procédure.

---

### Quand faire appel à un pro — zones de risque

La décision de déployer seul ou avec de l'aide dépend des enjeux du projet, pas de sa complexité technique.

**Zone verte — peut déployer seul**
- Site statique ou front-end pur
- Pas de données sensibles
- Cercle d'utilisateurs limité et connu
- Plateforme cloud qui gère l'hébergement (Vercel, Lovable...)

**Zone orange — déployer avec prudence**
- Application multi-utilisateurs
- Base de données avec données personnelles (noms, emails, téléphones)
- Back-end no-code (Supabase, Convex)
→ Audit sécurité croisé obligatoire (voir `securite.md` — Phase 4)
→ Séparation dev/prod obligatoire (niveau 2 minimum)

**Zone rouge — faire appel à un professionnel**
- Paiement en ligne
- Données de santé, financières, légales
- Authentification multi-utilisateurs avec rôles complexes
- Exposition publique large
- Back-end custom

Faire appel à un professionnel n'est pas un aveu d'échec — c'est du vibe coding éclairé. Si on a codé une application fonctionnelle, on a fait la partie la plus créatrice. La mise en production sécurisée d'un projet en zone rouge, c'est un autre métier.

---

## Backup & conformité RGPD — doctrine

### Périmètre

Le backup s'applique uniquement aux **données en production**. Le code est versionné sur GitHub — ce n'est pas un backup au sens strict, mais suffisant pour le code. La base de données est le seul vrai risque.

---

### Criticité des données — 3 niveaux

À trancher au `/archi` pour chaque projet.

| Niveau | Critère | Exemples |
|---|---|---|
| **1 — Faible** | Données récréables, aucune donnée personnelle | App perso, prototype |
| **2 — Standard** | Données personnelles non sensibles (nom, email, rôle) | App associative, club |
| **3 — Élevé** | Données financières, médicales, légales | Paiements, santé, B2B |

---

### Stratégie de backup par niveau

**Niveau 1** — aucun backup obligatoire. Git suffit.

**Niveau 2** :
- Dump quotidien automatisé (GitHub Actions)
- Stockage : GitHub privé + GitLab privé, dumps chiffrés GPG
- Monitoring : UptimeRobot (URL de l'API)
- Test de restauration : 1 fois par an minimum

**Niveau 3** :
- Tout le niveau 2
- Backup natif Supabase Pro (région EU, rétention 7 jours native)
- Dump secondaire chiffré sur OVH ou Scaleway Object Storage (souveraineté EU)
- Test de restauration : 2 fois par an

---

### Contenu obligatoire d'un dump

Pour toute base relationnelle (Supabase ou Convex) :
- Schéma de la base (structure des tables, types, contraintes)
- Données complètes
- IDs et clés étrangères — indispensables pour reconstruire les relations entre tables

---

### Politique de rétention — formule par défaut

À adapter par projet au `/archi`.

| Fréquence | Conservation |
|---|---|
| Dumps quotidiens | 30 jours glissants |
| Dumps mensuels | 12 mois glissants |
| Dumps annuels | Indéfini (archivage) |

Rotation automatisée via script GitHub Actions. Certains projets ont une logique saisonnière (ex : données d'adhésion) — la politique de rétention s'adapte en conséquence.

**Archivage** : si le projet nécessite une conservation historique longue, définir au `/archi` : quelles données archiver, à quel moment les basculer, pour quelle durée.

---

### RGPD — règles par outil

**Supabase** :
- Sélectionner la région **Frankfurt (eu-central-1)** à la création du projet — disponible sur tous les plans, y compris gratuit
- Signer le DPA sur `supabase.com/legal/dpa` avant toute mise en production avec données personnelles EU
- Chiffrement au repos AES-256 et en transit TLS inclus — clés gérées par Supabase (pas le client)
- Référence pour tout projet niveau 2 ou 3

**Convex** :
- DPA disponible sur `convex.dev/legal/dpa` — GDPR Verified, SOC 2 Type II
- Pas de région EU confirmée — préférer Supabase pour les projets avec données personnelles EU
- Acceptable pour projets niveau 1 ou sans données personnelles EU

**GitHub / GitLab** (stockage des dumps) :
- Plateformes américaines soumises au Cloud Act
- Les dumps **doivent être chiffrés GPG** avant tout push — les fichiers stockés sont illisibles sans la clé
- Clé GPG stockée dans 1Password — jamais dans le repo

**Nota** : la synchronisation (Google Drive, Dropbox) n'est pas un backup. Elle propage les corruptions et suppressions.

---

### Architecture backup standard (niveaux 2 et 3)

```
Code             → GitHub (primary) + GitLab (miroir automatique)
Dump quotidien   → chiffré GPG → GitHub privé + GitLab privé
Monitoring       → UptimeRobot (URL de l'API)
Clé GPG          → 1Password
DPA              → signé (Supabase et/ou Convex selon le projet)
```

---

### Implémentation — skill /backup

Le skill `/backup` prend le relais après `/archi` pour l'exécution :
- Configuration GitHub Actions (dump automatique + rotation)
- Miroir automatique GitHub → GitLab
- Setup GPG + stockage clé dans 1Password
- Signature DPA (Supabase et/ou Convex)
- Configuration UptimeRobot
- Test de restauration initial

---

### Règles actées

- **Backup obligatoire dès le niveau 2** — aucune donnée personnelle sans backup
- **Chiffrement GPG systématique** sur GitHub et GitLab pour tous les dumps
- **Tester la restauration** au moins une fois par an — vérifier que le dump est restaurable, pas seulement qu'il existe
- **DPA signé avant mise en production** — pas après
- **Supabase + région Frankfurt** = référence pour tout projet avec données personnelles EU

---

## Dépendances externes — Model Context Protocol (MCP)

Les MCP permettent à l'IA de se connecter à des systèmes externes (GitHub, Notion, bases de données, APIs) sans custom code. C'est un standard ouvert avec trois primitives : tools (actions), resources (données), prompts (directives).

**Principe : traiter MCP comme un **spectre**, pas un choix binaire.**

### Quand identifier les MCP ?

Au moment du `/archi`, lors de l'identification des dépendances externes.

Question clé : "Quels systèmes externes auront besoin d'être lus/écrits de manière **conversationnelle** ?"

### Règle de décision : MCP vs CLI vs API directe

Trois approches selon la nature du workflow :

| Approche | Quand l'utiliser | Avantage | Inconvénient |
|---|---|---|---|
| **MCP** | Workflow conversationnel, exploratoire, haute flexibilité requise | Zéro custom code, découverte autonome, interface déclarée | ~2-3s de latence, ~2000 tokens par appel |
| **CLI** (ex: `gh`) | Workflow déterministe, connu d'avance, appelé fréquemment | ~100ms, pas d'overhead token, déterministe | Besoin de connaître la commande exacte |
| **API directe** | Haute-fréquence, performances critiques, workflow connu | Contrôle total, performances | Besoin de custom code à chaque fois |

**Cas mixte (conversationnel + déterministe)** : Si un système a les deux, MCP est mieux. La flexibilité conversationnelle justifie l'overhead.

Exemples :
- **GitHub** : 100% déterministe (créer PR, merger) → rester en CLI (`gh`)
- **Notion** : conversationnel (écrire `.peda`, documenter) + déterministe (ajouter entrée `.log`) → rester en MCP

### Activation : global vs par-projet vs on-demand

| Mode | Quand | Exemple |
|---|---|---|
| **Global** | Utilisé par >50% des projets vibe-method | Notion MCP (tous les projets en ont besoin), Gmail |
| **Par-projet** | Spécifique à un projet ou une catégorie | Linear MCP pour un projet client, Slack pour un projet de comms |
| **On-demand** | Rare, exploratoire, ou haute-fréquence mais pas par défaut | GitHub MCP quand exploration nécessaire (normalement on utilise `gh` CLI) |

Une fois décidé au `/archi`, l'activation est documentée dans `[projet].archi.md`.

### Découverte des MCP disponibles

- Taper `@` dans le prompt → voir ressources des MCP connectés
- Commande : `claude mcp list` → lister tous les serveurs enregistrés
- Catalogues : [awesome-mcp-servers](https://github.com), [Glama Directory](https://glama.ai), [Claude Code Marketplaces](https://claudemarketplaces.com/mcp)

### Créer un MCP custom

Si un besoin est identifié et qu'aucun MCP standard ne le couvre : créer un MCP est possible **si une API existe** + besoin conversationnel documenté.

Avant de créer : chercher dans les catalogues. L'écosystème MCP grandit rapidement.

---

## Dépendances d'environnement — la question n'est pas « survit-elle ? »

Une dépendance d'environnement, c'est tout ce dont le code a besoin sans l'avoir déclaré : polices, locales, fuseaux horaires, dictionnaires, encodages, certificats, résolveurs DNS, binaires système, environnements virtuels installés à chaud.

**La bonne question n'est pas « est-ce que cette dépendance survit à un redéploiement ? » mais « comment se manifeste son absence ? »**

Deux familles, et elles ne présentent pas du tout le même risque :

| Famille | Comportement en cas d'absence | Risque |
|---|---|---|
| **Panne franche** | Erreur levée : `ModuleNotFoundError`, `command not found`, connexion refusée | Borné. Visible, diagnosticable, souvent bloquant donc traité |
| **Repli silencieux** | Substitution automatique, valeur par défaut, dégradation muette | **Élevé.** Le programme continue, produit un résultat *plausible mais faux*, et aucune alerte n'est émise |

Exemples de la seconde famille : une police manquante remplacée par fontconfig ; une locale absente qui bascule en `C` et change le tri, les séparateurs décimaux et les dates ; un fuseau non installé qui retombe en UTC ; un dictionnaire de césure absent ; une vérification de certificat désactivée par une configuration permissive.

**Cas vécu (2026-08-03, projet Hermes).** Un document contractuel généré par weasyprint dépendait de polices installées à chaud dans une couche non persistante. Après recréation du conteneur, weasyprint **ne plantait pas** : fontconfig substituait une autre police, le PDF se générait sans la moindre erreur, mais ses métriques changeaient — 19 196 octets au lieu de 19 128, empreintes différentes. Une maquette validée et figée serait partie chez un client modifiée, sans aucun signal. Le venv Python manquant au même endroit, lui, levait une erreur franche : c'était le cas facile.

### Règles

1. **Inventorier avant de conclure.** Quand un correctif est motivé par « X sera détruit », lister *tout* ce que X contient. L'élément qui a déclenché l'enquête est rarement le seul, ni le plus dangereux.
2. **Toute dépendance installée à chaud va dans un emplacement persistant**, jamais dans un répertoire temporaire ni dans une couche d'image. Si ce n'est pas possible, un mécanisme de réinstallation au démarrage doit la rejouer — et ce mécanisme fait partie du livrable, pas des notes.
3. **Pour chaque dépendance à repli silencieux, définir une commande de contrôle** et la placer dans la documentation d'exploitation : `fc-match <police>`, `locale -a`, `date +%Z`. Elle doit être exécutée après tout changement d'environnement, puisque rien d'autre ne signalera le problème.
4. **Vérifier par comparaison d'empreintes, pas par inspection visuelle.** Une dégradation silencieuse produit un résultat qui *a l'air* correct. Seule la comparaison de deux sorties, avant et après, la révèle.

**Principe :** le danger d'une dépendance ne se mesure pas à sa probabilité de disparaître, mais au bruit que fait sa disparition. Un composant doté d'un repli silencieux transforme une panne en dégradation invisible — et une dégradation invisible franchit toutes les vérifications qui cherchaient une erreur.

---

## Règles actées

- **Modulaire + silos = règle par défaut** sur tous les projets, sans exception
- **`/shared` = utilitaires génériques uniquement** — jamais de logique métier. Si tout finit dans /shared, le silo s'effondre.
- **Un module peut appeler un autre, jamais modifier son code**
- **Contexte minimal** — donner à l'IA : CLAUDE.md + module ciblé + specs de la feature. Pas tout le projet.
- **Niveau d'abstraction maximal** — toujours choisir l'outil ou le service qui abstrait le plus de complexité technique, tant qu'il couvre le besoin. Vercel plutôt qu'un VPS, Supabase plutôt qu'une base auto-hébergée, un service managé plutôt que Docker. Ne descendre d'un niveau d'abstraction que si le niveau supérieur ne couvre pas le besoin — jamais par défaut, jamais par curiosité.
- **MCP = spectre, pas binaire** — traiter comme un choix conversationnel vs déterministe. Commencer en MCP, migrer les workflows éprouvés vers CLI/API si perf critiques.
- **Dépendance d'environnement : trier par bruit, pas par probabilité** — celles qui ont un repli silencieux (polices, locales, fuseaux, encodages) sont plus dangereuses que celles qui plantent. Toute dépendance installée à chaud va dans un emplacement persistant, et chacune à repli silencieux doit avoir sa commande de contrôle documentée.
