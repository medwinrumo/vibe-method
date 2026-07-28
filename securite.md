Règles de sécurité à appliquer dans tout projet web.

Sources : podcast Radio Vibe Code #6 + recherche OWASP 2025 + Apiiro + Snyk + USENIX Security 2025 + documentation officielle Supabase/Convex/React Native.

---

## 0 — Principe fondamental

**Zero Trust** : ne faire confiance à rien par défaut. Autoriser explicitement le minimum nécessaire, interdire tout le reste.

La sécurité est aussi solide que son maillon le plus faible. Un seul point négligé suffit.

**Loi du code généré par IA :** les LLMs génèrent du code fonctionnel mais rarement sécurisé par défaut. Étude Apiiro (40 000+ repos Fortune 50, 2025) : le code généré par IA contient 2× plus de vulnérabilités que le code humain. Étude Pearce et al. (CACM 2023) : 40 % du code généré contient des vulnérabilités de sécurité actives. Ce n'est pas un défaut de l'IA — c'est sa nature. La sécurité doit être demandée explicitement à chaque étape.

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
    
    **Sur Supabase :**
    
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
    - **Mobile — PKCE obligatoire** : sur les flux OAuth mobiles, utiliser PKCE (Proof Key for Code Exchange) — élimine le besoin d'un `client_secret` fixe dans le bundle. Un `client_secret` hardcodé dans le code React Native est extractible par décompilation.
- Le choix impacte l'UX, le schéma de BDD et les flux de récupération de compte — difficile à changer après coup
- L'IA ne propose pas de MFA par défaut — toujours le demander explicitement si nécessaire

### 1.5 Définition des rôles et permissions

- Si l'app a plusieurs types d'utilisateurs (admin, utilisateur, viewer...), définir les rôles dès la conception
- Ça impacte toute la structure : les tables, les règles de filtrage, les routes, les écrans
- Ajouter les rôles après coup est toujours plus coûteux et risqué que de les prévoir dès le départ
- **Principe du moindre privilège** : chaque rôle ne doit avoir accès qu'à ce dont il a strictement besoin
- Un utilisateur ne doit **jamais** pouvoir s'auto-promouvoir admin (vérification côté serveur obligatoire)
- **Supabase — `app_metadata` vs `user_metadata` :** les rôles doivent toujours être stockés dans `app_metadata`, jamais dans `user_metadata`. `user_metadata` est modifiable par l'utilisateur lui-même — un utilisateur peut s'auto-promouvoir admin. `app_metadata` n'est modifiable qu'en backend.
    ```javascript
    // DANGEREUX — l'utilisateur peut modifier user_metadata
    CREATE POLICY "admin_only" ON sensitive_table
    USING (auth.jwt() -> 'user_metadata' ->> 'role' = 'admin');

    // CORRECT — app_metadata non modifiable par l'utilisateur
    CREATE POLICY "admin_only" ON sensitive_table
    USING (auth.jwt() -> 'app_metadata' ->> 'role' = 'admin');
    ```
- Si l'app est **multi-tenant** (plusieurs organisations/clients dans la même app) :
    - Prévoir la séparation des données dès le schéma de base (ex: colonne `organization_id` sur chaque table)
    - Les règles RLS doivent inclure le filtre par organisation en plus du filtre par utilisateur
    - Tester que les données d'une organisation ne fuitent jamais vers une autre
- L'IA génère souvent un seul rôle "utilisateur" — penser à lui demander la gestion des rôles dès le début

### 1.6 Données sensibles

- Identifier dès le départ quelles données sont sensibles (données personnelles, moyens de paiement, mots de passe, données de santé, etc.)
- Décider comment les stocker : chiffrement au repos, chiffrement en transit, accès restreint
- Ne jamais stocker en clair ce qui peut être chiffré ou haché

**Stockage sécurisé sur mobile (React Native / Expo) :**

| Stockage | Statut | Raison |
|---|---|---|
| `AsyncStorage` pour credentials | Interdit | Non chiffré, accessible par root/jailbreak |
| Variables d'env compilées dans le bundle | Interdit | Lisibles par décompilation du JS |
| Clés hardcodées dans le code | Interdit | Extraction triviale |
| `expo-secure-store` | Recommandé | Keychain iOS, Keystore Android |
| Mémoire (state React) | Acceptable | Disparaît à la fermeture, jamais persisté |

Le bundle JS Expo/React Native est entièrement lisible par décompilation. Tout ce qui est dans le code ou dans `AsyncStorage` est extractible. Il n'existe pas de variable d'environnement "privée" dans un bundle mobile — elles finissent dans le bundle.

Règle absolue : aucune clé privée ne doit exister dans le code source React Native.

**Backups mobiles :**
- Désactiver les backups iCloud/Google pour les données sensibles via les flags de stockage appropriés
- Ne jamais logguer de données personnelles, même en debug (`console.log('User data:', user)` est une fuite de données)

### 1.7 RGPD

La conformité RGPD se conçoit dès la phase `/archi`, pas après le lancement.

La doctrine complète est dans `rgpd.md` — bases légales, minimisation des données, registre des traitements, droits des utilisateurs, consentement, politique de confidentialité, sous-traitants, transferts hors UE, violation de données, DPIA, DPO, checklist avant prod.

**Règle absolue :** l'IA ne pense pas au RGPD quand elle génère du code — toujours le demander explicitement. La checklist de conformité de `rgpd.md` est obligatoire avant toute mise en production.

### 1.8 Stratégie de backup

- Décider dès le départ comment et à quelle fréquence les données sont sauvegardées
- Vérifier ce que le service choisi (Supabase, Firebase, etc.) propose nativement comme backups
- Tester la restauration — un backup qui n'a jamais été testé ne vaut rien

La doctrine complète (niveaux de criticité, outils, fréquences, politique de rétention, test de restauration) est dans `architecture.md` section "Backup & conformité RGPD". `/archi` Étape 4c documente les décisions backup du projet.

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
    - Données utilisateur en debug (`console.log('User:', user)`)
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

### 1.14 Niveau de risque du projet

À définir dès `/brief` et `/archi` — détermine l'intensité des mesures de sécurité requises.

| Niveau | Critères | Exemples |
|---|---|---|
| Bas | Pas de données personnelles, pas de paiement, app publique | Site vitrine, portfolio |
| Moyen | Comptes utilisateurs, données personnelles standard | App de notes, SaaS |
| Élevé | Paiements, données de santé, données d'entreprise confidentielles | Fintech, santé, B2B |

Ce niveau est à documenter dans `[projet].brief.md` et `[projet].archi.md`. Il détermine les outils de scan à utiliser (§3.2), le type d'audit avant déploiement (§4), et si un pentest externe est nécessaire (§4).

---

## 2 — Phase 2 : Pendant le code

### 2.1 Secrets et clés API

- **Jamais** de clé API privée en front-end (ni dans le code, ni dans les variables d'environnement front)
- Les secrets vivent uniquement dans les variables d'environnement **back-end** (`.env`)
- Le fichier `.env` ne doit **jamais** être commité sur GitHub (vérifier `.gitignore`)
- Ne jamais donner la secret key Supabase à l'IA — ni à Claude, ni à aucun autre modèle
- Exception : certaines clés publiques sont faites pour être exposées (ex: Supabase anonkey, Firebase config)

**Supabase — `anon` key vs `service_role` key :**

| Clé | Rôle | Bypass RLS | Où l'utiliser |
|---|---|---|---|
| `anon` key | Utilisateurs non authentifiés | Non | Client-side, public |
| `service_role` key | Admin système | Oui — bypass total | Back-end uniquement, jamais dans le bundle |

L'IA génère souvent du code côté client qui initialise Supabase avec la `service_role` key "pour que ça marche" pendant le développement. Cette clé bypass le RLS et donne accès complet à toute la base — y compris les données de tous les utilisateurs.

### 2.2 Dépendances

- Lancer `npm audit` après chaque `npm install`
- L'IA installe souvent des versions obsolètes (ses données d'entraînement ont une date limite)
- Les versions obsolètes contiennent des failles connues — les pirates les exploitent en priorité
- S'abonner aux newsletters des frameworks utilisés (Next.js, etc.) pour être alerté des failles critiques
- **En CI/CD** : utiliser `npm ci` (ou `yarn --frozen-lockfile`) — utilise exclusivement le lockfile et détecte les modifications non validées
- **Dependabot** : activer sur chaque repo GitHub — alertes de sécurité automatiques + PR de mise à jour des dépendances vulnérables (gratuit)
- **lockfile-lint** : valide que le lockfile ne pointe que vers des registries de confiance (protège contre les attaques supply chain via substitution de registry)

**Hallucinations de packages LLM — risque critique :**

Étude USENIX Security 2025 (576 000 échantillons, 16 LLMs) : ~20 % des échantillons référencent des packages inexistants. 43 % de ces noms sont reproduits de façon stable — un attaquant peut créer le package inexistant et attendre que du code généré par IA l'importe.

Règle : avant d'installer un package suggéré par l'IA, vérifier son existence sur npmjs.com (nombre de téléchargements, date de dernière publication, mainteneur actif). Un package avec 0 téléchargements ou créé très récemment est suspect.

Illustration réelle : en mars 2026, le package Axios (100 millions de téléchargements/semaine) a été compromis via le compte npm de son mainteneur. Un script postinstall installait un RAT. En septembre 2025, l'attaque "Shai-hulud" a propagé du code malveillant dans 18 packages populaires via phishing d'un seul mainteneur.

### 2.3 Front-end

- Vérifier l'authentification **avant** d'afficher les données — jamais après
- Ne jamais masquer des données sensibles avec CSS ou JavaScript : elles restent présentes dans le HTML et accessibles à n'importe qui
- Stocker le token d'authentification en cookie HttpOnly (pas en localStorage si possible)
- Ne jamais construire des requêtes SQL ou des commandes avec des données venant de l'utilisateur directement
- **`dangerouslySetInnerHTML` interdit sans sanitisation :** React échappe par défaut les valeurs JSX, mais l'IA utilise régulièrement `dangerouslySetInnerHTML` pour afficher du HTML "riche". Ne jamais l'utiliser sans passer le contenu par `DOMPurify` ou `sanitize-html`.
    ```jsx
    // DANGEREUX — généré typiquement par l'IA
    <div dangerouslySetInnerHTML={{ __html: userContent }} />

    // CORRECT
    import DOMPurify from 'dompurify'
    <div dangerouslySetInnerHTML={{ __html: DOMPurify.sanitize(userContent) }} />
    ```

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

**Auth côté serveur obligatoire — le piège le plus courant généré par l'IA :**

Le pattern le plus courant généré par les LLMs pour "protéger" une route :
```jsx
// React — guard côté client
function ProtectedPage() {
  const { user } = useAuth()
  if (!user) return <Navigate to="/login" />
  return <SensitivePage />
}
```
Ce code protège l'affichage visuel — **pas les données**. Un attaquant n'a pas besoin de l'interface React. Il appelle directement l'API avec `curl` ou `fetch`. Si l'API ne vérifie pas le token, les données sont exposées.

Pattern correct pour Supabase :
```javascript
// Edge Function — vérification du JWT côté serveur
export default async function handler(req: Request) {
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: req.headers.get('Authorization') ?? '' } }
  })
  const { data: { user }, error } = await supabase.auth.getUser()
  if (!user || error) return new Response('Unauthorized', { status: 401 })
  // Suite du traitement...
}
```
`supabase.auth.getUser()` valide le JWT en appelant le serveur Supabase — ce n'est pas une vérification locale du token (qui serait falsifiable). C'est la seule méthode sûre.

Pattern correct pour Convex :
```javascript
export const getMyOrders = query({
  args: {},
  handler: async (ctx) => {
    const identity = await ctx.auth.getUserIdentity()
    if (!identity) throw new ConvexError("Unauthenticated")
    return await ctx.db
      .query("orders")
      .withIndex("by_user", (q) => q.eq("userId", identity.subject))
      .collect()
  }
})
```

Toute `query()` et `mutation()` Convex publique doit appeler `ctx.auth.getUserIdentity()`. Les opérations sensibles passent par `internalMutation`.

- Utiliser les générateurs de requêtes (Supabase client, ORM) plutôt que le SQL brut
- Relire et comprendre le SQL généré par l'IA avant de l'appliquer
- Ne jamais laisser l'IA appliquer directement des changements en base de données

**Mass Assignment — whitelister les champs acceptés :**

L'IA passe souvent `req.body` directement à la mise à jour sans filtrer les champs autorisés — un utilisateur peut envoyer `{"role": "admin"}` et l'app l'accepte.

```javascript
// DANGEREUX — généré typiquement
const updatedUser = await supabase
  .from('users')
  .update(req.body)      // Accepte tout ce que l'utilisateur envoie
  .eq('id', userId)

// CORRECT — whitelister les champs autorisés
const { displayName, avatar } = req.body
const updatedUser = await supabase
  .from('users')
  .update({ displayName, avatar })   // Jamais 'role', 'email', etc.
  .eq('id', userId)
```

Convex : valider les arguments avec un schéma exact — ne jamais accepter `v.any()` pour des mutations qui modifient la base.

```javascript
// DANGEREUX
export const updateUser = mutation({
  args: { updates: v.any() },
  ...
})

// CORRECT
export const updateUser = mutation({
  args: {
    displayName: v.optional(v.string()),
    avatar: v.optional(v.string()),
    // 'role' absent — un utilisateur ne peut pas changer son rôle
  },
  ...
})
```

### 2.6 Rate limiting

- Limiter le nombre d'appels par endpoint (ex: 10 tentatives de login par minute)
- Protège contre le brute-force et les abus d'API
- Protège aussi contre les factures d'API gonflées si une clé fuite
- Limiter la taille des payloads (body-parser limits en Express) — empêche les attaques par payload massif
- Quotas sur les appels aux APIs externes (OpenAI, Anthropic, etc.) avec alertes de coût configurées

**Endpoints d'authentification — au-delà de la limite générique :**
- Limiter par IP **et** par compte séparément (bloquer un compte ciblé ne doit pas nécessiter de bloquer toute une IP partagée, et inversement)
- Délai progressif entre tentatives (1s, 2s, 4s...) plutôt qu'un simple compteur dur
- Verrouillage temporaire du compte après un seuil (ex : 5 échecs → 15 min de blocage), jamais un blocage définitif silencieux
- Ne jamais révéler si c'est l'email ou le mot de passe qui est incorrect (message générique)

### 2.7 Principe du moindre privilège — base de données

Au-delà du RLS, deux axes souvent oubliés.

**Supabase — RLS par opération, pas global :**

Une policy SELECT ≠ UPDATE ≠ INSERT ≠ DELETE. L'IA génère souvent `USING (auth.uid() = user_id)` pour tout — ce qui est insuffisant.

```sql
-- Insuffisant (généré par l'IA)
CREATE POLICY "users_own_data" ON orders USING (auth.uid() = user_id);

-- Correct : politiques distinctes par opération
CREATE POLICY "select_own_orders" ON orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert_own_orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update_own_orders" ON orders FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id AND status != 'completed');
-- Pas de DELETE policy = pas de DELETE pour les utilisateurs
```

**Supabase — Grants PostgreSQL :**

Au-delà du RLS, Supabase utilise les rôles PostgreSQL `anon` et `authenticated`. N'accorder que les privileges nécessaires.

```sql
-- Table orders — lecture et insertion pour les authentifiés, rien pour anon
GRANT SELECT, INSERT ON orders TO authenticated;
REVOKE ALL ON orders FROM anon;
```

**Convex — public vs internal :**

```javascript
// Accessible depuis le client — doit vérifier l'auth
export const createOrder = mutation({ ... })

// Accessible uniquement depuis d'autres fonctions Convex — jamais depuis le client
export const processPayment = internalMutation({ ... })
```

Audit systématique à faire sur tout projet Convex : chercher toutes les occurrences de `query(`, `mutation(`, `action(`, `httpAction(` et vérifier que chacune appelle `ctx.auth.getUserIdentity()`.

### 2.8 En-têtes de sécurité HTTP (Security Headers)

Vercel gère HTTPS automatiquement mais **ne configure pas** les en-têtes de sécurité HTTP au niveau application. Un déploiement Vercel sans configuration additionnelle est signalé comme "insecure headers" par les scanners.

Configuration minimale dans `vercel.json` :

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "X-Frame-Options", "value": "SAMEORIGIN" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-XSS-Protection", "value": "1; mode=block" },
        { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" },
        { "key": "Permissions-Policy", "value": "camera=(), microphone=(), geolocation=()" }
      ]
    }
  ]
}
```

**Content Security Policy (CSP) :**

La CSP est plus complexe — une CSP mal configurée casse l'app. Protocole recommandé :

1. Démarrer en mode rapport : `Content-Security-Policy-Report-Only`
2. Analyser les violations sans bloquer
3. Passer en mode enforcement une fois la politique stable
4. Interdire `unsafe-inline` pour les scripts — ne jamais l'autoriser

```json
{
  "key": "Content-Security-Policy",
  "value": "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self' https://*.supabase.co https://*.convex.cloud; frame-ancestors 'none'"
}
```

Note : `'unsafe-inline'` est conservé pour `style-src` car Tailwind CSS et la plupart des librairies CSS-in-JS en ont besoin. Pour les scripts (`script-src`), `unsafe-inline` ne doit jamais être autorisé.

**Supabase Edge Functions :** `verify_jwt: true` par défaut en prod, jamais `false` — l'IA met parfois `false` "pour tester rapidement".

### 2.9 Sécurité des webhooks

Les apps qui intègrent des services tiers (Stripe, Supabase Events, services d'emailing) via des webhooks doivent vérifier l'authenticité des requêtes. L'IA génère des endpoints webhook qui acceptent n'importe quelle requête POST sans vérification.

**Protection : vérification HMAC-SHA256**

```javascript
// Supabase Edge Function — exemple avec Stripe
export default async function handler(req: Request) {
  const signature = req.headers.get('stripe-signature')
  const rawBody = await req.text() // CRITIQUE : lire le corps RAW avant tout parsing

  try {
    const event = stripe.webhooks.constructEvent(rawBody, signature, STRIPE_WEBHOOK_SECRET)
    // Traitement...
  } catch (err) {
    return new Response('Invalid signature', { status: 400 })
  }
}
```

Points critiques :
1. Le corps doit être lu en RAW — si le framework parse le JSON d'abord, la sérialisation peut invalider la signature
2. Stripe inclut un timestamp dans la signature — le valider pour prévenir les attaques par replay
3. Utiliser `timingSafeEqual` pour la comparaison — évite les attaques par timing side channel

### 2.10 SSRF — Server-Side Request Forgery

L'IA génère des proxies d'URL simples côté serveur sans valider que l'URL cible est autorisée :

```javascript
// Edge Function — DANGEREUX si url vient de l'utilisateur
const response = await fetch(req.body.url)
```

Un attaquant peut cibler des services internes non exposés publiquement (métadonnées cloud AWS/GCP, services internes).

Protection :
- Toujours valider les URLs fournies par l'utilisateur contre une whitelist de domaines autorisés
- Bloquer les plages d'IP privées (10.x.x.x, 172.16.x.x, 192.168.x.x) et les adresses loopback (127.0.0.1, localhost)

### 2.11 Mobile — Sécurité spécifique React Native / Expo

**Deep Link Hijacking :**

L'IA génère des deep links du type `myapp://callback?token=xxx` pour les flows OAuth mobiles. Une app malveillante peut enregistrer le même scheme et capturer les tokens.

Protection :
- Utiliser **Universal Links** (iOS) et **App Links** (Android) — liés au domaine HTTPS, non interceptables par d'autres apps
- Ne jamais transmettre de token dans les paramètres d'URL d'un deep link
- Expo : configurer `scheme` + `intentFilters` avec `autoVerify: true` pour les App Links Android

**Données sensibles sur l'appareil :**
- iOS : utiliser le Keychain pour les credentials, GroupContainers avec chiffrement pour les données utilisateur
- Désactiver les backups iCloud/Google pour les données sensibles
- Ne jamais logguer de données personnelles, même en debug

### 2.12 Prototype Pollution (JavaScript)

Manipulation du prototype global d'un objet JavaScript via des données utilisateur (`__proto__`, `constructor`, `prototype`). L'IA merge des objets utilisateur sans protection : `Object.assign({}, req.body)`. CVE-2024-51999 dans Express (sévérité 6.9).

Protection :
- Ne pas merger directement des objets utilisateur dans des objets applicatifs
- Utiliser `JSON.parse(JSON.stringify(input))` pour cloner les objets issus d'entrées utilisateur
- `npm audit` détecte les CVE connus sur les dépendances vulnérables

### 2.13 Sécurité des fonctionnalités IA/LLM (si le projet en expose)

Distinct du §7 (le fait que Claude *génère* le code) — ici, le projet lui-même **expose** une fonctionnalité IA à l'utilisateur (chat, agent, génération de contenu). Concerne Minou et tout projet avec un LLM en fonctionnalité produit.

- **Output du modèle = non fiable.** Jamais injecté directement dans `eval`, une requête SQL, un shell, `innerHTML`, ou un chemin de fichier — mêmes règles que pour un input utilisateur classique.
- **Le system prompt n'est pas une frontière de sécurité.** Ne jamais compter dessus pour empêcher une action — les permissions réelles se codent, pas se demandent poliment au modèle (risque de prompt injection).
- **Contexte isolé par tenant.** Jamais de secret, de donnée cross-tenant, ou du system prompt complet dans une fenêtre de contexte accessible à l'utilisateur.
- **Permissions d'outils/agents scopées.** Si le projet donne à un LLM la capacité d'agir (function calling, agent), chaque outil a un périmètre explicite ; toute action destructive (suppression, paiement, envoi) demande confirmation humaine.
- **Limites de tokens, de débit, de récursion.** Un agent qui boucle ou qui consomme sans borne est un vecteur de déni de service et de facture incontrôlée — voir aussi §2.6 quotas API.

Base minimum : OWASP Top 10 for LLM Applications. Grille appliquée en revue ad hoc par `agents/security-auditor.md` (point 6 de son périmètre).

---

## 2bis — Gestion des ressources

La gestion des ressources, c'est s'assurer que ton application ne consomme pas plus que ce qu'elle ne devrait — ni en mémoire, ni en connexions, ni en appels à des services externes. Une app mal gérée ralentit, plante ou génère des coûts imprévus, même avec peu d'utilisateurs.

Ces règles s'appliquent dès la conception (`/archi`, `/stack`) et se vérifient à chaque feature codée.

---

### 2bis.1 — Penser en connexions simultanées, pas en nombre d'utilisateurs

**Le problème :** quand on parle de charge, l'instinct est de raisonner en nombre d'utilisateurs. C'est la mauvaise métrique. Ce qui compte, c'est combien d'utilisateurs sont actifs **en même temps** — et combien de connexions chacun génère.

**Pourquoi ce n'est pas la même chose :**

Une connexion n'est pas toujours égale à un utilisateur. Selon ce que fait l'app :
- Un utilisateur qui charge une page peut ouvrir **plusieurs connexions simultanément** (données initiales + écoute temps réel + rafraîchissement périodique)
- Une app avec du temps réel (chat, notifications) peut générer 3 à 5 connexions par utilisateur actif
- 100 utilisateurs inscrits qui se connectent tous en même temps ≠ 10 000 utilisateurs qui se connectent une fois par mois

**Question à poser lors du `/archi` :** "Décris ce qu'un utilisateur typique fait sur l'app : combien de temps reste-t-il, est-ce que l'app se met à jour automatiquement, y a-t-il du temps réel ?" Cette réponse permet d'estimer la charge réelle.

**Contre-mesure concrète :** choisir le bon plan dès le départ. Exemple : Supabase free tier autorise 60 connexions simultanées. Si chaque utilisateur actif en génère 3, l'app tient 20 utilisateurs simultanés — pas 60. Cette limite se vérifie dans `/stack` pour chaque service utilisé.

---

### 2bis.2 — Connaître la limite mémoire de chaque service et ce qui se passe quand elle est atteinte

**Le problème :** quand trop de requêtes arrivent en même temps, elles s'accumulent dans une file d'attente. Cette file consomme de la mémoire. Quand la limite est atteinte, deux scénarios :
- **Dégradation douce** : les nouvelles requêtes sont refusées proprement, les données restent intactes
- **Crash dur** : le serveur s'éteint brutalement — risque de perte de données en cours d'écriture

Sur Supabase et Xano : si tu remplis la mémoire, ça shut down (crash dur).

**Ce qu'il faut faire dans `/stack` :**
1. Identifier la limite mémoire du plan choisi pour chaque service
2. Identifier le comportement à saturation (dégradation douce ou crash dur)

**Contre-mesures selon le résultat :**
- Si **crash dur** → prévoir une page d'erreur explicite côté front, et si la charge est prévisible (événement, campagne), mettre en place une salle d'attente qui régule les connexions entrantes
- Si **dégradation douce** → vérifier que les requêtes sont bien rejetées sans perte de données en cours
- Dans tous les cas : configurer des **alertes** pour être prévenu avant d'atteindre la limite — pas après

---

### 2bis.3 — Ne pas compter sur le scaling de la base de données comme solution de secours

**Le problème :** quand une app rame, l'instinct est de vouloir "ajouter de la puissance". Pour le front-end et le serveur, c'est souvent faisable. Pour la base de données, c'est une autre affaire.

Les bases de données SQL sont mal faites pour le scaling horizontal (multiplier les instances). Rajouter des serveurs DB en parallèle crée des risques de désynchronisation des données — un utilisateur peut écrire sur une instance et lire une donnée périmée sur une autre.

**Ce qu'on en déduit :** le vrai levier est de **réduire la pression sur la DB dès la conception**, pas d'augmenter sa puissance après coup. Ça signifie : bonne modélisation des données, requêtes légères (cf. 2bis.5), et cache (cf. 2bis.4). C'est une décision d'architecture, à poser dans `/archi` — pas une optimisation tardive.

---

### 2bis.4 — Prévoir le cache à l'architecture, pas quand le site rame

**Le problème :** si beaucoup d'utilisateurs font les mêmes requêtes (lire la liste des produits, afficher un tableau de bord), chaque requête tape directement dans la base de données. Sous charge, ça épuise rapidement le quota de connexions disponibles.

**La solution : le cache.** Plutôt que de demander à la DB à chaque fois, on stocke temporairement le résultat en mémoire. Les utilisateurs lisent depuis le cache. Le cache met à jour la DB au fil de l'eau.

**Ce n'est pas une optimisation avancée.** C'est une décision d'architecture à prendre lors du `/archi` si le projet anticipe de la charge concurrente.

**Pour chaque nouvelle stack, vérifier :**
- Est-ce que la stack intègre un cache nativement ? (Convex : oui, cache intégré. Supabase : non par défaut)
- Si non : prévoir une couche de cache explicite (Redis ou équivalent)
- L'IA ne propose pas de cache par défaut — le demander explicitement si nécessaire

---

### 2bis.5 — Écrire des requêtes légères dès le départ (frugalité)

**Le problème :** une requête qui fetche trop de données (toutes les colonnes, toutes les lignes, sans filtre) est une requête qui consomme plus de mémoire, plus de connexions, et prend plus de temps — pour chaque utilisateur, à chaque chargement de page.

**Exemple réel :** une startup a cru que PostgreSQL ne tenait pas au-delà d'un million d'enregistrements. En réalité, leurs requêtes étaient mal écrites. Des crédits cloud massifs masquaient le problème. Quand les crédits ont disparu, tout est devenu lent.

**La règle :** chaque requête écrite doit répondre à la question — "est-ce que je fetche uniquement ce dont j'ai besoin ici ?" :
- Ne sélectionner que les colonnes utilisées (pas de `SELECT *` systématique)
- Toujours filtrer (ne pas récupérer 10 000 lignes pour n'en afficher que 10)
- Paginer les listes longues
- **Activer le logging des requêtes lentes** (`log_min_duration_statement` sur Postgres, ou équivalent selon la stack) dès le niveau 2 de déploiement — sans ça, une requête qui se dégrade progressivement reste invisible jusqu'à ce qu'un utilisateur se plaigne

**Dans `/specs` :** documenter ce que chaque requête doit retourner exactement. Pas "les messages", mais "les 20 derniers messages du canal, avec auteur et timestamp uniquement".

**L'IA génère souvent des `SELECT *` ou des requêtes sans filtre** pour aller vite — relire systématiquement.

---

### 2bis.6 — Identifier le goulot d'étranglement de chaque stack

**Le principe :** dans une architecture web, plusieurs couches peuvent lâcher sous charge. Ce n'est pas toujours la même selon la stack. Il faut savoir laquelle lâche en premier — et à quel seuil — pour savoir où concentrer les efforts.

**Ce que `/stack` doit produire pour chaque projet :**

| Couche | Résistance à la charge | Goulot potentiel |
|---|---|---|
| Front-end (Netlify, Vercel) | Très bonne (CDN) | Rarement le problème |
| Back-end serveur | Dépend du plan | À vérifier |
| Base de données | Le point faible habituel | Connexions simultanées, mémoire |
| API externes (OpenAI, etc.) | Rate limiting strict | À surveiller par clé API |

**Contre-mesure :** une fois le goulot identifié, toutes les décisions d'architecture qui suivent (cache, modélisation, choix de plan) se concentrent sur ce point. On ne renforce pas ce qui est déjà solide.

---

## 3 — Phase 3 : Vérification

### 3.1 Ce que Claude vérifie à chaque fin de feature

- [ ] Les données retournées sont-elles filtrées par utilisateur ?
- [ ] Les vérifications d'autorisation sont-elles faites côté serveur (pas seulement guard React) ?
- [ ] Les clés privées sont-elles absentes du front-end et du repo ?
- [ ] Le `.env` est-il dans le `.gitignore` ?
- [ ] Les entrées utilisateur sont-elles validées côté serveur ?
- [ ] Le RLS est-il activé sur les tables concernées ? Avec des policies distinctes par opération (SELECT/INSERT/UPDATE/DELETE) ?
- [ ] `npm audit` a-t-il été lancé ?
- [ ] Les mutations whitelistent-elles les champs acceptés (pas de `req.body` passé directement) ?
- [ ] Y a-t-il du `dangerouslySetInnerHTML` ? → vérifier que DOMPurify est appliqué
- [ ] Les nouvelles routes d'API vérifient-elles l'auth côté serveur (pas seulement côté client) ?
- [ ] Y a-t-il des webhooks entrants ? → vérifier la signature HMAC
- [ ] Y a-t-il des URLs fournies par l'utilisateur passées à `fetch` côté serveur ? → vérifier la whitelist
- [ ] Les packages nouvellement installés ont-ils été vérifiés sur npmjs.com ?
- [ ] Si mobile : aucune donnée sensible dans `AsyncStorage` ? → expo-secure-store utilisé ?

### 3.2 Outils de scan automatique

À intégrer dans la CI/CD dès le setup du projet.

| Outil | Type | Coût | Ce qu'il détecte |
|---|---|---|---|
| Semgrep | SAST (analyse statique du code) | Gratuit (OSS) | `dangerouslySetInnerHTML`, SQL brut, secrets dans le code, patterns dangereux React/Node |
| Snyk | SCA (analyse des dépendances) | Gratuit (dev) | CVE dans les dépendances node_modules |
| Dependabot | Automatique GitHub | Gratuit | Alertes de sécurité + PR de mise à jour |
| `npm audit` | SCA local | Gratuit | CVE connus dans node_modules |

```bash
# Semgrep — scan avec règles de sécurité React/Node/secrets
npm install -g semgrep
semgrep --config "p/react" --config "p/nodejs" --config "p/secrets" .

# Snyk — scan des dépendances
npm install -g snyk
snyk test         # Scan ponctuel
snyk monitor      # Surveillance continue
```

Benchmark : Snyk Code : 97 % de vrais positifs (OWASP Benchmark). Semgrep : 87 %. Utilisés ensemble, leur couverture est complémentaire.

---

## 4 — Avant la mise en ligne

### Checklist sécurité minimale

À passer obligatoirement avant toute mise en production.

- [ ] Les clés API et secrets sont dans des variables d'environnement — jamais dans le code source, jamais en front-end
- [ ] Les clés de production sont différentes des clés de développement (rotation)
- [ ] L'authentification est vérifiée côté serveur, pas uniquement côté navigateur
- [ ] Les permissions de la base de données sont restrictives — chaque utilisateur ne voit que ses propres données (RLS activé, policies par opération)
- [ ] Les mutations whitelistent les champs acceptés — pas de `req.body` direct
- [ ] Les entrées utilisateur sont validées côté serveur (formulaires, paramètres d'URL)
- [ ] Les données sensibles sont chiffrées (mots de passe hachés, données personnelles protégées)
- [ ] HTTPS activé (géré automatiquement par Vercel/Netlify)
- [ ] Security headers configurés dans `vercel.json` (X-Frame-Options, X-Content-Type-Options, CSP testée en mode report-only d'abord)
- [ ] Dependabot activé sur le repo GitHub
- [ ] `service_role` key Supabase absente de tout repo Git (y compris les configs CI)
- [ ] Variables d'environnement de prod déclarées dans Vercel Dashboard — pas dans `.env` commité
- [ ] Limite de prélèvement configurée dès l'ajout d'une carte bancaire sur toute plateforme cloud (Vercel, Cloudflare, etc.) — avant le premier dépassement de plan gratuit, pas après

### Audit de sécurité léger (avant chaque mise en production)

**Outils gratuits à utiliser avant le go-live :**

```bash
# Mozilla Observatory CLI — scan des en-têtes de sécurité HTTP
npx observatory --format report https://monapp.vercel.app
```

- **Mozilla Observatory** (gratuit) — scan des en-têtes HTTP, TLS, CSP
- **securityheaders.com** (gratuit) — vérification rapide CSP, HSTS, X-Frame-Options
- **OWASP ZAP** (gratuit, open source) — scan DAST de l'app en ligne (failles runtime)

Intégrer le résultat du scan dans `[projet].recette.md` (section Sécurité) avant le go-live.

**Si niveau de risque élevé** (paiements, données de santé, B2B, >1 000 utilisateurs avec données personnelles) : envisager un pentest manuel ou faire appel à un service de bug bounty (HackerOne, YesWeHack) avant le lancement.

### Audit sécurité croisé double LLM

L'IA qui a écrit le code peut également auditer sa propre sécurité — à condition qu'on le lui demande explicitement. Elle ne le fait jamais spontanément.

**Étape 1 — Audit avec le LLM courant (Claude) :**

Prompt d'audit :
> "Fais un audit de sécurité complet de cette application. Vérifie : validation des entrées, gestion des clés API, authentification côté serveur vs côté client, permissions de la base de données, protection contre les injections, mass assignment, webhooks, security headers, dangerouslySetInnerHTML, packages suspects."

**Étape 2 — Audit croisé avec un second LLM (pattern /party appliqué à la sécurité) :**

Chaque modèle a été entraîné différemment et détecte des choses que l'autre manque. Après l'audit Claude, soumettre le même code à GPT-4 ou Gemini avec le même prompt.

Points de divergence entre les deux audits → à traiter en priorité (ni l'un ni l'autre n'a validé ce point).

**Règle :** l'audit croisé est obligatoire pour les projets de niveau de risque moyen et élevé (§1.14). Pour les projets bas, il est recommandé.

### Erreur critique Supabase — clé service_role

La clé `service_role` contourne toutes les protections de la base de données. Elle ne doit jamais se trouver dans le code JavaScript exécuté dans le navigateur. Seule la clé `anon` (clé publique) est faite pour le front-end — à condition que les Row Level Security soient activées sur toutes les tables. La `service_role` vit uniquement dans les variables d'environnement back-end.

---

## 5 — Attaques connues : références rapides

| **Attaque** | **Description courte** | **Protection** |
| --- | --- | --- |
| **XSS** | Injection de code JS dans une page via un formulaire | Valider + échapper les entrées. Ne jamais utiliser `dangerouslySetInnerHTML` sans DOMPurify |
| **SQL Injection** | Injection de code SQL dans une requête | Utiliser les générateurs de requêtes, jamais de SQL brut avec données utilisateur |
| **IDOR** | Accéder aux données d'un autre utilisateur en changeant l'ID dans l'URL | RLS + vérification d'autorisation à chaque requête |
| **CSRF** | Forcer un utilisateur connecté à effectuer une action à son insu | Tokens CSRF, cookies SameSite |
| **Fuite de secrets** | Clé API dans le code versionné sur GitHub | `.gitignore` + variables d'environnement |
| **Mass Assignment** | L'utilisateur envoie des champs qu'il ne devrait pas pouvoir modifier (`role: admin`) | Whitelist explicite des champs acceptés en update |
| **SSRF** | Forcer le serveur à faire des requêtes vers des services internes | Whitelist d'URLs + blocage IPs privées |
| **Supply Chain** | Package npm compromis ou halluciné par l'IA | Vérifier npmjs.com + Dependabot + lockfile-lint |
| **Deep Link Hijacking** | App malveillante capture les tokens via deep links | Universal Links (iOS) + App Links (Android) |
| **Prototype Pollution** | Manipulation du prototype global via `__proto__` | Ne pas merger objets utilisateur directement |
| **Broken Access Control** | Auth vérifiée uniquement côté client — l'API est accessible sans auth | Vérification JWT côté serveur à chaque route |

---

## 6 — Stratégie cybersécurité par projet

La sécurité n'est pas une phase — c'est une contrainte transversale. Elle s'intègre à chaque phase du workflow vibe-method avec un livrable spécifique.

### 6.1 Phase /brief

**Question obligatoire :** "Quelles données sensibles l'app manipule-t-elle ?"

**Décision :** niveau de risque du projet (bas / moyen / élevé) — voir §1.14.

**Livrable :** mention du niveau de risque dans `[projet].brief.md`.

### 6.2 Phase /archi

C'est la phase la plus critique pour la sécurité — les décisions d'architecture sont les plus coûteuses à changer.

**Questions obligatoires :**
1. Quel service d'auth ? (Supabase Auth, Clerk, Auth0, Firebase Auth — jamais fait maison)
2. Les accès multi-rôles sont-ils nécessaires ? (Si oui : schéma de rôles dès maintenant, stockés dans `app_metadata`)
3. L'app est-elle multi-tenant ? (Si oui : `organization_id` sur chaque table dès le schéma)
4. Y a-t-il des webhooks entrants ? (Si oui : stratégie de vérification HMAC-SHA256)
5. Y a-t-il des appels à des URLs fournies par l'utilisateur ? (Si oui : whitelist de domaines)
6. **Threat modeling STRIDE** sur chaque frontière de confiance identifiée (où une donnée non fiable entre dans le système) :
   - **S**poofing — peut-on usurper une identité ?
   - **T**ampering — peut-on modifier une donnée en transit ou au repos ?
   - **R**epudiation — une action peut-elle être niée faute de trace ?
   - **I**nformation disclosure — une donnée peut-elle fuiter ?
   - **D**enial of service — le service peut-il être saturé ?
   - **E**levation of privilege — peut-on obtenir plus de droits que prévu ?

   Un passage systématique, pas juste "on verra à l'usage" — comparer contre la doctrine `agents/security-auditor.md` qui applique cette grille en revue ad hoc.

**Livrable dans `[projet].archi.md` — section Sécurité :**
- Schéma des rôles et permissions
- Liste des tables avec leur niveau RLS requis
- Liste des endpoints publics vs authentifiés
- Décision : `service_role` key — où et comment protégée

### 6.3 Phase /stack

**Questions sécu à ajouter au spike :**
- Le service a-t-il un rate limiting natif ? (peut-il être épuisé par une attaque ?)
- Le comportement à saturation est-il une dégradation douce ou un crash dur ?
- Le service supporte-t-il les security headers nécessaires ?
- Y a-t-il un historique de CVE sur les dépendances principales ?

**Livrable :** section "Risques sécu" dans `[projet].stack.md`.

### 6.4 Phase /specs

**Pour chaque user story, vérifier :**
- Qui peut effectuer cette action ? (rôle requis)
- Quelles données sont exposées ? (minimisation)
- Y a-t-il une validation des entrées à spécifier côté serveur ?

**Livrable :** contraintes sécu documentées dans `[projet].spec.[feature].md`.

### 6.5 Phase [code]

Appliquer la checklist §3.1 à chaque feature. Lancer Semgrep + Snyk (§3.2) régulièrement.

### 6.6 Phase /code-review

**Questions de sécurité à vérifier :**
- Chaque endpoint API vérifie-t-il l'auth côté serveur ?
- Les nouvelles tables ont-elles des policies RLS distinctes par opération ?
- Les mutations whitelistent-elles les champs acceptés ?
- Les en-têtes de sécurité sont-ils configurés dans `vercel.json` ?
- Y a-t-il des packages nouvellement installés ? → vérifier sur npmjs.com
- Y a-t-il du `dangerouslySetInnerHTML` ? → vérifier DOMPurify

### 6.7 Phase /recette (avant mise en production)

Lancer les scanners de la §4 : Mozilla Observatory, securityheaders.com, OWASP ZAP.

Intégrer le rapport dans `[projet].recette.md`.

### 6.8 Phase /deploy

Appliquer la checklist complète de la §4 avant go-live.

### 6.9 Qui fait quoi — IA vs développeur

| Responsabilité | IA | Développeur |
|---|---|---|
| Générer les policies RLS | Oui — à la demande | Valide, teste avec un utilisateur non-propriétaire |
| Configurer les security headers | Oui — template standard | Adapte la CSP à l'app spécifique |
| Implémenter la validation des entrées | Oui | Vérifie que tous les champs sont couverts |
| Décider du niveau de risque | Non | Oui — décision métier |
| Valider les policies RLS multi-rôles complexes | Non seul — risque d'erreur | Teste chaque rôle manuellement |
| Scanner les dépendances (Snyk) | Déclenche le scan | Analyse les résultats, décide des mises à jour |
| Audit de sécurité final (DAST) | Déclenche le scan | Interprète les résultats, priorise les corrections |

---

## 7 — Spécifique vibe coding

- Les IA génèrent du code fonctionnel mais rarement sécurisé par défaut — voir §0
- Toujours demander explicitement : "ajoute le RLS", "valide les entrées", "n'expose pas cette clé", "whitelist les champs acceptés"
- Relire le code généré avec l'angle de sécurité avant d'exécuter
- En cas de doute sur une règle RLS générée : la faire vérifier par un second modèle
- Vérifier tout package suggéré par l'IA sur npmjs.com avant installation (§2.2)
- Les patterns dangereux les plus courants générés par les LLMs :
    - Guards React sans vérification API côté serveur
    - `service_role` key côté client "pour que ça marche"
    - `dangerouslySetInnerHTML` sans sanitisation
    - `req.body` passé directement à un update DB
    - `Access-Control-Allow-Origin: *` en production
    - `verify_jwt: false` sur les Edge Functions Supabase
    - `AsyncStorage` pour les tokens sur mobile

Source GitHub : `https://github.com/medwinrumo/vibe-method/blob/main/securite.md`
