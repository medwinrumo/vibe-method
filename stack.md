# stack.md

Doctrine de reconnaissance technique — ce qu'on investigue avant de coder, pourquoi, et comment.
À enrichir au fil des projets et des stacks rencontrées.

---

## Principe fondamental

**Anticiper, pas réagir.**

Démarrer un projet sans connaître les contraintes de sa stack, c'est s'exposer à trois types de problèmes coûteux :

1. **Données d'entraînement obsolètes** — l'IA recommande des patterns qui étaient corrects au moment de son entraînement. Les APIs évoluent, les breaking changes arrivent, les best practices se mettent à jour. Sans investigation préalable, on code avec des informations périmées.

2. **Contraintes découvertes trop tard** — une limite de free tier, une restriction d'API, ou un gotcha architectural découvert au milieu du développement oblige à refactorer ce qui est déjà construit. Le coût est exponentiellement plus élevé qu'une heure de recherche en amont.

3. **Absence de référence commune** — sans document de stack, chaque session IA repart de zéro. On réexplique les contraintes, on redemande les patterns, on reproduit les mêmes erreurs.

---

## Le spike technique

Un spike technique est une **activité time-boxée de recherche** pour lever une incertitude avant de construire. Il n'est pas du code déployable — il produit de la connaissance.

**Règles du spike :**
- Une question claire à répondre — pas une exploration générale
- Une durée fixée à l'avance — 2 à 4 heures pour une stack connue, une journée maximum pour une stack nouvelle
- Un livrable concret — `[projet].stack.md` dans le repo du projet
- Si la durée est dépassée → s'arrêter, rendre les findings, décider de la suite

**Ce qui déclenche un spike :**
- Stack nouvelle ou peu maîtrisée
- API externe critique pour le projet
- Contrainte de free tier non encore cartographiée
- Intégration entre plusieurs outils dont la compatibilité est incertaine

---

## Cadre d'investigation — applicable à toute stack

Pour chaque outil ou service de la stack, investiguer dans cet ordre :

### 1. Versions et état de l'art
- Quelle est la version actuelle ? Y a-t-il eu des breaking changes récents ?
- Quelle est la version que l'IA connaît probablement (date de training) ?
- Y a-t-il des migrations en cours ou annoncées ?

### 2. Limites du free tier
- Quelles sont les limites en volume, requêtes, stockage, bande passante ?
- Quelles actions déclenchent des coûts ?
- Y a-t-il des limites discrètes (pause automatique, coupure) vs. des limites progressives (pay-as-you-go) ?
- Comment monitorer sa consommation ?

### 3. Gotchas et pièges connus
- Quels sont les comportements contre-intuitifs documentés ?
- Quels sont les problèmes de performance courants ?
- Quelles sont les erreurs les plus fréquentes sur GitHub Issues, Stack Overflow, Discord ?
- Quels sont les anti-patterns à éviter absolument ?

### 4. Sécurité spécifique à l'outil
- Quelles données sont exposées par défaut ?
- Quelles configurations de sécurité sont désactivées par défaut et doivent être activées manuellement ?
- Quelles clés / tokens ne doivent jamais se retrouver côté client ?

### 5. APIs et SDK clés
- Quelles sont les fonctions principales que le projet va utiliser ?
- Y a-t-il des limites de rate limiting sur ces APIs ?
- Quels sont les patterns d'usage recommandés (avec exemples) ?
- Y a-t-il des fonctions deprecated à éviter ?

### 6. Compatibilité entre outils
- Comment les outils de la stack s'intègrent-ils entre eux ?
- Y a-t-il des incompatibilités de versions connues ?
- Quelles sont les dépendances partagées susceptibles de conflits ?

### 7. Compatibilité avec l'IA (Claude Code)
- Existe-t-il des ressources ou guides spécifiques pour utiliser cet outil avec Claude Code ?
- L'IA connaît-elle bien cet outil ou a-t-elle tendance à halluciner des APIs ?
- Y a-t-il des patterns TypeScript spécifiques à fournir dans le contexte ?

### 8. Observabilité
- Quel outillage de logs/métriques/alerting pour ce projet, à quel niveau de déploiement (voir `observabilite.md`) ?
- Documenté dans `[projet].stack.md` section observabilité.

---

## Vérification documentaire par feature (source-driven)

Comparaison externe (pack `addyosmani/agent-skills`), validée le 2026-07-28. Complète le spike technique : le spike lève l'incertitude une fois par outil en Phase 4, ceci se rejoue à chaque feature qui touche un pattern framework-spécifique nouveau — pas seulement en cas de blocage (voir `methode.md`, "Le faucon en chasse").

**Principe :** ne jamais coder un pattern spécifique à un framework depuis la mémoire de l'IA sans l'avoir vérifié contre la doc officielle. Les données d'entraînement se périment, les APIs changent, ce qui avait l'air correct casse en silence.

**Process, à chaque fois qu'un pattern framework-spécifique nouveau est écrit :**

1. **DETECT** — lire le fichier de dépendances du projet (`package.json`, `requirements.txt`...) pour connaître la version exacte en jeu.
2. **FETCH** — aller chercher la page de doc officielle précise (pas la page d'accueil, pas une recherche générale). Hiérarchie de confiance : doc officielle > blog/changelog officiel > standards (MDN) > jamais Stack Overflow, jamais un blog tiers, jamais la mémoire de l'IA seule.
3. **IMPLEMENT** — suivre le pattern documenté, signaler si la doc contredit le code existant du projet plutôt que trancher silencieusement.
4. **CITE** — une citation (URL précise, avec ancre) pour chaque décision framework-spécifique non triviale. Si rien n'est trouvé → le dire explicitement ("non vérifié"), jamais faire semblant.

**Quand ne pas s'embêter :** renommage, formatage, logique pure indépendante de version, ou demande explicite de vitesse plutôt que de vérification.

**Pas encore de mécanique de forçage** (hook ou lint) — évalué comme trop fragile pour l'instant (détection de domaine de doc "officielle" par heuristique = faux positifs/négatifs). À la place : surveillance via `task-observer`. Toute application ou tout saut de cette doctrine pendant une session framework-spécifique se log comme observation. **Seuil : après 3 sauts sans raison valable, revenir discuter d'un mécanisme de forçage (hook `PostToolUse` sur `Edit`/`Write` de fichiers de code, avec heuristique de domaines officiels par stack).**

---

## Format de `[projet].stack.md`

Le document produit par le skill `/stack`. Stocké dans le repo du projet. Consulté par tous les skills suivants.

```markdown
# Stack — [Nom du projet]
_Investigué le [date]_

## Stack choisie
[Stack A — Convex / Stack B — Supabase] + React + Vite + TypeScript + Vercel + GitHub

---

## [Nom de l'outil 1]
**Version actuelle :** [version]
**Version connue par l'IA :** [estimation]

### Limites free tier
- [limite 1]
- [limite 2]

### Gotchas critiques
- [piège 1 — description + impact]
- [piège 2 — description + impact]

### Sécurité
- [point de sécurité 1]

### APIs clés pour ce projet
- [fonction/API 1] — [usage prévu + pattern recommandé]
- [fonction/API 2] — [usage prévu + pattern recommandé]

### Ressources de référence
- [lien documentation officielle]
- [lien guide spécifique]

---

## [Nom de l'outil 2]
[même structure]

---

## Contraintes croisées
[Incompatibilités ou points d'attention liés à l'interaction entre les outils]

---

## Décisions prises suite à l'investigation
[Ce que l'investigation a changé dans l'architecture ou la roadmap]
```

---

## Comment les autres skills utilisent `[projet].stack.md`

| Skill | Ce qu'il lit dans stack.md |
|---|---|
| `/roadmap` | Limites free tier → éviter de planifier des features qui dépassent les quotas en V1 |
| `/specs` | Gotchas et contraintes API → écrire des critères d'acceptation réalistes |
| `/tests` | Patterns d'authentification et de mock → savoir quoi tester contre le vrai service vs. mocker |
| `/recette` | Comportements connus → ne pas confondre un gotcha documenté avec un bug |
| Code | Référence permanente pour l'IA pendant le développement |

**Règle :** tout skill qui prend une décision susceptible d'être affectée par une contrainte de stack **doit** lire `[projet].stack.md` avant d'agir.

---

## Checklists par stack

### Stack A — Convex

**Limites free tier (Starter) :**
- 1 million d'appels de fonctions / mois
- 0.5 GB de stockage base de données
- 1 GB de stockage fichiers
- 1 GB de bande passante / mois
- 6 membres maximum par équipe
- Pay-as-you-go au-delà (pas de coupure)

**Gotchas critiques :**
- **Bandwidth explosion avec les listes paginées** — toute mise à jour d'un élément dans une liste paginée renvoie la liste complète (MB au lieu de KB). Pas de caching natif. Requiert un design custom si le volume est important.
- **Accumulation de tokens d'auth** — un utilisateur actif peut générer 2000+ refresh tokens/mois. À 500 utilisateurs = 1M+ tokens. Nettoyer régulièrement.
- **Conflit pagination / real-time** — la pagination vise l'efficacité réseau, le real-time veut tous les deltas. Ces deux besoins s'opposent dans Convex — prévoir du design custom si les deux sont nécessaires.

**Sécurité :**
- Les mutations et actions sont publiques par défaut — ajouter des vérifications d'identité explicites dans chaque fonction qui accède aux données utilisateur
- Ne jamais exposer de logique d'autorisation côté client

**Ressources de référence :**
- Documentation officielle : https://docs.convex.dev
- Best practices : https://docs.convex.dev/understanding/best-practices/
- Limites : https://docs.convex.dev/production/state/limits

---

### Stack B — Supabase

**Limites free tier :**
- 500 MB de base de données
- 50 000 utilisateurs actifs mensuels
- 1 GB de stockage fichiers (50 MB par fichier max)
- 2 projets gratuits
- **Pause automatique après 7 jours d'inactivité** — prévoir un ping régulier pour les projets en dev

**Gotchas critiques :**
- **RLS désactivée par défaut** — créer une table = RLS désactivée. Toutes les données sont accessibles à n'importe qui avec la clé anon. À activer immédiatement sur chaque nouvelle table, sans exception.
- **RLS activée sans policies = résultats vides silencieux** — l'app ne plante pas, elle retourne juste des tableaux vides. L'éditeur SQL bypasse RLS — tester uniquement depuis le SDK client.
- **Service role key côté client** — erreur critique et fréquente. La service role key bypasse toutes les RLS. Ne jamais l'utiliser dans le frontend.
- **Colonnes non indexées dans les policies RLS** — tueur de performances silencieux. Indexer systématiquement les colonnes utilisées dans les conditions RLS.

**Sécurité :**
- Activer RLS sur toutes les tables, sans exception, dès la création
- Tester chaque policy depuis le SDK client (jamais depuis l'éditeur SQL)
- Mettre la service role key uniquement dans les variables d'environnement serveur
- Activer les alertes de quota dans le dashboard Supabase

**Ressources de référence :**
- Row Level Security : https://supabase.com/docs/guides/database/postgres/row-level-security
- Best practices : https://supabase.com/docs/guides/platform/going-into-prod
- Billing FAQ : https://supabase.com/docs/guides/platform/billing-faq

---

### Commun — React 19 + Vite + TypeScript

**Configuration TypeScript recommandée :**
```json
{
  "compilerOptions": {
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true
  }
}
```

**Gotchas courants :**
- **Barrel files (`index.ts`)** — importer depuis un barrel charge tous les fichiers du barrel. Préférer les imports directs pour les performances.
- **Libraries CommonJS** — utiliser les versions ESM (ex : `lodash-es` plutôt que `lodash`) pour que Vite puisse tree-shaker correctement.
- **Plugins Vite excessifs** — chaque plugin ralentit le dev server. Garder la configuration minimale.
- **Désactiver le caching Vite** — Vite repose entièrement sur le caching pour sa performance. Ne pas le désactiver.

**Bonnes pratiques :**
- Imports directs, pas de barrels pour les modules critiques au chargement
- ESM-first pour toutes les librairies tierces
- Code-splitting natif Vite — en profiter pour les modules lourds

---

### Tests — Playwright

**État de l'art (v1.56+) :**
- Playwright Test Agents intégrés : Planner, Generator, Healer — génération et maintenance de tests en langage naturel
- Résultats mesurés : création de tests 70-80% plus rapide, maintenance 60-70% moins coûteuse
- Intégration MCP disponible pour Claude Code

**Bonnes pratiques :**
- Page Object Model (POM) — encapsuler les sélecteurs pour la maintenabilité
- Sélecteurs résilients — préférer les attributs sémantiques (`role`, `label`) aux sélecteurs CSS fragiles
- Secrets en variables d'environnement — jamais hardcodés dans les fichiers de test
- Tester depuis le SDK client — jamais en bypassant les couches d'authentification
- Mode headless par défaut, mode visible pour le debug

**Ressources de référence :**
- Documentation : https://playwright.dev/docs
- Test Agents : https://playwright.dev/docs/test-agents

---

## Dépendances — coder ou importer

Pour toute fonctionnalité candidate à une lib externe (npm, etc.), le LLM juge au cas par cas :
- Si la fonction est triviale à écrire soi-même → la coder directement, pas de lib
- Si c'est complexe, standardisé, ou à fort risque d'erreur (dates, crypto, parsing) → importer une lib reconnue
- Pas de règle figée — décision projet par projet, mais toujours motivée

**Scan régulier obligatoire** : passer un outil de type `depcheck` périodiquement pour repérer les dépendances mortes ou quasi jamais utilisées, et les retirer (recoder à la main si le volume d'usage est faible). Complète le suivi sécurité déjà prévu dans `securite.md` §2.2 (`npm audit`, Dependabot).

---

## Coûts cachés — au-delà du free tier de la stack technique

Certains outils indispensables à un projet en production ne font pas partie de la stack applicative (Convex/Supabase) ni de la stack de dev — ils sont oubliés au moment du `/stack` initial et découverts à l'usage.

À vérifier systématiquement pour tout projet destiné à la prod :
- **Emailing transactionnel** (confirmation de compte, réinitialisation de mot de passe...) — aucun backend ne le fournit nativement en illimité. Options : Resend, Brevo, Mailjet — vérifier le quota gratuit exact (nombre d'emails/mois) avant de compter dessus.
- **Monitoring d'erreurs production** (Sentry ou équivalent) — quota gratuit basé sur le volume d'erreurs remontées, peut être consommé vite par une erreur récurrente non corrigée.
- **Limites de collaboration** — Vercel/Netlify facturent dès qu'on déploie depuis une organisation GitHub (pas un compte perso) ou dès qu'on ajoute des utilisateurs. À anticiper si le projet passe de solo à équipe.
- **Limite de prélèvement carte bancaire** — dès qu'une CB est ajoutée sur une plateforme cloud (Vercel, Cloudflare, etc.), configurer immédiatement un plafond de prélèvement. Voir `securite.md` §4.

À documenter dans `[projet].stack.md` sous une section "Coûts cachés" dès l'investigation initiale.

---

## Règles de conduite

1. **Le spike est time-boxé** — 2 à 4 heures max. Si la question n'est pas résolue, documenter ce qu'on sait, noter ce qui reste ouvert, continuer.
2. **L'investigation est orientée projet** — on n'investigue pas une stack en général, on investigue ce dont le projet a besoin spécifiquement.
3. **Tout finding critique va dans `[projet].stack.md`** — pas dans la tête, pas dans Notion uniquement. Dans le repo, accessible à l'IA à chaque session.
4. **Les décisions impactées sont documentées** — si l'investigation change quelque chose à l'architecture ou à la roadmap, c'est noté explicitement dans le document.
5. **Le document est vivant** — si un gotcha est découvert pendant le développement, il est ajouté à `[projet].stack.md` immédiatement.
