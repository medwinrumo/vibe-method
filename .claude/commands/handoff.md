# /handoff — Ancre de contexte mid-session

Tu compresses la conversation courante en un document de reprise, sauvegardé dans le projet. Objectif : survivre à une compaction de contexte et permettre à la prochaine fenêtre de reprendre le fil précisément.

Ce skill ne remplace pas `/maj` — il est utilisé en cours de session, avant qu'une compaction se produise.

---

## Quand lancer /handoff

- La session est longue et le contexte commence à peser
- Tu sens qu'une compaction est imminente
- Tu veux préserver les détails d'une conversation non-code (analyse, décisions, exploration)

**Note :** pour les sessions de code, `/prp` joue déjà ce rôle. `/handoff` est utile pour les sessions où on travaille sur la méthode, des specs, des décisions d'architecture, ou tout autre contexte non-code.

---

## Étape 0 — Identification

Tu détermines le projet en cours depuis le répertoire courant.
Le fichier sera sauvegardé à la racine du projet : `handoff.md`.

---

## Étape 1 — Écrasement

Tu écrase `handoff.md` à chaque usage. Ce fichier contient toujours l'état le plus récent — pas un historique. Les vieilles entrées sont périmées dès qu'elles ont été lues par la nouvelle fenêtre de contexte. L'historique des décisions vit dans les vrais artefacts (git, ADR, PRD).

---

## Étape 2 — Rédaction du document

Tu rédiges une entrée concise avec les sections suivantes :

```markdown
---
## Handoff — [date] [heure]

### Contexte
[1-3 phrases : sur quoi porte cette session, quel est l'objectif]

### Ce qui a été fait
[Liste des décisions prises, fichiers modifiés, skills ajoutés — avec chemins exacts]
[Ne pas dupliquer le contenu des artefacts — référencer par chemin]

### État en cours
[Ce qui est en attente, incomplet, ou en suspens]

### Prochaine étape
[Ce que la prochaine fenêtre de contexte doit faire en premier]

### Skills à enchaîner
[Liste des skills recommandés pour la suite, dans l'ordre]
```

---

## Règles

- **Références, pas duplications** — si un PRD, un ADR ou un fichier existe, noter son chemin, pas son contenu
- **Concis** — ce fichier doit être rapide à relire, pas exhaustif
- **Chemins exacts** — chaque fichier mentionné avec son chemin complet depuis la racine du projet
- **Pas de clôture** — `/handoff` ne commite pas, ne pousse pas, ne met pas à jour Notion. C'est une ancre locale uniquement

---

## Après la compaction

Pour reprendre le fil dans la nouvelle fenêtre :
> "Lis `handoff.md` dans le projet courant et reprends à partir de là."

---

## Prochaine étape

Continuer la session. `/maj` reste la clôture officielle en fin de session.
