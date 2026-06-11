# /condense — Condenser un document

Réduis n'importe quel document long (compte-rendu, email, doc externe, retour client) à l'essentiel exploitable — sans perdre les décisions, les contraintes et les chiffres.

---

## Étape 1 — Récupération du document

> "Colle le document à condenser directement ici, ou donne-moi son chemin dans le repo."

Si Medwin colle le texte → l'utiliser directement.
Si Medwin donne un chemin → lire le fichier.

---

## Étape 2 — Condensation

**Conserver :**
- Décisions prises (explicites ou implicites)
- Contraintes imposées (délais, budget, technique, légal)
- Chiffres et dates
- Acteurs nommés et leur rôle
- Points de friction ou désaccords

**Supprimer :**
- Formules de politesse et transitions rhétoriques
- Répétitions et reformulations du même point
- Exemples purement illustratifs (sauf si l'exemple est la décision)
- Digressions hors-scope

Format de sortie : liste à puces, une ligne par point. Pas de paragraphes.

---

## Étape 3 — Usage

> "Ce condensé va servir à quoi ?
> 1. Alimenter un `/brief` ou `/contexte` — je le formate en inputs prêts à coller
> 2. Alimenter un `/prd` ou `/prd-update` — je le structure en retours à intégrer
> 3. Sauvegarder comme référence dans `[projet].context.md`
> 4. Usage libre — je te rends le condensé brut"

Selon le choix de Medwin :

**Option 1 — Pour `/brief` ou `/contexte` :**
Reformater en liste de réponses aux domaines du `/brief` (problème, utilisateurs, fonctions, contraintes, règles métier, sécurité, RGPD).
> "Voilà les inputs formatés pour `/brief`. Colle-les directement quand Claude posera les questions."

**Option 2 — Pour `/prd` ou `/prd-update` :**
Structurer en liste de suggestions / retours avec catégorie (Feature, NFR, Règle métier, Scope creep probable).
> "Voilà les retours formatés pour `/prd-update`. Lance `/prd-update` et colle-les."

**Option 3 — Référence dans `[projet].context.md` :**
Appender le condensé dans `[projet].context.md` sous une section `## Source — [titre ou date]`.
> "Condensé sauvegardé dans `[projet].context.md`."

**Option 4 — Brut :**
Livrer le condensé tel quel.

---

## Ton

Direct et factuel. Le condensé est un outil, pas un résumé littéraire. Chaque ligne doit être exploitable immédiatement.
