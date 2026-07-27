---
type: skill
source: ../../.claude/commands/brief.md
source_modified: 2026-07-27
wiki_updated: 2026-07-27
tags: [phase-1, produit, brief]
phase: 1
---

## Rôle
**`/brief`** — De l'intention au brief structuré en 9 domaines.

## Inputs
- Intention verbale de Medwin
- `[projet].context.md` si existant (lu en amont)
- `[projet].brief-wip.md` si une session précédente a été interrompue

## Output
`[projet].brief.md` + mise à jour de la section `## Projet` dans `CLAUDE.md`

## En résumé
Dialogue domaine par domaine (pas de formulaire). Une question ouverte par domaine, relance si vague, résumé + confirmation avant de passer au suivant. Brainstorming anti-biais si les fonctions sont évidentes. Comprend la qualification commerciale (modèle de prestation M1/M2/M3, stack, services tiers, coûts récurrents, traitements automatiques).

## Étape 0 — trois vérifications avant de démarrer
- **0.1 Protection** — si `[projet].brief.md` existe sans `[projet].context.md`, proposer le renommage en `.context.md` avant tout. Le skill écrase le brief en fin de session.
- **0.2 Reprise** — si `[projet].brief-wip.md` existe, reprendre au domaine suivant sans rejouer les précédents.
- **0.3 Contexte** — lire `[projet].context.md` pour ne pas reposer ce qui est déjà tranché.

## Sauvegarde d'état
Après **chaque domaine validé**, écrire l'incrément dans `[projet].brief-wip.md` — décisions, raisonnement, questions ouvertes. Un `/brief` de projet réel ne tient pas en une séance. Fichier supprimé une fois le brief final généré.

## Les 9 domaines
1. Le problème (pourquoi l'app existe)
2. Les utilisateurs (qui, contexte, niveau tech)
3. Les fonctions essentielles (3 à 5 + brainstorming)
4. Le hors-scope V1
5. Les contraintes techniques (stack, délai, budget, distribution)
6. Architecture légère et modèle de prestation (M1/M2/M3, **traitements automatiques**, stack, coûts)
7. Les règles métier (logique domaine)
8. Niveau de risque sécurité (Bas / Moyen / Élevé)
9. Données personnelles et RGPD

## Traitements automatiques — domaine 6
Question posée systématiquement avant le choix de stack : *« Y a-t-il des choses qui doivent se déclencher toutes seules — rappels, relances, envois périodiques, expirations, changements de statut à une date ? »*
Souvent **le critère le plus discriminant pour choisir le backend**, plus que n'importe quelle comparaison de fonctionnalités. Noter déclencheur, fréquence, canal de sortie. Remonter au [[skills/stack]].

## Quality Gate
17 cases à cocher avant enregistrement. Brief incomplet → question manquante posée.

**Précédent :** [[skills/contexte]] | **Suivant :** [[skills/prd]]
**Doctrine :** [[doctrines/produit]]
