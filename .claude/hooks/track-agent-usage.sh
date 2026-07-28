#!/bin/bash
# Log silencieux de chaque invocation d'agent (PostToolUse) — une ligne par
# appel : subagent_type. Sert à repérer si cavecrew (investigator/builder/
# reviewer) est réellement utilisé ou pas. Lu par stop-cloture.sh en fin de
# session : si des agents ont tourné mais aucun cavecrew, alerte.
# Champs vérifiés empiriquement le 2026-07-28 (payload réel capturé) :
# tool_name = "Agent", subagent_type dans tool_input.subagent_type.
payload=$(cat)
sid=$(printf '%s' "$payload" | jq -r '.session_id // "unknown"')
subagent=$(printf '%s' "$payload" | jq -r '.tool_input.subagent_type // "unknown"')
log="/tmp/claude-agent-usage-$sid"
printf '%s\n' "$subagent" >> "$log"
exit 0
