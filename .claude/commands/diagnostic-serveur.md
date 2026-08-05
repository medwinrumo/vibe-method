---
description: Diagnostic d'infrastructure — serveur, conteneur ou service qui se comporte mal : lenteur, saturation, process qui meurt, intermittence
---

# /diagnostic-serveur — Diagnostic d'infrastructure

Pour un serveur, un conteneur ou un service qui se comporte mal : lenteur, saturation, coupures, process qui meurt, comportement intermittent.

Complète `/diagnose`, qui vise le code applicatif. Ici la cause est dans l'environnement d'exécution — ressources, réseau, cycle de vie des process, persistance.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

Ce skill encode des erreurs réellement commises (projet Hermes, juillet-août 2026). Chaque règle vient d'un diagnostic qui est parti dans la mauvaise direction.

---

## Phase 0 — Trois réflexes avant de toucher au clavier

### 0.1 — Le programme mesure-t-il déjà ce que je m'apprête à supposer ?

Un logiciel mature instrumente ses propres pathologies connues. Avant de formuler une hypothèse sur un comportement interne — blocage, fuite, latence, saturation — **chercher dans le code le message ou le compteur correspondant** :

```bash
grep -rn "stall\|timeout\|pressure\|backlog\|dropped" <source>
```

Vécu : une hypothèse sur un blocage de boucle d'événements a été construite, présentée, puis réfutée en une commande — le programme journalisait déjà exactement ça, avec un seuil de 5 secondes, et n'avait rien signalé sur la fenêtre concernée. Le commentaire de code qui avait mis sur la piste citait littéralement le message d'instrumentation.

**L'instrumentation existante réfute ou confirme plus vite que le raisonnement, et sans coût de crédibilité.**

### 0.2 — Un instantané ne dit rien d'une tendance

`top`, `df`, `free` donnent l'état à la seconde présente. Un pic isolé et une dérive lente s'y ressemblent.

```bash
sar -q          # charge, historique
sar -r          # mémoire, historique
vmstat 1 5      # colonne st = steal time
```

Rétention typique : 7 à 8 jours dans `/var/log/sysstat/`. **Ne jamais conclure « le serveur est saturé » sur une seule lecture** — et vérifier le `steal time` avant d'incriminer l'hébergeur : à 0, la cause est locale.

### 0.3 — Le vocabulaire du projet avant l'interprétation générique

Si la demande est plus courte que la tâche qu'elle déclenche (deux mots pour une opération non triviale), c'est probablement un **terme de vocabulaire projet**. Chercher le verbe dans `CLAUDE.md` et en mémoire **avant** d'agir.

Vécu : « check hermes » a produit un diagnostic d'infrastructure complet alors que l'expression désigne la lecture d'un fichier précis. Rien de faux, rien de demandé, et le vrai message a failli être manqué.

---

## Phase 1 — Mesurer sans se mentir

### 1.1 — Un résultat négatif obtenu par pipe doit être rejoué sans pipe

`| grep -c`, `| wc -l` comptent les lignes de **stdout**. Si la commande a échoué et écrit sur **stderr**, le compte est zéro — indiscernable d'une absence réelle.

```bash
# FAUX : renvoie 0 aussi bien si le process n'a pas de socket
#        que si la lecture est refusée
docker exec c ls -l /proc/<pid>/fd | grep -c socket

# JUSTE : l'erreur est visible
docker exec c ls -l /proc/<pid>/fd 2>&1 | head
```

Vécu : ce comptage a renvoyé `0`, d'où la conclusion « le process n'a plus aucune connexion ». Faux — Docker retire `CAP_SYS_PTRACE`, chaque lien renvoyait `Permission denied`. La mesure correcte montrait des sockets parfaitement saines. Conclusion inverse.

**Règle : un résultat qui *confirme* l'hypothèse mérite plus de vérification qu'un résultat qui la contredit — c'est celui qu'on ne rejouera pas.**

### 1.2 — Vérifier depuis le bon point d'observation

Un conteneur ne voit pas tout de lui-même. Pour l'état réseau réel :

```bash
CPID=$(docker inspect -f '{{.State.Pid}}' <conteneur>)
nsenter -t $CPID -n ss -tnp
```

Donne l'état effectif des sockets (`ESTAB`, `Recv-Q`/`Send-Q`) et le PID **hôte** propriétaire. Indispensable pour distinguer un client vraiment déconnecté d'un client bloqué logiquement dont la socket est saine.

### 1.3 — Où vit le fichier que je regarde ?

Dans un conteneur, trois zones aux durées de vie différentes :

| Zone | Survit à `restart` | Survit à `up -d --force-recreate` |
|---|---|---|
| Bind mount / volume | oui | oui |
| Couche d'écriture | oui | **non** |
| Couche d'image | oui | oui, mais écrasée par une mise à jour |

Un correctif appliqué à chaud dans la couche d'écriture disparaît à la première recréation — c'est-à-dire souvent à la première mise à jour. Se demander explicitement, pour chaque fichier modifié : **dans quelle zone vit-il ?**

---

## Phase 2 — Formuler l'hypothèse

### 2.1 — Nommer la commande qui la réfuterait

Pour chaque hypothèse, écrire à côté la commande qui prouverait qu'elle est fausse. L'écrire force à constater qu'elle n'a pas été lancée.

### 2.2 — Pas d'intitulé de certitude avant vérification

Interdits dans un livrable écrit tant que la preuve n'est pas faite : « cause racine », « confirmé », « le problème est ». Utiliser « hypothèse », « piste ».

Vécu : une section intitulée « Cause racine » écrite avant vérification, puis rétractée dans la même session.

### 2.3 — Vérifier qu'un correctif peut seulement s'appliquer

Avant de recommander un levier de configuration, vérifier que **sa condition de garde est remplie**. Vécu : deux réglages allaient être proposés alors que le transport utilisé les rendait inopérants.

---

## Phase 3 — Corriger et prouver

### 3.1 — Le test doit provoquer l'événement, pas le simuler

Si l'enjeu est « survit à X » (recreate, reboot, redéploiement, rotation), fabriquer l'état d'après-X. Le patron, détaillé dans `~/dev/wiki/tests-doc.md` règle d :

```bash
docker run --rm -v /chemin/donnees:/opt/data:ro --entrypoint sh <image-construite> -c '...'
```

Couche d'écriture vierge, données réelles en lecture seule, zéro effet de bord. Viser **l'image que le recreate emploierait**, pas l'image amont dont elle dérive.

### 3.2 — Prouver que le correctif est invoqué, pas seulement qu'il fonctionne

Tester un script isolément ne dit rien de son déclenchement. Exercer le mécanisme appelant — entrypoint, hook, cron, unité systemd — dans le même environnement jetable.

Vécu : un correctif déployé et testé unitairement, dont rien ne prouvait qu'il était appelé. La boucle censée l'invoquer n'avait jamais tourné.

### 3.3 — Inventorier ce que l'événement détruit

Quand un correctif est motivé par « X sera détruit », lister **tout** ce que X contient. L'élément qui a déclenché l'enquête est rarement le seul.

Vécu : en déplaçant un environnement Python hors d'une zone volatile, découverte de polices au même endroit — dépendance plus dangereuse, parce que son absence ne lève **aucune erreur** (voir `~/dev/wiki/architecture-doc.md`, « Dépendances d'environnement »).

---

## Phase 4 — Rendre le correctif durable

1. **Emplacement persistant** pour toute dépendance installée à chaud.
2. **Mécanisme de réapplication** si la persistance est impossible : script rejoué au démarrage, idempotent, qui sort en code 0 même en échec — un correctif raté ne doit jamais empêcher le démarrage.
3. **Commande de contrôle documentée** dans le `doc.md` du projet, surtout pour les dépendances à repli silencieux.
4. **Journal** : le mécanisme doit écrire quelque part, et son message de succès doit être **conditionné au succès**. Un journal qui ne peut pas écrire « échec » ne prouve rien quand il écrit « succès ».

---

## Checklist de sortie

- [ ] L'instrumentation existante a été consultée avant toute hypothèse
- [ ] Aucune conclusion tirée d'un instantané unique
- [ ] Tout résultat négatif issu d'un pipe a été rejoué sans pipe
- [ ] Chaque hypothèse a sa commande de réfutation nommée
- [ ] Aucun intitulé de certitude sur une hypothèse non vérifiée
- [ ] Le test a provoqué l'événement, pas simulé sur une copie
- [ ] Le déclenchement du correctif est prouvé, pas seulement son fonctionnement
- [ ] Ce que l'événement détruit a été inventorié en entier
- [ ] Le correctif survit à un recreate — vérifié, pas supposé
- [ ] Commande de contrôle ajoutée à la documentation d'exploitation
