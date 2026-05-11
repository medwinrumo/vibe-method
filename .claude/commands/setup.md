# /setup — Bootstrap technique du projet

Tu transformes les décisions d'architecture et de stack en un projet qui tourne en local, prêt pour la première ligne de code métier.

**Inputs requis :** `[projet].archi.md` + `[projet].stack.md`
**Place dans la chaîne :** après `/stack`, avant `/prp` et le premier code métier.

---

## Étape 0 — Lecture des inputs

Tu lis `[projet].archi.md` et `[projet].stack.md` en intégralité.

Tu en extrais :
- **Stack détectée** : React Native + Expo / React + Vite / les deux
- **Back-end** : Convex (Stack A) / Supabase (Stack B)
- **Modules** : liste et structure de dossiers définie dans l'archi
- **Dépendances** : packages listés dans stack.md
- **Variables d'environnement** : services utilisés qui nécessitent des clés

Si `[projet].archi.md` est absent → stop :
> "L'architecture n'est pas définie. Lance `/archi` d'abord."

Si `[projet].stack.md` est absent → stop :
> "La stack n'est pas documentée. Lance `/stack` d'abord."

---

## Étape 1 — Vérification des prérequis machine

Tu fournis les commandes de vérification selon la stack détectée. Medwin les exécute et te donne le retour.

**Prérequis communs :**
```bash
node --version      # doit être ≥ 18
npm --version
git --version
gh --version
```

**Si React Native + Expo :**
```bash
npx expo --version
eas --version        # EAS CLI pour les builds stores
```

Si un prérequis manque → tu fournis la commande d'installation exacte avant de continuer. Tu n'avances pas tant que les prérequis ne sont pas en place.

---

## Étape 2 — Bootstrap du projet

Tu génères la commande de bootstrap selon la stack détectée. **Medwin l'exécute dans son terminal.**

**React Native + Expo :**
```bash
npx create-expo-app@latest [projet] --template blank-typescript
cd [projet]
```

**React + Vite (web) :**
```bash
npm create vite@latest [projet] -- --template react-ts
cd [projet]
npm install
```

Tu attends la confirmation que la commande s'est terminée sans erreur avant de continuer.

---

## Étape 3 — Installation des dépendances

Tu lis `[projet].stack.md` et tu génères les commandes d'installation groupées par catégorie.

**Pour Expo**, tu utilises `npx expo install` pour les packages compatibles Expo (meilleure gestion des versions) et `npm install` pour les packages génériques.

Exemple de format que tu génères :
```bash
# Packages Expo (versions compatibles garanties)
npx expo install expo-router expo-haptics expo-symbols expo-apple-authentication

# NativeWind
npm install nativewind
npm install --save-dev tailwindcss@^4

# Navigation
npx expo install react-native-safe-area-context react-native-screens

# Back-end (Supabase ou Convex selon archi)
npm install @supabase/supabase-js   # Stack B
# ou
npm install convex                   # Stack A
```

**Medwin exécute chaque bloc.** Si une commande retourne une erreur, il te la colle — tu diagnostiques avant de continuer.

---

## Étape 4 — Configuration du tooling

Tu crées directement les fichiers de configuration dans le projet.

### ESLint

Pour React Native + Expo avec TypeScript :
```js
// eslint.config.js
```

### Prettier
```json
// .prettierrc
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 100
}
```

### TypeScript — path aliases

Tu lis les modules définis dans `[projet].archi.md` et tu génères les aliases correspondants dans `tsconfig.json` :
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/shared/*": ["src/shared/*"],
      "@/config/*": ["src/config/*"],
      "@/features/*": ["src/features/*"]
    }
  }
}
```

Les aliases correspondent exactement aux modules de l'archi — pas de chemin inventé.

### NativeWind (si React Native)

Tu crées `global.css` et tu configures `babel.config.js` selon la doc NativeWind v5.

---

## Étape 5 — Structure de dossiers

Tu lis les modules de `[projet].archi.md` et tu crées la structure complète dans le projet.

```
src/
  features/
    [module-metier-1]/
      index.ts          ← contrat d'interface (exports publics)
    [module-metier-2]/
      index.ts
  shared/
    index.ts
  config/
    index.ts
```

Chaque `index.ts` est créé vide avec un commentaire indiquant la responsabilité du module, issue directement de l'archi.

---

## Étape 6 — Variables d'environnement

Tu crées `.env.example` en listant toutes les variables nécessaires selon les services identifiés dans `[projet].stack.md`.

**Supabase (Stack B) :**
```
EXPO_PUBLIC_SUPABASE_URL=
EXPO_PUBLIC_SUPABASE_ANON_KEY=
```

**Convex (Stack A) :**
```
EXPO_PUBLIC_CONVEX_URL=
```

**Variables communes :**
```
EXPO_PUBLIC_APP_ENV=development
```

Tu vérifies que `.env` est bien dans `.gitignore`. Si ce n'est pas le cas, tu l'ajoutes.

Tu rappelles à Medwin :
> "Crée ton `.env` local en copiant `.env.example` et en remplissant les valeurs. Stocke ces valeurs également dans ton gestionnaire de mots de passe (1Password ou Bitwarden) — elles ne sont nulle part ailleurs si tu perds ta machine."

---

## Étape 7 — Vérification du lancement

Tu fournis la commande de démarrage. **Medwin l'exécute et confirme que l'app se lance.**

**React Native + Expo :**
```bash
npx expo start
```
L'app doit s'afficher dans le simulateur iOS ou dans Expo Go. Si elle s'affiche → go.

**React + Vite :**
```bash
npm run dev
```
L'app doit s'ouvrir sur `localhost:5173`. Si elle s'ouvre → go.

Si l'app ne se lance pas → tu diagnostiques l'erreur avant de continuer. Tu ne valides pas un setup cassé.

---

## Étape 8 — Premier commit

```bash
git add .
git commit -m "setup: bootstrap [projet] — stack + tooling + structure"
git push
```

Tu fournis les commandes. Medwin les exécute.

---

## Étape 9 — Confirmation

Tu confirmes :

```
[projet] — setup complet.

Bootstrap    : [commande utilisée]
Dépendances  : [nombre] packages installés
Tooling      : ESLint + Prettier + TypeScript configurés
Structure    : [N] modules créés
Env          : .env.example créé — à remplir localement
Lancement    : ✅ app tourne en local

Prochaine étape → /prp puis première session de code.
```

---

## Règles

- **Je lis, tu exécutes.** Toutes les commandes shell sont exécutées par Medwin — jamais lancées automatiquement par le skill.
- **Un prérequis manquant = stop.** On ne bootstrap pas sur une machine incomplète.
- **Pas de créativité.** La structure de dossiers est celle de l'archi, les dépendances sont celles du stack. Je n'ajoute rien.
- **Erreur = diagnostic immédiat.** Si une commande échoue, Medwin colle l'erreur, je diagnostique avant de continuer. Je ne fais pas passer une étape cassée.
- **Le projet doit tourner à la fin.** Ce n'est pas optionnel — si l'étape 7 échoue, le setup n'est pas terminé.
