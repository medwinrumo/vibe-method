#!/bin/bash
# setup.sh — Recrée les symlinks ~/.claude/commands/ → vibe-method/.claude/commands/
# À lancer après un git clone sur une nouvelle machine.
#
# ⚠️ CE SCRIPT ÉCRASE. `ln -sf` remplace sans prévenir un fichier réel présent
# dans ~/.claude/commands/ portant le même nom qu'un fichier de vibe-method.
# Vécu le 2026-07-29 : grill-me.md existait en fichier réel (non versionné) et
# a été remplacé par le symlink, sans backup possible.
# Avant de le lancer sur une machine déjà configurée :
#   find ~/.claude/commands ~/.claude/hooks ~/.claude/agents -maxdepth 1 -type f
# Tout ce qui remonte est un fichier réel — le sauvegarder d'abord s'il n'existe
# pas déjà à l'identique dans vibe-method.

VIBE=~/dev/vibe-method/.claude/commands
TARGET=~/.claude/commands

mkdir -p $TARGET

for f in $VIBE/*.md; do
  filename=$(basename $f)
  ln -sf $f $TARGET/$filename
  echo "$filename → symlink créé"
done

# Symlink CLAUDE.md global
ln -sf ~/dev/vibe-method/CLAUDE.global.md ~/dev/CLAUDE.md
echo "CLAUDE.md global → symlink créé"

echo "Setup terminé — $(ls $TARGET | wc -l | tr -d ' ') skills liés."

# --- Hooks de session (ajout 2026-07-27) ---
# Boucle sur le glob et non sur une liste en dur : une liste nommée prend du
# retard en silence (track-agent-usage.sh, ajouté le 2026-07-28, manquait ici).
# Revers du glob : il ramasse aussi les scripts archivés — d'où l'exclusion
# explicite ci-dessous, à tenir à jour quand un hook est retiré de settings.json.
HOOKS_ARCHIVES="doubt-commit-reminder.sh"   # testé et abandonné (observation 9)

mkdir -p ~/.claude/hooks
for f in ~/dev/vibe-method/.claude/hooks/*.sh; do
  [ -e "$f" ] || continue
  nom=$(basename "$f")
  case " $HOOKS_ARCHIVES " in
    *" $nom "*) echo "$nom → ignoré (archivé)" ; continue ;;
  esac
  ln -sf "$f" ~/.claude/hooks/"$nom"
  echo "$nom → symlink créé"
done
echo "Hooks de session liés."

# --- Agents / personas (ajout 2026-07-29) ---
# Étaient symlinkés à la main depuis le 2026-07-28, donc perdus sur une
# machine neuve. Même logique de glob que les hooks.
mkdir -p ~/.claude/agents
for f in ~/dev/vibe-method/.claude/agents/*.md; do
  [ -e "$f" ] || continue
  ln -sf "$f" ~/.claude/agents/$(basename "$f")
  echo "$(basename "$f") → symlink créé"
done
echo "Agents liés."

# --- Non couvert par ce script (volontairement, en attente de la session
# d'architecture sur la frontière contenu / infrastructure) ---
# Ces fichiers vivent dans ~/.claude/ et ne sont versionnés nulle part :
#   ~/.claude/skills/task-observer/SKILL.md
#   ~/.claude/observations/log.md
#   ~/.claude/commands/grill-me.md, firecrawl.md   (fichiers réels, pas des symlinks)
#   ~/.claude/CLAUDE.md, settings.json, settings.local.json
#   ~/.claude/projects/*/memory/
# Une machine neuve ne les récupérera pas. Voir vibe-method.todo.md.
