# Bilan d'intégration — Traité du Vibe Coding Éclairé
> À relire et compléter avec Medwin

---

## Section 1 — Posture

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Culture générale > diplôme + "you don't know what you don't know" | ✅ Intégré | `methode.md` — Posture fondatrice |
| Chef d'orchestre vs touriste | ✅ Intégré | `methode.md` — Posture fondatrice |
| Le généraliste a l'avantage à l'ère IA | ❌ Non intégré | On en a parlé, pas écrit |

---

## Section 2 — Phase AVANT

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Cadre 3 phases AVANT / PENDANT / APRÈS | ❌ Non intégré | `methode.md` a des phases 1-7 mais pas cette lecture macro |
| 3 règles d'état d'esprit (contrôle, concentration, notes) | ❌ Non intégré | Jamais discuté |
| Kidlin — 5 étapes | ⚠️ Partiel | `/prd` — 3 étapes sur 5 intégrées (vague→précis, sous-problèmes, critère de succès). "Solutions possibles" laissée aux features V1/V2 |
| User flows sur papier avant l'outil | ✅ Déjà existait | `/prd` — Étape 3b User Journeys |
| Template prompt PRD (4 sections) | ❌ Non intégré | Notre `/prd` est un dialogue, pas un template prompt. Plus avancé sur le fond, mais le template du livre n'a pas été ajouté |
| Règle : relire le PRD intégralement, l'amender soi-même | ❌ Non intégré | Jamais discuté |
| Prototype exploratoire jetable (YOLO first) | ❌ Non intégré | Couvert indirectement par "la mue du serpent" mais pas explicitement |

---

## Section 3 — Architecture

| Point | Statut | Où / Pourquoi |
|---|---|---|
| 4 familles d'architecture (statique → complexe) | ❌ Non intégré | Notre `architecture.md` classe par distribution (web/PWA/native) et back-end. Deux lectures différentes, pas incompatibles |
| 3 questions pour choisir son archi (BDD ? Auth ? Tiers ?) | ❌ Non intégré | Jamais discuté |
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
| Happy path en premier, puis cas limites | ❌ Non intégré | `tests.md` a une section edge cases mais pas la règle "happy path d'abord" |
| Ouvrir la console du navigateur au premier chargement | ❌ Non intégré | Jamais discuté |
| Gherkin (confirmation) | ✅ Déjà existait | `tests.md` |
| Prompt pour générer les Gherkin depuis le PRD | ❌ Non intégré | Jamais discuté |
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
| Git : un commit par feature validée | ❌ Non intégré | `methode.md` a les règles Git (branches) mais pas cette règle précise |
| Alertes de facturation | ✅ Intégré | `/deploy` — checklist finale |

---

## Section 8 — Philosophie

| Point | Statut | Où / Pourquoi |
|---|---|---|
| Work slop (livrer du vérifié, pas du généré) | ❌ Non intégré | Jamais discuté |
| Deskilling (danger de déléguer sans comprendre) | ❌ Non intégré | Jamais discuté |
| Vibe = domaine non-expert, pas standard pro | ❌ Non intégré | Jamais discuté |
| FOMO des outils | ❌ Non intégré | Jamais discuté |

---

## Section 9 — Making of

| Point | Statut | Où / Pourquoi |
|---|---|---|
| CLAUDE.md = fichier le plus important | ✅ Déjà existait | Dans notre architecture |
| Documenter le POURQUOI des décisions | ❌ Non intégré | Mentionné dans l'extraction, jamais discuté |

---

## Comptage final

- ✅ 20 points intégrés ou déjà couverts
- ⚠️ 1 point partiel (Kidlin)
- ❌ 14 points non intégrés
