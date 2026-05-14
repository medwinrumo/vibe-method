# Comparaison BMAD vs vibe-method
_Produit le 2026-05-14 — base : fichiers réels `~/dev/bmad-method/src/` vs `~/dev/vibe-method/.claude/commands/`_

---

## Section A — Ce que BMAD couvre mieux

### 1. Gestion de sprint à deux niveaux (épics + stories + status tracking)
**BMAD** : `bmad-sprint-planning` génère et maintient `sprint-status.yaml` avec tracking exhaustif (state machine : backlog → ready-for-dev → in-progress → review → done). `bmad-sprint-status` consulte ce fichier pour surfacer les risques.
**vibe-method** : `/todo` lit l'état du projet mais ne gère pas d'artefact centralisé de sprint tracking. Le statut des stories reste dispersé.
**Impact** : BMAD donne une visibilité temps-réel sur quelle story développer ensuite et détecte les goulots d'étranglement.

### 2. Validation PRD avant architecture
**BMAD** : `bmad-validate-prd` valide un PRD existant (cohérence, complétude, traçabilité) via checklist structurée.
**vibe-method** : `/prd` crée le PRD par dialogue mais pas de gate de validation avant `/archi`.
**Impact** : BMAD piège les failles de PRD avant qu'elles n'impactent l'architecture.

### 3. Vérification de readiness avant implementation
**BMAD** : `bmad-check-implementation-readiness` valide que PRD, UX, Archi, Épics et Stories sont complets et alignés AVANT Phase 4.
**vibe-method** : Pas de skill équivalent. Transition vers `/specs` → `/sessionCode` sans vérification formelle.
**Impact** : BMAD empêche le code de démarrer sur des fondations instables.

### 4. Gestion du changement avec impact cross-artifact
**BMAD** : `bmad-correct-course` analyse les impacts d'un changement sur PRD, Épics, Archi, UX. Trie par sévérité (Minor → Moderate → Major).
**vibe-method** : Pas de skill dédié. Les changements sont gérés ad hoc.
**Impact** : BMAD maîtrise les cascades de dépendances lors du changement.

### 5. Revue de code en couches parallèles
**BMAD** : `bmad-code-review` lance 3 revues en parallèle (Blind Hunter + Edge Case + Acceptance), trie les findings par couche.
**vibe-method** : `/code-review` est une revue linéaire structurelle + sécurité.
**Impact** : BMAD capture plus de patterns subtils via la parallélisation.

### 6. Edge case hunting dédié
**BMAD** : `bmad-review-edge-case-hunter` marche méthodiquement chaque branching path et retourne UNIQUEMENT les unhandled edges.
**vibe-method** : `/code-review` couvre les edge cases mais sans cette rigueur mécanique d'énumération.
**Impact** : BMAD détecte les conditions limites systématiquement.

### 7. Adversarial review (cynical reviewing)
**BMAD** : `bmad-review-adversarial-general` — revue cynique qui assume que le contenu est mauvais, trouve au minimum 10 problèmes.
**vibe-method** : `/code-review` est structure-first, non cynical.
**Impact** : BMAD pousse à la critique extrême. vibe-method peut manquer des défauts systémiques.

### 8. Retrospective post-épic structurée
**BMAD** : `bmad-retrospective` — workflow 12 étapes : deep story analysis, previous retro follow-through, next epic preview, preparation planning, action items, readiness verification. Avec party mode.
**vibe-method** : Pas de skill retrospective. `/maj` clôture de session mais sans ce layer de post-epic learning.
**Impact** : BMAD crée un cycle d'amélioration continue.

### 9. Project context optimisé pour LLM
**BMAD** : `bmad-generate-project-context` crée `project-context.md` via dialogue — règles unobvious que les LLMs doivent suivre, optimisé pour la génération de code.
**vibe-method** : `/prp` agrège les outputs. Les règles LLM-spécifiques sont dans `CLAUDE.md` du projet.
**Impact** : BMAD centralise les règles LLM-spécifiques en un fichier dédié.

### 10. Dev story workflow avec review continuation
**BMAD** : `bmad-dev-story` — implémente la story avec continuation post-review (findings → fix → re-test → done). Integre sprint-status tracking.
**vibe-method** : `/sessionCode` + code. Pas de workflow de story completion formel (review → fix → done).
**Impact** : BMAD force la boucle complète. vibe-method peut laisser des reviews ouvertes.

### 11. Party mode intégré dans les workflows critiques
**BMAD** : `/party` (core-skill) est invoqué dans `archi`, `retrospective`, etc.
**vibe-method** : `/party` existe mais reste un skill standalone — pas intégré systématiquement.
**Impact** : BMAD force la multi-perspective aux décisions critiques. vibe-method la rend optionnelle.

---

## Section B — Ce que vibe-method couvre mieux

### 1. Dialogue de brief structuré avec elicitation avancée
**vibe-method** : `/brief` guide intention → brief via Socratique / First Principles / Pre-Mortem / Red Team.
**BMAD** : Pas de skill équivalent. Part du PRD existant ou le génère linéairement.

### 2. Design system avec toggle Mode A/B
**vibe-method** : `/design` Mode A (système complet → Claude Design) ↔ Mode B (intégration code → Tailwind/NativeWind). Architecture explicite.
**BMAD** : `bmad-create-ux-design` crée des specs mais sans workflow A/B ni intégration Tailwind/NativeWind.

### 3. Architecture avec feedback loop A/P/C
**vibe-method** : `/archi` menu A/P/C force l'approfondissement ou la multi-perspective sur chaque décision.
**BMAD** : `bmad-create-architecture` est un workflow linéaire par étapes. Pas de menu récursif.

### 4. Spike technique (stack investigation)
**vibe-method** : `/stack` — spike complet (versions, free tier, gotchas, WebSearch obligatoire, guidelines stores).
**BMAD** : Pas de skill dédié. Investigation distribuée dans `bmad-create-architecture`.

### 5. Roadmap globale avant fragmentation en stories
**vibe-method** : `/roadmap` produit une roadmap PRD → épics → planning global avant de découper.
**BMAD** : Pas de skill roadmap. Passe directement PRD → create epics.

### 6. Spec par feature (fichier auto-contenu)
**vibe-method** : `/specs` → `[projet].spec.[feature].md` — un fichier par feature, testable isolément.
**BMAD** : `bmad-create-epics-and-stories` crée un fichier central. Pas de spec dédiée par feature.

### 7. Project Ready Prompt (condensation optimisée LLM)
**vibe-method** : `/prp` agrège TOUS les outputs en un document condensé < 1 000 tokens.
**BMAD** : Pas d'équivalent. Les agents chargent les artefacts séparément.

### 8. Session code avec confirmation de contexte
**vibe-method** : `/sessionCode` charge PRP, confirme feature, rappelle règles critiques (sécurité, silos, tests).
**BMAD** : `bmad-dev-story` démarre sur la story mais sans ce sas de mise en contexte explicite.

### 9. Refactoring guidé itératif
**vibe-method** : `/refacto` — diagnostic + exécution pas à pas. Déclenché proactivement.
**BMAD** : Pas de skill refactoring dédié. La dette est détectée en rétrospective.

### 10. Recette et validation manuelle
**vibe-method** : `/recette` — Gherkin depuis User Stories + validation manuelle humaine.
**BMAD** : `bmad-qa-generate-e2e-tests` automatise les E2E mais pas de workflow de recette manuelle dédiée.

### 11. Doctrine RGPD séparée
**vibe-method** : `rgpd.md` — doctrine complète (bases légales, droits, registre, checklist).
**BMAD** : Pas de module RGPD séparé.

### 12. ADR (Architectural Decision Records)
**vibe-method** : `/adr` — capture chaque décision architecturale (4 questions → append `[projet].adr.md`).
**BMAD** : Pas de skill ADR. Les décisions restent dans le document d'architecture.

---

## Section C — Lacunes dans vibe-method à combler

### 1. Gate de validation PRD avant architecture — **Haute priorité**
**Recommandation** : Créer `/prd-validate` — skill standalone qui relit un PRD et valide : cohérence interne, traçabilité (feature → success criterion), complétude (zones essentielles remplies).
**Déclencheur** : automatique après `/prd` (première version) ou on-demand après itérations.

### 2. Gate de readiness avant dev — **Haute priorité**
**Recommandation** : Créer `/readiness-check` — scanne : PRD validé, archi couvre toutes les features, specs existent pour V1, project context existe.
**Output** : rapport readiness (GO / BLOCKERS / WARNINGS).
**Déclencheur** : avant `/setup` ou premier `/sessionCode`.

### 3. Sprint tracking centralisé — **Haute priorité**
**Recommandation** : Créer `/sprint-status` — lit un `sprint-status.yaml` (ou équivalent) et résume : % complété, risques, prochaine story.
**Déclencheur** : en début de session de code (via `/sessionCode`).

### 4. Retrospective post-épic — **Haute priorité**
**Recommandation** : Créer `/epic-retrospective` — deep story analysis, previous retro follow-through, next epic preview, action items.
**Déclencheur** : quand toutes les stories d'une épic sont "done".

### 5. Project context dédié LLM — **Haute priorité**
**Recommandation** : Créer `/project-context` — dialogue itératif pour documenter les règles unobvious spécifiques au projet. Output : `[projet].project-context.md` compact.
**Déclencheur** : après `/archi` et avant premier `/sessionCode`.

### 6. Change request avec impact analysis — **Moyenne priorité**
**Recommandation** : Créer `/change-request` — prend un changement proposé, analyse l'impact sur tous les artefacts (PRD, archi, specs), trie par scope (Minor / Moderate / Major), propose before/after.

### 7. Revue de code edge-case hunting — **Moyenne priorité**
**Recommandation** : Créer `/code-review-edge-cases` — skill orthogonal qui énumère tous les branching paths et retourne les unhandled edges.
**Alternative** : intégrer dans `/code-review` comme étape séparée.

### 8. Story workflow complet (review → fix → done) — **Moyenne priorité**
**Recommandation** : Enrichir `/sessionCode` — après le code, tracker la story vers "review", puis "done" après résolution des findings de `/code-review`.

### 9. Dependency mapping (feature → module → story) — **Basse priorité**
**Recommandation** : Créer `/dependency-map` — charge PRD, archi, specs et produit une matrice de traçabilité. Détecte orphelines et doublons.

### 10. PRD versioning explicite — **Basse priorité**
**Recommandation** : Structurer `[projet].prd.md` avec sections versionnées (V1 en toggle, V2 en toggle) et historique de changements.

### 11. Test architecture clarity — **Basse priorité**
**Recommandation** : Enrichir `/tests` avec une section explicite sur quels tests tournent où (unit en local, E2E en CI).

---

## Tableau de synthèse

| Priorité | Action | Skill à créer / enrichir |
|---|---|---|
| Haute | Gate validation PRD | `/prd-validate` (nouveau) |
| Haute | Gate readiness avant dev | `/readiness-check` (nouveau) |
| Haute | Sprint tracking | `/sprint-status` (nouveau) ou enrichir `/todo` |
| Haute | Retrospective post-épic | `/epic-retrospective` (nouveau) |
| Haute | Project context LLM-optimized | `/project-context` (nouveau) |
| Moyenne | Change management | `/change-request` (nouveau) |
| Moyenne | Edge case hunting | `/code-review-edge-cases` (nouveau) ou enrichir `/code-review` |
| Moyenne | Story workflow complet | Enrichir `/sessionCode` |
| Basse | Dependency traceability | `/dependency-map` (nouveau) |
| Basse | PRD versioning | Enrichir `/prd` template |
| Basse | Test architecture clarity | Enrichir `/tests` |
