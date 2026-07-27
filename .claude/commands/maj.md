# /maj — Clôture de session

Effectue la clôture complète de session pour le projet en cours.

**Modèle recommandé : T1 — Haiku** _(optionnel)_
> Tâche mécanique. Sonnet fonctionne parfaitement. Si Medwin veut optimiser les tokens : _"Tape `/model haiku` avant de lancer."_

## Étape 1 — Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant (ex : `minou` depuis `/Users/medwinrumo/dev/minou`).

## Étape 2 — Documentation locale

Avant le commit Git, mettre à jour les fichiers de documentation. Ces fichiers seront inclus dans le commit de clôture.

1. **`[projet].peda.md`** — Documenter la session : ce qu'on a fait, pourquoi, comment, difficultés rencontrées. Lire le fichier avant d'écrire.
2. **`[projet].log.md`** — Entrées factuelles courtes de la session. Lire avant d'écrire.
3. **`[projet].doc.md`** — Si la session a produit des changements visibles pour l'utilisateur ou l'opérateur. Ignorer si rien n'a changé.
4. **`[projet].spec-global.md`** — Si la session a produit des changements de spec (fonctionnalité décidée, contrainte modifiée, décision abandonnée). Ignorer si rien n'a changé.

**Règle de non-duplication :** si `/checkpoint` a été lancé en cours de session, ne documenter que l'incrément depuis le dernier checkpoint.

## Étape 3 — GitHub

1. Vérifier que tout est commité (`git status`)
2. Si des modifications non commitées existent → lancer `/commit` pour générer le message au bon format et créer le commit
3. Pousser la branche courante (`git push`)

### Fichier `CLAUDE.md`

Chaque skill est responsable de sa propre section (upsert). Le rôle de `/maj` est de vérifier la cohérence :
1. Lire `CLAUDE.md` — identifier les sections présentes
2. Pour chaque section, vérifier que le contenu correspond à l'état actuel de l'artefact référencé
3. Si une section est manifestement périmée → la mettre à jour silencieusement

**Sync sécurité automatique :**
Si `[projet].archi.md` existe et contient une section `## Sécurité` :
1. Lire la section `## Sécurité` de `[projet].archi.md`
2. Lire le bloc `## Sécurité — règles de ce projet` du `CLAUDE.md` projet
3. Si les deux diffèrent → mettre à jour le bloc du `CLAUDE.md` projet pour le remettre en phase avec `archi.md`
Cette sync est silencieuse si aucune différence — elle ne signale que si une mise à jour a été faite.

## Étape 4 — GitHub Projects

Met à jour le kanban du projet.

**Prérequis** : `.gh-project.local` présent dans le répertoire courant (voir `/todo` — setup GitHub Projects).

Si `.gh-project.local` existe :
1. Lire les variables : `project_number`, `owner`, `project_id`, `field_status_id`, `option_todo_id`, `option_in_progress_id`, `option_done_id`, `option_late_id`, `field_debut_id`, `field_fin_id`

2. Récupérer l'état actuel via GraphQL (retourne status + dates pour chaque item) :

       gh api graphql -f query='{ node(id: "$project_id") { ... on ProjectV2 { items(first: 50) { nodes { id content { ... on DraftIssue { id title } } fieldValues(first: 10) { nodes { ... on ProjectV2ItemFieldSingleSelectValue { name field { ... on ProjectV2SingleSelectField { name } } } ... on ProjectV2ItemFieldDateValue { date field { ... on ProjectV2Field { name } } } } } } } } } }'

3. **Tâches terminées cette session** → mettre à jour en "Done" :

       gh project item-edit --id [pvti_id] --project-id $project_id \
         --field-id $field_status_id --single-select-option-id $option_done_id

4. **Nouvelles tâches identifiées** → créer les items avec titre + description :

       # Créer l'item (retourne PVTI_xxx)
       gh project item-create $project_number --owner $owner --title "[titre]" --format json

       # Récupérer l'ID DI_ du contenu draft
       gh api graphql -f query='{ node(id: "PVTI_xxx") { ... on ProjectV2Item { content { ... on DraftIssue { id } } } } }'

       # Remplir la description (--title obligatoire avec --body)
       gh project item-edit --id "DI_xxx" --title "[titre]" --body "[description depuis .todo.md]"

5. **Tâches démarrées** → mettre à jour en "In Progress" (même commande avec `$option_in_progress_id`)

6. **Détection des tâches "Late"** → pour chaque item Todo ou In Progress dont `fin < aujourd'hui` :

       gh project item-edit --id [pvti_id] --project-id $project_id \
         --field-id $field_status_id --single-select-option-id $option_late_id

   Mettre à jour `.todo.md` local avec la mention du retard.

Si `.gh-project.local` absent → ignorer cette étape silencieusement.

## Étape 5 — Lint wiki (si projet vibe-method)

Si le répertoire courant est `vibe-method/` :

1. Détecter les sources modifiées depuis le dernier commit :
   ```
   git diff --name-only HEAD
   ```
2. Si au moins un fichier source wiki a changé (doctrines `*.md`, skills `.claude/commands/*.md`, `CLAUDE.md`) → lancer le lint wiki :
   - **Liens orphelins** : chaque `[[lien]]` dans le wiki pointe vers une page qui existe sur le disque
   - **Pages stales** : `source_modified` > `wiki_updated` dans le frontmatter — la source a changé mais le wiki n'a pas été mis à jour
   - **Pages sans frontmatter** : toute page wiki sans `type:` ou `source:`
   - **Pages manquantes** : un skill ou doctrine existe dans les sources mais n'a pas de page wiki

3. Signaler les problèmes trouvés. Pour chaque page stale → proposer la mise à jour immédiatement.

Si aucune source n'a changé → ignorer cette étape silencieusement.

---

## Étape 6 — Cohérence skills / doctrine (si projet vibe-method ou si un skill a été modifié)

Si la session a modifié un skill ou un fichier de doctrine (`produit.md`, `methode.md`, `architecture.md`, `securite.md`) :

| Doctrine modifiée | Skill(s) à vérifier |
|---|---|
| `produit.md` | `/brief` `/prd` `/prd-update` `/specs` |
| `architecture.md` | `/archi` |
| `securite.md` | `/securite` |
| `methode.md` | `/roadmap` `/tests` `/recette` |

Pour chaque paire concernée :
1. Lire la doctrine modifiée
2. Lire le skill correspondant
3. Identifier les divergences
4. Proposer la mise à jour à Medwin — ne jamais modifier sans validation explicite

## Étape 7 — Review task-observer

Lire `~/.claude/observations/log.md`.

1. Si aucune observation au statut OUVERT → passer à la checklist finale.
2. Pour chaque observation OUVERTE, identifier le skill concerné (fichier
   `~/.claude/commands/[skill].md`, ou skill dans `~/.claude/skills/`) et
   le lire.
3. Regrouper par skill : présenter à Medwin (numéro, titre, une phrase de
   constat, suggestion concrète). Nouveaux skills candidats à part.
4. Attendre validation de Medwin avant de modifier quoi que ce soit — ne
   jamais toucher un skill sans accord explicite.
5. Pour chaque observation validée et appliquée : marquer
   `**Statut :** ACTIONNÉ (date) — [ce qui a été fait]` dans le log.
6. Pour chaque observation refusée : marquer
   `**Statut :** REFUSÉ (date) — [raison]`.

## Checklist finale

- [ ] `[projet].peda.md` complété
- [ ] `[projet].log.md` complété
- [ ] `[projet].doc.md` mis à jour si nécessaire
- [ ] `[projet].spec-global.md` mis à jour si nécessaire
- [ ] Tout commité et poussé sur GitHub
- [ ] `CLAUDE.md` — sections vérifiées et cohérentes avec leurs artefacts
- [ ] Bloc sécurité du `CLAUDE.md` synchronisé avec `archi.md` (si projet avec archi)
- [ ] GitHub Projects mis à jour (tâches terminées + nouvelles tâches)
- [ ] Lint wiki passé (si projet vibe-method et sources modifiées)
- [ ] Cohérence skills / doctrine vérifiée si applicable
- [ ] Review task-observer effectuée (observations traitées ou reportées)
