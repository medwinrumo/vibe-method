---
type: agent
source: ../../.claude/agents/web-performance-auditor.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [agent, performance, web]
---

## Rôle
**`web-performance-auditor`** — Audit Core Web Vitals, chargement, rendu, réseau. Contexte frais isolé. Seul vrai gap identifié dans la comparaison agent-skills — rien d'équivalent ailleurs chez vibe-method.

## Modes
- **Rapide** (actif) : scan statique du code, zéro outil requis, findings étiquetés "impact potentiel" uniquement.
- **Profond** : MCP `chrome-devtools` installé (2026-07-28, scope user) — vérifier sa présence réelle dans les outils de la session avant de s'y fier (chargement au démarrage, pas à chaud). Jamais de mesure inventée sans artefact réel (règle d'honnêteté métrique).

## Outils
Read, Grep, Bash, WebFetch (parsing d'un artefact collé/URL PageSpeed si fourni)

## Sortie
Scorecard (LCP/INP/CLS, "non mesuré" si pas d'artefact) + findings par sévérité.

## Composition
Invocation directe uniquement. Pas inclus dans un éventuel fan-out multi-persona — s'applique aux apps web seulement.

## Liens
[[doctrines/design]] | [[doctrines/stack]] | [[agents/code-reviewer]]
