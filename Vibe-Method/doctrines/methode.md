---
type: doctrine
source: ../../methode.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [méthode, phases, pilotage, reflex, effort, tiers-modeles, doubt-driven]
---

# Doctrine — Méthode

## En une ligne
Chef d'orchestre : comprendre sans micro-gérer, avec des garde-fous à chaque étape.

---

## Les 7 phases

```
AVANT :  Phase 1 (Produit) → Phase 2 (Design) → Phase 3 (Archi) → Phase 4 (Stack)
PENDANT: Phase 5 (Planif) → Phase 6 (Code)
APRÈS :  Phase 7 (Vérification)
```

---

## Les 10 gestes — réflexes de la Phase 6

| Geste | Ce que c'est | Quand |
|---|---|---|
| L'archer immobile | Plan avant code — discuter, pas écrire | Avant chaque feature |
| Le tranchant de la main | Interrompre l'IA dès qu'elle dérive | Pendant le code |
| La mue du serpent | Recommencer depuis zéro, ne pas corriger | Première itération ratée |
| Le juge impartial | CLAIM → EXTRACT → DOUBT (sous-agent adversarial) → RECONCILE → STOP | Décision non triviale, avant qu'elle se fixe |
| Le kiai | Dicter les prompts complexes | Prompts longs ou techniques |
| Le souffle neuf | Nouvelle conversation = contexte propre | Contexte saturé |
| L'œil de l'aigle | Analyse globale avant correction | Bloqué après 2 essais |
| Le bond du tigre | Git reset + contraintes négatives | Bloqué après analyse |
| Le singe change de branche | Changer de modèle (Claude → GPT → Gemini) | Insoluble après reset |
| Le faucon en chasse | Recherche web — doc à jour | Avant d'intégrer un service |

**Le juge impartial** — pas `/code-review-hostil` (verdict a posteriori sur du code fini) : ici en cours de route, pendant que la correction est encore bon marché. Décision non triviale = introduit/modifie une logique conditionnelle, traverse une frontière de module, affirme une propriété non vérifiable par le compilateur, ou a un rayon d'impact irréversible. Hook `PreToolUse` sur `git commit` testé et retiré (2026-07-28) — ni `systemMessage`/exit 0 ni `stderr`/exit 1 ne s'affichent pour cet événement dans ce build de Claude Code (4 tests, dont 2 en session fraîche). Script archivé, pas supprimé. **Mécanisme retenu : bloc CLAIM écrit directement dans la réponse de l'agent avant tout commit non trivial.**

**Version préventive du faucon en chasse** — vérification documentaire par feature (pas seulement en cas de blocage), voir [[doctrines/stack]] section "Vérification documentaire par feature".

---

## Protocole d'escalade (si bloqué)

1. L'œil de l'aigle — analyse globale. Pour bug difficile à cerner sans preuve technique (perf, réseau, rendu) : Chrome DevTools MCP en complément — inspection réseau live, traces LCP/INP/CLS. Outil de debug uniquement, ne remplace pas Playwright (référence tests E2E et non-régression CI/CD, voir [[doctrines/tests]])
2. Le bond du tigre — git reset + contraintes négatives
3. Le singe change de branche — autre modèle
4. Le faucon en chasse — web search
5. Le souffle neuf — nouvelle conversation
6. Si rien ne débloque → reporter, continuer

---

## Niveau d'effort par tier

En dessous de "medium", le modèle est dégradé. Au-dessus de "high", risque de sur-réflexion (invente des problèmes, refactorise sans demande, sur-anticipe des cas qui n'arriveront jamais).

| Tier | Modèle | Effort |
|---|---|---|
| T1 — Haiku | Tâche mécanique | Bas |
| T2 — Sonnet (défaut) | Implémentation standard | Medium — High si feature complexe |
| T3 — Opus | Raisonnement structurant | High — jamais extra-high |

**Règle** : fixer l'effort une fois par tâche selon sa complexité, pas au coup par coup pendant la session.

---

## Greenfield vs Brownfield

**Greenfield** : workflow standard (phases 1→7).

**Brownfield** (reprise/migration) : 3 étapes AVANT tout changement :
1. Inventaire codebase existante
2. Tests de régression sur l'existant
3. Architecture adaptateur (brancher nouveau sur ancien, migrer progressivement)

**Règle absolue brownfield** : aucune modification sans couverture de régression préalable.

---

## Definition of Done

- [ ] Tests unitaires et intégration passants (Vitest)
- [ ] Non-régression Playwright verte
- [ ] `/securite` check validé (bloquant)
- [ ] Recette manuelle validée par Medwin
- [ ] Aucune valeur hardcodée
- [ ] Code sur branche `feat/[feature]`, prêt à merger
- [ ] `[projet].doc-user.md` mis à jour

---

## Règles non-négociables

- Planification et exécution : **deux sessions séparées** — jamais mélangées
- **Une conversation par lot** — max 2-3h, recontextualiser après
- **Vérifier les modifications non demandées** après chaque session
- Rien n'entre dans le système sans validation explicite de Medwin

## Liens
[[_vue-ensemble]] | [[flux/chaine-complete]] | [[doctrines/tests]] | [[doctrines/refacto]] | [[doctrines/observabilite]] | [[doctrines/stack]]
