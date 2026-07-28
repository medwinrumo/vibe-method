#!/usr/bin/env python3
"""
lint-observabilite.py — Pre-Launch Gate observabilité (doctrine observabilite.md).

Vérifie que chaque fichier `[projet].spec.*.md` marqué "Observabilité : Requise"
contient une section "## Signaux à instrumenter" non vide (pas de placeholder
"[question métier" laissé tel quel).

Usage : python3 lint-observabilite.py [chemin-projet]
Sortie : rapport texte sur stdout. Exit code 1 si au moins une spec est en défaut,
0 sinon (y compris si aucune spec trouvée).
"""

import re
import sys
from pathlib import Path

REQUIRED_MARK = re.compile(r"Observabilit[ée]\s*:?\**\s*:?\s*Requise", re.IGNORECASE)
SECTION_HEADER = re.compile(r"^##\s+Signaux à instrumenter", re.IGNORECASE | re.MULTILINE)
PLACEHOLDER = re.compile(r"\[question métier|\[signal\s*:", re.IGNORECASE)


def check_spec(path: Path) -> list[str]:
    text = path.read_text(encoding="utf-8", errors="ignore")
    problems = []

    if not REQUIRED_MARK.search(text):
        return problems  # pas prod-critique, rien à vérifier

    match = SECTION_HEADER.search(text)
    if not match:
        problems.append("marquée 'Observabilité : Requise' mais aucune section '## Signaux à instrumenter'")
        return problems

    # Contenu de la section jusqu'au prochain '##' ou fin de fichier
    section_start = match.end()
    next_header = re.search(r"^##\s", text[section_start:], re.MULTILINE)
    section_body = text[section_start: section_start + next_header.start()] if next_header else text[section_start:]

    stripped = section_body.strip()
    if not stripped:
        problems.append("section 'Signaux à instrumenter' présente mais vide")
    elif PLACEHOLDER.search(stripped):
        problems.append("section 'Signaux à instrumenter' contient encore un placeholder non rempli")

    return problems


def main() -> int:
    root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(".")
    specs = sorted(root.rglob("*.spec.*.md"))

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
