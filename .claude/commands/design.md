# /design — Du PRD à la liste features UI + intégration export design

Tu guides Medwin dans deux étapes séquentielles et obligatoires :
- **Mode A** — Valider la stack design, interviewer, produire la liste features pour Stitch/Figma
- **Mode B** — Recevoir l'export CSS et configurer Tailwind + shadcn/ui

Tu détectes automatiquement le mode selon le contexte : si Medwin arrive avec un export CSS → Mode B. Sinon → Mode A.

---

## MODE A — Liste features pour Stitch/Figma

### Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **`[projet].prd.md`** dans le repo du projet — pour lire les features V1 et la stack design envisagée
3. **`[projet].brief.md`** si disponible — pour les contraintes responsive, contexte d'usage

Si le PRD est absent → tu t'arrêtes :
> "Avant de travailler le design, il faut un PRD finalisé. Lance `/prd` d'abord."

---

### Étape 1 — Identification de la stack design

Tu lis le PRD et tu extrais la stack design envisagée (Stitch, Figma, autre).

Si aucune stack design n'est mentionnée dans le PRD → tu demandes :
> "Quelle stack design tu envisages ? Stitch + Figma, Stitch seul, Figma seul, autre ?"

Tu retiens la réponse pour le spike.

---

### Étape 2 — Spike sur la stack design

**Lance une web search** pour chaque outil de la stack design identifiée.

Points à investiguer pour chaque outil :

**Stitch (si utilisé)**
- Ce qu'il accepte en entrée : format de la liste features, niveau de détail attendu, captures d'écran de référence
- Ce qu'il exporte : format exact (CSS, HTML, image, autre), exploitabilité directe
- Compatibilité de l'export avec Tailwind CSS et shadcn/ui
- Limites et gotchas connus

**Figma (si utilisé)**
- Format d'export CSS via Inspect : ce qu'il couvre (palette, typo, border-radius, shadows)
- Plugins utiles pour l'export (ex : Figma to Code, CSSGen)
- Compatibilité avec Tailwind CSS et shadcn/ui
- Limites et gotchas connus

Après le spike, tu présentes un verdict :
> "Stack design envisagée : [stack]
>
> Ce que j'ai trouvé :
> - [finding 1 — impact sur le workflow]
> - [finding 2 — impact sur le workflow]
>
> Verdict : cette stack est / n'est pas adaptée au projet parce que [raison]."

---

### Étape 3 — Décision sur la stack design

**Si la stack est validée** → on continue vers l'interview.

**Si la stack n'est pas adaptée** → tu proposes :
> "Je recommande [alternative] parce que [raison].
>
> Deux options :
> - Changer la stack design → on repart avec [alternative]
> - Maintenir le choix et adapter le workflow → [implication concrète]
>
> Si ce changement impacte les contraintes du PRD → il faudra passer par `/prd-update` avant de continuer."

Tu ne continues pas sans décision explicite de Medwin.

---

### Étape 4 — Interview design

Tu poses les questions une par une, dans l'ordre. Tu n'attends pas toutes les réponses en même temps.

**Contexte d'usage** (si pas déjà dans le brief)
- L'app est utilisée sur mobile, desktop, ou les deux ?
- Si les deux : le layout s'adapte (responsive) ou deux interfaces distinctes ?

**Mode d'affichage**
- Clair uniquement / sombre uniquement / les deux (clair + sombre + système) ?

**Ambiance visuelle**
- Comment tu décrirais l'ambiance que tu veux : moderne, minimaliste, chaleureuse, sérieuse, ludique, technique ?
- Des apps ou sites dont tu aimes le design ? (références visuelles pour Stitch)

**Typographie**
- Style souhaité : sans-serif (neutre, lisible), serif (classique, formel), script/manuscrit, monospace (technique) ?
- Casse : mixte standard, tout en majuscules, tout en minuscules ?
- Ton : compact et dense, ou aéré et généreux ?

**Couleurs**
- Ambiance : chaude, froide, neutre, très contrastée ?
- Restrictions : couleurs à éviter, couleur de marque imposée ?

**Densité d'information**
- Interface aérée (peu d'éléments visibles) ou dense (maximum d'infos en même temps) ?

**Animations**
- Aucune / subtiles (micro-interactions) / marquées (transitions visibles) ?

**États des composants**
- Y a-t-il des comportements spécifiques à ce projet ? (ex : bouton Envoyer désactivé si champ vide, indicateur de chargement pendant appel API)
- Ces états doivent-ils être visibles dans la maquette ou gérés uniquement en code ?

Tu résumes les réponses et demandes confirmation avant de passer à l'étape suivante.

---

### Étape 5 — Génération de la liste features

Tu lis les features V1 du PRD et tu produis la liste structurée, en tenant compte des réponses de l'interview.

Format :

```
- [Nom de la feature]
  - Composant UI : [bouton / champ texte / liste déroulante / onglet / panneau / carte / ...]
  - Comportement : [description courte — seulement si non évident]
  - États : [états spécifiques à cette feature — si identifiés]
```

Exemple :
```
- Saisie du message
  - Composant UI : champ texte multi-ligne + bouton Envoyer
  - Comportement : Entrée envoie, Shift+Entrée saute une ligne
  - États : bouton Envoyer désactivé si champ vide, spinner pendant envoi

- Sélection du modèle LLM
  - Composant UI : liste déroulante
  - Comportement : sélection immédiate, pas de confirmation
```

Tu présentes la liste complète et demandes validation avant d'écrire le fichier.

---

### Étape 6 — Enregistrement Mode A

Tu écris `[projet].design.md` dans le répertoire courant du projet avec :
1. La stack design validée + findings du spike
2. Les réponses de l'interview (ambiance, typo, couleurs, dark mode, etc.)
3. La liste features structurée

```markdown
# Design — [Nom du projet]
_Mode A complété le [date]_

## Stack design
[Outil(s) validé(s)] — [raison du choix]

### Findings du spike
- [finding 1]
- [finding 2]

## Références visuelles
[Apps / sites cités par Medwin]

## Paramètres de design
- **Responsive** : [mobile / desktop / les deux — avec précision si les deux]
- **Mode** : [clair / sombre / système]
- **Ambiance** : [description]
- **Typographie** : [style, casse, densité]
- **Couleurs** : [ambiance, restrictions]
- **Animations** : [aucune / subtiles / marquées]

## Liste features — pour Stitch
[liste générée à l'étape 5]
```

Confirmer : "Design Mode A sauvegardé → `[projet].design.md`. Tu peux maintenant travailler dans Stitch (et éventuellement Figma). Reviens avec l'export CSS pour le Mode B."

---

### Étape 7 — Instructions pour Stitch

Tu fournis les instructions prêtes à utiliser dans Stitch :

> **Ce que tu donnes à Stitch :**
> 1. La liste features ci-dessus
> 2. 2-3 captures d'écran des apps/sites de référence que tu as cités
> 3. Les paramètres de design (ambiance, couleurs, typographie, dark mode)
>
> **Si Stitch exporte directement du CSS exploitable** → tu reviens avec cet export → Mode B
> **Si tu passes par Figma** → tu affines dans Figma, tu exportes via Inspect ou plugin → Mode B

---

## MODE B — Intégration export design

### Étape 0 — Réception de l'export

Tu as besoin de :
1. **`[projet].design.md`** — pour relire les paramètres définis en Mode A
2. **L'export design** — CSS Stitch, export Figma Inspect, ou fichier HTML/CSS

Si `[projet].design.md` est absent → tu demandes à Medwin de résumer les paramètres de design définis, ou de relancer le Mode A.

Tu lis l'export et tu identifies ce qu'il couvre :
- Palette de couleurs (primaire, secondaire, neutres, états)
- Typographie (famille, tailles, poids)
- Espacements et border-radius
- Shadows et effets
- Dark mode (si présent dans l'export)

Tu signales ce qui manque dans l'export avant de continuer.

---

### Étape 1 — Configuration Tailwind

Tu génères le bloc à ajouter dans `tailwind.config.ts` :

```typescript
// À intégrer dans tailwind.config.ts
theme: {
  extend: {
    colors: {
      // [palette extraite de l'export]
    },
    fontFamily: {
      // [familles extraites de l'export]
    },
    borderRadius: {
      // [valeurs extraites de l'export]
    },
    boxShadow: {
      // [shadows extraites de l'export]
    },
  }
}
```

Si dark mode activé → tu ajoutes :
```typescript
darkMode: 'class', // ou 'media' si mode système uniquement
```

---

### Étape 2 — Personnalisation shadcn/ui

Pour chaque composant shadcn/ui utilisé dans la liste features, tu fournis les overrides CSS à appliquer pour coller au design :

```css
/* Exemple — Button */
.btn-primary {
  background-color: var(--color-primary);
  border-radius: var(--radius);
  /* ... */
}
```

Tu ne réécris pas les composants shadcn — tu surcharges uniquement ce qui doit l'être.

---

### Étape 3 — Enregistrement Mode B

Tu mets à jour `[projet].design.md` en ajoutant une section Mode B :

```markdown
## Mode B — [date]

### Configuration Tailwind
[bloc généré]

### Overrides shadcn/ui
[overrides par composant]

### Points d'attention
- [ce qui manquait dans l'export et comment c'est compensé]
- [décisions prises en l'absence d'info dans l'export]
```

Confirmer : "Design Mode B sauvegardé → `[projet].design.md`. La config Tailwind et les overrides shadcn sont prêts. Tu peux démarrer le code."

---

## Ton

Mode A : curieux et précis. Tu creuses pour obtenir une vision claire avant de produire. Si une réponse est vague, tu relances.
Mode B : technique et direct. Tu extrais, tu génères, tu signales les manques. Pas de questions ouvertes — tu travailles avec ce qu'on te donne et tu notes ce qui est absent.
