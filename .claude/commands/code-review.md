# /code-review — Revue de code avant merge

Tu fais une revue complète du code d'une feature avant son merge dans `main`.
Ce skill s'insère dans la Phase 7 — Vérification, après les tests automatisés et avant la recette manuelle.

---

## Quand l'utiliser

- Après que les tests Vitest et Playwright sont passants
- Avant `/recette`
- Sur toute feature dont le code touche : authentification, paiement, données personnelles, logique métier critique

---

## Étape 0 — Identification du périmètre

Tu demandes :
> "Quelle branche ou quels fichiers dois-je revoir ?"

Tu listes les fichiers modifiés :
```bash
git diff main --name-only
```

Tu confirmes le périmètre avec Medwin avant de commencer.

---

## Étape 1 — Revue structurelle

Tu lis chaque fichier modifié et tu vérifies :

**Architecture et silo**
- [ ] Le code respecte la règle silo (aucun module ne modifie le code d'un autre)
- [ ] Les imports respectent les contrats d'interface définis dans `/archi`
- [ ] Aucun élément privé d'un module n'est importé depuis l'extérieur

**Qualité du code**
- [ ] Pas de code mort ou commenté qui traîne
- [ ] Pas de console.log, debugger ou TODO non résolu
- [ ] Les noms de variables et fonctions sont clairs et cohérents avec le reste du projet
- [ ] Pas de duplication évidente (même logique copiée dans plusieurs endroits)

**Logique métier**
- [ ] La logique correspond à ce qui est décrit dans la spec (`[projet].spec.[feature].md`)
- [ ] Les cas limites définis dans la spec sont gérés dans le code
- [ ] Les cas d'échec définis dans la spec retournent les bonnes erreurs

---

## Étape 2 — Revue sécurité

Tu appliques les règles de `securite.md` :

**Secrets et clés**
- [ ] Aucune valeur hardcodée (clés API, tokens, URLs d'environnement, credentials)
- [ ] La `service_role` key Supabase absente du code front-end et du bundle

**Auth et accès**
- [ ] Les règles d'accès (auth, rôles) sont vérifiées côté serveur (`supabase.auth.getUser()` ou `ctx.auth.getUserIdentity()`), pas seulement côté client (guard React)
- [ ] RLS activé sur les nouvelles tables, avec policies distinctes par opération (SELECT/INSERT/UPDATE/DELETE)

**Entrées et mutations**
- [ ] Les inputs utilisateur sont validés côté serveur avant tout traitement
- [ ] Les mutations whitelistent les champs acceptés — pas de `req.body` passé directement à un update DB
- [ ] Pas de requête SQL construite par concaténation de chaînes
- [ ] Pas de `dangerouslySetInnerHTML` sans DOMPurify appliqué

**Intégrations**
- [ ] Les webhooks entrants vérifient la signature HMAC du service émetteur, corps lu en RAW
- [ ] Les URLs fournies par l'utilisateur passées à `fetch` côté serveur sont filtrées par une whitelist de domaines

**Configuration**
- [ ] Les en-têtes de sécurité HTTP sont configurés dans `vercel.json` (X-Frame-Options, X-Content-Type-Options, CSP)
- [ ] Les erreurs retournées à l'utilisateur ne révèlent pas d'informations internes
- [ ] Les données sensibles ne sont pas loggées

**Dépendances**
- [ ] Les packages nouvellement installés ont été vérifiés sur npmjs.com (téléchargements, date, mainteneur)
- [ ] `npm audit` a été lancé

Si le projet est une app mobile (React Native / Expo) :
- [ ] Aucune donnée sensible stockée dans `AsyncStorage` → `expo-secure-store` utilisé
- [ ] Aucune clé privée dans le code source ou les variables d'env compilées dans le bundle
- [ ] Les deep links OAuth utilisent Universal Links (iOS) / App Links (Android)
- [ ] Les permissions iOS/Android déclarées dans Info.plist correspondent à ce qui est utilisé

---

## Étape 3 — Rapport de revue

Tu produis un rapport structuré :

```markdown
## Code Review — [feature] — [date]

### Statut global
[APPROUVÉ / APPROUVÉ AVEC RÉSERVES / BLOQUANT]

### Points bloquants (à corriger avant merge)
- [fichier:ligne] — [problème] — [correction recommandée]

### Points à améliorer (non bloquants)
- [fichier:ligne] — [observation] — [suggestion]

### Points positifs
- [ce qui est bien fait — utile pour maintenir le niveau]

### Verdict
[merge autorisé / corrections requises avant merge]
```

Tu présentes le rapport à Medwin et tu attends sa décision.

---

## Étape 4 — Corrections si nécessaire

Si des points bloquants sont identifiés :
- Tu expliques chaque problème et la correction recommandée
- Medwin valide la correction ou propose une alternative
- Tu corriges, tu relances les tests concernés, tu refais la revue sur les fichiers modifiés

Si aucun point bloquant → le code est prêt pour `/recette`.

---

## Intégration dans la chaîne

La revue de code s'insère ainsi dans la Phase 7 :

```
1. Feature développée
2. /tests         → tests unitaires + intégration (Vitest)
3. /tests         → non-régression Playwright
4. /code-review   → revue structurelle + sécurité → bloquant si point critique
5. /recette       → génération du cahier de recettes (Gherkin)
6. /tests         → Playwright sur la nouvelle feature
7. /securite check → vérification sécurité
8. /recette       → validation manuelle finale
```

---

## Ton

Direct et factuel. Tu identifies les problèmes sans ménagement mais sans jugement. Le but est un code propre et sûr — pas de vexer. Si quelque chose est bien fait, tu le dis aussi.
