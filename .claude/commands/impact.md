# /impact — Analyse d'impact d'un changement

Tu analyses l'impact d'un changement sur tous les artefacts du projet et tu proposes les modifications nécessaires.

**Applicable à TOUT changement** — fonctionnel, technique, de priorité, ou de périmètre. Pas de seuil minimal : si quelque chose change, on l'analyse.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Quand lancer /impact

Dès qu'une décision change quelque chose à ce qui a été planifié ou codé :
- Une feature est reformulée, supprimée, ou ajoutée
- Un module change de responsabilité
- Une technologie est remplacée
- Une priorité est inversée
- Une contrainte nouvelle apparaît (légale, technique, client)

---

## Étape 0 — Description du changement

> "Décris le changement : qu'est-ce qui change, pourquoi ?"

Medwin décrit librement. Tu résumes en une phrase de confirmation :
> "Changement : [résumé en une phrase]. C'est bien ça ?"

---

## Étape 1 — Chargement des artefacts

Tu lis dans cet ordre :
1. `[projet].prd.md` — les fonctions et leur description
2. `[projet].archi.md` — les modules et leurs responsabilités
3. `[projet].Rmap.md` — la roadmap et le planning
4. `[projet].avancement.yaml` — l'état actuel de chaque fonction (si le fichier existe)
5. `[projet].spec.*.md` — les specs des fonctions potentiellement impactées

Si un fichier est absent → continuer sans lui, le noter.

---

## Étape 2 — Classification du changement

| Type | Critère |
|---|---|
| **Mineur** | Une seule fonction impactée, aucun changement d'architecture ni de planning |
| **Modéré** | Plusieurs fonctions ou un module impactés, planning potentiellement décalé |
| **Majeur** | Architecture ou stack modifiée, périmètre de V1 redéfini |

> "Ce changement est de type [Mineur / Modéré / Majeur]. Raison : [justification courte]."

---

## Étape 3 — Analyse d'impact artefact par artefact

Pour chaque artefact chargé, tu identifies ce qui doit changer.

Format par artefact :

```
## PRD
Impact : [aucun / faible / élevé]
Avant : [citation exacte du texte actuel]
Après : [texte modifié proposé]

## Architecture
Impact : [aucun / faible / élevé]
Avant : [module ou règle impactée]
Après : [modification nécessaire]

## Roadmap
Impact : [aucun / décalage / restructuration]
Avant : [planning actuel]
Après : [planning modifié]
Décalage estimé : [Xj]

## Specs impactées
- `[projet].spec.[feature].md` : [ce qui change]
- `[projet].spec.[feature2].md` : [ce qui change]

## Sprint status
- [fonction X] : statut recommandé → [backlog / blocked / autre]
  Raison : [pourquoi ce statut change]
```

Si un artefact n'est pas impacté → `Impact : aucun` et passer au suivant.

---

## Étape 4 — Proposition de décision

Tu présentes un plan d'action ordonné :

> "Pour appliquer ce changement, voici l'ordre :
> 1. PRD — [description de la modification] — [durée estimée]
> 2. Architecture — [description] — [durée estimée]
> 3. Roadmap — [description] — [durée estimée]
> 4. Specs — [N fonctions à mettre à jour] — [durée estimée]
> 5. Sprint status — [N fonctions à reclasser]
>
> Effort total estimé : [X heures]
> On applique ?"

---

## Étape 5 — Application (si confirmée)

Tu appliques les modifications dans l'ordre défini à l'Étape 4, **une par une** :

Pour chaque artefact :
1. Annoncer ce que tu vas modifier
2. Appliquer la modification
3. Confirmer : "PRD mis à jour. On passe à l'Architecture ?"

Tu ne sautes pas d'étape. Tu ne modifies pas deux artefacts en même temps.

Si Medwin dit non à une modification spécifique → noter le refus, continuer avec les autres.

---

## Étape 6 — Commit de clôture

Après toutes les modifications, tu proposes un commit groupé :

```bash
git add [liste des fichiers modifiés]
git commit -m "impact: [résumé du changement en une ligne]"
```

---

## Règles

- **L'ordre d'application est toujours** : PRD → Architecture → Roadmap → Specs → Sprint status → Code
- **Aucun artefact n'est modifié sans confirmation explicite** de Medwin à l'Étape 4
- **Tout changement est analysé**, même si Medwin dit "c'est juste un petit détail"
- **Si le code a déjà été écrit** sur des fonctions impactées → signaler explicitement que le code peut être désynchronisé et proposer `/code-review` après les mises à jour
- **Archiver les change requests refusées** : noter dans `[projet].adr.md` sous "Changements refusés — [date] — [raison]"
