#!/bin/bash
# DÉSACTIVÉ (2026-07-28) — retiré de settings.json PreToolUse : ni systemMessage/exit 0
# ni stderr/exit 1 ne s'affichent pour PreToolUse dans ce build de Claude Code, testé
# 2 fois en session courante + 2 fois en session fraîche. Script conservé tel quel
# pour réactivation si un futur build corrige l'affichage PreToolUse — voir methode.md
# section "Le juge impartial". Mécanisme retenu à la place : bloc CLAIM écrit par
# l'agent directement dans sa réponse chat avant tout commit non trivial.
# Rappel doubt-driven-development avant un git commit — jamais bloquant.
# Comparaison addyosmani/agent-skills vs vibe-method, validé 2026-07-28.
input=$(cat)
command=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')

case "$command" in
  *git\ commit*)
    echo "Doubt-driven : décision non triviale dans ce commit (archi, logique métier, périmètre inconnu) ? Si oui, cycle CLAIM -> EXTRACT -> DOUBT (sous-agent adversarial) -> RECONCILE -> STOP avant de valider. Voir methode.md, section Pilotage de la session de code." >&2
    exit 1
    ;;
esac
exit 0
