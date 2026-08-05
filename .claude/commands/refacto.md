---
description: Refactoring guidé — diagnostic, prérequis, exécution étape par étape en session dédiée
---

# /refacto — Refactoring guidé

Tu guides Medwin à travers une session de refactoring : diagnostic, prérequis, exécution étape par étape.

Doctrine de référence : `~/dev/wiki/refacto-doc.md`

---

## Vocabulaire d'analyse

Ces termes sont utilisés dans le diagnostic pour décrire les problèmes avec précision.

- **Seam** — point de couture : endroit où un comportement peut être modifié sans éditer le code en place. Là où une interface existe ou devrait exister.
- **Profondeur** — ratio valeur / complexité d'interface. Un module **profond** offre beaucoup de comportement derrière une petite interface. Un module **superficiel** a une interface presque aussi complexe que son implémentation.
- **Deletion test** — outil de diagnostic : "si je supprime ce module, où va la complexité ?" Si elle disparaît → le module était un passe-plat superficiel. Si elle réapparaît chez N appelants → le module gagnait sa place.

---

## Quand proposer /refacto

Ce skill n'est jamais automatique — Claude le **propose**, Medwin décide de le lancer ou de le reporter.

### Mode exploration (optionnel)

Si aucun module n'est encore identifié mais que le codebase "résiste" — navigation difficile, bugs récurrents sans cause claire, features qui touchent trop de fichiers — lancer `/refacto` en mode exploration :

1. Lire le codebase organiquement, noter les points de friction :
   - Comprendre un concept oblige à rebondir entre de nombreux petits fichiers ?
   - Des modules superficiels dont la suppression ne ferait que déplacer la complexité chez les appelants ?
   - Des fonctions extraites uniquement pour les tests, mais les vrais bugs se cachent dans la façon dont elles sont appelées ?
   - Des modules qui violent leurs seams (logique qui fuit à travers l'interface) ?
2. Appliquer le **deletion test** sur les suspects
3. Présenter une liste classée de candidats à Medwin avec le problème constaté
4. Medwin choisit un candidat → passer aux prérequis (étape 0)

Trois signaux déclencheurs (mode ciblé) :

### Signal 1 — Après une review négative

Si `/code-review` ou `/code-review-hostil` remonte des problèmes de nature **structurelle** sur un module (violation de silo, responsabilités mal placées, couplage excessif, duplication significative, complexité inextricable) → proposer :
> "Ce module montre des signes de dégradation structurelle. Je recommande `/refacto` avant d'ajouter de nouvelles fonctionnalités ici."

**Filtre important :** `/code-review-hostil` remonte toujours ≥ 10 problèmes par design. Ne proposer `/refacto` que si les problèmes critiques touchent la **structure du module** — pas juste des bugs, des cas limites ou des problèmes de sécurité isolés.

### Signal 2 — Avant d'implémenter une feature sur un module instable

Si la feature à coder touche un module qui présente **au moins 2** des critères suivants → proposer `/refacto` avant de continuer :
- Fonctions trop longues ou trop imbriquées
- Duplication significative (même logique copiée à plusieurs endroits)
- Absence ou fragilité des tests sur le module
- Interfaces floues entre modules (violations répétées de la règle silo)
- Bug récurrent ou effet de bord connu dans ce module (vu en `/debug` ou `/phase-retrospective`)
- Modifications à risque (auth, permissions/RLS, paiement) sur du code difficile à raisonner

Pour évaluer ces critères, Claude lit le module concerné au démarrage de `/sessionCode` avant de commencer le développement.

### Signal 3 — En fin de phase (hygiène)

Après `/phase-retrospective`, si la section "dette technique" contient ≥ 2 items classés "élevé" ou "bloquant" → proposer une session `/refacto` planifiée avant de démarrer la phase suivante.

---

## Étape 0 — Vérification de session

Avant tout :

> "Ce skill doit être lancé dans une session dédiée au refactoring — sans feature en cours, sans bug fix en attente.
> Es-tu dans une session propre, ou es-tu en cours de travail sur autre chose ?"

Si en cours de travail → arrêt immédiat :
> "Lance `/maj` pour clôturer la session en cours, puis `/clear`.
> Au redémarrage : `/todo` — le refactoring est la première action de la nouvelle session."

---

## Étape 1 — Prérequis

Tu vérifies les quatre conditions avant d'aller plus loin. Chaque condition non remplie est bloquante.

**1a — Nom du projet**
Détermine le nom du projet depuis le répertoire courant.

**1b — Branche dédiée**
> "Sur quelle branche es-tu ?"

Si `main` ou une branche `feat/` → tu t'arrêtes :
> "Crée une branche dédiée avant de continuer :
> `git checkout -b refacto/[module-ciblé]`"

**1c — Commit de checkpoint**
> "Lance ces commandes pour créer le point de retour garanti :
> `git add -A && git commit -m 'refacto: checkpoint avant début'`
> Confirme quand c'est fait."

Pourquoi : si quelque chose part mal, `git reset --hard HEAD` ramène exactement à cet état, sans perte.

**1d — Tests passants**
> "Lance la suite de tests complète maintenant. Combien passent ? Y a-t-il des échecs ?"

Si des tests échouent avant même de commencer → arrêt complet :
> "Des tests échouent avant que tu aies touché quoi que ce soit. Ce n'est pas un problème de refactoring — c'est un bug existant. Corrige-le d'abord (session `/debug`), puis reviens ici."

Si tous les tests passent → note le nombre de tests passants. C'est la baseline.

---

## Étape 2 — Diagnostic

Tu lis le(s) fichier(s) du module concerné. Tu identifies ce qui pose problème.

**Signaux à chercher :**
- Duplication : même logique écrite à plusieurs endroits
- Module trop gros : trop de responsabilités dans un seul fichier
- Nommage flou : des noms qui ne reflètent plus ce qu'ils font
- Logique impossible à décrire en une phrase
- Responsabilités mal placées : logique dans le mauvais module
- Fonctions trop longues ou trop imbriquées
- Violations de la règle silo : un module touche le code d'un autre
- Tests absents ou fragiles sur le module
- Bug récurrent ou effet de bord connu (tracé dans `/debug` ou `/phase-retrospective`)

**Outils d'analyse :**
- Appliquer le **deletion test** sur chaque suspect : si ce module disparaissait, la complexité s'évaporerait-elle ou réapparaîtrait-elle chez les appelants ? Réapparition chez N appelants = le module gagne sa place. Évaporation = candidat prioritaire.
- Qualifier la **profondeur** du module : grande valeur derrière une petite interface (profond, à garder) ou interface aussi complexe que l'implémentation (superficiel, à fusionner ou restructurer) ?
- Identifier les **seams** manquants : où devrait exister une interface pour isoler un comportement, mais n'en existe pas encore ?

**Tu présentes le diagnostic en langage clair, sans code :**
> "Voici ce que j'observe dans [module] :
> - [signal 1 : description en langage clair]
> - [signal 2 : description en langage clair]
> - [...]
>
> Ce que je propose de traiter dans cette session : [objectif en une phrase précise]
> Périmètre exact : [module], [fichier(s)], [type de refactoring]
>
> Ce qui est hors scope (journal de dette) :
> - [point hors scope 1]
> - [point hors scope 2]"

Medwin valide l'objectif et le périmètre avant de continuer.

**Règle absolue :** si Medwin ne valide pas l'objectif ou le périmètre → ne pas commencer l'exécution.

**Écriture dans le journal de dette :**
Tu ajoutes immédiatement les points hors scope dans `[projet].refacto-dette.md` (dans le repo projet).

Si le fichier n'existe pas → le créer avec cet en-tête :
```markdown
# Journal de dette refactoring — [projet]
_Appended par /refacto. Ne jamais supprimer les entrées existantes._

```

Format d'une entrée :
```
- [ ] [module/fichier] — [signal identifié] — noté le [date]
```

Les points en cours de traitement dans cette session ne sont PAS ajoutés au journal — uniquement ce qui est explicitement laissé hors scope.

---

## Étape 3 — Exécution guidée

Tu travailles une étape à la fois, dans un seul fichier à la fois.

### Protocole par étape

**Annonce avant d'agir :**
> "Étape [N] : je vais [action précise en langage clair — pas de code].
> Fichier concerné : [nom du fichier uniquement].
> Je ne touche rien d'autre.
> Tu valides ?"

Si Medwin ne valide pas → tu ne fais rien. Tu proposes une alternative ou tu passes à l'étape suivante.

**Après exécution — audit obligatoire :**
> "Voici tous les fichiers que j'ai modifiés et ce que j'y ai changé :
> - [fichier] : [description en langage clair de ce qui a changé]"

Medwin lance `git diff` pour vérifier. Si quelque chose hors scope a bougé → `git restore [fichier]` pour annuler uniquement ce fichier.

**Commit atomique :**
> "Lance : `git commit -m 'refacto: [action précise]'`"

**Tests après chaque commit :**
> "Relance les tests. Le nombre de tests passants est-il toujours [baseline] ?"

Si un test échoue → arrêt immédiat :
> "Un test échoue. Deux options : (1) revenir en arrière sur cette étape (`git reset HEAD~1`) et comprendre ce qui a changé, ou (2) corriger le comportement si c'était un bug masqué. Qu'est-ce que tu préfères ?"

### Règles de l'exécution

- **Contexte minimal** : tu travailles fichier par fichier. Tu ne demandes pas tout le projet — tu demandes uniquement le fichier ciblé par l'étape en cours.
- **Pas de code dans les explications** : les propositions et les descriptions sont toujours en langage clair. Medwin valide ce que tu vas faire, pas comment tu vas l'écrire.
- **Aucune initiative hors scope** : si tu remarques quelque chose à améliorer dans un fichier hors périmètre → tu le notes dans le journal de dette, tu n'y touches pas.
- **Un seul fichier par étape** : si une étape implique plusieurs fichiers → la découper en sous-étapes.

---

## Étape 4 — Clôture

Une fois toutes les étapes validées :

**Vérification finale des tests :**
> "Lance la suite complète une dernière fois. Tous les [baseline] tests passent-ils toujours ?"

Si oui → le refactoring est sûr. Le comportement externe est préservé.

**Mise à jour du journal de dette :**
Tu marques les points traités comme résolus dans `[projet].refacto-dette.md` :
- Remplace `- [ ]` par `- [x]` sur chaque point traité
- Ajoute `— résolu le [date]` en fin de ligne

Si de nouveaux points ont été identifiés pendant l'exécution (hors scope apparu en cours de route) → les ajouter au journal avec le format standard.

> "Journal de dette mis à jour. Points résolus : [liste]. Points restants : [liste]."

**Prochaine étape :**
- Si le refactoring était pré-feature → proposer de lancer `/sessionCode` pour la feature
- Si le refactoring était fin de phase → proposer le merge et la release
- Si on-demand → proposer `/maj` pour clôturer

---

## Ton

Tu guides, tu proposes, Medwin valide. Tu ne touches jamais un fichier sans avoir annoncé l'action et reçu un "ok". Les descriptions sont en langage clair — ce que tu changes et pourquoi, pas comment c'est écrit dans le code.

---

## Prochaine étape

Retour à `/sessionCode` — le refactoring est terminé, reprendre la feature qui attendait.
