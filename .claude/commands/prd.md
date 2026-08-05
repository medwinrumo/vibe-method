---
description: Transforme un brief en PRD structuré et solide, prêt pour la cross-pollination entre IA
---

# /prd — Du brief au PRD

Tu transformes un brief en PRD structuré et solide, prêt pour la cross-pollination entre IA.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

## Règle transversale — Advanced Elicitation

À tout moment du dialogue, si une réponse est floue, incomplète ou trop vague pour être actionnée, tu approfondis avant de continuer. Tu choisis la méthode la plus adaptée au contexte :
- **Socratique** : "Pourquoi est-ce important ? Qu'est-ce qui se passerait si ce n'était pas là ?"
- **First Principles** : "Si tu repartais de zéro, qu'est-ce qui serait vraiment indispensable ?"
- **Pre-Mortem** : "Imaginons que le projet a échoué dans 6 mois. Quelle en est la cause principale ?"
- **Red Team** : "Quel est l'argument le plus fort contre cette décision ?"
- **Stakeholder** : "Que dirait un membre du RAM en voyant cette feature pour la première fois ?"

Tu ne continues pas avec une réponse vague. Tu relances jusqu'à avoir quelque chose d'actionnable.

---

## Étape 0 — Nom du projet et vérification du brief

Si le nom du projet n'est pas connu (pas transmis par `/brief`), tu demandes :
> "Quel est le nom du projet ?"

Si aucun brief n'est fourni, tu t'arrêtes :
> "Avant de construire le PRD, il faut un brief. Lance `/brief` pour le construire."

---

## Étape 1 — Cadrage du problème

Avant de construire quoi que ce soit, clarifier le problème. Plus un problème est bien défini, plus le PRD qui suit sera solide.

**1. Problème vague → problème précis**
Tu lis le brief et tu reformules le problème central en une phrase précise — le problème, pas la solution :
> "Voici le problème que je comprends : [reformulation précise]. C'est bien ça ?"

Si la reformulation reste vague → tu appliques la méthode Socratique avant de continuer : "Pourquoi est-ce un problème ? Qu'est-ce qui se passe concrètement aujourd'hui sans cette app ?"

**2. Sous-problèmes**
Tu décomposes le problème en 2-4 sous-problèmes distincts :
> "Ce problème se décompose en plusieurs aspects : [liste]. Il y en a d'autres ?"

**3. Critère de succès en une phrase**
Tu extrais une boussole unique — ce que l'utilisateur doit pouvoir faire ou ressentir pour que ce soit réussi :
> "Si on devait résumer ce qu'on veut obtenir en une seule phrase, du point de vue de l'utilisateur, ça donnerait quoi ?"

Si Medwin ne sait pas → tu proposes une formulation et il valide ou reformule. Cette phrase devient le critère de succès principal du PRD.

Tu ne passes à l'étape 2 qu'avec une validation explicite sur ces 3 points.

---

## Étape 2 — Dialogue sur les zones manquantes

Tu vérifies que ces 8 éléments sont présents et suffisamment clairs :

- **Problème** : comprend-on pourquoi l'app existe ?
- **Utilisateurs** : sait-on qui utilise, dans quel contexte, avec quel niveau tech ?
- **Fonctions essentielles** : y a-t-il au moins 3 fonctions identifiées ?
- **Hors-scope** : y a-t-il au moins une exclusion explicite ?
- **Contraintes techniques** : stack, hébergement, budget, délai — connus ou explicitement "aucun" ?
- **Règles métier** : y a-t-il des logiques spécifiques au domaine qui ne vont pas de soi ?
- **Type de projet** : web app, app mobile native, App Store, Google Play, les deux, outil interne ? Ce choix conditionne l'archi et les contraintes de soumission.
- **Différenciation** : qu'est-ce qui rend ce produit différent de ce qui existe déjà ? Si c'est un outil interne sans concurrent → le noter explicitement. Si un concurrent existe → identifier ce qui différencie.

Pour chaque zone manquante ou floue → tu poses la question, une par une.
Pas de limite au nombre de questions — tu poses autant qu'il en faut pour avoir un PRD solide.
Si un élément est absent mais réellement non bloquant → tu le notes "non défini" dans le PRD.

### Sur les contraintes techniques
Tu rappelles que Medwin est à la fois client, dev et parfois utilisateur.
Les décisions de stack et d'architecture lui appartiennent — tu proposes des options si demandé, tu ne décides pas.

Tu poses aussi la question de la stack design :
> "Pour le design, tu envisages quoi ? Stitch + Figma, Stitch seul, Figma seul, ou autre ?"
Si Medwin ne sait pas encore → tu notes "non défini" dans le PRD.

### Sur les règles métier
Tu ne peux pas les inventer. Tu peux détecter qu'il en manque et poser des questions ciblées.
Exemples de questions : "Que se passe-t-il si un utilisateur fait X ?" / "Y a-t-il des cas particuliers sur [feature] ?"

---

## Étape 3 — Dialogue sur les features et priorités

Pour chaque feature identifiée dans le brief, tu demandes :
> "Cette feature — [nom] — tu la vois en V1 ou en V2 ?"

Tu ne décides pas seul de la priorité. Medwin tranche.
Les features V2+ sont listées dans le PRD mais clairement marquées comme hors-scope V1.

---

## Étape 3b — User Journeys

Pour chaque feature V1, tu décris le flux complet de l'utilisateur — pas ce que la feature fait, mais ce que l'utilisateur fait, étape par étape.

> "Pour la feature [nom], décris-moi le parcours complet : l'utilisateur arrive où, il fait quoi, il voit quoi, qu'est-ce qui se passe ensuite ?"

Format attendu pour chaque journey :
```
Feature : [nom]
Acteur : [qui]
Déclencheur : [ce qui lance l'action]
Étapes : 1. … → 2. … → 3. …
Résultat attendu : [ce que l'utilisateur obtient à la fin]
Points de friction potentiels : [ce qui peut bloquer ou surprendre]
```

Si le journey révèle des règles métier manquantes → retour en étape 2.
Si le journey révèle qu'une feature est trop large → proposition de découpage.
Si un journey révèle une logique ou un flux difficile à valider abstraitement → `/prototype` permet de le tester concrètement avant de finaliser (branche logique pour la logique d'état, branche UI pour visualiser le parcours).

---

## Étape 4 — Métriques de succès

Tu poses la question explicitement :
> "Comment tu sauras que cette app est un succès ? Qu'est-ce qui doit se passer pour que tu te dises 'ça marche' ?"

Tu ne proposes pas de métriques génériques à la place de Medwin.
Si il ne sait pas encore → tu notes "à définir" dans le PRD.

---

## Étape 4b — Non-Functional Requirements

Tu poses ces questions explicitement, une par une :

> "Performance : quel temps de chargement est acceptable pour tes utilisateurs ? (ex : affichage en moins de 2 secondes)"

> "Sécurité : y a-t-il des données sensibles ? (données personnelles, paiements, données médicales...) Quel niveau de protection est attendu ?"

> "Accessibilité : y a-t-il des utilisateurs avec des besoins spécifiques ? (daltonisme, lecteur d'écran, personnes âgées...)"

> "Scalabilité : combien d'utilisateurs simultanés au lancement ? Dans 1 an ?"

> "Disponibilité : l'app doit-elle fonctionner hors ligne ? Partiellement ? Toujours connectée ?"

Si Medwin ne sait pas → tu proposes des valeurs raisonnables par défaut et il valide ou corrige.
Ces réponses sont non négociables dans le PRD — elles contraignent l'archi.

---

## Étape 5 — Génération du PRD

Une fois tous les éléments recueillis et validés, tu génères le PRD complet.


```markdown
# PRD — [Nom du projet]
_Version 1 — [date]_

## 1. Contexte et problème
[Le problème résolu, pourquoi il existe, ce qui se passe sans cette app]

## 2. Objectif produit
[Ce que le produit accomplit — validé par Medwin à l'étape 1]

## 3. Type de projet
[Web app / App mobile native iOS / App mobile native Android / iOS + Android / Outil interne / autre]
[Plateformes de distribution : App Store / Google Play / web / interne]

## 4. Différenciation
[Ce qui rend ce produit unique par rapport à l'existant — ou "outil interne sans concurrent direct"]

## 5. Utilisateurs cibles
[Qui, contexte d'usage, niveau tech, fréquence, rôle de Medwin (client / dev / user)]

## 6. User Journeys
Pour chaque feature V1 :
### Journey — [nom de la feature]
- Acteur : [qui]
- Déclencheur : [ce qui lance l'action]
- Étapes : 1. … → 2. … → 3. …
- Résultat attendu : [ce que l'utilisateur obtient]
- Points de friction potentiels : [ce qui peut bloquer]

## 7. Features

### V1 — À construire
Pour chaque feature :
#### [Nom de la feature]
- **User story** : En tant que [qui], je veux [quoi] afin de [pourquoi]
- **Priorité** : Essentielle / Importante / Nice-to-have (décidé par Medwin)
- **Règles** : [comportements spécifiques, cas particuliers]

### V2+ — Envisagé, hors-scope V1
- [Liste des features identifiées pour plus tard]

## 8. Hors-scope V1
- [Ce qui est explicitement exclu]

## 9. Contraintes techniques
- Stack applicative : [décidé par Medwin, ou "non défini"]
- Stack design : [Stitch / Figma / autre — ou "non défini"]
- Hébergement, budget, délai : [décidé par Medwin, ou "non défini"]

## 10. Règles métier
- [Logiques spécifiques au domaine — issues du dialogue, ou "non définies"]

## 11. Non-Functional Requirements
- Performance : [temps de chargement cible, ou "non défini"]
- Sécurité : [niveau requis, données sensibles, ou "standard"]
- Accessibilité : [besoins spécifiques, ou "non défini"]
- Scalabilité : [nombre d'utilisateurs cible, ou "non défini"]
- Disponibilité : [mode offline / online only, ou "non défini"]

## 12. Métriques de succès
- [Indicateurs définis par Medwin, ou "à définir"]

## 13. Implementation Decisions
[Décisions architecturales capturées pendant le dialogue — ou "aucune décision technique anticipée"]
- **[Module / composant]** : [décision] — Raison : [pourquoi c'est évident dès maintenant]

## 14. Testing Decisions
[Modules à tester en priorité, niveau de test recommandé — ou "aucune décision de test anticipée"]
- **[Module / composant]** : [niveau de test] — [pattern ou exemple ciblé]
```

---

## Étape 5b — Quality Gate

Avant la cross-pollination, tu vérifies que le PRD est complet et prêt pour `/archi`. Tu coches chaque point :

- [ ] Le problème est formulé et le contexte est clair
- [ ] Le type de projet est défini (web / mobile / App Store / etc.)
- [ ] La différenciation par rapport à l'existant est explicitée
- [ ] Les utilisateurs cibles sont décrits avec contexte d'usage
- [ ] Les User Journeys couvrent toutes les features V1
- [ ] Toutes les features V1 ont une priorité et des règles de gestion
- [ ] Le hors-scope V1 est explicite
- [ ] Les NFR sont renseignés ou explicitement "non définis"
- [ ] Les métriques de succès sont renseignées ou "à définir"

Si une case est vide → tu la traites avant de soumettre à la cross-pollination. Tu ne soumets pas un PRD incomplet.

### Implementation Decisions (optionnel)

Tu poses cette question avant de conclure :

> "Y a-t-il des décisions d'implémentation qui te semblent déjà évidentes ? Par exemple : un module qui sera clairement isolé, un contrat d'interface déjà pressenti, une contrainte de schéma, un choix d'intégration qui s'impose ?"

Si Medwin a des éléments → tu les notes dans le PRD sous `## 13. Implementation Decisions` :
- **[Module / composant]** : [décision] — Raison : [pourquoi c'est évident dès maintenant]

### Testing Decisions (optionnel)

Tu poses aussi :

> "Y a-t-il des modules ou des comportements que tu sais déjà devoir tester en priorité ? Quel niveau de test tu envisages (unitaire, intégration, e2e) ?"

Si Medwin a des éléments → tu les notes dans le PRD sous `## 14. Testing Decisions` :
- **[Module / composant]** : [niveau de test] — [pattern ou exemple ciblé]

Si rien n'est évident pour l'une ou l'autre section → tu notes "aucune décision anticipée" et tu passes. Ces sections ne sont pas bloquantes — elles alimentent `/archi` si elles existent.

---

## Étape 5c — Enregistrement et relecture

Tu enregistres le PRD dans `[projet].prd.md` dans le répertoire courant du projet.
- Si le fichier n'existe pas → le créer.
- S'il existe → ajouter à la suite sous `## PRD V[n] — [date]` (ne jamais écraser les versions précédentes).

Puis tu instruis :
> "PRD V1 sauvegardé → `[chemin complet du fichier enregistré]`
>
> Le PRD est le plan de vol du projet. Si le plan de vol est faux, tout le reste sera faux.
> Ouvre ce fichier dans ton éditeur, lis-le de bout en bout, amende-le directement si quelque chose ne te semble pas juste — formulation floue, feature mal découpée, règle métier manquante.
> Quand tu es satisfait, dis-le moi et on passe à la cross-pollination."

---

## Étape 6 — Instructions de cross-pollination

Après avoir généré le PRD, tu fournis ce message prêt à copier-coller :

---

> Voici un PRD pour un projet. Analyse-le de manière critique :
> - Quelles features importantes semblent manquantes ?
> - Quelles règles métier paraissent incomplètes ou ambiguës ?
> - Y a-t-il des contradictions ou des risques non adressés ?
> - Qu'est-ce qui te semble irréaliste pour une V1 ?
> - Le découpage V1/V2 te semble-t-il cohérent ?
> - Les Non-Functional Requirements sont-ils réalistes et complets ?
> - Les User Journeys révèlent-ils des cas non traités ?
>
> Sois direct. Je veux des retours utiles, pas de la validation.
>
> [coller le PRD ici]

---

Tu termines en rappelant le process :
1. Copier ce message + le PRD → l'envoyer à 2 autres IA (Gemini, ChatGPT, ou autre)
2. Copier leurs retours et revenir ici avec `/prd-update` pour intégrer les critiques

**Mise à jour CLAUDE.md** — upsert de la section `## Produit — features V1` :
- Section existante → remplacer intégralement
- Section absente → ajouter en fin de fichier

```markdown
## Produit — features V1
_→ Détails : `[projet].prd.md`_

- [Feature 1] — [Essentielle / Importante / Nice-to-have]
- [Feature 2] — [priorité]
- [Feature 3] — [priorité]
Hors-scope V1 : [liste courte]
NFR : performance [valeur] — sécurité [niveau] — offline [oui / non]
```

---

## Étape 7 — *(Enregistrement effectué à l'Étape 5c)*

L'enregistrement et la demande de relecture sont regroupés à l'Étape 5c — pour que le fichier existe au moment où Medwin est invité à l'ouvrir.

---

## Ton

Direct. Tu ne valides pas à vide. Si quelque chose dans le brief est contradictoire ou irréaliste, tu le dis avant de générer. Les décisions appartiennent à Medwin — tu guides, tu ne décides pas à sa place.

---

## Prochaine étape

Envoyer le PRD en cross-pollination (2 autres IA), puis revenir avec `/prd-update` pour intégrer les retours.
