#!/bin/bash
# Rappelle /maj si des repos touches dans la session ont du travail en suspens.
# Throttle : au plus un rappel toutes les 20 minutes, pour ne pas polluer chaque tour.
payload=$(cat)
sid=$(printf '%s' "$payload" | jq -r '.session_id // "unknown"')
touched="/tmp/claude-repos-$sid"
[ -s "$touched" ] || exit 0

stamp="/tmp/claude-cloture-$sid"
if [ -f "$stamp" ]; then
  age=$(( $(date +%s) - $(stat -f %m "$stamp" 2>/dev/null || echo 0) ))
  [ "$age" -lt 1200 ] && exit 0
fi

pending=""
while IFS= read -r r; do
  [ -d "$r" ] || continue
  etat=""
  git -C "$r" status --porcelain 2>/dev/null | grep -q . && etat="non commite"
  n=$(git -C "$r" log --oneline @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
  [ "${n:-0}" -gt 0 ] && etat="${etat:+$etat, }$n commit(s) non pousse(s)"
  [ -n "$etat" ] && pending="${pending}${pending:+ | }$(basename "$r") ($etat)"
done < "$touched"

[ -n "$pending" ] || exit 0
touch "$stamp"
printf '{"systemMessage":%s}\n' "$(printf 'Cloture de session non faite — %s. Lancer /maj avant de terminer.' "$pending" | jq -Rs .)"
exit 0
