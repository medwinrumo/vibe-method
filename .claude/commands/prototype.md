# /prototype — Code jetable pour valider une décision

Un prototype répond à une question précise, puis s'efface. La question détermine la forme.

Skill transversal — invocable à tout moment. Déclenché par Claude quand une décision est difficile à trancher sans la voir fonctionner ou tourner.

---

## Choisir la branche

Identifie quelle question est posée :

- **"Est-ce que cette logique / ce modèle d'état tient ?"** → **Branche logique** : un mini programme en terminal interactif qui pousse la machine d'état à travers les cas difficiles à raisonner sur le papier.
- **"À quoi ça doit ressembler ?"** → **Branche UI** : plusieurs variations radicalement différentes sur une même route, switchables via un paramètre d'URL et une barre flottante.

Si la question est ambiguë et que Medwin n'est pas disponible → prendre la branche qui correspond au contexte immédiat (module back-end → logique ; page ou composant → UI) et l'annoncer en haut du prototype.

---

## Règles communes

1. **Jetable dès le départ, clairement marqué.** Nommer le fichier ou le dossier pour qu'un lecteur casual voie immédiatement que c'est un prototype. Le placer près du module ou de la page concernée — pas dans un dossier isolé sans contexte.

2. **Une commande pour lancer.** S'appuyer sur le task runner existant du projet (`pnpm`, `bun`, `python`, etc.). Medwin doit pouvoir démarrer sans réfléchir.

3. **Pas de persistence par défaut.** L'état vit en mémoire. Si la question porte explicitement sur la base de données → utiliser une BDD scratch ou un fichier local nommé "PROTOTYPE — à supprimer".

4. **Zéro polish.** Pas de tests, pas de gestion d'erreur au-delà du nécessaire pour le faire tourner, pas d'abstractions. L'objectif est d'apprendre vite.

5. **Rendre l'état visible.** Après chaque action (logique) ou à chaque changement de variante (UI), afficher ou rendre l'état complet. Medwin doit voir ce qui change.

6. **Supprimer ou absorber quand c'est répondu.** Une fois la question résolue, soit supprimer le prototype, soit intégrer la décision validée dans le vrai code. Ne pas le laisser dans le repo.

---

## En sortie

La **réponse** est la seule chose à conserver. La capturer de manière durable :
- Dans un message de commit
- Dans un `/adr` si la décision engage l'architecture
- Dans une note `NOTES.md` à côté du prototype, à supprimer avec lui

Si la réponse engage une décision architecturale → proposer `/adr` avant de supprimer le prototype.
