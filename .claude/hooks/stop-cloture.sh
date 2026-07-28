#!/bin/bash
# Rappelle /maj si des repos touches dans la session ont du travail en suspens.
# Alerte aussi si des agents ont ete invoques cette session sans jamais passer
# par cavecrew (investigator/builder/reviewer) — surveillance d'usage, une
# seule fois par session (pas repete a chaque tour).
# Throttle cloture : au plus un rappel toutes les 20 minutes, pour ne pas polluer chaque tour.
payload=$(cat)
sid=$(printf '%s' "$payload" | jq -r '.session_id // "unknown"')

msg=""

# --- Cloture git (existant) ---
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

# --- Surveillance usage agents / cavecrew ---
agentlog="/tmp/claude-agent-usage-$sid"
agentstamp="/tmp/claude-agent-alert-$sid"
if [ -s "$agentlog" ] && [ ! -f "$agentstamp" ]; then
  total=$(wc -l < "$agentlog" | tr -d ' ')
  cave=$(grep -c "^caveman:cavecrew" "$agentlog")
  if [ "$total" -gt 0 ] && [ "$cave" -eq 0 ]; then
    touch "$agentstamp"
    agent_msg="$total agent(s) invoque(s) cette session, aucun cavecrew (investigator/builder/reviewer) — verifier si une recherche read-only ou une petite edition aurait pu passer par cavecrew (economie de contexte)."
    msg="${msg:+$msg | }$agent_msg"
  fi
fi

[ -n "$msg" ] || exit 0
printf '{"systemMessage":%s}\n' "$(printf '%s' "$msg" | jq -Rs .)"
exit 0
