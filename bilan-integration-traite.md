# Bilan d'intégration — Traité du Vibe Coding Éclairé
> À relire et compléter avec Medwin

---

## Section 1 — Posture

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Culture générale > diplôme + "you don't know what you don't know" | ✅ Intégré | `methode.md` — Posture fondatrice |
| Chef d'orchestre vs touriste | ✅ Intégré | `methode.md` — Posture fondatrice |
| Le généraliste a l'avantage à l'ère IA | 🚫 Non intégrer | Contenu non actionnable — déjà couvert par la posture chef d'orchestre |

---

## Section 2 — Phase AVANT

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Cadre 3 phases AVANT / PENDANT / APRÈS | ✅ Intégré | `methode.md` — intro "Les phases" (2026-05-14) |
| 3 règles d'état d'esprit (contrôle, concentration, notes) | ✅ Intégré | `methode.md` — Posture fondatrice (2026-05-14) |
| Kidlin — 5 étapes | ⚠️ Partiel | `/prd` — 3 étapes sur 5 intégrées (vague→précis, sous-problèmes, critère de succès). "Solutions possibles" laissée aux features V1/V2 |
| User flows sur papier avant l'outil | ✅ Déjà existait | `/prd` — Étape 3b User Journeys |
| Template prompt PRD (4 sections) | ✅ Intégré | `/prd` Étape 5 — alternative rapide (2026-05-14) |
| Règle : relire le PRD intégralement, l'amender soi-même | ✅ Intégré | `/prd` Étape 5c (2026-05-14) |
| Prototype exploratoire jetable (YOLO first) | ✅ Intégré | `methode.md` Phase 5 — option YOLO first (2026-05-14) |

---

## Section 3 — Architecture

| Point | Statut | Où / Pourquoi |
|---|---|---|
| 4 familles d'architecture (statique → complexe) | ✅ Intégré | `architecture.md` — section "Choisir son architecture" (2026-05-14) |
| 3 questions pour choisir son archi (BDD ? Auth ? Tiers ?) | ✅ Intégré | `architecture.md` + `/archi` Étape 1 (2026-05-14) |
| Zones verte / orange / rouge | ✅ Intégré | `architecture.md` — section "Quand faire appel à un pro" |

---

## Section 4 — Pendant

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Context engineering + fenêtre glissante | ✅ Intégré | `methode.md` — Gestion du contexte |
| Une conversation par lot, max 2-3h | ✅ Intégré | `methode.md` — Gestion du contexte |
| Discuter avant de coder (plan mode d'abord) | ✅ Intégré | `methode.md` — Pilotage |
| Surveiller et interrompre immédiatement | ✅ Intégré | `methode.md` — Pilotage |
| Vérifier les modifications non demandées | ✅ Intégré | `methode.md` — Pilotage |
| Anatomie d'un bon rapport de bug | ✅ Intégré | `tests.md` — Remontée de bug |
| Escalade de déblocage (5 étapes) | ✅ Intégré | `methode.md` — Pilotage |
| Méthode par contraintes (dire ce qu'elle ne doit PAS faire) | ✅ Intégré | `methode.md` — dans l'étape 2 de l'escalade |
| Les 9 techniques (6 nouvelles + 3 enrichies) | ✅ Intégré | `methode.md` — Pilotage |

---

## Section 5 — Tests

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Happy path en premier, puis cas limites | ✅ Intégré | `/recette` — "happy path d'abord, cas limites ensuite" (vérifié 2026-05-13) |
| Ouvrir la console du navigateur au premier chargement | 🚫 Non intégrer | Playwright + /recette couvrent déjà les erreurs silencieuses |
| Gherkin (confirmation) | ✅ Déjà existait | `tests.md` |
| Prompt pour générer les Gherkin depuis le PRD | ✅ Intégré | `/recette` génère automatiquement les Gherkin depuis les User Stories (vérifié 2026-05-13) |
| Playwright pour verrouiller ce qui marche | ✅ Déjà existait | `tests.md` |

---

## Section 6 — Sécurité

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Checklist 8 points avant mise en ligne | ✅ Intégré | `securite.md` — Phase 4 |
| Audit sécurité croisé + prompt d'audit | ✅ Intégré | `securite.md` — Phase 4 |
| Erreur service_role Supabase | ✅ Intégré | `securite.md` — Phase 4 |

---

## Section 7 — Stack

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Séparation dev/prod | ✅ Déjà existait | `architecture.md` — niveaux 1/2/3, notion de staging |
| Hébergement selon l'architecture | ✅ Déjà existait | `architecture.md` — Les 6 couches |
| Git : un commit par feature validée | ✅ Intégré | `methode.md` ligne 235 — "Un commit par feature validée" (vérifié 2026-05-13) |
| Alertes de facturation | ✅ Intégré | `/deploy` — checklist finale |

---

## Section 8 — Philosophie

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Work slop (livrer du vérifié, pas du généré) | 🚫 Non intégrer | Couvert par /recette + tests.md — pas d'ajout actionnable |
| Deskilling (danger de déléguer sans comprendre) | 🚫 Non intégrer | Couvert implicitement par les garde-fous de la méthode |
| Vibe = domaine non-expert, pas standard pro | 🚫 Non intégrer | Clarification culturelle, pas une règle opérationnelle |
| FOMO des outils | 🚫 Non intégrer | Stack fixée par défaut — risque non réel dans ce contexte |

---

## Section 9 — Making of

| Point | Statut | Où / Pourquoi |
|---|---|---|
| CLAUDE.md = fichier le plus important | ✅ Déjà existait | Dans notre architecture |
| Documenter le POURQUOI des décisions | 🚫 Non intégrer | `/adr` couvre les décisions structurantes. Étendre au code entrerait en conflit avec la règle "pas de commentaires par défaut" |

---

## Comptage final

- ✅ 30 points intégrés ou déjà couverts
- ⚠️ 1 point partiel (Kidlin)
- 🚫 7 points décidés non intégrables (contenu redondant ou non actionnable)
- ❌ 0 point non intégré — bilan complet

_Mis à jour 2026-05-13 — vérification dans les fichiers réels._
