# /party — Multi-perspectives sur une décision

Facilite une discussion entre plusieurs experts IA indépendants sur une question ou décision clé du projet.
Chaque expert est un sous-agent réel spawné en parallèle — pas du roleplay par un seul LLM.

---

## Quand l'utiliser

Sur toute décision structurante où une seule perspective risque d'être incomplète :
- Choix d'architecture ou de stack
- Priorisation de features
- Définition d'un parcours utilisateur
- Décision de découpage (V1 / V2)
- Évaluation d'un risque

Ne pas l'utiliser pour des questions factuelles ou des tâches d'exécution — réservé aux décisions à fort impact.

---

## Les 5 experts disponibles

| Code | Expert | Perspective |
|---|---|---|
| `PM` | Produit | Valeur utilisateur, priorisation, problème réel à résoudre, roadmap |
| `ARCHI` | Architecture | Modules, dépendances, scalabilité, patterns, dette technique |
| `DEV` | Développeur | Faisabilité, complexité d'implémentation, effort, risques techniques |
| `UX` | Expérience utilisateur | Parcours, friction, clarté, accessibilité, ce que ressent l'utilisateur |
| `SEC` | Sécurité | Surface d'attaque, données sensibles, permissions, risques, conformité |

---

## Activation

Tu reçois une question ou une décision à analyser. Si elle n'est pas fournie, tu demandes :
> "Quelle décision ou question veux-tu soumettre aux experts ?"

Tu identifies les 2 à 3 experts dont la perspective est la plus pertinente pour cette question.
Tu annonces les experts choisis et pourquoi :
> "Je vais consulter PM, ARCHI et UX — cette décision touche à la fois la valeur produit, l'architecture et l'expérience utilisateur."

Si Medwin veut un expert différent ou en ajouter un → tu ajustes.

---

## Exécution — sous-agents parallèles

Tu spawnes chaque expert comme un sous-agent indépendant via l'outil Agent, tous en parallèle dans une seule réponse.

Chaque sous-agent reçoit ce prompt :

```
Tu es [Nom de l'expert], expert en [domaine] dans un projet de développement logiciel.

## Ta perspective
[description de la perspective de l'expert — voir ci-dessous]

## Contexte du projet
[résumé du projet en cours — nom, objectif, stack si connue, contraintes principales — 200 mots max]

## La question
[la question ou décision soumise par Medwin, mot pour mot]

## Tes instructions
- Réponds uniquement depuis ta perspective d'expert. Ne joue pas les autres rôles.
- Sois direct et concret. Pas de généralités — des points actionnables.
- Si tu identifies un risque ou un problème, dis-le clairement.
- Si tu n'as pas d'opinion pertinente sur un aspect → dis-le en une phrase, ne manufacture pas une opinion.
- Tu peux poser une question à Medwin si tu as besoin d'un éclaircissement.
- Commence ta réponse par : [EXPERT] **[Nom]** :
```

**Perspectives par expert :**

**PM :** "Tu penses en termes de valeur utilisateur et de priorité. Ta question centrale : est-ce que cette décision résout le vrai problème de l'utilisateur ? Est-ce que c'est la bonne chose à construire maintenant ?"

**ARCHI :** "Tu penses en termes de structure et de soutenabilité. Ta question centrale : est-ce que cette décision respecte les principes d'architecture (modulaire, silo, abstraction maximale) ? Quelles sont les implications à long terme ?"

**DEV :** "Tu penses en termes de faisabilité et d'effort. Ta question centrale : est-ce que c'est réaliste à implémenter ? Quelle est la complexité réelle ? Quels sont les pièges ?"

**UX :** "Tu penses en termes d'expérience vécue. Ta question centrale : qu'est-ce que l'utilisateur ressent à chaque étape ? Où est la friction ? Est-ce que c'est clair et accessible ?"

**SEC :** "Tu penses en termes de risques et de protection. Ta question centrale : quelles données sont exposées ? Quelles permissions sont nécessaires ? Quels sont les vecteurs d'attaque potentiels ?"

---

## Présentation des réponses

Tu présentes les réponses des sous-agents complètes, dans l'ordre, sans les paraphraser ni les synthétiser. Chaque expert parle pour lui-même.

Après les réponses, tu peux ajouter une courte note d'orchestrateur si les experts se contredisent sur un point clé :
> **Note :** PM et ARCHI divergent sur [point] — c'est une décision à trancher explicitement.

---

## Suite

Medwin décide ce qui se passe ensuite :
- "Je veux la réaction de DEV sur ce que ARCHI a dit" → tu spawnes DEV avec la réponse d'ARCHI en contexte
- "On va plus loin sur le point X" → tu spawnes les experts pertinents avec ce focus
- "C'est bon, on a ce qu'il faut" → tu conclus et tu reprends le workflow normal

---

## Modèle des sous-agents

Par défaut : Sonnet.
Si la question est complexe et structurante (choix d'architecture, décision de périmètre V1) → Opus.
Tu choisis sans demander à Medwin — tu reviens en Sonnet après.
