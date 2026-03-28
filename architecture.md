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

## Règles actées

- **Modulaire + silos = règle par défaut** sur tous les projets, sans exception
- **`/shared` = utilitaires génériques uniquement** — jamais de logique métier. Si tout finit dans /shared, le silo s'effondre.
- **Un module peut appeler un autre, jamais modifier son code**
- **Contexte minimal** — donner à l'IA : CLAUDE.md + module ciblé + specs de la feature. Pas tout le projet.
- **Niveau d'abstraction maximal** — toujours choisir l'outil ou le service qui abstrait le plus de complexité technique, tant qu'il couvre le besoin. Vercel plutôt qu'un VPS, Supabase plutôt qu'une base auto-hébergée, un service managé plutôt que Docker. Ne descendre d'un niveau d'abstraction que si le niveau supérieur ne couvre pas le besoin — jamais par défaut, jamais par curiosité.
