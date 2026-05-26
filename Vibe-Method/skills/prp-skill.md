---
type: concept
source: ../CLAUDE.md
source_modified: 2026-05-18
wiki_updated: 2026-05-26
tags: [concept, prp, contexte-session]
---

# Concept — PRP (Project Ready Prompt)

Le PRP est le document de démarrage de session de code. Il condense toute l'information nécessaire en ≤ 1 000 tokens.

## Rôle dans la chaîne
- **Produit par :** [[skills/prp]]
- **Consommé par :** [[skills/sessionCode]] + chargé à chaque compaction de contexte

## Ce qu'il contient
- App (2 lignes)
- Features V1 (1 ligne par feature)
- Modules (nom + responsabilité)
- Règles silo
- Conventions
- Sécurité (section complète)
- Stack — contraintes critiques
- Tests — patterns
- Commandes de dev
- Glossaire (si présent)
- Feature en cours + critères d'acceptance

## Ce qu'il ne contient PAS
Pas d'explications. Pas de justifications. Pas d'historique. Uniquement des décisions et des contraintes.

## Test de suffisance
Le PRP doit répondre sans ambiguïté :
1. Qu'est-ce que je code maintenant ?
2. Où je le code ?
3. Quelles règles je ne dois pas violer ?
4. Comment je vérifie que ça marche ?
