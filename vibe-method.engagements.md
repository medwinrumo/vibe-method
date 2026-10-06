# vibe-method — Registre des engagements

> **Fichier d'entrée unique, en ajout seul.** Toute phrase du type « je commence par »,
> « à porter au X », « à reprendre quand », « à trancher » s'écrit **ici**, en une ligne,
> **dans le tour où elle est prononcée**. Même principe que `RAMrezo.engagements.md`
> (20/08/2026) et `claude-config.engagements.md` (21/08/2026). Créé le 08/09/2026 à la
> demande du hook `stop-engagements.sh`, qui exige un registre par projet.
>
> Portée : les engagements qui concernent **la méthode elle-même** — skills du wiki,
> doctrines, rapports de ce dépôt. Les engagements d'outillage (hooks, `claude-config`,
> mémoires) vont dans `claude-config.engagements.md` ; ceux d'un projet dans le registre
> de ce projet.
>
> Ce registre ne double pas `vibe-method.todo.md` : le todo porte l'état des chantiers,
> le registre porte les promesses faites en conversation, avec leur destination. Une
> ligne du registre peut pointer vers une ligne du todo.

| # | Engagement | Destination | Né le |
|---|---|---|---|
| E-3 | **Trancher la numérotation des règles de gestion dans le format A4 de `/specs`** — question posée à Medwin le 08/09/2026. Sans identifiant stable par règle, le contrôle de couverture croisée (E-1) n'a pas de clé pour relier règle ↔ scénario Gherkin ↔ issue. ***Tranché « oui » par Medwin et porté le 08/09/2026*** *— `specs.md` étapes 3 et 5 : `RG-nn` / `CL-nn` / `CE-nn` par feature, jamais réattribués, cités par tout ce qui en découle. **Reste** : faire citer ces identifiants dans `gherkin.md` Mode Specs et `to-issues.md` — porté dans E-1.* | `~/dev/wiki/specs.md` porté ; suite dans E-1 | 08/09/2026 |
| E-2 | **Écrire les décisions de `/angles-morts` dans l'artefact source, dans le tour** — annoncé le 08/09/2026 comme premier chantier (« je commence par le 3 »). ***Porté le 08/09/2026*** *— `angles-morts.md` étape 4 (mécanisme en trois gestes) et étape 3 (garde « l'énoncé, pas le comportement ») ; `workflow-doc.md` corrigé ; journal du wiki. Non commité dans le wiki à ce tour — voir E-4.* | `~/dev/wiki/angles-morts.md` porté | 08/09/2026 |
| E-1 | **Contrôle de couverture croisée règle ↔ Gherkin ↔ issue** — annoncé le 08/09/2026 comme second chantier, après E-2 et après la décision E-3 (les deux faites le 08/09). Cible : étape 8 de `readyTo-code.md`, rapport sur disque + résumé court en session. **Préalable intégré au chantier** : `gherkin.md` Mode Specs et `to-issues.md` doivent citer `RG-nn` / `CL-nn` / `CE-nn`, sinon la matrice n'a rien à croiser. Détail : `rapports/spec-kit-analyse.md` §3 point 1 ; ligne correspondante dans `vibe-method.todo.md`. | `~/dev/wiki/readyTo-code.md`, `gherkin.md`, `to-issues.md` | 08/09/2026 |
| E-4 | **Commiter les trois fiches du wiki modifiées le 08/09/2026** (`specs.md`, `angles-morts.md`, `workflow-doc.md`, index régénéré, `journal-log.md`) **et ce dépôt** (`rapports/spec-kit-analyse.md`, todo, ce registre). Opération à cheval sur deux dépôts : à commiter des deux côtés dans le même tour, message croisé (`conduite-de-chantier.md` §6). ***Porté le 09/09/2026 sur ordre de Medwin (« commit now »)*** *— wiki : commit `84ad89a` ; vibe-method : le commit qui contient cette ligne. Messages croisés. Pas de push : non demandé.* | `~/dev/wiki` (git) et `~/dev/vibe-method` (git) | 08/09/2026 |
| E-5 | **Projet TASTE reporté sans date** — Medwin, le 06/10/2026 : « on reprendra ça plus tard ». Première étape envisagée, non validée : compter les détours exploitables sur dix sessions passées. Claude ne relance pas le sujet de lui-même. | `vibe-method.todo.md`, rubrique « Projet TASTE » ; source `~/dev/wiki/taste-bench-rech.md` ; mémoire `project_taste.md` | 06/10/2026 |
| E-6 | **Ordre de la chaîne : la décision 1 attend la réponse de Medwin** — question posée le 06/10/2026 en fin de mesure des contradictions texte ↔ graphe : pour le tronçon architecture → roadmap, le bon ordre est-il celui du graphe ou celui du texte des skills ? Medwin a lancé `/maj` sans y répondre. Aucun skill ne se corrige avant sa réponse (sa consigne : « tu ne modifies pas les skills sans mon accord »). Les neuf autres contradictions suivent, une par une. | `vibe-method.todo.md`, rubrique « Ordre de la chaîne », bloc **Reprise** ; détail dans `rapports/contradictions-ordre-chaine-2026-10-06.md` | 2026-10-06 |
