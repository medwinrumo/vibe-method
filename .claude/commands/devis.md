# /devis — Du brief à la proposition commerciale

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
> **Contraintes** : [délai, stack évoquée, budget mentionné]
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

## Étape 2 — Architecture légère

Objectif : identifier les choix techniques qui impactent les coûts récurrents. Ce n'est pas une architecture complète — juste ce qui est nécessaire pour chiffrer.

Tu poses uniquement les questions nécessaires :

- "Quelle stack envisages-tu ? (ou ta stack habituelle)"
- "Quel hébergeur ? (Vercel, Railway, VPS…)"
- "Base de données ? (Supabase, PlanetScale, Neon…)"
- "Services tiers nécessaires ? (Stripe, SendGrid, stockage fichiers…)"

Tu estimes les coûts récurrents mensuels à la charge du client :

| Service | Coût estimé/mois |
|---|---|
| Hébergement | X€ |
| Base de données | X€ |
| Services tiers | X€ |
| **Total récurrent** | **X€/mois** |

---

## Étape 3 — Découpage en blocs et estimation

Tu découpes le projet en blocs fonctionnels à partir du brief.

Grille d'estimation :

| Taille | Critère | Durée |
|---|---|---|
| Petit (P) | Logique simple, peu d'incertitude | 0,5 – 1 jour |
| Moyen (M) | Logique métier standard | 1 – 2 jours |
| Gros (G) | Complexité ou incertitude élevée | 3 – 5 jours |

Tu présentes le tableau et tu demandes confirmation :

| Bloc | Description | Taille | Jours | € HT |
|---|---|---|---|---|
| [Bloc 1] | | P/M/G | X | X€ |
| … | | | | |
| **Total** | | | **X j** | **X€** |

TJM de référence : **400€/jour**

"Est-ce que ce découpage et ces estimations te semblent cohérents ? On peut ajuster avant de continuer."

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

À la fin, tu rappelles systématiquement :

> ⚠️ **Note CGV** : tes CGV actuelles visent les "systèmes Notion" (article 1). Pour un projet applicatif, les articles 1, 2, 14 et 16 sont à adapter avant signature. À faire en dehors de ce skill.

---

## Étape 6 — Génération et enregistrement

Tu génères le document en respectant la structure ci-dessous — fidèle au template de proposition commerciale existant.

```markdown
# Proposition commerciale — [Nom du projet]
_[Date]_

**Client :** [Nom]
**Prestataire :** Medwin Rumo — medwinrumo@gmail.com

---

[Lettre d'introduction : 3-4 phrases. Rappel du contexte, ce que tu as compris, ton intention. Ton direct et personnel, pas corporate. S'appuyer sur les arguments clés identifiés en Étape 4.]

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
[Ce qu'on construit — blocs principaux, logique générale]

### Méthodologie
- Cadrage et cahier des charges à partir du brief validé
- Itérations courtes : développement, démonstration, retours, ajustements
- Livraison documentée et transfert de compétences

### Planning prévisionnel
[Découpage en semaines basé sur l'estimation des blocs]

### Livrables
- [L1]
- [L2]

### Période d'ajustement
[Durée confirmée] incluse après livraison. Couvre les ajustements fonctionnels et ergonomiques dans le périmètre livré. Toute demande hors périmètre fait l'objet d'un devis complémentaire (Change Request).

### Coûts récurrents à la charge du client
[Tableau hébergement / DB / services tiers — estimations mensuelles]

Ces coûts sont distincts du forfait de réalisation et sont engagés directement par le client auprès des éditeurs concernés.

## 3. Proposition financière

**Forfait de réalisation V1 : [Prix final]€ HT**

Inclus : [blocs couverts], tests, livraison, documentation, [durée] d'ajustements inclus.
Non inclus : coûts d'hébergement et services tiers récurrents, évolutions hors périmètre initial.

[Si option maintenance confirmée :]
**Option maintenance post-ajustement** : [description et tarif confirmé]

### Conditions de paiement
Acompte de 30% à la commande. Solde à la livraison, paiement à 7 jours.
Non assujetti à la TVA — article 293B du CGI.
Pénalités de retard et indemnité forfaitaire de 40€ conformément aux CGV.

## 4. Garanties et engagements
- Solution documentée et adaptée au besoin réel
- Ajustements correctifs inclus sur la période convenue
- Évolutions par devis complémentaire (Change Request)
- Les présentes CGV sont disponibles sur demande
```

---

## Quality Gate — avant enregistrement

- [ ] Le problème client est formulé clairement en 2-3 phrases
- [ ] Les blocs sont découpés et estimés
- [ ] Les coûts récurrents mensuels sont identifiés
- [ ] Le prix final est dans la fourchette plancher–plafond
- [ ] Ce qui est inclus et exclu est explicitement listé
- [ ] La durée d'ajustement est confirmée (pas supposée)
- [ ] L'option maintenance est tranchée : incluse ou non
- [ ] La note CGV figure si le projet est applicatif (pas Notion)

Si une case est vide → poser la question manquante avant d'écrire.

---

## Enregistrement

Tu écris `[projet].proposition.md` dans le répertoire courant du projet.

Confirmer :
> "`[projet].proposition.md` enregistré.
> Prochaine étape : personnalise la lettre d'introduction, puis transmets au client pour validation avant de faire signer le devis."

---

## Règles

- L'étape 4 (calibrage valeur) est **strictement interne** — ne jamais l'inclure dans le document client
- Ne jamais imposer un tarif de maintenance — demander à chaque fois
- Si des SaaS concurrents existent dans le secteur → toujours le signaler à l'étape 1
- Pour tout projet applicatif → toujours rappeler l'inadéquation des CGV actuelles
- Le document généré est une proposition commerciale, pas un devis signable — le devis PDF est produit en dehors de ce skill

---

## Prochaine étape

`/prd` — la proposition est acceptée par le client, construire le PRD complet.
