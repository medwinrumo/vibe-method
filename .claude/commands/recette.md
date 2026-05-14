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

## Étape 1 — Chargement ou génération des scénarios Gherkin

Tu cherches `[projet].gherkin.[feature].md` pour chaque feature de la phase.

**Si le fichier existe** (généré par `/gherkin` Mode Specs) :
Tu le lis. Tu ne régénères pas les scénarios — ils ont déjà été validés.
> "Scénarios Gherkin chargés depuis `[projet].gherkin.[feature].md` — [N] scénarios."

**Si le fichier est absent** (feature codée sans passer par `/gherkin`) :
Tu génères les scénarios depuis les User Stories dans `[projet].spec.[feature].md` :
- Happy path d'abord
- Cas limites ensuite (champs vides, caractères spéciaux, type incorrect, accès non autorisé, mauvais identifiants)

Format Gherkin :
```
Étant donné [contexte initial — qui est l'utilisateur, dans quel état est le système]
Lorsque [action de l'utilisateur]
Alors [résultat attendu]
```

**Signal de découpage :** si une User Story produit plus de 15 scénarios, signaler :
> "La story '[titre]' a généré [N] scénarios — signal que la story était trop large. À noter pour les prochaines specs. On continue ?"

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

## Étape 5b — Audit de sécurité léger (avant clôture de phase)

À exécuter une fois toutes les recettes ✅, avant de clore la phase. Obligatoire si l'app est déployée ou sur le point de l'être.

**Outils gratuits à lancer :**

```bash
# Mozilla Observatory — en-têtes de sécurité HTTP
npx observatory --format report https://[url-staging-ou-prod]
```

- **securityheaders.com** — vérification manuelle de l'URL (CSP, HSTS, X-Frame-Options)
- **OWASP ZAP** (scan DAST) — si le niveau de risque est moyen ou élevé (voir `[projet].archi.md`)

Demander à Medwin :
> "Avant de clore la phase, on lance un audit de sécurité léger sur l'URL de staging. Tu veux qu'on le fasse maintenant ?"

Si oui → lancer les outils ci-dessus, intégrer les résultats dans `[projet].recette.md` sous une section "Sécurité — Phase [N]".

Si des problèmes sont identifiés → les traiter avant de clore la phase (même traitement qu'un bug de recette : bloquant).

---

## Étape 6 — Clôture

Quand toutes les recettes sont ✅ :

Tu mets à jour `[projet].recette.md` avec les résultats finaux (✅/❌ + notes).

Puis, pour chaque feature de la phase validée, tu guides Medwin vers le commit propre sur sa branche :

> "Phase [N] validée. Pour chaque feature, un commit propre avant le merge :
> ```
> git add .
> git commit -m "feat: [nom-feature] — validée recette phase [N]"
> ```
> Une feature = un commit. On ne merge pas avant d'avoir commité."

### Sprint status

Si `[projet].avancement.yaml` existe → pour chaque feature validée, proposer de passer le statut à `done` :
> "Je mets à jour le sprint status pour les features validées : [liste] → done. Je le fais ?"

### Documentation utilisateur

> "Phase [N] validée. Veux-tu mettre à jour `[projet].doc-user.md` pour les features de cette phase ?
> Je peux rédiger les entrées pour : [liste des features validées]."

Si oui → rédiger les entrées en langage utilisateur (pas technique) et les appender dans `[projet].doc-user.md` :

```markdown
## [Nom de la feature] _(Phase [N] — [date])_

[2-3 phrases du point de vue utilisateur — ce que l'utilisateur peut maintenant faire]
```

Si non → noter en checklist finale que `[projet].doc-user.md` reste à mettre à jour.

---

> "Cahier de recettes complété ✅
> - [N] recettes validées
> - [N] bugs détectés et corrigés
> - Phase [N] validée — prête pour le merge dans `main`"

---

## Ton

Méthodique et rigoureux. Une recette à la fois. Un bug = arrêt immédiat et diagnostic avant de continuer. Tu ne laisses pas Medwin sauter des étapes ni passer à la suivante avant résolution. La recette est un contrat : tout doit être vert avant de clore la phase.
