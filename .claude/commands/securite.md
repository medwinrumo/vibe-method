---
description: /securite — Analyse sécurité du PRD ou vérification sécurité d'une feature
allowed-tools: WebSearch, Read, Glob, Grep
---

Skill en trois modes distincts. Doctrine de référence : `securite.md`.

---

## Mode `analyse` — `/securite analyse`

**Quand :** après `/prd`, avant `/archi`.

**Rôle :** lire le PRD du projet et identifier les enjeux de sécurité spécifiques à CE projet. Pas une checklist générique — une analyse ciblée qui alimente `/archi`.

### Étape 1 — Lecture du PRD

Lire `[projet].prd.md`. Si absent, demander à Medwin de le fournir.

### Étape 2 — Analyse des enjeux sécurité

Pour chaque dimension, répondre OUI / NON / À PRÉCISER selon le PRD :

**Données**
- Y a-t-il des données personnelles (nom, email, adresse, téléphone) ?
- Y a-t-il des données sensibles (santé, paiement, mots de passe, documents) ?
- Y a-t-il des données d'entreprise confidentielles ?

**Utilisateurs et rôles**
- Y a-t-il plusieurs types d'utilisateurs (admin, utilisateur, viewer...) ?
- Y a-t-il un espace multi-tenant (plusieurs organisations dans la même app) ?
- Y a-t-il des actions réservées à certains rôles seulement ?

**Exposition**
- L'app est-elle publique (accessible sans connexion) ?
- Y a-t-il des APIs tierces avec des clés secrètes ?
- Y a-t-il du paiement en ligne ?
- Y a-t-il du temps réel (WebSockets, subscriptions) ?
- Y a-t-il des webhooks entrants (Stripe, services tiers...) ?
- L'app fait-elle des requêtes HTTP côté serveur vers des URLs fournies par l'utilisateur ?

**Mobile**
- L'app est-elle React Native / Expo ?
- Y a-t-il des flux OAuth sur mobile (deep links) ?
- Des données sensibles sont-elles stockées localement sur l'appareil ?

**Conformité**
- L'app cible-t-elle des utilisateurs en Europe → RGPD applicable ?
- Y a-t-il des données soumises à une réglementation spécifique (santé, finance) ?

### Étape 3 — Détermination du niveau de risque

À partir des réponses de l'étape 2, déterminer le niveau de risque du projet :

| Niveau | Critères |
|---|---|
| Bas | Pas de données personnelles, pas de paiement, app publique |
| Moyen | Comptes utilisateurs, données personnelles standard |
| Élevé | Paiements, données de santé, données d'entreprise confidentielles |

### Étape 4 — Production du rapport de sécurité

Produire une liste courte et priorisée des points de sécurité à intégrer dans `/archi` :

> "**Points de sécurité identifiés pour [projet] :**
>
> **Niveau de risque : [Bas / Moyen / Élevé]**
>
> **Bloquants (à décider avant l'architecture) :**
> - [point 1 — pourquoi c'est bloquant]
> - [point 2]
>
> **Importants (à intégrer pendant le code) :**
> - [point 3]
> - [point 4]
>
> **À surveiller (vérification en Phase 7) :**
> - [point 5]
>
> Ces points sont transmis à `/archi` pour intégration dans les décisions d'architecture."

**Mise à jour CLAUDE.md** — upsert de la section `## Sécurité projet` :
- Section existante → remplacer intégralement
- Section absente → ajouter en fin de fichier

```markdown
## Sécurité projet
_→ Détails : `securite.md` · `[projet].archi.md §Sécurité`_

Niveau : [Bas / Moyen / Élevé]
Bloquants : [point 1] · [point 2]
Importants : [point 3] · [point 4]
```

---

## Mode `check` — `/securite check`

**Quand :** automatiquement après chaque feature développée, avant le merge dans `main`. S'insère entre `/tests` (Playwright) et la validation manuelle de Medwin.

**Rôle :** vérifier que la feature respecte les règles de `securite.md`. Bloquant si un point échoue — pas de merge tant que ce n'est pas résolu.

### Étape 1 — Lecture du contexte

Lire :
- Le code de la feature (module ciblé)
- `CLAUDE.md` du projet (architecture, modules, conventions)
- Le rapport d'analyse sécurité produit par `/securite analyse` si disponible

### Étape 2 — Vérification par catégorie

**Données et accès**
- [ ] Les données retournées sont-elles filtrées par utilisateur ?
- [ ] Le RLS est-il activé sur les tables concernées ?
- [ ] Les policies RLS sont-elles définies par opération (SELECT/INSERT/UPDATE/DELETE séparés) ?
- [ ] Les vérifications d'autorisation sont-elles faites côté serveur (pas seulement guard React) ?
- [ ] Les IDs utilisés sont-ils des UUIDs (pas des IDs séquentiels) ?

**Auth côté serveur**
- [ ] Chaque route API vérifie-t-elle l'identité côté serveur (`supabase.auth.getUser()` ou `ctx.auth.getUserIdentity()`) ?
- [ ] Aucun guard React ne remplace une vérification API ?

**Mutations et entrées**
- [ ] Les mutations whitelistent-elles les champs acceptés ? (pas de `req.body` passé directement à un update DB)
- [ ] Les entrées utilisateur sont-elles validées côté serveur ?
- [ ] Y a-t-il du `dangerouslySetInnerHTML` → DOMPurify appliqué ?
- [ ] Les messages d'erreur n'exposent-ils pas de détails techniques ?

**Secrets**
- [ ] Aucune clé API privée dans le code front-end ?
- [ ] Les secrets sont-ils dans les variables d'environnement back-end uniquement ?
- [ ] Le fichier `.env` est-il dans `.gitignore` ?
- [ ] La `service_role` key Supabase est-elle absente du bundle client ?

**Dépendances**
- [ ] `npm audit` a-t-il été lancé après les dernières installations ?
- [ ] Les packages nouvellement suggérés par l'IA ont-ils été vérifiés sur npmjs.com ?

**Intégrations**
- [ ] Y a-t-il des webhooks entrants ? → signature HMAC vérifiée, corps lu en RAW ?
- [ ] Y a-t-il des URLs fournies par l'utilisateur passées à `fetch` côté serveur ? → whitelist de domaines appliquée ?

**Mobile (si React Native / Expo)**
- [ ] Aucune donnée sensible stockée dans `AsyncStorage` → `expo-secure-store` utilisé ?
- [ ] Aucune clé privée dans le code source ou les variables d'env compilées ?
- [ ] Les deep links OAuth utilisent-ils Universal Links / App Links (pas de scheme custom) ?

**Ressources (section 2bis)**
- [ ] Les requêtes DB fetchent-elles uniquement ce qui est nécessaire (pas de `SELECT *` systématique) ?
- [ ] Les abonnements temps réel sont-ils fermés correctement quand le composant se démonte ?

**Spécifique au projet**
Reprendre les points identifiés dans `/securite analyse` et vérifier ceux qui s'appliquent à cette feature.

### Étape 3 — Rapport de vérification

> "**Vérification sécurité — [feature] — [date]**
>
> ✅ Points validés : [liste]
>
> ❌ Points en échec :
> - [point] — [description du problème] — [correction attendue]
>
> **Verdict : BLOQUANT / OK**"

Si BLOQUANT → corriger avant tout merge. Relancer `/securite check` après correction.
Si OK → merge autorisé.

---

## Mode `audit` — `/securite audit`

**Quand :** avant chaque mise en production. Obligatoire pour les projets de niveau de risque moyen et élevé (§1.14 de `securite.md`). Recommandé pour tous les projets.

**Rôle :** audit croisé double LLM du code complet, suivi d'une validation par scan automatique.

### Étape 1 — Audit Claude (LLM courant)

Lire l'ensemble du code du projet (modules, routes, schéma BDD, configuration).

Produire un rapport d'audit structuré :

> "**Audit sécurité complet — [projet] — [date]**
>
> **Périmètre audité :** [liste des fichiers / modules lus]
>
> **Vulnérabilités identifiées :**
>
> 🔴 Critiques (à corriger avant déploiement) :
> - [fichier:ligne] — [vulnérabilité] — [correction]
>
> 🟠 Importantes :
> - [fichier:ligne] — [observation] — [recommandation]
>
> 🟡 Mineures :
> - [observation] — [recommandation]
>
> ✅ Points validés :
> - [ce qui est bien implémenté]"

### Étape 2 — Instructions pour l'audit croisé (second LLM)

Produire un prompt prêt à l'emploi pour le second LLM (GPT-4, Gemini ou autre) :

> "**Prompt à utiliser pour l'audit croisé :**
>
> Fais un audit de sécurité complet de cette application. Vérifie :
> - Validation des entrées côté serveur (formulaires, paramètres d'URL, payloads API)
> - Gestion des clés API et secrets (aucune clé privée en front-end)
> - Authentification côté serveur vs côté client (guards React ≠ protection API)
> - Permissions de la base de données (RLS activé, policies par opération)
> - Injections (SQL brut, template literals avec données utilisateur)
> - Mass assignment (req.body passé directement à un update DB)
> - Webhooks (signature HMAC vérifiée ?)
> - Security headers (vercel.json configuré ?)
> - dangerouslySetInnerHTML (DOMPurify appliqué ?)
> - Packages suspects (vérifiés sur npmjs.com ?)
>
> Code à auditer : [coller le code ici]"

### Étape 3 — Synthèse croisée

Après l'audit du second LLM, demander à Medwin de coller les résultats.

Identifier les divergences entre les deux audits :
- Points en échec pour les deux → priorité absolue
- Points en échec seulement pour l'un → à investiguer manuellement
- Points validés par les deux → confirmés

Produire la liste finale des corrections à effectuer avant déploiement.

### Étape 4 — Scan automatique

Déclencher les outils de scan (§3.2 de `securite.md`) :

```bash
# Semgrep — analyse statique
semgrep --config "p/react" --config "p/nodejs" --config "p/secrets" .

# Snyk — dépendances
snyk test

# npm audit
npm audit
```

Puis scanner l'URL de staging avec :
- Mozilla Observatory : `npx observatory --format report https://[url-staging]`
- securityheaders.com : vérification manuelle

Intégrer les résultats dans `[projet].recette.md` (section Sécurité).

---

## Règles

- **Mode `analyse` = une seule fois par projet**, au démarrage, avant `/archi`
- **Mode `check` = à chaque feature**, automatiquement, non négociable
- **Mode `audit` = avant chaque mise en production**, obligatoire pour les niveaux moyen et élevé
- **Un point en échec en mode `check` = merge bloqué** — pas d'exception
- **Web search si nécessaire** — pour vérifier une règle de sécurité spécifique à un outil de la stack
