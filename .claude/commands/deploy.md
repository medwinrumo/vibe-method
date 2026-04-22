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

Pour une app web ou PWA :

1. Vérifier que le repo GitHub est connecté à Vercel
2. Si non : `vercel --prod` ou connexion via dashboard Vercel → Import Git Repository
3. Vérifier que le build passe sans erreur
4. Vérifier que les variables d'environnement sont bien déclarées (étape 1)
5. Confirmer l'URL de déploiement

---

## Étape 3 — Domaine

**App web / PWA :**
1. Medwin achète le domaine chez son registrar (OVH, Namecheap, Gandi...)
2. Dans Vercel : Project → Settings → Domains → Add
3. Vercel génère les enregistrements DNS à configurer
4. Claude guide la configuration DNS dans l'interface du registrar
5. Attendre la propagation DNS (quelques minutes à 48h)
6. SSL généré automatiquement par Vercel — rien à faire

**App mobile :**
- Bundle ID (iOS) : `fr.[nom].app` — à déclarer dans Apple Developer
- Package name (Android) : même convention
- Compte Apple Developer (99€/an) et/ou Google Play (25€ une fois) requis
- Soumission store : procédure dédiée à lancer séparément

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

- [ ] Variables d'environnement déclarées dans Vercel
- [ ] Build Vercel passe sans erreur
- [ ] Domaine configuré et SSL actif
- [ ] Migration BDD appliquée selon le niveau
- [ ] Monitoring configuré selon le niveau
- [ ] App testée en prod par Medwin avant ouverture aux utilisateurs
