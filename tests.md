# tests.md

Doctrine de test — principes, niveaux et règles à appliquer dans tous les projets vibe-method.
À enrichir au fil des sessions.

---

## Principe fondamental

Tester, c'est vérifier que ce qui a été produit correspond à ce qui a été demandé.
Il y a deux dimensions à vérifier : que ça **fonctionne** techniquement, et que c'est **correct** du point de vue de l'utilisateur. Ces deux dimensions ne se confondent pas — une feature peut fonctionner et être mauvaise, ou être bien conçue et contenir un bug.

---

## TDD — Test-Driven Development

### Principe

Écrire le test avant le code. Le test définit le comportement attendu — le code doit le satisfaire, pas l'inverse.

Cycle **Red → Green → Refactor** :
- **Red** : le test est écrit, il échoue (le code n'existe pas encore). Un test qui passe sans code est un test inutile.
- **Green** : on écrit le minimum de code pour que le test passe. Rien de plus.
- **Refactor** : on améliore le code qu'on vient d'écrire sans changer son comportement. Les tests restent verts — c'est la preuve que rien n'a cassé.

**Ce que "refactoriser" signifie concrètement à cette étape :**
- Renommer une variable ou fonction dont le nom ne reflète pas ce qu'elle fait
- Extraire un bloc répété ou trop dense dans une fonction séparée
- Simplifier une condition inutilement complexe
- Supprimer du code mort ou redondant introduit pour atteindre le Green

**Règles du Refactor TDD :**
- Scope strict : uniquement le code qui vient d'être écrit pour ce test, rien d'autre
- Un seul changement à la fois — relancer les tests après chaque changement
- Si un test échoue après le refactor → revenir en arrière immédiatement, pas de correction en avant

C'est un **micro-refactoring** : immédiat, ciblé, dans la même session et sur la même branche. À ne pas confondre avec le refactoring de dette accumulée, qui exige une session dédiée. Voir `refacto.md`.

### Quand appliquer TDD

**Obligatoire pour :**
- Tous les modules métier — la logique est connue avant le code, elle vient du `/specs`
- Tous les modules de sécurité — permissions, auth, validation des droits

**Ne pas appliquer pour :**
- Modules UI (composants, écrans) — le comportement visuel se découvre en codant
- Modules techniques (config, api, shared, plomberie) — pas de logique métier à spécifier

### Connexion avec /specs

Les règles de gestion et les cas d'échec définis dans `/specs` sont exactement les contrats dont TDD a besoin. La chaîne directe :

```
Règle de gestion dans le spec → test unitaire (TDD)
Cas d'échec dans le spec      → test négatif (TDD)
Cas limite dans le spec       → test négatif (TDD)
```

Les tests ne sont pas écrits après la feature — ils en sont la traduction directe avant que le code n'existe.

---

## Les trois niveaux de tests

### Niveau 1 — Tests unitaires et d'intégration

Tests au niveau du code, exécutés automatiquement.

**Tests unitaires** — vérifient qu'une fonction isolée produit le bon résultat pour des entrées données. Exemple : la fonction `calculerTotal(articles, remise)` avec 3 articles à 10€ et une remise de 10% doit retourner 27€. Rien d'autre n'est testé — pas l'interface, pas la base de données.

**Tests d'intégration** — vérifient que deux modules fonctionnent correctement ensemble. Exemple : le module panier communique-t-il correctement avec le module paiement ?

Outil de référence : **Vitest** (projets Vite/React).

Ces tests sont exécutés via `/tests` immédiatement après le développement d'une feature, avant toute validation manuelle.

**Implémentation réelle plutôt que mock, par défaut.** Un test qui mock la base de données ou le service externe vérifie que le code appelle correctement un mock — pas qu'il fonctionne avec le vrai système. Utiliser une vraie instance (DB de test locale, service en mode sandbox) chaque fois que c'est raisonnablement possible. Mocker uniquement aux frontières système difficiles à reproduire en test (API tierce payante, service externe sans mode sandbox) — jamais entre modules internes du projet.

### Niveau 2 — Tests automatisés d'interface (E2E)

Un programme simule les actions d'un utilisateur réel dans un navigateur : navigation, clics, saisies, soumissions de formulaires. Le programme prend des captures d'écran et peut enregistrer une vidéo de l'exécution.

Outil de référence : **Playwright**.

Ces tests sont générés depuis les scénarios Gherkin du cahier de recettes. Ils sont exécutés automatiquement avant la validation manuelle finale.

**Test de non-régression** — après chaque nouvelle feature, toute la batterie Playwright existante est relancée pour vérifier que rien n'a été cassé dans les features précédentes.

Intégration CI/CD possible : Playwright peut être intégré dans GitHub Actions pour bloquer automatiquement un déploiement si des tests échouent.

### Niveau 3 — Recette manuelle

Validation humaine en conditions réelles. C'est le dernier filtre — celui que l'automatisation ne peut pas remplacer.

L'automatisation vérifie que ça fonctionne techniquement. La recette manuelle vérifie que c'est correct du point de vue de l'expérience utilisateur : cohérence visuelle, fluidité, logique de navigation, ressenti global.

Exécutée via `/recette`.

---

## Ordre d'exécution dans un projet

**Mode TDD** (modules métier et sécurité) :
```
1.  /specs         → règles de gestion + cas d'échec définis
2.  /tests         → tests écrits depuis le spec (Red — échouent)
3.  Code           → feature implémentée pour satisfaire les tests
4.  /tests         → tests passants (Green) + refactor
5.  /tests         → non-régression (batterie Playwright sur features existantes)
6.  /code-review   → revue structurelle + sécurité → bloquant si point critique
7.  /recette       → génération du cahier de recettes (Gherkin)
8.  /tests         → Playwright sur la nouvelle feature
9.  /securite check → vérification sécurité → bloquant si point en échec
10. /recette       → validation manuelle finale
```

**Mode Standard** (modules UI et techniques) :
```
1. Code            → feature implémentée
2. /tests          → tests unitaires + intégration
3. /tests          → non-régression (batterie Playwright sur features existantes)
4. /code-review    → revue structurelle + sécurité → bloquant si point critique
5. /recette        → génération du cahier de recettes (Gherkin)
6. /tests          → Playwright sur la nouvelle feature
7. /securite check → vérification sécurité → bloquant si point en échec
8. /recette        → validation manuelle finale
```

Dans les deux modes, l'humain arrive en dernier pour valider ce que l'automatisation ne peut pas juger. Ordre de référence complet : `methode.md` Phase 7.

---

## Gherkin — format de référence

Le Gherkin est le format standard pour décrire les scénarios de test. Il est le miroir opérationnel de la User Story : la User Story dit ce qu'on veut construire, le Gherkin dit comment on vérifie que c'est construit correctement.

**Les Gherkin sont générés par `/recette` à partir des User Stories, et stockés uniquement dans `[projet].recette.md`.** Ils ne figurent pas dans les specs.

Format :
```
Étant donné [contexte initial — qui est l'utilisateur, dans quel état est le système]
Lorsque [action de l'utilisateur]
Alors [résultat attendu — ce qui doit se passer]
```

Exemple (feature de connexion) :
```
Étant donné que je suis sur la page de connexion et que j'ai un compte actif
Lorsque je saisis mon email et mon mot de passe corrects et que je clique sur "Se connecter"
Alors je suis redirigé vers mon tableau de bord et mon prénom apparaît dans la navigation
```

Il y a autant de scénarios Gherkin que de User Stories — plus les cas limites associés à chacune.

---

## Edge cases — ne jamais faire confiance à l'utilisateur

Chaque feature doit être testée au-delà du parcours heureux. Les cas limites à couvrir systématiquement :

- Champs vides soumis
- Caractères spéciaux (apostrophes, accents, symboles monétaires)
- Espaces en début ou fin de champ
- Type de données incorrect (texte là où un nombre est attendu)
- Actions hors séquence (accéder à une page protégée sans être connecté)
- Mauvais identifiants, mauvais mot de passe
- Valeurs extrêmes (nombre très grand, chaîne très longue)

Chaque cas limite a son propre scénario Gherkin dans le cahier de recettes.

---

## Anti-auto-validation

L'IA a tendance à générer des tests qui passent toujours, parce qu'elle choisit des données qui garantissent le succès. Ces tests ne détectent rien.

**Règle a — Séparer la génération du code et la génération des tests**

Ne jamais demander en un seul prompt "développe cette feature ET écris les tests". D'abord le code. Ensuite, dans un contexte séparé, les tests.

**Règle b — Vérifier que les tests échouent avant l'implémentation**

Avant d'écrire le code, lancer les tests. S'ils passent déjà — le code n'existant pas — le test est mal écrit. Un test qui passe sans code ne teste rien.

**Règle c — Demander explicitement des tests négatifs**

Toujours inclure dans la demande de génération : "Génère également des scénarios qui doivent échouer — inputs incorrects, cas limites, actions non autorisées. Les tests doivent vérifier que l'application rejette correctement ces cas, pas seulement qu'elle les accepte."

**Règle d — Tester le chemin réel, pas un substitut qui lui ressemble**

Un test valide ce qu'il exerce, pas ce qu'il évoque. Le substitut le plus dangereux est celui qui ressemble assez à la cible pour qu'on oublie que c'en est un — il donne *plus* de confiance qu'aucun test, alors qu'il couvre moins qu'on ne croit.

Cas typique : un correctif dont l'enjeu est « **survit à l'événement X** » — recreate de conteneur, redéploiement, reboot, rotation de secret, migration. Le test doit **provoquer X**, jamais le simuler sur une copie.

Question à se poser explicitement : *« quel est l'état d'après-X, et comment je le fabrique sans toucher à la production ? »*

**Le patron qui répond presque toujours : l'environnement jetable, alimenté par les données réelles en lecture seule.**

```bash
# Conteneur neuf créé depuis l'image réelle, données de production montées en RO.
# Couche d'écriture vierge = exactement l'état d'après-recreate. Zéro effet de bord.
docker run --rm -v /chemin/donnees:/opt/data:ro --entrypoint sh <image> -c '...'
```

Décliner selon le contexte : base de données éphémère, clone en lecture seule, worktree git jetable, machine virtuelle neuve.

Deux précisions issues du terrain :

- **Viser l'artefact que l'événement emploierait réellement** — l'image que `docker compose up` utiliserait (celle construite localement), pas l'image amont dont elle dérive. Se tromper de cible fait tester autre chose, et peut déclencher un téléchargement inutile de plusieurs gigaoctets.
- **Prouver que le correctif est *invoqué*, pas seulement qu'il *fonctionne*.** Tester un script isolément ne dit rien de son déclenchement. Il faut exercer le mécanisme appelant — la boucle de l'entrypoint, le hook, le cron — dans le même environnement jetable.

Si le test se fait malgré tout sur un substitut, le **nommer comme tel** dans le compte rendu : « logique validée, chemin réel non exercé ». Une sauvegarde jamais restaurée, un correctif jamais rejoué après l'événement qu'il vise, ne sont pas vérifiés — ce sont des hypothèses.

**Règle e — Un mécanisme idempotent par contrat se teste par deux exécutions, pas une**

Sauvegarde, synchronisation, installation, migration : tout ce qui doit pouvoir tourner plusieurs fois sans dégât. **Le premier passage ne prouve rien**, parce que la sémantique des outils de copie dépend de l'état préalable de la destination, pas seulement des arguments.

| Commande | Destination absente | Destination existante |
|---|---|---|
| `cp -R src dst` | `dst` = copie de `src` | crée `dst/src` — imbrication |
| `rsync -a src dst/` | `dst/src` | `dst/src` (identique) |
| `rsync -a src/ dst/` | contenu de `src` dans `dst` | idem, mais les fichiers en trop **restent** |
| `rsync -a --delete src/ dst/` | idem | miroir exact — les fichiers en trop sont supprimés |

Le protocole minimal :

1. exécuter une première fois ;
2. exécuter une **seconde** fois sans rien changer entre les deux ;
3. comparer la **structure**, pas seulement le code de retour : `find <dst> -type d`, `diff -rq <src> <dst>`.

Un dossier apparu au second passage, un fichier qui a cessé d'être mis à jour, une arborescence plus profonde qu'attendu : c'est le mode de panne, et il est **invisible au premier passage**.

Vécu le 03/08/2026 : un script de sauvegarde en `cp -R` a laissé pendant quatre jours les fichiers du premier niveau figés à la première exécution, pendant que les mises à jour s'accumulaient dans un sous-dossier imbriqué. Le dépôt paraissait sain — commits réguliers, aucune erreur — et une restauration aurait rendu des données périmées. Corrigé en `rsync -a --delete` avec barres obliques finales : la destination devient identique à la source, donc auto-réparatrice.

Corollaire pour une sauvegarde : **la seule preuve est une restauration**. Un `git log` qui avance prouve que le script tourne, pas qu'il sauvegarde ce qu'on croit.

---

## Audit et auto-évaluation

Après génération des tests, avant exécution, poser systématiquement ces deux questions à l'IA :

1. "Relis ces tests. Les données que tu as utilisées représentent-elles de vrais cas d'usage, ou garantissent-elles simplement que les tests passent ?"
2. "Quels scénarios ces tests ne couvrent-ils pas ?"

Ces deux questions forcent l'identification des angles morts avant qu'ils deviennent des bugs en production.

---

## Couverture fonctionnelle

Avant de valider la batterie de tests Playwright, vérifier que chaque scénario Gherkin du cahier de recettes a un test automatisé correspondant.

Règle : **un scénario Gherkin = un test Playwright**.

Si un scénario n'a pas de test → le générer avant de continuer.

---

## Outils de référence

| Outil | Usage |
|---|---|
| Vitest | Tests unitaires et d'intégration |
| Playwright | Tests d'interface automatisés (E2E) |
| GitHub Actions | CI/CD — intégration des tests dans le pipeline de déploiement |

---

## Remontée de bug

Quand un bug est détecté lors de la recette manuelle, le skill `/debug` est déclenché automatiquement.

### Anatomie d'un bon rapport de bug

Un rapport insuffisant ("ça ne marche pas, corrige") ne donne pas le contexte nécessaire pour diagnostiquer. Un bon rapport contient 4 éléments :

```
1. OÙ      → quelle page, quel écran, quel rôle utilisateur
2. QUOI    → quelle action exactement
3. RÉSULTAT → ce qui s'est passé (message d'erreur, comportement incorrect)
4. ATTENDU  → ce qui aurait dû se passer
+ message d'erreur copié intégralement (console du navigateur ou terminal)
```

Exemple :
```
OÙ      : page /planning, connecté en tant que bénévole (test@email.com)
QUOI    : clic sur "Signaler une indisponibilité" pour le créneau Mardi 14h
RÉSULTAT : le bouton se grise une seconde puis revient. Console : "Error 403: permission denied on table disponibilites"
ATTENDU : le créneau aurait dû passer en orange
```

**Règle :** si on envoie un screenshot sans préciser le résultat attendu, l'IA risque de considérer l'état bugué comme l'état normal.

### Escalade

Si le bug n'est pas résolu après deux essais → suivre le protocole d'escalade défini dans `methode.md` (Phase Code — section Pilotage de la session de code).

Un bug non résolu est bloquant : la recette ne peut pas continuer tant qu'il n'est pas corrigé.

Doctrine de debug : intégrée au skill `/debug`.
