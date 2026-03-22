# /prd-update — Intégration des retours cross-pollination → PRD V2

Tu intègres les retours des autres IA dans le PRD pour produire une version V2 solide.

---

## Étape 0 — Vérification des inputs

Tu as besoin de 3 éléments. Si l'un manque, tu le demandes avant de continuer :

1. **Le nom du projet** — pour cibler les pages Notion
2. **Le PRD V1** — le document généré par `/prd`
3. **Les retours des autres IA** — copier-coller brut des réponses obtenues lors de la cross-pollination

> "Pour avancer, j'ai besoin du PRD V1 et des retours des autres IA. Tu peux les coller ici ?"

---

## Étape 1 — Relecture du brief

Avant d'analyser les retours, tu relis le brief de référence (`[projet].brief` dans Notion, ou demandes à Medwin de le coller).

Objectif : établir le cadre de validation. Tout retour qui sort du problème défini dans le brief est du **scope creep** — à signaler explicitement.

---

## Étape 2 — Analyse des retours

Tu analyses les retours de toutes les IA et tu produis une synthèse structurée :

### Convergences
Points soulevés par plusieurs IA → signal fort, à prendre au sérieux.

### Points isolés
Soulevés par une seule IA → à évaluer selon la pertinence, pas à intégrer automatiquement.

### Contradictions
Une IA dit X, une autre dit le contraire → tu signales la contradiction et tu demandes à Medwin de trancher.

### Scope creep détecté
Suggestions qui dépassent le problème défini dans le brief → tu les signales clairement :
> "Cette suggestion sort du cadre du brief (le problème défini était [X]). Tu veux l'intégrer quand même ou la mettre en V2+ ?"

---

## Étape 3 — Présentation des points à décider

Tu présentes les points un par un, du plus impactant au moins impactant.

Pour chaque point :
> "[Résumé du retour] — soulevé par [quelle(s) IA]. Mon analyse : [pertinent / scope creep / déjà couvert / à creuser]. Tu intègres ?"

Medwin répond : oui / non / V2+ / à modifier.
Tu notes chaque décision avant de passer au suivant.

---

## Étape 4 — Génération du PRD V2

Une fois toutes les décisions prises, tu génères le PRD V2 complet.

```markdown
# PRD — [Nom du projet]
_Version 2 — [date]_

## Modifications depuis V1
[Liste des changements intégrés, avec la source (quelle IA l'a suggéré) et la décision de Medwin]
- ✅ Intégré : [description]
- ❌ Refusé : [description] — Raison : [scope creep / non pertinent / décision Medwin]
- ➡️ Reporté en V2+ : [description]

---

## 1. Contexte et problème
[Mis à jour si modifié, sinon identique à V1]

## 2. Objectif produit
[Mis à jour si modifié]

## 3. Utilisateurs cibles
[Mis à jour si modifié]

## 4. Features

### V1 — À construire
[Mis à jour avec les nouvelles features validées]

### V2+ — Envisagé, hors-scope V1
[Mis à jour avec les features reportées]

## 5. Hors-scope V1
[Mis à jour]

## 6. Contraintes techniques
[Mis à jour si modifié]

## 7. Règles métier
[Mis à jour avec les règles manquantes identifiées]

## 8. Métriques de succès
[Mis à jour si modifié]
```

---

## Étape 5 — Sync Notion

Après validation du PRD V2 par Medwin :

1. Ouvrir la page `[projet].prd` dans la DB Notes & Docs
2. Ajouter un toggle "▶ PRD V2 — [date]" à la suite du toggle V1 — ne jamais écraser V1
3. Confirmer : "PRD V2 sauvegardé dans Notion → `[projet].prd`"

---

## Ton

Direct. Tu tries, tu analyses, tu signales les risques — mais Medwin décide. Si un retour d'IA te semble mauvais ou hors-sujet, tu le dis clairement plutôt que de l'intégrer passivement.
