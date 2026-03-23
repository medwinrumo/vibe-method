# methode.md

Le process de travail — dans quel ordre construire, comment passer d'une étape à la suivante.
À enrichir au fil des sessions.

---

## Les phases

### Phase 1 — Produit
> Définir ce qu'on construit avant de toucher au code.

- Rédiger le brief
- Construire le PRD (cross-pollination entre IA)
- Définir le backlog et les user stories
- Identifier les enjeux de sécurité

Fichiers de référence : `produit.md`, `securite.md`

---

### Phase 2 — Architecture
> Décider comment le code est organisé.

- Choisir le pattern d'architecture (ex : modulaire)
- Définir les modules et leurs responsabilités
- S'assurer qu'ils sont indépendants

Fichier de référence : `architecture.md`

---

### Phase 3 — Planification
> Construire la roadmap d'exécution.

- Donner le PRD à Claude pour générer la roadmap en markdown
- Découper en features parallélisables
- Chaque bloc = la plus petite feature possible

---

### Phase 4 — Code
> Coder feature par feature, en respectant les règles établies.

- Une feature à la fois, validée contre ses critères d'acceptation
- Appliquer les règles de sécurité et d'architecture en continu
- Rien n'est ajouté silencieusement sans validation de Medwin

Fichiers de référence : `securite.md`, `architecture.md`

---

### Phase 5 — Vérification
> S'assurer que ce qui est construit correspond aux specs.

- Claude génère la liste des tests (scénarios Gherkin issus des critères d'acceptation)
- Medwin exécute les tests manuellement
- Medwin rend compte du résultat et valide définitivement
- Une feature n'est "Done" que quand Medwin a validé

---

## Règles Git — projets applicatifs

- `main` = toujours stable, jamais de code non validé
- Une branche par feature : `feat/[nom-feature]`
- Merge dans `main` après validation `/recette` ✅
- Branche supprimée après merge
- PR (Pull Request) optionnelle en solo — recommandée pour forcer une relecture avant merge

---

## Règle transversale

Rien n'entre dans le système (fichiers, règles, code) sans discussion préalable et validation explicite de Medwin.
