# PRP — Enrichissement doctrines
_Produit par agent le 2026-05-11 — à appliquer lors de la tâche 6_

---

## architecture.md

**Règles critiques à intégrer :**
1. Un module peut appeler le code d'un autre via import — il ne peut jamais modifier son code.
2. `/shared` = utilitaires génériques uniquement — jamais de logique métier.
3. Ne descendre d'un niveau d'abstraction (VPS, Docker) que si le niveau supérieur ne couvre pas le besoin — jamais par défaut.
4. Le staging n'est jamais permanent — créé à la demande, fermé après validation.
5. DPA signé avant toute mise en production avec données personnelles EU.

**Destination :** règles 1+2 → PRP section "Règles silo" + CLAUDE.md projet. Règles 3+4+5 → checklist `/archi`.

---

## securite.md

**Règles critiques à intégrer :**
1. RLS désactivé par défaut sur Supabase — l'activer manuellement sur chaque table dès la création, pas après.
2. Jamais de clé API privée en front-end ni dans les variables d'environnement front. `.env` jamais commité.
3. Jamais `Access-Control-Allow-Origin: *` en production.
4. Vérifier authentification ET autorisation à chaque requête — ce sont deux checks distincts.
5. Les messages d'erreur exposés aux utilisateurs ne contiennent jamais de détails techniques.

**Destination :** règles 1+2+3+4 → PRP section "Contraintes critiques". Règle 5 → `/code-review`.

---

## tests.md

**Règles critiques à intégrer :**
1. Ne jamais demander en un seul prompt "développe cette feature ET écris les tests" — contextes séparés.
2. Toujours demander explicitement des scénarios négatifs — l'IA génère le chemin heureux par défaut.
3. Un scénario Gherkin = un test Playwright — générer avant de continuer si manquant.
4. Après chaque nouvelle feature, relancer toute la batterie Playwright existante.
5. Les Gherkin sont générés par `/recette` depuis les User Stories — pas dans les specs.

**Destination :** règles 1+2+4 → PRP section "Tests — patterns". Règles 3+5 → `/tests` et `/recette`.

---

## rgpd.md

**Règles critiques à intégrer :**
1. Tout fournisseur traitant des données personnelles EU = DPA obligatoire avant mise en production.
2. "Supprimer un compte" ne suffit pas — supprimer toutes les données liées (BDD, fichiers, logs, services tiers). Prévoir la cascade dès le schéma.
3. RLS activé sur toutes les tables contenant des données personnelles.
4. Chaque champ doit répondre à "à quelle fonctionnalité précise est-ce nécessaire ?" — si flou, ne pas collecter.
5. Base légale définie avant de coder le traitement — une base légale par traitement.

**Destination :** règles 1+2+4+5 → checklist `/archi`. Règle 2 → item `/code-review`. Règle 3 → PRP uniquement si projet avec données personnelles.

---

## Tableau de priorité

| Règle | Source | Destination | Priorité |
|---|---|---|---|
| RLS désactivé par défaut — activer dès création | securite.md | PRP | Haute |
| Jamais de secret en front-end, `.env` non commité | securite.md | PRP | Haute |
| Jamais `Access-Control-Allow-Origin: *` en prod | securite.md | PRP | Haute |
| Auth ≠ Autorisation — vérifier les deux | securite.md | PRP | Haute |
| Code et tests dans des contextes séparés | tests.md | PRP + `/tests` | Haute |
| Toujours demander des tests négatifs explicitement | tests.md | PRP + `/tests` | Haute |
| `/shared` = utilitaires uniquement | architecture.md | PRP + CLAUDE.md projet | Moyenne |
| Un module appelle, jamais modifie | architecture.md | PRP section silo | Moyenne |
| Cascade suppression dès le schéma (RGPD) | rgpd.md | `/archi` + `/code-review` | Moyenne |
| DPA signé avant mise en prod | architecture.md + rgpd.md | `/archi` + `/deploy` | Moyenne |
| Staging jamais permanent | architecture.md | `/archi` checklist | Basse |
| Non-régression Playwright après chaque feature | tests.md | `/tests` | Basse |
