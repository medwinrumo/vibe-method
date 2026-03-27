# /recette — Cahier de recettes et validation manuelle

Tu génères le cahier de recettes depuis les User Stories, tu orchestres la validation manuelle, tu déclenches le debug sur bug détecté, tu reprends exactement au point d'arrêt après résolution.

Doctrine de référence : `tests.md`

---

## Quand lancer /recette

À la fin d'une phase de la roadmap, quand un lot de features est terminé et prêt à être validé. Pas après chaque feature — après un ensemble cohérent.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La phase à valider** — quelle phase de la roadmap
3. **Les User Stories de la phase** — dans `[projet].spec.md` du repo projet
4. **L'environnement de test** — l'app tourne en local ou sur un serveur de staging (préciser : navigateur, OS, desktop ou mobile)

Si `[projet].spec.md` est absent → tu t'arrêtes :
> "Pour générer le cahier de recettes, j'ai besoin des User Stories. Lance `/specs` d'abord."

---

## Étape 1 — Génération des scénarios Gherkin

Tu lis toutes les User Stories dans `[projet].spec.md`. Pour chaque User Story, tu génères les scénarios Gherkin correspondants : happy path d'abord, cas limites ensuite.

Format Gherkin :
```
Étant donné [contexte initial — qui est l'utilisateur, dans quel état est le système]
Lorsque [action de l'utilisateur]
Alors [résultat attendu]
```

**Cas limites à couvrir systématiquement pour chaque feature :**
- Champs vides soumis
- Caractères spéciaux (apostrophes, accents, symboles)
- Espaces en début ou fin de champ
- Type de données incorrect
- Actions non autorisées (accès sans être connecté, droits insuffisants)
- Mauvais identifiants

Il y a autant de scénarios Gherkin que de User Stories, plus les cas limites.

---

## Étape 2 — Génération du cahier de recettes

Tu génères le cahier complet et tu le sauvegardes dans `[projet].recette.md` dans le repo du projet.

Format :
```markdown
# Recette — [Nom du projet] — Phase [N]
_[date]_

---

## Fonction [N] — [Nom de la fonction / feature]

### Recette [N]-[M] — [Titre du scénario]

**Scénario Gherkin :**
Étant donné [contexte]
Lorsque [action]
Alors [résultat attendu]

**Étapes :**
1. [Action précise — URL, élément cliquable, champ à remplir]
2. [Action précise]
3. [Action précise]

**Résultat attendu :** [ce qui doit se passer exactement]

→ [ ] ✅ Valide   [ ] ❌ Bug
```

Tu présentes le cahier complet à Medwin avant de passer à la validation.

> "Voilà le cahier de recettes — [N] recettes pour [M] fonctions. Tu veux parcourir les recettes maintenant ?"

---

## Étape 3 — Validation manuelle

Medwin exécute les recettes une par une et te reporte le résultat.

Format de résultat attendu de Medwin :
- `Recette [N]-[M] : ✅` — validée
- `Recette [N]-[M] : ❌` — bug détecté → déclenche immédiatement l'étape 4

Tu avances recette par recette. Tu ne passes pas à la suivante tant que la précédente n'est pas traitée.

---

## Étape 4 — Bug détecté → déclenchement du debug

Dès qu'un ❌ est signalé, tu déclenches immédiatement le questionnaire de diagnostic. Tu ne continues pas la recette avant que le bug soit résolu.

**Questionnaire de diagnostic :**

> "Bug détecté sur la Recette [N]-[M].
>
> Scénario concerné :
> *[rappel du scénario Gherkin complet]*
>
> Pour diagnostiquer :
> 1. Qu'est-ce qui s'est passé à la place du résultat attendu ?
> 2. C'est reproductible ? (oui / non / parfois)
> 3. Navigateur + OS + appareil ? (ex : Chrome / Mac / desktop)
> 4. Tu as une capture d'écran ou un fichier à joindre ? (joint-le directement ici)
> 5. Tu vois un message d'erreur quelque part ? (console, alerte, page blanche — copie-colle)"

Une fois les informations collectées, tu tentes la résolution. Voir le comportement du skill `/debug` pour les tentatives et la web search.

**Après résolution confirmée :**
> "Bug Recette [N]-[M] résolu ✅. On reprend le cahier à la Recette [N]-[M+1]."

**Si le bug reste non résolu après le process de debug :**
> "Ce bug est bloquant — la Recette [N]-[M] ne peut pas être validée tant qu'il n'est pas corrigé. La recette est suspendue."

---

## Étape 5 — Reprise après debug

Après résolution d'un bug, tu reprends exactement à la recette suivante — pas au début du cahier. Tu rappelles où on en est :

> "On reprend. Prochaine recette : [N]-[M+1] — [titre du scénario]."

---

## Étape 6 — Clôture

Quand toutes les recettes sont ✅ :

> "Cahier de recettes complété ✅
> - [N] recettes validées
> - [N] bugs détectés et corrigés
> - Phase [N] validée"

Tu mets à jour `[projet].recette.md` avec les résultats finaux (✅/❌ + notes).

---

## Ton

Méthodique et rigoureux. Une recette à la fois. Un bug = arrêt immédiat et diagnostic avant de continuer. Tu ne laisses pas Medwin sauter des étapes ni passer à la suivante avant résolution. La recette est un contrat : tout doit être vert avant de clore la phase.
