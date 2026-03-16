# securite.md

Règles de sécurité à appliquer dans tout projet web.
Sources : podcast Radio Vibe Code #7 + connaissances Claude (OWASP, bonnes pratiques générales).

Medwin valide les règles via Claude Web — les modifications arrivent ensuite par GitHub.

---

## Principe fondamental

**Zero Trust** : ne faire confiance à rien par défaut. Autoriser explicitement le minimum nécessaire, interdire tout le reste.

La sécurité est aussi solide que son maillon le plus faible. Un seul point négligé suffit.

---

## Phase 1 — Avant de coder (à décider à la conception)

### Identifiants
- Utiliser des **UUIDs** plutôt que des IDs séquentiels (ex: `1, 2, 3...`)
- Les IDs séquentiels permettent de deviner les autres enregistrements (attaque IDOR)

### Segmentation des données
- Définir dès le départ **qui a accès à quoi**
- Chaque utilisateur ne doit voir que ses propres données
- Sur Supabase : activer le **Row Level Security (RLS)** dès la création des tables
- L'IA ne le fait pas par défaut — toujours demander explicitement

### Architecture
- Ne jamais auto-héberger le back-end (utiliser Vercel, Netlify, Railway, etc.)
- HTTPS obligatoire — géré automatiquement par les hébergeurs modernes

---

## Phase 2 — Pendant le code

### Secrets et clés API
- **Jamais** de clé API privée en front-end (ni dans le code, ni dans les variables d'environnement front)
- Les secrets vivent uniquement dans les variables d'environnement **back-end** (`.env`)
- Le fichier `.env` ne doit **jamais** être commité sur GitHub (vérifier `.gitignore`)
- Ne jamais donner la secret key Supabase à l'IA — ni à Claude, ni à aucun autre modèle
- Exception : certaines clés publiques sont faites pour être exposées (ex: Supabase anonkey, Firebase config)

### Dépendances
- Lancer `npm audit` après chaque `npm install`
- L'IA installe souvent des versions obsolètes (ses données d'entraînement ont une date limite)
- Les versions obsolètes contiennent des failles connues — les pirates les exploitent en priorité
- S'abonner aux newsletters des frameworks utilisés (Next.js, etc.) pour être alerté des failles critiques

### Front-end
- Vérifier l'authentification **avant** d'afficher les données — jamais après
- Ne jamais masquer des données sensibles avec CSS ou JavaScript : elles restent présentes dans le HTML et accessibles à n'importe qui
- Stocker le token d'authentification en cookie HttpOnly (pas en localStorage si possible)
- Ne jamais construire des requêtes SQL ou des commandes avec des données venant de l'utilisateur directement

### Validation des entrées utilisateur
- Valider **côté serveur** — la validation front-end seule ne protège pas
- Utiliser une **whitelist** : autoriser uniquement les caractères attendus (lettres, chiffres, espaces)
- Rejeter ou nettoyer tout ce qui ressemble à du code : `< >`, `{ }`, `||`, balises HTML, JavaScript
- Utiliser les fonctions de sanitisation existantes dans les librairies — ne pas réinventer

### Back-end / Base de données
- **Authentification ≠ Autorisation**
  - Authentification : "est-ce que cet utilisateur est connecté ?" (token valide)
  - Autorisation : "est-ce que cet utilisateur a le droit d'accéder à CET enregistrement ?"
  - Vérifier les deux à chaque requête
- Utiliser les générateurs de requêtes (Supabase client, ORM) plutôt que le SQL brut
- Relire et comprendre le SQL généré par l'IA avant de l'appliquer
- Ne jamais laisser l'IA appliquer directement des changements en base de données

### Rate limiting
- Limiter le nombre d'appels par endpoint (ex: 10 tentatives de login par minute)
- Protège contre le brute-force et les abus d'API
- Protège aussi contre les factures d'API gonflées si une clé fuite

---

## Phase 3 — Vérification

### Ce que Claude vérifie à chaque fin de feature
- Les données retournées sont-elles filtrées par utilisateur ?
- Les clés privées sont-elles absentes du front-end et du repo ?
- Le `.env` est-il dans le `.gitignore` ?
- Les entrées utilisateur sont-elles validées côté serveur ?
- Le RLS est-il activé sur les tables concernées ?
- `npm audit` a-t-il été lancé ?

---

## Attaques connues — références rapides

| Attaque | Description courte | Protection |
|---|---|---|
| **XSS** | Injection de code JS dans une page via un formulaire | Valider + échapper les entrées |
| **SQL Injection** | Injection de code SQL dans une requête | Utiliser les générateurs de requêtes, jamais de SQL brut avec données utilisateur |
| **IDOR** | Accéder aux données d'un autre utilisateur en changeant l'ID dans l'URL | RLS + vérification d'autorisation à chaque requête |
| **CSRF** | Forcer un utilisateur connecté à effectuer une action à son insu | Tokens CSRF, cookies SameSite |
| **Fuite de secrets** | Clé API dans le code versionné sur GitHub | `.gitignore` + variables d'environnement |

---

## Spécifique vibe coding

- Les IA génèrent du code fonctionnel mais rarement sécurisé par défaut
- Toujours demander explicitement : "ajoute le RLS", "valide les entrées", "n'expose pas cette clé"
- Relire le code généré avec cet angle de lecture avant d'exécuter
- En cas de doute sur une règle RLS générée : la faire vérifier par un second modèle

