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

## Résultats (à remplir après le test)

### Output Claude Design
> À documenter : ce que Claude Design a produit, qualité, fidélité à la charte, cohérence entre écrans

### Mode B — intégration Tailwind
> À documenter : ce qui a bien traduit, ce qui a frotté, ce qui a nécessité des ajustements manuels

### Verdict final
> À documenter : le workflow est-il utilisable tel quel ? Qu'est-ce qui doit changer dans `/design` ?
