# /lint — Contrôle qualité du Wiki

Vérifie la cohérence et la fraîcheur de `~/dev/wiki/`. Distinct du lint wiki vibe-method (étape 5 de `/maj`).

Deux modes selon le coût en tokens acceptable.

---

## Modes

**`/lint quick`** — Faible coût tokens. Lit `index.md` + frontmatters uniquement.
Détecte : pages orphelines, fichiers potentiellement obsolètes (via champ `updated:`).

**`/lint`** (mode complet) — Lit tous les fichiers entiers.
Détecte : contradictions, pages manquantes, pages orphelines, affirmations obsolètes.

Déclarer le mode utilisé en tête de rapport.

---

## Mode quick

### Étape 1 — Inventaire

Lire `~/dev/wiki/index.md` pour obtenir la liste complète des fichiers de savoir et leurs métadonnées.

### Étape 2 — Frontmatters

Pour chaque fichier listé dans `index.md`, lire uniquement son frontmatter (champs `tags`, `created`, `updated`, `sources`).

### Étape 3 — Pages orphelines

Une page est orpheline si son nom de fichier est absent du tableau de `index.md` (colonne Fichier).

Vérifier aussi les fichiers `.md` présents sur disque mais non listés dans `index.md` :

```bash
ls ~/dev/wiki/*.md
```

Comparer avec la liste de `index.md`. Toute page présente sur disque mais absente du tableau → orpheline candidate.

### Étape 4 — Affirmations potentiellement obsolètes

Pour chaque fichier dont `updated:` date de plus de 6 mois → le signaler comme potentiellement obsolète.

### Étape 5 — Rapport quick

> **Lint quick Wiki — [date]**
>
> **Pages orphelines** : [N]
> - `[fichier].md` — absent du tableau index
>
> **Potentiellement obsolètes** (`updated` > 6 mois) : [N]
> - `[fichier].md` — dernière mise à jour : [date]
>
> **Aucun problème détecté.** (si rien trouvé)

---

## Mode complet

À invoquer périodiquement — pas en routine.

### Étape 1 — Inventaire complet

Lire `~/dev/wiki/index.md`. Puis lire chaque fichier de savoir listé dans son intégralité.

### Étape 2 — Contradictions

Pour chaque sujet couvert dans plusieurs fichiers, comparer les informations.
Si deux fichiers affirment des choses incompatibles sur le même sujet → signaler.

> **Contradiction** : `[Fichier A]` dit X / `[Fichier B]` dit Y sur [sujet]. Laquelle est correcte ?

### Étape 3 — Pages manquantes

Identifier les concepts qui reviennent dans 3 pages ou plus sans avoir leur propre fichier.

> **Page manquante** : "[concept]" apparaît dans [N] pages ([liste]) sans sa propre page. Créer `[concept].md` ?

### Étape 4 — Pages orphelines

Une page est orpheline si son nom de fichier n'est mentionné :
- ni dans le tableau de `index.md`
- ni dans le contenu d'aucune autre page de savoir

> **Page orpheline** : `[fichier].md` — n'est référencée nulle part.

### Étape 5 — Affirmations obsolètes

Chercher en priorité : `updated:` > 6 mois.
Chercher en secondaire dans le contenu : marqueurs temporels ("à venir", "bêta", "prochainement", "dans les prochains mois"), dates explicites passées.

> **Potentiellement obsolète** : `[fichier].md` — "[extrait]" — à vérifier.

### Étape 6 — Rapport complet

> **Lint complet Wiki — [date]**
>
> **Contradictions** : [N]
> [liste]
>
> **Pages manquantes** : [N candidates]
> [liste]
>
> **Pages orphelines** : [N]
> [liste]
>
> **Potentiellement obsolètes** : [N]
> [liste]
>
> **Aucun problème détecté.** (si rien trouvé)

---

## Étape finale — Correction (les deux modes)

Pour chaque problème signalé, proposer une action et attendre la validation de Medwin :

| Problème | Action proposée |
|---|---|
| Contradiction | Choisir la version correcte — mettre à jour le fichier concerné |
| Page manquante | Créer la page (si Medwin valide) |
| Page orpheline | Supprimer ou intégrer à une autre page (si Medwin valide) |
| Obsolète | Mettre à jour ou supprimer l'information |

Chaque correction → entrée dans `~/dev/wiki/log.md`.

---

## Règles

- Ne jamais supprimer sans validation explicite de Medwin
- Lire tous les fichiers avant de signaler (mode complet) — pas de rapport partiel
- Logger toutes les corrections dans `log.md`
- Si aucun problème trouvé → le dire clairement

---

## Prochaine étape

Corrections appliquées → Wiki plus cohérent.
