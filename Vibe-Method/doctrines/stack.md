---
type: doctrine
source: ../../stack.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [stack, spike, investigation, free-tier, gotchas, dependances, couts-caches, source-driven, observabilite]
---

# Doctrine — Stack

## En une ligne
Anticiper, pas réagir : investiguer les contraintes de la stack avant de coder, pas quand les problèmes apparaissent.

---

## Pourquoi un spike ?

Sans investigation préalable, 3 risques coûteux :
1. **Données obsolètes** : l'IA recommande des patterns périmés (data de training)
2. **Contraintes découvertes trop tard** : limites free tier, gotchas architecturaux → refactoring coûteux
3. **Pas de référence commune** : chaque session IA repart de zéro

---

## Le spike technique

- **Durée fixée** : 2 à 4h (stack connue) / 1 jour max (stack nouvelle)
- **Déclencheur** : stack nouvelle, API externe critique, free tier inconnu, intégration incertaine
- **Livrable** : `[projet].stack.md` dans le repo (pas dans la tête)
- **Règle** : si durée dépassée → documenter ce qu'on sait, noter ce qui reste ouvert, continuer

---

## 7 points d'investigation (par outil)

1. Version actuelle — breaking changes récents ?
2. Limites free tier — volumes, seuils, comportement à saturation
3. Gotchas et pièges — GitHub Issues, Stack Overflow, Discord
4. Sécurité spécifique — ce qui est désactivé par défaut
5. APIs et SDK clés — rate limiting, patterns recommandés
6. Compatibilité entre outils — incompatibilités de versions connues
7. Compatibilité avec Claude Code — l'IA connaît-elle bien cet outil ?
8. Observabilité — outillage logs/métriques/alerting, voir [[doctrines/observabilite]]

---

## Vérification documentaire par feature (source-driven)

Complète le spike : le spike lève l'incertitude une fois par outil (Phase 4), ceci se rejoue à chaque feature qui touche un pattern framework-spécifique nouveau — pas seulement en cas de blocage (contrairement au "faucon en chasse" réactif de [[doctrines/methode]]).

**Process** : DETECT (version exacte depuis le fichier de dépendances) → FETCH (doc officielle précise, jamais Stack Overflow/blog/mémoire seule) → IMPLEMENT (signaler les contradictions avec le code existant plutôt que trancher silencieusement) → CITE (URL précise par décision non triviale, ou "non vérifié" explicite).

**Pas de mécanique de forçage** — heuristique de "domaine de doc officielle" jugée trop fragile (faux positifs/négatifs). Surveillance via `task-observer`, seuil de 3 sauts sans raison valable avant de reconsidérer un hook `PostToolUse` sur `Edit`/`Write`.

---

## Gotchas critiques par stack

**Convex :**
- Bandwidth explosion avec listes paginées (toute MàJ renvoie la liste complète)
- Accumulation de tokens d'auth (2000+/mois/utilisateur actif)
- Conflict pagination / real-time — design custom obligatoire

**Supabase :**
- **RLS désactivée par défaut** — activer sur chaque nouvelle table immédiatement
- RLS activée sans policies = résultats vides silencieux (pas d'erreur)
- `service_role` key côté client = bypass total de RLS
- Colonnes RLS non indexées = tueur de performances silencieux
- **Pause automatique après 7j d'inactivité** (free tier)

**React + Vite + TypeScript :**
- Barrel files → importer directement, pas depuis `index.ts`
- Libraries CommonJS → préférer les versions ESM
- Ne jamais désactiver le caching Vite

---

## Dépendances — coder ou importer

Pas de règle figée : le LLM juge au cas par cas.
- Fonction triviale → la coder soi-même, pas de lib
- Complexe/standardisée/à risque (dates, crypto, parsing) → importer une lib reconnue
- **Scan régulier obligatoire** (`depcheck`) : repérer les dépendances mortes ou peu utilisées, les retirer

---

## Coûts cachés — au-delà du free tier technique

Outils indispensables en prod, oubliés au moment du `/stack` initial :
- **Emailing transactionnel** (Resend, Brevo, Mailjet) — vérifier le quota gratuit exact
- **Monitoring d'erreurs** (Sentry) — quota basé sur le volume d'erreurs remontées
- **Limites de collaboration** — Vercel/Netlify facturent dès qu'on déploie depuis une org GitHub ou qu'on ajoute des utilisateurs
- **Limite de prélèvement CB** — à configurer dès l'ajout d'une carte sur une plateforme cloud, avant le premier dépassement de plan gratuit (voir [[doctrines/securite]])

À documenter dans `[projet].stack.md` section "Coûts cachés" — investigué systématiquement par `/stack` (étape 2bis).

---

## Comment les autres skills utilisent stack.md

| Skill | Ce qu'il lit |
|---|---|
| [[skills/roadmap]] | Limites free tier → éviter les features hors quota en V1 |
| [[skills/specs]] | Gotchas → critères d'acceptation réalistes |
| [[skills/tests]] | Patterns auth et mock |
| [[skills/sessionCode]] | Contraintes critiques → règles session |

---

## Règles non-négociables

- **Spike time-boxé** — s'arrêter et documenter si dépassé
- **Investigation orientée projet** — pas en général, pour ce projet spécifiquement
- **Tout finding critique dans `[projet].stack.md`** — dans le repo, pas dans la tête
- **Document vivant** — gotcha découvert en dev → ajouté immédiatement

## Liens
[[skills/stack]] | [[doctrines/architecture]] | [[flux/chaine-complete]]
