# observabilite.md

Doctrine d'instrumentation — quoi logger, mesurer, alerter, et quand. Comparaison externe (pack `addyosmani/agent-skills`) vs vibe-method, discutée et validée le 2026-07-28. À enrichir au fil des projets.

---

## Principe fondamental

**Du code qu'on ne peut pas observer est du code qu'on ne peut pas exploiter.**

L'instrumentation se code **en même temps** que la feature, pas après — exactement comme les tests. Une feature qui part en prod sans télémétrie transforme le premier bug remonté par un utilisateur en enquête archéologique : aucune trace de ce qui s'est passé, pas de moyen de reproduire, pas de moyen de savoir si le problème touche 1 utilisateur ou 500.

**Ce n'est pas pour tout.** Cérémonie inutile sur du code jetable (`/prototype`) ou une feature sans utilisateur réel en prod. Même filtre de portée que le TDD obligatoire dans `methode.md` (modules métier/sécurité) : **instrumentation obligatoire pour toute feature qui tourne en prod avec de vrais utilisateurs, pas avant.**

---

## Étape 1 — Définir "ça marche" avant d'instrumenter

De la télémétrie sans question derrière est du bruit. Avant d'ajouter le moindre log ou la moindre métrique, écrire 2 à 4 questions qu'on se poserait en découvrant un problème sur cette feature :

```
FEATURE : relance automatique d'échéance (RAMrezo)
QUESTIONS QU'ON SE POSERA EN CAS DE PROBLÈME :
1. Quelle proportion des relances part avec succès vs échoue ?
2. Quand une relance échoue, pourquoi ? (email invalide, service down, règle métier)
3. Le déclenchement à échéance a-t-il du retard ?
→ Chaque signal ci-dessous doit répondre à une de ces questions.
```

Si on n'arrive pas à nommer ces questions, on n'est pas prêt à instrumenter — on va tout logger et ne rien apprendre.

---

## Étape 2 — Les 4 signaux

### Logs structurés
- Format structuré (JSON ou équivalent), jamais du texte libre concaténé — doit rester grep/filtrable.
- Un log = un événement métier identifiable (`payment_retry_failed`, `relance_echeance_envoyee`), pas une trace de debug oubliée.
- Jamais de donnée personnelle en clair dans un log (RGPD — voir `securite.md`) : pas d'email, pas de nom, un identifiant opaque suffit.

### Métriques
- Compteurs et durées sur les opérations qui répondent aux questions de l'étape 1.
- Une métrique inutile (qui ne répond à aucune question posée) ne se crée pas "au cas où".

### Alerting
- Un seuil d'alerte = une action attendue derrière. Pas d'alerte sans destinataire ni sans geste à faire.
- Éviter la fatigue d'alerte : mieux vaut 3 alertes fiables que 15 qu'on finit par ignorer.

### Dashboards
- Optionnel en V1 (niveau 1/2 de déploiement) — les logs structurés + `/deploy` niveau 1 (Vercel Logs) suffisent souvent.
- Devient nécessaire au niveau 3 (`deploy.md` — monitoring niveau 3).

---

## Étape 3 — Vérifier que la télémétrie marche

Avant de considérer la feature terminée : déclencher volontairement le chemin d'erreur en dev/staging et vérifier que le signal attendu apparaît bien. Une instrumentation jamais testée a de bonnes chances d'être silencieusement cassée le jour où elle sert.

---

## Outillage — décision une fois par projet

Décidé lors du `/stack` (Phase 4), documenté dans `[projet].stack.md` section observabilité :
- Logs : natif Vercel (niveau 1) → Sentry ou équivalent (niveau 2/3, voir `deploy.md`)
- Métriques/alerting : UptimeRobot (niveau 2), dashboard dédié (niveau 3)
- Pas d'outil supplémentaire à payer avant d'en avoir besoin — cohérent avec le principe "pas de stack overkill" de `stack.md`.

---

## Où ça s'accroche dans le workflow

| Phase | Ce qui se passe |
|---|---|
| `/stack` (Phase 4) | Décision d'outillage — une fois par projet |
| `/specs` (Phase 5, Étape 4c-ter) | Pour chaque feature prod-critique : les 2-4 questions de l'étape 1 + section "Signaux à instrumenter" dans le fichier spec — **c'est l'artefact vérifiable** |
| Code (Phase 6) | Le signal est codé en même temps que la feature, jamais ajouté après coup |
| `/deploy` (Pre-Launch Gate) | Vérification mécanique (`scripts/lint-observabilite.py`) que chaque spec prod-critique a bien sa section renseignée avant mise en prod |

**Règle de chaînage :** c'est `/specs` qui décide si cette doctrine s'applique à la feature en cours — Medwin n'a jamais besoin de se souvenir d'invoquer `observabilite.md` lui-même.

---

## Surveillance

Doctrine neuve (2026-07-28), pas encore éprouvée à l'usage. Toute friction rencontrée (section ignorée, lint qui ne se déclenche pas, filtre de portée mal calibré) → observation dans `task-observer`, revue en `/maj`.
