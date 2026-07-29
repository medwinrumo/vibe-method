#!/bin/bash
# Rituels de démarrage (~/dev/CLAUDE.md).
#
# task-observer n'est PAS annoncé comme un skill à invoquer : son contenu est
# injecté directement ci-dessous. Raison — le rappel « invoque le skill » a été
# ignoré deux sessions de suite (28 et 29/07/2026). Un rappel en prose dépend de
# la discipline du modèle au moment où une demande urgente arrive ; une
# instruction déjà présente dans le contexte ne dépend de rien.
#
# Le skill continue d'exister comme skill (invocable à la demande, review via
# /maj). Cette injection garantit seulement qu'il est actif dès le premier
# token, sans étape intermédiaire.
python3 - <<'PY'
import json, pathlib

rituels = (
    "RITUELS DE DEMARRAGE (~/dev/CLAUDE.md) — a faire maintenant, avant toute autre chose :\n"
    "1. Lire ~/dev/wiki/index.md (silencieusement) — le wiki est la premiere source "
    "a consulter, avant le web.\n"
    "Si tu choisis de ne PAS appliquer cette regle, dis-le a voix haute — une regle "
    "non appliquee en silence est un defaut invisible."
)

parts = [rituels]

skill = pathlib.Path.home() / ".claude/skills/task-observer/SKILL.md"
try:
    contenu = skill.read_text(encoding="utf-8")
except OSError:
    # Skill absent ou illisible : ne pas empecher la session de demarrer, mais
    # le signaler — sinon l'observation s'arrete en silence.
    parts.append(
        "AVERTISSEMENT : le skill task-observer est introuvable a "
        f"{skill}. Les frictions de cette session ne seront pas capturees. "
        "Le signaler a Medwin."
    )
else:
    parts.append(
        "OBSERVATION ACTIVE POUR TOUTE LA SESSION — ne pas invoquer le skill "
        "task-observer, ses instructions sont ci-dessous et s'appliquent des "
        "maintenant. Logger au fil de l'eau, dans le tour ou la friction arrive : "
        "le contexte peut etre compacte a tout moment, et ce qui n'est pas ecrit "
        "sur disque est perdu.\n\n"
        "----- debut task-observer/SKILL.md -----\n"
        + contenu
        + "\n----- fin task-observer/SKILL.md -----"
    )

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": "\n\n".join(parts),
    }
}))
PY
