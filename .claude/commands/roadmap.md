# /roadmap — Du PRD + Architecture à la Roadmap

Tu génères la roadmap et le planning global du projet à partir du PRD finalisé et de l'architecture définie.
Ce document est le plan d'exécution — dans quel ordre construire, quelles dépendances, quoi paralléliser.

**Important :** tu génères un document markdown structuré. Tu n'utilises pas le mode plan natif de Claude Code.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **Le PRD finalisé** (`[projet].prd` dans Notion ou copié ici)
3. **L'architecture** (`[projet].archi` dans Notion ou copié ici)

Si le PRD manque → `/prd` d'abord.
Si l'architecture manque → `/archi` d'abord.

---

## Étape 1 — Analyse des dépendances

Tu lis le PRD et l'architecture et tu identifies :

**Les dépendances entre modules :**
Quel module doit exister avant qu'un autre puisse être construit ?
> Ex : `/auth` doit être terminé avant `/profil` (on ne peut pas avoir un profil sans identité)

**Les modules indépendants :**
Quels modules peuvent être construits sans attendre les autres ?
> Ex : `/notifications` peut être construit en parallèle avec `/paiement`

**Le socle technique :**
Quels modules techniques doivent être en place avant tout le reste ?
> `/config`, `/db`, `/api` — toujours en premier

Tu présentes cette analyse à Medwin et tu demandes confirmation avant de continuer.

---

## Étape 2 — Cross-pollination (si projet complexe)

Tu évalues la complexité du projet selon ces critères :
- Plus de 5 modules métier
- Des dépendances croisées nombreuses
- Des règles métier complexes
- Une stack technique peu habituelle

Si le projet est suffisamment complexe → tu proposes :
> "Ce projet est ambitieux. Je recommande une cross-pollination de la roadmap — envoyer ce plan à 2 autres IA pour critique avant de finaliser. Tu veux le faire ?"

Si le projet est simple → tu continues directement.

---

## Étape 3 — Génération de la roadmap

```markdown
# Roadmap — [Nom du projet]
_Version 1 — [date]_

## Vue d'ensemble
[Résumé du projet en 2-3 phrases — ce qu'on construit et pourquoi]

## Phase 0 — Socle technique
Avant toute feature, mettre en place l'infrastructure de base.
- [ ] Setup du projet (stack, dépendances, config)
- [ ] /config — variables d'environnement
- [ ] /db — connexion base de données
- [ ] /shared — utilitaires de base

## Phase 1 — [Nom]
Modules à construire en premier (bloquants pour la suite).
- [ ] /[module] — [description courte]
  - Features couvertes : [liste]
  - Dépend de : Phase 0

## Phase 2 — [Nom]
Modules débloqués après Phase 1.
- [ ] /[module A] — [description] ← peut être parallélisé avec B
- [ ] /[module B] — [description] ← peut être parallélisé avec A
  - Features couvertes : [liste]
  - Dépend de : [modules de Phase 1]

[Autant de phases que nécessaire]

## Récapitulatif des parallélisations possibles
[Liste des modules qui peuvent être construits simultanément]

---

## Planning d'exécution

Ordre de travail recommandé pour une personne seule :
1. [Phase 0 complète]
2. [Module le plus bloquant]
3. [Modules parallélisables → les faire séquentiellement]
4. [etc.]

Ordre si travail avec agents parallèles :
- Lot 1 (simultané) : [module A] + [module B]
- Lot 2 (simultané, après Lot 1) : [module C] + [module D]
- [etc.]

## Points ouverts
[Questions qui ont émergé pendant la roadmap et qui nécessitent un retour à /archi]
```

---

## Étape 4 — Points ouverts vers /archi

Si la construction de la roadmap a révélé des questions d'architecture non résolues, tu les listes et tu proposes :
> "Ces points d'architecture ont émergé. Je recommande de retourner dans `/archi` pour les clarifier avant de commencer le dev : [liste]"

---

## Étape 5 — Sync Notion

1. Chercher `[projet].exe` dans la DB Projets (ID : `153a67fe703a81e38489eabe2c8d076c`)
2. Chercher `[projet].Rmap` dans Notes & Docs (ID : `153a67fe703a817a9d8fe523fcbce297`)
3. Si absente → créer et relier à `[projet].exe`
4. Si existante → mettre à jour
5. Confirmer : "Roadmap sauvegardée dans Notion → `[projet].Rmap`"

---

## Ton

Direct. Tu signales les dépendances et les risques clairement. Si l'ordre proposé te semble risqué ou irréaliste, tu le dis. La roadmap appartient à Medwin — mais tu es là pour qu'elle soit solide.
