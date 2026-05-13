# Apports du Traité du Vibe Coding Éclairé
> Extraction pour enrichissement de la vibe-method — à valider avec Medwin avant intégration

---

## 1. POSTURE — ce qui manque dans notre méthode

### La thèse centrale : culture générale > diplôme

> "Pour tirer le meilleur du vibe coding, il faut développer une culture générale informatique. Pas forcément un diplôme. Une compréhension suffisante du monde numérique pour savoir poser les bonnes questions, repérer quand quelque chose ne tourne pas rond, et piloter l'IA plutôt que de la subir."

**Formule clé à garder :** *"You don't know what you don't know"* — si tu ignores qu'une question existe, tu ne la poseras jamais à l'IA.

### Chef d'orchestre, pas touriste

L'auteur (Alexis Kovalenko) distingue deux postures :
- **Touriste** : on accepte ce que l'IA produit sans comprendre
- **Chef d'orchestre** : on comprend la partition sans jouer chaque instrument

Notre vibe-method pose déjà un workflow, mais pas cette *posture mentale* en intro. À intégrer dans `methode.md` comme principe fondateur.

### Le généraliste a l'avantage

> "Jack of all trades, master of none, but oftentimes better than a master of one."
> "Touche-à-tout, maître de rien, mais souvent meilleur que maître d'un seul."

Dans l'ère IA, la valeur rare = croiser les domaines, pas l'expertise profonde dans un seul. Pertinent à mentionner dans le contexte de qui est le vibe-codeur cible.

---

## 2. PHASE AVANT — enrichir `produit.md` et `methode.md`

### Les 3 phases d'un projet

Structure claire à adopter dans `methode.md` :

```
Phase 1 — AVANT     : préparation humaine, PRD, architecture
Phase 2 — PENDANT   : boucle de développement (IA + humain)
Phase 3 — APRÈS     : mise en production, sécurité, hébergement
```

### Règle de posture Phase 1

Trois règles d'état d'esprit avant d'ouvrir l'outil :
1. **Être en contrôle** — savoir où on en est dans le projet à tout moment
2. **Travailler de manière synchrone et concentrée** — pendant que l'IA travaille, préparer la prochaine instruction (pas de réseaux sociaux)
3. **Prendre des notes** — ce qui marche, ce qui ne marche pas, les termes découverts

### La méthode Kidlin — 5 étapes pour définir le problème

À intégrer dans `produit.md` dans la section "comment formuler un problème" :

1. Problème vague
2. Problème précis (reformulation)
3. Décomposition en sous-problèmes
4. Critère de succès en une seule phrase ("je veux que chaque bénévole voie son créneau sans m'appeler")
5. Solutions possibles

**Règle clé :** définir le PROBLÈME, pas la SOLUTION. La solution arrive après.

### User flows / User journeys

Avant le PRD : dessiner sur papier les parcours utilisateurs pour chaque profil (boîtes et flèches, pas besoin d'outil). Ces questions qui surgissent en dessinant sont "de l'or" — exactement ce qu'on aurait oublié en fonçant dans l'outil.

### Structure du prompt PRD

Template précis à intégrer dans `/prd` (ou dans `produit.md`) :

```
Tu es un expert en développement applicatif.
Rédige un PRD pour le développement d'un outil interne.
Ne fais PAS de choix techniques — partie fonctionnelle uniquement.
Cette application sera développée par un agent IA.
Liste les tâches groupées en lots pour une approche itérative.
L'ordre est important pour tester et valider lot par lot.

## Contexte
[Qui va utiliser l'app, dans quel cadre, quel problème elle résout]

## Principe
[Ce que ça fait en gros]

## Description de l'application
[User flows, fonctionnalités, types d'utilisateurs]

## Remarques diverses
[Contraintes, choses à éviter, inspirations]
```

**Règle cruciale du PRD :** "le PRD est le plan de vol du projet. Si le plan de vol est faux, tout le reste sera faux aussi." → Relire intégralement, amender soi-même dans l'éditeur.

### Technique : prototype exploratoire jetable (Sacha Pachoutinsky)

Avant de s'engager : construire un premier prototype en mode "YOLO" sans s'y attacher, uniquement pour comprendre l'architecture que l'IA va proposer, puis le jeter et recommencer proprement. Ce n'est pas du temps perdu : c'est de la compréhension gagnée.

---

## 3. ARCHITECTURE — enrichir `architecture.md`

### Les 4 familles d'architecture (du plus simple au plus complexe)

**Famille 1 — Site statique**
- HTML/CSS servi par un serveur
- Pas de calcul, pas de données, pas de problème
- Exemple : CV en ligne, page de présentation

**Famille 2 — Front-end dynamique (sans back-end)**
- Logique dans le navigateur, mais pas de données persistantes
- Exemple : simulateur, petit jeu

**Famille 3 — Full-stack moderne (RECOMMANDÉE)**
- Front-end vibe codé + back-end no-code/low-code (Supabase, Xano)
- Le back-end gère auth, BDD, sécurité, stockage fichiers
- "Sécurité par architecture, pas par espoir"

**Famille 4 — Architecture complexe (pour les pros)**
- Front + API custom + BDD + Auth + Logique métier + services tiers
- Multiples points de défaillance → laisser aux professionnels

### Les 3 questions pour choisir son architecture

1. L'app a-t-elle besoin d'une base de données ?
2. Les utilisateurs doivent-ils s'authentifier ?
3. Y a-t-il des services tiers à connecter ? (et donc des clés API à sécuriser)

### Zones verte / orange / rouge

À intégrer dans `architecture.md` pour guider les décisions de complexité et de mise en production :

**Zone verte — peut faire seul**
- Site statique ou front-end pur
- Pas de données sensibles
- Petit cercle d'utilisateurs
- Plateforme cloud qui gère l'hébergement

**Zone orange — faire avec prudence**
- Application multi-utilisateurs
- Base de données avec données personnelles
- Back-end no-code (Supabase, Xano)
- → Audit de sécurité sérieux obligatoire
- → Séparation d'environnements obligatoire

**Zone rouge — faire appel à un pro**
- Paiement en ligne
- Données de santé ou financières
- Auth multi-utilisateurs avec rôles complexes
- Exposition publique large
- Back-end custom

---

## 4. PENDANT — enrichir `methode.md`

### Context engineering — le vrai nom de la compétence

> "Tu ne codes pas, tu ne 'vibes' pas non plus. Tu gères activement ce que le modèle sait de ton projet à chaque instant."

**La fenêtre glissante :** au fur et à mesure que la conversation s'allonge, les éléments anciens "sortent" du contexte. Conséquences :
- Une conversation claire et structurée → code cohérent
- Du code cassé qui traîne dans le contexte → prédictions dégradées
- Chaque échange de débogage qui tourne en rond = contexte qui se contamine

### Règle : une conversation par fonctionnalité majeure

Limiter à 2-3h par conversation. Au-delà, ouvrir une nouvelle conversation avec un résumé propre de l'état du projet. Une conversation par lot du PRD.

### Discuter avant de coder — toujours

> "Commencer en mode discussion. Demander à l'IA comment elle compte s'y prendre avant de lui donner les commandes. Si elle prévoit de toucher à 15 fichiers pour ajouter un bouton, c'est qu'elle part dans la mauvaise direction."

Plan mode → validate → Write mode. Toujours.

### Surveiller l'IA en temps réel

Si l'IA modifie des fichiers qui n'ont rien à voir avec la demande → **interrompre immédiatement**. Ne pas la laisser finir. Plus elle avance dans la mauvaise direction, plus le code erroné s'accumule.

### Anatomie d'un bon rapport de bug

À intégrer dans `/debug` :

```
1. OÙ     → "Page planning, connecté en tant que bénévole"
2. QUOI   → "Clic sur 'Je ne suis pas disponible'"
3. RÉSULTAT → "Message d'erreur, rien n'a changé"
4. ATTENDU  → "Le créneau aurait dû passer en orange"
+ message d'erreur copié intégralement
```

**Règle :** si on envoie un screenshot d'un bug sans expliquer ce qui devrait se passer, l'IA risque de considérer l'état bugué comme l'état normal.

### Escalade de déblocage — processus structuré

Quand l'IA tourne en rond après 2 essais :

1. **Demander une analyse globale** : "Relis tout le code lié à cette feature. Propose des hypothèses avant de modifier quoi que ce soit."
2. **Changer de modèle** : Claude → GPT → Gemini. Chaque modèle détecte des choses différentes.
3. **Chercher sur le web** : les modèles ont une date de péremption. "Cherche si d'autres ont eu ce problème."
4. **Revenir en arrière + nouvelle conversation** : contexte propre + méthode par contraintes (dire à l'IA ce qu'elle ne doit PAS faire)
5. **Reporter ou demander de l'aide** : ce n'est pas un échec, c'est du pragmatisme

### La méthode par contraintes (Xavier Agapé)

Plus efficace que dire à l'IA ce qu'elle doit faire : lui dire ce qu'elle ne doit PAS faire.

> "Implémente la notification de désistement. Attention : ne modifie pas directement la base de données depuis le front-end, passe par l'API Supabase."

### Les 9 techniques nommées

À intégrer dans `methode.md` comme mini-répertoire de gestes :

| Nom | Geste |
|---|---|
| La mue du serpent | Multi-restart — première itération ratée → recommencer, ne pas corriger |
| L'archer immobile | Planifier avant de coder — toujours commencer en mode discussion |
| Le bond du tigre | Reroll — revenir avec Git + relancer en ajoutant ce qu'elle doit éviter |
| Le tranchant de la main | Interruption — IA part dans la mauvaise direction → arrêter immédiatement |
| L'œil de l'aigle | Prise de recul — arrêter les corrections ponctuelles, demander une analyse globale |
| Le singe change de branche | Changer de modèle — Claude → GPT → Gemini |
| Le souffle neuf | Context reset — nouvelle conversation = contexte propre |
| Le faucon en chasse | Recherche web — chercher les bonnes pratiques actuelles avant d'intégrer |
| Le kiai | Audio — dicter les prompts pour enrichir le contexte naturellement |

---

## 5. TESTS — enrichir `tests.md`

### Ordre de test : toujours le happy path en premier

1. **Happy path** (chemin heureux) : scénario nominal, tout se passe bien, données correctes
2. **Cas limites** : entrées invalides, comportements inattendus, situations de concurrence
3. **Console du navigateur** : ouvrir "Inspecter → Console" au premier chargement de chaque nouvelle version

**Astuce :** demander à l'IA de générer une liste de cas limites. Les LLM sont très bons pour imaginer les scénarios tordus auxquels on n'aurait pas pensé.

### Format Gherkin — déjà dans notre doctrine, confirmer la priorité

Le traité confirme l'utilisation du format Gherkin et ajoute un point important : **chaque user story du PRD se retourne naturellement en scénario de test**.

```
GIVEN [contexte de départ]
WHEN [action effectuée]
THEN [résultat attendu]
AND [résultat attendu complémentaire]
```

Prompt pour générer les tests depuis le PRD :
> "Prends les user stories du lot 2 et génère les scénarios de test correspondants en format Gherkin, y compris les cas limites."

### Verrouiller ce qui marche — tests automatisés Playwright

Une fois une fonctionnalité validée manuellement → test automatisé Playwright. Le filet se renforce à chaque lot.

**Règle :** chaque test automatisé = un test qu'on ne refait plus jamais manuellement + garantie que l'IA ne cassera pas silencieusement ce qui fonctionne.

> "A chaque lot, le filet attrape plus de régressions."

---

## 6. SÉCURITÉ — enrichir `securite.md`

### Checklist minimale avant toute mise en ligne

```
[ ] Les clés API et secrets sont dans des variables d'environnement, jamais dans le code source
[ ] L'authentification est gérée côté serveur (pas dans le navigateur)
[ ] Les permissions de la BDD sont restrictives (chaque personne ne voit que ses propres données)
[ ] Les entrées utilisateur sont validées (formulaires, paramètres d'URL)
[ ] Les données sensibles sont chiffrées (mots de passe, informations personnelles)
[ ] Le HTTPS est activé
[ ] L'IA a fait un audit de sécurité complet
[ ] Un deuxième LLM a croisé l'audit
```

### Paradoxe de l'audit IA

> "La même IA qui a introduit ces failles est parfaitement capable de les détecter quand on lui demande explicitement."

Prompt d'audit :
> "Fais un audit de sécurité complet. Vérifie : validation des entrées, gestion des clés API, authentification, permissions de la base de données, protection contre les injections."

**Règle :** croiser avec un deuxième LLM. Chaque modèle a été entraîné différemment.

### Erreur critique Supabase à ne pas faire

Utiliser la clé `service_role` côté front-end. Seule la clé `anon` (publique) doit être utilisée côté front-end, avec les Row Level Security activées.

---

## 7. STACK — enrichir `stack.md`

### Séparation des environnements (nouveau sujet non couvert)

Principe fondamental absent de notre doctrine actuelle :

> "Tu n'as pas besoin d'un nettoyeur de code vibe codé. Tu as besoin de quelqu'un qui sait auditer du code, configurer un déploiement, sécuriser une infrastructure."

**Règle :** ne jamais travailler directement sur l'application que les gens utilisent.

- **Développement** : code en cours, données de test, on casse, on teste
- **Production** : vraies données, vrais utilisateurs, protégé

**Supabase branching :** crée des branches de BDD exactement comme Git. Alternative : deux projets Supabase séparés.

### Hébergement recommandé

| Architecture | Front-end | Back-end |
|---|---|---|
| Plateforme cloud (Lovable, Bolt, Replit) | Inclus | Inclus |
| Front seul | Netlify / Vercel | — |
| Front + back no-code (recommandée) | Netlify / Vercel | Supabase / Xano (déjà hébergé) |
| Full-stack custom | Railway / Render | Railway / Render |

### Git : commits atomiques

**Règle :** un commit par fonctionnalité validée, pas un commit géant en fin de journée.

**Après chaque session IA :** demander à l'IA de lister tous les fichiers modifiés et ce qu'elle y a changé. L'IA modifie des choses non demandées — c'est la seule façon de le voir.

### Alertes de facturation

Configurer des alertes de facturation sur tous les services cloud avant la mise en production (ex : "préviens-moi quand ma facture dépasse 20€ ce mois-ci").

---

## 8. PHILOSOPHIE — à garder en tête

### Le "work slop" — l'ennemi

> "Ton travail, c'est de livrer du code dont tu as prouvé qu'il fonctionne. Pas du code que tu as généré. Pas du code qui a l'air de marcher." — Simon Willison

La même logique s'applique à tout ce qu'on produit avec l'IA. L'IA génère, toi tu livres. Tu portes la responsabilité.

### Le deskilling

> "À force de déléguer sans comprendre, on risque de perdre les compétences qu'on n'exerce plus."

Contre-mesure : utiliser l'IA comme un levier, pas comme une béquille. Rester dans la boucle, pas à côté.

### "Vibe" = domaine non-expert

> "Le vibe, c'est pour les domaines où tu n'es pas expert·e. Dans ton propre domaine, l'IA doit amplifier ta compétence, pas la remplacer par quelque chose d'approximatif."

### Le FOMO des outils

> "Mieux vaut être vraiment compétent sur un outil un peu moins à la mode que de papillonner d'un outil à l'autre sans jamais rien maîtriser."

---

## 9. MAKING OF — ce qui peut enrichir nos pratiques

L'auteur a écrit ce livre comme un projet de code : Markdown + Git + CLAUDE.md + Pandoc pipeline. Points remarquables pour notre méthode :

- **CLAUDE.md** est le fichier le plus important du projet : contexte, consignes de style, concepts à défendre, workflow. Sans lui, chaque conversation repart de zéro.
- **Journal de bord** dans le repo = changelog textuel = traçabilité éditoriale
- **Plan.md** = document vivant qui évolue avec le projet, pas un plan figé du premier jour
- Le cycle : notes vocales brutes → travail éditorial avec IA → manuscrit structuré → itérations de relecture = même logique que le dev vibe codé

**Question pour notre vibe-method :** est-ce qu'on documente bien le POURQUOI des décisions dans nos fichiers d'architecture et de PRD ? Le traité insiste sur les "décisions non évidentes" à noter : pourquoi ce back-end, pourquoi cette structure de table, pourquoi ce composant séparé.

---

## Résumé des priorités d'intégration

| Priorité | Fichier cible | Apport |
|---|---|---|
| Haute | `methode.md` | Les 9 techniques nommées, structure 3 phases, règles de boucle |
| Haute | `produit.md` | Kidlin's Law 5 étapes, template prompt PRD, user flows papier |
| Haute | `securite.md` | Checklist avant mise en ligne, audit croisé LLM, erreur service_role |
| Haute | `architecture.md` | 4 familles d'archi, 3 questions, zones verte/orange/rouge |
| Haute | `tests.md` | Escalade déblocage, verrouillage Playwright, anatomie bug |
| Moyenne | `stack.md` | Séparation environnements, hébergement par architecture, alertes facturation |
| Basse | Intro méthode | Posture chef d'orchestre, culture générale, généraliste vs spécialiste |
