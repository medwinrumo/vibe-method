---
type: agent
source: ../../.claude/agents/code-reviewer.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [agent, code-review, doubt-driven]
---

## Rôle
**`code-reviewer`** — Revue de code Staff Engineer, contexte frais isolé, 5 dimensions (correction, lisibilité, architecture, sécurité, performance).

## Différence avec `/code-review`
`/code-review` = étape fixe du pipeline Phase 7, suit la doctrine projet (archi, silos). `code-reviewer` = persona ad hoc, verdict générique indépendant du pipeline — invocable n'importe quand, ou comme reviewer adversarial de l'étape DOUBT du geste [[doctrines/methode|Le juge impartial]].

## Outils
Read, Grep, Bash (lecture seule — `git diff`/`log -p`/`show` uniquement)

## Sortie
Verdict APPROUVE/DEMANDE DE CHANGEMENTS, findings classés Critique/Important/Suggestion, au moins une observation positive.

## Composition
Invocation directe uniquement — n'invoque jamais une autre persona (`security-auditor`, `test-engineer`). Recommandation en texte si un audit plus profond semble nécessaire.

## Liens
[[doctrines/methode]] | [[agents/security-auditor]] | [[agents/test-engineer]] | [[agents/web-performance-auditor]]
