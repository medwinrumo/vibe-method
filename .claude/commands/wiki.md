---
description: Enrichit ~/dev/wiki depuis n'importe quel dossier de travail, en appliquant ses règles et son workflow git
---

# /wiki — Enrichir le Wiki depuis n'importe quel dossier

Garantit que les règles de `~/dev/wiki/CLAUDE.md` sont appliquées, même quand la session ne travaille pas dans le dossier `~/dev/wiki/`.

## Déclencheur

À invoquer chaque fois que Medwin demande d'ajouter, noter, enrichir ou sauvegarder une connaissance dans "le wiki" / "le second cerveau" — quel que soit le dossier de travail courant.

## Procédure

0. **Clarifier la source du contenu — étape obligatoire**, sauf si Medwin l'a déjà rendue explicite dans sa demande. Demander : *« Que veux-tu ajouter au wiki ? »*. Le contenu peut être :
   - la conversation entière en cours
   - un document externe, transmis via son chemin d'accès
   - le résultat d'un crawl/scraping déjà commandé
   - une portion ciblée de la conversation (derniers échanges, échanges relatifs à une question précise, ou seulement la dernière réponse)

   Ne pas lancer la suite tant que la source n'est pas précisée.
1. `cd ~/dev/wiki && git pull` — se mettre à jour avant de lire ou écrire (règle 6 de `CLAUDE.md`, risque de collision avec Hermes)
2. Lire `~/dev/wiki/CLAUDE.md` en entier (source de vérité unique), si pas déjà lu dans cette session
3. Lire `~/dev/wiki/index.md` pour voir ce qui existe déjà
4. Appliquer les règles telles quelles (frontmatter, dédoublonnage, wikilinks, tags canoniques) au contenu précisé à l'étape 0
5. **Écrire la `description` aux deux endroits** — frontmatter de la fiche **et** dernière colonne de sa ligne dans `index.md`, à l'identique. Une phrase, évocatrice, qui dit ce que contient la fiche et quand elle sert — pas le titre recopié. Guillemets obligatoires (la description contient presque toujours un `:` ou une virgule). Règles complètes dans `wiki/CLAUDE.md`, section « Frontmatter ». Le lint vérifie l'existence **et** la concordance des deux.
6. Logger l'opération dans `log.md`
7. `git add` + commit + `git push` — sans attendre (règle 6)
8. Confirmer à Medwin ce qui a été ajouté/modifié, avec le(s) fichier(s) concerné(s) et le commit

## Règle absolue

Ne jamais écrire dans le wiki sans avoir lu `CLAUDE.md` au préalable dans la session en cours, même si le sujet semble simple.
