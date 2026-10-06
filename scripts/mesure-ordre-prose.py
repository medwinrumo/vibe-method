#!/usr/bin/env python3
"""Mesure en lecture seule : la prose des skills et doctrines contredit-elle le graphe `apres` ?
N'écrit rien dans le wiki. Sortie détaillée dans le fichier passé en argument."""
import importlib.util, os, re, sys, collections
WIKI = os.path.expanduser("~/dev/wiki"); OUT = sys.argv[1]
spec = importlib.util.spec_from_file_location("lint_wiki", os.path.join(WIKI, "scripts/lint-wiki.py"))
lint = importlib.util.module_from_spec(spec); spec.loader.exec_module(lint)
linter = lint.WikiLinter(WIKI); linter.load()
chaine = (linter.lint().get("axe6_methode") or {}).get("chaine") or []

fiches = {}
for nom in sorted(os.listdir(WIKI)):
    if not nom.endswith(".md"): continue
    txt = open(os.path.join(WIKI, nom), encoding="utf-8").read()
    fm, body = lint.parse_frontmatter(txt)
    fiches[nom[:-3]] = (fm or {}, txt)
skills = {n: fm for n, (fm, _) in fiches.items() if fm.get("claude-code") == "commande"}
agents = {n for n, (fm, _) in fiches.items() if fm.get("claude-code") == "agent"}
doctrines = [n for n in fiches if n.endswith("-doc")]

# graphe, même logique que _chaine_derivee
noeuds = {}
for nom, fm in skills.items():
    modes = {k: v for k, v in (fm.get("modes") or {}).items() if isinstance(v, dict)}
    if modes:
        for m, sous in modes.items(): noeuds[f"{nom}.{m}"] = list(sous.get("apres") or [])
    else: noeuds[nom] = list(fm.get("apres") or [])
base = lambda n: n.split(".")[0]
aretes = set()            # (base_pre, base_suiv)
for n, pres in noeuds.items():
    for p in pres:
        if not p.startswith(":"): aretes.add((base(p), base(n)))
# passage par `:code`
for n, pres in noeuds.items():
    if ":code" in pres:
        aretes.add(("tests", base(n))) if "tests.TDD" in noeuds else aretes.add(("sessionCode", base(n)))
pos = collections.defaultdict(list)
for i, n in enumerate(chaine):
    if not n.startswith(":"): pos[base(n)].append(i)

def classe(a, b):
    if a == b: return None
    if (a, b) in aretes: return "CONCORDANT"
    if a not in pos or b not in pos: return "HORS-CHAINE"
    if min(pos[a]) < max(pos[b]) and not (max(pos[b]) < min(pos[a])):
        if max(pos[a]) < min(pos[b]) or any(x < y for x in pos[a] for y in pos[b]):
            # ordre compatible ; inversion stricte seulement si b est toujours avant a
            pass
    if max(pos[b]) < min(pos[a]): return "INVERSION"
    if (b, a) in aretes and not any(x < y for x in pos[a] for y in pos[b]): return "INVERSION"
    return "RACCOURCI" if any(x < y for x in pos[a] for y in pos[b]) else "INVERSION"

noms = sorted(skills, key=len, reverse=True)
MENTION = re.compile(r"(?<![\w./~-])/(" + "|".join(map(re.escape, noms)) + r")(?![\w-])")
SUITE = re.compile(r"étape suivante|prochaine étape|suite\s*:|ensuite|enchaîn|passer à|puis lancer|lancer ensuite|proposer de lancer|on passe|suivant\s*:", re.I)
AVANT = re.compile(r"après `?/|prérequis|pré-requis|à lancer après|doit (déjà )?(avoir|exister)|issu de `?/|produit par `?/|vient après|suit `?/", re.I)

res = []   # (classe, type, fichier, ligne, a, b, texte)
for nom in sorted(list(skills) + doctrines):
    fm, txt = fiches[nom]
    lignes = txt.split("\n")
    dans_bloc = False; fin_fm = 0; sujet = nom if nom in skills else None
    if txt.startswith("---\n"): fin_fm = txt[4:].split("\n---\n")[0].count("\n") + 2
    for i, l in enumerate(lignes, 1):
        if i <= fin_fm: continue
        if "chaine-derivee:debut" in l: dans_bloc = True
        if "chaine-derivee:fin" in l: dans_bloc = False; continue
        if dans_bloc: continue
        ms = list(MENTION.finditer(l))
        if nom not in skills and l.startswith("#"):
            hs = {m.group(1) for m in ms}
            sujet = hs.pop() if len(hs) == 1 else None
        if not ms: continue
        t = l.strip()[:230]
        # A. flèches sur une même ligne
        for m1, m2 in zip(ms, ms[1:]):
            entre = l[m1.end():m2.start()]
            if "→" in entre and len(entre) < 60:
                c = classe(m1.group(1), m2.group(1))
                if c: res.append((c, "fleche", nom, i, m1.group(1), m2.group(1), t))
        if l.startswith("#") or not sujet: continue
        autres = [m.group(1) for m in ms if m.group(1) != sujet]
        fleche_ligne = any("→" in l[a.end():b.start()] for a, b in zip(ms, ms[1:]))
        if fleche_ligne: continue
        if SUITE.search(l):
            for z in dict.fromkeys(autres):
                c = classe(sujet, z)
                if c: res.append((c, "suite", nom, i, sujet, z, t))
        elif AVANT.search(l):
            for x in dict.fromkeys(autres):
                c = classe(x, sujet)
                if c: res.append((c, "avant", nom, i, x, sujet, t))

ordre = {"INVERSION": 0, "RACCOURCI": 1, "HORS-CHAINE": 2, "CONCORDANT": 3}
res.sort(key=lambda r: (ordre[r[0]], r[2], r[3]))
with open(OUT, "w", encoding="utf-8") as f:
    for c, ty, nom, i, a, b, t in res:
        f.write(f"{c}\t{ty}\t{nom}.md:{i}\t/{a} → /{b}\t{t}\n")
cpt = collections.Counter(r[0] for r in res)
print(f"skills {len(skills)} · agents {len(agents)} · doctrines {len(doctrines)} · chaîne {len(chaine)} étapes · arêtes {len(aretes)}")
print("affirmations d'ordre relevées dans la prose :", len(res), dict(cpt))
for c in ("INVERSION", "RACCOURCI", "HORS-CHAINE"):
    par = collections.Counter(r[2] for r in res if r[0] == c)
    print(f"{c} — {len(par)} fichiers :", ", ".join(f"{k}({v})" for k, v in par.most_common()))
print("skills de la chaîne sans aucune affirmation relevée :", ", ".join(sorted(n for n in pos if not any(r[2] == n for r in res))))
