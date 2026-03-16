Règles de sécurité à appliquer dans tout projet web.

Sources : podcast Radio Vibe Code #6 ou #7 + connaissances Claude (OWASP, bonnes pratiques générales).

Medwin valide les règles via Claude Web — les modifications arrivent ensuite par GitHub.

---

## 0 — Principe fondamental

**Zero Trust** : ne faire confiance à rien par défaut. Autoriser explicitement le minimum nécessaire, interdire tout le reste.

La sécurité est aussi solide que son maillon le plus faible. Un seul point négligé suffit.

---

## 1 — Phase 1 : Avant de coder (à décider à la conception)

### 1.1 Identifiants

- Utiliser des **UUIDs** plutôt que des IDs séquentiels (ex: `1, 2, 3...`)
    - Empêche l'énumération d'objets : avec des IDs séquentiels, un attaquant peut facilement parcourir tous les enregistrements en testant 1, 2, 3, etc.
    - Les UUIDs sont impossibles à deviner (ex: `550e8400-e29b-41d4-a716-446655440000`)
        - **UUID** signifie **Universally Unique Identifier** (identifiant unique universel)
        - C'est une chaîne de 128 bits représentée par 32 caractères hexadécimaux séparés par des tirets
        - Exemple de format : `550e8400-e29b-41d4-a716-446655440000`
        - Il existe plusieurs versions (v1, v4, v7...) — la v4 est la plus utilisée car totalement aléatoire
        - La probabilité de collision (deux UUIDs identiques) est quasi nulle : environ 1 chance sur 2122
    - Attention : les UUIDs ne remplacent pas les vérifications d'autorisation — il faut toujours vérifier que l'utilisateur a le droit d'accéder à la ressource demandée
- Les IDs séquentiels permettent de deviner les autres enregistrements (attaque IDOR)

**IDOR** signifie **Insecure Direct Object Reference** (référence directe non sécurisée à un objet)

C'est une vulnérabilité qui permet à un attaquant d'accéder à des ressources auxquelles il n'a pas le droit

**Exemple concret :**

Imaginons une URL : `https://monsite.com/facture/123`

Si l'utilisateur change l'URL en `https://monsite.com/facture/124`, il peut accéder à la facture d'un autre utilisateur

Avec des IDs séquentiels (1, 2, 3...), l'attaquant peut facilement tester tous les numéros

**Comment se protéger :**

- Utiliser des UUIDs au lieu d'IDs séquentiels (difficiles à deviner)
- Toujours vérifier côté serveur que l'utilisateur a le droit d'accéder à la ressource demandée
- Activer le Row Level Security (RLS) sur les bases de données
    
    **RLS** signifie **Row Level Security** (Sécurité au niveau des lignes)
    
    C'est un mécanisme de sécurité intégré directement dans la base de données qui filtre automatiquement les données selon l'utilisateur connecté
    
    **Comment ça fonctionne :**
    
    - Au lieu de filtrer les données dans le code de l'application, c'est la base de données elle-même qui applique les règles
    - Chaque requête SQL est automatiquement filtrée selon l'identité de l'utilisateur
    - Même si un attaquant contourne le code front-end ou back-end, la base de données bloque l'accès
    
    **Exemple concret :**
    
    Sans RLS : vous devez écrire dans votre code :
    
    ```jsx
    const { data } = await supabase
      .from('factures')
      .select('*')
      .eq('user_id', currentUser.id)  // ← vous devez penser à ajouter ce filtre
    ```
    
    Si vous oubliez `.eq('user_id', currentUser.id)`, tous les utilisateurs peuvent voir toutes les factures
    
    Avec RLS activé : vous écrivez simplement :
    
    ```jsx
    const { data } = await supabase
      .from('factures')
      .select('*')  // ← la base filtre automatiquement
    ```
    
    La base de données applique automatiquement une règle du type :
    
    ```sql
    CREATE POLICY "Les utilisateurs ne voient que leurs factures"
    ON factures
    FOR SELECT
    USING (auth.uid() = user_id);
    ```
    
    **Pourquoi c'est crucial :**
    
    - Protection en profondeur : même si vous oubliez un filtre dans le code, la base protège
    - Protection contre les bugs : une erreur de code ne peut pas exposer les données des autres
    - Protection contre les attaques : impossible de contourner les filtres en manipulant les requêtes
    
    **Sur Supabase : Attention je n'utilise pas forcement Supabase , mais aussi firebase par exemple…**
    
    - Par défaut, RLS est **désactivé** — toutes les données sont accessibles à tout le monde
    - Il faut l'activer manuellement pour chaque table
    - Ensuite, créer des "policies" (règles) qui définissent qui peut lire/modifier quoi
    
    **Attention :**
    
    - L'IA oublie souvent d'activer le RLS — il faut le demander explicitement
    - RLS ne remplace pas les vérifications d'autorisation côté serveur pour les actions complexes
    - Bien tester les règles RLS : une règle mal écrite peut bloquer l'accès légitime ou laisser passer des accès illégitimes

### 1.2 Segmentation des données

- Définir dès le départ **qui a accès à quoi**
- Chaque utilisateur ne doit voir que ses propres données
- Activer le mécanisme de filtrage par utilisateur dès la création des tables (RLS sur Supabase/PostgreSQL, Security Rules sur Firebase, policies sur d'autres services)
- Le mécanisme exact dépend du service utilisé — mais le principe reste le même : la base filtre automatiquement, pas le code
- L'IA ne met pas en place le filtrage par utilisateur par défaut quand elle génère le code — toujours lui demander explicitement de l'ajouter

### 1.3 Architecture

- Ne jamais auto-héberger le back-end (utiliser Vercel, Netlify, Railway, etc.)
    
    Tu **peux** utiliser un VPS Hostinger, mais ce n'est **pas recommandé** pour le Vibe Coding, voici pourquoi :
    
    #### 1.3.a Pourquoi éviter l'auto-hébergement (VPS)
    
    - **Responsabilité de la sécurité** : sur un VPS, tu dois gérer toi-même :
        - Les mises à jour de sécurité du système (Linux, serveur web, etc.)
        - La configuration du firewall
        - Les certificats SSL/HTTPS
        - La protection contre les attaques DDoS
        - Les sauvegardes
    - **Surface d'attaque plus large** : un VPS mal configuré est une porte d'entrée pour les pirates
    - **Temps de maintenance** : au lieu de coder, tu passes du temps à administrer le serveur
    - **Pas de protection automatique** : les hébergeurs modernes (Vercel, Netlify, etc.) incluent :
        - HTTPS automatique
        - Protection DDoS
        - Mises à jour de sécurité automatiques
        - Surveillance 24/7
    
    #### 1.3.b Les alternatives recommandées
    
    - **Vercel** : idéal pour Next.js, déploiement en 1 clic
    - **Netlify** : excellent pour les sites statiques et JAMstack
    - **Railway** : si tu as besoin d'un back-end Node.js
    - **Render** : alternative à Heroku, gratuit pour commencer
    - **Cloudflare Pages** : très performant et gratuit
    
    Ces plateformes gèrent la sécurité pour toi — tu te concentres sur le code.
    
    #### 1.3.c Quand utiliser un VPS quand même ?
    
    - Si tu as des besoins très spécifiques (technologies non supportées ailleurs)
    - Si tu as l'expertise et le temps pour bien le sécuriser
    - Si tu acceptes le risque et la charge de travail supplémentaire
    
    <aside>
    
    **Conseil Vibe Coding :** commence par un hébergeur managé (Vercel, etc.). Si vraiment tu as besoin d'un VPS plus tard, tu migreras. Mais 99% des projets n'en ont pas besoin.
    
    </aside>
    
- HTTPS obligatoire — géré automatiquement par les hébergeurs modernes

### 1.4 Choix de l'authentification

- Ne jamais coder son propre système d'authentification — utiliser un service existant (Supabase Auth, Firebase Auth, Clerk, Auth0, etc.)
- Ces services gèrent pour toi : le hachage des mots de passe, les tokens, la récupération de compte, la protection contre le brute-force
- Coder l'auth soi-même, c'est réinventer la roue avec un risque élevé de faille
- **Décider dès la conception** quelle(s) méthode(s) d'authentification utiliser :
    - Email / mot de passe (le classique — mais le plus exposé au brute-force)
    - OAuth (Google, GitHub, Apple…) — réduit les frictions et délègue la sécurité au provider
    - Magic link (lien envoyé par email) — plus simple, pas de mot de passe à gérer
    - MFA (Multi-Factor Authentication) — à envisager pour les apps sensibles (finance, santé, admin)
- Le choix impacte l'UX, le schéma de BDD et les flux de récupération de compte — difficile à changer après coup
- L'IA ne propose pas de MFA par défaut — toujours le demander explicitement si nécessaire

### 1.5 Définition des rôles et permissions

- Si l'app a plusieurs types d'utilisateurs (admin, utilisateur, viewer...), définir les rôles dès la conception
- Ça impacte toute la structure : les tables, les règles de filtrage, les routes, les écrans
- Ajouter les rôles après coup est toujours plus coûteux et risqué que de les prévoir dès le départ
- **Principe du moindre privilège** : chaque rôle ne doit avoir accès qu'à ce dont il a strictement besoin
- Un utilisateur ne doit **jamais** pouvoir s'auto-promouvoir admin (vérification côté serveur obligatoire)
- Si l'app est **multi-tenant** (plusieurs organisations/clients dans la même app) :
    - Prévoir la séparation des données dès le schéma de base (ex: colonne `organization_id` sur chaque table)
    - Les règles RLS doivent inclure le filtre par organisation en plus du filtre par utilisateur
    - Tester que les données d'une organisation ne fuitent jamais vers une autre
- L'IA génère souvent un seul rôle "utilisateur" — penser à lui demander la gestion des rôles dès le début

### 1.6 Données sensibles

> À enrichir lors d'une session dédiée.
> 
- Identifier dès le départ quelles données sont sensibles (données personnelles, moyens de paiement, mots de passe, données de santé, etc.)
- Décider comment les stocker : chiffrement au repos, chiffrement en transit, accès restreint
- Ne jamais stocker en clair ce qui peut être chiffré ou haché

### 1.7 RGPD

- Clientèle PME/TPE en France — la conformité RGPD se pense dès la conception, pas après le lancement
- **Principe de minimisation** : ne collecter que les données strictement nécessaires au fonctionnement
    - Exemple : si tu n'as pas besoin de la date de naissance, ne la demande pas
    - Chaque champ de formulaire doit avoir une justification
- Décisions à prendre avant de coder :
    - Quelles données personnelles sont collectées et pourquoi
    - Combien de temps elles sont conservées (durée de rétention) — prévoir une suppression automatique
    - Comment recueillir le consentement de l'utilisateur (bannière cookies, checkbox inscription…)
    - Comment permettre à l'utilisateur de supprimer ses données (droit à l'effacement)
    - Comment permettre l'export des données (droit à la portabilité)
    - Comment permettre la rectification des données (droit de rectification)
- **Impact sur le schéma de BDD** : prévoir dès le départ les fonctions de suppression/export/anonymisation — c'est beaucoup plus facile à coder dès le début qu'à ajouter après
- L'IA ne pense pas au RGPD quand elle génère du code — toujours lui demander explicitement
- En cas de doute, consulter le site de la CNIL ([cnil.fr](http://cnil.fr)) pour les obligations spécifiques

### 1.8 Stratégie de backup

> À enrichir lors d'une session dédiée.
> 
- Décider dès le départ comment et à quelle fréquence les données sont sauvegardées
- Vérifier ce que le service choisi (Supabase, Firebase, etc.) propose nativement comme backups
- Tester la restauration — un backup qui n'a jamais été testé ne vaut rien

### 1.9 Politique de mots de passe

- Déléguer au maximum au service d'authentification choisi (cf. 1.4)
- A minima : longueur minimale de 8 caractères, idéalement 12+
- Ne jamais stocker les mots de passe en clair — le service d'auth gère le hachage automatiquement
- Envisager l'authentification sans mot de passe (magic link, OAuth) pour simplifier et sécuriser
- Interdire les mots de passe trop courants ("password", "123456", etc.) — la plupart des services d'auth le gèrent
- Ne jamais envoyer de mot de passe en clair par email — utiliser des liens de réinitialisation avec token temporaire

### 1.10 Politique de sessions et tokens

- Définir dès la conception la durée de vie des sessions / tokens JWT
    - Token d'accès : durée courte (15 min à 1h) — limite l'impact en cas de vol
    - Refresh token : durée plus longue (7 à 30 jours) — permet de renouveler le token d'accès sans re-login
- Prévoir l'**invalidation des sessions** côté serveur à la déconnexion — pas juste supprimer le cookie côté client
    - Sans invalidation serveur, un token volé reste utilisable jusqu'à son expiration
- Si l'app gère des données sensibles : prévoir le "logout everywhere" (invalider toutes les sessions actives)
- L'IA génère souvent des tokens sans expiration ou avec des durées trop longues — toujours vérifier

### 1.11 Politique CORS

- **CORS** (Cross-Origin Resource Sharing) définit quels domaines ont le droit d'appeler ton API
- Décider dès la conception quels domaines sont autorisés (ton front-end, ton app mobile, etc.)
- **Règle d'or** : jamais `Access-Control-Allow-Origin: *` en production
    - Le `*` signifie "tout le monde peut appeler mon API" — n'importe quel site malveillant peut envoyer des requêtes
    - Acceptable uniquement en développement local
- L'IA met très souvent `*` pour que ça "marche" rapidement — toujours vérifier et restreindre avant le déploiement
- Exemple de configuration correcte : n'autoriser que `https://monsite.com` et `https://app.monsite.com`

### 1.12 Logging et traçabilité

- Décider dès la conception ce qu'on logge et où vont les logs
- **Ce qu'il faut logger** :
    - Tentatives de connexion (réussies et échouées)
    - Accès refusés (403, 401)
    - Modifications de données sensibles (changement d'email, de rôle, suppression de compte)
    - Erreurs serveur (500)
- **Ce qu'il ne faut JAMAIS logger** :
    - Mots de passe (même hachés)
    - Tokens d'authentification
    - Données personnelles complètes (numéros de carte, etc.)
- **Où stocker les logs** : utiliser un service managé (Vercel logs, LogTail, Datadog, etc.) plutôt que des `console.log` en production
- Les logs permettent de détecter les attaques en cours et de comprendre les incidents après coup
- L'IA n'ajoute pas de logging de sécurité par défaut — le demander explicitement

### 1.13 Gestion des erreurs

- Les messages d'erreur ne doivent **jamais** exposer de détails techniques aux utilisateurs
    - ❌ "Error: relation "users" does not exist at line 42 of /app/src/api/users.ts"
    - ✅ "Une erreur est survenue. Veuillez réessayer."
- **Deux niveaux de messages** :
    - **Utilisateur** : message générique et rassurant, sans détail interne
    - **Log interne** : message détaillé avec stack trace, nom de table, timestamp, user ID (cf. 1.12)
- Cas spécifique de l'authentification : ne jamais dire si c'est l'email ou le mot de passe qui est incorrect
    - ❌ "Mot de passe incorrect" (confirme que l'email existe)
    - ✅ "Identifiants incorrects" (ne révèle rien)
- L'IA génère souvent des messages d'erreur trop détaillés — relire et remplacer avant la mise en production

---

## 2 — Phase 2 : Pendant le code

### 2.1 Secrets et clés API

- **Jamais** de clé API privée en front-end (ni dans le code, ni dans les variables d'environnement front)
- Les secrets vivent uniquement dans les variables d'environnement **back-end** (`.env`)
- Le fichier `.env` ne doit **jamais** être commité sur GitHub (vérifier `.gitignore`)
- Ne jamais donner la secret key Supabase à l'IA — ni à Claude, ni à aucun autre modèle
- Exception : certaines clés publiques sont faites pour être exposées (ex: Supabase anonkey, Firebase config)

### 2.2 Dépendances

- Lancer `npm audit` après chaque `npm install`
- L'IA installe souvent des versions obsolètes (ses données d'entraînement ont une date limite)
- Les versions obsolètes contiennent des failles connues — les pirates les exploitent en priorité
- S'abonner aux newsletters des frameworks utilisés (Next.js, etc.) pour être alerté des failles critiques

### 2.3 Front-end

- Vérifier l'authentification **avant** d'afficher les données — jamais après
- Ne jamais masquer des données sensibles avec CSS ou JavaScript : elles restent présentes dans le HTML et accessibles à n'importe qui
- Stocker le token d'authentification en cookie HttpOnly (pas en localStorage si possible)
- Ne jamais construire des requêtes SQL ou des commandes avec des données venant de l'utilisateur directement

### 2.4 Validation des entrées utilisateur

- Valider **côté serveur** — la validation front-end seule ne protège pas
- Utiliser une **whitelist** : autoriser uniquement les caractères attendus (lettres, chiffres, espaces)
- Rejeter ou nettoyer tout ce qui ressemble à du code : `< >`, `{ }`, `||`, balises HTML, JavaScript
- Utiliser les fonctions de sanitisation existantes dans les librairies — ne pas réinventer

### 2.5 Back-end / Base de données

- **Authentification ≠ Autorisation**
    - Authentification : "est-ce que cet utilisateur est connecté ?" (token valide)
    - Autorisation : "est-ce que cet utilisateur a le droit d'accéder à CET enregistrement ?"
    - Vérifier les deux à chaque requête
- Utiliser les générateurs de requêtes (Supabase client, ORM) plutôt que le SQL brut
- Relire et comprendre le SQL généré par l'IA avant de l'appliquer
- Ne jamais laisser l'IA appliquer directement des changements en base de données

### 2.6 Rate limiting

- Limiter le nombre d'appels par endpoint (ex: 10 tentatives de login par minute)
- Protège contre le brute-force et les abus d'API
- Protège aussi contre les factures d'API gonflées si une clé fuite

---

## 3 — Phase 3 : Vérification

### 3.1 Ce que Claude vérifie à chaque fin de feature

- Les données retournées sont-elles filtrées par utilisateur ?
- Les clés privées sont-elles absentes du front-end et du repo ?
- Le `.env` est-il dans le `.gitignore` ?
- Les entrées utilisateur sont-elles validées côté serveur ?
- Le RLS est-il activé sur les tables concernées ?
- `npm audit` a-t-il été lancé ?

---

## 4 — Attaques connues : références rapides

| **Attaque** | **Description courte** | **Protection** |
| --- | --- | --- |
| **XSS** | Injection de code JS dans une page via un formulaire | Valider + échapper les entrées |
| **SQL Injection** | Injection de code SQL dans une requête | Utiliser les générateurs de requêtes, jamais de SQL brut avec données utilisateur |
| **IDOR** | Accéder aux données d'un autre utilisateur en changeant l'ID dans l'URL | RLS + vérification d'autorisation à chaque requête |
| **CSRF** | Forcer un utilisateur connecté à effectuer une action à son insu | Tokens CSRF, cookies SameSite |
| **Fuite de secrets** | Clé API dans le code versionné sur GitHub | `.gitignore`  • variables d'environnement |

---

## 5 — Spécifique vibe coding

- Les IA génèrent du code fonctionnel mais rarement sécurisé par défaut
- Toujours demander explicitement : "ajoute le RLS", "valide les entrées", "n'expose pas cette clé"
- Relire le code généré avec cet angle de lecture avant d'exécuter
- En cas de doute sur une règle RLS générée : la faire vérifier par un second modèle

<aside>
📌

Source GitHub : `https://github.com/medwinrumo/vibe-method/blob/main/securite.md`

</aside>
