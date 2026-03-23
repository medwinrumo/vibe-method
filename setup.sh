#!/bin/bash
# setup.sh — Recrée les symlinks ~/.claude/commands/ → vibe-method/.claude/commands/
# À lancer après un git clone sur une nouvelle machine.

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
