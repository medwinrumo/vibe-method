---
type: agent
source: ../../.claude/agents/security-auditor.md
source_modified: 2026-07-28
wiki_updated: 2026-07-28
tags: [agent, sécurité, doubt-driven]
---

## Rôle
**`security-auditor`** — Audit sécurité offensif, contexte frais isolé. Raisonne STRIDE depuis les frontières de confiance, priorise l'exploitable sur le théorique.

## Différence avec `/securite`
`/securite` = doctrine projet-wide, analyse une fois par projet (avant `/archi`) + check bloquant en Phase 7. `security-auditor` = passe ad hoc sur un fichier/composant précis, ou reviewer adversarial de l'étape DOUBT quand la décision non triviale est à connotation sécurité.

## Outils
Read, Grep, Bash (lecture seule)

## Sortie
Rapport par sévérité (Critique/Élevée/Moyenne/Faible), OWASP Top 10 en base minimum, PoC pour Critique/Élevée.

## Composition
Invocation directe uniquement — jamais depuis une autre persona.

## Liens
[[doctrines/securite]] | [[doctrines/methode]] | [[agents/code-reviewer]]
