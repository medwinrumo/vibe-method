# Cybersécurité — Recherche approfondie pour la vibe-method

**Date :** mai 2026  
**Périmètre :** apps web/mobile — React, React Native, Expo, Supabase, Convex, Vercel  
**Rôle :** document de base pour la refonte de `securite.md`  

---

## Note de lecture

Ce document est additif par rapport à `securite.md` existant.  
Chaque section est marquée :  
- **[déjà couvert §X.Y]** — la règle existe dans `securite.md`, section indiquée  
- **[à compléter §X.Y]** — la règle est évoquée mais insuffisamment développée  
- **[ajout]** — absent de `securite.md`, à intégrer

---

## Sources primaires consultées

- OWASP Top 10 : 2025 (RC1, version 2025 publiée) — https://owasp.org/Top10/2025/
- OWASP Mobile Top 10 : 2024 — https://owasp.org/www-project-mobile-top-10/
- OWASP API Security Top 10 : 2023 — https://owasp.org/API-Security/editions/2023/en/0x11-t10/
- OWASP Top 10 for LLM Applications : 2025 — https://genai.owasp.org/resource/owasp-top-10-for-llm-applications-2025/
- Pearce et al., "Asleep at the Keyboard?" (2021, publié CACM 2023) — https://arxiv.org/abs/2108.09293
- Apiiro, analyse 40 000+ repos Fortune 50 (déc. 2024 — juin 2025) — https://labs.cloudsecurityalliance.org/research/csa-research-note-ai-generated-code-vulnerability-surge-2026/
- USENIX Security 2025 — analyse 576 000 échantillons de code LLM (hallucinations de packages) — https://arxiv.org/abs/2510.26103
- CSET Georgetown, "Cybersecurity Risks of AI-Generated Code" (nov. 2024) — https://cset.georgetown.edu/wp-content/uploads/CSET-Cybersecurity-Risks-of-AI-Generated-Code.pdf
- Snyk, "The Highs and Lows of Vibe Coding" (2025) — https://snyk.io/articles/the-highs-and-lows-of-vibe-coding/
- Supabase docs : RLS, API keys, Edge Functions, Secure Data — https://supabase.com/docs/
- Convex docs : Auth, Internal Functions, Best Practices — https://docs.convex.dev/
- React Native docs : Security — https://reactnative.dev/docs/security
- OWASP, "Securing React Native Mobile Apps with OWASP MAS" (oct. 2024) — https://owasp.org/blog/2024/10/02/Securing-React-Native-Mobile-Apps-with-OWASP-MAS
- Snyk, rapport Axios supply chain attack (mars 2026) — https://snyk.io/blog/axios-npm-package-compromised-supply-chain-attack-delivers-cross-platform/
- CISA, "Widespread Supply Chain Compromise Impacting npm" (sept. 2025) — https://www.cisa.gov/news-events/alerts/2025/09/23/widespread-supply-chain-compromise-impacting-npm-ecosystem

---

## Partie 1 — Inventaire des failles classiques

### Cadre de référence utilisé

| Référentiel | Version | Scope |
|---|---|---|
| OWASP Top 10 | 2025 (RC1) | Applications web |
| OWASP Mobile Top 10 | 2024 | Applications mobiles |
| OWASP API Security Top 10 | 2023 | APIs REST/GraphQL |
| OWASP Top 10 for LLM | 2025 | IA générative + code généré |

---

### 1.1 Broken Access Control (A01:2025 — #1 web)

**Description**  
Contrôle d'accès défaillant : un utilisateur peut accéder à des ressources ou effectuer des actions au-delà de ses droits. En 2025, c'est le risque #1 — présent dans 3,73 % des applications testées, couvrant 40 CWE distincts.

**Comment un LLM le reproduit**  
L'IA génère des routes d'API sans vérification d'identité ou génère des vérifications uniquement côté client (`if (user.role === 'admin')`). Elle oublie systématiquement de vérifier que l'utilisateur courant est bien propriétaire de la ressource demandée, pas seulement authentifié. Sur Supabase, elle écrit des requêtes sans RLS ou avec des policies trop larges. Sur Convex, elle crée des `query()` et `mutation()` publiques sans appel à `ctx.auth.getUserIdentity()`.

**Impact**  
Lecture, modification ou suppression des données d'autres utilisateurs. Élévation de privilèges (utilisateur → admin). Dans les cas graves : exfiltration complète de la base.

**Protection concrète**  
- Supabase : RLS activé sur chaque table, policies testées avec un utilisateur non-propriétaire, ne jamais exposer la `service_role` key côté client. [déjà couvert §1.2, §2.5]
- Convex : toute `query()` et `mutation()` publique doit vérifier `ctx.auth.getUserIdentity()`. Utiliser des wrappers `authenticatedQuery` / `authenticatedMutation`. Les opérations sensibles passent par `internalMutation`. [ajout — voir Partie 2.2]
- Vérification côté serveur à chaque requête, pas seulement au login. [déjà couvert §2.5]

---

### 1.2 Security Misconfiguration (A02:2025 — passe de #5 à #2)

**Description**  
Configuration de sécurité absente, incomplète ou par défaut. Cette catégorie monte de #5 à #2 en 2025 — signal fort de la prévalence du problème dans les apps modernes.

**Comment un LLM le reproduit**  
Il génère des configurations "qui marchent" : `Access-Control-Allow-Origin: *` pour débloquer CORS, RLS désactivé pour simplifier les requêtes, `verify_jwt: false` sur les Edge Functions Supabase pour tester rapidement, aucun en-tête de sécurité HTTP. Ces configurations de développement restent en production.

**Impact**  
Surface d'attaque ouverte. N'importe quel site peut appeler l'API. Accès non authentifié à des endpoints sensibles.

**Protection concrète**  
- CORS : whitelister uniquement les domaines prod. [déjà couvert §1.11]
- Headers HTTP absents de `securite.md` : configurer CSP, HSTS, X-Frame-Options, X-Content-Type-Options dans `vercel.json` ou le middleware. Vercel ne les ajoute pas automatiquement au niveau application. [ajout — voir Partie 2.3]
- Supabase Edge Functions : `verify_jwt: true` par défaut en prod, jamais `false`. [ajout]
- Checklist de configuration avant chaque déploiement. [ajout — voir Partie 3]

---

### 1.3 Software Supply Chain Failures (A03:2025 — nouveau, remplace "Vulnerable and Outdated Components")

**Description**  
La catégorie s'élargit : elle couvre désormais l'ensemble de la chaîne — dépendances compromises, scripts postinstall malveillants, mainteneurs de packages piratés. Illustration réelle : en mars 2026, le package Axios (100 millions de téléchargements hebdomadaires) a été compromis via le compte npm de son mainteneur. Un script postinstall installait un RAT. En septembre 2025, l'attaque "Shai-hulud" a propagé du code malveillant dans 18 packages populaires (debug, chalk, ansi-styles) via phishing d'un seul mainteneur.

**Comment un LLM le reproduit**  
Il suggère des packages sans vérifier leur état de maintenance, installe des versions potentiellement anciennes ou inconnues. Étude USENIX Security 2025 (576 000 échantillons, 16 LLMs) : environ 20 % des échantillons référençaient des packages inexistants, 43 % de ces noms hallucinés étaient reproduits de façon stable — un attaquant peut créer le package inexistant et attendre que du code généré par IA l'importe.

**Impact**  
Code malveillant exécuté sur les machines des développeurs et en CI/CD. Vol de tokens, de clés API, de credentials. Propagation à travers d'autres packages.

**Protection concrète**  
- `npm audit` après chaque installation. [déjà couvert §2.2]
- `npm ci` (ou `yarn --frozen-lockfile`) en CI — utilise exclusivement le lockfile. [ajout]
- Activer Dependabot (alertes + security updates) sur chaque repo. [ajout]
- `lockfile-lint` : valide que le lockfile ne pointe que vers des registries de confiance. [ajout]
- Vérifier l'existence réelle d'un package avant de l'importer (npm registry, GitHub, date dernière publication). [ajout]
- Ne jamais utiliser `--ignore-scripts` en développement si des packages natifs sont nécessaires, mais l'activer en CI quand possible. [ajout]
- Abonnement aux newsletters sécurité des frameworks (Next.js, Expo, etc.). [déjà couvert §2.2]

---

### 1.4 Cryptographic Failures (A04:2025 — était #2, descend à #4)

**Description**  
Chiffrement absent ou défaillant : données sensibles en clair, algorithmes cassés (MD5, SHA-1), clés insuffisamment protégées, mauvaise gestion des certificats.

**Comment un LLM le reproduit**  
Il stocke des tokens ou données sensibles en `localStorage` (pas chiffré, accessible via XSS), utilise `AsyncStorage` sans chiffrement en React Native, génère des tokens avec des algorithmes faibles, oublie de marquer les cookies comme `HttpOnly` et `Secure`.

**Impact**  
Vol de tokens d'authentification. Lecture de données sensibles par injection XSS. Sur mobile, extraction de données si l'appareil est compromis.

**Protection concrète**  
- Web : stocker les tokens en cookie `HttpOnly; Secure; SameSite=Strict`. [déjà couvert §2.3]
- React Native : remplacer `AsyncStorage` par `expo-secure-store` (Keychain iOS, Keystore Android). Ne jamais stocker tokens, clés ou données personnelles dans AsyncStorage. [ajout]
- Ne jamais MD5 ou SHA-1 pour des signatures ou hachages de mots de passe. Utiliser bcrypt/argon2 (délégué au service d'auth). [déjà couvert implicitement §1.4]
- Chiffrement au repos pour les données sensibles en base. [à compléter §1.6]

---

### 1.5 Injection (A05:2025 — confirmé)

**Description**  
Injection SQL, NoSQL, de commandes OS, LDAP. L'IA génère régulièrement du SQL brut en concaténant des valeurs utilisateur.

**Comment un LLM le reproduit**  
Côté Supabase Edge Function ou backend Node.js, l'IA génère du SQL brut avec interpolation de chaînes :
```javascript
// Edge Function Node.js — DANGEREUX
const result = await db.query(
  `SELECT * FROM users WHERE name = '${req.body.name}'`
)
```
Côté Supabase, l'IA écrit des fonctions PostgreSQL avec `EXECUTE format(...)` non paramétré :
```sql
-- Fonction PostgreSQL générée par l'IA — DANGEREUX
CREATE FUNCTION search_users(search_term TEXT) RETURNS SETOF users AS $$
BEGIN
  EXECUTE format('SELECT * FROM users WHERE name LIKE ''%%%s%%''', search_term);
END;
$$ LANGUAGE plpgsql;
```
L'IA utilise des template literals ou `format()` non paramétré plutôt que des paramètres positionnels (`$1`, `$2`).

**Impact**  
Extraction complète de la base de données. Dans les cas d'injection de commandes : exécution de code arbitraire sur le serveur.

**Protection concrète**  
- Toujours utiliser le client Supabase ou un ORM — jamais de SQL brut avec données utilisateur. [déjà couvert §2.5]
- Supabase : utiliser `.select()`, `.eq()`, `.rpc()` avec des paramètres — jamais de string interpolation dans du SQL. [déjà couvert §2.5]
- Relire tout SQL généré par l'IA avant exécution. [déjà couvert §2.5]

---

### 1.6 Authentication Failures (A07:2025 / API2:2023)

**Description**  
Authentification défaillante côté serveur. L'application vérifie l'identité uniquement côté client (trust du JWT sans vérification serveur), accepte des tokens expirés, ne gère pas l'invalidation.

**Comment un LLM le reproduit**  
Il génère des guards React (`if (!user) return <Redirect />`) sans jamais vérifier le JWT côté serveur. Il expose des endpoints API sans middleware d'authentification. Il laisse des tokens sans expiration. **Ce point est insuffisamment couvert dans `securite.md` — voir Partie 2.1.**

**Impact**  
Accès non authentifié à toute l'API en contournant le front-end. Sessions qui ne s'invalident pas au logout.

**Protection concrète**  
- Voir Partie 2.1 — développement complet. [à compléter]

---

### 1.7 SSRF — Server-Side Request Forgery (API7:2023 / absorbé dans A01:2025)

**Description**  
L'application effectue des requêtes HTTP côté serveur avec une URL contrôlée par l'utilisateur. L'attaquant peut cibler des services internes non exposés publiquement (métadonnées cloud AWS/GCP, services internes, services de fichiers).

**Comment un LLM le reproduit**  
Dans les apps React + backend Node.js ou Supabase Edge Functions, l'IA génère des proxies d'URL simples :
```javascript
// Edge Function — DANGEREUX si url vient de l'utilisateur
const response = await fetch(req.body.url)
```
L'IA ne valide pas que l'URL cible est autorisée.

**Impact**  
Accès aux métadonnées cloud (tokens IAM), lecture de services internes, exfiltration de données.

**Protection concrète**  
- Toujours valider les URLs fournies par l'utilisateur contre une whitelist de domaines autorisés. [ajout]
- Bloquer les plages d'IP privées (10.x.x.x, 172.16.x.x, 192.168.x.x) et les adresses loopback (127.0.0.1, localhost). [ajout]
- Sur Vercel/Supabase : les Edge Functions n'ont pas accès aux métadonnées cloud internes, ce qui réduit l'impact — mais reste un vecteur pour des attaques latérales. [ajout]

---

### 1.8 XSS — Cross-Site Scripting

**Description**  
Injection de code JavaScript dans une page via des entrées utilisateur non échappées. React échappe par défaut les valeurs JSX, mais l'IA utilise régulièrement `dangerouslySetInnerHTML`.

**Comment un LLM le reproduit**  
```jsx
// Généré typiquement pour afficher du HTML "riche" — DANGEREUX
<div dangerouslySetInnerHTML={{ __html: userContent }} />
```
L'IA utilise `dangerouslySetInnerHTML` sans sanitisation pour afficher du contenu formaté.

**Impact**  
Vol de tokens (si stockés en localStorage). Redirection vers des sites malveillants. Actions effectuées à la place de l'utilisateur.

**Protection concrète**  
- Ne jamais utiliser `dangerouslySetInnerHTML` sans passer par `DOMPurify` ou `sanitize-html`. [ajout explicite — securite.md couvre XSS généralement mais pas ce cas React spécifique]
- Configurer une CSP stricte qui bloque les scripts inline. [ajout — voir Partie 2.3]
- Stocker les tokens en cookie HttpOnly (non accessible au JS). [déjà couvert §2.3]

---

### 1.9 CSRF — Cross-Site Request Forgery

**Description**  
Un site malveillant force un utilisateur connecté à effectuer une action à son insu en exploitant ses cookies de session.

**Comment un LLM le reproduit**  
Il n'implémente pas de protection CSRF car il utilise souvent des tokens JWT dans des headers (naturellement protégés) mais oublie de configurer `SameSite` sur les cookies.

**Impact**  
Changement d'email, de mot de passe, ou suppression de données à l'insu de l'utilisateur.

**Protection concrète**  
- Cookies : `SameSite=Strict` ou `SameSite=Lax`. [déjà couvert §4]
- Supabase Auth gère la protection CSRF pour ses propres endpoints. [ajout]
- Pour les formulaires custom : tokens CSRF dans les headers. [déjà couvert §4]

---

### 1.10 Improper Credential Usage — Mobile (M1:2024 OWASP Mobile)

**Description**  
Credentials stockés de façon non sécurisée sur mobile : tokens en clair dans `AsyncStorage`, clés API hardcodées dans le code source du bundle JavaScript. Rang #1 du OWASP Mobile Top 10 2024.

**Comment un LLM le reproduit**  
```javascript
// Généré typiquement — DANGEREUX
import AsyncStorage from '@react-native-async-storage/async-storage'
await AsyncStorage.setItem('auth_token', token)

// Encore plus dangereux — clé en dur
const SUPABASE_SERVICE_KEY = 'eyJhbGciOiJIUzI1...' // dans le code
```
Le bundle JS Expo/React Native est entièrement lisible par décompilation. Tout ce qui est dans le code ou dans `AsyncStorage` est extractible.

**Impact**  
Extraction du token d'authentification ou de la clé API par reverse engineering. Accès complet au compte de l'utilisateur ou à la base de données.

**Protection concrète**  
- Remplacer `AsyncStorage` par `expo-secure-store` pour tout ce qui est sensible. [ajout]
- Jamais de clé privée dans le code React Native — même dans les variables d'environnement compilées (elles finissent dans le bundle). [ajout]
- Utiliser PKCE pour les flux OAuth mobiles — élimine le besoin d'un `client_secret` fixe. [ajout]

---

### 1.11 Inadequate Privacy Controls / Insecure Data Storage — Mobile (M6:2024 + M9:2024)

**Description**  
Données personnelles ou sensibles stockées en clair sur l'appareil ou transmises sans chiffrement suffisant.

**Comment un LLM le reproduit**  
Il génère des logs qui incluent des données personnelles (`console.log('User data:', user)`), stocke des préférences sensibles sans chiffrement, ne configure pas les permissions d'accès au stockage de façon restrictive.

**Protection concrète**  
- Sur iOS : utiliser le Keychain pour les credentials, et les GroupContainers avec chiffrement pour les données utilisateur. [ajout]
- Ne jamais logguer de données personnelles, même en debug. [à compléter §1.12]
- Désactiver les backups iCloud/Google pour les données sensibles via les flags de stockage appropriés. [ajout]

---

### 1.12 Deep Link Hijacking — Mobile (M3:2024 Insecure Authentication/Authorization)

**Description**  
Une app malveillante enregistre le même scheme de deep link que l'app légitime et capture les tokens ou paramètres transmis via deep link.

**Comment un LLM le reproduit**  
Il génère des deep links du type `myapp://callback?token=xxx` pour les flows OAuth mobiles, sans utiliser les Universal Links (iOS) ou App Links (Android).

**Impact**  
Vol du token OAuth. Compromission complète du compte utilisateur.

**Protection concrète**  
- Utiliser Universal Links (iOS) et App Links (Android) — liés au domaine HTTPS, non interceptables par d'autres apps. [ajout]
- Ne jamais transmettre de token dans les paramètres d'URL d'un deep link. [ajout]
- Expo : configurer `scheme` + `intentFilters` avec `autoVerify: true` pour les App Links Android. [ajout]

---

### 1.13 Broken Object Level Authorization (API1:2023)

**Description**  
Variante API d'IDOR : l'API retourne des objets sans vérifier que l'utilisateur courant y a accès. API1:2023 — rang #1 de l'OWASP API Security 2023.

**Comment un LLM le reproduit**  
```javascript
// Route Express générée par l'IA — DANGEREUX
app.get('/api/orders/:id', async (req, res) => {
  const order = await db.orders.findById(req.params.id) // Pas de vérif ownership
  res.json(order)
})
```

**Protection concrète**  
- Toujours filtrer par `user_id` en plus de l'ID de ressource. [déjà couvert §2.5, §1.2]
- RLS Supabase comme filet de sécurité supplémentaire. [déjà couvert §1.2]

---

### 1.14 Broken Object Property Level Authorization / Mass Assignment (API3:2023)

**Description**  
L'API expose ou accepte des propriétés qu'un utilisateur ne devrait pas voir ou modifier. Cas classique : `mass assignment` — l'utilisateur envoie `{"role": "admin"}` dans son profil et l'app l'accepte.

**Comment un LLM le reproduit**  
```javascript
// Généré typiquement — DANGEREUX
const updatedUser = await supabase
  .from('users')
  .update(req.body) // Accepte tout ce que l'utilisateur envoie
  .eq('id', userId)
```
L'IA passe `req.body` directement à la mise à jour sans filtrer les champs autorisés.

**Impact**  
Élévation de privilèges : un utilisateur peut s'auto-promouvoir admin. Modification de champs sensibles (email d'un autre, solde de compte).

**Protection concrète**  
- Toujours whitelister les champs acceptés en update : ne jamais passer `req.body` directement. [ajout]
- Supabase : RLS policies spécifiques par type d'opération (SELECT ≠ UPDATE ≠ INSERT). [ajout]
- Convex : valider les arguments avec `v.object({ field: v.string() })` — ne jamais accepter un objet libre. [ajout]

---

### 1.15 Unrestricted Resource Consumption (API4:2023 — confirmé)

**Description**  
Absence de rate limiting et de quotas : l'API peut être épuisée par des requêtes massives ou des paiements automatisés excessifs.

**Comment un LLM le reproduit**  
Il n'implémente pas de rate limiting par défaut. Il ne place pas de limites sur les tailles de payload.

**Protection concrète**  
- Rate limiting par endpoint. [déjà couvert §2.6]
- Limiter la taille des payloads (body-parser limits en Express). [ajout]
- Quotas sur les appels aux APIs externes (OpenAI, etc.) avec alertes de coût. [ajout]

---

### 1.16 Prototype Pollution (JavaScript-specific)

**Description**  
Manipulation du prototype global d'un objet JavaScript via des données utilisateur (`__proto__`, `constructor`, `prototype`). Peut mener à une exécution de code arbitraire côté serveur. CVE-2024-51999 dans Express (sévérité 6.9).

**Comment un LLM le reproduit**  
Il merge des objets utilisateur sans protection : `Object.assign({}, req.body)`. L'IA ne pense pas à ce vecteur.

**Impact**  
Modification du comportement de toute l'application (ex: transformer un `false` en `true` pour des vérifications de droits). Potentiellement RCE.

**Protection concrète**  
- Utiliser des parsers de JSON avec protection contre la pollution de prototype. [ajout]
- Remplacer `Object.assign` par `JSON.parse(JSON.stringify(...))` ou une librairie comme `lodash.merge` patchée. [ajout]
- `npm audit` détecte les CVE connus sur les dépendances vulnérables. [déjà couvert §2.2]

---

## Partie 2 — Ce qui manque dans securite.md

### 2.1 Auth côté serveur obligatoire

**Problème actuel dans securite.md**  
La section §2.3 mentionne "Vérifier l'authentification avant d'afficher les données" — mais c'est une règle front-end. La section §2.5 mentionne "Authentification ≠ Autorisation" sans décrire le pattern serveur concret.

**Ce que l'IA génère par défaut (et pourquoi c'est faux)**

Le pattern le plus courant généré par les LLMs pour "protéger" une route :
```jsx
// React — guard côté client
function ProtectedPage() {
  const { user } = useAuth()
  if (!user) return <Navigate to="/login" />
  return <SensitivePage />
}
```
Ce code protège l'affichage visuel — pas les données. Un attaquant n'a pas besoin de l'interface React. Il appelle directement l'API avec `curl` ou `fetch`. Si l'API ne vérifie pas le token, les données sont exposées.

**Pattern correct pour Supabase**

```javascript
// Edge Function ou RLS — vérification côté serveur
// Option 1 : RLS (automatique sur chaque requête)
CREATE POLICY "user_owns_resource" ON orders
FOR SELECT USING (auth.uid() = user_id);

// Option 2 : Edge Function — vérification du JWT
export default async function handler(req: Request) {
  const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
    global: { headers: { Authorization: req.headers.get('Authorization') ?? '' } }
  })
  const { data: { user }, error } = await supabase.auth.getUser()
  if (!user || error) return new Response('Unauthorized', { status: 401 })
  // Suite du traitement...
}
```

La méthode `supabase.auth.getUser()` valide le JWT en appelant le serveur Supabase — ce n'est pas une vérification locale du token (qui serait falsifiable). C'est la seule méthode sûre.

**Pattern correct pour Convex**

```javascript
// Toute fonction publique qui touche des données utilisateur
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

**Règle à ajouter dans securite.md**  
> Toute route API et toute fonction serveur qui retourne ou modifie des données doit vérifier l'identité côté serveur, indépendamment de ce que le front-end affiche. La vérification client (guards React, redirections) n'est pas une mesure de sécurité — c'est une mesure UX.

---

### 2.2 Principe du moindre privilège pour la base de données

**Problème actuel dans securite.md**  
§1.5 mentionne le "principe du moindre privilège" pour les rôles utilisateurs. Rien sur la granularité des accès à la base de données elle-même.

**Supabase — 4 niveaux à maîtriser**

**Niveau 1 : anon key vs service_role key**

| Clé | Rôle | Bypass RLS | Où l'utiliser |
|---|---|---|---|
| `anon` key | Utilisateurs non authentifiés | Non | Client-side, public |
| `service_role` key | Admin système | Oui — bypass total | Back-end uniquement, jamais dans le bundle |

L'IA génère souvent du code côté client qui initialise Supabase avec la `service_role` key "pour que ça marche" pendant le développement. Cette clé bypass le RLS et donne accès complet à toute la base.

**Niveau 2 : Granularité des policies RLS par opération**

Une policy SELECT ≠ UPDATE ≠ INSERT ≠ DELETE. L'IA génère souvent `USING (auth.uid() = user_id)` pour tout — ce qui est insuffisant.

```sql
-- Insuffisant (généré par l'IA)
CREATE POLICY "users_own_data" ON orders USING (auth.uid() = user_id);

-- Correct : politiques distinctes par opération
CREATE POLICY "select_own_orders" ON orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert_own_orders" ON orders FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update_own_orders" ON orders FOR UPDATE USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id AND status != 'completed'); -- empêche de modifier une commande terminée
-- Pas de DELETE policy = pas de DELETE pour les utilisateurs
```

**Niveau 3 : Grants PostgreSQL**

Au-delà du RLS, Supabase utilise les rôles PostgreSQL `anon` et `authenticated`. Si une table n'a pas de grant, le RLS ne peut pas s'appliquer. Règle : n'accorder que les privileges nécessaires.

```sql
-- Exemple : table orders — lecture et insertion pour les authentifiés, rien pour anon
GRANT SELECT, INSERT ON orders TO authenticated;
REVOKE ALL ON orders FROM anon;
```

**Niveau 4 : user_metadata vs app_metadata**

`user_metadata` est modifiable par l'utilisateur lui-même. `app_metadata` ne l'est pas (backend uniquement). Les LLMs stockent souvent les rôles dans `user_metadata` — un utilisateur peut alors s'auto-promouvoir.

```javascript
// DANGEREUX — l'utilisateur peut modifier user_metadata
CREATE POLICY "admin_only" ON sensitive_table
USING (auth.jwt() -> 'user_metadata' ->> 'role' = 'admin');

// CORRECT — app_metadata n'est pas modifiable par l'utilisateur
CREATE POLICY "admin_only" ON sensitive_table
USING (auth.jwt() -> 'app_metadata' ->> 'role' = 'admin');
```

**Convex — 3 niveaux à maîtriser**

**Niveau 1 : public vs internal**

```javascript
// Accessible depuis le client — doit vérifier l'auth
export const createOrder = mutation({ ... })

// Accessible uniquement depuis d'autres fonctions Convex — jamais depuis le client
export const processPayment = internalMutation({ ... })
```

**Niveau 2 : Audit systématique**  
Chercher toutes les occurrences de `query(`, `mutation(`, `action(`, `httpAction(` dans le codebase et vérifier que chacune vérifie `ctx.auth.getUserIdentity()`.

**Niveau 3 : Validation des arguments**  
Convex utilise des validateurs typés. Toujours définir le schéma exact des arguments — ne jamais accepter `v.any()` pour des mutations qui modifient la base.

```javascript
// DANGEREUX
export const updateUser = mutation({
  args: { updates: v.any() }, // Accepte tout
  handler: async (ctx, { updates }) => { ... }
})

// CORRECT
export const updateUser = mutation({
  args: {
    displayName: v.optional(v.string()),
    avatar: v.optional(v.string()),
    // role: absent — un utilisateur ne peut pas changer son rôle
  },
  handler: async (ctx, args) => { ... }
})
```

---

### 2.3 En-têtes de sécurité HTTP (Security Headers) — absent de securite.md

**Contexte**  
Vercel gère HTTPS automatiquement (HSTS au niveau infrastructure) mais ne configure pas les en-têtes de sécurité HTTP au niveau application. Un déploiement Vercel sans configuration additionnelle est signalé comme "insecure headers" par les scanners de sécurité.

Source : https://vibeappscanner.com/security-issue/vercel-insecure-headers

**Configuration dans `vercel.json`**

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

**Content Security Policy (CSP)**  
La CSP est plus complexe — elle définit les sources autorisées pour scripts, styles, images, fonts, etc. Une CSP mal configurée casse l'app. Protocole recommandé :

1. Démarrer en mode rapport : `Content-Security-Policy-Report-Only`
2. Analyser les violations sans bloquer
3. Passer en mode enforcement une fois la politique stable
4. Interdire `unsafe-inline` et `unsafe-eval` sauf nécessité justifiée

```json
{
  "key": "Content-Security-Policy",
  "value": "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self' https://*.supabase.co https://*.convex.cloud; frame-ancestors 'none'"
}
```

Note : `'unsafe-inline'` est conservé pour `style-src` dans cet exemple car Tailwind CSS et la plupart des librairies CSS-in-JS en React en ont besoin. C'est un compromis explicite et documenté. Pour les scripts (`script-src`), `unsafe-inline` ne doit jamais être autorisé — un attaquant pourrait injecter des scripts arbitraires.

**Règle à ajouter dans securite.md**  
> Les en-têtes de sécurité HTTP (`X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy`, CSP) doivent être configurés dans `vercel.json` ou le middleware. Vercel ne les ajoute pas automatiquement au niveau application.

---

### 2.4 Sécurité des webhooks — absent de securite.md

**Contexte**  
Les apps vibe-method intègrent des services tiers (Stripe pour les paiements, Supabase pour les events DB, services d'emailing, etc.) via des webhooks. Un endpoint webhook sans vérification de signature est un vecteur d'attaque direct.

**Le problème**  
L'IA génère des endpoints webhook qui acceptent n'importe quelle requête POST sans vérifier que la requête vient bien du service légitime.

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

**Points critiques non-évidents**  
1. Le corps doit être lu en RAW — si le framework parse le JSON d'abord, la sérialisation peut différer et invalider la signature.
2. Stripe inclut un timestamp dans la signature — à valider pour prévenir les attaques par replay.
3. Utiliser `timingSafeEqual` pour la comparaison — évite les attaques par timing side channel.

**Règle à ajouter dans securite.md**  
> Tout endpoint webhook doit vérifier la signature HMAC fournie par le service émetteur. Lire le corps en raw bytes avant tout parsing. Ne jamais accepter un webhook sans vérification de signature.

---

### 2.5 Stockage sécurisé sur mobile (React Native / Expo) — absent de securite.md

**Ce qu'il faut bannir**

| Stockage | Statut | Raison |
|---|---|---|
| `AsyncStorage` pour credentials | Interdit | Non chiffré, accessible par root/jailbreak |
| Variables d'env compilées dans le bundle | Interdit | Lisibles par décompilation du JS |
| Clés hardcodées | Interdit | Extraction triviale |
| `SecureStore` Expo | Recommandé | Keychain iOS, Keystore Android |
| Mémoire (state React) | Acceptable | Disparaît à la fermeture, jamais persisté |

**Règle à ajouter dans securite.md**  
> Sur React Native / Expo : `AsyncStorage` est non chiffré. Toute donnée sensible (token, clé API, donnée personnelle) doit passer par `expo-secure-store`. Aucune clé privée ne doit exister dans le code source React Native — elle sera visible par décompilation du bundle JS.

---

### 2.6 Mass Assignment — absent de securite.md

**Règle à ajouter**  
Toujours whitelister les champs acceptés dans les mutations / updates — ne jamais passer `req.body` ou l'objet utilisateur directement. Documenter dans `securite.md` §2.5 comme règle de code obligatoire.

---

### 2.7 Hallucinations de packages LLM — absent de securite.md

**Données**  
Étude USENIX Security 2025 (576 000 échantillons, 16 LLMs) : ~20 % des échantillons référencent des packages inexistants. 43 % de ces noms sont stables — un attaquant peut créer le package et attendre.

**Règle à ajouter**  
> Avant d'installer un package suggéré par l'IA, vérifier son existence sur npm (npmjs.com), son nombre de téléchargements, sa date de dernière publication, et son mainteneur. Un package avec 0 téléchargements ou créé très récemment est suspect.

---

## Partie 3 — Stratégie cybersécurité par projet

### 3.1 Principe général

La sécurité n'est pas une phase — c'est une contrainte transversale. Elle s'intègre à chaque phase du workflow vibe-method avec un livrable spécifique et une question obligatoire à poser.

---

### 3.2 Phase par phase

#### Phase /brief

**Question obligatoire :** "Quelles données sensibles l'app manipule-t-elle ?" (données personnelles, financières, médicales, contenu d'entreprise)

**Décision à prendre :** niveau de risque du projet (bas / moyen / élevé). Ce niveau détermine l'intensité des mesures de sécurité requises.

| Niveau | Critères | Exemples |
|---|---|---|
| Bas | Pas de données personnelles, pas de paiement, app publique | Site vitrine, portfolio |
| Moyen | Comptes utilisateurs, données personnelles standard | App de notes, SaaS |
| Élevé | Paiements, données de santé, données d'entreprise confidentielles | Fintech, santé, B2B |

**Livrable :** mention du niveau de risque dans `[projet].brief.md`.

---

#### Phase /archi

**C'est la phase la plus critique pour la sécurité.** Les décisions d'architecture sont les plus coûteuses à changer.

**Questions obligatoires :**
1. Quel service d'auth ? (Supabase Auth, Clerk, Auth0, Firebase Auth — jamais fait maison)
2. Les accès multi-rôles sont-ils nécessaires ? (Si oui : schéma de rôles dès maintenant)
3. L'app est-elle multi-tenant ? (Si oui : `organization_id` sur chaque table dès le schéma)
4. Y a-t-il des webhooks entrants ? (Si oui : stratégie de vérification de signature)
5. Y a-t-il des appels à des URLs fournies par l'utilisateur ? (Si oui : whitelist de domaines)

**Livrable sécu dans `[projet].archi.md` :**
- Schéma des rôles et permissions
- Liste des tables avec leur niveau RLS requis
- Liste des endpoints publics vs authentifiés
- Décision : `service_role` key — où et comment protégée

**Qui fait quoi :**
- IA : propose le schéma de roles, génère les politiques RLS de base
- Développeur : valide que les policies couvrent tous les cas d'accès, teste avec un utilisateur non-propriétaire

---

#### Phase /stack

**Questions sécu à ajouter au spike technique :**
- Est-ce que le service a des free-tier limits qui peuvent être épuisées par une attaque ? (rate limiting natif ?)
- Quel est le comportement à saturation ? (crash dur ou dégradation douce) [déjà couvert §2bis]
- Le service supporte-t-il les security headers nécessaires ?
- Y a-t-il un historique de CVE sur les dépendances principales ?

**Livrable :** section "Risques sécu" dans `[projet].stack.md`.

---

#### Phase /specs

**Pour chaque user story, ajouter :**
- Qui peut effectuer cette action ? (rôle requis)
- Quelles données sont exposées ? (minimisation)
- Y a-t-il une validation des entrées à spécifier ?

**Livrable :** contraintes sécu par user story dans `[projet].spec.[feature].md`.

---

#### Phase [code]

**IA — checklist à appliquer à chaque feature :**
- [ ] Vérification auth côté serveur (pas seulement guard React)
- [ ] RLS activé sur les nouvelles tables
- [ ] Aucun `SELECT *` sur des tables sensibles
- [ ] Entrées utilisateur validées côté serveur
- [ ] Aucune clé privée dans le code front-end ou le bundle mobile
- [ ] Pas de `dangerouslySetInnerHTML` sans DOMPurify
- [ ] Pas de `req.body` passé directement à un update DB
- [ ] Packages nouveaux vérifiés sur npm avant installation

**Outil automatique : Semgrep**  
Semgrep (gratuit pour les projets open source, règles communautaires disponibles pour React/Node) détecte statiquement les patterns dangereux : `dangerouslySetInnerHTML`, SQL brut avec interpolation, secrets dans le code. À intégrer dans la CI dès le setup.

```bash
# Installation
npm install -g semgrep

# Scan avec règles de sécurité React
semgrep --config "p/react" --config "p/nodejs" --config "p/secrets" .
```

**Outil automatique : Snyk**  
Snyk scanne les dépendances (SCA) et détecte les CVE. Complémentaire à Semgrep qui fait du SAST (analyse du code).

```bash
npm install -g snyk
snyk test         # Scan des dépendances
snyk monitor      # Surveillance continue
```

**Référence benchmark :** Snyk Code : 97 % de taux de vrais positifs (OWASP Benchmark). Semgrep : 87 %. Combinés : couverture complémentaire.

---

#### Phase /code-review

**Questions de sécurité à ajouter à la checklist de revue :**
- Est-ce que chaque endpoint API vérifie l'auth côté serveur ?
- Est-ce que les nouvelles tables ont des policies RLS distinctes par opération ?
- Est-ce que les mutations whitelistent les champs acceptés ?
- Les en-têtes de sécurité sont-ils configurés dans `vercel.json` ?
- Y a-t-il des packages nouvellement installés ? → vérifier sur npm
- Y a-t-il du `dangerouslySetInnerHTML` ? → vérifier la sanitisation

---

#### Phase /recette (avant mise en production)

**Audit de sécurité léger obligatoire — niveau de risque bas/moyen**

Utiliser un scanner automatique en ligne :
- **OWASP ZAP** (gratuit, open source) — scan DAST de l'app en ligne
- **Mozilla Observatory** (gratuit) — scan des en-têtes de sécurité HTTP
- **securityheaders.com** (gratuit) — vérifie CSP, HSTS, X-Frame-Options

```bash
# Mozilla Observatory CLI
npx observatory --format report https://monapp.vercel.app
```

**Si niveau de risque élevé :** envisager un pentest manuel ou faire appel à un service de bug bounty (HackerOne, YesWeHack) avant le lancement.

**Livrable :** rapport de scan dans `[projet].recette.md` (section Sécurité).

---

#### Phase /deploy (mise en production)

**Checklist sécu supplémentaire avant go-live :**
- [ ] `vercel.json` contient les security headers
- [ ] CSP configurée et testée en mode report d'abord
- [ ] Clés de production différentes des clés de développement (rotation)
- [ ] `service_role` key Supabase absente de tout repo Git (y compris les configs CI)
- [ ] Variables d'environnement de prod dans Vercel Dashboard — pas dans `.env` commité
- [ ] Dependabot activé sur le repo GitHub
- [ ] Monitoring d'erreurs configuré (Sentry ou équivalent)

---

### 3.3 Qui fait quoi — IA vs développeur

| Responsabilité | IA | Développeur |
|---|---|---|
| Générer les policies RLS | Oui — à la demande | Valide, teste avec un utilisateur non-propriétaire |
| Configurer les security headers | Oui — template standard | Adapte la CSP à l'app spécifique |
| Implémenter la validation des entrées | Oui | Vérifie que tous les champs sont couverts |
| Décider du niveau de risque du projet | Non | Oui — c'est une décision métier |
| Valider les policies RLS multi-rôles complexes | Non seul — risque d'erreur | Teste chaque rôle manuellement |
| Scanner les dépendances (Snyk) | Déclenche le scan | Analyse les résultats, décide des mises à jour |
| Audit de sécurité final (DAST) | Déclenche le scan | Interprète les résultats, priorise les corrections |

---

### 3.4 Outils recommandés par phase

| Phase | Outil | Coût | Ce qu'il détecte |
|---|---|---|---|
| Code | Semgrep | Gratuit (OSS) | Patterns dangereux dans le code (SAST) |
| Code | Snyk | Gratuit (free tier : ~200 tests/mois open source) | CVE dans les dépendances (SCA) |
| Code | Dependabot | Gratuit (GitHub) | Mises à jour de sécurité automatiques |
| Code | `npm audit` | Gratuit | CVE connus dans node_modules |
| Recette | Mozilla Observatory | Gratuit | En-têtes HTTP, TLS, CSP |
| Recette | securityheaders.com | Gratuit | En-têtes de sécurité |
| Recette | OWASP ZAP | Gratuit | Scan DAST (failles runtime) |
| Deploy | Vercel Security Headers | Inclus | Config `vercel.json` |
| Continu | Snyk Monitor | Gratuit (dev) | Surveillance continue des CVE |

---

### 3.5 Critères pour un audit de sécurité externe

Aller au-delà des outils automatiques et faire appel à un professionnel ou un service bug bounty si l'app remplit au moins un de ces critères :

- Traitement de paiements (données financières)
- Données de santé
- Plus de 1 000 utilisateurs avec données personnelles (seuil RGPD significatif)
- Données d'entreprise confidentielles (B2B)
- App avec des fonctionnalités admin exposées sur internet

**Services accessibles pour un développeur solo :**
- HackerOne : bug bounty public ou privé
- YesWeHack : alternative européenne, programmes à partir de 5 000 €
- Cobalt.io : pentest-as-a-service
- Synack : plateforme enterprise

---

## Résumé des ajouts prioritaires à securite.md

### Urgents (failles à fort impact, absentes ou insuffisantes)

1. **Auth côté serveur** — pattern `supabase.auth.getUser()` / `ctx.auth.getUserIdentity()` obligatoire sur chaque endpoint. [Partie 2.1]
2. **anon key vs service_role key** — règle absolue : service_role jamais dans le bundle. [Partie 2.2]
3. **RLS par opération** — policies SELECT / INSERT / UPDATE / DELETE distinctes. [Partie 2.2]
4. **app_metadata vs user_metadata** — rôles toujours dans app_metadata. [Partie 2.2]
5. **Stockage mobile** — `expo-secure-store` obligatoire, `AsyncStorage` interdit pour credentials. [Partie 2.5]
6. **Mass assignment** — whitelist des champs en update, jamais req.body direct. [Partie 1.14 + 2.6]
7. **Deep link hijacking** — Universal Links / App Links, jamais de tokens dans les URLs deep link. [Partie 1.12]

### Importants (manquants mais moins critiques pour les premiers projets)

8. **Security headers HTTP** — `vercel.json` avec X-Frame-Options, CSP, etc. [Partie 2.3]
9. **Webhooks** — vérification HMAC-SHA256, corps raw, constant-time comparison. [Partie 2.4]
10. **Supply chain** — Dependabot + lockfile-lint + `npm ci` en CI + vérification des packages hallucinés. [Partie 1.3]
11. **SSRF** — whitelist d'URLs, blocage des IPs privées. [Partie 1.7]
12. **Prototype pollution** — ne pas merger des objets utilisateur sans protection. [Partie 1.16]
13. **Semgrep + Snyk** — outils automatiques intégrés à la CI dès le /setup. [Partie 3.2]

### À enrichir (déjà évoqués mais insuffisants)

14. **§1.6 Données sensibles** — à développer avec le tableau de stockage mobile. [Partie 1.4]
15. **§3.1 Checklist de fin de feature** — étendre avec les items mass assignment, dangerouslySetInnerHTML, webhooks. [Partie 3.2]
