#!/bin/bash
# setup.sh — Recrée les liens de ~/.claude vers les exécutables du wiki.
# À lancer après un git clone sur une nouvelle machine.
#
# Depuis le 05/08/2026 (phase 5 de la réorganisation), les skills et les agents
# ne vivent plus dans vibe-method/.claude/ mais dans ~/dev/wiki/, à plat, en
# fiches du second cerveau. Ce script ne balaie donc plus un dossier : il
# interroge le frontmatter.
#
# Le discriminant est le champ `claude-code:` — `commande` pour un skill,
# `agent` pour une persona, absent pour une fiche de savoir ordinaire. Il est
# lu dans le PREMIER bloc `---` du fichier, et nulle part ailleurs : le
# `CLAUDE.md` du vault documente ce champ en toutes lettres, et une recherche
# naïve le prendrait pour un exécutable.
#
# Ce script ne détruit rien. Un fichier réel portant le nom d'un lien est
# sauvegardé sous `.remplace-<horodatage>` avant d'être remplacé — comportement
# repris de claude-config/install.sh. La version précédente utilisait `ln -sf`,
# qui écrase sans prévenir : le 29/07/2026, `grill-me.md` a été perdu ainsi.
#
# Usage :  ./setup.sh          installe
#          ./setup.sh --dry    montre ce qui serait fait, ne touche à rien
set -u

WIKI="$HOME/dev/wiki"
DRY=0
[ "${1:-}" = "--dry" ] && DRY=1

[ -d "$WIKI" ] || { echo "ABSENT : $WIKI — cloner github.com/medwinrumo/wiki d'abord"; exit 1; }

horodatage=$(date +%Y%m%d-%H%M%S)

# Lit la valeur de `claude-code:` dans le premier bloc de frontmatter.
# Renvoie une chaîne vide si le fichier n'a pas de frontmatter, ou si le champ
# n'y figure pas.
type_executable() {
  awk '
    NR==1 && $0!="---" { exit }
    NR==1 { dans=1; next }
    dans && $0=="---" { exit }
    dans && /^claude-code:[ \t]*/ {
      sub(/^claude-code:[ \t]*/, ""); gsub(/[ \t\r]+$/, ""); print; exit
    }
  ' "$1"
}

poses=0 sauvegardes=0 inchanges=0

for f in "$WIKI"/*.md; do
  [ -e "$f" ] || continue
  kind=$(type_executable "$f")
  case "$kind" in
    commande) dossier="$HOME/.claude/commands" ;;
    agent)    dossier="$HOME/.claude/agents" ;;
    *)        continue ;;
  esac

  mkdir -p "$dossier"
  nom=$(basename "$f")
  d="$dossier/$nom"

  if [ -L "$d" ] && [ "$(readlink "$d")" = "$f" ]; then
    inchanges=$((inchanges + 1)); continue
  fi

  # Fichier RÉEL à cet emplacement : le sauvegarder avant de le remplacer.
  if [ -e "$d" ] && [ ! -L "$d" ]; then
    printf 'FICHIER RÉEL     %s\n  -> sauvegardé  %s\n' "$nom" "$d.remplace-$horodatage"
    if [ "$DRY" = 0 ]; then
      mv "$d" "$d.remplace-$horodatage" || { echo "  ÉCHEC de la sauvegarde — on ne touche à rien"; continue; }
    fi
    sauvegardes=$((sauvegardes + 1))
  fi

  printf 'lien  %-10s %s\n' "$kind" "$nom"
  if [ "$DRY" = 0 ]; then rm -f "$d"; ln -s "$f" "$d"; fi
  poses=$((poses + 1))
done

printf '\n%s liens posés, %s inchangés, %s sauvegardes\n' "$poses" "$inchanges" "$sauvegardes"

# --- Hooks ---
# Boucle sur le glob et non sur une liste nommée : une liste prend du retard en
# silence (track-agent-usage.sh, ajouté le 28/07/2026, y manquait).
# Revers du glob : il ramasse les scripts archivés — d'où l'exclusion ci-dessous,
# à tenir à jour quand un hook est retiré de settings.json.
HOOKS_ARCHIVES="doubt-commit-reminder.sh"   # testé et abandonné (observation 9)

mkdir -p "$HOME/.claude/hooks"
for f in "$HOME"/dev/vibe-method/.claude/hooks/*.sh; do
  [ -e "$f" ] || continue
  nom=$(basename "$f")
  case " $HOOKS_ARCHIVES " in *" $nom "*) echo "$nom → ignoré (archivé)"; continue ;; esac
  d="$HOME/.claude/hooks/$nom"
  if [ -e "$d" ] && [ ! -L "$d" ]; then
    mv "$d" "$d.remplace-$horodatage"
    echo "$nom → fichier réel sauvegardé"
  fi
  [ "$DRY" = 0 ] && { rm -f "$d"; ln -s "$f" "$d"; }
  echo "$nom → lien"
done

# --- Non couvert par ce script, volontairement ---
#
# Le dépôt ~/dev/claude-config (privé) pose ses propres liens via son
# install.sh — CLAUDE.md, settings.json, observations/, ses hooks, et les
# 8 skills hors méthode (lint, wiki, caveman, pdf, slides, condense,
# firecrawl, task-observer).
#
# Versionnés nulle part, une machine neuve ne les récupérera pas :
#   ~/.claude/settings.local.json   (contient des secrets — hors dépôt à dessein)
#   ~/.claude/projects/*/memory/    (sauvegardés par ~/dev/claude-memoire)
#
# ATTENTION : claude-config/install.sh vise aussi ~/.claude/hooks/, comme la
# boucle ci-dessus. Les deux sauvegardent désormais avant de remplacer, donc
# le dernier lancé ne détruit plus rien. La fusion des deux installateurs en
# un seul point d'entrée est la phase 7 de migration-structure.md.
