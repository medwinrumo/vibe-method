# /stack — Investigation de la stack technique

Tu conduis le spike technique avant le démarrage du développement.
Tu produis `[projet].stack.md` dans le repo du projet — document de référence permanent pour toute la session IA.

Doctrine de référence : `stack.md`

---

## Quand lancer /stack

Entre `/archi` et `/roadmap` — après que l'architecture est définie, avant que le planning soit établi.

Obligatoire si :
- Stack nouvelle ou peu maîtrisée
- API externe critique pour le projet
- Contrainte de free tier non encore cartographiée
- Intégration entre plusieurs outils dont la compatibilité est incertaine

---

## Étape 0 — Vérification des inputs

Tu as besoin de :
1. **Le nom du projet**
2. **La stack choisie** — définie dans `/archi` (Stack A / Stack B / autre)
3. **Les outils critiques** — quels services externes, quelles APIs le projet va utiliser

Si la stack n'est pas définie → tu t'arrêtes :
> "La stack n'est pas encore définie. Lance `/archi` d'abord pour choisir entre Stack A (Convex) et Stack B (Supabase)."

---

## Étape 1 — Déclaration du périmètre

Tu annonces ce que tu vas investiguer et dans quel ordre :

> "Stack identifiée : [stack choisie].
>
> Je vais investiguer dans cet ordre :
> 1. [Outil 1] — [raison]
> 2. [Outil 2] — [raison]
> 3. [...]
>
> Durée estimée : [2-4h selon la stack]. On commence ?"

---

## Étape 2 — Investigation outillée

Pour chaque outil de la stack, tu mènes une investigation en 7 points. **Lance une web search pour chaque outil critique** — ne pas se fier uniquement aux données d'entraînement.

### Les 7 points à investiguer pour chaque outil

**1. Versions et état de l'art**
- Quelle est la version actuelle ? Chercher les release notes récentes.
- Y a-t-il eu des breaking changes depuis la date probable d'entraînement de l'IA ?
- Des migrations en cours ou annoncées ?

**2. Limites du free tier**
- Volume, requêtes, stockage, bande passante
- Actions qui déclenchent des coûts
- Limites discrètes (pause, coupure) vs progressives (pay-as-you-go)
- Comment monitorer sa consommation

**3. Gotchas et pièges connus**
- Comportements contre-intuitifs documentés
- Problèmes de performance courants
- Erreurs fréquentes sur GitHub Issues, Stack Overflow, Discord
- Anti-patterns à éviter absolument

**4. Sécurité**
- Données exposées par défaut
- Configurations de sécurité désactivées par défaut
- Clés / tokens qui ne doivent jamais se retrouver côté client

**5. APIs et SDK clés**
- Fonctions principales que le projet va utiliser
- Rate limiting sur ces APIs
- Patterns d'usage recommandés (avec exemples)
- Fonctions deprecated à éviter

**6. Compatibilité entre outils**
- Comment les outils de la stack s'intègrent-ils entre eux ?
- Incompatibilités de versions connues
- Dépendances partagées susceptibles de conflits

**7. Compatibilité avec l'IA (Claude Code)**
- L'IA connaît-elle bien cet outil ou a-t-elle tendance à halluciner des APIs ?
- Ressources ou guides spécifiques pour utiliser cet outil avec Claude Code
- Patterns TypeScript à fournir dans le contexte

---

## Étape 3 — Présentation des findings

Pour chaque outil investigué, tu présentes les findings critiques :

> "**[Outil]** — version actuelle : [version]
>
> Points critiques à retenir :
> - [finding 1 — impact]
> - [finding 2 — impact]
>
> Décision suggérée : [si un finding change quelque chose à l'architecture ou au planning]"

Tu marques une pause après chaque outil pour permettre à Medwin de réagir avant de passer au suivant.

---

## Étape 4 — Identification des décisions impactées

Après l'investigation complète, tu identifies ce que les findings changent :

> "Suite à l'investigation, voici ce que ça change :
>
> **Architecture :** [si un gotcha critique oblige à revoir une décision d'archi]
> **Roadmap :** [si une limite free tier oblige à revoir le périmètre V1]
> **Développement :** [patterns ou contraintes à respecter systématiquement pendant le code]
>
> Ces points doivent être pris en compte dans `/roadmap`."

---

## Étape 5 — Génération de `[projet].stack.md`

Tu génères le document final dans le repo du projet.

```markdown
# Stack — [Nom du projet]
_Investigué le [date]_

## Stack choisie
[Stack A — Convex / Stack B — Supabase] + React + Vite + TypeScript + Vercel + GitHub

---

## [Nom de l'outil 1]
**Version actuelle :** [version]
**Version connue par l'IA :** [estimation]

### Limites free tier
- [limite 1]
- [limite 2]

### Gotchas critiques
- [piège 1 — description + impact]
- [piège 2 — description + impact]

### Sécurité
- [point de sécurité 1]

### APIs clés pour ce projet
- [fonction/API 1] — [usage prévu + pattern recommandé]
- [fonction/API 2] — [usage prévu + pattern recommandé]

### Ressources de référence
- [lien documentation officielle]
- [lien guide spécifique]

---

## [Nom de l'outil 2]
[même structure]

---

## Contraintes croisées
[Incompatibilités ou points d'attention liés à l'interaction entre les outils]

---

## Décisions prises suite à l'investigation
[Ce que l'investigation a changé dans l'architecture ou la roadmap]
```

Tu confirmes :
> "`[projet].stack.md` généré. Ce document sera lu par `/roadmap`, `/specs`, `/tests` et `/recette` — et par l'IA à chaque session de développement."

---

## Règles

- **Le spike est time-boxé** — si un point résiste après 30 min de recherche, noter ce qui est ouvert et passer au suivant
- **Web search systématique** pour les outils critiques — les données d'entraînement peuvent être périmées
- **Tout finding critique dans le document** — pas dans la tête, pas ailleurs. Dans le repo.
- **Les décisions impactées sont documentées** — si l'investigation change quelque chose à l'architecture ou au planning, c'est noté explicitement
- **Le document est vivant** — tout gotcha découvert pendant le développement est ajouté immédiatement à `[projet].stack.md`

---

## Ton

Direct et orienté risque. Tu cherches ce qui peut faire dérailler le projet — les limites, les pièges, les incompatibilités. Tu ne présentes pas une stack sous son meilleur jour : tu identifies ses contraintes réelles pour que Medwin puisse coder en les connaissant.
