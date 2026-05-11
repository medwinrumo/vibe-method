---
description: Mise en production — guide pas à pas selon le niveau défini au /archi
allowed-tools: Bash(git *), Bash(gh *), Bash(vercel *), Bash(supabase *), Read, Write, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-search
---

Accompagne Medwin dans la mise en production d'un projet, selon le niveau défini lors du `/archi`.

## Étape 0 — Lecture du contexte projet

Avant toute action, lire :
1. `[projet].archi.md` — niveau de déploiement (1, 2 ou 3), type d'app (web / PWA / mobile), stack, BDD
2. `CLAUDE.md` du projet — modules, variables d'environnement listées, conventions

Si le niveau n'est pas défini dans `[projet].archi.md` → s'arrêter :
> "Le niveau de déploiement n'est pas défini. Lance `/archi` d'abord ou précise le niveau (1, 2 ou 3)."

---

## Étape 1 — Variables d'environnement

Générer la liste exhaustive des variables d'environnement du projet :
- Nom de la variable
- Description
- Où trouver la valeur (dashboard Supabase, dashboard OpenAI, etc.)

Guider Medwin pas à pas dans la déclaration dans Vercel :
> Dashboard Vercel → ton projet → Settings → Environment Variables → Add New

La saisie des valeurs est manuelle — Claude ne touche pas aux secrets.

---

## Étape 2 — Front (Vercel)

Pour une app web, PWA, ou interface admin web :

1. Vérifier que le repo GitHub est connecté à Vercel
2. Si non : `vercel --prod` ou connexion via dashboard Vercel → Import Git Repository
3. Vérifier que le build passe sans erreur
4. Vérifier que les variables d'environnement sont bien déclarées (étape 1)
5. Confirmer l'URL de déploiement

**Si le projet a un site vitrine dans le même repo :**
Les routes publiques (`/`, `/tarifs`, etc.) sont déployées en même temps que l'app — rien de spécifique à faire. Vérifier que les pages publiques sont bien accessibles sans authentification.

**Si le site vitrine est dans un repo séparé :**
Déployer comme un projet Vercel distinct. Domaine principal (`monprojet.com`) → site vitrine. Sous-domaine (`app.monprojet.com`) → app.

---

## Étape 2bis — Soumission sur les stores (si app native)

La soumission sur les stores est un processus distinct du déploiement web. **Prévoir 2 semaines de buffer avant la date de lancement souhaitée** — la première soumission est toujours la plus longue.

### Prérequis

- **Apple Developer** : compte à 99$/an — créer et vérifier le compte avant tout. La vérification peut prendre 48h.
- **Google Play Console** : compte à 25€ une seule fois.
- **Expo / EAS** : outil recommandé pour gérer les builds et la soumission sans configuration native complexe.
  - EAS Build : génère les builds iOS et Android en cloud — pas besoin d'un Mac pour compiler une app iOS.
  - EAS Submit : soumet directement sur les stores depuis la ligne de commande.
  - EAS Update : déploie des mises à jour JS sans passer par la review (pour les patches mineurs).

### Procédure Apple App Store

1. Déclarer le **Bundle ID** (`fr.[nom].app`) dans l'Apple Developer Portal
2. Générer le build de production : `eas build --platform ios --profile production`
3. Ouvrir **App Store Connect** → créer la fiche app
4. Remplir les métadonnées : nom, description (170 caractères max), mots-clés, catégorie, classification par âge
5. Préparer les **screenshots** selon les tailles requises (iPhone 6.7", iPad Pro si applicable)
6. Remplir les **Privacy Nutrition Labels** (obligatoire depuis iOS 14) : déclarer chaque donnée collectée, sa finalité, si elle est liée à l'identité — s'appuyer sur le registre des traitements (`rgpd.md` section 3)
7. Vérifier les points critiques des **App Store Review Guidelines** documentés dans `[projet].stack.md`
8. Soumettre pour review : `eas submit --platform ios` ou via App Store Connect
9. Délai de review : **1 à 7 jours**. Si refus → motif reçu par email. Corriger et resoumettre.

### Procédure Google Play

1. Déclarer le **Package name** (`fr.[nom].app`) dans Google Play Console
2. Générer le build de production : `eas build --platform android --profile production`
3. Dans Google Play Console → créer la fiche app
4. Remplir les métadonnées : nom, description courte (80 car.), description longue (4000 car.), catégorie
5. Préparer les **screenshots** et le **feature graphic** (1024×500px)
6. Remplir la **Data Safety Section** (équivalent des Privacy Nutrition Labels Apple) — s'appuyer sur le registre des traitements
7. Vérifier les points critiques de la **Google Play Developer Policy** documentés dans `[projet].stack.md`
8. Soumettre pour review : `eas submit --platform android` ou upload manuel de l'AAB
9. Délai de review : **quelques heures à 3 jours**

### Mises à jour après lancement

- **Changements JS uniquement** (corrections visuelles, textes, logique métier) → `eas update` — déploiement immédiat, pas de review
- **Changements natifs** (nouvelles permissions, modules natifs, version Expo) → nouvelle build + review obligatoire

### Plan de repli si refus définitif des stores

Si Apple et/ou Google refusent l'app après plusieurs cycles de correction sans issue :

- Une app React Native ne se convertit pas en PWA sans réécriture complète — ce sont deux codebases fondamentalement différentes
- La logique métier (appels API, état) est réutilisable ; l'UI doit être recodée en React web
- Ce scénario est un **dernier recours**, pas une stratégie — il implique un retard significatif et du travail supplémentaire
- Si ce scénario se produit : informer le client immédiatement, évaluer ensemble le périmètre de la réécriture avant de s'engager

---

## Étape 3 — Domaine

**App web / PWA / site vitrine :**
1. Medwin achète le domaine chez son registrar (OVH, Namecheap, Gandi...)
2. Dans Vercel : Project → Settings → Domains → Add
3. Vercel génère les enregistrements DNS à configurer
4. Claude guide la configuration DNS dans l'interface du registrar
5. Attendre la propagation DNS (quelques minutes à 48h)
6. SSL généré automatiquement par Vercel — rien à faire

**App mobile native :**
- Bundle ID (iOS) : `fr.[nom].app` — déclaré lors de l'étape 2bis
- Package name (Android) : même convention — déclaré lors de l'étape 2bis
- Pas de domaine à configurer pour l'app elle-même — la fiche store fait office d'URL publique

---

## Étape 4 — Migration BDD

Appliquer la procédure selon le niveau du projet.

### Niveau 1
1. Sauvegarder la BDD manuellement (export Supabase ou Convex)
2. Appliquer la migration directement en prod
3. Vérifier que l'app fonctionne après migration

### Niveau 2
1. Créer l'environnement de staging (second projet Vercel + second projet Supabase/Convex)
2. Déclarer les variables d'environnement sur staging
3. Appliquer la migration sur staging
4. Tester que l'app fonctionne correctement sur staging
5. Validation explicite de Medwin
6. Sauvegarder la BDD prod
7. Appliquer la migration en prod
8. Vérifier que l'app fonctionne en prod
9. Fermer l'environnement de staging

### Niveau 3
1. Tout le niveau 2
2. Tests automatisés pré-migration sur staging
3. Rollback automatique configuré avant application en prod
4. Validation humaine explicite avant chaque étape critique
5. Surveillance monitoring pendant et après migration

---

## Étape 5 — Monitoring

**Niveau 1 :** logs Vercel disponibles dans Dashboard → Project → Logs. Rien à configurer.

**Niveau 2 :**
- UptimeRobot : créer un monitor HTTP sur l'URL prod (gratuit, alertes email/SMS)
- Sentry : intégrer le SDK dans le projet, configurer les alertes email

**Niveau 3 :**
- Tout le niveau 2
- Alertes performances configurées (temps de réponse, taux d'erreur)
- Dashboard de monitoring dédié

---

## Checklist finale

**Déploiement web**
- [ ] Variables d'environnement déclarées dans Vercel
- [ ] Build Vercel passe sans erreur
- [ ] Domaine configuré et SSL actif
- [ ] Si site vitrine : pages publiques accessibles sans authentification vérifiées
- [ ] Migration BDD appliquée selon le niveau
- [ ] Monitoring configuré selon le niveau

**Stores (si app native)**
- [ ] Comptes développeur créés et vérifiés (Apple Developer + Google Play Console)
- [ ] Guidelines Apple et Google lues et documentées dans `[projet].stack.md`
- [ ] Builds de production générés via EAS Build
- [ ] Métadonnées complètes (nom, description, screenshots, icônes)
- [ ] Privacy Nutrition Labels / Data Safety Section remplis (s'appuyer sur le registre des traitements)
- [ ] Soumission effectuée sur les deux stores
- [ ] Buffer de 2 semaines prévu dans le planning avant la date de lancement

**RGPD (niveaux 2 et 3)**
Vérifier la checklist complète de `rgpd.md` section 12 avant ouverture aux utilisateurs :
- [ ] Politique de confidentialité publiée et accessible (lien dans le footer)
- [ ] Bannière de consentement cookies en place si applicable
- [ ] Fonctions effacement, export, rectification implémentées et testées
- [ ] DPA signé avec chaque sous-traitant (Supabase, Vercel, service d'emailing…)
- [ ] Si SaaS B2B : DPA inclus dans les CGU

**Validation finale**
- [ ] App testée en prod par Medwin avant ouverture aux utilisateurs
