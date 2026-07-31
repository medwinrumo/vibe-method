#!/bin/bash
# Rappelle /maj si des repos touches dans la session ont du travail en suspens.
# Throttle : au plus un rappel toutes les 20 minutes, pour ne pas polluer chaque tour.
#
# Couple avec track-repo.sh (meme depot), qui alimente le fichier lu ici.
#
# La surveillance cavecrew qui vivait ici a ete sortie le 2026-07-31 vers
# claude-config/hooks/stop-cavecrew.sh : cavecrew est un plugin personnel, pas
# un element de la methode. Les deux blocs ne partageaient aucune donnee.
payload=$(cat)
sid=$(printf '%s' "$payload" | jq -r '.session_id // "unknown"')

msg=""

touched="/tmp/claude-repos-$sid"
if [ -s "$touched" ]; then
  stamp="/tmp/claude-cloture-$sid"
  do_check=1
  if [ -f "$stamp" ]; then
    age=$(( $(date +%s) - $(stat -f %m "$stamp" 2>/dev/null || echo 0) ))
    [ "$age" -lt 1200 ] && do_check=0
  fi
  if [ "$do_check" = "1" ]; then
    pending=""
    while IFS= read -r r; do
      [ -d "$r" ] || continue
      etat=""
      git -C "$r" status --porcelain 2>/dev/null | grep -q . && etat="non commite"
      n=$(git -C "$r" log --oneline @{u}..HEAD 2>/dev/null | wc -l | tr -d ' ')
      [ "${n:-0}" -gt 0 ] && etat="${etat:+$etat, }$n commit(s) non pousse(s)"
      [ -n "$etat" ] && pending="${pending}${pending:+ | }$(basename "$r") ($etat)"
    done < "$touched"
    if [ -n "$pending" ]; then
      touch "$stamp"
      msg="Cloture de session non faite — $pending. Lancer /maj avant de terminer."
    fi
  fi
fi

[ -n "$msg" ] || exit 0
printf '{"systemMessage":%s}\n' "$(printf '%s' "$msg" | jq -Rs .)"
exit 0
