#!/usr/bin/env python3
"""
Tests de scripts/lint-observabilite.py — 8 cas fixtures.
Cas A-D : découverts lors de la construction initiale (2026-07-28).
Cas E-H : trouvés par le sous-agent `code-reviewer` sur la version initiale
(regex de proximité au lieu de parsing du champ) — tous fail-open avant fix.

Usage : python3 scripts/test_lint_observabilite.py
Aucune dépendance externe (pas de pytest) — assertions simples, exit 1 si échec.
"""

import importlib.util
import sys
from pathlib import Path

SCRIPT_PATH = Path(__file__).parent / "lint-observabilite.py"
spec = importlib.util.spec_from_file_location("lint_observabilite", SCRIPT_PATH)
lint = importlib.util.module_from_spec(spec)
spec.loader.exec_module(lint)

CASES = {
    "A_ok_rempli": (
        "- **Observabilité** : Requise\n\n## Signaux à instrumenter\n- Combien de relances échouent ? → compteur relance_echec\n",
        False,
    ),
    "B_section_absente": (
        "- **Observabilité** : Requise\n\n## Definition of Done\n",
        True,
    ),
    "C_placeholder_liste": (
        "- **Observabilité** : Requise\n\n## Signaux à instrumenter\n- [question métier 1] → [signal : log/métrique correspondant]\n",
        True,
    ),
    "D_non_requise_ok": (
        "- **Observabilité** : Non requise (prototype ou hors prod)\n\n## Definition of Done\n",
        False,
    ),
    "E_placeholder_template_jamais_rempli": (
        "- **Observabilité** : [Requise / Non requise (prototype ou hors prod)]\n\n## Definition of Done\n",
        True,
    ),
    "F_champ_absent": (
        "## Contexte d'implémentation\n- Module : x\n\n## Definition of Done\n",
        True,
    ),
    "G_section_avec_seulement_guidage": (
        "- **Observabilité** : Requise\n\n## Signaux à instrumenter\n_(uniquement si Observabilité : Requise)_\n\n## Definition of Done\n",
        True,
    ),
    "H_non_requise_avec_residu_guidage": (
        "- **Observabilité** : Non requise (prototype ou hors prod)\n\n## Signaux à instrumenter\n_(uniquement si Observabilité : Requise)_\n\n## Definition of Done\n",
        False,
    ),
}


def run() -> int:
    failures = []
    for name, (content, should_fail) in CASES.items():
        tmp = Path(f"/tmp/test-lint-obs-{name}.spec.feature.md")
        tmp.write_text(content, encoding="utf-8")
        problems = lint.check_spec(tmp)
        tmp.unlink()

        got_fail = len(problems) > 0
        status = "OK" if got_fail == should_fail else "ÉCHEC"
        print(f"[{status}] {name} — attendu {'problème' if should_fail else 'silence'}, obtenu {problems or 'silence'}")
        if got_fail != should_fail:
            failures.append(name)

    print()
    if failures:
        print(f"{len(failures)}/{len(CASES)} cas en échec : {', '.join(failures)}")
        return 1
    print(f"{len(CASES)}/{len(CASES)} cas passent.")
    return 0


if __name__ == "__main__":
    sys.exit(run())
