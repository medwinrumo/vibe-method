#!/bin/bash
# Enregistre la racine du repo git de chaque fichier ecrit/edite, par session
payload=$(cat)
sid=$(printf '%s' "$payload" | jq -r '.session_id // "unknown"')
f=$(printf '%s' "$payload" | jq -r '.tool_response.filePath // .tool_input.file_path // empty')
[ -n "$f" ] || exit 0
root=$(git -C "$(dirname "$f")" rev-parse --show-toplevel 2>/dev/null) || exit 0
touched="/tmp/claude-repos-$sid"
grep -qxF "$root" "$touched" 2>/dev/null || echo "$root" >> "$touched"
exit 0
