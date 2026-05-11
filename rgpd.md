# rgpd.md — Doctrine RGPD

Le RGPD (Règlement Général sur la Protection des Données) est le cadre légal européen qui régit la collecte et le traitement des données personnelles. Une donnée personnelle, c'est toute information qui permet d'identifier directement ou indirectement une personne : nom, email, adresse IP, photo, numéro de téléphone.

**Règle absolue :** la conformité RGPD se conçoit au démarrage du projet, pas après le lancement. Ajouter la conformité après coup coûte toujours plus cher en code, en temps et en risque légal.

Source de référence : CNIL (cnil.fr) — autorité française de contrôle. En cas de doute sur une règle spécifique, c'est la source primaire à consulter, avant tout autre.

---

## 0 — Principe fondamental

Le RGPD repose sur trois principes qui gouvernent toutes les décisions qui suivent :

- **Finalité** : toute donnée collectée doit avoir un but précis, déclaré à l'avance.
- **Minimisation** : on ne collecte que ce qui est strictement nécessaire à ce but.
- **Durée limitée** : on ne conserve les données que le temps nécessaire, puis on les supprime.

Ces trois principes doivent être posés dès le `/archi`, avant d'écrire la première ligne de code.

---

## 1 — Bases légales (art. 6)

Avant de collecter une donnée, la loi exige une raison valable, appelée "base légale". Il en existe 6. Choisir la mauvaise base légale rend un traitement illégal, même si la donnée semble anodine. Ce choix se fait avant de coder, et il est déclaré publiquement dans la politique de confidentialité.

### Les 6 bases légales

| Base légale | Quand l'utiliser | Exemples concrets |
|---|---|---|
| **Consentement** | L'utilisateur donne un accord explicite, libre, et révocable | Newsletter, cookies analytics, notifications push |
| **Exécution d'un contrat** | La donnée est nécessaire pour fournir le service auquel l'utilisateur s'est inscrit | Email pour créer un compte, adresse pour livrer une commande |
| **Obligation légale** | La loi impose le traitement, indépendamment de la volonté des parties | Conservation des factures 10 ans (Code du Commerce) |
| **Intérêts vitaux** | Protection de la vie d'une personne en danger | Urgences médicales — quasiment jamais applicable dans un projet web standard |
| **Mission d'intérêt public** | Organismes publics dans l'exercice de leurs missions | Administrations — ne s'applique pas aux projets vibe-method |
| **Intérêt légitime** | Intérêt réel de l'organisation, à condition qu'il ne prime pas sur les droits des utilisateurs | Statistiques d'utilisation anonymisées, prévention de la fraude |

### Règles opérationnelles

- Choisir la base légale **avant** de coder le traitement — pas après.
- Une base légale par traitement. Si tu en cherches deux pour le même traitement, c'est que quelque chose ne va pas.
- **Contrat et consentement** sont les deux bases les plus utilisées dans les projets vibe-method.
- L'intérêt légitime est la plus délicate : elle nécessite une mise en balance documentée entre tes intérêts et les droits des utilisateurs. À éviter si une autre base s'applique.
- La base légale choisie est documentée dans le registre des traitements (section 3) et déclarée dans la politique de confidentialité (section 6).

---

## 2 — Minimisation des données

La minimisation, c'est ne collecter que ce dont on a besoin. Pas moins — mais pas plus. Ce n'est pas un principe moral, c'est une obligation légale. Chaque champ de formulaire qui n'a pas de justification est une donnée que tu n'as pas le droit de collecter.

### Règle opérationnelle

Pour chaque champ de formulaire ou colonne de table BDD, une question : **"À quelle fonctionnalité précise cette donnée est-elle nécessaire ?"**

- Si la réponse est claire et vérifiable → on collecte.
- Si la réponse est floue ou hypothétique ("ça pourra peut-être servir un jour") → on ne collecte pas.

Cette vérification se fait au moment du `/archi`, quand le schéma de données est défini. C'est le bon moment : les tables et les champs sont dessinés, la justification fonctionnelle est encore fraîche.

### Exemples

| Donnée | Contexte | Verdict |
|---|---|---|
| Email | Authentification au service | ✅ Nécessaire |
| Numéro de téléphone | App associative avec annuaire des membres | ✅ Nécessaire |
| Photo de profil | App avec annuaire et page profil | ✅ Nécessaire |
| Date de naissance | App sans restriction d'âge ni calcul lié à l'âge | ❌ Non justifié |
| Adresse personnelle | App où seule l'adresse professionnelle est utile | ❌ Non justifié |
| Numéro de sécurité sociale | App qui n'a aucun lien avec la santé ou les droits sociaux | ❌ Non justifié |

### Durées de conservation

La minimisation s'applique aussi dans le temps : on ne garde pas les données indéfiniment. Définir pour chaque catégorie de données :

- **Durée active** : pendant combien de temps les données sont utilisées (durée du compte, durée de la relation commerciale).
- **Durée d'archivage** : certaines données doivent être conservées après la fin de la relation (ex : factures 10 ans). Elles sont alors inaccessibles aux utilisateurs normaux, conservées pour obligation légale uniquement.
- **Suppression automatique** : prévoir le mécanisme dès la conception du schéma BDD, pas après.

---

## 3 — Registre des traitements (art. 30)

Le registre des traitements est un document interne (non public) qui liste tous les traitements de données personnelles réalisés dans le cadre d'un projet. Ce n'est pas une formalité administrative — c'est le document que la CNIL peut demander à tout moment en cas de contrôle.

**Contrairement à ce qu'on pourrait croire : le registre est obligatoire pour tout le monde**, quelle que soit la taille de la structure. La dérogation partielle pour les structures de moins de 250 salariés est si étroite qu'elle couvre très peu de cas en pratique.

### Qui tient le registre selon le modèle du projet

**Modèle SaaS B2B (ex : RAMrezo)**

Deux acteurs, deux registres distincts :

- **Le client (ex : RAM)** est responsable de traitement — il décide pourquoi les données de ses membres sont collectées. C'est lui qui tient son registre en tant que responsable.
- **Toi (Medwin)** es sous-traitant — tu traites les données pour le compte du RAM, via l'app que tu as construite. Tu tiens un registre de sous-traitant qui liste les clients pour lesquels tu traites des données, et la nature de ce traitement.

En tant qu'éditeur SaaS, tu peux faciliter la conformité de tes clients en leur fournissant un modèle de registre pré-structuré, voire une page admin dans l'app pour les aider à le tenir. Ce n'est pas une obligation légale de ta part — c'est un service à valeur ajoutée.

**Modèle B2C (ex : Minou — app en direct avec les utilisateurs finaux)**

Tu es toi-même responsable de traitement. Tu tiens le registre directement.

### Contenu obligatoire du registre (par traitement)

| Champ | Exemple |
|---|---|
| Finalité du traitement | "Gestion des adhésions au club RAM" |
| Catégories de personnes concernées | Membres du club, administrateurs |
| Types de données collectées | Nom, email, téléphone, photo de profil, date d'adhésion |
| Destinataires des données | RAM (interne), Medwin (hébergeur), Supabase (infrastructure) |
| Durée de conservation | Durée de l'adhésion + 3 ans pour les obligations légales |
| Mesures de sécurité | Chiffrement au repos AES-256 (Supabase), HTTPS, RLS activé |
| Transferts hors UE | Supabase Frankfurt (EU) — pas de transfert hors UE |
| Responsable de traitement | Nom, adresse, email de contact |

### Quand le créer

Dès le `/archi`, au moment où le schéma de données est défini. On sait à ce stade quelles données sont collectées, pourquoi, et chez quel hébergeur. C'est le moment de remplir le registre.

### Format

Un tableau dans un document (Google Sheets, Notion, ou fichier `.md` dans le repo). Pas besoin d'outil spécifique. Ce document est tenu à jour à chaque ajout de feature qui modifie les données collectées.

---

## 4 — Droits des utilisateurs (art. 15-22)

Tout utilisateur dont tu collectes des données dispose de 9 droits reconnus par le RGPD. Ces droits génèrent des fonctions concrètes dans le code et des boutons dans l'interface — pas par choix de design, mais par obligation légale. Le délai de réponse à toute demande d'exercice d'un droit est d'**1 mois**.

### Les 9 droits

| Droit | Article | Ce que ça signifie |
|---|---|---|
| Droit à l'information | Art. 13-14 | Être informé de la collecte avant qu'elle ait lieu (→ politique de confidentialité) |
| Droit d'accès | Art. 15 | Obtenir une copie de toutes les données détenues |
| Droit de rectification | Art. 16 | Corriger des données inexactes ou incomplètes |
| Droit à l'effacement | Art. 17 | Demander la suppression de toutes les données |
| Droit à la limitation | Art. 18 | Geler les données sans les supprimer (en cas de litige) |
| Droit à la portabilité | Art. 20 | Recevoir ses données dans un format réutilisable (JSON, CSV) |
| Droit d'opposition | Art. 21 | S'opposer à certains traitements (ex : marketing) |
| Droit contre la décision automatisée | Art. 22 | Demander une intervention humaine sur toute décision automatisée |
| Droit au déréférencement | — | Demander à un moteur de recherche de supprimer une référence — ne s'applique pas aux apps web |

### Implémentation selon le modèle du projet

**Modèle SaaS B2B (RAMrezo)**

Les membres exercent leurs droits auprès du RAM (le responsable de traitement), pas auprès de Medwin directement. Le RAM répond à ces demandes via l'interface admin de l'app.

Ce que tu mets en place dans le code :

- Interface **admin** : bouton "Supprimer ce membre" (effacement), "Exporter les données de ce membre" (portabilité), "Modifier les données de ce membre" (rectification).
- Interface **membre** : formulaire de modification de son propre profil (rectification en self-service).
- L'effacement complet supprime toutes les données de l'utilisateur — pas juste désactiver le compte. Prévoir la cascade de suppression dès le schéma BDD.

**Modèle B2C (Minou)**

Les utilisateurs exercent leurs droits directement via leur espace personnel ou par email. Ce que tu mets en place :

- Bouton "Supprimer mon compte" dans les paramètres → suppression réelle de toutes les données.
- Bouton ou endpoint "Exporter mes données" → archive JSON ou CSV.
- Formulaire de contact dédié pour les demandes d'accès et d'opposition.

### Point d'attention sur l'effacement

"Supprimer un compte" ne suffit pas. L'effacement RGPD implique de supprimer toutes les données liées : entrées en BDD, fichiers uploadés, logs d'activité contenant des données personnelles, données dans les services tiers (emails envoyés par SendGrid, etc.). Prévoir cette cascade dès la conception du schéma.

---

## 5 — Gestion du consentement

Le consentement, c'est un accord **explicite, libre, éclairé et révocable** donné par l'utilisateur **avant** que le traitement commence. Une case pré-cochée, un accord implicite ou un accord obtenu par défaut ne sont pas des consentements valables.

Deux sous-sujets : les cookies, et les consentements liés aux communications.

### Cookies — ce qui est exempté de consentement

Certains cookies peuvent être déposés sans demander l'accord de l'utilisateur, parce qu'ils sont strictement nécessaires au fonctionnement du service :

- Cookies de session d'authentification (maintenir l'utilisateur connecté)
- Cookies techniques indispensables (panier, préférences de langue, CSRF token)
- Cookies de mesure d'audience **strictement anonymes** : Plausible Analytics, AT Internet en mode anonyme — à condition que les données ne soient pas transmises à des tiers et que l'anonymisation soit réelle

### Cookies nécessitant un consentement explicite

Tout le reste nécessite un accord préalable avant dépôt :

- Google Analytics (même GA4 dans sa configuration par défaut)
- Pixels publicitaires (Meta Pixel, Google Ads, etc.)
- Outils de heatmap et enregistrement de sessions (Hotjar, etc.)
- Cookies de partage social (boutons Facebook, Twitter intégrés)
- Tout cookie tiers à des fins de ciblage publicitaire

### Bannière de consentement — ce qui est valable

- Le bouton "Accepter" et le bouton "Refuser" doivent être aussi visibles et accessibles l'un que l'autre.
- L'utilisateur peut continuer à utiliser le site même en cas de refus (sauf si le cookie est strictement nécessaire).
- L'accord ou le refus doit être enregistré et respecté.
- Le refus ne peut pas être pénalisé (pas de dégradation volontaire du service).
- Le consentement peut être retiré à tout moment aussi facilement qu'il a été donné.

### Consentement pour les communications (emails marketing, notifications)

- Checkbox non pré-cochée et distincte des CGU lors de l'inscription.
- Lien de désinscription fonctionnel dans chaque email commercial.
- Conserver la preuve du consentement (date, source, version du formulaire).

### Consentement vs base légale "contrat"

Si l'email est nécessaire pour créer le compte et fournir le service, la base légale est le contrat (pas le consentement). On ne redemande pas un consentement pour quelque chose qui relève du contrat. Le consentement s'utilise uniquement pour les traitements qui vont au-delà du service de base.

---

## 6 — Politique de confidentialité

La politique de confidentialité est la page publique qui explique aux utilisateurs ce que tu fais de leurs données. C'est une obligation légale dès que tu collectes une donnée personnelle — y compris une adresse email. Elle n'est pas optionnelle et ne peut pas être rédigée après le lancement.

### Contenu obligatoire

- Identité et coordonnées du responsable de traitement
- Données collectées et finalités de chaque traitement
- Base légale de chaque traitement
- Durées de conservation
- Destinataires des données (sous-traitants, partenaires)
- Transferts hors UE éventuels et garanties associées
- Droits des utilisateurs et comment les exercer (email de contact ou formulaire dédié)
- Droit de déposer une plainte auprès de la CNIL (cnil.fr)
- Date de dernière mise à jour

### Quand la créer

Avant la mise en production. C'est une des cases de la checklist de conformité finale (section 12).

### Où la publier

- Lien dans le **footer** de toutes les pages publiques du site ou de l'app
- Lien explicite dans le **formulaire d'inscription** (avant validation)
- Lien dans la **bannière de consentement** cookies

### Comment la tenir à jour

La politique de confidentialité doit refléter la réalité des traitements. Toute nouvelle feature qui collecte une nouvelle donnée ou introduit un nouveau sous-traitant déclenche une mise à jour de la politique. Informer les utilisateurs existants des changements significatifs.

### Templates

Un template de politique de confidentialité sera rédigé au moment du premier projet qui en a besoin. Ce fichier documente ce qu'il doit contenir — le template lui-même vit dans le repo du projet concerné.

---

## 7 — Sous-traitants et DPA (art. 28)

Un sous-traitant est tout service tiers qui traite des données personnelles pour ton compte : hébergeur de base de données, service d'emailing, service d'authentification, outil d'analytics, etc. Le RGPD impose de signer un accord écrit (DPA — Data Processing Agreement) avec chaque sous-traitant avant toute mise en production.

### Règle générale

**Tout fournisseur qui traite tes données = DPA obligatoire.**

Ce contrat précise : la nature et la finalité du traitement, les catégories de données, la durée, les obligations de sécurité du sous-traitant, les conditions de suppression des données à la fin du contrat.

### DPA des fournisseurs standard vibe-method

La liste des fournisseurs déjà documentés (Supabase, Convex, GitHub, GitLab) et leurs procédures de DPA sont dans `architecture.md` — section "Backup & conformité RGPD".

Pour tout nouveau fournisseur introduit dans un projet : chercher "DPA" ou "Data Processing Agreement" sur le site officiel du fournisseur. Si aucun DPA n'est disponible, ce fournisseur ne peut pas être utilisé pour traiter des données personnelles EU.

### Le cas SaaS B2B — tu es toi-même sous-traitant de ton client

Quand tu vends une app SaaS à une organisation (ex : RAMrezo vendu au RAM) :

- Le RAM est responsable de traitement (il décide pourquoi les données de ses membres sont collectées).
- Toi, tu es sous-traitant (tu fournis l'infrastructure et le service qui traite ces données).

Dans ce cas, tu dois signer un DPA avec ton client. Opérationnellement, ce DPA prend la forme d'une **annexe à tes CGU**, acceptée électroniquement lors de l'inscription du client au service. C'est légalement valable — pas besoin de document papier ni de signature manuscrite.

Ce DPA client doit contenir : liste des données traitées pour son compte, finalités, durée, mesures de sécurité mises en place, engagement de sous-traitance uniquement aux fournisseurs couverts par leur propre DPA.

---

## 8 — Transferts hors UE

Le RGPD interdit par défaut le transfert de données personnelles vers des pays hors UE qui n'offrent pas un niveau de protection équivalent. Or, plusieurs services standard de la vibe-method sont hébergés aux États-Unis : Vercel, GitHub, Convex, SendGrid.

### Le Data Privacy Framework (DPF) — accord EU-USA en vigueur depuis 2023

Depuis juillet 2023, un accord entre l'UE et les États-Unis (Data Privacy Framework) légalise les transferts de données personnelles vers les entreprises américaines **certifiées DPF**. Pour vérifier si un fournisseur est certifié : consulter le registre officiel sur `dataprivacyframework.gov` et rechercher le nom du fournisseur.

### Situation des fournisseurs standard vibe-method

| Fournisseur | Localisation | Couverture | Action |
|---|---|---|---|
| Supabase (région Frankfurt) | EU | Données restent en EU — pas de transfert | Choisir Frankfurt à la création |
| Convex | USA | DPF à vérifier sur dataprivacyframework.gov | Vérifier avant production |
| Vercel | USA | Vérifier DPF | Vérifier avant production |
| GitHub | USA (Microsoft) | Microsoft certifié DPF | DPA Microsoft disponible |
| GitLab.com | USA | Vérifier DPF | Vérifier avant production |
| SendGrid | USA (Twilio) | Twilio certifié DPF | DPA Twilio disponible |

### Règle

- **Supabase Frankfurt** = solution la plus simple pour les données EU — les données ne quittent pas l'UE.
- Pour les autres fournisseurs US : vérifier la certification DPF avant la mise en production. Si le fournisseur n'est pas certifié DPF, il faut des clauses contractuelles types (CCT) dans le DPA — ou changer de fournisseur.
- Documenter les transferts hors UE dans le registre des traitements.

---

## 9 — Violation de données (art. 33-34)

Une violation de données, c'est tout incident de sécurité qui entraîne la destruction, la perte, l'altération, la divulgation non autorisée ou l'accès non autorisé à des données personnelles. Une base de données qui fuite, un accès non autorisé à un compte admin, un dump non chiffré exposé publiquement : tout ça déclenche les obligations RGPD.

### Ce qui déclenche l'obligation de notification

- Vol ou fuite d'une base de données contenant des données personnelles
- Accès non autorisé à l'interface admin ou à la BDD
- Envoi accidentel de données personnelles à la mauvaise personne
- Perte de données sans possibilité de restauration (si les données sont personnelles)

Ce qui ne déclenche pas forcément (à évaluer au cas par cas) : incident purement interne sans exposition de données à des tiers, crash serveur sans perte de données.

### Procédure en cas de violation

1. **Détecter et contenir** — isoler le problème, couper les accès si nécessaire.
2. **Évaluer la gravité** — quelles données sont concernées, combien de personnes, quel risque pour elles.
3. **Notifier la CNIL sous 72h** depuis la découverte de la violation, via le portail : `notifications.cnil.fr`. Ce délai s'applique même si l'évaluation est incomplète — on notifie avec les éléments disponibles et on complète ensuite.
4. **Notifier les utilisateurs concernés** si la violation est susceptible d'engendrer un risque élevé pour leurs droits (ex : vol de données bancaires, données de santé, identifiants permettant une usurpation d'identité).
5. **Documenter** dans le registre des violations — même les violations non notifiées doivent être tracées.

### Registre des violations

Distinct du registre des traitements. Il liste tous les incidents, qu'ils aient été notifiés ou non, avec : date, nature de l'incident, données concernées, mesures prises, décision de notification ou non et justification. La CNIL peut le demander.

### Prévention

Les mesures qui réduisent le risque de violation et son impact :
- Chiffrement des données au repos (Supabase Frankfurt l'inclut nativement)
- Chiffrement des dumps (GPG — voir `architecture.md`)
- RLS activé sur toutes les tables contenant des données personnelles
- Accès admin restreint aux personnes strictement nécessaires
- Monitoring et alertes (UptimeRobot, logs d'accès)

---

## 10 — DPIA et DPO

Deux obligations qui semblent complexes mais qui, pour la grande majorité des projets vibe-method (PME, associations, apps SaaS B2B standards), ne s'appliquent pas. Ce chapitre donne les critères pour en être sûr.

### DPIA — Analyse d'impact sur la protection des données (art. 35)

**Ce que c'est :** une étude formelle obligatoire avant de lancer un traitement présentant un "risque élevé" pour les droits des personnes.

**Quand c'est obligatoire :** au moins deux des critères suivants sont réunis :
- Évaluation ou notation/profilage intensif des personnes
- Décision automatisée avec effet légal ou significatif
- Surveillance systématique à grande échelle (géolocalisation en temps réel, vidéosurveillance)
- Données sensibles à grande échelle (santé, opinions politiques, données biométriques)
- Données de personnes vulnérables (mineurs, patients)
- Croisement de bases de données provenant de sources différentes

**Pour les projets vibe-method standards :** très probablement non obligatoire. Une app de gestion d'adhésions associatives, un chat multi-LLM pour des professionnels, un outil de gestion de réseau B2B ne remplissent généralement pas ces critères. Vérifier au cas par cas au `/archi`.

### DPO — Délégué à la Protection des Données (art. 37)

**Ce que c'est :** un responsable désigné pour superviser la conformité RGPD d'une organisation.

**Quand c'est obligatoire :**
- Autorités et organismes publics
- Organisations dont l'activité principale implique un suivi régulier et systématique des personnes à grande échelle
- Organisations traitant des données sensibles à grande échelle

**Pour les projets vibe-method standards :** non obligatoire. Le RAM, une PME, une association standard n'ont pas l'obligation de nommer un DPO.

**Bonne pratique :** même si non obligatoire, désigner un "référent RGPD" interne (une personne qui centralise les demandes d'exercice de droits et tient les registres à jour). Pour le RAM, c'est probablement l'admin de l'app. Pour Medwin en tant qu'éditeur, c'est Medwin lui-même.

---

## 11 — Hooks avec les skills

Le RGPD n'est pas une étape unique — c'est une série de vérifications distribuées dans toute la chaîne de création. Voici où chaque obligation RGPD s'ancre dans la vibe-method.

| Skill | Actions RGPD à ce stade |
|---|---|
| `/brief` | Identifier le type de données collectées et la population concernée (membres, professionnels, mineurs ?) |
| `/archi` | Déclarer chaque donnée collectée + sa base légale + sa durée de conservation. Vérifier la minimisation champ par champ. Identifier les sous-traitants et vérifier leurs DPA. Identifier si DPIA nécessaire. Créer le registre des traitements. |
| `/specs` | Chaque feature qui collecte ou modifie une donnée personnelle déclare sa base légale et sa durée de rétention. Inclure les fonctions "droits utilisateurs" (suppression, export, rectification) dans les specs concernées. |
| `/stack` | Vérifier pour chaque service : région d'hébergement, DPA disponible, certification DPF si fournisseur US. |
| `/deploy` | Vérifier la checklist de conformité complète (section 12) avant toute mise en production. |
| `/code-review` | Vérifier que les fonctions d'effacement suppriment vraiment toutes les données (pas juste désactiver le compte). Vérifier que les exports incluent toutes les données. Vérifier que le RLS est activé sur les tables contenant des données personnelles. |

**Note :** les skills eux-mêmes seront mis à jour pour intégrer ces points de vérification explicitement. C'est l'objet de la tâche 3 (audit et enrichissement des skills).

---

## 12 — Checklist de conformité avant mise en production

À vérifier intégralement avant tout déploiement en production. Une case non cochée = la mise en prod est bloquée.

### Fondations

- [ ] Base légale définie pour chaque traitement de données
- [ ] Registre des traitements créé et rempli
- [ ] DPA signé avec chaque sous-traitant (Supabase, Vercel, service d'emailing, etc.)
- [ ] Si SaaS B2B : DPA inclus dans les CGU, accepté électroniquement à l'inscription

### Interface

- [ ] Politique de confidentialité rédigée et publiée (lien dans le footer)
- [ ] Lien vers la politique de confidentialité dans le formulaire d'inscription
- [ ] Bannière de consentement cookies en place (si cookies non exemptés utilisés)
- [ ] Bouton "Refuser" aussi visible que "Accepter" dans la bannière

### Droits utilisateurs

- [ ] Fonction d'effacement de compte implémentée et testée (suppression réelle de toutes les données)
- [ ] Fonction d'export des données implémentée (JSON ou CSV)
- [ ] Formulaire de modification du profil fonctionnel (rectification)
- [ ] Email ou formulaire de contact pour les demandes de droits publié dans la politique de confidentialité

### Sécurité des données

- [ ] RLS activé sur toutes les tables contenant des données personnelles
- [ ] Hébergeur en région EU (Supabase Frankfurt) ou DPF vérifié pour les fournisseurs US
- [ ] Chiffrement au repos et en transit confirmé (natif Supabase Frankfurt)
- [ ] Dumps chiffrés GPG (voir `architecture.md`)

### Si applicable

- [ ] DPIA réalisée (si critères remplis — section 10)
- [ ] DPO nommé (si obligatoire — section 10)
- [ ] Procédure de gestion des violations documentée (section 9)

---

*Source : CNIL — cnil.fr. Toute question sur une obligation spécifique → consulter la CNIL en priorité.*
