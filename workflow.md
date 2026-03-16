# workflow.md

Ce fichier définit les phases de travail à suivre pour chaque projet de vibe coding.
Il évolue au fil des sessions et de la montée en compétence.

---

## Phase 1 — Avant le code

> Objectif : construire le projet à fond avant de toucher au code.

- Définir le backlog (liste de toutes les features)
- Rédiger les user stories (format Story A4)
- Décider de l'architecture
- Identifier les enjeux de sécurité dès le départ

Fichiers de référence : `specs.md`, `architecture.md`, `securite.md`

---

## Phase 2 — Pendant le code

> Objectif : coder feature par feature, en respectant les règles établies.

- Une feature à la fois, validée contre ses critères d'acceptation
- Appliquer les règles de sécurité et d'architecture en continu
- Rien n'est ajouté silencieusement sans validation de Medwin

Fichiers de référence : `securite.md`, `architecture.md`

---

## Phase 3 — Vérification

> Objectif : s'assurer que ce qui est construit correspond aux specs.

- Claude génère la liste des tests à effectuer (format Gherkin)
- Medwin exécute les tests manuellement
- Medwin rend compte et valide définitivement
- Une feature n'est "Done" que quand Medwin a validé

Fichiers de référence : `tests.md`

---

## Règle transversale

Rien n'entre dans le système (fichiers, règles, code) sans discussion préalable et validation explicite de Medwin.
