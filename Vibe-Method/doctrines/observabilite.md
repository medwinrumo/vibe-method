---
type: doctrine
source: ../../observabilite.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [observabilite, logs, metriques, alerting, prod-critique]
---

# Doctrine — Observabilité

## En une ligne
Du code qu'on ne peut pas observer est du code qu'on ne peut pas exploiter — l'instrumentation se code en même temps que la feature, pas après.

---

## Portée

Obligatoire pour toute feature qui tourne en prod avec de vrais utilisateurs. Pas de cérémonie sur du jetable ([[skills/prototype]]) — même filtre de portée que le TDD obligatoire de [[doctrines/methode]] (modules métier/sécurité).

---

## Étape 1 — Définir "ça marche" avant d'instrumenter

2 à 4 questions qu'on se poserait en découvrant un problème sur la feature. Chaque signal doit répondre à une de ces questions — sinon c'est du bruit.

## Étape 2 — Les 4 signaux

- **Logs structurés** — événement métier identifiable, jamais de donnée personnelle en clair (RGPD, voir [[doctrines/securite]])
- **Métriques** — compteurs/durées qui répondent aux questions de l'étape 1
- **Alerting** — un seuil = une action attendue derrière, éviter la fatigue d'alerte
- **Dashboards** — optionnel niveaux 1/2, nécessaire niveau 3 ([[skills/deploy]])

## Étape 3 — Vérifier que la télémétrie marche

Déclencher volontairement le chemin d'erreur en dev/staging avant de considérer la feature terminée.

---

## Où ça s'accroche dans le workflow

| Phase | Ce qui se passe |
|---|---|
| [[skills/stack]] (Phase 4) | Décision d'outillage — une fois par projet |
| [[skills/specs]] (Étape 4c-ter) | Filtre prod-critique → section "Signaux à instrumenter" — **artefact vérifiable** |
| Code (Phase 6) | Signal codé en même temps que la feature |
| [[skills/deploy]] (Pre-Launch Gate) | `scripts/lint-observabilite.py` — vérification mécanique, bloquant si spec incomplète |

**Règle de chaînage** : `/specs` décide seul si la doctrine s'applique — Medwin n'a jamais besoin de se souvenir de l'invoquer.

---

## Règles non-négociables

- Pas de télémétrie sans question métier derrière
- Jamais de donnée personnelle en clair dans un log
- Pas d'alerte sans destinataire ni geste attendu
- Doctrine neuve (2026-07-28) — friction à loguer dans `task-observer`, revue en `/maj`

## Liens
[[doctrines/methode]] | [[doctrines/stack]] | [[skills/specs]] | [[skills/deploy]] | [[doctrines/securite]]
