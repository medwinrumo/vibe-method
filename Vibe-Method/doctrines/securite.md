---
type: doctrine
source: ../../securite.md
source_modified: 2026-07-27
wiki_updated: 2026-07-27
tags: [sécurité, owasp, zero-trust, rls, auth, couts-caches]
---

# Doctrine — Sécurité

## En une ligne
Zero Trust : autoriser explicitement le minimum nécessaire — le code IA contient 2× plus de vulnérabilités que le code humain.

---

## La loi fondamentale

Les LLMs génèrent du code fonctionnel mais **rarement sécurisé par défaut**.
- Étude Apiiro (2025) : code IA = 2× plus de vulnérabilités que code humain
- Étude Pearce (CACM 2023) : 40 % du code IA contient des vulnérabilités actives

**Conséquence** : la sécurité doit être demandée explicitement à chaque étape.

---

## 4 phases de sécurité

### Phase 1 — Conception (décider avant de coder)
Checklist des décisions obligatoires :
- UUIDs (pas IDs séquentiels) → protection IDOR
- RLS sur toutes les tables → défini dès le schéma
- Auth : service existant (Supabase Auth, Clerk, Auth0) — jamais fait maison
- Rôles dans `app_metadata` (jamais `user_metadata` — modifiable par l'utilisateur)
- Niveau de risque : Bas / Moyen / Élevé → calibre les mesures
- RGPD : base légale et durée de rétention → doctrine complète dans `rgpd.md`

### Phase 2 — Pendant le code
Pièges courants générés par les IA :
- `service_role` key côté client → bypass RLS total
- Guards React sans vérification API côté serveur → données exposées
- `dangerouslySetInnerHTML` sans DOMPurify → XSS
- `req.body` passé directement → Mass Assignment
- `Access-Control-Allow-Origin: *` en prod → CORS ouvert
- `AsyncStorage` pour tokens mobile → non chiffré

### Phase 3 — Vérification (checklist feature)
À chaque fin de feature :
- [ ] Données filtrées par utilisateur ?
- [ ] Auth vérifiée côté serveur (pas seulement guard React) ?
- [ ] Clés privées absentes du front ?
- [ ] `.env` dans `.gitignore` ?
- [ ] Entrées validées côté serveur ?
- [ ] RLS activé + policies distinctes par opération ?
- [ ] Packages nouveaux vérifiés sur npmjs.com ?

### Phase 4 — Avant mise en ligne
- Semgrep (SAST) + Snyk (SCA) + Dependabot
- Mozilla Observatory + securityheaders.com + OWASP ZAP
- Audit croisé double LLM (Claude + second modèle)
- Pentest si niveau de risque Élevé
- **Limite de prélèvement CB configurée dès l'ajout d'une carte** sur toute plateforme cloud (Vercel, Cloudflare...) — avant le premier dépassement de plan gratuit, pas après (voir [[doctrines/stack]] section Coûts cachés)

---

## Attaques clés à connaître

| Attaque | Protection |
|---|---|
| XSS | Valider + DOMPurify sur dangerouslySetInnerHTML |
| IDOR | RLS + vérification autorisation à chaque requête |
| Mass Assignment | Whitelist explicite des champs acceptés |
| SSRF | Whitelist d'URLs + blocage IPs privées |
| Supply Chain | npmjs.com avant install + Dependabot |
| Broken Access Control | JWT vérifié côté serveur à chaque route |

---

## Règles non-négociables

- **`service_role` key** = jamais en front, jamais dans un repo Git
- **RLS activé sur toutes les tables** dès création — désactivé par défaut sur Supabase
- **Policies RLS distinctes par opération** (SELECT / INSERT / UPDATE / DELETE)
- **Jamais de custom auth** — utiliser un service éprouvé
- **Audit croisé obligatoire** pour les projets Moyen et Élevé

## Liens
[[skills/securite]] | [[doctrines/architecture]] | [[flux/chaine-complete]]
