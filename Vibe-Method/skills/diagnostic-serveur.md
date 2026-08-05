---
type: skill
source: ../../.claude/commands/diagnostic-serveur.md
source_modified: 2026-08-03
wiki_updated: 2026-08-05
tags: [debug, infrastructure, serveur, docker, diagnostic, hermes]
phase: transversal
---

## Rôle
**`/diagnostic-serveur`** — Diagnostic d'infrastructure : serveur, conteneur ou service qui se comporte mal (lenteur, saturation, coupures, process qui meurt, intermittence). **T3 — Opus.**

Complète [[skills/diagnose]], qui vise le code applicatif. Ici la cause est dans l'**environnement d'exécution** : ressources, réseau, cycle de vie des process, persistance.

## Inputs
- Aucun artefact requis — accès au serveur ou au conteneur concerné

## En résumé
Quatre phases, plus une checklist de sortie. Chaque règle du skill vient d'un diagnostic réel parti dans la mauvaise direction (projet Hermes, juillet-août 2026) — ce n'est pas une méthode théorique.

**Phase 0 — Avant de toucher au clavier.** Le programme mesure-t-il déjà ce que je m'apprête à supposer ? Un instantané ne dit rien d'une tendance. Le vocabulaire du projet passe avant l'interprétation générique.

**Phase 1 — Mesurer sans se mentir.** Un résultat négatif obtenu par pipe doit être rejoué sans pipe (un `| grep` renvoie 0 aussi bien quand il n'y a rien que quand la lecture est refusée). Vérifier depuis le bon point d'observation. Savoir où vit réellement le fichier qu'on regarde.

**Phase 2 — Formuler l'hypothèse.** Nommer la commande qui la réfuterait. Pas d'intitulé de certitude avant vérification. Vérifier qu'un correctif *peut* seulement s'appliquer.

**Phase 3 — Corriger et prouver.** Le test doit provoquer l'événement, pas le simuler. Prouver que le correctif est invoqué, pas seulement qu'il fonctionne. Inventorier ce que l'événement détruit.

**Phase 4 — Rendre le correctif durable.** Emplacement persistant pour toute dépendance installée à chaud ; mécanisme de réapplication idempotent qui n'empêche jamais le démarrage ; commande de contrôle documentée ; journal dont le message de succès est conditionné au succès — *un journal qui ne peut pas écrire « échec » ne prouve rien quand il écrit « succès »*.

## Ce qui le distingue
La plupart des règles portent sur la **façon de conclure**, pas sur les commandes à lancer. Le skill part du constat qu'un diagnostic d'infrastructure échoue rarement par manque d'outil, et presque toujours par une conclusion tirée trop tôt d'une mesure ambiguë.

## Liens
[[skills/diagnose]] — même geste sur le code applicatif | [[skills/debug]] | [[doctrines/observabilite]]
