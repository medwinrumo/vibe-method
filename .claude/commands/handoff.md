# /handoff — Ancre de contexte mid-session

Tu compresses la conversation courante en un document de reprise, ou tu restaures un contexte sauvegardé. Un seul fichier — `handoff.md` — qu'on remplit ou qu'on vide selon l'état.

Ce skill ne remplace pas `/maj` — il est utilisé en cours de session, avant ou après une compaction.

---

## Détection automatique du mode

Tu lis `handoff.md` dans le répertoire courant.

- **Fichier absent ou vide** → mode sauvegarde
- **Fichier avec du contenu** → mode reprise

---

## Mode sauvegarde

Applicable à toutes les phases : PRD, archi, specs, code, méthode, roadmap.

Tu rédiges une entrée concise avec ces sections :

**Phase et skill en cours**
[Phase du projet : conception / archi / specs / code / méthode]
[Skill actif : /prd / /archi / /specs / /sessionCode / autre]
[Étape précise : ex. "Étape 3b de /archi — définition des modules techniques en cours"]

**Décisions validées**
[Ce qui est acté et sur lequel on ne revient pas — une ligne par décision]
[Si la décision est dans un artefact → référencer par chemin, pas dupliquer le contenu]

**En cours / en suspens**
[Ce qui était en train d'être travaillé]
[Questions ouvertes non résolues]

**Artefacts modifiés**
[Fichiers touchés avec chemins exacts — pas leur contenu]

**Prochaine action précise**
[Pas "continuer l'archi" — "Reprendre à l'Étape 3b de /archi, définir /notifications et /paiement"]

**Skills à enchaîner**
[Liste ordonnée des skills recommandés pour la suite]

**État du code** _(sessions de code uniquement)_
[Module et fichier en cours d'édition]
[Tests qui passent / échouent]
[Prochaine action dans le code : fonction à écrire, bug à corriger, etc.]

---

## Mode reprise

Tu lis le contenu de `handoff.md` et tu le présentes :

> "Contexte récupéré — voici où on en était :
> [contenu du handoff]
>
> Prochaine action : [prochaine action précise tirée du handoff]"

Puis tu vides `handoff.md` (Write avec contenu vide) — le fichier est consommé.

---

## Règles

- **Références, pas duplications** — si un artefact existe, noter son chemin, pas son contenu
- **Concis** — rapide à relire, pas exhaustif
- **Chemins exacts** — chaque fichier mentionné avec son chemin complet depuis la racine du projet
- **Pas de clôture** — `/handoff` ne commite pas, ne pousse pas. Ancre locale uniquement

---

## Prochaine étape

Continuer la session. `/maj` reste la clôture officielle en fin de session.
