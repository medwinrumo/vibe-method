---
type: flux
source: ../CLAUDE.md
source_modified: 2026-07-28
wiki_updated: 2026-08-05
tags: [workflow, chaîne, navigation]
---

# Chaîne complète des skills

La chaîne de gauche à droite. Chaque skill produit un artefact consommé par le suivant.

---

## AVANT — Phases 1 à 4

### Phase 0 — Contexte (si projet client)
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/contexte]] | Notes réunion, emails | `[projet].context.md` | Optionnel — si contexte riche à capturer |

### Phase 1 — Produit
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/brief]] | Intention | `[projet].brief.md` | 9 domaines, brainstorming anti-biais |
| [[skills/devis]] | Brief | `[projet].proposition.md` | Optionnel — si projet client |
| [[skills/cgv]] | Brief + contexte | `[projet].cgv.md` | Optionnel — si projet client |
| [[skills/prd]] | Brief | `[projet].prd.md` | Dialogue V1 — cross-pollination IA |
| [[skills/prd-update]] | PRD V1 + retours | `[projet].prd.md` V2 | Intègre les critiques croisées |
| [[skills/prd-validate]] | PRD V2 | — (rapport GO/BLOCKERS) | Gate — 8 zones à valider avant /archi |
| [[skills/gherkin]] | PRD (Mode PRD) | Zones floues révélées | Révèle les ambiguïtés du PRD |

### Phase 2 — Design
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/charte]] | Brief | `[projet].charte.md` | Couleurs, typo, logo, ambiance |
| [[skills/design]] | Charte + PRD (Mode A) | `[projet].design.md` | Aller-retour avec /archi |
| ↔ [[skills/archi]] | PRD + Design | `[projet].archi.md` | Phase itérative jusqu'à cohérence |
| Claude Design | `[projet].design.md` | HTML/CSS/JS | Outil externe (claude.ai/design) |
| [[skills/design]] Mode B | HTML/CSS/JS | Tailwind / NativeWind | Intégration dans la stack |

### Phase 3 — Architecture (en aller-retour avec Phase 2)
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/archi]] | PRD + Design | `[projet].archi.md` + `CLAUDE.md` | Modules, silos, stack, sécurité |
| [[skills/regles]] | Archi + codebase | `[projet].regles.md` | Règles non-évidentes pour l'IA |
| [[skills/adr]] | Décision structurante | `[projet].adr.md` | Déclenché par /archi ou /specs |

### Phase 4 — Stack
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/stack]] | Archi | `[projet].stack.md` | Spike technique — free tiers, gotchas |

---

## PENDANT — Phases 5 à 6

### Phase 5 — Planification
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/roadmap]] | PRD + Design + Archi | `[projet].Rmap.md` | Découpage en features parallélisables |
| [[skills/specs]] | PRD + feature | `[projet].spec.[feature].md` | User story auto-contenue (format A4) |
| [[skills/gherkin]] | Specs (Mode Specs) | `[projet].gherkin.[feature].md` | Scénarios complets |
| [[skills/to-issues]] | Specs + Roadmap | Issues GitHub | Découpage HITL/AFK |

### Gates de démarrage
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/readyTo-code]] | PRD + Archi + Specs + PRP | — (rapport) | Gate — vérifie la complétude |
| [[skills/setup]] | Archi + Stack | Repo initialisé | Bootstrap technique |
| [[skills/prp]] | Tous les artefacts | `[projet].prp.md` | Contexte condensé pour sessions IA |
| [[skills/avancement]] | Roadmap | `[projet].avancement.yaml` | Init du tracker de features |

### Phase 6 — Code
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/sessionCode]] | PRP + Spec | — (contexte chargé) | Sas obligatoire avant chaque session |
| [code] | Spec + Archi | Features codées | Mode TDD (métier/sécu) ou Standard (UI/tech) |

---

## APRÈS — Phase 7

### Quality Chain (après chaque feature)
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/code-review]] | Code | — (rapport) | Structurel + sécurité — bloquant si critique |
| [[skills/code-review-edge-cases]] | Code | — (énumération) | Chasse aux cas non gérés |
| [[skills/repair-edge-cases]] | Code + edge cases | — (corrections) | Traitement un par un |
| [[skills/code-review-hostil]] | Code | — (10+ problèmes) | Revue cynique — assume le code cassé |
| [[skills/tests]] | Spec + Code | Tests (Vitest + Playwright) | TDD ou Standard |
| [[skills/securite]] | Code + Archi | — (rapport sécu) | Bloquant si point en échec |
| [[skills/doc-tech]] Mode B | Code | JSDoc / TSDoc | Annotations dans le code |
| [[skills/recette]] | User Stories + Gherkin | `[projet].recette.md` | Validation manuelle Medwin |
| [[skills/debug]] | Bug rapporté | — | Déclenché par /recette |
| [[skills/diagnose]] | Bug difficile | — | Escalade de /debug |

### Fin de phase
| Skill | Input | Output | Note |
|---|---|---|---|
| [[skills/phase-retrospective]] | Log + métriques | `[projet]-retrospective.md` | Léger (fin phase) ou Complet (fin ensemble) |
| [[skills/doc-tech]] Mode A | Codebase | `[projet].doc-tech.md` | Vue d'ensemble développeur |
| [[skills/refacto]] | Module dégradé | Code refactorisé | Session dédiée obligatoire |

---

## Skills transversaux (invocables à tout moment)

| Skill | Quand |
|---|---|
| [[skills/party]] | Décision structurante — multi-perspectives en parallèle |
| [[skills/impact]] | Avant tout changement — analyse d'impact sur les artefacts |
| [[skills/grill-me]] | Stress-test d'un plan — interrogatoire systématique |
| [[skills/zoom-out]] | Désorientation dans un fichier — carte du module courant |
| [[skills/prototype]] | Décision impossible à trancher sans la voir tourner |
| [[skills/askme]] | Questions contextuelles rapides — AskUserQuestion raccourci |
| [[skills/diagnostic-serveur]] | Serveur/conteneur qui se comporte mal — pendant infra de /diagnose |

---

## Skills de session (clôture et suivi)

| Skill | Quand |
|---|---|
| [[skills/maj]] | Clôture de session — Git + GH Projects |
| [[skills/todo]] | Début de session — sync GH Projects |
| [[skills/majtodo]] | Mise à jour de `[projet].todo.md` |
| [[skills/checkpoint]] | Documentation intermédiaire en cours de session |
| [[skills/handoff]] | Ancre de contexte mid-session |
| [[skills/log]] | Mise à jour `[projet].log.md` |
| [[skills/peda]] | Mise à jour `[projet].peda.md` + glossaire |
| [[skills/doc]] | Mise à jour `[projet].doc.md` |
| [[skills/spec]] | Mise à jour `[projet].spec-global.md` |

---

## Artefacts produits

| Artefact | Skill producteur | Consommateurs |
|---|---|---|
| `[projet].brief.md` | [[skills/brief]] | /prd, /devis, /archi |
| `[projet].prd.md` | [[skills/prd]], [[skills/prd-update]] | /prd-validate, /archi, /roadmap, /specs |
| `[projet].archi.md` + `CLAUDE.md` | [[skills/archi]] | /prp, /sessionCode, /specs |
| `[projet].design.md` | [[skills/design]] Mode A | Claude Design |
| `[projet].stack.md` | [[skills/stack]] | /roadmap, /specs, /prp |
| `[projet].Rmap.md` | [[skills/roadmap]] | /sessionCode, /to-issues |
| `[projet].spec.[feature].md` | [[skills/specs]] | /prp, /sessionCode, /tests |
| `[projet].prp.md` | [[skills/prp]] | /sessionCode |
| `[projet].avancement.yaml` | [[skills/avancement]] | /sessionCode, /maj |
| `[projet].recette.md` | [[skills/recette]] | validation manuelle |
| `[projet].doc-tech.md` | [[skills/doc-tech]] Mode A | équipe dev |
| `[projet]-retrospective.md` | [[skills/phase-retrospective]] | phase suivante |
| `[projet].adr.md` | [[skills/adr]] | équipe, mémoire architecture |
| `[projet].refacto-dette.md` | [[skills/refacto]] | /sessionCode |
