---
description: Transforme specs et roadmap en issues GitHub qualifiées HITL/AFK, ordonnées par dépendances
---

# /to-issues — Specs vers issues GitHub

Transforme les specs et la roadmap en issues GitHub structurées, qualifiées et ordonnées par dépendances.

Place dans la chaîne : après `/specs`, avant `/sessionCode`.

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.
Lit `[projet].Rmap.md` et `[projet].spec.[feature].md` disponibles.

---

## Étape 1 — Découpage en vertical slices

Chaque issue est un **vertical slice** : une tranche qui coupe à travers toutes les couches (schéma → API → UI → tests), démontrable ou vérifiable seule une fois terminée.

**Test de découpage pour chaque candidat :** "Si on livre uniquement ça, peut-on le montrer ou le tester de bout en bout ?" Si non → redécouper.

---

## Étape 2 — Qualification HITL / AFK

Pour chaque issue, qualifier :

- **HITL** (Human In The Loop) — Medwin reste dans la boucle : décision d'architecture, choix de design, validation métier, action irréversible sur un système externe.
- **AFK** (Away From Keyboard) — délégable entièrement : implémentation spécifiée avec critères d'acceptance clairs, sans ambiguïté, sans décision à prendre. Une issue AFK peut être traitée par un sous-agent sans intervention.

Préférer AFK quand la spec est suffisamment précise. Une issue HITL mal qualifiée bloque inutilement.

---

## Étape 3 — Quiz

Présenter la liste numérotée des issues proposées. Pour chaque issue :

- **Titre** — court et descriptif
- **Type** — HITL / AFK
- **Bloqué par** — numéros des issues qui doivent être terminées avant

Demander à Medwin :
- La granularité est-elle bonne ? (trop grosse / trop fine)
- Les dépendances sont-elles correctes ?
- Des issues à fusionner ou à découper ?
- Des qualifications HITL/AFK à corriger ?

Itérer jusqu'à validation explicite avant de créer quoi que ce soit sur GitHub.

---

## Étape 4 — Création des issues GitHub

Créer les issues dans l'ordre de dépendance (les bloquants en premier) pour pouvoir référencer les vrais numéros dans "Bloqué par".

Template pour chaque issue :

```markdown
## Ce qu'on construit

[Description du comportement end-to-end de cette tranche. Pas couche par couche — ce que l'utilisateur ou le système peut faire une fois cette issue terminée.]

## Critères d'acceptance

- [ ] [critère 1]
- [ ] [critère 2]
- [ ] [critère 3]

## Bloqué par

[Référence aux issues bloquantes, ou "Aucun — peut démarrer immédiatement"]
```

Commandes :
```bash
# Créer l'issue
gh issue create --title "[titre]" --body "[corps]" --label "[label]"

# Vérifier
gh issue list
```

Ne pas modifier ni fermer les issues existantes.

---

## Étape 5 — Confirmation

> "Issues créées : [liste avec numéros GitHub].
>
> Issues AFK prêtes à déléguer : [liste].
> Issues HITL en attente de décision : [liste].
>
> Prochaine étape → `/sessionCode` pour démarrer l'implémentation."
