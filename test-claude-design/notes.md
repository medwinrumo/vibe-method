# Tâche 3 — Notes de test Claude Design

> Test en cours : workflow Mode A → Claude Design → Mode B (React + Tailwind)
> Mini-projet fictif : TeamTasks — 3 écrans (liste, détail, formulaire)

---

## Réflexions en cours de test

### Réflexion 1 — One-shot vs two-step

Le fichier `teamtasks.design.md` est un document hybride : il contient à la fois le design system (charte : couleurs, typo, ambiance) ET la spécification des écrans (composants, comportements, ASCII art). Claude Design reçoit tout en une passe et produit l'interface d'un coup.

Claude Design peut fonctionner en deux temps :
1. D'abord construire le design system (tokens, composants de base, variantes)
2. Ensuite produire les écrans en s'appuyant sur ce système établi

**Question ouverte :** le one-shot tient-il la cohérence sur 3 écrans ? Sur 10 ou 15 ?

**Leçon anticipée :** selon le résultat de ce test, il faudra retravailler `/design` pour intégrer cette distinction. Le skill traite aujourd'hui tout en one-shot via un seul `[projet].design.md`. Une version mature pourrait prévoir deux documents séparés ou deux passes distinctes avec Claude Design.

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

## Résultats (à remplir après le test)

### Output Claude Design
> À documenter : ce que Claude Design a produit, qualité, fidélité à la charte, cohérence entre écrans

### Mode B — intégration Tailwind
> À documenter : ce qui a bien traduit, ce qui a frotté, ce qui a nécessité des ajustements manuels

### Verdict final
> À documenter : le workflow est-il utilisable tel quel ? Qu'est-ce qui doit changer dans `/design` ?
