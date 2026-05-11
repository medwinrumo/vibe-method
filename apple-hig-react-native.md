# Apple HIG × React Native + Expo + NativeWind — Documentation de référence
_Recherche effectuée le 2026-05-11_

---

## 1. Tableau synthèse des contraintes critiques

| Guideline | Niveau | Implémentation React Native | Source |
|---|---|---|---|
| Zones tactiles 44×44pt minimum | Refus potentiel (App Store 4.0) | `minWidth: 44, minHeight: 44` ou `hitSlop` | HIG |
| Safe Areas | Refus si contenu masqué | `react-native-safe-area-context` + `SafeAreaProvider` | Expo docs |
| Launch Screen obligatoire | Refus App Store | `expo-splash-screen` + storyboard Xcode | Apple Developer |
| VoiceOver — accessibilityLabel | EAA 2025 UE + risque refus | Props `accessibilityLabel`, `accessibilityRole`, `accessibilityHint` | RN docs |
| Sign in with Apple (si auth tiers) | Refus App Store §4.8 | `expo-apple-authentication` | App Store Review Guidelines |
| Politique de confidentialité | Refus App Store §5.1.1(i) | Lien dans App.config + dans l'app | App Store Review Guidelines |
| Purpose strings (permissions) | Refus App Store §5.1.1(ii) | `infoPlist` dans app.json Expo | App Store Review Guidelines |
| Suppression de compte | Refus App Store §5.1.1(v) | Feature à implémenter si login | App Store Review Guidelines |
| Dark Mode | Recommandé fort (iOS 13+) | `useColorScheme` + NativeWind `dark:` | HIG |
| Dynamic Type | Recommandé fort — badge App Store | `allowFontScaling={true}` (défaut) + `maxFontSizeMultiplier` | App Store Connect |
| Reduce Motion | Recommandé fort | `useReducedMotion` (Reanimated) | Reanimated docs |
| Haptics | Recommandé | `expo-haptics` | Expo docs |
| SF Symbols | Recommandé | `expo-symbols` | Expo docs |

---

## 2. Refus App Store — points critiques

### §4.8 — Sign in with Apple
Si l'app utilise un auth social tiers (Google, Facebook, Twitter…) pour créer le compte principal, elle **doit** proposer Sign in with Apple en option équivalente.

Exceptions : app d'entreprise avec compte existant, app client d'un service tiers spécifique.

### §2.1 — App Completeness
Refus certain si :
- Placeholder text ou contenu temporaire visible
- URLs non fonctionnels
- Crash au lancement
- Pas de compte de démo fourni si l'app nécessite un login
- Achats in-app non fonctionnels

### §2.3 — Metadata
- Screenshots montrant uniquement l'écran de login ou la splash screen → refus
- App name > 30 caractères → refus
- Description mentionnant d'autres plateformes mobiles → refus

### §4.2 — Minimum Functionality
- App trop simple ou réemballage d'un site web → refus
- App nécessitant une autre app pour fonctionner → refus

### §5.1.1 — Data Collection
- Pas de lien politique de confidentialité → refus
- Purpose strings vagues → refus
- Obligation de connexion sans fonctionnalité basée sur compte → refus
- Pas d'option de suppression de compte si l'app permet la création d'un compte → refus

### §5.1.2 — Data Use
- Partage de données avec des tiers (y compris IA tierce) sans consentement explicite → refus
- App Tracking Transparency non utilisée pour le tracking → refus
- Forcer l'activation des notifications push ou localisation pour accéder à l'app → refus

### Launch Screen
Depuis avril 2020 : storyboard Xcode obligatoire. Expo gère cela via `expo-splash-screen`.
- Pas de texte sur le launch screen (non localisé)
- Design proche du premier écran réel
- Support de toutes les tailles d'écran iPhone

---

## 3. Implémentation concrète — React Native + Expo

### Safe Areas

```bash
expo install react-native-safe-area-context
```

```tsx
// Racine de l'app
import { SafeAreaProvider } from 'react-native-safe-area-context';
export default function RootLayout() {
  return <SafeAreaProvider>{/* app */}</SafeAreaProvider>;
}

// Option 1 : SafeAreaView
import { SafeAreaView } from 'react-native-safe-area-context';
<SafeAreaView style={{ flex: 1 }}>{/* contenu */}</SafeAreaView>

// Option 2 : useSafeAreaInsets (contrôle granulaire)
const insets = useSafeAreaInsets();
<View style={{ paddingTop: insets.top, paddingBottom: insets.bottom }} />
```

**Piège** : avec Expo Router / React Navigation, les navigateurs gèrent déjà les safe areas sur Tab Bars et Stack Headers. Double-padding possible. Utiliser `edges` prop :
```tsx
<SafeAreaView edges={['bottom']}> {/* uniquement le bas */}
```

### Zones tactiles

```tsx
// Taille minimale explicite
<TouchableOpacity style={{ minWidth: 44, minHeight: 44, justifyContent: 'center', alignItems: 'center' }}>
  <Icon size={24} />
</TouchableOpacity>

// hitSlop — agrandit la zone sans changer la taille visuelle
<TouchableOpacity hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
  <Icon size={24} />
</TouchableOpacity>
```

**Piège** : les icônes personnalisées dans une tab bar ou un header peuvent être sous-dimensionnées si on ne force pas la taille.

### Dark Mode

```tsx
import { useColorScheme } from 'react-native';
const colorScheme = useColorScheme(); // 'light' | 'dark' | null

// Avec React Navigation
import { NavigationContainer, DefaultTheme, DarkTheme } from '@react-navigation/native';
<NavigationContainer theme={colorScheme === 'dark' ? DarkTheme : DefaultTheme}>
```

**Piège** : `useColorScheme` peut retourner `null` au démarrage. Toujours avoir une valeur par défaut.

### Dynamic Type

React Native **ne bridge pas** les APIs natives iOS (`UIFont.preferredFont`). Il applique un multiplicateur sur la `fontSize` définie.

```tsx
// Comportement par défaut — allowFontScaling est true
<Text style={{ fontSize: 17 }}>Texte qui scale avec les préférences système</Text>

// Plafonnement — utile pour les éléments UI critiques
<Text style={{ fontSize: 17 }} maxFontSizeMultiplier={1.3}>Texte plafonné à 130%</Text>

// Désactiver — à éviter sauf exception justifiée
<Text allowFontScaling={false}>Taille fixe (mauvaise pratique)</Text>
```

**Catégories Dynamic Type** (tailles à Large, la catégorie par défaut) :
LargeTitle ~34pt, Title1 ~28pt, Title2 ~22pt, Title3 ~20pt, Headline ~17pt (semibold), Body ~17pt, Callout ~16pt, Subheadline ~15pt, Footnote ~13pt, Caption1 ~12pt, Caption2 ~11pt.

12 catégories au total : xSmall → xxxLarge → AX1 → AX5.

**App Store Connect Larger Text Badge** : le texte principal doit être lisible jusqu'à 200% de la taille par défaut, sans chevauchement ni troncature critique.

**Piège** : tester avec iOS Settings → Accessibility → Display & Text Size → Larger Text → activer "Larger Accessibility Sizes".

### Navigation — Tab Bar

**Règle HIG** : 3 à 5 onglets sur iPhone. Tab bar pour la navigation entre sections majeures, pas pour déclencher des actions.

```tsx
// Expo Router — tabs natifs
<Tabs screenOptions={{ tabBarActiveTintColor: '#007AFF', tabBarInactiveTintColor: '#8E8E93' }}>
  <Tabs.Screen name="index" options={{ title: 'Accueil', tabBarIcon: ... }} />
  <Tabs.Screen name="search" options={{ title: 'Recherche', tabBarIcon: ... }} />
  <Tabs.Screen name="profile" options={{ title: 'Profil', tabBarIcon: ... }} />
</Tabs>
```

**iOS 26 Liquid Glass** : la tab bar devient un capsule flottant semi-transparent qui minimise au scroll. Comportement automatique avec les composants natifs. `expo-router/unstable-native-tabs` disponible mais statut instable en 2025-2026.

### SF Symbols

```bash
expo install expo-symbols
```

```tsx
import { SymbolView } from 'expo-symbols';
<SymbolView name="heart.fill" style={{ width: 24, height: 24 }} type="hierarchical" tintColor="#FF0000" />
```

Sur Android et web, `expo-symbols` utilise Material Symbols à la place.

**Licence** : redistribution via l'app compilée permise. Interdiction d'utiliser un SF Symbol comme icône d'app ou logo. Certains symboles (AirPlay, AirPods, Apple Watch…) réservés à leurs technologies Apple respectives.

### Haptics

```bash
expo install expo-haptics
```

```tsx
import * as Haptics from 'expo-haptics';

// Résultat d'une opération
await Haptics.notificationAsync(Haptics.NotificationFeedbackType.Success);

// Impact physique / confirmation d'action
await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);

// Changement de sélection (picker, segmented control)
await Haptics.selectionAsync();
```

**Règle** : ne pas mettre de haptics partout — réserver aux moments significatifs. iOS désactive automatiquement en Low Power Mode, pendant la dictée, et quand la caméra est active.

### Reduce Motion

```tsx
import { useReducedMotion, ReduceMotion, ReducedMotionConfig } from 'react-native-reanimated';

// Configuration globale à la racine de l'app
<ReducedMotionConfig mode={ReduceMotion.System} />

// Usage dans un composant
function AnimatedComponent() {
  const reduceMotion = useReducedMotion();
  const animatedStyle = useAnimatedStyle(() => ({
    transform: reduceMotion ? [] : [{ translateX: withSpring(offset.value) }],
  }));
}
```

**Piège** : Reduce Motion ne supprime pas toutes les animations — les fondus (opacity) sont maintenus. Seules les translations/scale/rotations sont supprimées.

### VoiceOver / Accessibilité

```tsx
<TouchableOpacity
  accessible={true}
  accessibilityLabel="Ajouter au panier"
  accessibilityHint="Ajoute cet article à votre panier"
  accessibilityRole="button"
  accessibilityState={{ disabled: isDisabled }}
>
  <Icon name="cart" />
</TouchableOpacity>
```

**EAA 2025** : depuis juin 2025, les apps distribuées dans l'UE doivent respecter WCAG 2.1 AA — VoiceOver, Dynamic Type, contraste couleurs (4.5:1 texte normal, 3:1 texte large).

**Piège** : les éléments `View` sans `accessible={true}` ne sont pas exposés à VoiceOver. `TouchableOpacity` et `Pressable` sont accessibles par défaut mais sans label ni role, VoiceOver dit juste "bouton".

### Sign in with Apple

```bash
expo install expo-apple-authentication
```

```tsx
import * as AppleAuthentication from 'expo-apple-authentication';

<AppleAuthentication.AppleAuthenticationButton
  buttonType={AppleAuthentication.AppleAuthenticationButtonType.SIGN_IN}
  buttonStyle={AppleAuthentication.AppleAuthenticationButtonStyle.BLACK}
  cornerRadius={5}
  style={{ width: 200, height: 44 }}
  onPress={async () => {
    const credential = await AppleAuthentication.signInAsync({
      requestedScopes: [
        AppleAuthentication.AppleAuthenticationScope.FULL_NAME,
        AppleAuthentication.AppleAuthenticationScope.EMAIL,
      ],
    });
    // Stocker credential.user — l'email n'est fourni qu'à la première auth
  }}
/>
```

**Piège critique** : Apple masque l'email au deuxième login. Stocker l'identifiant `credential.user` en base dès la première authentification.

---

## 4. NativeWind — spécificités iOS

### Version recommandée (2026)

**NativeWind v5** avec Expo SDK 54. Basé sur Tailwind CSS v4 (config CSS-first, plus de `tailwind.config.js`). Requiert React Native 0.81+ et Reanimated v4+.

### Dark Mode

```tsx
import { useColorScheme } from 'nativewind';

function ThemeToggle() {
  const { colorScheme, setColorScheme } = useColorScheme();
  return <Pressable onPress={() => setColorScheme(colorScheme === 'dark' ? 'light' : 'dark')} />;
}

// Classes dark mode
<View className="bg-white dark:bg-gray-900">
  <Text className="text-black dark:text-white">Texte adaptatif</Text>
</View>
```

**Issue connue (#1626)** : sur iOS, le changement de thème système ne met pas à jour les styles NativeWind en temps réel — délai ou redémarrage nécessaire. Contournement : utiliser `useColorScheme` du core RN + styles conditionnels JS pour les éléments critiques.

### Safe Areas

```tsx
// Avec tailwindcss-safe-area (NativeWind v5)
<View className="pt-safe pb-safe">{/* contenu */}</View>

// Avec valeur de fallback
<View className="pt-safe-or-4 pb-safe-or-2">{/* max(safe-top, 16px) */}</View>
```

Prérequis : `SafeAreaProvider` monté à la racine.

### Classes Tailwind non supportées ou comportement différent

| Classe | Situation en NativeWind | Solution |
|---|---|---|
| `sm:`, `md:`, `lg:` breakpoints | Pas de viewport mobile | `Platform.select()` ou `ios:`, `android:` |
| `hover:`, `focus:` | Pas de hover sur mobile | Utiliser `active:` |
| `display: grid` | Non supporté | `flex-wrap` avec `basis-1/2` |
| `position: sticky` | Non supporté | `FlatList` avec `stickyHeaderIndices` |
| `box-shadow` | Comportement différent iOS/Android | `shadow-*` + vérifier sur les deux |
| Pseudo-éléments `::before`, `::after` | Non supporté | — |
| `flex-direction` | RN = `column` par défaut (pas `row`) | Toujours spécifier `flex-row` ou `flex-col` |

### Modificateurs plateforme

```tsx
<View className="ios:pt-12 android:pt-8">
<View className="native:text-base web:text-sm">
```

**Note importante** : Dynamic Type n'est pas géré par NativeWind. Les classes `text-*` définissent des tailles fixes. `allowFontScaling` doit être géré côté React Native indépendamment.

---

## 5. iOS vs Android — divergences cross-platform

| Point | Apple HIG (iOS) | Material Design 3 (Android) | Note |
|---|---|---|---|
| Zone tactile | 44×44 pt | 48×48 dp | Utiliser 48dp satisfait les deux |
| Navigation principale | Tab Bar en bas, 3-5 onglets | Navigation Bar en bas | Pattern similaire |
| Stack navigation | Titre centré, back à gauche | Titre aligné à gauche | React Navigation gère automatiquement |
| Gestes back | Swipe depuis le bord gauche | Back gesture depuis le bas | React Navigation gère nativement |
| Typographie | SF Pro (système) | Roboto (système) | `fontFamily: 'System'` utilise la police système par plateforme |
| Dark Mode | iOS 13+ | Android 10+ | `useColorScheme` fonctionne sur les deux |
| Haptics | Taptic Engine — précis | Vibrator API — moins granulaire | `expo-haptics` abstrait les deux |
| Tab bar Liquid Glass | iOS 26 — capsule flottant | Pas d'équivalent | iOS uniquement, pas de conflit |

---

## 6. iOS 26 / Liquid Glass — impact React Native

React Native utilise les composants UIKit natifs. Quand Apple met à jour leur apparence, les apps React Native en bénéficient automatiquement (avantage vs Flutter ou Compose Multiplatform).

**Tab Bar Liquid Glass** : capsule flottant semi-transparent, se minimise au scroll. Automatique avec le navigator natif iOS. Les tab bars custom en JS n'en bénéficient pas.

**Point de vigilance** : tester impérativement sur simulateur iOS 26 avant soumission.

---

## 7. Points non vérifiés sur source primaire

Les pages HIG sont JS-rendered et n'ont pas pu être fetchées directement. Points vérifiés via sources secondaires uniquement :

- Valeurs exactes des zones tactiles (44pt) — très largement documenté comme standard
- Ramp Dynamic Type complète — tailles par text style par catégorie
- Règles précises licence SF Symbols — les principes sont connus, les détails complets dans l'Apple Developer License Agreement
- VoiceOver comme motif de refus App Store direct — Apple ne le cite pas explicitement dans les Review Guidelines. C'est une obligation légale EAA en UE depuis juin 2025.
- Dynamic Type dans NativeWind v5 — aucune documentation officielle NativeWind sur ce point.
- Comportement Liquid Glass Tab Bar avec NativeWind — à tester empiriquement.

---

## 8. Checklist avant soumission App Store

### Bloquant — refus certain
- [ ] Launch Screen storyboard configuré (`expo-splash-screen`)
- [ ] Politique de confidentialité accessible dans l'app + lien dans App Store Connect
- [ ] Purpose strings complets et spécifiques pour chaque permission
- [ ] Si login social tiers → Sign in with Apple implémenté en option équivalente
- [ ] Si création de compte → option de suppression de compte implémentée
- [ ] Aucun placeholder text visible
- [ ] Aucun crash au lancement
- [ ] Compte de démo fourni dans les notes de review (si login requis)
- [ ] Screenshots montrant l'app en usage réel (pas écran de login ni splash)
- [ ] App name ≤ 30 caractères
- [ ] App Tracking Transparency si tracking utilisateur

### Qualité forte — non-refus, impact utilisateurs et classement
- [ ] Dark Mode supporté (iOS 13+)
- [ ] Dynamic Type — `allowFontScaling={true}` sur tous les `<Text>` + test à AX5
- [ ] Zones tactiles ≥ 44×44pt sur tous les éléments interactifs
- [ ] Safe Areas respectées sur tous les écrans
- [ ] VoiceOver — `accessibilityLabel` et `accessibilityRole` sur tous les éléments interactifs
- [ ] Reduce Motion respecté via Reanimated `ReduceMotion.System`
- [ ] Contraste couleurs ≥ 4.5:1 (texte normal), ≥ 3:1 (texte large)

### Recommandé
- [ ] Haptics sur les actions significatives (`expo-haptics`)
- [ ] SF Symbols pour les icônes (`expo-symbols`)
- [ ] Test sur simulateur iOS 26 (Liquid Glass tab bar)

---

## 9. Sources consultées

**Sources primaires :**
- App Store Review Guidelines : https://developer.apple.com/app-store/review/guidelines/
- Apple Developer — Larger Text evaluation : https://developer.apple.com/help/app-store-connect/manage-app-accessibility/larger-text-evaluation-criteria/
- Expo safe-area : https://docs.expo.dev/develop/user-interface/safe-areas/
- Expo symbols : https://docs.expo.dev/versions/latest/sdk/symbols/
- Expo haptics : https://docs.expo.dev/versions/latest/sdk/haptics/
- Reanimated useReducedMotion : https://docs.swmansion.com/react-native-reanimated/docs/device/useReducedMotion/

**Sources secondaires vérifiées :**
- NativeWind v5 migration guide : https://www.nativewind.dev/v5/guides/migrate-from-v4
- NativeWind issue #1626 (dark mode delay iOS) : https://github.com/nativewind/nativewind/issues/1626
- React Native accessibility : https://reactnative.dev/docs/accessibility
- iOS 26 tab bar analysis : https://www.donnywals.com/exploring-tab-bars-on-ios-26-with-liquid-glass/
