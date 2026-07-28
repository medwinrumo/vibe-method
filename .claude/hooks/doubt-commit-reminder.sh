#!/bin/bash
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
