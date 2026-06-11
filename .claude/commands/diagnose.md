# /diagnose — Diagnostic approfondi

Pour les bugs difficiles qui résistent à `/debug`. Quatre phases dans l'ordre — ne pas en sauter sans justification.

Déclenché depuis `/debug` étape 5 (bug bloquant), ou manuellement pour une régression de performance.

**Modèle recommandé : T3 — Opus**
> Si tu tournes en Sonnet, signale-le à Medwin avant de commencer : _"Ce skill est T3 — Opus est recommandé pour ce niveau de raisonnement. Tape `/model opus` pour basculer."_

---

## Phase 1 — Construire une boucle de feedback

Avant tout : construire un signal pass/fail automatisé, rapide, déterministe. Sans ça, ne pas avancer.

### Comment construire la boucle — dans cet ordre de préférence

1. Test automatisé (unitaire, intégration, Playwright) qui atteint le bug
2. Script curl ou HTTP contre le serveur de dev
3. Invocation CLI avec un input fixture, diff du résultat contre un snapshot connu
4. Script Playwright headless qui navigue dans l'UI et asserte sur DOM / console / réseau
5. Replay d'une requête capturée — sauvegarder le payload réel, le rejouer en isolation
6. Harness minimal — un service, deps mockées, un seul appel qui déclenche le bug
7. Boucle fuzz — si le bug est "parfois mauvais résultat", lancer 1000 inputs aléatoires
8. Bisection — si le bug est apparu entre deux commits connus : `git bisect run`
9. Boucle différentielle — même input, ancienne vs nouvelle version, diff des sorties

Une fois une boucle construite, l'améliorer :
- Plus rapide ? (réduire le scope, ignorer l'init non pertinent)
- Signal plus précis ? (asserter sur le symptôme exact, pas juste "n'a pas crashé")
- Plus déterministe ? (fixer l'horodatage, seeder le RNG, isoler le filesystem)

### Bugs non déterministes

Objectif : taux de reproduction suffisamment élevé pour déboguer. Boucler 100×, paralléliser, injecter du stress. Un bug à 50% de flake est déboguable ; à 1% non.

### Si la boucle est impossible à construire

S'arrêter et le dire. Lister ce qui a été essayé. Demander à Medwin : accès à l'environnement qui reproduit, artefact capturé (HAR, log, recording avec timestamps), ou permission d'instrumenter temporairement.

---

## Phase 2 — Reproduire

Lancer la boucle. Vérifier :

- [ ] Le bug reproduit est bien celui décrit par Medwin — pas un bug voisin
- [ ] L'échec est stable (ou le taux de flake est suffisant pour déboguer)
- [ ] Le symptôme exact est capturé pour pouvoir vérifier le fix plus tard

---

## Phase 3 — Hypothèses

Générer 3 à 5 hypothèses classées avant d'en tester aucune.

Chaque hypothèse doit être falsifiable :

> "Si [X] est la cause, alors [changer Y] fera disparaître le bug."

Une hypothèse sans prédiction est une intuition — l'affiner ou l'écarter.

Montrer la liste classée à Medwin avant de tester. Il a souvent une connaissance du domaine qui reclasse instantanément. Ne pas bloquer dessus si il est absent.

---

## Phase 4 — Instrumenter, fixer, nettoyer

### Instrumentation

Une sonde = une hypothèse de la Phase 3. Changer une variable à la fois.

- Debugger ou REPL en premier si l'environnement le permet
- Logs ciblés aux frontières qui distinguent les hypothèses
- Taguer chaque log temporaire : `[DEBUG-xxxx]` — le nettoyage devient un seul grep

Pour les régressions de performance : établir une baseline (timing harness, `performance.now()`, query plan), puis bisect. Mesurer avant de fixer.

### Fix

Écrire le test de régression avant le fix — seulement s'il existe une bonne couture (seam) :
1. Transformer la repro minimisée en test qui échoue
2. Observer l'échec
3. Appliquer le fix
4. Observer le succès
5. Relancer la boucle Phase 1 sur le scénario original

Si aucune bonne couture n'existe → le noter. L'architecture empêche de verrouiller le bug. Signaler pour `/refacto`.

### Nettoyage

- [ ] La repro originale ne se reproduit plus
- [ ] Test de régression passe (ou absence de couture documentée)
- [ ] Tous les `[DEBUG-...]` retirés — `grep "[DEBUG-"` dans le code
- [ ] L'hypothèse correcte est dans le message de commit

Avant de clôturer : qu'est-ce qui aurait prévenu ce bug ? Si la réponse implique un changement architectural → signaler pour `/refacto` ou `/archi`.

---

## Prochaine étape

Bug résolu → retour à `/recette`.
