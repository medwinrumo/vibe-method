---
type: infrastructure
source: ../CLAUDE.md
source_modified: 2026-07-28
wiki_updated: 2026-08-05
tags: [overview, méthode]
---

# Vue d'ensemble — vibe-method

La vibe-method est un workflow de développement structuré pour le vibe coding éclairé. Elle place Medwin dans la posture du **chef d'orchestre** : comprendre ce qu'on construit, prendre les décisions, sans micro-gérer chaque ligne de code.

---

## La posture

Deux erreurs à éviter :
- **Le touriste** : accepte tout ce que l'IA produit sans comprendre. Le projet dérive.
- **L'ingénieur fantôme** : veut tout contrôler ligne par ligne. Perd l'avantage de l'IA.

La vibe-method vise le milieu : des garde-fous à chaque étape, pas du micro-management.

---

## Les 7 phases

| Phase | Nom | Ce qu'on fait |
|---|---|---|
| 1 | Produit | Brief → PRD → User stories |
| 2 | Design | Interface visuelle (Claude Design) |
| 3 | Architecture | Organisation du code, modules, stack |
| 4 | Stack | Spike technique, investigation free tiers |
| 5 | Planification | Roadmap, découpage en features |
| 6 | Code | Feature par feature, avec TDD si modules métier |
| 7 | Vérification | Tests, code review, recette, mise en prod |

**3 temps :** AVANT (phases 1–4) → PENDANT (phases 5–6) → APRÈS (phase 7)

---

## La chaîne de skills

→ [[flux/chaine-complete]] pour la vision détaillée avec tous les liens.

```
/contexte → /brief → /devis → /cgv → /charte → /prd → /prd-update → /prd-validate
→ /gherkin → /design Mode A ↔ /archi → /regles → /stack → /design Mode B
→ /roadmap → /specs → /readyTo-code → /setup → /prp → /avancement → /sessionCode
→ [code] → /code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil
→ /tests → /securite → /doc-tech → /recette ↔ /debug → /phase-retrospective
```

---

## Les 5 garde-fous

1. **[[skills/archi]]** — schéma validé avant code (l'IA exécute, pas décide)
2. **[[skills/securite]]** — chaque décision d'accès examinée explicitement
3. **[[skills/recette]]** — validation fonctionnelle en langage métier (Gherkin)
4. **[[skills/code-review]]** + **[[skills/code-review-hostil]]** — revue structurelle et cynique
5. **[[skills/prp]]** — contexte minimal et précis à chaque session de code

---

## Les doctrines

| Doctrine | Principe fondateur |
|---|---|
| [[doctrines/methode]] | Chef d'orchestre — garde-fous à chaque étape |
| [[doctrines/architecture]] | Contexte minimal = IA performante |
| [[doctrines/securite]] | Zero Trust — code IA = 2× plus de vulnérabilités |
| [[doctrines/tests]] | Vérifier fonctionnement ET correction |
| [[doctrines/design]] | Interface d'abord, logique ensuite |
| [[doctrines/stack]] | Anticiper, pas réagir |
| [[doctrines/refacto]] | Discipline séparée — session dédiée |
| [[doctrines/produit]] | Brief → PRD → Story A4 → Gherkin |

---

## Greenfield vs Brownfield

**Greenfield** (projet de zéro) : workflow standard ci-dessus.

**Brownfield** (reprise/migration) : 3 étapes supplémentaires AVANT tout changement :
1. Inventaire de la codebase
2. Couverture de régression (tests d'abord)
3. Architecture adaptateur (brancher le nouveau sur l'ancien)

---

## Règle absolue

Rien n'entre dans le système (fichiers, règles, code) sans discussion et validation explicite de Medwin.
