# /wiki — Enrichir le Wiki depuis n'importe quel dossier

Garantit que les règles de `~/dev/wiki/CLAUDE.md` sont appliquées, même quand la session ne travaille pas dans le dossier `~/dev/wiki/`.

## Déclencheur

À invoquer chaque fois que Medwin demande d'ajouter, noter, enrichir ou sauvegarder une connaissance dans "le wiki" / "le second cerveau" — quel que soit le dossier de travail courant.

## Procédure

1. `cd ~/dev/wiki && git pull` — se mettre à jour avant de lire ou écrire (règle 6 de `CLAUDE.md`, risque de collision avec Hermes)
2. Lire `~/dev/wiki/CLAUDE.md` en entier (source de vérité unique), si pas déjà lu dans cette session
3. Lire `~/dev/wiki/index.md` pour voir ce qui existe déjà
4. Appliquer les règles telles quelles (frontmatter, dédoublonnage, wikilinks, tags canoniques)
5. Logger l'opération dans `log.md`
6. `git add` + commit + `git push` — sans attendre (règle 6)
7. Confirmer à Medwin ce qui a été ajouté/modifié, avec le(s) fichier(s) concerné(s) et le commit

## Règle absolue

Ne jamais écrire dans le wiki sans avoir lu `CLAUDE.md` au préalable dans la session en cours, même si le sujet semble simple.
