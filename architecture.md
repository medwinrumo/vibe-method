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

## Stack front de référence

React + Vite + TypeScript — combo de référence pour tous les projets front.

- **React** — composants, gestion d'état, écosystème mature
- **Vite** — build rapide, configuration minimale
- **TypeScript** — typage statique, erreurs détectées avant l'exécution

Alternatives viables selon le contexte :
- **PWA** (Progressive Web App) — app web installable, offline, notifications push. Reste sur React + Vite + TS. Adaptée si les besoins ne nécessitent pas les APIs natives avancées du téléphone.
- **React Native** — app mobile native, soumission App Store + Google Play. À choisir si l'accès aux APIs natives est requis ou si l'expérience native est critique.
- D'autres options existent — à évaluer au cas par cas lors du `/archi`.

Règle : toute déviation par rapport à la stack de référence doit être justifiée explicitement dans le `/archi` du projet.

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

## Règles actées

- **Modulaire + silos = règle par défaut** sur tous les projets, sans exception
- **`/shared` = utilitaires génériques uniquement** — jamais de logique métier. Si tout finit dans /shared, le silo s'effondre.
- **Un module peut appeler un autre, jamais modifier son code**
- **Contexte minimal** — donner à l'IA : CLAUDE.md + module ciblé + specs de la feature. Pas tout le projet.
- **Niveau d'abstraction maximal** — toujours choisir l'outil ou le service qui abstrait le plus de complexité technique, tant qu'il couvre le besoin. Vercel plutôt qu'un VPS, Supabase plutôt qu'une base auto-hébergée, un service managé plutôt que Docker. Ne descendre d'un niveau d'abstraction que si le niveau supérieur ne couvre pas le besoin — jamais par défaut, jamais par curiosité.
- **MCP = spectre, pas binaire** — traiter comme un choix conversationnel vs déterministe. Commencer en MCP, migrer les workflows éprouvés vers CLI/API si perf critiques.
