---
description: Contrôle qualité du wiki ~/dev/wiki — intégrité du graphe, doublons, terminologie, structure, contradictions
---

# /lint — Contrôle qualité du Wiki

Vérifie la cohérence et la fraîcheur de `~/dev/wiki/`. Distinct du lint wiki vibe-method (étape 5 de `/maj`).

Depuis le 08/07/2026 (T16), `/lint` s'appuie sur le même script que Hermes (`~/dev/wiki/scripts/lint-wiki.py`) pour les axes mécaniques — même détection des deux côtés du wiki partagé, plus de divergence de critères entre Claude Code et Hermes. Historique de la décision et du chantier : `hermes.todo.md` (T13, T14, T16).

Deux modes selon le coût en tokens acceptable.

---

## Modes

**`/lint quick`** — Coût minimal. Lance uniquement le script (5 axes mécaniques), aucune lecture LLM.

**`/lint`** (mode complet) — Lance le script PUIS lit tous les fichiers pour détecter contradictions sémantiques et pages manquantes (jugement sémantique, non mécanisable).

Déclarer le mode utilisé en tête de rapport.

---

## Étape 0 — Vérification du vérificateur

**Quand :** après toute modification de `lint-wiki.py`, et avant de traiter un rapport en masse (plus de 5 signalements sur un même axe). Pas à chaque `/lint quick` de routine.

Un axe de lint a deux façons d'afficher ✅ : « rien à signaler » et « je n'ai rien lu ». Rien dans la sortie ne les distingue. Le seul moyen de trancher est de le faire échouer exprès.

```bash
cp -R ~/dev/wiki /tmp/wiki-lint-test && cd /tmp/wiki-lint-test
```

Dans cette copie jetable, provoquer une violation par axe, puis relancer
`python3 scripts/lint-wiki.py --wiki-path .` et confirmer qu'elle est signalée :

| Axe | Violation à fabriquer | Doit ressortir en |
|---|---|---|
| 1 — Graphe | Ajouter `[[page-qui-nexiste-pas-xyz]]` dans deux fiches | Lien cassé / nœud fantôme |
| 2 — Doublons/stubs | Créer une fiche de 20 mots | Stub |
| 3 — Terminologie | Mettre `tags: [tag-bidon-xyz]` et `sujet: notion-rgpd` (minuscules) sur une fiche du cluster `Notion-Rgpd` | Tag non canonique **et** casse de `sujet` divergente |
| 4 — Structure | Retirer tout le frontmatter d'une fiche | Frontmatter incomplet |
| 5 — Conflits | Passer `updated` d'une fiche d'un cluster à une date > 90 jours des autres | Écart intra-cluster |

Un axe resté vert sur une violation fabriquée est cassé — le réparer avant d'exploiter le moindre rapport. Supprimer `/tmp/wiki-lint-test` ensuite.

**Signal d'alerte indépendant de ce test :** tout chiffre extrême dans un rapport — 0 % ou ~100 % des fiches sur un axe — se traite comme un **défaut d'outil présumé** avant d'être traité comme un défaut de données. Trois axes se sont révélés faux le 03/08/2026, dont un annonçant « frontmatter incomplet » sur 123 fiches sur 125 : le parser YAML n'acceptait pas les listes non indentées, format pourtant utilisé par tout le wiki. Son symétrique silencieux — le contrôle des tags canoniques lisant une liste vide — affichait ✅ depuis sa création.

---

## Mode quick

### Étape 1 — Synchro puis script

```bash
cd ~/dev/wiki && git pull
python3 scripts/lint-wiki.py --wiki-path .
```

### Étape 2 — Rapport

Le script produit directement un rapport markdown structuré (5 axes, sévérité ❌/⚠️/✅). L'afficher tel quel — pas de reformulation.

---

## Mode complet

À invoquer périodiquement — pas en routine.

### Étape 1 — Synchro puis script (mêmes axes mécaniques que mode quick)

```bash
cd ~/dev/wiki && git pull
python3 scripts/lint-wiki.py --wiki-path .
```

### Étape 2 — Lire tous les fichiers de savoir dans leur intégralité

Nécessaire pour les deux étapes suivantes, non mécanisables par le script.

### Étape 3 — Contradictions sémantiques

Pour chaque sujet couvert dans plusieurs fichiers, comparer les informations.
Si deux fichiers affirment des choses incompatibles sur le même sujet → signaler.

> ❌ **Contradiction** : `[Fichier A]` dit X / `[Fichier B]` dit Y sur [sujet]. Laquelle est correcte ?

Distinct de l'axe 5 du script (« conflits de contenu », qui ne détecte que des écarts de date de mise à jour >90 jours entre pages d'un même cluster — un proxy, pas une détection de contradiction de fond). Cette étape couvre les vraies contradictions, avec ou sans écart de date associé — c'est la seule à pouvoir les attraper.

### Étape 4 — Pages manquantes

Identifier les concepts qui reviennent dans 3 pages ou plus sans avoir leur propre fichier.

> ⚠️ **Page manquante** : « [concept] » apparaît dans [N] pages ([liste]) sans sa propre page. Créer `[concept].md` ?

### Étape 5 — Rapport complet

Fusionner le rapport du script (étape 1) avec les résultats des étapes 3-4, sous la même notation de sévérité ❌/⚠️/✅.

---

## Étape finale — Correction (les deux modes)

Pour chaque problème signalé, proposer une action et attendre la validation de Medwin :

| Problème | Sévérité | Action proposée |
|---|---|---|
| Lien cassé | ❌ | Corriger le wikilien ou créer la page manquante |
| Entrée d'index fantôme | ❌ | Retirer l'entrée de `index.md` |
| Frontmatter incomplet | ❌ | Ajouter les champs manquants |
| Contradiction | ❌ | Choisir la version correcte — mettre à jour le fichier concerné |
| Nœud fantôme (lien vers page inexistante, ≥2 sources) | ⚠️ | Dette de connaissance assumée — créer la page si pertinent |
| Page orpheline | ⚠️ | Ajouter des backlinks ou intégrer à une autre page |
| Quasi-doublon | ⚠️ | Fusionner si même sujet et même type (cf. règle 3 de `~/dev/wiki/CLAUDE.md`) |
| Stub (< 200 mots) | ⚠️ | Enrichir ou fusionner dans une page parente |
| Tag non canonique | ⚠️ | Utiliser un tag de la table canonique dans `index.md` |
| Page sans sections / sans wikiliens sortants | ⚠️ | Enrichir la structure |
| Obsolète | ⚠️ | Mettre à jour ou supprimer l'information |
| Page manquante | jugement | Créer la page (si Medwin valide) |

Chaque correction → entrée dans `~/dev/wiki/log.md`.

---

## Règles

- Ne jamais supprimer sans validation explicite de Medwin
- Mode complet : lire tous les fichiers avant de signaler — pas de rapport partiel
- Logger toutes les corrections dans `log.md`
- Si aucun problème trouvé → le dire clairement
- Un ✅ n'est une information que si l'axe a déjà été vu échouer (étape 0)
- Toute correction de `lint-wiki.py` rouvre l'étape 0 sur l'axe corrigé

---

## Prochaine étape

Corrections appliquées → Wiki plus cohérent.
