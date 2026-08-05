#!/bin/bash
# audit-dependances.sh — Inventaire des dépendances avant/après un déplacement.
#
# Créé le 2026-08-05. Motif : la stratégie de migration comptait les références
# textuelles à vibe-method et au wiki, mais avait manqué cinq catégories —
# dont un dépôt entier (hermes-config, ~140 skills VPS miroir) et une constante
# codée en dur dans lint-wiki.py.
#
# À lancer AVANT chaque phase de migration (état de référence) et APRÈS
# (vérification qu'il ne reste rien). Une phase n'est finie que quand la sortie
# « après » ne contient plus que des occurrences volontaires — historique du
# carnet d'observations, journaux, mentions d'un incident passé.
#
# Usage : bash scripts/audit-dependances.sh [motif]
#         motif par défaut : les chemins de la migration en cours.

set -uo pipefail
DEV="$HOME/dev"
MOTIFS=("${1:-dev/vibe-method}" "dev/wiki" "CLAUDE.global" "lint-observabilite" "Vibe-Method/")

titre() { printf '\n\033[1m=== %s ===\033[0m\n' "$1"; }

titre "1. Références textuelles, par motif"
for m in "${MOTIFS[@]}"; do
  n=$(grep -rl "$m" "$DEV" --include="*.md" --include="*.sh" --include="*.py" --include="*.json" 2>/dev/null \
      | grep -v "/\.git/" | wc -l | tr -d ' ')
  printf "  %-24s %s fichiers\n" "$m" "$n"
done

titre "2. Dépôts concernés (hors celui qu'on déplace)"
for m in "${MOTIFS[@]}"; do
  grep -rl "$m" "$DEV" --include="*.md" --include="*.sh" --include="*.py" --include="*.json" 2>/dev/null \
    | grep -v "/\.git/" | sed "s|$DEV/||;s|/.*||"
done | sort -u | sed 's/^/  /'

titre "3. Liens symboliques pointant vers les dépôts"
for d in commands agents hooks skills; do
  [ -d "$HOME/.claude/$d" ] || continue
  n=$(find "$HOME/.claude/$d" -maxdepth 1 -type l | wc -l | tr -d ' ')
  printf "  ~/.claude/%-10s %s liens\n" "$d" "$n"
done
printf "  cibles distinctes : "
find "$HOME/.claude" -maxdepth 2 -type l -exec readlink {} \; 2>/dev/null \
  | sed "s|$DEV/||;s|/.*||" | sort -u | tr '\n' ' '; echo

titre "4. Fichiers réels dans les dossiers d'extension (doit être vide)"
find "$HOME/.claude/commands" "$HOME/.claude/agents" "$HOME/.claude/hooks" "$HOME/.claude/skills" \
  -maxdepth 1 -type f 2>/dev/null | sed 's/^/  ANOMALIE: /' || true

titre "5. Chemins en dur dans les scripts et les hooks"
grep -rn "$HOME\|/opt/data\|dev/wiki\|dev/vibe-method" \
  "$DEV"/*/scripts/*.py "$DEV"/*/hooks/*.sh "$DEV"/*/.claude/hooks/*.sh 2>/dev/null \
  | grep -v "^Binary" | sed "s|$DEV/||" | head -20 | sed 's/^/  /'

titre "6. Constantes de nom de fichier codées en dur"
grep -rn "INFRA_FILES\|\"log.md\"\|'log.md'\|index.md\"" \
  "$DEV"/*/scripts/*.py 2>/dev/null | sed "s|$DEV/||" | sed 's/^/  /'

titre "7. settings.json — les hooks passent-ils par les liens ?"
grep -o '"command": "[^"]*"' "$DEV/claude-config/settings.json" 2>/dev/null \
  | sed 's/"command": //' | sed 's/^/  /'
echo "  (s'ils pointent vers ~/.claude/hooks/, ils sont immunisés : seuls les liens changent)"

titre "8. Miroirs Hermes citant le wiki ou la méthode"
grep -rl "dev/wiki\|/opt/data/wiki\|vibe-method" "$DEV/hermes-config/vps/skills/" 2>/dev/null \
  | sed "s|$DEV/hermes-config/vps/skills/||" | sed 's/^/  /'

titre "9. Mémoires automatiques citant ces chemins"
grep -rl "vibe-method\|dev/wiki" "$HOME/.claude/projects"/*/memory/*.md 2>/dev/null \
  | sed 's|.*/memory/||' | sed 's/^/  /'
echo "  (réécrites par la machine — corriger dans ~/.claude/projects/*/memory/,"
echo "   JAMAIS dans claude-memoire : ce dépôt est une sauvegarde, il serait écrasé)"

titre "10. Autres dépôts projet citant la méthode"
grep -rl "vibe-method" "$DEV" --include="CLAUDE.md" --include="settings.local.json" 2>/dev/null \
  | grep -v "/\.git/" | grep -vE "vibe-method/|claude-config/|claude-memoire/|hermes-config/" \
  | sed "s|$DEV/||" | sed 's/^/  /'

echo
echo "Fin de l'audit. Comparer cette sortie avant et après chaque phase."

titre "11. Exécutables du wiki ↔ liens posés (invariant de la phase 5)"
# Depuis le 05/08/2026 les skills et agents sont des fiches du wiki, reconnues
# au champ `claude-code:` de leur frontmatter. Deux façons de casser ça en
# silence : une fiche perd le champ (la commande disparaît), ou une fiche est
# renommée (le lien pend). Aucune ne produit d'erreur visible en session.
compter_champ() {
  local val="$1" n=0
  for f in "$DEV"/wiki/*.md; do
    [ -e "$f" ] || continue
    awk -v cible="$val" '
      NR==1 && $0!="---" { exit }
      NR==1 { d=1; next }
      d && $0=="---" { exit }
      d && /^claude-code:[ \t]*/ { sub(/^claude-code:[ \t]*/,""); gsub(/[ \t\r]+$/,"");
                                   if ($0==cible) { print "1" } exit }
    ' "$f"
  done | wc -l | tr -d ' '
}
fiches_cmd=$(compter_champ commande)
fiches_agt=$(compter_champ agent)
liens_cmd=$(find "$HOME/.claude/commands" -maxdepth 1 -type l -lname "*/wiki/*" 2>/dev/null | wc -l | tr -d ' ')
liens_agt=$(find "$HOME/.claude/agents"   -maxdepth 1 -type l -lname "*/wiki/*" 2>/dev/null | wc -l | tr -d ' ')
printf "  commandes : %s fiches / %s liens" "$fiches_cmd" "$liens_cmd"
[ "$fiches_cmd" = "$liens_cmd" ] && echo "  OK" || echo "  ÉCART — relancer setup.sh"
printf "  agents    : %s fiches / %s liens" "$fiches_agt" "$liens_agt"
[ "$fiches_agt" = "$liens_agt" ] && echo "  OK" || echo "  ÉCART — relancer setup.sh"
casses=$(find -L "$HOME/.claude/commands" "$HOME/.claude/agents" "$HOME/.claude/hooks" \
  -maxdepth 1 -type l 2>/dev/null | wc -l | tr -d ' ')
[ "$casses" = "0" ] && echo "  liens cassés : 0  OK" || {
  echo "  liens cassés : $casses  ANOMALIE"
  find -L "$HOME/.claude/commands" "$HOME/.claude/agents" "$HOME/.claude/hooks" \
    -maxdepth 1 -type l 2>/dev/null | sed 's/^/    /'; }
