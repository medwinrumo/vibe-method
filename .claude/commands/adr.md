# /adr — Capture d'une décision architecturale

Tu captures une décision architecturale au moment où elle est prise, avant que le contexte qui l'a motivée ne soit perdu.

---

## Quand lancer /adr

- Immédiatement après qu'une décision structurante a été prise (choix de stack, choix d'architecture, abandon d'une approche)
- Proposé automatiquement par `/archi` et `/specs` sur les décisions majeures
- Invocable manuellement à tout moment

### Filtre — 3 conditions requises (toutes)

Avant de capturer un ADR, vérifier que les 3 conditions sont réunies. Si une seule manque → pas d'ADR.

1. **Difficile à inverser** — changer d'avis plus tard a un coût réel (migration, refonte, dette)
2. **Surprenant sans contexte** — un futur lecteur se demanderait "pourquoi ils ont fait ça ?" sans cette trace
3. **Vrai arbitrage** — il y avait de vraies alternatives ; une a été choisie pour des raisons précises

Si la décision est évidente, facilement réversible, ou n'avait pas d'alternative réelle → la noter dans un commentaire de code ou un commit, pas dans un ADR.

---

## Étape 0 — Identification

Détermine le nom du projet depuis le répertoire courant.

---

## Étape 1 — Capture des 4 points

Tu poses 4 questions, une par une :

1. > "**Décision prise** : quelle est la décision exacte ? (formulée en une phrase)"
2. > "**Alternatives écartées** : quelles options ont été considérées et rejetées ? Pour chacune, pourquoi elle a été écartée."
3. > "**Raisonnement** : qu'est-ce qui a fait pencher la balance pour cette option ?"
4. > "**Conditions de révision** : dans quelles circonstances cette décision devrait être remise en question ?"

---

## Étape 2 — Génération de l'entrée ADR

Tu génères l'entrée au format suivant :

```markdown
---
## ADR-[N] — [Titre court]
_[date]_

**Décision :** [une phrase]

**Alternatives écartées :**
- [option] — [raison du rejet]

**Raisonnement :** [2-3 phrases max]

**Conditions de révision :** [déclencheur ou condition]
```

---

## Étape 3 — Enregistrement dans [projet].adr.md

Tu **appendes** l'entrée à `[projet].adr.md`. Ce fichier est un journal — chaque entrée est ajoutée à la suite, jamais écrasée, jamais réordonnée.

Si `[projet].adr.md` n'existe pas → le créer avec cet en-tête :

```markdown
# ADR — [Nom du projet]
_Architectural Decision Records — appendé à chaque décision, jamais écrasé._

```

Tu attribues le numéro suivant (ADR-1, ADR-2...) en comptant les entrées existantes.

**Mise à jour CLAUDE.md** — upsert de la section `## Décisions clés` :
- Section existante → remplacer intégralement (conserver les ADR précédents, ajouter le nouveau)
- Section absente → créer avec ce premier ADR

```markdown
## Décisions clés
_→ Détails : `[projet].adr.md`_

- ADR-[N] : [titre] — [décision en 1 ligne]
```

---

## Règles

- **Capture immédiate** — l'ADR perd sa valeur si la session se compacte avant qu'il soit écrit
- **Jamais réécrire** — si une décision est révisée, créer un nouvel ADR qui référence l'ancien
- **Bref et précis** — 2-3 phrases max par section

---

## Prochaine étape

Reprendre là où tu étais dans la chaîne — l'ADR est capturé, retour au skill appelant (`/specs`, `/archi`, ou autre).
