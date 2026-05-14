# Guide de réflexion — Définir un outil et ses features

Cheminement mental à avoir avant et pendant la phase produit.
Certaines étapes se font avant d'ouvrir Claude Code, d'autres se font avec lui.

---

## Phase 1 — Le problème (avant tout outil, papier + crayon)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 1 | Quelle est la douleur concrète aujourd'hui ? Décris ce qui se passe **sans** l'app. | Une phrase de problème brut |
| 2 | Reformule en précis : qui souffre, de quoi, à quelle fréquence, avec quelle conséquence ? | Le problème précis |
| 3 | Quels sont les 2-4 aspects distincts de ce problème ? | Liste de sous-problèmes |
| 4 | Si tu devais résumer le succès en **une seule phrase du point de vue de l'utilisateur**, ce serait quoi ? | La boussole du projet |

> Règle : si tu ne peux pas répondre à la question 4, les questions 1-3 ne sont pas assez précises. Recommence.

---

## Phase 2 — Les utilisateurs (papier)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 5 | Qui utilise l'app ? (visiteur, utilisateur connecté, admin, système) | Liste des acteurs |
| 6 | Dans quel contexte chaque acteur l'utilise-t-il ? (mobile en déplacement, desktop au bureau, urgence…) | Contexte d'usage par acteur |
| 7 | Quel est le niveau technique de chaque acteur ? | Contrainte d'interface |
| 8 | Quel est ton rôle à toi : client, dev, utilisateur, ou les trois ? | Clarté sur les conflits d'intérêt |

---

## Phase 3 — Les user flows (papier, boîtes et flèches)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 9 | Pour chaque acteur : d'où arrive-t-il ? Que fait-il ? Que voit-il ? Où va-t-il ensuite ? | Parcours dessiné par acteur |
| 10 | Quels sont les points de friction — où l'utilisateur peut se perdre, se bloquer, faire une erreur ? | Liste de risques UX |
| 11 | Quels cas particuliers surgissent en dessinant ? (accès sans droits, données manquantes, action impossible…) | Premiers cas limites |

> Ces questions qui surgissent en dessinant sont de l'or. Note-les — elles deviendront des règles de gestion.

---

## Phase 4 — Les features (avec `/brief` puis `/prd`)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 12 | Quelles fonctions sont **indispensables** pour que la boussole (question 4) soit atteinte ? | Features V1 |
| 13 | Quelles fonctions seraient bien mais ne bloquent pas l'objectif principal ? | Features V2+ |
| 14 | Qu'est-ce que cet outil ne fera **pas** ? (hors-scope explicite) | Non-fonctions |
| 15 | Pour chaque feature V1 : quelle est la règle métier — le comportement attendu dans le cas normal ? | Règles de gestion |
| 16 | Pour chaque feature V1 : qu'est-ce qui peut mal se passer ? (données incorrectes, droits insuffisants, service indisponible) | Cas d'échec |

---

## Phase 5 — Les contraintes (avec `/prd`)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 17 | L'app a-t-elle besoin d'une base de données ? D'une authentification ? De services tiers ? | Choix d'architecture |
| 18 | Web, mobile, ou les deux ? App Store ou pas ? | Type de projet |
| 19 | Quel temps de chargement est acceptable ? Y a-t-il des données sensibles ? Des besoins d'accessibilité ? | NFR |
| 20 | Combien d'utilisateurs au lancement ? Dans 1 an ? | Contrainte de scalabilité |

---

## Phase 6 — Le succès (avec `/prd`)

| # | Question à te poser | Ce que tu produis |
|---|---|---|
| 21 | Comment sauras-tu que l'app est un succès ? Qu'est-ce qui doit se passer pour te dire "ça marche" ? | Métriques de succès |

---

## Où chaque phase s'exécute

```
Questions 1-11   → Papier, crayon, avant Claude Code
Questions 12-16  → /brief → /prd (dialogue guidé)
Questions 17-20  → /prd (Étapes 2 et 4b)
Question 21      → /prd (Étape 4)
```
