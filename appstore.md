# appstore.md — Référence Apple App Store

Document opérationnel. Règle + conséquence si non respectée + action concrète.
Source : Apple Developer Documentation, App Store Review Guidelines 2025-2026.

---

## 1. Exigences techniques obligatoires

### SDK et Xcode

| Exigence | Détail | Action |
|---|---|---|
| Xcode minimum | Xcode 15 ou supérieur requis pour toute soumission | Utiliser Xcode 15+ |
| iOS SDK cible | Optimiser pour iOS 17 SDK ; à partir d'avril 2026 : iOS 26 SDK obligatoire | Mettre à jour la cible SDK avant soumission |
| iOS minimum supporté | Aucune version plancher imposée par Apple, mais iOS 16+ couvre la majorité des appareils actifs | Définir le deployment target en fonction de l'audience |

Conséquence si non respecté : rejet automatique en soumission.

---

### Icône de l'app

| Spécification | Valeur |
|---|---|
| Taille obligatoire | 1024 × 1024 px (carré, pas de transparence) |
| Format | PNG |
| Interdits | Transparence alpha, angles arrondis (Apple les applique) |

---

### Screenshots

| Exigence | Détail |
|---|---|
| Taille obligatoire iPhone | 6.9 pouces — 1290 × 2796 px ou 1320 × 2868 px portrait. Requis depuis 2025 |
| Taille obligatoire iPad | 13 pouces — requis si app universelle |
| Nombre | 1 à 10 par localisation |
| Taille fichier max | 10 MB par screenshot |
| Contenu | Captures réelles de l'app uniquement |

---

### Privacy Manifest — PrivacyInfo.xcprivacy

Fichier obligatoire depuis le 1er mai 2024. Rejet si absent.

Ce que le fichier déclare :
1. Les types de données collectées
2. Les Required Reason APIs utilisées
3. Les SDKs tiers qui ont leur propre manifest

Required Reason APIs — nécessitent une justification explicite dans le manifest :

| API | Clé NSPrivacyAccessedAPICategory |
|---|---|
| UserDefaults | NSPrivacyAccessedAPICategoryUserDefaults |
| File Timestamp | NSPrivacyAccessedAPICategoryFileTimestamp |
| Disk Space | NSPrivacyAccessedAPICategoryDiskSpace |
| System Boot Time | NSPrivacyAccessedAPICategorySystemBootTime |
| Active Keyboard | NSPrivacyAccessedAPICategoryActiveKeyboards |

SDKs tiers nécessitant leur propre privacy manifest : Firebase (tous modules), Google Sign-In, Alamofire, SDWebImage, Kingfisher, RealmSwift, Lottie, OneSignal, AppAuth.

Action : créer PrivacyInfo.xcprivacy à la racine du projet Xcode dès le début du dev.

---

## 2. Règles de review — causes de rejet fréquentes

Top 3 motifs de rejet :
1. Guideline 2.1 — Crashes et bugs
2. Guideline 5.1.1 — Violations de privacy
3. Guideline 4.3 — Spam / app trop similaire sans valeur propre

Autres motifs fréquents :

| Règle | Violation | Conséquence |
|---|---|---|
| 2.1 | App sans compte démo fourni au reviewer | Rejet |
| 2.3.1 | Fonctionnalités cachées non documentées dans les Review Notes | Rejet |
| 2.3.7 | Nom de l'app > 30 caractères, keywords trompeurs | Rejet |
| 3.1.1 | Contournement de l'IAP pour des achats numériques | Rejet + risque suppression compte développeur |
| 4.2 | App = simple wrapper de site web | Rejet |
| 5.1.1 | Pas de politique de confidentialité dans l'app ET sur l'App Store | Rejet |

---

## 3. Authentification et comptes

### Sign in with Apple — règle obligatoire

Si l'app propose un login via un service tiers (Google, Facebook, LinkedIn...) → Sign in with Apple obligatoire en alternative équivalente.

Exceptions (Sign in with Apple non obligatoire) :
- App utilisant uniquement son propre système de compte
- App d'entreprise nécessitant un compte institutionnel existant

### Suppression de compte — obligation absolue

Toute app permettant la création de compte doit permettre la suppression depuis l'app elle-même. Un lien vers le support email ne suffit pas.

Ce que la suppression doit couvrir :
- Suppression effective du compte (pas juste désactivation)
- Suppression des données personnelles associées
- Si Sign in with Apple : appeler l'API de révocation des tokens Apple

Conséquence si absent : rejet systématique.

Action : implémenter la suppression de compte dans les paramètres utilisateur dès le premier sprint.

---

## 4. Données et privacy

### Privacy Nutrition Labels

Toutes les données collectées doivent être déclarées dans App Store Connect avant soumission.

Données à déclarer minimalement pour une app communautaire avec espace membre : nom, email, User ID, Product Interaction, Crash Data.

### App Tracking Transparency (ATT)

Tout tracking cross-app ou cross-site nécessite une permission explicite via le framework AppTrackingTransparency.

Si aucune régie publicitaire ni data broker → ATT non obligatoire.

### RGPD

Pour une app avec membres européens : consentement explicite avant collecte, droit à l'effacement, politique de confidentialité accessible et compréhensible.

---

## 5. Permissions iOS — clés Info.plist obligatoires

Chaque permission utilisée doit avoir une entrée dans Info.plist avec une description explicite.

| Clé Info.plist | Ressource protégée |
|---|---|
| NSCameraUsageDescription | Caméra |
| NSMicrophoneUsageDescription | Microphone |
| NSPhotoLibraryUsageDescription | Lecture de la photothèque |
| NSPhotoLibraryAddUsageDescription | Enregistrement dans la photothèque |
| NSLocationWhenInUseUsageDescription | Localisation quand l'app est ouverte |
| NSLocationAlwaysAndWhenInUseUsageDescription | Localisation en arrière-plan |
| NSContactsUsageDescription | Carnet de contacts |
| NSCalendarsFullAccessUsageDescription | Calendrier (accès complet) |
| NSFaceIDUsageDescription | Face ID |
| NSBluetoothAlwaysUsageDescription | Bluetooth |
| NSUserTrackingUsageDescription | Tracking publicitaire (ATT) |

Règles :
- La description doit expliquer clairement l'usage (pas "Nécessaire pour l'app")
- Ne pas demander des permissions non utilisées
- Demander uniquement au moment où la fonctionnalité est nécessaire (pas au lancement)
- Si l'utilisateur refuse : proposer une alternative ou dégradation gracieuse

---

## 6. Paiements in-app (IAP)

### Quand l'IAP Apple est obligatoire (commission 30%)

- Débloquer des fonctionnalités ou du contenu numérique dans l'app
- Abonnements premium
- Toute vente de contenu numérique consommé dans l'app

### Exceptions — autorisé sans IAP Apple

| Cas | Règle |
|---|---|
| Biens physiques | Paiement externe autorisé |
| Services multiplateforme | Abonnement souscrit sur le web → accès depuis l'app autorisé sans commission |
| Services entreprise | Groupes, employés — hors IAP |

Si l'abonnement est géré sur le web et que l'app donne accès au contenu souscrit → exemption multiplateforme applicable, pas de commission Apple.

---

## 7. Apps avec espace membre / accès privé

| Règle | Application |
|---|---|
| Compte démo pour le reviewer | Fournir login + mot de passe dans les Review Notes à chaque soumission |
| Ne pas forcer le login si des contenus sont accessibles sans compte | Laisser accessible ce qui peut l'être |
| UGC (contenu membre) | Si les membres peuvent poster : bouton Signaler + option Bloquer obligatoires |

---

## 8. Processus de soumission

### Checklist avant soumission

- [ ] Screenshots 6.9" iPhone (et 13" iPad si app universelle)
- [ ] Icône 1024×1024 px
- [ ] PrivacyInfo.xcprivacy complété
- [ ] Politique de confidentialité URL publique
- [ ] URL de support
- [ ] Compte démo fonctionnel pour le reviewer
- [ ] App Privacy Details remplies dans App Store Connect
- [ ] Description et mots-clés (max 100 caractères pour keywords)
- [ ] Nom de l'app (max 30 caractères)
- [ ] Toutes les permissions Info.plist renseignées avec descriptions explicites
- [ ] Suppression de compte implémentée
- [ ] Sign in with Apple si autre login tiers utilisé

### Délais de review

- 90% des soumissions reviewées en 24h
- 98% en 48h
- Premières soumissions et apps complexes : 48-72h

---

## Sources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/)
- [Privacy manifest files](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files)
- [Screenshot specifications](https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications/)
- [Account deletion requirement](https://developer.apple.com/news/?id=12m75xbj)
