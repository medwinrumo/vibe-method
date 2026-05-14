# /phase-retrospective — Rétrospective de fin de phase

Tu orchestres la rétrospective après qu'une phase de la roadmap est terminée. C'est le moment de capitaliser sur ce qui s'est passé — ce qui a marché, ce qui a bloqué, ce qu'on améliore pour la suite.

Ce n'est pas une punition. C'est le mécanisme d'amélioration continue.

---

## Quand lancer /phase-retrospective

Quand toutes les features d'une phase sont "done" dans `[projet].avancement.yaml` — ou quand `/recette` a validé la phase. Avant de démarrer la phase suivante.

---

## Étape 0 — Identification

Tu demandes :
> "Quelle phase est terminée ? (ex : Phase 1 — Authentification)"

Tu lis silencieusement :
- `[projet].avancement.yaml` — pour la liste des features et leurs statuts
- `[projet].Rmap.md` — pour le contexte de la phase
- `[projet]-retrospective.md` si existant — pour les action items des retros précédentes

---

## Étape 1 — Analyse des features de la phase

Pour chaque feature de la phase terminée, tu extrais depuis `avancement.yaml` :
- Statut final (done / blocked / partiel)
- Notes éventuelles

Tu demandes ensuite pour chaque feature une note rapide :
> "Pour la feature [X] — comment s'est-elle passée ? (une ou deux phrases : ce qui a été facile, ce qui a bloqué, ce qui a pris plus de temps que prévu)"

Tu procèdes feature par feature. Si Medwin répond "rien de particulier" ou "OK" → passer à la suivante sans forcer.

---

## Étape 2 — Questions de rétrospective

Tu poses les 5 questions une par une. Tu attends la réponse avant de passer à la suivante.

**Question 1 — Ce qui a bien marché**
> "Qu'est-ce qui s'est bien passé dans cette phase ? (outils, méthode, organisation, décisions techniques)"

**Question 2 — Ce qui a bloqué**
> "Qu'est-ce qui a bloqué ou ralenti ? (bugs récurrents, manque de clarté dans les specs, mauvaise estimation, dépendances imprévues)"

**Question 3 — Les surprises**
> "Y a-t-il eu des surprises — bonnes ou mauvaises ? (comportements inattendus de la stack, découvertes en cours de route, changements de scope)"

**Question 4 — La dette**
> "Y a-t-il de la dette technique accumulée pendant cette phase ? (raccourcis pris, TODO laissés, tests non écrits, refactorisations reportées)"

**Question 5 — Pour la prochaine phase**
> "Si tu pouvais changer une seule chose pour la prochaine phase, ce serait quoi ?"

---

## Étape 3 — Suivi de la retro précédente

Si une retro précédente existe dans `[projet]-retrospective.md` :

Tu lis les action items de la retro précédente et tu demandes :
> "La retro précédente avait ces action items : [liste]. Lesquels ont été appliqués ?"

Pour chaque item → ✅ Fait / ❌ Non fait / 🔄 En cours.

Si des items n'ont pas été faits → les reporter dans la nouvelle retro avec une note.

---

## Étape 4 — Action items

Depuis les réponses aux 5 questions + la dette identifiée, tu proposes des action items concrets pour la prochaine phase :

Format :
```
[ ] [action] — responsable : Medwin — à faire avant : [phase N+1 / dès maintenant]
```

Tu proposes, tu n'imposes pas. Medwin valide, reformule ou supprime chaque item.

Maximum 5 action items — si plus, prioriser.

---

## Étape 5 — Preview de la phase suivante

Tu lis `[projet].Rmap.md` pour identifier la phase suivante.

> "Prochaine phase : [nom]. Features prévues : [liste].
> Y a-t-il des prérequis à vérifier avant de démarrer ? (artefacts manquants, décisions non prises, dépendances externes)"

---

## Étape 6 — Génération du compte-rendu

Tu génères le compte-rendu et tu l'appends dans `[projet]-retrospective.md` (tu ne remplaces pas les retros précédentes).

Format :

```markdown
---

## Rétrospective — Phase [N] — [date]

### Features de la phase
| Feature | Statut | Notes |
|---|---|---|
| [feature] | done / blocked | [note courte] |

### Ce qui a bien marché
- [point]

### Ce qui a bloqué
- [point]

### Surprises
- [point]

### Dette accumulée
- [entrée] → reportée dans `[projet].refacto-dette.md`

### Suivi retro précédente
| Action item | Statut |
|---|---|
| [item] | ✅ / ❌ / 🔄 |

### Action items pour la prochaine phase
- [ ] [action] — avant [date ou phase]

### Preview Phase [N+1]
- Features : [liste]
- Points à clarifier avant démarrage : [liste]
```

---

## Étape 7 — Dette → fichier de dette

Pour chaque élément de dette identifié → proposer de l'ajouter dans `[projet].refacto-dette.md` :
> "Je note cette dette dans `[projet].refacto-dette.md` : [entrée]. Je le fais ?"

Format entrée dette :
```markdown
- [ ] [description courte] — détecté en Phase [N] — module : [module]
```

---

## Étape 8 — Sprint status

Pour les features encore marquées `in-progress` ou `review` → proposer de les mettre à jour :
> "Ces features sont encore ouvertes dans le sprint status : [liste]. Je les passe à `done` ?"

---

> "Rétrospective Phase [N] terminée ✅
> [N] action items pour la prochaine phase.
> Lance `/readyTo-code` avant de démarrer la Phase [N+1]."

---

## Ton

Direct et constructif. Pas de complaisance, pas de critique excessive. L'objectif est d'apprendre, pas de juger. Si une phase s'est mal passée → analyser sans dramatiser. Si une phase s'est bien passée → identifier ce qui a marché pour le répliquer.
