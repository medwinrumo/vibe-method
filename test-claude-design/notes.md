# Tâche 3 — Notes de test Claude Design

> Test en cours : workflow Mode A → Claude Design → Mode B (React + Tailwind)
> Mini-projet fictif : TeamTasks — 3 écrans (liste, détail, formulaire)

---

## Réflexions en cours de test

### Réflexion 1 — One-shot vs two-step ✅ Intégré dans le skill (2026-05-15)

Le fichier `teamtasks.design.md` est un document hybride : il contient à la fois le design system (charte : couleurs, typo, ambiance) ET la spécification des écrans (composants, comportements, ASCII art). Claude Design reçoit tout en une passe et produit l'interface d'un coup.

Claude Design peut fonctionner en deux temps :
1. D'abord construire le design system (tokens, composants de base, variantes)
2. Ensuite produire les écrans en s'appuyant sur ce système établi

**Décision actée :** le Mode A commence maintenant par une décision one-shot vs two-step (Étape 0b du skill /design).
- **One-shot** : ≤ 6 écrans, 1 type d'utilisateur, navigation simple → un seul `[projet].design.md`
- **Two-step** : > 6 écrans, plusieurs rôles, navigation complexe → Passe 1 (design system) + Passe 2 (écrans par batch)
- **Règle critique two-step** : Claude Design n'a aucune mémoire entre sessions — chaque document de Passe 2 doit inclure la référence complète aux tokens et composants de Passe 1.

---

## Procédure Handoff Claude Design → Claude Code

### Route A — ZIP (recommandée pour projet vierge)

1. Dans Claude Design → "Share" → "Handoff to Claude Code" → cocher **"Download zip instead"** → télécharger
2. Créer le dossier projet (`~/dev/[projet]`)
3. Déposer le zip dans ce dossier
4. Ouvrir le dossier dans Claude Code (`claude ~/dev/[projet]`)
5. Lancer `/init` → Claude crée le CLAUDE.md du projet
6. Demander à Claude de dézipper et d'implémenter en React + Tailwind

### Route B — Send to local coding agent (projet React déjà configuré)

1. Dans Claude Design → "Share" → "Handoff to Claude Code"
2. Dans le champ **"Give the agent more detail"** → préciser la stack :
   `Implement as React components with Tailwind CSS. Create one file per screen component.`
3. Cliquer **"Send to local coding agent"** → copie la commande
4. Dans Claude Code — être dans le **dossier du projet React existant**
5. Coller et exécuter la commande

> **Règle :** Route A quand le projet n'existe pas encore. Route B quand le projet React est déjà bootstrappé et configuré.

---

## Observation générale — Précision requise avec Claude Design

Claude Design interprète ce qu'il reçoit. Tout ce qui n'est pas explicitement spécifié est une décision qu'il prend seul — et pas forcément dans le sens voulu. Contrairement à un développeur humain qui pose des questions, Claude Design ne demande pas de clarification : il produit.

**Conséquence pour le Mode A :** le `[projet].design.md` doit être d'une précision extrême. Chaque ambiguïté dans le brief = une décision arbitraire dans l'output. Plus le brief est vague, plus le résultat s'éloigne de l'intention.

**Ce que ça implique pour `/design` v2 :** le skill Mode A doit guider Medwin vers ce niveau de précision — poser les bonnes questions, forcer les décisions explicites, ne rien laisser à l'interprétation.

---

## Lacunes identifiées dans le Mode A

### Lacune 2 — Le Mode A doit forcer la précision à tous les niveaux

Le `teamtasks.design.md` contient des zones d'ambiguïté — pas uniquement sur les couleurs de fond, mais à tous les niveaux : structure des composants, comportements, états, espacements, hiérarchie visuelle. Partout où quelque chose n'est pas explicitement dit, Claude Design l'invente.

Exemple observé : la zone commentaires de l'écran Détail est apparue en blanc sans bordure — impossible de savoir si c'est une card ou le fond de page. Ce n'est qu'un cas parmi d'autres ambiguïtés possibles dans le document.

**L'enseignement n'est pas "préciser surface vs background" — c'est que la précision est de tous les instants dans le Mode A.** Chaque décision non prise par Medwin est une décision prise par Claude Design.

**Correction à apporter dans `/design` v2 :**
Le skill Mode A doit guider Medwin vers cette précision systématique — poser les bonnes questions, forcer les décisions à chaque niveau, ne rien laisser ouvert à l'interprétation. Le document produit doit être une spécification, pas un brief approximatif.

---

### Lacune 3 — Pas de boucle de révision design après Mode B

**Ce qu'on a en sortie de Mode B :** l'interface complète — navigation, routing, états, composants — sans backend ni auth. Le squelette fonctionnel visuel est là, mais pas encore chargé de logique métier.

**Ce qui manque :** une étape explicite entre Mode B et `/roadmap` — une boucle de révision design où on passe l'interface en revue dans le navigateur, on corrige les défauts visuels et UX, et on valide avant de commencer à coder les features.

Exemple concret détecté dans ce test : zone cliquable du composant date trop étroite. Visible immédiatement à l'usage après Mode B. Correction triviale à ce stade (padding sur le composant). Inutile et risqué d'attendre `/recette` — à ce moment le code métier est construit dessus et les corrections peuvent introduire des régressions.

**Pourquoi c'est le bon moment pour corriger :**
- Le code est encore propre — rien de métier n'est construit dessus
- Les corrections sont cosmétiques — aucun risque de régression fonctionnelle
- Attendre `/recette` = corriger du design sur un code chargé de logique

**Correction à apporter dans `/design` v2 :**
Ajouter une étape explicite après Mode B :
> **Étape 5 — Révision design in-browser**
> Parcourir tous les écrans dans le navigateur. Identifier les défauts visuels et UX (zones cliquables, espacements, états manquants, incohérences). Corriger directement dans le code avant de passer à `/roadmap`. Valider avec Medwin : "L'interface est correcte — on peut commencer à coder dessus ?"

---

### Lacune 4 — Medwin ne connaît pas le vocabulaire UI/UX

Sans le vocabulaire, impossible d'être précis dans le Mode A, impossible d'être créatif, impossible de communiquer sans friction. C'est une source d'erreurs et de perte de temps structurelle — pas un problème ponctuel.

**Trois corrections à apporter dans `/design` v2 :**

**1. Créer `ui-vocabulary.md` dans vibe-method**
Lexique de référence — zones d'un écran, composants courants, patterns de navigation, états — avec pour chacun : nom, définition, ASCII art illustratif. Consulté avant tout `/charte` ou `/design` Mode A.

**2. Transformer le Mode A en dialogue guidé**
Plutôt que demander à Medwin de décrire ses écrans en partant de zéro, le skill propose des patterns nommés avec exemples visuels (AskUserQuestion + ASCII art). Medwin choisit et ajuste — il ne doit pas inventer depuis rien.

**3. Claude prend en charge la terminologie en temps réel**
Quand Medwin décrit quelque chose sans en connaître le nom, Claude pose le nom, confirme, et l'utilise de manière cohérente dans tous les documents. Ce comportement existe déjà mais reste une source de friction — les propositions 1 et 2 le réduisent structurellement.

---

## Résultats (à remplir après le test)

### Output Claude Design
> À documenter : ce que Claude Design a produit, qualité, fidélité à la charte, cohérence entre écrans

### Mode B — intégration Tailwind
> À documenter : ce qui a bien traduit, ce qui a frotté, ce qui a nécessité des ajustements manuels

### Verdict final
> À documenter : le workflow est-il utilisable tel quel ? Qu'est-ce qui doit changer dans `/design` ?
