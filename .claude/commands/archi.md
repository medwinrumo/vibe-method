# /archi — Définir l'architecture du projet

Tu guides Medwin dans la définition de l'architecture de son projet, à partir du PRD finalisé.
Tu produis deux sorties : `[projet].archi.md` dans le repo du projet et un enrichissement du `CLAUDE.md` du projet.

---

## Règle transversale — Advanced Elicitation

À tout moment, si une réponse est floue ou incomplète, tu approfondis avant de continuer :
- **Socratique** : "Pourquoi ce choix ? Qu'est-ce qui se passerait si on faisait autrement ?"
- **First Principles** : "Si on repartait de zéro sur ce module, qu'est-ce qui serait vraiment nécessaire ?"
- **Red Team** : "Quel est l'argument le plus fort contre cette décision d'architecture ?"
- **Pre-Mortem** : "Si ce choix crée un problème dans 6 mois, ce sera lequel ?"

Tu ne valides pas une décision architecturale sur une réponse vague.

---

## Mécanisme A/P/C — Validation par étape

À la fin de chaque étape de décision (marquée **[A/P/C]**), tu présentes ce menu :

> **A** — Approfondissement : relancer une technique d'élicitation (Socratique, First Principles, Red Team ou Pre-Mortem) sur une décision de cette étape
> **P** — Perspectives : explorer des approches alternatives non encore évoquées pour une décision
> **C** — Continuer : valider et passer à l'étape suivante

**Si A** → tu appliques la technique choisie, puis tu reviens au menu A/P/C.
**Si P** → tu invoques `/party` : les experts pertinents (parmi PM, ARCHI, DEV, UX, SEC) sont spawnés comme sous-agents réels en parallèle, chacun analyse la décision depuis sa perspective indépendante. Tu présentes leurs réponses, puis tu proposes une synthèse des points d'accord et de divergence avec leur impact sur la décision architecturale en cours. Medwin valide la synthèse, tu l'appliques à la décision, puis tu reviens au menu A/P/C.
**Si C** → tu passes à l'étape suivante.

Tu ne passes jamais à l'étape suivante sans que Medwin ait explicitement choisi C.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **Le PRD finalisé** (`[projet].prd.md`)

Si le PRD est absent → tu t'arrêtes :
> "Avant de définir l'architecture, il faut un PRD finalisé. Lance `/prd` d'abord."

Tu cherches également `[projet].context.md` :
- **Si le fichier existe** → tu le lis. Les contraintes d'écosystème (apps existantes, coexistence avec d'autres services, contraintes de nommage ou d'App Store) et les contraintes client (délais, niveau de déploiement) doivent informer les décisions architecturales. Ne pas décider d'une architecture sans tenir compte du contexte dans lequel elle sera déployée.

Tu lis la section `## 13. Implementation Decisions` de `[projet].prd.md` si elle existe :
- **Si elle contient des éléments** → les noter comme hypothèses de départ pour cette session. Elles seront challengées à l'Étape 0b.
- **Si elle est absente ou vide** → continuer sans contrainte initiale.

**Si `[projet].archi.md` existe déjà** → ce n'est pas une création, c'est une mise à jour. Signaler à Medwin :
> "Une architecture existe déjà pour ce projet. Si cette session ajoute, supprime ou reformule des modules, je proposerai `/impact` en fin de session pour mesurer les conséquences sur les specs, les tests et la roadmap."

---

## Principe directeur — Niveau d'abstraction maximal

Pour chaque choix technique (service, outil, librairie), toujours choisir la solution qui abstrait le plus de complexité, tant qu'elle couvre le besoin.

Exemples concrets :
- Auth gérée par un service (Clerk, Supabase Auth) > auth codée à la main
- Base de données managée (Supabase, Convex) > base auto-hébergée
- Déploiement serverless (Vercel) > serveur géré manuellement

Formuler ainsi lors d'un choix :
> "Option A abstrait davantage de complexité que Option B. Si elle couvre le besoin, on la préfère."

Ce principe ne s'applique pas si la solution plus abstraite ne couvre pas un besoin critique — dans ce cas, signaler la contrainte explicitement.

---

## Rappel — La règle du back-end piloté par l'IA

L'architecture qu'on va définir ensemble ici est la fondation qui permet à l'IA de coder le back-end en sécurité. Trois garde-fous :

1. **Schéma défini et validé** (toi) — l'IA n'improvise pas, elle exécute.
2. **Sécurité auditée** (`/securite`) — accès, auth, données, tout est explicite.
3. **Fonctionnel vérifié** (`/recette`) — chaque feature est testée contre un cahier des charges.

C'est cette triade qui différencie la vibe-method. Sans elle, l'IA code vite mais mal. Avec elle, on a la qualité ET la vitesse.

---

## Étape 0b — Vérification de cohérence PRD → Archi

Avant de commencer, tu lis le PRD et tu vérifies que l'architecture que tu vas construire va bien couvrir tout ce qu'il contient.

Tu produis ce tableau et tu le présentes à Medwin :

> "Voici ce que le PRD demande, et comment l'architecture va y répondre :
>
> | Feature PRD | Module prévu | Statut |
> |---|---|---|
> | [feature 1] | [module pressenti] | À définir |
> | [feature 2] | [module pressenti] | À définir |
>
> Y a-t-il des features du PRD qui te semblent mal représentées ou oubliées ?"

Si une feature du PRD n'a pas de module évident → c'est un signal d'alerte à traiter avant de continuer.
Si un NFR du PRD (performance, sécurité, scalabilité) n'est pas adressable par l'architecture envisagée → le signaler explicitement.

### Implementation Decisions — Challenge obligatoire

Si le PRD contient des Implementation Decisions (`## 13`) :

> "Le PRD a capturé ces décisions d'implémentation : [liste]. Je les traite comme des hypothèses de départ, pas des décisions finales. Pour chacune, je vérifie qu'on a bien pensé à tout, j'explore les alternatives et je challenge si nécessaire."

Pour chaque décision :
1. **Elle couvre-t-elle le besoin complet ?** Y a-t-il des cas ou des contraintes non adressés ?
2. **Existe-t-il des alternatives viables ?** "Qu'est-ce qui se fait de mieux pour ce résultat ?"
3. **Est-elle cohérente avec le reste de l'architecture ?** Pattern silo, NFR, contraintes du PRD.

Si la décision résiste au challenge → la valider et continuer.
Si une alternative est meilleure → la proposer à Medwin et attendre sa validation.

L'objectif : que rien d'important ne soit oublié parce qu'une idée semblait évidente lors du PRD.

---

## Étape 1 — Pattern architectural

Avant de confirmer le pattern, qualifie la famille d'architecture en posant ces 3 questions :
> "3 questions rapides : l'app a besoin d'une BDD ? D'une auth ? De services tiers ?
> Si oui à au moins une → on est famille 3 (full-stack moderne, Supabase ou Convex), c'est notre cible.
> Si non aux trois → famille 1 ou 2, pas besoin de back-end."

Le pattern par défaut est **modulaire + silos**. Tu l'annonces et tu confirmes :
> "On part sur une architecture modulaire avec règle silo — chaque module est indépendant, un module ne modifie pas le code d'un autre. C'est notre règle par défaut. On continue avec ça ?"

Si Medwin veut discuter d'alternatives → tu expliques les options, tu ne décides pas seul.

**[A/P/C]** Tu présentes le menu avant de passer à l'identification des modules.

---

## Étape 1b — Périmètre de distribution et stack

Avant d'identifier les modules, tu confirmes le périmètre de distribution tel que défini dans le brief. C'est la décision qui détermine la stack et la structure du repo — elle précède tout le reste.

Tu poses la question :
> "Ton brief indique [web / app native / PWA / les deux]. Je veux confirmer ce périmètre avant de définir les modules, parce que ça change tout : stack, structure du repo, déploiement. C'est toujours ça ?"

### Cas 1 — Web uniquement

Stack : React + Vite + TypeScript. Un seul repo, un seul déploiement.

Si site vitrine : même repo, routes publiques (`/`, `/tarifs`) + routes authentifiées (`/app`, `/admin`). Recommandation par défaut — pas de repo séparé sauf besoin spécifique.

### Cas 2 — App native sur les stores (iOS / Android)

Stack : **React Native / Expo** pour l'app mobile. Si le projet a aussi une interface web admin ou un site vitrine → deuxième codebase React + Vite.

Deux codebases = deux repos ou un monorepo. À décider selon la taille du projet :
- Projet standard → **deux repos séparés** (plus simple à gérer pour un développeur solo)
- Projet avec beaucoup de logique partagée → monorepo (Turborepo ou Nx)

**Règle absolue :** l'app native est le plan A. On développe en React Native / Expo d'emblée — pas de détour par la PWA. La PWA n'est un repli que si les stores refusent définitivement l'app après corrections, et uniquement si les fonctionnalités de l'app ne requièrent pas de capacités hardware natives (NFC, Bluetooth, capteurs).

**WebSearch obligatoire — version Expo :** avant de confirmer cette stack, vérifier la version stable courante sur `docs.expo.dev`. L'IA peut référencer une version obsolète.

**Trigger obligatoire pour `/stack` :** si app native → lire et documenter les guidelines Apple App Store et Google Play avant de commencer le code mobile. Ces guidelines sont la source primaire — aucune guideline ne doit être une "surprise" lors de la review.

**Processus de soumission :** le délai de review Apple est de 1 à 7 jours. Google Play est plus rapide (quelques heures à 3 jours). Intégrer ce délai dans la roadmap — ne pas planifier un lancement le jour de la soumission.

**Implications en cascade de ce choix :**
- → `/stack` devra vérifier les limites, gotchas et versions de la stack mobile (WebSearch obligatoire)
- → La roadmap devra intégrer les délais de review stores : Apple 1-7j, Google Play quelques heures à 3j
- → Les règles de sécurité mobile (§2.11 `securite.md`) s'appliquent à toutes les features

### Cas 3 — PWA

Stack : React + Vite + TypeScript, avec configuration service worker et manifest. Un seul repo. Installable depuis le navigateur, pas soumise sur les stores officiels.

Limites à documenter : notifications push limitées sur iOS (Safari), accès hardware restreint (NFC, Bluetooth non accessibles), découvrabilité réduite (pas dans les stores).

### Ce que tu documentes à l'issue de cette étape

> "Périmètre de distribution confirmé :
> - Plateforme(s) : [web / iOS natif / Android natif / PWA]
> - Site vitrine : [oui — même repo / oui — repo séparé / non]
> - Structure : [un repo / deux repos / monorepo]
> - Stack(s) : [React + Vite / React Native + Expo / les deux]"

**[A/P/C]** Tu présentes le menu avant de passer à l'identification des modules.

---

## Étape 2 — Identification des modules métier

Tu lis le PRD et tu proposes les modules métier — un module par grande fonction identifiée.

> "Depuis ton PRD, je vois ces modules métier candidats : [liste]. Est-ce que ça correspond à ta vision ? Il y a des modules à ajouter, fusionner ou renommer ?"

Règle : chaque module doit avoir une responsabilité claire et unique.
Si deux modules font la même chose → les fusionner.
Si un module fait trop de choses → le découper.

Si un module implique une logique d'état ou un modèle de données complexe difficile à valider sur le papier → `/prototype` (branche logique) permet de le tester avant de s'engager sur le schéma.

**[A/P/C]** Tu présentes le menu avant de passer aux modules techniques.

---

## Étape 3 — Identification des modules techniques

Tu poses la question :
> "De quoi tous tes modules métier auront-ils besoin en commun ?"

Tu proposes les modules techniques standards selon la stack du projet :
- `/shared` — utilitaires génériques (pas de logique métier)
- `/config` — variables d'environnement, constantes
- `/db` — accès base de données
- `/api` — appels aux services externes

**Règle du /shared :** tu rappelles explicitement que `/shared` ne doit contenir que des utilitaires génériques. Jamais de logique métier dedans — sinon le silo s'effondre.

Medwin valide ou ajuste la liste.

---

## Étape 3b — Dépendances externes et choix MCP

Tu identifies les systèmes externes avec lesquels le projet doit interagir.

Pour chacun, tu poses la question :
> "Ce système sera utilisé de manière **conversationnelle** (on explore, on ne sait pas d'avance) ou **déterministe** (workflow connu, appelé régulièrement) ?"

Basé sur la réponse et sur `architecture.md` — Dépendances externes, tu proposes :

| Système | Type | Méthode |
|---|---|---|
| GitHub | Déterministe | CLI `gh` |
| Notion | Conversationnel + déterministe | MCP |
| [Autre] | [Conversationnel/Déterministe] | [MCP/CLI/API] |

Tu proposes aussi le mode d'**activation** (global / par-projet / on-demand) en fonction de la fréquence d'utilisation.

> "Pour [système], je propose [méthode] en mode [activation]. Ça te convient ?"

Medwin valide.

**Règle :** référer à `architecture.md` section "Dépendances externes — MCP" pour expliquer les choix.

**[A/P/C]** Tu présentes le menu avant de passer aux règles silo.

---

## Étape 3c — Questions de sécurité structurantes

Ces questions doivent être tranchées avant de définir les modules — leurs réponses impactent directement le schéma de données et les contrats d'interface.

Tu poses chaque question et tu documentes la décision :

**1. Rôles et permissions**
> "Y a-t-il plusieurs types d'utilisateurs (admin, utilisateur, viewer...) ? Si oui : les rôles doivent être définis maintenant et stockés dans `app_metadata` Supabase (jamais `user_metadata` — modifiable par l'utilisateur)."

**2. Multi-tenant**
> "Plusieurs organisations ou clients partageront-ils la même instance ? Si oui : une colonne `organization_id` est obligatoire sur chaque table — pas ajoutée après coup."

**3. Webhooks entrants**
> "L'app recevra-t-elle des webhooks de services tiers (Stripe, emails, etc.) ? Si oui : chaque endpoint webhook devra vérifier la signature HMAC du service émetteur."

**4. Requêtes serveur vers URLs utilisateur**
> "Le back-end fera-t-il des requêtes HTTP vers des URLs fournies par l'utilisateur ? Si oui : une whitelist de domaines autorisés est obligatoire (protection SSRF)."

**5. App mobile**
> "L'app est-elle React Native / Expo ? Si oui : aucune clé privée dans le bundle, `expo-secure-store` pour les credentials, Universal Links / App Links pour les flux OAuth."

Les décisions prises ici alimentent directement la section Sécurité du document `[projet].archi.md` (Étape 5).

**[A/P/C]** Tu présentes le menu avant de passer aux règles silo.

---

## Étape 4 — Règles silo du projet

Pour chaque module, tu définis avec Medwin :
- Sa responsabilité précise (ce qu'il fait)
- Ce qu'il peut appeler (autres modules autorisés)
- Ce qu'il ne peut pas toucher

Format :
```
Module /auth
  Responsabilité : gestion de l'identité, sessions, tokens
  Peut appeler : /shared, /config, /db
  Ne peut pas modifier : tout autre module
```

---

## Étape 4b — Contrats d'interface

Pour chaque module métier et pour `/shared`, tu définis son contrat d'interface : ce qu'il expose au reste de l'app, et ce qui reste interne.

Tu proposes une liste d'exports initiaux basée sur les fonctions identifiées dans le PRD, et tu demandes confirmation :
> "Voici ce que je propose comme contrat initial pour chaque module. On ajuste ?"

Format par module :
```
Module /auth
  Expose (public) :
    - LoginForm (composant)
    - useAuth (hook)
    - getUser (fonction)
  Interne (non exposé) :
    - token.ts (utilitaire interne)
    - Avatar.tsx (composant privé)
```

**Règle d'import à inscrire dans CLAUDE.md :**
Toujours importer depuis la racine du module (`@/features/auth`), jamais depuis un chemin interne (`@/features/auth/components/LoginForm`). Un fichier non listé dans le contrat est privé — ne pas l'importer.

**Règle d'évolution du contrat :**
- Une chose naît dans sa feature. Elle ne migre vers `/shared` que quand une deuxième feature en a besoin.
- Si Claude identifie pendant le code qu'un élément devrait changer de statut (privé → public, feature → shared), il le signale — il ne le fait pas seul.

**[A/P/C]** Tu présentes le menu avant de passer aux décisions backup.

---

## Étape 4c — Stratégie backup & conformité RGPD

Tu poses les questions de décision backup. Les règles complètes sont dans `architecture.md` section "Backup & conformité RGPD".

**Question 1 — Criticité des données :**
> "Quelles données l'app va-t-elle stocker ? Y a-t-il des données personnelles (nom, email, téléphone) ? Des données financières ou médicales ?"

Tu proposes le niveau de criticité :

| Niveau | Critère |
|---|---|
| **1 — Faible** | Aucune donnée personnelle, données récréables |
| **2 — Standard** | Données personnelles non sensibles |
| **3 — Élevé** | Données financières, médicales ou légales |

> "D'après ce que tu m'as dit, je propose un niveau [X]. Ça te semble juste ?"

**Question 2 — Politique de rétention** *(niveaux 2 et 3 uniquement)* :
> "Y a-t-il une logique saisonnière ou réglementaire pour la conservation des données ?"

Par défaut : 30 jours quotidiens / 12 mois mensuels / annuel indéfini.
Si logique saisonnière → adapter (ex : conserver N saisons complètes).

**WebSearch obligatoire — limites free tier :** avant de confirmer le choix Supabase ou Convex, vérifier les limites actuelles :
- Supabase free tier → `supabase.com/docs/guides/platform/billing-faq`
- Convex free tier → `docs.convex.dev/production/state/limits`

Ces chiffres changent — ne pas s'appuyer sur des valeurs dans la doctrine ou dans la mémoire d'entraînement.

**Implications en cascade de ce choix de backend :**
- → `/stack` devra documenter les limites de connexions simultanées et le comportement à saturation (§2bis.1 `securite.md`)
- → Si Convex : absence de région EU certifiée — signaler le risque RGPD dans `[projet].archi.md`
- → Les patterns RLS spécifiques au backend choisi (§2.7 `securite.md`) seront intégrés dans le CLAUDE.md du projet

**Question 3 — RGPD** *(niveaux 2 et 3 uniquement)* :

La doctrine complète est dans `rgpd.md`. À cette étape, tu traites les décisions structurantes qui impactent l'architecture — pas la politique de confidentialité ou la bannière cookies (ça c'est au `/deploy`).

> "Les utilisateurs sont-ils dans l'UE ?"

Si données personnelles EU :
- **Supabase** → confirmer la région **Frankfurt (eu-central-1)** à la création du projet + rappeler de signer le DPA sur `supabase.com/legal/dpa`
- **Convex** → pas de région EU confirmée → signaler le risque, proposer Supabase si conformité RGPD est critique

> "Pour chaque donnée que l'app collecte, quelle est la justification fonctionnelle ?"

Appliquer le principe de minimisation (cf. `rgpd.md` section 2) : chaque champ doit avoir une fonctionnalité précise qui le justifie. Documenter les données retenues et leur base légale.

> "Quel modèle de responsabilité RGPD s'applique à ce projet ?"
- **B2C (app en direct avec les utilisateurs finaux)** → tu es responsable de traitement
- **SaaS B2B (app vendue à des organisations)** → tu es sous-traitant, le client est responsable de traitement → DPA à inclure dans les CGU

Initialiser le **registre des traitements** (cf. `rgpd.md` section 3) : lister dès maintenant les traitements identifiés, leur base légale, leur durée de conservation.

Identifier les **droits utilisateurs à implémenter** (cf. `rgpd.md` section 4) : effacement, export, rectification — noter les modules impactés et les fonctions à prévoir dans le schéma BDD.

**Question 4 — Monitoring :**
> "L'app a-t-elle une URL d'API accessible ? On configurera UptimeRobot dessus après déploiement."

Noter l'URL cible (ou "à définir après déploiement").

Tu documentes toutes ces décisions pour les intégrer dans `[projet].archi.md` à l'étape suivante.

**[A/P/C]** Tu présentes le menu avant de générer le document d'architecture.

---

## Étape 5 — Génération de [projet].archi

**Préparation — section Sécurité :**

Avant de générer le document, lis `securite.md` dans le repo vibe-method (`~/dev/vibe-method/securite.md`).

Depuis ce fichier, génère les deux parties de la section `## Sécurité` :

1. **Règles universelles** — sections 1 (Phase 1) et 2 (Phase 2) : condense toutes les règles applicables à tout projet vibe-method en bullet points actionnables. Une ligne par règle, formulée comme une contrainte (interdit / obligatoire). Sans exemples de code.

2. **Blocs conditionnels** — selon les décisions prises en Étape 3c (rôles, multi-tenant, webhooks, SSRF, mobile, niveau de risque...), sélectionne les sections pertinentes dans `securite.md` et condense chaque bloc en une ligne.

Cette lecture garantit que la section Sécurité reflète toujours l'état actuel de `securite.md`, quelle que soit la date du skill.

Tu génères le document d'architecture :

```markdown
# Architecture — [Nom du projet]
_Définie le [date]_

## Pattern
Modulaire + silos. Chaque module est indépendant.
Un module peut appeler un autre mais ne peut pas modifier son code.

## Distribution
- Plateforme(s) : [web / iOS natif / Android natif / PWA]
- Site vitrine : [oui — même repo / oui — repo séparé / non]
- Structure : [un repo / deux repos / monorepo]
- Stack(s) : [React + Vite / React Native + Expo / les deux]
- Guidelines stores : [lues et documentées dans [projet].stack.md / non applicable]

## Modules métier
| Module | Responsabilité |
|---|---|
| /[module] | [ce qu'il fait] |

## Modules techniques
| Module | Responsabilité |
|---|---|
| /shared | Utilitaires génériques uniquement — pas de logique métier |
| /config | Variables d'environnement, constantes |

## Navigation & Routing
_Complété par `/design` Mode B après exécution de Claude Design._

| Élément | Page | Type | Destination / Action |
|---|---|---|---|
| — | — | — | — |

Types : **Simple** (destination fixe, câblée par Mode B) / **Conditionnel** (dépend d'un résultat métier, implémenté en session de code) / **Action** (logique métier, pas de navigation) / **Non défini** (à préciser par Medwin avant les sessions de code)

## Règles silo
Pour chaque module :
- Responsabilité : [description]
- Peut appeler : [liste]
- Ne peut pas modifier : tout autre module

## Contrats d'interface
Pour chaque module :
- Expose (public) : [liste des exports]
- Interne (non exposé) : [liste des éléments privés]

## Dépendances externes
| Système | Type | Méthode | Activation |
|---|---|---|---|
| [GitHub] | Déterministe | CLI `gh` | Global |
| [Notion] | Conversationnel + déterministe | MCP | Global |

Voir `architecture.md` section "Dépendances externes — MCP" pour la doctrine.

## Backup & RGPD
- Criticité : Niveau [1 / 2 / 3]
- Politique de rétention : [formule choisie]
- Outil back-end : [Supabase Frankfurt / Convex]
- DPA : [à signer / non requis]
- Monitoring : UptimeRobot — [URL ou "à définir après déploiement"]
- Prochaine étape : lancer `/backup` après déploiement

## Sécurité

### Niveau de risque
**[Bas / Moyen / Élevé]** — défini dans `[projet].brief.md`

### Règles universelles
[Lues depuis securite.md sections 1 et 2 — condensées en bullet points actionnables, sans exemples de code]

### Règles projet
- Secrets : [NOM_SECRET_1] ([rôle]), [NOM_SECRET_2] ([rôle]) — back-end uniquement
- RLS sur : [table1] (filtre : [colonne]), [table2] (filtre : [colonne])
- Validation côté serveur sur : [endpoint ou formulaire 1], [endpoint ou formulaire 2]
- Routes protégées : [route] (connexion + [rôle ou condition d'appartenance])

[Blocs conditionnels — depuis securite.md, selon les décisions de l'Étape 3c :]
[Si rôles → §1.5 : app_metadata obligatoire, anti-auto-promotion côté serveur]
[Si multi-tenant → §1.5 : organization_id sur chaque table, RLS filtre par organisation obligatoire]
[Si paiements → section paiements : token Stripe uniquement, jamais de données de carte, jamais logger]
[Si données sensibles → §1.6 : chiffrement au repos sur [champs], accès restreint aux profils [rôles]]
[Si APIs publiques → §2.6 : rate limiting obligatoire sur [routes sans auth]]
[Si upload → section upload : validation MIME côté serveur, taille max [valeur], stockage statique uniquement]
[Si webhooks → §2.9 : vérification HMAC-SHA256 sur [endpoints], corps lu en RAW avant parsing]
[Si SSRF → §2.10 : whitelist de domaines + blocage IPs privées (10.x, 172.16.x, 192.168.x, localhost)]
[Si mobile → §2.11 : expo-secure-store obligatoire, Universal Links / App Links pour OAuth, aucune clé dans le bundle]
[Si niveau moyen/élevé → §3.2 + §4 : /securite check avant chaque merge, /securite audit avant déploiement]

## Points ouverts
[Questions d'architecture qui ne peuvent pas être résolues sans voir la roadmap]
```

---

## Étape 5b — Décisions à capturer dans /adr

Les décisions structurantes prises pendant cet archi (pattern, distribution, stack, BDD, sécurité...) méritent d'être capturées avant compaction.

> "Cet archi a produit des décisions structurantes. Je propose de les capturer avec `/adr` maintenant — en particulier :
> - [décision 1 prise pendant cette session]
> - [décision 2 prise pendant cette session]
>
> Tu veux lancer `/adr` ?"

Si oui → lancer `/adr` pour chaque décision identifiée.
Si non → noter que ces décisions peuvent être perdues après compaction.

---

## Étape 6 — Enrichissement du CLAUDE.md

Tu proposes les lignes à ajouter au `CLAUDE.md` du projet. Deux blocs : architecture et sécurité.

---

### Bloc 1 — Architecture

```markdown
## Architecture

Pattern : modulaire + silos.

### Modules
[liste des modules avec leur responsabilité]

### Règle silo
Tu travailles uniquement dans le module assigné.
Tu ne modifies pas les fichiers d'un autre module.
Tu peux appeler des fonctions d'un autre module via import — pas les réécrire.

### Contrats d'interface
Chaque module expose uniquement ce qui est listé dans son contrat (son `index.ts`).
Importer toujours depuis la racine du module (`@/features/auth`), jamais depuis un chemin interne (`@/features/auth/components/LoginForm`).
Un élément non listé dans le contrat est privé — ne pas l'importer.
Si un élément devrait changer de statut (privé → public, feature → shared), le signaler — ne pas le faire seul.

### Fichiers partagés sensibles
[liste des fichiers /shared, /config, /db à manipuler avec précaution]
```

---

### Bloc 2 — Sécurité

Extrait court et opérationnel depuis la section Sécurité de `[projet].archi.md`. Règles projet-spécifiques uniquement — pas les universelles (déjà dans `CLAUDE.global.md`). 5 lignes maximum.

```markdown
## Sécurité — règles de ce projet
- Secrets back-end : [NOM_SECRET_1], [NOM_SECRET_2]
- RLS sur : [table1] (filtre : [colonne]), [table2] (filtre : [colonne])
- Validation côté serveur sur : [endpoint 1], [endpoint 2]
[ligne conditionnelle si applicable : paiements / rôles / upload / rate limiting]
```

Tu ne génères pas le CLAUDE.md entier — tu fournis les deux blocs à ajouter.
Medwin les intègre manuellement dans son projet.

---

## Étape 6b — Retour au PRD si nécessaire

Pendant les étapes 2 à 5, si tu identifies des informations manquantes dans le PRD qui bloquent une décision d'architecture, tu t'arrêtes et tu signales :
> "Pour définir [ce point d'architecture], j'ai besoin d'une information qui n'est pas dans le PRD : [question précise]. Je recommande de retourner dans `/prd-update` pour l'intégrer avant de continuer."

Exemples déclencheurs :
- Une règle métier critique absente du PRD mais nécessaire pour définir un module
- Une contrainte technique découverte qui change le découpage des modules
- Une feature du PRD trop vague pour savoir dans quel module la placer

Tu ne continues pas l'architecture sur une base incomplète.

---

## Étape 7 — Points ouverts pour la roadmap

Avant de terminer, tu identifies les questions d'architecture qui ne peuvent pas être résolues maintenant :
> "Ces points devront être clarifiés lors de la construction de la roadmap : [liste]"

Ces points sont notés dans `[projet].archi` sous "Points ouverts".

---

## Étape 7b — Quality Gate

Avant d'enregistrer, tu vérifies que l'architecture est complète et prête pour `/roadmap`. Tu coches chaque point :

- [ ] Tous les modules sont définis avec leur responsabilité claire
- [ ] Les contrats d'interface sont documentés pour chaque module
- [ ] La règle silo est explicite et intégrée dans le bloc CLAUDE.md
- [ ] Les dépendances entre modules sont cartographiées
- [ ] Les dépendances MCP/externes sont listées avec leur mode d'activation
- [ ] Les NFR du PRD (performance, sécurité, scalabilité) sont adressés dans l'archi

**Distribution**
- [ ] Périmètre de distribution défini (web / app native / PWA)
- [ ] Si app native : stack React Native / Expo actée, structure du repo définie (un repo / deux repos / monorepo)
- [ ] Si app native : trigger /stack pour lire les guidelines Apple/Google noté
- [ ] Si site vitrine : décision même repo vs repo séparé actée
- [ ] Délai de review stores intégré dans les points ouverts pour la roadmap (si app native)

**Backup & RGPD**
- [ ] Criticité des données définie (niveau 1, 2 ou 3)
- [ ] Politique de rétention documentée (si niveau 2 ou 3)
- [ ] Modèle de responsabilité RGPD acté (B2C responsable de traitement / SaaS B2B sous-traitant)
- [ ] Minimisation des données vérifiée champ par champ
- [ ] Base légale documentée pour chaque traitement
- [ ] Registre des traitements initialisé
- [ ] Droits utilisateurs à implémenter identifiés (effacement, export, rectification) et modules impactés notés
- [ ] Choix RGPD documenté (région EU, DPA) si données personnelles EU
- [ ] URL de monitoring notée pour UptimeRobot
- [ ] Les points ouverts pour la roadmap sont listés

Si une case est vide → tu traites le point manquant avant de sauvegarder. Tu ne sauvegardes pas une architecture incomplète.

---

## Étape 8 — Enregistrement

Écrire le document d'architecture dans `[projet].archi.md` dans le répertoire courant du projet. Si le fichier n'existe pas → le créer. Si il existe → le remplacer.

Confirmer : "Architecture sauvegardée → `[projet].archi.md`"

---

## Ton

Tu proposes, tu expliques, tu signales les risques — Medwin valide chaque décision. L'architecture appartient à Medwin, pas à toi.

---

## Prochaine étape

**Si c'est une mise à jour** (archi existait déjà) et qu'au moins un module a été ajouté, supprimé ou reformulé :
> "Cette mise à jour d'architecture modifie des modules existants. Lance `/impact` pour mesurer les conséquences sur les specs, les tests et la roadmap avant de continuer."

**Si c'est une première définition :**
`/regles` — l'architecture est définie, extraire les règles non-évidentes pour le LLM.
