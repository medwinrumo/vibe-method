---
description: Mise en production — guide pas à pas selon le niveau défini au /archi
allowed-tools: Bash(git *), Bash(gh *), Bash(vercel *), Bash(supabase *), Read, Write, mcp__claude_ai_Notion__notion-fetch, mcp__claude_ai_Notion__notion-search
---

Accompagne Medwin dans la mise en production d'un projet, selon le niveau défini lors du `/archi`.

## Wiki

**Lecture** : lire `~/dev/wiki/index.md` — si des fichiers de patterns de déploiement existent pour la stack de ce projet, les lire avant de commencer.

**Écriture** (après déploiement réussi) : si des gotchas ou patterns utiles ont été découverts → proposer de les écrire dans le Wiki :
> "On a découvert [pattern/gotcha] pendant ce déploiement. Je le note dans `~/dev/wiki/[outil]-deploy.md` ?"

---

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
6. Remplir les **Privacy Nutrition Labels** (obligatoire depuis iOS 14) : déclarer chaque donnée collectée, sa finalité, si elle est liée à l'identité — s'appuyer sur le registre des traitements (`~/dev/wiki/rgpd-doc.md` section 3)
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

## Étape 5bis-A — Feature flags et rollout progressif (niveau 3, comparaison agent-skills 2026-07-28)

Pour toute mise en prod niveau 3 (app critique, vrais utilisateurs, rollback coûteux si ça casse). Découple le déploiement de l'activation — le code est en prod avant d'être visible.

**Cycle de vie d'un feature flag :**
```
1. DEPLOY, flag OFF        → code en prod, inactif
2. ACTIVER équipe/beta     → test interne en conditions réelles
3. ROLLOUT progressif      → 5% → 25% → 50% → 100% des utilisateurs
4. SURVEILLER à chaque palier → taux d'erreur, perf, retours utilisateur
5. NETTOYER                → retirer le flag et le code mort sous 2 semaines après rollout complet
```

Règles : chaque flag a un propriétaire et une date d'expiration. Ne jamais imbriquer des flags (combinatoire exponentielle). Tester les deux états (ON et OFF) avant d'activer.

**Seuils de décision à chaque palier :**

| Métrique | Avancer | Observer | Rollback |
|---|---|---|---|
| Taux d'erreur | Dans les 10% de la baseline | 10-100% au-dessus | > 2× la baseline |
| Latence p95 | Dans les 20% de la baseline | 20-50% au-dessus | > 50% au-dessus |
| Erreurs JS client | Aucun nouveau type | Nouvelles erreurs < 0.1% des sessions | Nouvelles erreurs > 0.1% des sessions |
| Métriques business | Neutre ou positif | Baisse < 5% (peut être du bruit) | Baisse > 5% |

**Rollback immédiat si :** taux d'erreur > 2× baseline, latence p95 > +50%, signalements utilisateur qui explosent, incohérence de données détectée, faille de sécurité découverte.

---

## Étape 5bis — Vérification observabilité (Pre-Launch Gate)

Avant toute mise en prod, exécuter :

```
python3 ~/dev/vibe-method/scripts/lint-observabilite.py [chemin-projet]
```

Le script vérifie que chaque `[projet].spec.*.md` marqué **Observabilité : Requise** contient bien une section "Signaux à instrumenter" non vide. C'est la vérification mécanique de la doctrine `~/dev/wiki/observabilite-doc.md` — pas une relecture manuelle.

Si le lint signale une spec incomplète → bloquant, ne pas déployer avant correction (même logique que `/securite audit`).

---

## Étape 6 — Traçabilité du déploiement (obligatoire, tous niveaux)

**Règle préalable, non négociable : aucun déploiement dont la source n'existe qu'en production.** La source vit dans un dépôt git local ; le serveur n'en reçoit qu'une copie. Si le déploiement se fait par `scp`, `rsync` ou édition directe sur le serveur, créer le dépôt local **avant** d'envoyer quoi que ce soit.

Un artefact en production dont la source n'existe qu'en production n'a ni historique, ni sauvegarde, ni adresse mémorisable. Le retrouver coûte une enquête ; le modifier revient à éditer la production.

Vécu le 03/08/2026 : une page client livrée le 21/07 a été retrouvée uniquement par `find` en SSH plus deux semaines après, dans `/var/www/notion-rgpd/`, avec son bloc Caddy dans `/etc/caddy/Caddyfile`. Aucune trace côté Mac — ni dossier projet, ni entrée dans `wiki/log.md`. La modifier a imposé de rapatrier le fichier depuis la production.

**Sortie obligatoire de tout déploiement** — créer ou mettre à jour `[projet].deploy.md` dans le dépôt du projet :

```markdown
# Déploiement — [projet]

| | |
|---|---|
| URL publique | https://… |
| Hébergeur | Vercel / VPS Hostinger / store |
| Chemin serveur | /var/www/… (si VPS) |
| Config reverse proxy | /etc/caddy/Caddyfile, bloc `…` (si VPS) |
| Dépôt source | ~/dev/… — GitHub : … |
| Commande de déploiement | `scp …` / auto sur push |
| Dernier déploiement | YYYY-MM-DD — commit `abc1234` |
```

Les trois lignes serveur ne s'appliquent pas à un déploiement Vercel (rien à retrouver, tout est dans le dashboard lié au repo) — les laisser à `—`. Elles sont le cœur du problème pour tout déploiement manuel sur VPS.

**Livrable sans projet formel** (page statique isolée, one-shot client) : la règle tient quand même. Créer un dépôt minimal `~/dev/[nom]/` avec la source, un `README.md` portant le tableau ci-dessus, et pousser sur GitHub. C'est le seul cas où le `[projet].deploy.md` et le `README.md` fusionnent.

Puis proposer l'entrée wiki correspondante (règle 4 de `~/dev/wiki/CLAUDE.md` — n'écrire au wiki que ce qui vaudrait pour un autre projet ; l'URL d'un livrable client, elle, reste dans le dépôt du projet).

---

## Checklist finale

**Traçabilité — avant de considérer le déploiement fait**
- [ ] La source vit dans un dépôt git local, poussé sur GitHub — pas uniquement sur le serveur
- [ ] `[projet].deploy.md` créé ou à jour : URL publique, hébergeur, chemin serveur, config reverse proxy, dépôt source, commande, date + commit
- [ ] Si déploiement manuel (scp/rsync) : la version en production correspond à un commit identifié (`shasum` local vs distant si doute)

**Déploiement web**
- [ ] Variables d'environnement de production déclarées dans Vercel Dashboard (pas dans `.env` commité)
- [ ] Clés de production différentes des clés de développement (rotation effectuée)
- [ ] Build Vercel passe sans erreur
- [ ] Domaine configuré et SSL actif
- [ ] Si site vitrine : pages publiques accessibles sans authentification vérifiées
- [ ] Migration BDD appliquée selon le niveau
- [ ] Monitoring configuré selon le niveau
- [ ] `scripts/lint-observabilite.py` passé sans erreur (Pre-Launch Gate observabilité)
- [ ] Alertes de facturation configurées sur tous les services cloud (seuil à définir selon le projet)
- [ ] Si niveau 3 : feature flag en place avec propriétaire + date d'expiration, seuils de rollback définis avant le premier palier de rollout

**Sécurité — avant go-live**
- [ ] Security headers configurés dans `vercel.json` (X-Frame-Options, X-Content-Type-Options, Referrer-Policy)
- [ ] CSP testée en mode `Content-Security-Policy-Report-Only` puis activée en enforcement
- [ ] `service_role` key Supabase absente de tout repo Git, de toute config CI, de tout log
- [ ] Dependabot activé sur le repo GitHub (alertes de sécurité automatiques)
- [ ] `/securite audit` exécuté — rapport produit et corrections appliquées
- [ ] Mozilla Observatory ou securityheaders.com : score acceptable sur l'URL de production
- [ ] Si niveau de risque élevé : OWASP ZAP lancé sur l'URL de production

**Stores (si app native)**
- [ ] Comptes développeur créés et vérifiés (Apple Developer + Google Play Console)
- [ ] Guidelines Apple et Google lues et documentées dans `[projet].stack.md`
- [ ] Builds de production générés via EAS Build
- [ ] Métadonnées complètes (nom, description, screenshots, icônes)
- [ ] Privacy Nutrition Labels / Data Safety Section remplis (s'appuyer sur le registre des traitements)
- [ ] Soumission effectuée sur les deux stores
- [ ] Buffer de 2 semaines prévu dans le planning avant la date de lancement

**RGPD (niveaux 2 et 3)**
Vérifier la checklist complète de `~/dev/wiki/rgpd-doc.md` section 12 avant ouverture aux utilisateurs :
- [ ] Politique de confidentialité publiée et accessible (lien dans le footer)
- [ ] Bannière de consentement cookies en place si applicable
- [ ] Fonctions effacement, export, rectification implémentées et testées
- [ ] DPA signé avec chaque sous-traitant (Supabase, Vercel, service d'emailing…)
- [ ] Si SaaS B2B : DPA inclus dans les CGU

**Validation finale**
- [ ] App testée en prod par Medwin avant ouverture aux utilisateurs
