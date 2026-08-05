---
description: Du brief à la proposition commerciale — qualification client, estimation par phases et par blocs de développement
---

# /devis — Du brief à la proposition commerciale

**Miroir côté Hermes** : `devis-generation` (`/opt/data/skills/productivity/devis-generation/SKILL.md`, VPS) reproduit cette même logique pour que Hermes puisse qualifier un client et préparer une proposition sans passer par Claude Code — en s'appuyant sur son propre MCP Exa, déjà actif en permanence (pas besoin de la préparation `/mcp` de cette version). Deux fichiers de procédure séparés, pas de synchro automatique. Toute évolution de la logique ci-dessous doit être répercutée dans le skill Hermes.

Tu génères `[projet].proposition.md` — une proposition commerciale prête à personnaliser et envoyer au client.

---

## Étape 0 — Lecture des fichiers existants

Tu cherches `[projet].context.md` et `[projet].brief.md` dans le répertoire courant.

- **Si les deux sont absents** → tu t'arrêtes : "Lance `/contexte` puis `/brief` avant de générer une proposition."
- **Si seul le brief est absent** → tu t'arrêtes : "Lance `/brief` d'abord."
- **Si les deux existent** → tu les lis intégralement et tu résumes :

> "Voici ce que j'ai compris :
> **Client** : [nom, secteur, ce qu'on sait]
> **Projet** : [ce qu'on construit, les blocs clés]
> **Contraintes** : [délai, budget mentionné]
> **Modèle** : [M1 / M2 / M3 — si défini dans le brief]
> **Architecture légère** : [stack + services tiers + coûts récurrents — si définis dans le brief]
> C'est correct avant qu'on avance ?"

Tu ne passes à la suite qu'après confirmation explicite.

---

## Étape 1 — Qualification client

Objectif : déterminer si ce prospect est prioritaire pour une offre d'application sur-mesure / Notion / automatisation / tableau de bord, identifier ses douleurs probables, ses signaux d'achat, sa maturité digitale, et produire un angle de prise de contact concret.

**Avant de commencer**, dis à Medwin :
> "Lance `/mcp` et connecte `exa`. Dis-moi quand c'est fait."

Tu attends la confirmation avant de lancer la recherche.

---

### Brief de recherche pour `exa:search`

Soumet ce brief complet à `exa:search` en adaptant `[Nom client]`, `[ville]`, `[secteur]`, `[Nom fondateur]` :

---

**Objectif** : qualifier commercialement `[Nom client]`, `[ville]`, France — secteur `[secteur]`, fondateur / dirigeant : `[Nom fondateur]`.

But final : déterminer si cette entreprise est un bon prospect pour une offre d'application sur-mesure, Notion, automatisation légère, tableau de bord opérationnel ou structuration de l'information. Produire une analyse orientée décision commerciale, pas une fiche descriptive.

**Contraintes générales** :
- Citer les sources utilisées avec URL
- Distinguer faits vérifiés, signaux faibles et hypothèses
- Ne jamais inventer les informations manquantes — indiquer "non disponible publiquement"
- Indiquer la date des informations récentes
- Prioriser les données commercialement actionnables

---

**1. Identification légale**
Rechercher : SIREN/SIRET, forme juridique, date de création, adresse, code NAF, capital social, dirigeants officiels, effectif si disponible.
Sources **prioritaires** : pappers.fr, annuaire-entreprises.data.gouv.fr
Sources **secondaires** : societe.com

**2. Taille, stabilité et santé financière**
Rechercher : CA sur 3 ans si disponible, résultat net, dépôt des comptes.
Si comptes indisponibles → utiliser les signaux indirects : recrutements, nouveaux locaux, nouvelles offres, presse, effectif LinkedIn.
Sources : pappers.fr, infogreffe.fr, presse économique locale.
Donner une lecture commerciale : entreprise stable / en croissance / fragile / probablement trop petite pour acheter une prestation sur-mesure.

**3. Maturité digitale et organisationnelle**
Analyser : site web (clarté, modernité, tunnel de contact, espace client), présence LinkedIn, fréquence des publications, outils SaaS visibles.
Chercher surtout les signaux utiles pour une offre sur-mesure :
- suivi client, gestion de projet, coordination interne, planning, reporting
- dépendance visible à Excel, email, WhatsApp, Google Sheets
- absence de portail client, tableau de bord ou base documentaire
- process visibles mais non intégrés

**4. Profil du décideur**
Analyser `[Nom fondateur]` : parcours, culture tech/digitale/opérationnelle, publications LinkedIn, sujets récurrents (croissance, organisation, IA, productivité, structuration).
But : déduire le bon angle de langage commercial.
- Dirigeant opérationnel ou commercial ?
- Sensible à la productivité, au pilotage, à la réduction du chaos, à la croissance ?
- A-t-il déjà piloté des équipes ? Acheté du sur-mesure ?
Ne pas produire une fiche biographique — uniquement ce qui aide à vendre.

**5. Signaux d'achat** *(priorité haute)*
Chercher : recrutements ops/admin/chargé de projet, croissance d'équipe, ouverture géographique, levée de fonds, nouveaux contrats, changement de direction, posts LinkedIn sur organisation/outils/IA, avis clients mentionnant retards/suivi/coordination/administratif.
Classer les signaux : **forts / moyens / faibles / absents**.

**6. Actualités et contexte sectoriel**
Rechercher : actualités récentes de l'entreprise, contraintes réglementaires, mutations du secteur, tendances numériques.
But : identifier si le contexte crée une opportunité — besoin de conformité, de reporting, d'efficacité, de digitalisation.

**7. Réputation, douleurs visibles et irritants clients**
Analyser : avis Google, Trustpilot, forums, réseaux sociaux.
Chercher : irritants opérationnels récurrents — délai, suivi client, communication, erreurs administratives, désorganisation.
Distinguer signal récurrent et cas ponctuel.

**8. Logiciels métier et SaaS concurrents**
Identifier les solutions courantes dans le secteur exact de `[secteur]`.
Pour chaque solution : nom, URL, fonctionnalités, prix mensuel/annuel, coût sur 2 ans, limites probables.
Chercher aussi les cas où une solution sur-mesure / Notion serait **complémentaire** plutôt que concurrente (tableau de bord dirigeant, CRM léger, coordination interne, reporting, espace documentaire).
Sources : Capterra, G2, Product Hunt, sites officiels — prioriser les solutions réellement utilisées dans le secteur.

---

### Sortie attendue

1. **Synthèse exécutive** — 10 lignes max
2. **Fiche entreprise** — données légales et financières
3. **Signaux d'achat détectés** — classés forts / moyens / faibles
4. **Douleurs probables** — irritants opérationnels identifiés
5. **Maturité digitale** — faible / moyenne / forte + justification
6. **Opportunités** — où une offre sur-mesure / Notion / automatisation s'insère
7. **Risques et mauvais fit** — signaux de faible pertinence ou de risque
8. **SaaS concurrents** — solutions + coût comparatif sur 2 ans
9. **Scoring** :
   - Potentiel commercial : /10
   - Maturité digitale : /10
   - Urgence probable : /10
   - Accessibilité du décideur : /10
   - Pertinence sur-mesure / Notion : /10
   - Risque de mauvais fit : /10
10. **Recommandation** : Priorité A (contacter rapidement) / B (surveiller) / C (faible priorité) / À écarter
11. **Angle de prospection** :
    - Hypothèse de douleur principale
    - Message LinkedIn court
    - Email de prise de contact
    - Objection probable et réponse possible

---

**Après avoir produit la fiche**, dis à Medwin :
> "Recherche terminée. Tu peux déconnecter `exa` via `/mcp`."

---

### Questions de complément si des angles restent lacunaires

- "Tu as des infos sur leur CA ou leur taille ?"
- "Sais-tu ce qu'ils paient actuellement pour des outils similaires ?"
- "Y a-t-il eu des recrutements récents ou un changement de cap dans l'entreprise ?"

---

## Étape 2 — Confirmation de l'architecture légère

Objectif : confirmer les choix techniques qui impactent les coûts récurrents. Ces informations ont été capturées dans le brief — l'étape consiste à les valider, pas à les re-découvrir.

Tu extrais du brief la section "Architecture légère et modèle de prestation" et tu la présentes :

> "Voici l'architecture légère définie dans le brief :
> - Modèle : [M1 / M2 / M3]
> - Stack : [Stack A — Convex / Stack B — Supabase / à confirmer]
> - Services tiers : [liste]
> - Coûts récurrents estimés : [tableau]
> C'est toujours valide ? Des ajustements ?"

**Si la section est absente du brief** → demander les informations une par une :
- "Modèle de prestation : M1 (dev sur mesure client unique), M2 (SaaS multi-clients), ou M3 (Notion) ?"
- "Stack prévue ? (Stack A — Convex, Stack B — Supabase, ou autre)"
- "Services tiers nécessaires ? (Stripe, Resend, stockage fichiers…)"

Tu consolides la table des coûts récurrents à la charge du client :

| Service | Coût estimé/mois |
|---|---|
| Hébergement | X€ |
| Base de données | X€ |
| Services tiers | X€ |
| **Total récurrent** | **X€/mois** |

---

## Étape 3 — Estimation complète : workflow + développement

L'étape se déroule en deux parties. Le total des deux alimente le récapitulatif de l'étape 6.

---

### Étape 3a — Estimation des phases workflow

À partir des paramètres déjà lus dans le brief (étape 0), tu estimes chaque phase du workflow vibe-method en raisonnant depuis la grille de calibration ci-dessous.

**Paramètres à extraire du brief :**
- N : nombre de features majeures
- Modèle : M1 / M2 / M3
- Sécurité : Bas / Moyen / Élevé
- Distribution : Web / Mobile natif / PWA
- Règles métier : simples / complexes
- Services tiers : nombre
- Site vitrine : oui / non
- RGPD : applicable / non
- Stack : connue (Convex / Supabase) / à confirmer

**Grille de calibration :**

| Phase | Base | Ce qui augmente | Incertitude |
|---|---|---|---|
| Brief + cadrage | 0,5 j | M2 : +0,5 j | ± 0 j |
| PRD | 1 j | N > 5 : +0,5 j — Règles complexes : +0,5 j — M2 : +0,5 j — M3 : −0,5 j | ± 0,5 j |
| Gherkin (mode PRD) | 0,5 j | N > 5 : +0,5 j | ± 0,5 j |
| Architecture + Design | M1 : 1 j / M2 : 2 j / M3 : 0,5 j | Mobile natif : +1 j — Services tiers > 3 : +0,5 j — Site vitrine : +0,5 j | ± 1 j |
| Règles + Stack | 0,5 j | Stack à confirmer : +0,5 j — Par service tiers au-delà de 2 : +0,3 j | ± 0,5 j |
| Specs + Gherkin (mode Specs) | 0,5 j × N | Règles complexes : +0,5 j — Sécurité élevée : +0,5 j | ± 0,5 j |
| Setup | 0,5 j | Mobile natif : +0,5 j — Stack nouvelle : +0,5 j | ± 0 j |
| Revues de code (4 passes) | 20 % du temps dev | Sécurité élevée : × 1,5 — Sécurité basse : × 0,8 | ± 0,5 j |
| Tests | 15 % du temps dev | Sécurité élevée ou RGPD : × 1,3 | ± 0,5 j |
| Sécurité (/securite) | Bas : 0,5 j / Moyen : 1 j / Élevé : 2 j | — | ± 0 j |
| Documentation | 0,5 j | M2 : +0,5 j | ± 0 j |
| Recette + Debug | 1 j | — | ± 2 j (variable — toujours signaler au client) |
| Formation | selon étape 5 | — | ± 0 j |

Tu produis le tableau et tu demandes confirmation :

| Phase | Estimé | Incertitude | Justification |
|---|---|---|---|
| Brief + cadrage | X j | ± 0 j | — |
| PRD | X j | ± 0,5 j | [ce qui a ajusté la base] |
| Gherkin PRD | X j | ± 0,5 j | [ce qui a ajusté la base] |
| Architecture + Design | X j | ± 1 j | [modèle + paramètres] |
| Règles + Stack | X j | ± 0,5 j | [stack + services tiers] |
| Specs + Gherkin Specs | X j | ± 0,5 j | [N features + règles] |
| Setup | X j | ± 0 j | [stack + distribution] |
| Revues de code | X j | ± 0,5 j | [niveau sécurité] |
| Tests | X j | ± 0,5 j | [niveau sécurité + RGPD] |
| Sécurité | X j | ± 0 j | [niveau sécurité] |
| Documentation | X j | ± 0 j | [modèle] |
| Recette + Debug | X j | ± 2 j | Variable selon retours client |
| Formation | X j | ± 0 j | Confirmée étape 5 |
| **Total workflow** | **X j** | **± Z j** | Z = somme des incertitudes |

"Est-ce que ces estimations te semblent cohérentes ? On peut ajuster avant de continuer."

---

### Étape 3b — Découpage en blocs de développement

Tu découpes le projet en blocs fonctionnels à partir du brief. Pour chaque bloc, tu cherches d'abord un pattern dans la table de référence ci-dessous — ajusté selon la stack choisie. Si le bloc ne correspond à aucun pattern connu, tu appliques la grille P/M/G en fallback.

**Stack lue dans le brief** : Stack A (Convex) ou Stack B (Supabase). Si mobile natif (Expo) : multiplier les durées × 1,5 à 2 selon la feature.

---

**Table de référence par pattern :**

*Authentification & utilisateurs*

| Pattern | Supabase | Convex |
|---|---|---|
| Auth email + mot de passe | 1 j | 1,5 j |
| Auth OAuth (Google, GitHub…) | 2 j | 2 j |
| Profil utilisateur (lecture/édition) | 0,5 j | 0,5 j |
| Rôles et permissions (RBAC) | 1–2 j | 1–2 j |
| Multi-tenant (M2 — isolation par organisation) | +1–2 j sur toute la stack | +1–2 j |

*Données & CRUD*

| Pattern | Supabase | Convex |
|---|---|---|
| CRUD standard (1 entité, UI complète) | 1 j | 1 j |
| CRUD avec relations complexes | 2 j | 1,5 j |
| CRUD avec validation métier | 1,5 j | 1,5 j |
| Recherche et filtres avancés | 1–2 j | 1–2 j |
| Pagination | 0,5 j | 0,5 j |
| Import / export CSV | 0,5–1 j | 0,5–1 j |

*Temps réel*

| Pattern | Supabase | Convex |
|---|---|---|
| Chat simple | 3–4 j | 1–2 j |
| Notifications en temps réel | 2–3 j | 1 j |
| Collaboration multi-utilisateurs | 4–5 j | 2–3 j |

*Interface & UI*

| Pattern | Supabase | Convex |
|---|---|---|
| Dashboard (graphes, filtres) | 2–3 j | 2 j |
| Formulaire multi-étapes avec validation | 1–2 j | 1–2 j |
| Tableau de données (tri, filtre, pagination) | 1–2 j | 1–2 j |
| Calendrier / planning | 2–3 j | 2–3 j |

*Intégrations tierces*

| Pattern | Durée |
|---|---|
| Stripe — paiement one-time | 1–2 j |
| Stripe — abonnements (subscriptions) | 2–3 j |
| Email transactionnel (Resend) | 0,5 j |
| Upload fichiers (Cloudflare R2) | 1 j |
| Webhook entrant | 0,5–1 j |
| API tierce bien documentée | 0,5–1 j par endpoint |

---

**Grille P/M/G — fallback pour les patterns non listés :**

| Taille | Critère | Durée |
|---|---|---|
| Petit (P) | Pattern connu, peu d'incertitude | 0,5 – 1 j |
| Moyen (M) | Logique métier standard | 1 – 2 j |
| Gros (G) | Complexité ou incertitude élevée | 3 – 5 j |

---

Tu présentes le tableau et tu demandes confirmation :

| Bloc | Pattern de référence | Jours | € HT |
|---|---|---|---|
| [Bloc 1] | [pattern ou P/M/G] | X | X€ |
| … | | | |
| **Total développement** | | **X j** | **X€** |

TJM de référence : **400€/jour**

"Est-ce que ce découpage et ces estimations te semblent cohérents ? On peut ajuster avant de continuer."

---

**Total général après 3a + 3b :**

| | Jours | € HT |
|---|---|---|
| Workflow (3a) | X j | X€ |
| Développement (3b) | X j | X€ |
| **Total** | **X j** | **X€** |

---

## Étape 4 — Calibrage valeur (interne — ne jamais inclure dans le document client)

Ce raisonnement est une conversation entre toi et le skill. Il ne figure jamais dans la proposition.

### Grille de lecture commerciale

Pour chaque signal de l'Étape 1, extraire une décision :

| Signal | Ce qu'on a trouvé | Lecture commerciale | Impact sur le prix |
|---|---|---|---|
| Santé financière | [CA, résultat, signaux indirects] | stable / en croissance / fragile | budget disponible / limité / incertain |
| Maturité digitale | [outils, site, process] | faible / moyenne / forte | besoin réel / résistance probable |
| Profil décideur | [background, sensibilité] | opérationnel / commercial / tech | langage à utiliser, niveau d'éducation nécessaire |
| Signaux d'achat | [forts / moyens / faibles] | timing favorable / neutre / mauvais | urgence → influence le prix défendable |
| Douleurs visibles | [irritants identifiés] | douleur documentée / supposée / absente | argument fort / faible pour le sur-mesure |
| Concurrents SaaS | [solutions + coût 2 ans] | ancrage prix disponible | plafond psychologique calculable |

### Trois décisions à prendre

**1. Profil d'acheteur**
- **Prêt** : signaux d'achat forts, maturité digitale moyenne/forte, douleur documentée → aller vite, proposer haut
- **Hésitant** : signaux mixtes, maturité faible → justifier la valeur, proposer en deux temps (diagnostic d'abord)
- **À évangéliser** : pas de maturité digitale, pas de signaux d'achat → coût d'acquisition élevé, évaluer si ça vaut le temps

**2. Fourchette de prix défendable**

> **Plancher** : X jours × 400€ = X€ (en dessous, tu travailles à perte)
> **Ancrage concurrentiel** : coût SaaS sur 2 ans = X€ (plafond psychologique par comparaison)
> **Valeur annuelle estimée** : heures gagnées × coût horaire client = X€/an
> **Prix proposé** : X€ — [justification en 1 ligne : plancher + valeur + ancrage]

"Est-ce que ce positionnement te semble juste ? On peut aller plus haut si la valeur le justifie."

**3. Arguments clés pour la proposition**
Identifier les 2-3 arguments issus de la recherche à intégrer dans :
- la lettre d'introduction (ton personnel, montre qu'on a fait ses devoirs)
- la section "Compréhension du besoin" (douleurs nommées précisément)
- la justification du prix (valeur vs alternative SaaS)

---

## Étape 5 — Conditions

Tu confirmes les conditions contractuelles, une question à la fois.

1. "Quelle durée pour la période d'ajustement incluse après livraison ?"
2. "Tu veux proposer une option de maintenance au-delà ? Si oui, à quel tarif ?"
3. "L'acompte à 30% / solde à la livraison s'applique ici aussi ?"
4. "Durée de validité de cette proposition ? (recommandé : 30 jours)"

À la fin, tu confirmes le modèle de prestation retenu — il sera utilisé par `/cgv` pour sélectionner les Conditions Particulières applicables (M1 / M2 / M3).

---

## Étape 6 — Génération et enregistrement

Tu génères `[projet].proposition.md` en deux parties : le récapitulatif devis en tête de fichier, puis la proposition commerciale complète.

**Récapitulatif devis — construction du tableau**

À partir des données collectées aux étapes 3 et 5, construis une ligne par élément :

| Type | Désignation | Qté | Prix unitaire | Total HT |
|---|---|---|---|---|
| Développement (M1/M2) | [Nom du bloc] | N j | 400 €/j | N × 400 € |
| Accompagnement inclus | Période d'accompagnement ([X mois]) | Inclus | — | Inclus |
| Formation (si au devis) | Formation | N j | 400 €/j | N × 400 € |
| Option maintenance | Maintenance post-accompagnement | 1 | X €/mois | Récurrent |
| Abonnement tiers pris en charge | Abonnement [outil] | 1 | X €/mois | Récurrent |
| Achat matériel | [Désignation] | N | X € | N × X € |
| Abonnement mensuel (M2) | Infrastructure + support | 1 | X €/mois | Récurrent |

Règles tableau 1 :
- Les lignes "Inclus" et "Récurrent" ne comptent pas dans le Total HT
- Total HT = somme des lignes à prix fixe uniquement (développement, formation, matériel)
- Si M2 : deux totaux distincts — "Développement : X €" et "Abonnement mensuel : X €/mois"
- La colonne "Type" est un guide interne — ne pas l'inclure dans le document généré

**Détail par phase — construction du second tableau**

Construis ce tableau à partir du brief et des estimations de l'étape 3. Il reste dans le fichier pour Medwin — à supprimer avant conversion en PDF.

Référentiel d'estimation par phase :

| Phase | Base | Incertitude |
|---|---|---|
| Brief + cadrage | 0,5 j | ± 0 |
| PRD + architecture | 0,5–1 j selon complexité | ± 0,5 j |
| Specs | 0,5 j par feature majeure | ± 0,5 j |
| Design | 0,5–2 j selon périmètre UI | ± 1 j |
| Développement | blocs étape 3 | ± Y j |
| Tests + recette | ~15% du temps de dev | ± 0,5 j |
| Déploiement + documentation | 0,5 j | ± 0 |
| Formation | confirmée à l'étape 5 | ± 0 |

Le total du tableau 2 doit correspondre au nombre de jours inscrit dans le tableau 1.

```markdown
## Récapitulatif — Lignes de devis

| Désignation | Qté | Prix unitaire | Total HT |
|---|---|---|---|
| [Bloc 1 — nom] | [N] j | 400 €/j | [N × 400] € |
| [Bloc 2 — nom] | [N] j | 400 €/j | [N × 400] € |
| Période d'accompagnement ([X mois]) | Inclus | — | Inclus |
| **Total HT** | | | **[X] €** |

*TVA non applicable — art. 293B CGI*

## Détail par phase *(à supprimer avant envoi au client)*

| Phase | Charge estimée | Incertitude |
|---|---|---|
| Brief + cadrage | [X] j | ± [Y] j |
| PRD + architecture | [X] j | ± [Y] j |
| Specs | [X] j | ± [Y] j |
| Design | [X] j | ± [Y] j |
| Développement | [X] j | ± [Y] j |
| Tests + recette | [X] j | ± [Y] j |
| Déploiement + documentation | [X] j | ± [Y] j |
| Formation | [X] j | ± 0 j |
| **Total** | **[X] j** | **± [Y] j** |

---

# Proposition commerciale — [Nom du projet]
_[Date] — Valable jusqu'au [Date + durée de validité]_

**Client :** [Nom complet — coordonnées]
**Prestataire :** Medwin Rumo — medwinrumo@gmail.com | SIRET : 520 868 480 00028

---

[Lettre d'introduction — 3-4 phrases. Rappel du contexte de la relation, ce qu'on a compris de leur situation, angle commercial issu de la qualification (Étape 1). Ton direct et personnel, pas corporate. Montrer qu'on a fait ses devoirs.]

## 1. Compréhension du besoin

### Contexte
[Situation du client en 2-3 phrases — ce qui existe aujourd'hui, pourquoi ça pose problème]

### Problématiques identifiées
- [P1]
- [P2]

### Objectifs à atteindre
- [O1]
- [O2]

## 2. Solution proposée

### Description
[Ce qu'on construit — logique générale, pour qui, dans quel but]

### Périmètre

<!-- M1 — dev sur mesure -->
**Ce qui est inclus dans la V1**
- [Bloc 1] — [description courte]
- [Bloc 2] — [description courte]

**Ce qui n'est pas inclus**
- [Exclusion 1]
Toute demande hors périmètre fait l'objet d'un devis complémentaire (Change Request).

**Stack technique retenue**
[Stack A — React + Vite + TypeScript + Convex + Vercel / Stack B — React + Vite + TypeScript + Supabase + Vercel]

<!-- M2 — SaaS multi-clients -->
**Fonctionnalités couvertes**
- [F1]
- [F2]

**Hors périmètre**
- [Exclusion 1]
Les évolutions fonctionnelles font l'objet d'un devis complémentaire ou sont intégrées à la roadmap.

**Stack technique retenue**
[Stack A — React + Vite + TypeScript + Convex + Vercel / Stack B — React + Vite + TypeScript + Supabase + Vercel]

<!-- M3 — Notion -->
**Ce qui est inclus**
- [Base de données 1] — [description]
- [Vues et filtres] — [description]
- [Gabarits] — [description]
- [Automatisations / intégrations] — si applicable

**Ce qui n'est pas inclus**
- [Exclusion 1]
Toute demande hors périmètre fait l'objet d'un devis complémentaire.

### Méthodologie
<!-- M1/M2 --> Brief et cahier des charges validés en amont — itérations courtes : développement, démonstration, retours, ajustements — livraison documentée et transfert des accès.
<!-- M3 --> Cadrage à partir de vos usages réels — conception en itérations courtes — documentation et prise en main guidée.

### Planning prévisionnel

| Étape | Date |
|---|---|
| Livraison V1 | [Date] |
| Début de la période d'accompagnement | [Date] |
| Fin de la période d'accompagnement | [Date + 3 mois par défaut] |
<!-- Si formation prévue au devis : -->
| Formation | [À planifier ensemble] |

Durant la période d'accompagnement, vous testez l'outil en conditions réelles et me faites remonter vos retours. Les corrections sont apportées au fil de l'eau.

### Livrables

<!-- M1 -->
- Code source versionné dans un dépôt Git — accès administrateur transmis à la livraison
- Application déployée sur [hébergeur] et accessible en production
- Documentation technique de livraison
- [Durée] de période d'accompagnement incluse

<!-- M2 -->
- Application déployée et accessible en production
- Compte d'accès transmis à la livraison
- Documentation utilisateur
- [Durée] de période d'accompagnement incluse

<!-- M3 -->
- Base Notion opérationnelle, dupliquée dans votre espace de travail
- Documentation d'utilisation
- [Durée] de période d'accompagnement incluse
<!-- Si formation prévue au devis : - Session de formation — [durée et modalités] -->

## 3. Infrastructure

<!-- M1 -->
Les services suivants sont nécessaires au fonctionnement de l'application. Ils sont souscrits et réglés directement par vous auprès des éditeurs concernés, indépendamment du forfait de réalisation.

| Service | Usage | Coût estimé / mois |
|---|---|---|
| [service] | [usage] | [montant] |
| **Total récurrent estimé** | | **~X€/mois** |

*Dans la majorité des projets de ce type, les volumes restent dans les limites des plans gratuits — à confirmer selon l'usage réel.*

<!-- M2 -->
L'infrastructure nécessaire au fonctionnement du service est incluse dans l'abonnement mensuel. Si le volume du projet augmente significativement, l'abonnement évolue en conséquence — vous en êtes informé avec un préavis de 2 mois.

<!-- M3 -->
Un abonnement Notion est nécessaire pour accéder à l'espace de travail. Il est souscrit et réglé directement par vous auprès de Notion.

## 4. Propriété intellectuelle

<!-- M1 -->
À compter du paiement intégral du forfait, l'ensemble des droits patrimoniaux sur le code source développé pour ce projet vous est cédé — reproduction, représentation, adaptation, distribution — pour le monde entier et pour toute la durée légale de protection. Cette cession est comprise dans le forfait. Les droits sur les composants open source tiers et le savoir-faire général du prestataire sont exclus. Les CGV jointes (CP M1, art. CP.4) détaillent l'étendue complète.

<!-- M2 -->
Le prestataire est et demeure propriétaire de l'application, de son code et de son architecture. Vous bénéficiez d'une licence d'accès non exclusive, limitée à l'utilisation du service dans le cadre de votre activité, pour la durée de l'abonnement. Les CGV jointes (CP M2, art. CP.4) détaillent les droits et obligations associés.

<!-- M3 -->
Le prestataire est et demeure propriétaire du système Notion — structure, bases de données, automatisations, documentation. Vous bénéficiez d'un droit d'usage non exclusif et non transférable, pour vos besoins propres. Les CGV jointes (CP M3, art. CP.4) détaillent les droits et obligations associés.

## 5. Proposition financière

<!-- M1 et M3 -->
**Forfait de réalisation : [Prix final]€ HT**

<!-- M1 --> Inclus : conception, développement des blocs définis, tests, déploiement, documentation, [durée] d'accompagnement. Non inclus : infrastructure récurrente (section 3), évolutions hors périmètre.
<!-- M3 --> Inclus : conception, construction du système Notion, documentation, [durée] d'accompagnement. Non inclus : abonnement Notion (section 3), évolutions hors périmètre[, formation si non prévue au devis].

Acompte de 30% à la commande — [montant acompte]€ HT.
Solde à la livraison, paiement à 7 jours — [montant solde]€ HT.

<!-- M1 : Si option maintenance confirmée -->
**Option maintenance post-accompagnement :** [description et tarif]

<!-- M2 -->
**Coût de développement : [Prix]€ HT** — règlement à la commande.
**Abonnement mensuel : [Prix]€ HT/mois** — infrastructure, maintenance corrective et support inclus.

Si le volume du projet augmente significativement, l'abonnement évolue en conséquence. Vous en êtes informé avec un préavis de 2 mois.

---
Non assujetti à la TVA (art. 293B CGI).
Pénalités de retard et indemnité forfaitaire de 40€ conformément aux CGV.
**Validité de cette proposition :** [durée] — jusqu'au [date limite].

## 6. Garanties et engagements
- Solution documentée et adaptée au besoin réel
- Corrections incluses sur la période d'accompagnement convenue
- Évolutions par devis complémentaire (Change Request)
- Les Conditions Générales et Conditions Particulières [M1 / M2 / M3] sont jointes à cette proposition et en font partie intégrante

### Engagements RGPD

Dans le cadre de la présente mission, le Prestataire intervient en tant que [sous-traitant au sens de l'article 28 du RGPD / prestataire technique sans accès aux données opérationnelles — selon modèle M1/M2/M3]. À ce titre :

- **Destruction des fichiers sources** — les documents et exports transmis par le Client sont détruits des systèmes du Prestataire à l'issue de la mission, avec attestation sur demande.
- **Sécurité** — poste de travail chiffré (FileVault), accès restreints, authentification forte.
- **Notification** — information du Client dans les 72 heures suivant la détection d'une violation de données.
- **Outils certifiés DPF** — les outils tiers utilisés (notamment Notion Labs, Inc.) sont certifiés Data Privacy Framework, garantie de transfert conforme pour les données hébergées hors UE.
- **Politique de confidentialité** — disponible sur demande.
- **Registre des traitements** — tenu conformément à l'article 30.2 du RGPD, à disposition sur demande.

## Prochaine étape

Pour démarrer :
1. Retourner cette proposition signée (bon pour accord) accompagnée du règlement de l'acompte ([montant acompte]€ HT)
2. Les CGV jointes sont réputées acceptées à la signature
```

---

## Quality Gate — avant enregistrement

- [ ] Le problème client est formulé clairement en 2-3 phrases
- [ ] Le périmètre (inclus) et le hors-scope (exclus) sont explicitement listés
- [ ] Le prix final est dans la fourchette plancher–plafond
- [ ] La durée de la période d'accompagnement est confirmée (pas supposée)
- [ ] La validité de la proposition est précisée (date limite)
- [ ] Le modèle de prestation est confirmé (M1 / M2 / M3) — nécessaire pour `/cgv`
- [ ] **Si M1 ou M3** : montants acompte (30%) et solde (70%) calculés — stack et infrastructure précisées
- [ ] **Si M1** : option maintenance post-accompagnement tranchée (incluse ou non)
- [ ] **Si M2** : coût de développement initial et abonnement mensuel précisés — blocs découpés et estimés

Si une case est vide → poser la question manquante avant d'écrire.

---

## Enregistrement

Tu écris `[projet].proposition.md` dans le répertoire courant du projet.

Confirmer :
> "`[projet].proposition.md` enregistré.
> Prochaine étape : lance `/cgv` pour générer les Conditions Générales + Conditions Particulières M[1/2/3].
> Proposition commerciale et CGV partent ensemble au client — ne pas envoyer l'une sans l'autre."

---

## Règles

- L'étape 4 (calibrage valeur) est **strictement interne** — ne jamais l'inclure dans le document client
- Ne jamais imposer un tarif de maintenance — demander à chaque fois
- Si des SaaS concurrents existent dans le secteur → toujours le signaler à l'étape 1
- La proposition commerciale ne part jamais seule — elle est toujours accompagnée des CGV générées par `/cgv`
- Le document généré est une proposition commerciale, pas un devis signable — le devis PDF est produit en dehors de ce skill

---

## Prochaine étape

`/cgv` — générer les CGV (CG + CP adaptées au modèle M1/M2/M3). Proposition et CGV partent ensemble au client.
Après validation client : `/prd`.

---

## Contexte RGPD

La section « Engagements RGPD » ci-dessus reflète les clauses désormais présentes dans les gabarits CGV/CP. Pour le détail des connaissances RGPD (statut sous-traitant vs prestataire technique, DPA, DPF), voir `vibe-method/rgpd.md`.
