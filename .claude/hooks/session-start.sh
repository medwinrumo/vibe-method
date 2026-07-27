#!/bin/bash
# Rappelle les rituels de démarrage définis dans ~/dev/CLAUDE.md
cat <<'JSON'
{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"RITUELS DE DEMARRAGE (~/dev/CLAUDE.md) — a faire maintenant, avant toute autre chose :\n1. Lire ~/dev/wiki/index.md (silencieusement) — le wiki est la premiere source a consulter, avant le web.\n2. Invoquer le skill task-observer si la session va utiliser des outils ou produire un livrable.\nSi tu choisis de ne PAS appliquer une de ces regles, dis-le a voix haute — une regle non appliquee en silence est un defaut invisible."}}
JSON
