---
type: doctrine
source: ../architecture.md
source_modified: 2026-05-14
wiki_updated: 2026-05-26
tags: [architecture, modules, silos, stack, backup]
---

# Doctrine — Architecture

## En une ligne
Contexte minimal donné à l'IA = IA performante et fiable.

---

## Principe fondateur

Plus le contexte donné à l'IA est petit et ciblé, plus elle est performante.
Toutes les décisions découlent de ce principe : modules isolés, fichiers bien délimités, CLAUDE.md ciblé.

---

## 4 familles d'architecture

| Famille | Description | Cible |
|---|---|---|
| 1 — Statique | HTML/CSS pur | CV, landing |
| 2 — Front dynamique | Logique navigateur, pas de persistance | Simulateur, jeu |
| **3 — Full-stack moderne ✅** | Front + back no-code (Supabase, Convex) | **Tous les projets vibe-method** |
| 4 — Complexe | API custom + BDD + Auth + logique métier | Faire appel à un pro |

---

## Concepts actés

**Architecture modulaire** : chaque feature = un module quasi-autonome.

**Architecture en silos** : un module peut appeler les fonctions d'un autre — il ne peut pas modifier son code.

**Modules métier** (viennent des features) : `/auth`, `/profil`, `/paiement`, `/notifications`

**Modules techniques** (infrastructure) : `/shared`, `/config`, `/db`, `/api`

**CLAUDE.md par projet** : carte des modules + règles silo + conventions. Créé par [[skills/archi]], mis à jour à chaque décision.

---

## Stacks de référence

**Distribution :**
- Web : React + Vite + TypeScript + Vercel
- PWA : idem + Service Worker
- Native : React Native + Expo + TypeScript + NativeWind

**Back-end :**
- Stack A — Convex : real-time natif (chat, collaboration)
- Stack B — Supabase : projets standards (relationnel + auth + storage)

Le choix est documenté et justifié dans `[projet].archi.md`.

---

## Mise en production — 6 couches

1. Front → Vercel (auto sur push)
2. Back-end/BDD → cloud natif (Supabase/Convex)
3. Variables d'environnement → Vercel Dashboard, jamais dans le code
4. Migrations BDD → versionnées, avec rollback si niveau 3
5. Domaine → registrar + DNS Vercel
6. Monitoring → Sentry + UptimeRobot (niveau 2+)

**3 niveaux :** Proto (1), App client standard (2), App critique (3)

---

## MCP — règle de décision

| Approche | Quand |
|---|---|
| MCP | Workflow conversationnel, exploratoire |
| CLI (`gh`) | Workflow déterministe, connu d'avance |
| API directe | Haute-fréquence, performances critiques |

---

## Règles non-négociables

- **Modulaire + silos** = règle par défaut sur tous les projets
- **`/shared` = utilitaires génériques uniquement** — jamais de logique métier
- **Niveau d'abstraction maximal** : Vercel > VPS, Supabase > base auto-hébergée
- **Contexte minimal** : CLAUDE.md + module ciblé + spec — pas tout le projet
- **Backup obligatoire dès le niveau 2** (données personnelles)
- **RLS activé dès la création** de chaque table Supabase (désactivé par défaut)

## Liens
[[skills/archi]] | [[skills/backup]] | [[skills/deploy]] | [[doctrines/securite]]
