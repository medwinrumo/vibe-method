# /charte — Charte graphique du projet

Tu guides Medwin dans la définition de l'identité visuelle du projet. La charte graphique est la fondation du design system : tout ce qui sera dessiné dans Claude Design en découlera. Elle se définit une fois, en début de projet, avant le PRD et avant les maquettes.

Tu produis `[projet].charte.md` dans le répertoire courant du projet.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet** — demande si absent
2. **`[projet].brief.md`** — pour comprendre le produit, ses utilisateurs, son ambiance générale

Si le brief est absent → continuer quand même, mais poser davantage de questions contextuelles.

---

## Étape 1 — Logo

> "Est-ce que tu as déjà un logo pour ce projet ?"

- **Si oui** → demander de le déposer dans le repo sous `assets/logo.[ext]`. Prendre note du chemin. Continuer.
- **Si non** → noter dans la charte "Logo : à fournir". Continuer sans bloquer. Le logo sera intégré quand il sera disponible.

Le skill ne génère pas de logo. Medwin (ou le client) apporte le sien.

---

## Étape 2 — Références visuelles

> "Est-ce qu'il y a des apps, des sites, des produits dont tu aimes le design et qui pourraient servir de référence visuelle pour ce projet ?"

Collecter 2 à 5 références. Pour chacune, demander :
> "Qu'est-ce qui t'attire dans ce design ? (les couleurs, la typo, la densité, l'ambiance générale ?)"

Ces références serviront d'ancre pour toutes les décisions qui suivent.

---

## Étape 3 — Ambiance et personnalité

Tu poses les questions une par une.

**Personnalité du produit**
> "Si ce produit était une personne, comment tu le décrirais ? (sérieux, chaleureux, technique, ludique, élégant, accessible...)"

**Ambiance générale**
> "Quelle ambiance tu veux créer ? (moderne et épuré, chaleureux et humain, sérieux et institutionnel, dynamique et énergique, autre ?)"

**Ce qu'il ne faut surtout pas**
> "Y a-t-il une ambiance ou un style que tu veux éviter à tout prix ?"

---

## Étape 4 — Couleurs

**Couleur principale**
> "Est-ce qu'il y a une couleur imposée (couleur de marque, couleur client) ? Ou on part de zéro ?"

Si couleur imposée → noter le code hex ou la référence.
Si libre → demander :
> "Vers quoi tu te diriges ? (chaud/froid, vif/neutre, sombre/clair)"

**Couleurs secondaires et neutres**
> "Est-ce qu'il y a des couleurs à éviter absolument ?"

Tu proposes une palette cohérente à partir des réponses : couleur principale, couleur secondaire, neutres (gris clairs/foncés), couleurs d'état (succès vert, erreur rouge, avertissement orange, info bleu).
Medwin valide ou ajuste.

**Dark mode**
> "Est-ce que l'app doit supporter le dark mode ?"
- Oui (clair + sombre) / Non (clair uniquement) / Système (suit les préférences de l'OS)

---

## Étape 5 — Typographie

**Style**
> "Quel style de typographie ? (sans-serif neutre et lisible, serif classique et formel, monospace technique, autre ?)"

**Hiérarchie**
> "L'app est plutôt dense en texte (listes, tableaux, données) ou aérée (peu d'éléments par écran) ?"

Tu proposes une combinaison : une police principale pour le corps + une police secondaire pour les titres si nécessaire. Pour les apps natives, rappeler que SF Pro (iOS) et Roboto (Android) sont les polices système — les utiliser est recommandé pour l'intégration native.

Medwin valide.

---

## Étape 6 — Formes et style visuel

**Arrondis**
> "Tu préfères des formes angulaires (bordures nettes) ou arrondies (border-radius généreux) ?"

**Densité**
> "Interface aérée (beaucoup d'espace, peu d'éléments visibles) ou dense (maximum d'infos par écran) ?"

**Ombres et effets**
> "Des ombres portées et de la profondeur, ou un style plat (flat design) sans ombre ?"

**Animations**
> "Aucune animation / micro-interactions subtiles / transitions marquées ?"

---

## Étape 7 — Synthèse et validation

Tu produis un résumé de la charte :

> "Voici la charte graphique telle que je la comprends :
>
> - Logo : [fourni / à fournir]
> - Références visuelles : [liste]
> - Ambiance : [description]
> - Couleur principale : [hex] — Secondaire : [hex] — Neutres : [liste]
> - États : succès [hex], erreur [hex], avertissement [hex], info [hex]
> - Dark mode : [oui / non / système]
> - Typographie : [police(s) choisie(s)] — style [description]
> - Arrondis : [valeur border-radius]
> - Densité : [aérée / dense]
> - Ombres : [oui / non]
> - Animations : [aucune / subtiles / marquées]
>
> Est-ce que c'est bien ça ? On peut ajuster avant d'enregistrer."

---

## Étape 8 — Enregistrement

Tu écris `[projet].charte.md` dans le répertoire courant du projet.

```markdown
# Charte graphique — [Nom du projet]
_Définie le [date]_

## Logo
[Chemin vers le fichier / "À fournir"]

## Références visuelles
- [Référence 1] — ce qui attire : [description]
- [Référence 2] — ce qui attire : [description]

## Ambiance et personnalité
[Description]
Ce qu'on évite : [description]

## Palette de couleurs
- Principale : [hex] — [nom/rôle]
- Secondaire : [hex] — [nom/rôle]
- Neutres : [liste hex]
- Succès : [hex]
- Erreur : [hex]
- Avertissement : [hex]
- Info : [hex]

## Dark mode
[Oui — clair + sombre / Non — clair uniquement / Système]

## Typographie
- Corps : [police] — [style]
- Titres : [police si différente]
- Densité : [aérée / dense]

## Style visuel
- Arrondis : [valeur border-radius en px]
- Ombres : [oui / non]
- Animations : [aucune / subtiles / marquées]
```

Confirmer : "Charte sauvegardée → `[projet].charte.md`. Cette charte servira de fondation au design system dans `/design`."

---

## Règles

- Ne pas générer de logo — le demander, noter "à fournir" si absent.
- Ne pas décider seul des couleurs — proposer, Medwin valide.
- La charte est le socle commun à toutes les surfaces du projet (site vitrine + app + interface admin). Elle doit être cohérente sur toutes les plateformes.
- Si le projet est un SaaS B2B, noter que le client pourra avoir sa propre charte — la fonctionnalité de personnalisation (logo, couleurs client) est une feature produit à définir dans les specs, pas dans cette charte.

---

## Prochaine étape

`/design` Mode A — la charte est posée, construire le design system complet pour Claude Design.

> **[RÉVISION 2026-05-15]**
> Avant de lancer `/design` Mode A, rappeler à Medwin l'existence de `ui-vocabulary.md` dans vibe-method :
> "Pour nommer précisément les zones, composants et états que tu veux dans tes écrans, consulte `ui-vocabulary.md` — c'est le lexique de référence avec des ASCII arts illustratifs."
