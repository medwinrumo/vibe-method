# design.md

Doctrine de conception visuelle — du brief à l'interface, comment passer des features à une maquette exploitable par Claude.

---

## Principe

L'interface est conçue **avant** le code, pas après. La maquette Figma est la référence visuelle pour toutes les features — elle évite les allers-retours de style pendant le développement.

---

## Le workflow

```
PRD → export features → Stitch → Figma → export CSS → Claude
```

### Étape 1 — Export features (Claude)

Claude produit une liste structurée depuis le PRD :

```
- [Nom de la feature]
  - Composant UI : [bouton / champ texte / liste déroulante / onglet / panneau / ...]
  - Comportement : [description courte si non évident]
```

Exemple :
```
- Saisie du message
  - Composant UI : champ texte multi-ligne + bouton Envoyer
  - Comportement : Entrée envoie le message, Shift+Entrée saute une ligne

- Sélection du modèle LLM
  - Composant UI : liste déroulante
  - Comportement : sélection immédiate, pas de confirmation

- Historique des conversations
  - Composant UI : panneau latéral, liste cliquable
  - Comportement : clic → charge la conversation dans la zone principale
```

### Étape 2 — Maquette (Medwin, hors Claude)

1. Donner la liste de features à **Stitch** (Google) avec 2-3 captures d'écran de styles aimés
2. Stitch génère une première maquette
3. Importer dans **Figma**, affiner : couleurs, polices, espacement, composants
4. Quand satisfait → exporter

### Étape 3 — Export Figma (Medwin → Claude)

Ce que Medwin livre à Claude :
- Export CSS du mode Inspect (palette, typographie, border-radius, shadows)
- Captures d'écran des écrans principaux
- Éventuellement : fichier HTML/CSS si généré par un plugin

### Étape 4 — Intégration (Claude)

À partir de l'export Figma, Claude :
1. Configure `tailwind.config.ts` — couleurs, fonts, border-radius, espacements
2. Personnalise les composants **shadcn/ui** pour coller au style
3. Applique la cohérence visuelle sur toutes les features codées

---

## Outils

| Outil | Rôle |
|---|---|
| **Stitch** (Google) | Génération de maquette depuis description features + références visuelles |
| **Figma** | Affinage et validation de la maquette, export CSS |
| **Tailwind CSS** | Implémentation du style dans le code (classes utilitaires) |
| **shadcn/ui** | Composants UI prêts à l'emploi, personnalisables avec Tailwind |

---

## Règles

- La maquette est livrée **avant** le début du code — pas en cours de route
- Si la maquette change en cours de dev → discuter l'impact avant d'appliquer
- Claude applique le style Figma mais ne l'invente pas — si l'export est insuffisant, demander à Medwin
- La cohérence visuelle est une responsabilité de Claude : un bouton a le même style partout
