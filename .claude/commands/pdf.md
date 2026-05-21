# /pdf — Génération de document PDF professionnel

Produit un fichier PDF propre et paginé depuis un contenu markdown ou HTML, via **weasyprint**. Applicable à tout type de document : proposition commerciale, CGV, rapport, document technique.

---

## Étape 0 — Cadrage

Poser ces questions avant toute génération, sauf si les réponses sont déjà dans le contexte :

1. "Quel est le document source ? (fichier .md existant, contenu à créer, ou HTML déjà rédigé)"
2. "Quel type de document ? (proposition commerciale, CGV, rapport, autre)"
3. "Y a-t-il un saut de page forcé attendu à un endroit précis ?"

Ne pas demander ce qui est déjà donné dans le contexte.

**Règle absolue de fidélité :** si le document source est un `.md` validé, le contenu est copié **verbatim** dans le HTML. Zéro reformulation, zéro amélioration silencieuse. Toute modification du contenu (pas de la mise en forme) doit être signalée explicitement et attendre un "go".

---

## Étape 1 — Vérification des dépendances

```bash
which weasyprint || echo "MANQUANT: brew install weasyprint"
```

Si weasyprint est absent : `brew install weasyprint` (installe automatiquement toutes les dépendances).

---

## Étape 2 — Création du fichier HTML

Créer `[nom].html` dans le dossier projet. Partir du template CSS ci-dessous — ne jamais partir de zéro.

### Template CSS de base

```html
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>[Titre du document]</title>
<style>

  /* ── Page ──────────────────────────────────────────────── */
  @page {
    size: A4;
    margin: 2.4cm 2.2cm 2.6cm 2.2cm;
    @bottom-right {
      content: "Page " counter(page) " / " counter(pages);
      font-size: 8pt;
      color: #aaa;
    }
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    font-size: 10.2pt;
    line-height: 1.55;
    color: #1a1a1a;
    background: #fff;
    padding: 2cm 2.2cm; /* écran uniquement */
  }

  @media print { body { padding: 0; } }

  /* ── Titres — toujours solidaires de leur contenu ─────── */
  h1 { font-size: 21pt; font-weight: 700; letter-spacing: -0.02em; }

  h2 {
    font-size: 12.5pt; font-weight: 700;
    margin: 1.8em 0 0.7em 0;
    padding-bottom: 0.35em;
    border-bottom: 1px solid #d0d0d0;
    page-break-after: avoid; /* insuffisant seul — toujours coupler avec .avoid-break */
  }

  h3 {
    font-size: 10.5pt; font-weight: 700;
    margin: 1.3em 0 0.4em 0;
    page-break-after: avoid;
  }

  h4 {
    font-size: 10pt; font-weight: 600; color: #333;
    margin: 1em 0 0.3em 0;
    page-break-after: avoid;
  }

  p { margin-bottom: 0.6em; }
  ul, ol { margin: 0.5em 0 0.8em 0; padding-left: 1.6em; }
  li { margin-bottom: 0.3em; }
  strong { font-weight: 700; }
  em { font-style: italic; color: #555; }

  /* ── Tableaux ───────────────────────────────────────────── */
  table { width: 100%; border-collapse: collapse; margin: 0.8em 0 1.2em 0; font-size: 9.5pt; }
  th {
    background: #f2f2f2; text-align: left;
    padding: 6px 10px; border: 1px solid #d0d0d0;
    font-weight: 600; font-size: 8.5pt;
    text-transform: uppercase; letter-spacing: 0.05em; color: #444;
  }
  td { padding: 7px 10px; border: 1px solid #e2e2e2; vertical-align: top; }
  tr:nth-child(even) td { background: #fafafa; }

  /* ── Boîte info ─────────────────────────────────────────── */
  .infobox {
    border: 1px solid #d8d8d8;
    border-left: 3px solid #1a1a1a;
    border-radius: 3px;
    padding: 0.8em 1.1em;
    background: #f7f7f7;
    margin: 0.8em 0;
    font-size: 9.5pt;
  }

  /* ── Note ───────────────────────────────────────────────── */
  .note { font-size: 9pt; color: #777; font-style: italic; margin-top: 0.3em; }

  /* ── Sauts de page ──────────────────────────────────────── */
  .page-break { page-break-before: always; }
  .avoid-break { page-break-inside: avoid; }

  /* ── Pied de document ───────────────────────────────────── */
  .doc-footer {
    margin-top: 2.5em; padding-top: 0.8em;
    border-top: 1px solid #eee;
    font-size: 8pt; color: #bbb; text-align: center;
  }

</style>
</head>
<body>

<!-- contenu ici -->

</body>
</html>
```

### Règles de structure HTML

**Layouts multi-colonnes (cover, tableaux de métadonnées) :** utiliser des `<table>` HTML sans bordure, jamais CSS Grid. WeasyPrint peut mal gérer `grid-column: 1 / -1` et auto-placement complexe.

```html
<!-- Correct — table HTML -->
<table style="width:100%; border-collapse:collapse;">
  <tr>
    <td style="width:50%; border:none; padding:0.3em 1em 0.3em 0; vertical-align:top">Colonne A</td>
    <td style="width:50%; border:none; padding:0.3em 0; vertical-align:top">Colonne B</td>
  </tr>
</table>

<!-- Interdit pour les layouts cover/meta -->
<!-- <div style="display:grid; grid-template-columns: 1fr 1fr"> -->
```

**Titres solidaires de leur contenu :** `page-break-after: avoid` seul est insuffisant — WeasyPrint l'ignore quand le bloc suivant est trop grand. Toujours envelopper le titre + son premier contenu dans un `div class="avoid-break"` :

```html
<!-- Correct -->
<div class="avoid-break">
  <h2>Titre de section</h2>
  <p>Premier paragraphe ou première liste.</p>
</div>
<p>Suite du contenu...</p>

<!-- Insuffisant -->
<h2>Titre de section</h2>   <!-- peut se retrouver seul en bas de page -->
<p>Premier paragraphe.</p>
```

**Sauts de page forcés :** ajouter `class="page-break"` sur le premier élément de la nouvelle page (généralement un `h2`) :

```html
<h2 class="page-break avoid-break-wrapper">Nouvelle section sur nouvelle page</h2>
```

Ou via un `div` vide entre deux sections :

```html
<div class="page-break"></div>
<h2>...</h2>
```

---

## Étape 3 — Génération

```bash
weasyprint [nom].html [nom].pdf
```

Ouvrir immédiatement après :

```bash
open [nom].pdf
```

---

## Étape 4 — QA obligatoire avant toute présentation

**Parcourir chaque page du PDF** et vérifier les points suivants avant de présenter le résultat à Medwin.

### Checklist page par page

- [ ] **Aucun titre seul en bas de page** — h2, h3, h4 doivent toujours être suivis d'au moins une ligne de contenu sur la même page
- [ ] **Aucun élément orphelin en haut d'une page** — dernier bullet d'une liste, dernière ligne d'un paragraphe isolé
- [ ] **Aucune grande zone blanche en bas d'une page** alors que le contenu correspondant commence en haut de la suivante → regrouper dans un `avoid-break`
- [ ] **Sauts de page cohérents avec la logique du document** — les sections importantes (tarifs, signature) commencent-elles au bon endroit ?
- [ ] **Numérotation visible** en bas à droite de chaque page
- [ ] **Tableaux non tronqués** — aucune ligne de tableau coupée entre deux pages
- [ ] **Contenu verbatim** si transposition depuis un `.md` — aucun mot reformulé

### Corrections

Corriger dans le HTML, regénérer, re-vérifier. Itérer jusqu'à ce que la checklist soit entièrement verte.

Ne jamais présenter un PDF sans avoir complété cette checklist.

---

## Règles absolues (non négociables)

| Règle | Pourquoi |
|---|---|
| `avoid-break` sur chaque titre + son premier contenu | `page-break-after: avoid` seul ignoré par WeasyPrint si le bloc suivant est trop grand |
| Jamais CSS Grid pour les layouts de couverture / métadonnées | WeasyPrint gère mal `grid-column: 1/-1` et l'auto-placement complexe |
| `@page @bottom-right` avec compteur dès le départ | WeasyPrint supporte le CSS Paged Media nativement — ne pas attendre que Medwin le demande |
| Contenu verbatim si source .md validé | Medwin ne peut pas détecter une reformulation silencieuse — ses documents doivent être fiables |
| QA page par page avant présentation | Les problèmes de mise en page sont visibles à l'œil — les trouver avant Medwin |

---

## Commandes de référence rapide

| Tâche | Commande |
|---|---|
| Vérifier weasyprint | `which weasyprint` |
| Installer weasyprint | `brew install weasyprint` |
| Générer le PDF | `weasyprint input.html output.pdf` |
| Générer + ouvrir | `weasyprint input.html output.pdf && open output.pdf` |
| Voir les warnings | `weasyprint input.html output.pdf 2>&1` |
