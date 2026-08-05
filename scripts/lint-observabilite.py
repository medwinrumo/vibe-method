#!/usr/bin/env python3
"""
lint-observabilite.py — Pre-Launch Gate observabilité (doctrine ~/dev/wiki/observabilite-doc.md).

Vérifie que chaque fichier `[projet].spec.*.md` a un champ "Observabilité"
explicite (Requise / Non requise) et, si Requise, une section
"## Signaux à instrumenter" réellement remplie.

Dépendance croisée : le format du champ et de la section suit le template
défini dans `.claude/commands/specs.md` (Étape 4c-ter, ~lignes 190-250).
Si ce template change de formulation, revérifier les regex ci-dessous.

Fail-closed : un champ absent ou dont la valeur n'est ni clairement
"Requise" ni "Non requise" est traité comme un problème, pas comme un
laissez-passer — corrigé après revue par le sous-agent `code-reviewer`
(2026-07-28) qui avait trouvé 4 cas de fail-open sur la version précédente.

Usage : python3 lint-observabilite.py [chemin-projet]
Sortie : rapport texte sur stdout. Exit code 1 si au moins une spec est en défaut,
0 sinon (y compris si aucune spec trouvée).
"""

import re
import sys
from pathlib import Path

VENDOR_DIRS = {"node_modules", ".git", "__pycache__", ".venv", "venv", "dist", "build"}

FIELD = re.compile(r"Observabilit[ée]\s*\*{0,2}\s*:\s*(.+)")
SECTION_HEADER = re.compile(r"^##\s+Signaux à instrumenter", re.IGNORECASE | re.MULTILINE)
GUIDANCE_LINE = re.compile(r"_\(uniquement si Observabilit[ée]\s*:\s*Requise\)_", re.IGNORECASE)
PLACEHOLDER = re.compile(r"\[question métier|\[signal\s*:", re.IGNORECASE)


def classify_field(text: str) -> tuple[str, str]:
    """Retourne (statut, valeur_brute). Statut : requise / non_requise / indetermine / absent."""
    match = FIELD.search(text)
    if not match:
        return "absent", ""
    value = re.sub(r"\*+$", "", match.group(1)).strip()
    if re.match(r"non\s+requise", value, re.IGNORECASE):
        return "non_requise", value
    if re.match(r"requise\b", value, re.IGNORECASE):
        return "requise", value
    return "indetermine", value


def check_spec(path: Path) -> list[str]:
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return [f"encodage non-UTF-8 détecté — fichier ignoré, à corriger manuellement"]

    problems: list[str] = []
    status, value = classify_field(text)

    if status == "absent":
        problems.append("champ 'Observabilité' absent — l'Étape 4c-ter de /specs n'a peut-être jamais été appliquée")
        return problems
    if status == "indetermine":
        problems.append(f"champ 'Observabilité' présent mais valeur indéterminée (ni 'Requise' ni 'Non requise') : '{value}'")
        return problems
    if status == "non_requise":
        return problems  # rien à vérifier, cas normal

    # status == "requise"
    match = SECTION_HEADER.search(text)
    if not match:
        problems.append("marquée 'Observabilité : Requise' mais aucune section '## Signaux à instrumenter'")
        return problems

    section_start = match.end()
    next_header = re.search(r"^##\s", text[section_start:], re.MULTILINE)
    section_body = text[section_start: section_start + next_header.start()] if next_header else text[section_start:]

    # Retirer la ligne de guidage du template avant de juger si la section est remplie
    section_body = GUIDANCE_LINE.sub("", section_body)
    stripped = section_body.strip()

    if not stripped:
        problems.append("section 'Signaux à instrumenter' présente mais vide")
    elif PLACEHOLDER.search(stripped):
        problems.append("section 'Signaux à instrumenter' contient encore un placeholder non rempli")

    return problems


def main() -> int:
    root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")
    specs = sorted(
        p for p in root.rglob("*.spec.*.md")
        if not any(part in VENDOR_DIRS for part in p.parts)
    )

    if not specs:
        print(f"Aucun fichier *.spec.*.md trouvé sous {root}")
        return 0

    total_problems = 0
    for spec in specs:
        problems = check_spec(spec)
        if problems:
            total_problems += len(problems)
            print(f"❌ {spec}")
            for p in problems:
                print(f"   - {p}")

    if total_problems == 0:
        print(f"✅ {len(specs)} spec(s) vérifiée(s) — observabilité OK")
        return 0

    print(f"\n{total_problems} problème(s) — corriger avant /deploy.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
