# architecture.md

Décisions d'organisation du code — patterns, structure, indépendance des modules.
À construire ensemble — aucune règle ici sans validation de Medwin.

---

## Principe fondateur

**Plus le contexte donné à l'IA est petit et ciblé, plus elle est performante.**

Toutes les décisions d'architecture découlent de ce principe : modules isolés, fichiers bien délimités, CLAUDE.md ciblé par projet. Un contexte lourd = l'IA oublie des détails, fait des erreurs subtiles. Un contexte minimal = l'IA est focalisée et fiable.

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

## Règles actées

- **Modulaire + silos = règle par défaut** sur tous les projets, sans exception
- **`/shared` = utilitaires génériques uniquement** — jamais de logique métier. Si tout finit dans /shared, le silo s'effondre.
- **Un module peut appeler un autre, jamais modifier son code**
- **Contexte minimal** — donner à l'IA : CLAUDE.md + module ciblé + specs de la feature. Pas tout le projet.
- **Niveau d'abstraction maximal** — toujours choisir l'outil ou le service qui abstrait le plus de complexité technique, tant qu'il couvre le besoin. Vercel plutôt qu'un VPS, Supabase plutôt qu'une base auto-hébergée, un service managé plutôt que Docker. Ne descendre d'un niveau d'abstraction que si le niveau supérieur ne couvre pas le besoin — jamais par défaut, jamais par curiosité.
