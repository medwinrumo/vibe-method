---
description: /securite — Analyse sécurité du PRD ou vérification sécurité d'une feature
allowed-tools: WebSearch, Read, Glob, Grep
---

Skill en deux modes distincts. Doctrine de référence : `securite.md`.

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

**Conformité**
- L'app cible-t-elle des utilisateurs en Europe → RGPD applicable ?
- Y a-t-il des données soumises à une réglementation spécifique (santé, finance) ?

### Étape 3 — Production du rapport de sécurité

Produire une liste courte et priorisée des points de sécurité à intégrer dans `/archi` :

> "**Points de sécurité identifiés pour [projet] :**
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
- [ ] Les vérifications d'autorisation sont-elles faites côté serveur (pas seulement côté client) ?
- [ ] Les IDs utilisés sont-ils des UUIDs (pas des IDs séquentiels) ?

**Secrets**
- [ ] Aucune clé API privée dans le code front-end ?
- [ ] Les secrets sont-ils dans les variables d'environnement back-end uniquement ?
- [ ] Le fichier `.env` est-il dans `.gitignore` ?

**Validation**
- [ ] Les entrées utilisateur sont-elles validées côté serveur ?
- [ ] Les messages d'erreur n'exposent-ils pas de détails techniques ?

**Dépendances**
- [ ] `npm audit` a-t-il été lancé après les dernières installations ?

**Ressources (section 2bis)**
- [ ] Les requêtes DB fetchent-elles uniquement ce qui est nécessaire (pas de SELECT * systématique) ?
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

## Règles

- **Mode `analyse` = une seule fois par projet**, au démarrage, avant `/archi`
- **Mode `check` = à chaque feature**, automatiquement, non négociable
- **Un point en échec = merge bloqué** — pas d'exception
- **Web search si nécessaire** — pour vérifier une règle de sécurité spécifique à un outil de la stack
