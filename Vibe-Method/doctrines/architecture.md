---
type: doctrine
source: ../../architecture.md
source_modified: 2026-08-03
wiki_updated: 2026-08-05
tags: [architecture, modules, silos, stack, backup, api-design, deprecation, dépendances-environnement]
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

## Conception d'API et d'interfaces

Comparaison `addyosmani/agent-skills` (2026-07-28). **Loi de Hyrum** : avec assez d'utilisateurs, tout comportement observable devient un contrat de fait — ne pas exposer de détail d'implémentation qu'on n'est pas prêt à maintenir. **Règle de la version unique** : ne jamais forcer plusieurs versions d'une même dépendance en simultané.

Process : contrat avant implémentation → sémantique d'erreur cohérente → valider aux frontières → additionner plutôt que modifier → nommage prévisible (REST sans verbe, camelCase, `is`/`has`/`can` pour les booléens).

## Deprecation et migration

Comparaison `addyosmani/agent-skills` (2026-07-28). Complète le Brownfield de [[doctrines/methode]]. **Le code est un passif** — sa valeur vient de la fonctionnalité rendue, pas du code lui-même. 5 questions avant de déprécier : valeur restante ? utilisateurs actifs ? remplaçant existant ? coût de migration ? coût de maintien ?

Advisory (optionnel) vs Compulsory (sécurité/deadline, outillage de migration obligatoire). Patterns : Strangler, Adapter, Feature Flag, Expand/Contract. Jamais de renommage/suppression en place — toujours *expand* puis *contract*.

---

## Dépendances d'environnement — la question n'est pas « survit-elle ? » (2026-08-03)

Tout ce dont le code a besoin sans l'avoir déclaré : polices, locales, fuseaux, dictionnaires, encodages, certificats, résolveurs DNS, binaires système, venv installés à chaud.

**La bonne question n'est pas « est-ce que ça survit à un redéploiement ? » mais « comment se manifeste son absence ? »**

| Famille | En cas d'absence | Risque |
|---|---|---|
| **Panne franche** | Erreur levée : `ModuleNotFoundError`, `command not found` | Borné — visible, donc traité |
| **Repli silencieux** | Substitution automatique, dégradation muette | **Élevé** — résultat *plausible mais faux*, aucune alerte |

Cas vécu (03/08/2026, Hermes) : un PDF contractuel généré par weasyprint dépendait de polices installées dans une couche non persistante. Après recreate, **aucune erreur** — fontconfig substituait une autre police, le PDF se générait, mais ses métriques changeaient (19 196 octets au lieu de 19 128). Une maquette validée serait partie chez un client modifiée, sans signal. Le venv Python manquant au même endroit levait une erreur franche : c'était le cas facile.

Trois règles : **inventorier avant de conclure** (quand un correctif est motivé par « X sera détruit », lister *tout* ce que X contient) ; **toute dépendance installée à chaud va dans un emplacement persistant**, sinon un mécanisme de réinstallation fait partie du livrable ; **pour chaque dépendance à repli silencieux, définir une commande de contrôle** (`fc-match`, `locale -a`, `date +%Z`) placée dans la documentation d'exploitation.

Voir [[skills/diagnostic-serveur]], qui opérationnalise ces règles.

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
