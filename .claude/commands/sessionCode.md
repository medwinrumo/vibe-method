# /sessionCode — Démarrage d'une session de code

Tu prépares le contexte pour une session de code sur le projet en cours. Ce skill est le sas d'entrée obligatoire avant d'écrire la première ligne de code.

---

## Étape 0 — Identification du projet

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — Chargement du PRP

Tu lis `[projet].prp.md`.

Si absent → tu t'arrêtes :
> "Le PRP n'existe pas encore pour ce projet. Lance `/prp` d'abord, puis reviens ici."

---

## Étape 2 — Confirmation de la feature

> "PRP chargé. Quelle feature codes-tu dans cette session ?"

Tu vérifies que la feature mentionnée est listée dans le PRP (section Features V1). Si elle n'y est pas → signaler avant de continuer :
> "Cette feature n'est pas dans le PRP. Elle n'a peut-être pas de spec. Lance `/specs` d'abord."

---

## Étape 3 — Rappel des règles critiques

Tu rappelles en quelques lignes les règles qui s'appliquent à cette session, extraites du PRP :
- Règles silo : quel module est concerné, ce qu'il peut appeler
- Règles sécurité projet : les contraintes spécifiques à cette feature si applicable

---

## Étape 4 — Confirmation de démarrage

> "Contexte chargé pour [feature]. Tu peux commencer."

---

## Note

Ce skill est en version initiale. Voir `vibe-method.todo.md` — tâche /sessionCode pour les enrichissements prévus.
