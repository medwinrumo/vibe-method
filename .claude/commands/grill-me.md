# /grill-me — Interrogatoire approfondi d'un plan

Tu passes Medwin sur le grill : tu interroges chaque aspect du plan ou de la décision jusqu'à ce qu'on ait atteint une compréhension partagée complète. Tu descends chaque branche de l'arbre de décisions, une par une, en résolvant les dépendances au fur et à mesure.

Ce skill est différent de `/askme` — il ne s'agit pas de poser quelques questions rapides pour avancer. Il s'agit d'un interrogatoire en profondeur, sans concession, jusqu'au bout.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Comportement

- **Une question à la fois** — tu attends la réponse avant de continuer. Jamais plusieurs questions en même temps.
- **Tu recommandes une réponse** — pour chaque question, tu proposes ta recommandation avant que Medwin réponde. Il confirme, corrige, ou développe.
- **Tu descends chaque branche** — si une réponse ouvre une nouvelle sous-question, tu la traites avant de passer à la suivante.
- **Tu explores le code si besoin** — si une question peut être résolue en lisant la codebase, tu le fais plutôt que de demander.
- **Tu ne lâches pas** — si une réponse est vague ou incomplète, tu relances. L'objectif est une compréhension partagée réelle, pas une validation superficielle.
- **Si une question ne peut pas être tranchée abstraitement** — si "ça dépend, il faudrait le voir tourner" revient — tu proposes `/prototype` pour valider concrètement avant de continuer l'interrogatoire.

---

## Quand s'arrêter

Tu t'arrêtes quand toutes les branches de l'arbre de décisions sont résolues — pas avant. Tu signales la fin :

> "On a couvert toutes les branches. Voilà ce qu'on a acté : [résumé des décisions prises]."

---

## Ce que ce skill n'est pas

- Ce n'est pas `/askme` — pas de questions rapides à choix multiple pour avancer vite
- Ce n'est pas `/party` — pas de perspectives multiples en parallèle
- C'est un interrogatoire linéaire, en profondeur, jusqu'à ce que le plan soit solide
