---
description: Mise en place de la stratégie de backup d'un projet — dump chiffré, GitHub Actions, miroir GitLab, DPA, UptimeRobot, test de restauration
allowed-tools: Bash(git *), Bash(gh *), Bash(ln *), Write
---

Implémente la stratégie de backup définie lors du `/archi`.
Tu guides Medwin étape par étape — il exécute, tu expliques pourquoi avant chaque action.
Chaque étape se termine par une confirmation de Medwin avant de passer à la suivante.

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **Le fichier `[projet].archi.md`** — section "Backup & RGPD"

Si absent → tu t'arrêtes :
> "Il faut d'abord lancer `/archi` pour ce projet. Les décisions backup doivent être documentées dans `[projet].archi.md`."

Tu lis la section "Backup & RGPD" et tu affiches un récapitulatif :
> "Décisions backup pour [projet] :
> - Criticité : Niveau [X]
> - Outil back-end : [Supabase / Convex]
> - Rétention : [formule]
> - Données EU : [oui / non]
> On commence ?"

**Si Niveau 1 → tu t'arrêtes** :
> "Niveau 1 — aucun backup nécessaire. Git couvre le code. Si la nature des données change, relance `/backup`."

---

## Étape 1 — DPA *(si données personnelles EU)*

Les DPA doivent être signés avant la mise en production.

**Si Supabase :**
> "Va sur supabase.com/legal/dpa → remplis le formulaire (nom, email, organisation) → envoie. Dis-moi quand c'est fait."

**Si Convex :**
> "Va sur convex.dev/legal/dpa → même procédure. Dis-moi quand c'est fait."

**Si Supabase + région EU :**
> "Vérifie dans Supabase Dashboard → Project Settings → General que la région affichée est bien 'Frankfurt (eu-central-1)'. Si ce n'est pas le cas, il faudra recréer le projet dans la bonne région — les données ne migrent pas automatiquement."

Tu ne continues pas tant que les DPA ne sont pas signés.

---

## Étape 2 — Création des dépôts de backup

Deux dépôts privés séparés du code source — un sur GitHub, un sur GitLab.

**GitHub :**
> "Lance cette commande dans le terminal :"
```bash
gh repo create [projet]-backup --private
```

**GitLab :**
> "Va sur gitlab.com → New project → Create blank project.
> - Nom : `[projet]-backup`
> - Visibility : Private
> - Décoche 'Initialize repository with a README'
> - Create project
> Note l'URL affichée (format : `https://gitlab.com/[username]/[projet]-backup.git`). Dis-moi quand c'est fait."

---

## Étape 3 — GPG — passphrase de chiffrement

La passphrase chiffre les dumps. Sans elle, les fichiers sont illisibles — même avec accès au dépôt.

> "Dans 1Password :
> - Crée un nouvel élément → type Password
> - Titre : `[projet] - GPG backup passphrase`
> - Génère un mot de passe fort (20+ caractères, lettres + chiffres + symboles)
> - Sauvegarde
> Dis-moi quand c'est enregistré."

---

## Étape 4 — Secrets GitHub Actions

Tu listes les secrets à créer dans le repo principal du projet.

> "Va sur GitHub → ton repo [projet] → Settings → Secrets and variables → Actions → New repository secret."

**Si Supabase :**

| Secret | Valeur | Où la trouver |
|---|---|---|
| `SUPABASE_DB_URL` | URL de connexion PostgreSQL | Supabase Dashboard → Project Settings → Database → Connection string → URI (mode "Transaction") |
| `GPG_PASSPHRASE` | La passphrase créée à l'étape 3 | 1Password |
| `BACKUP_GITHUB_TOKEN` | Personal access token avec accès `repo` | GitHub → Settings → Developer settings → Personal access tokens → Fine-grained → repo [projet]-backup |
| `BACKUP_GITLAB_URL` | URL GitLab avec token intégré | `https://oauth2:[ton-token-gitlab]@gitlab.com/[username]/[projet]-backup.git` |

Pour le token GitLab : GitLab → Profile → Access tokens → Create token → scope `write_repository`.

**Si Convex :**

Remplacer `SUPABASE_DB_URL` par :

| Secret | Valeur | Où la trouver |
|---|---|---|
| `CONVEX_DEPLOY_KEY` | Clé de déploiement | Convex Dashboard → Settings → Deploy keys |

Tu crées chaque secret un par un avec Medwin, en expliquant la source de chaque valeur.

---

## Étape 5 — GitHub Action — dump quotidien

Tu crées le fichier `.github/workflows/backup.yml` dans le repo du projet.

**Si Supabase :**

```yaml
name: Daily database backup

on:
  schedule:
    - cron: '0 2 * * *'
  workflow_dispatch:

jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - name: Install Supabase CLI
        run: npm install -g supabase@latest

      - name: Create dump
        run: |
          FILENAME="dump_$(date +%Y%m%d).sql"
          supabase db dump --db-url "${{ secrets.SUPABASE_DB_URL }}" > "$FILENAME"
          echo "FILENAME=$FILENAME" >> $GITHUB_ENV

      - name: Encrypt dump
        run: |
          echo "${{ secrets.GPG_PASSPHRASE }}" | gpg --batch --yes \
            --passphrase-fd 0 --symmetric --cipher-algo AES256 \
            --output "${FILENAME}.gpg" "$FILENAME"
          rm "$FILENAME"

      - name: Push to GitHub backup repo
        run: |
          git clone https://x-access-token:${{ secrets.BACKUP_GITHUB_TOKEN }}@github.com/${{ github.repository_owner }}/[projet]-backup.git gh-backup
          cp "${FILENAME}.gpg" gh-backup/
          cd gh-backup
          git config user.email "backup@github-actions"
          git config user.name "GitHub Actions"
          find . -name "dump_*.sql.gpg" -mtime +30 -delete
          git add -A
          git diff --staged --quiet || git commit -m "backup: $(date +%Y%m%d)"
          git push

      - name: Push to GitLab backup repo
        run: |
          git clone "${{ secrets.BACKUP_GITLAB_URL }}" gl-backup
          cp "${FILENAME}.gpg" gl-backup/
          cd gl-backup
          git config user.email "backup@github-actions"
          git config user.name "GitHub Actions"
          find . -name "dump_*.sql.gpg" -mtime +30 -delete
          git add -A
          git diff --staged --quiet || git commit -m "backup: $(date +%Y%m%d)"
          git push
```

**Si Convex :** remplacer les deux premières étapes par :

```yaml
      - name: Export Convex data
        run: |
          FILENAME="convex_$(date +%Y%m%d).zip"
          npx convex export --deployment-key "${{ secrets.CONVEX_DEPLOY_KEY }}" --output "$FILENAME"
          echo "FILENAME=$FILENAME" >> $GITHUB_ENV

      - name: Encrypt export
        run: |
          echo "${{ secrets.GPG_PASSPHRASE }}" | gpg --batch --yes \
            --passphrase-fd 0 --symmetric --cipher-algo AES256 \
            --output "${FILENAME}.gpg" "$FILENAME"
          rm "$FILENAME"
```

> "Crée le fichier `.github/workflows/backup.yml` dans ton projet avec ce contenu.
> Remplace `[projet]` par le vrai nom du projet partout dans le YAML.
> Dis-moi quand c'est créé."

---

## Étape 6 — GitHub Action — miroir code vers GitLab

Cette action copie automatiquement le code vers GitLab à chaque push sur `main`.

Tu crées le fichier `.github/workflows/mirror-gitlab.yml` :

```yaml
name: Mirror code to GitLab

on:
  push:
    branches: [main]

jobs:
  mirror:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Push to GitLab
        run: |
          git remote add gitlab "${{ secrets.GITLAB_MIRROR_URL }}"
          git push gitlab HEAD:main --force
```

Un secret supplémentaire à créer dans GitHub :

| Secret | Valeur |
|---|---|
| `GITLAB_MIRROR_URL` | `https://oauth2:[token-gitlab]@gitlab.com/[username]/[projet].git` (le repo code, pas le repo backup) |

> "Crée le fichier `.github/workflows/mirror-gitlab.yml`. Remplace `[projet]` par le vrai nom. Dis-moi quand c'est fait."

---

## Étape 7 — UptimeRobot

UptimeRobot surveille la disponibilité de l'app et alerte immédiatement en cas de panne.

> "Va sur uptimerobot.com → Create a new monitor :
> - Monitor type : HTTP(s)
> - URL : [URL de l'API du projet]
> - Friendly name : [projet]
> - Monitoring interval : 5 minutes
> - Alert contacts : ton email
> - Create Monitor
> Dis-moi quand c'est fait."

---

## Étape 8 — Premier test de restauration

C'est l'étape la plus importante : vérifier que le backup est réellement restaurable.

**Attendre 24h** que la première action quotidienne se soit exécutée. Ou déclencher manuellement depuis GitHub → Actions → Daily database backup → Run workflow.

**Télécharger et déchiffrer le dump :**
> "Dans le repo GitHub [projet]-backup, télécharge le dernier fichier `.gpg`. Puis lance dans ton terminal :"

```bash
echo "ta-passphrase-depuis-1password" | gpg --batch --yes \
  --passphrase-fd 0 --decrypt \
  dump_YYYYMMDD.sql.gpg > dump_test.sql

# Vérifier que le fichier est lisible
head -30 dump_test.sql
```

Si le fichier contient du SQL lisible → le backup fonctionne.

**Test de restauration sur projet de test (Supabase) :**
> "Crée un projet Supabase de test (free tier, région Frankfurt).
> Dans l'éditeur SQL de Supabase, colle le contenu de `dump_test.sql` et exécute.
> Vérifie que les tables et les données sont présentes."

Tu guides selon les erreurs éventuelles rencontrées.

> "Une fois le test validé, supprime le projet Supabase de test et le fichier `dump_test.sql` de ta machine."

---

## Étape 9 — Récapitulatif final

Tu affiches le récapitulatif de ce qui a été mis en place :

> "Backup opérationnel pour [projet] :
>
> ✓ DPA signé — [Supabase / Convex]
> ✓ Dump quotidien — chiffré GPG, 2h du matin
> ✓ Stockage — [projet]-backup sur GitHub + GitLab
> ✓ Rétention — 30 jours glissants (rotation automatique)
> ✓ Miroir code — GitHub → GitLab (à chaque push)
> ✓ Monitoring — UptimeRobot sur [URL]
> ✓ Test de restauration — validé le [date]
>
> À inscrire dans ton calendrier : **test de restauration annuel**. Dans 12 mois, relance `/backup` avec l'option `test` pour vérifier que tout fonctionne encore."

---

## Niveau 3 — Actions supplémentaires *(si criticité élevée)*

Si le projet est niveau 3 (données financières, médicales, légales) :

**Supabase Pro :**
> "Passe le projet en plan Pro (25$/mois) → active les backups natifs (rétention 7 jours incluse). Cela ajoute une couche de backup gérée par Supabase en plus de nos dumps externes."

**Stockage EU souverain (OVH ou Scaleway) :**
À la place du stockage GitLab, configurer un bucket OVH Object Storage ou Scaleway Object Storage comme destination des dumps. Configuration via `rclone` ou AWS CLI (compatible S3). À traiter lors d'une session dédiée.

---

## Ton

Tu guides, tu expliques, Medwin exécute.
Avant chaque commande ou action : expliquer pourquoi en une phrase.
Ne jamais sauter une étape sans confirmation de Medwin.
