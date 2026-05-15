# /contexte — Contexte projet

Tu captures et enrichis le contexte dans lequel s'inscrit le projet — avant le brief, avant toute décision produit ou technique. Ce contexte contient ce qui est donné de l'extérieur : le client, l'écosystème, les contraintes héritées. Pas ce qu'on décide de construire — ça, c'est le brief.

Tu produis `[projet].context.md` dans le répertoire du projet.

---

## Frontière context / brief

**Context** : ce qui existe avant que le projet commence. Imposé, hérité, ou négocié en amont.
- Qui est le client, quelle relation
- Ce qui existe déjà dans l'écosystème
- Les délais, contraintes, dépendances
- Notes de réunions préparatoires

**Brief** : ce qu'on décide de construire. Choix produit, features, utilisateurs, positionnement.

Si une information relève d'une décision → brief. Si elle relève d'une contrainte donnée → context.

---

## Étape 0 — Identification du projet et lecture du fichier existant

Tu demandes le nom du projet si absent.

Tu cherches `[projet].context.md` dans le répertoire courant :
- **Si le fichier existe** → tu le lis intégralement avant de commencer. Tu résumes ce que tu y trouves et tu identifies les zones incomplètes ou à approfondir.
- **Si le fichier est absent** → tu le signales et tu démarres la capture depuis zéro.

Dans les deux cas, Medwin peut compléter oralement ce qui n'est pas dans le fichier — tu intègres les deux sources.

---

## Étape 1 — Lecture et synthèse (si fichier existant)

Tu présentes une synthèse structurée de ce que tu as lu :

> "Voici ce que je comprends du contexte :
>
> **Écosystème** : [ce qui existe, les acteurs, les relations]
> **Client** : [qui, quelle relation, ce qui est signé]
> **Contraintes** : [délais, budget, dépendances]
> **Notes** : [éléments de réunions, informations libres]
>
> Ce qui me semble manquant ou flou : [liste]"

---

## Étape 2 — Interview et enrichissement

Tu poses les questions une par une. Tu ne poses que les questions dont la réponse est absente ou insuffisante dans le fichier.

### Écosystème

- Existe-t-il des apps, services ou outils que ce projet va côtoyer, remplacer, ou avec lesquels il devra coexister ?
- Y a-t-il des acteurs (autres entreprises, associations, partenaires) dont les décisions influencent ce projet ?
- Y a-t-il des contraintes de nommage, de marque, ou de positionnement imposées par l'écosystème ?

### Client

- Qui est le client ou commanditaire ? Quelle est la relation (nouveau client, client existant, interne) ?
- Y a-t-il un contrat ou un accord signé ? Quel est son périmètre ?
- Quels sont les interlocuteurs clés côté client et leurs rôles dans le projet ?

### Contraintes

- Y a-t-il une date de livraison ou de lancement fixée ? Par qui et pourquoi ?
- Y a-t-il des contraintes budgétaires qui affectent le périmètre technique ?
- Y a-t-il des dépendances externes (autre projet, autre équipe, décision tierce) qui conditionnent ce projet ?

### Ce qui n'est pas encore posé

Tu cherches activement ce qui pourrait surprendre plus tard. Quelques angles à explorer si non couverts :

- **Risques connus** : y a-t-il des points qui pourraient bloquer ou compliquer le projet ? (technique, politique, client, légal)
- **Historique** : y a-t-il un projet précédent, une tentative avortée, ou un contexte d'échec à connaître ?
- **Parties prenantes silencieuses** : y a-t-il des personnes non mentionnées dont l'opinion ou le rôle pourrait affecter le projet ?

---

## Étape 3 — Synthèse et validation

Tu présentes le contexte complet tel que tu le comprends :

> "Voici le contexte complet :
>
> **Écosystème** : [...]
> **Client** : [...]
> **Contraintes** : [...]
> **Notes et éléments libres** : [...]
> **Risques identifiés** : [...]
>
> Est-ce que c'est complet et fidèle ? On peut ajuster avant d'enregistrer."

---

## Étape 4 — Enregistrement

Tu écris `[projet].context.md` dans le répertoire du projet.

```markdown
# Contexte — [Nom du projet]
_Mis à jour le [date]_

## Écosystème
[Apps, services, acteurs en relation avec ce projet. Ce qui existe déjà. Contraintes héritées de l'écosystème.]

## Client
[Qui est le client. Nature de la relation. Ce qui est signé. Interlocuteurs clés.]

## Contraintes
[Délais fixés et leur raison. Budget. Dépendances externes.]

## Notes
[Synthèse de réunions préparatoires. Éléments libres apportés en session.]

## Risques identifiés
[Ce qui pourrait bloquer ou compliquer le projet — technique, politique, légal, client.]
```

Confirmer :
> "`[projet].context.md` enregistré.
> Ce fichier sera lu par `/brief`, `/archi`, et `/roadmap` au démarrage de chaque skill.
> Il peut être mis à jour à tout moment — relancer `/contexte` pour enrichir ou réviser."

---

## Règles

- **Le fichier peut exister sans le skill** — Medwin peut y écrire directement après ses réunions. Le skill vient enrichir, pas créer de toutes pièces.
- **Ne pas dupliquer le brief** — si une information relève d'une décision produit, elle n'a pas sa place ici. La renvoyer explicitement : "ça, c'est une décision brief."
- **Document vivant** — le contexte évolue. Relancer `/context` si une contrainte change ou qu'une réunion apporte de nouveaux éléments.
- **Challenger, pas juste transcrire** — chercher ce qui n'a pas été dit, les angles morts, les risques implicites.

---

## Prochaine étape

`/brief` — le contexte est posé, construire le brief structuré.
