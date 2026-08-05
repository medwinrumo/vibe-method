---
description: Compresse la conversation courante en document de reprise, ou restaure un contexte sauvegardé
---

# /handoff — Ancre de contexte mid-session

Tu compresses la conversation courante en un document de reprise, ou tu restaures un contexte sauvegardé. Un seul fichier — `handoff-out.md` — dans lequel on accumule des entrées ou qu'on vide après restauration.

Ce skill ne remplace pas `/maj` — il est utilisé en cours de session, avant ou après une compaction.

---

## Détection automatique du mode

**Étape 1 — Lire le contexte visible**

Tu examines la conversation courante :

- **Résumé de compaction visible + peu ou pas d'historique actif** → mode reprise
- **Conversation active avec de l'historique** → mode sauvegarde (append)

**Étape 2 — Lire `handoff-out.md`**

- **Fichier absent ou vide** → mode sauvegarde, quoi qu'il arrive
- **Fichier avec du contenu + résumé de compaction visible** → mode reprise automatique
- **Fichier avec du contenu + conversation active** → demander :
  > "Je vois un handoff existant (dernier : [date de la dernière entrée]). Ajout ou reprise ?"

---

## Mode sauvegarde — Quand lancer /handoff

- La session est longue et le contexte commence à peser
- Tu sens qu'une compaction est imminente
- Tu veux préserver une décision, une exploration, un état en cours

Applicable à toutes les phases : PRD, archi, specs, code, méthode, roadmap.
Plusieurs appels successifs accumulent des entrées dans le même fichier.

---

## Mode sauvegarde — Rédaction

Tu **ajoutes** une entrée à `handoff-out.md` (append — ne pas écraser les entrées précédentes) :

---
**Handoff — [date] [heure]**

**Phase et skill en cours**
[Phase : conception / archi / specs / code / méthode]
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

Tu lis l'intégralité de `handoff-out.md` et tu le présentes :

> "Contexte récupéré — [N] entrée(s) sauvegardée(s) :
>
> [contenu complet du fichier]
>
> Prochaine action : [prochaine action précise tirée de la dernière entrée]"

Puis tu vides `handoff-out.md` — le fichier est consommé.

---

## Règles

- **Append, jamais overwrite** en mode sauvegarde — les entrées précédentes sont précieuses
- **Références, pas duplications** — si un artefact existe, noter son chemin, pas son contenu
- **Concis** — rapide à relire, pas exhaustif
- **Chemins exacts** — chaque fichier mentionné avec son chemin complet depuis la racine du projet
- **Pas de clôture** — `/handoff` ne commite pas, ne pousse pas. Ancre locale uniquement

---

## Prochaine étape

Continuer la session. `/maj` reste la clôture officielle en fin de session.
