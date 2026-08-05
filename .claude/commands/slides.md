---
description: Crée, édite ou inspecte des présentations .pptx via pptxgenjs ou python-pptx
---

# /slides — Génération de présentation PPTX

Tu crées, édites ou inspectes des fichiers `.pptx` via `pptxgenjs` (création from scratch) ou `python-pptx` (édition d'un fichier existant).

---

## Étape 0 — Cadrage

Poser ces questions avant toute génération, sauf si les réponses sont déjà dans le contexte :

1. "Quel est le sujet de la présentation et à qui s'adresse-t-elle ?"
2. "Combien de slides ? Tu as un plan ou je le propose ?"
3. "Tu as un fichier `.pptx` existant à modifier, ou on part de zéro ?"
4. "Format : 16:9 (défaut) ou 4:3 ?"

Ne pas demander ce qui est déjà donné. Passer directement à la génération si le contexte est clair.

---

## Étape 1 — Vérification des dépendances

Avant toute génération, vérifier que les outils sont disponibles :

```bash
which node    || echo "MANQUANT: node"
node -e "require('pptxgenjs')" 2>/dev/null || echo "MANQUANT: npm install -g pptxgenjs"
which soffice || echo "MANQUANT: brew install libreoffice"
which pdftoppm || echo "MANQUANT: brew install poppler"
python3 -c "from pptx import Presentation" 2>/dev/null || echo "MANQUANT: pip install python-pptx"
```

Si un outil manque, le signaler à Medwin avant de continuer.

---

## Étape 2 — Génération

### Création from scratch (pptxgenjs)

```javascript
const pptx = new PptxGenJS();

// Dimensions
pptx.layout = 'LAYOUT_WIDE'; // 16:9 — 33.87 x 19.05 cm (13.33" x 7.5")

// Thème global
pptx.theme = { headFontFace: 'Georgia', bodyFontFace: 'Calibri' };

const slide = pptx.addSlide();

// Fond (toujours en premier — z-order)
slide.addShape(pptx.ShapeType.rect, {
  x: 0, y: 0, w: '100%', h: '100%',
  fill: { color: '1E2761' }
});

// Texte
slide.addText('Titre', {
  x: 0.5, y: 0.3, w: 12.3, h: 1.2,
  fontSize: 40, bold: true, color: 'FFFFFF',
  fontFace: 'Georgia'
});

// Image
slide.addImage({ path: './assets/logo.png', x: 11, y: 0.3, w: 2, h: 0.8 });

await pptx.writeFile({ fileName: 'output.pptx' });
```

**Unités :** toutes les mesures en pouces (inches). Marges min : 0.5". Espacement entre blocs : 0.3" min.

**Z-order :** éléments empilés dans l'ordre d'ajout — fonds en premier, texte en dernier.

### Édition d'un fichier existant (python-pptx)

```python
from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor

prs = Presentation('input.pptx')

for slide in prs.slides:
    for shape in slide.shapes:
        if shape.has_text_frame:
            for para in shape.text_frame.paragraphs:
                for run in para.runs:
                    print(run.text)

prs.save('output.pptx')
```

### Inspecter le XML brut

```bash
unzip -p input.pptx ppt/slides/slide1.xml
```

---

## Design — Règles obligatoires

### Palette — choisir avant de commencer

Ne pas defaulter sur bleu générique. Choisir une palette cohérente avec le sujet.

| Nom | Primaire | Secondaire | Accent |
|-----|----------|------------|--------|
| Midnight Executive | `1E2761` | `CADCFC` | `FFFFFF` |
| Forest & Moss | `2C5F2D` | `97BC62` | `F5F5F5` |
| Coral Energy | `F96167` | `F9E795` | `2F3C7E` |
| Warm Terracotta | `B85042` | `E7E8D1` | `A7BEAE` |
| Ocean Gradient | `065A82` | `1C7293` | `21295C` |
| Charcoal Minimal | `36454F` | `F2F2F2` | `212121` |
| Cherry Bold | `990011` | `FCF6F5` | `2F3C7E` |

Règle : 60-70% couleur dominante, 1 couleur secondaire, 1 accent. Structure "sandwich" : slide titre + conclusion sur fond sombre, contenu sur fond clair.

### Typographie

| Élément | Taille | Style |
|---------|--------|-------|
| Titre de slide | 36–44pt | Bold |
| En-tête de section | 20–24pt | Bold |
| Corps de texte | 14–16pt | Regular |
| Légendes | 10–12pt | Muted |

Pairings : Georgia / Calibri — Arial Black / Arial — Trebuchet MS / Calibri.

### Layouts — varier, jamais deux fois de suite le même

- Deux colonnes (texte gauche, visuel droit)
- Icône + texte en lignes (icône en cercle coloré, header bold, description)
- Grille 2x2 ou 2x3
- Image demi-slide avec overlay texte
- Callout chiffre clé (60–72pt) avec label sous le nombre
- Timeline ou process flow numéroté

### Motif visuel

Définir UN motif répété sur toutes les slides (ex : coins arrondis, icônes en cercles colorés, bordure épaisse sur un côté).

### Images — règles obligatoires

**1. Toujours respecter le ratio source.**
Récupérer les dimensions réelles de l'image avant de l'insérer (`sips -g pixelWidth -g pixelHeight`), puis calculer `h` à partir de `w` (ou inversement) :
```
h = w * (pixelHeight / pixelWidth)
```
Ne jamais fixer `w` et `h` indépendamment — cela déforme l'image.

**2. Aligner l'image sur le bloc texte adjacent.**
Quand image et texte coexistent sur la même slide (layout 2 colonnes ou similaire), l'image doit s'aligner sur l'un de ces trois axes — jamais flotter librement :
- `y_image = y_premier_élément_texte` → alignement haut
- `y_image = y_centre_bloc_texte - h_image/2` → alignement centre
- `y_image + h_image = y_dernier_élément_texte + h_dernier_élément` → alignement bas

L'alignement haut est le défaut. Utiliser le centre si l'image est nettement plus petite que le bloc texte. L'alignement bas est rare (réservé aux slides avec callout en pied de colonne).

---

## Interdictions (anti-patterns IA)

- Jamais de ligne décorative sous les titres
- Jamais de bandes colorées pleine largeur en header/footer
- Jamais de fond crème/beige (`F5F5DC`, `FAF0E6`, `FAEBD7`) — utiliser `FFFFFF` ou la palette choisie
- Jamais de slides texte-seul sans élément visuel
- Jamais de texte centré sur le corps (centrer uniquement les titres)
- Jamais de texte qui déborde de sa zone — réduire la police ou agrandir le conteneur
- Jamais de contraste insuffisant

---

## Étape 3 — QA obligatoire après génération

### Vérification texte

```bash
python3 -c "
from pptx import Presentation
prs = Presentation('output.pptx')
for i, slide in enumerate(prs.slides, 1):
    print(f'## Slide {i}')
    for shape in slide.shapes:
        if shape.has_text_frame:
            print(shape.text_frame.text)
    print()
"
```

### Détecter les placeholders oubliés

```bash
python3 -c "
from pptx import Presentation
import re
prs = Presentation('output.pptx')
for i, slide in enumerate(prs.slides, 1):
    for shape in slide.shapes:
        if shape.has_text_frame:
            text = shape.text_frame.text
            if re.search(r'xxx|lorem|ipsum|TODO|\[insert', text, re.I):
                print(f'Slide {i}: placeholder → {text[:80]}')
"
```

### QA visuelle — conversion en images

```bash
soffice --headless --convert-to pdf output.pptx
rm -f slide-*.jpg
pdftoppm -jpeg -r 150 output.pdf slide
ls -1 "$PWD"/slide-*.jpg
```

Inspecter chaque image. Chercher : chevauchements, texte tronqué, espacement insuffisant, marges < 0.5", colonnes non alignées, contraste insuffisant, placeholders.

### Boucle de correction

1. Générer → Convertir → Inspecter
2. Corriger les problèmes (overflow en priorité)
3. Relancer uniquement les slides modifiées
4. Stopper après un cycle fix/verify sauf nouveau défaut visible

Ne pas itérer sur des ajustements cosmétiques sub-pixel.

---

## Structure de projet recommandée

```
slides/
├── assets/
│   ├── logo.png
│   └── images/
├── src/
│   └── generate.js
├── output.pptx
└── output.pdf
```

---

## Commandes de référence rapide

| Tâche | Commande |
|-------|----------|
| Créer from scratch | `node src/generate.js` |
| Extraire le texte | `python3 -c "from pptx import Presentation; ..."` |
| Convertir en PDF | `soffice --headless --convert-to pdf output.pptx` |
| PDF → images | `pdftoppm -jpeg -r 150 output.pdf slide` |
| Inspecter XML brut | `unzip -p input.pptx ppt/slides/slide1.xml` |
