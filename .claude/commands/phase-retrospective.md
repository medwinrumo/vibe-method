---
description: Rétrospective de fin de phase ou de fin d'ensemble — calibration estimé vs réel, dette, actions à prendre
---

# /phase-retrospective — Rétrospective

Deux modes selon le moment :

- **Mode Léger** — fin de phase : journal de 5 lignes, écrit pendant que c'est frais
- **Mode Complet** — fin d'ensemble de fonctions : rétrospective complète, nourrie par les journaux de phase

L'objectif du Mode Léger est simple : ne pas faire reposer la rétrospective finale sur ta mémoire.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Quand lancer /phase-retrospective

- **Mode Léger** : quand toutes les features d'une phase sont `done` dans `[projet].avancement.yaml`, avant de démarrer la phase suivante
- **Mode Complet** : quand toutes les phases d'un ensemble de fonctions sont terminées, avant de démarrer le prochain ensemble

---

## Étape 0 — Identification du mode

Tu demandes :
> "On clôture une phase ou un ensemble de fonctions complet ?"

- Phase → **Mode Léger**
- Ensemble de fonctions → **Mode Complet**

Tu lis silencieusement :
- `[projet].avancement.yaml` — statuts des features
- `[projet].Rmap.md` — contexte de la phase ou de l'ensemble
- `[projet]-retrospective.md` si existant — journaux et retros précédents

---

## MODE LÉGER — Fin de phase

### L1 — 4 questions rapides

Tu poses les 4 questions l'une après l'autre. Réponses courtes attendues — une ou deux phrases maximum.

> "Phase [N] terminée. 4 questions rapides pendant que c'est frais :"

**Q1 — Ce qui a bien marché**
> "Une chose qui a bien marché dans cette phase ?"

**Q2 — Ce qui a bloqué**
> "Une chose qui a bloqué ou ralenti ?"

**Q3 — Ce qui a surpris**
> "Une surprise — bonne ou mauvaise ?"

**Q4 — Dette**
> "Un raccourci pris ou quelque chose laissé en suspens ?"

Si la réponse est "rien" ou "tout s'est bien passé" → noter explicitement : "RAS" — ne pas forcer.

---

### L2 — Écriture du journal

Tu appends dans `[projet]-retrospective.md` :

```markdown
---

### Journal — Phase [N] — [date]
_[nom de la phase]_

+ [ce qui a bien marché]
~ [ce qui a bloqué]
! [surprise]
⚠ [dette / raccourci]
```

Quatre lignes maximum. Pas de titres, pas de tableaux — juste les signaux bruts.

---

### L3 — Dette rapide

Si une dette a été mentionnée en Q4 → proposer immédiatement :
> "Je note cette dette dans `[projet].refacto-dette.md` : [entrée]. Je le fais ?"

---

### L4 — Avancement

Pour les features encore ouvertes → proposer de les passer à `done` :
> "Ces features sont encore ouvertes : [liste]. Je les passe à done ?"

---

> "Journal Phase [N] écrit ✅. Ces notes alimenteront la rétrospective de l'ensemble de fonctions."

---

## MODE COMPLET — Fin d'ensemble de fonctions

### C0 — Lecture des journaux de phase

Tu lis dans `[projet]-retrospective.md` tous les journaux des phases qui composent cet ensemble de fonctions.

Tu produis une synthèse des signaux récurrents :
> "Sur les [N] phases de cet ensemble, les signaux récurrents sont :
> - [signal qui revient plusieurs fois]
> - [signal qui revient plusieurs fois]
> On part de là pour la rétrospective."

---

### C0b — Analyse du log pour calibration des estimations

Tu lis `[projet].log.md` et tu identifies, session par session, la ou les phases travaillées à partir du sujet décrit dans chaque entrée.

Phases à reconnaître : Brief + cadrage, PRD, Architecture, Specs, Design, Développement [nom du bloc], Tests + recette, Déploiement + documentation, Formation.

Si une session couvre deux phases → tu comptabilises les deux séparément (c'est la réalité du travail — la fin d'une phase et le début d'une autre dans la même session sont tous les deux réels).

Tu cumules la durée par phase et tu construis le tableau de calibration.

Si `[projet].proposition.md` existe → tu lis la section "Détail par phase" pour récupérer les estimations. Sinon → colonne Estimé à "—".

Tu présentes le tableau avant de continuer :
> "Voici le comparatif estimé / réel d'après les logs. Des durées te semblent incorrectes ?"

Medwin peut corriger avant que le tableau soit écrit dans le compte-rendu.

---

### C1 — 5 questions de rétrospective

Tu poses les questions une par une, en t'appuyant sur les signaux des journaux. Tu attends la réponse avant de passer à la suivante.

**Question 1 — Ce qui a bien marché**
> "Sur l'ensemble de cet ensemble de fonctions — qu'est-ce qui a systématiquement bien fonctionné ?"

**Question 2 — Ce qui a bloqué**
> "Qu'est-ce qui a bloqué ou ralenti plusieurs fois ? (bugs récurrents, specs floues, dépendances imprévues)"

**Question 3 — Les surprises**
> "Y a-t-il eu des surprises majeures — une décision technique à revoir, un module plus complexe que prévu ?"

**Question 4 — La dette accumulée**
> "En relisant les journaux de phase, quelle dette reste ouverte ? Qu'est-ce qu'on a consciemment reporté ?"

**Question 5 — Pour le prochain ensemble**
> "Si tu pouvais changer une seule chose pour le prochain ensemble de fonctions, ce serait quoi ?"

---

### C2 — Suivi des action items précédents

Si une rétrospective complète précédente existe :
> "La dernière rétrospective complète avait ces action items : [liste]. Lesquels ont été appliqués ?"

Pour chaque item → ✅ Fait / ❌ Non fait / 🔄 En cours.

Les items non faits sont reportés avec une note.

---

### C3 — Action items

Depuis les réponses aux 5 questions, tu proposes des action items concrets :

```
[ ] [action précise] — à faire avant : [prochain ensemble / dès maintenant]
```

Maximum 5. Tu proposes, Medwin valide, reformule ou supprime.

---

### C4 — Preview du prochain ensemble

Tu lis `[projet].Rmap.md` pour identifier la suite.

> "Prochain ensemble de fonctions : [nom]. Phases prévues : [liste].
> Prérequis à vérifier avant de démarrer : [artefacts manquants, décisions ouvertes]"

---

### C5 — Génération du compte-rendu complet

Tu appends dans `[projet]-retrospective.md` :

```markdown
---

## Rétrospective — Ensemble "[nom]" — [date]
_Phases couvertes : Phase [N] → Phase [M]_

### Signaux des journaux de phase
- [signal récurrent 1]
- [signal récurrent 2]

### Ce qui a bien marché
- [point]

### Ce qui a bloqué
- [point]

### Surprises
- [point]

### Dette accumulée
- [entrée] → reportée dans `[projet].refacto-dette.md`

### Calibration — Estimé vs Réel

| Phase | Estimé | Réel | Écart |
|---|---|---|---|
| [phase] | [X] j | [X] j | [+/- X] j |
| **Total** | **[X] j** | **[X] j** | **[+/- X] j** |

### Suivi retro précédente
| Action item | Statut |
|---|---|
| [item] | ✅ / ❌ / 🔄 |

### Action items pour le prochain ensemble
- [ ] [action] — avant [date ou ensemble]

### Preview — Prochain ensemble
- Nom : [nom]
- Phases : [liste]
- Prérequis : [liste]
```

---

### C6 — Dette → fichier de dette

Pour chaque élément de dette identifié (journaux + Q4) :
> "Je note cette dette dans `[projet].refacto-dette.md` : [entrée]. Je le fais ?"

```markdown
- [ ] [description courte] — détecté sur ensemble "[nom]" — module : [module]
```

---

### C7 — Enrichissement du Wiki

Extraire les leçons réutilisables cross-projets vers le Wiki.

Pour chaque signal des journaux et chaque action item :
1. Demander : "Cette leçon s'applique-t-elle à d'autres projets ou est-elle spécifique à [projet] ?"
2. Pour chaque leçon réutilisable → identifier le fichier Wiki pertinent :
   - Estimation, planning → `~/dev/wiki/estimation.md`
   - Bug pattern → `~/dev/wiki/bugs-patterns.md`
   - Pattern d'archi → fichier outil ou pattern concerné
   - Autre → créer le fichier le plus naturel
3. Lire le fichier existant s'il existe → fusionner, ne pas dupliquer
4. Logger dans `~/dev/wiki/log.md` :
   `## [date] update | [fichier(s)] | /phase-retrospective — [projet]`

---

> "Rétrospective ensemble '[nom]' terminée ✅
> [N] action items.
> Lance `/readyTo-code` avant de démarrer le prochain ensemble."

---

## Ton

Direct et constructif. Les journaux de phase fournissent les faits — la rétrospective complète les analyse. Si un signal revient dans tous les journaux, c'est un problème systémique, pas un accident.

---

## Prochaine étape

**Mode Léger** (fin de phase) : `/specs` — le journal est écrit, reprendre les specs de la phase suivante.
**Mode Complet** (fin d'ensemble) : `/doc-tech` Mode A — rédiger le document développeur de l'ensemble avant de clore.
