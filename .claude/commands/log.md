# /log — Journal de bord

Met à jour le fichier `[projet].log.md` pour le projet en cours de travail.

**Modèle recommandé : T1 — Haiku** _(optionnel)_
> Tâche mécanique. Sonnet fonctionne parfaitement. Si Medwin veut optimiser les tokens : _"Tape `/model haiku` avant de lancer."_

## Identification du projet

Détermine le nom du projet à partir du répertoire de travail courant.

## Rôle de `.log`

Journal de bord factuel et daté. Entrées courtes, sans explication technique — les détails sont dans `.peda`. L'objectif est une trace concise de ce qui s'est passé, consultable d'un coup d'œil.

## Création

Si `[projet].log.md` n'existe pas → le créer avec l'en-tête `# [projet].log — Journal de bord`.

## Structure

Ajouter les entrées de la session courante :

```markdown
## Jour N — [date]

### Session N — [résumé en une phrase]

- [entrée factuelle 1]
- [entrée factuelle 2]
```

Chaque session dans sa propre section. Jamais dans la section d'une session précédente.

## Règle de non-duplication

Lire le fichier avant d'écrire. Ne documenter que l'incrément depuis la dernière entrée.

## Calibrage des entrées

- Bonne entrée : `Implémenté streaming SSE sur POST /api/chat`
- Trop vague : `Travaillé sur le chat`
- Trop technique : `Modifié le handler EventSource pour corriger le flush des chunks en cas de timeout réseau`

Les détails techniques vont dans `.peda`, pas ici.
