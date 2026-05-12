# Résumé de lecture — Traité du Vibe Coding Éclairé
> Alexis Kauffmann — relu depuis le chapitre "Basquiat au musée" (p. 97 dans l'édition papier)
> Note : le fichier source est un epub. Les références sont données par **chapitre et section** plutôt que par numéro de page, qui n'est pas fixe dans ce format.

---

## Chapitre : Basquiat au musée

### Section : Un gamin au Brooklyn Museum

Jean-Michel Basquiat n'a jamais fait les Beaux-Arts. Il a quitté l'école à 17 ans. Sa mère l'a inscrit comme membre junior du Brooklyn Museum à 6 ans. Il a passé son enfance à arpenter les salles, à dessiner "en jouant aux étudiants en art", à lire sur l'anatomie, l'histoire de l'art, la culture populaire.

**Ce que ça dit :** la compétence ne vient pas du diplôme. Elle vient de l'immersion, de la curiosité, des années d'exposition à un domaine. C'est exactement ce que le livre appelle "culture générale informatique".

### Section : La thèse du livre

> "Pour tirer le meilleur du vibe coding, il faut développer une culture générale informatique. Pas un diplôme. Une compréhension suffisante du monde numérique pour savoir poser les bonnes questions, repérer quand quelque chose ne tourne pas rond, et piloter l'IA plutôt que de la subir."

C'est ça, le vibe coding éclairé : comprendre ce qu'on construit, même si on ne le construit pas soi-même ligne par ligne.

### Section : "You don't know what you don't know"

Si tu ignores l'existence des bases de données relationnelles, tu ne penseras jamais à en demander une à l'IA. Si tu ne sais pas ce qu'est une API, tu ne pourras pas connecter ton app à un service externe. Si tu n'as jamais entendu parler de gestion de versions, tu ne sauras pas revenir en arrière quand l'IA casse ton projet.

**L'IA ne comble pas ces lacunes d'elle-même.** Elle répond aux questions qu'on lui pose. Si tu ne sais pas qu'une question existe, tu ne la poseras jamais. L'IA peut produire du code fonctionnel sans base de données, sans API, sans gestion de versions. Ce code sera fragile, limité, parfois dangereux — mais il "marchera" au premier regard. Et tu ne sauras pas ce qui manque.

### Section : La paresse, l'impatience et l'orgueil

Larry Wall (créateur de Perl) définit les 3 vertus du bon programmeur : la paresse (automatiser tout ce qui peut l'être), l'impatience (ne pas tolérer les processus mal conçus) et l'orgueil (ne pas se contenter du "ça a l'air de marcher").

L'auteur ajoute une 4e qualité : **la curiosité**. Celle qui te fait ouvrir un onglet pour comprendre ce que tu viens de lire. Celle qui te fait demander à l'IA "explique-moi ce que tu viens de faire et pourquoi" au lieu d'accepter le résultat.

### Section : Les généralistes à l'ère de l'IA

Citation complète souvent tronquée : "Jack of all trades, master of none, **but oftentimes better than a master of one**."

À l'ère de l'IA, l'expertise profonde dans un seul domaine est de plus en plus accessible via les LLM. Ce qui devient rare et précieux : voir les liens entre les domaines, comprendre le contexte global, s'adapter quand les règles changent. Dans le vibe coding, c'est exactement ce qui fait la différence : comprendre suffisamment de choses différentes — architecture, données, interface, sécurité, besoins utilisateur — pour orchestrer un projet cohérent.

### Section : Chef d'orchestre, pas touriste

Un chef d'orchestre ne sait pas jouer de tous les instruments. Mais il comprend la musique, connaît les capacités et les limites de chaque instrument, sait quand les cuivres doivent entrer.

C'est la posture du vibe coding éclairé : comprendre qu'il y a un front-end et un back-end, qu'une base de données stocke des informations, qu'une API fait communiquer deux services, ce que "déployer" signifie. Avec cette compréhension, même partielle, on peut donner des instructions pertinentes à l'IA, repérer quand elle prend une mauvaise direction, poser les bonnes questions. On passe de touriste à pilote.

Andrej Karpathy (celui qui a inventé le terme "vibe coding") le faisait en touriste car il est développeur de classe mondiale et pouvait reprendre la barre à tout moment. Toi et moi, on n'a pas ce filet de sécurité — d'où la nécessité de la posture chef d'orchestre.

### Section : Les no-codeurs ont une longueur d'avance

Avec Airtable, on a compris les bases de données relationnelles. Avec Zapier ou Make, la logique des API. Avec Bubble, des notions d'architecture. Ce sont des intuitions techniques solides, pas des connaissances académiques. On "sent" quand une architecture de données est bancale, même sans pouvoir l'expliquer dans le jargon.

### Section : Comprendre pour mieux créer

La compréhension des besoins utilisateur est irremplaçable. On ne résout pas un problème qu'on ne comprend pas. L'IA amplifie ce travers, parce qu'elle rend la construction tellement rapide qu'on a l'impression de pouvoir réfléchir après.

Or c'est l'inverse : **plus il est facile de construire, plus il est important de bien réfléchir à ce qu'on construit.**

---

## Chapitre : Avant d'ouvrir l'outil

### Section : Les 3 phases d'un projet

```
Phase 1 — AVANT    : préparation humaine, PRD, architecture
Phase 2 — PENDANT  : boucle de développement (IA + humain)
Phase 3 — APRÈS    : mise en production, sécurité, hébergement
```

C'est un enchaînement, pas un menu dans lequel on pioche à la carte.

### Section : L'état d'esprit

**Règle 1 — Être en contrôle.** Tu es le chef d'orchestre. Ce n'est pas parce que c'est l'IA qui écrit le code que c'est elle qui décide de la direction. Tu dois savoir où tu en es dans ton projet, ce qui est fait, ce qui reste à faire, ce qui pose problème.

**Règle 2 — Travailler de manière synchrone et concentrée.** Quand tu demandes quelque chose à l'IA et qu'elle travaille, ne pars pas scroller sur les réseaux sociaux. Reste dans ton projet. Prépare la prochaine instruction. Relis ce qu'elle vient de produire. Demande-lui d'expliquer un point que tu ne comprends pas. Ces temps de flottement sont des temps d'apprentissage déguisés.

**Règle 3 — Prendre des notes.** Note ce qui marche, ce qui ne marche pas, les termes que tu découvres, les erreurs que tu fais. Ces notes te serviront pour tes projets suivants.

Dan Shipper ("Stop Coding and Start Planning") : l'IA a rendu les gens négligents parce qu'elle leur a fait oublier comment planifier. Pourquoi passer une heure à préparer quand on peut passer 5 minutes à construire ? Parce que ces 5 minutes sans préparation mènent souvent à 3 heures de débogage qu'un quart d'heure de réflexion aurait évité.

### Section : Ne pas céder à la tentation

La tentation : tu as une idée, tu ouvres un outil de vibe coding en te disant "on verra bien". C'est la meilleure manière de perdre du temps.

Métaphore de Shubham Sharma : **la trajectoire d'avion.** Si tu décales ta trajectoire d'un seul degré au décollage, après quelques heures de vol, tu te retrouves à des centaines de kilomètres de ta destination. Une mauvaise compréhension du problème au départ, un choix d'architecture bancal, et quelques heures plus tard tu tournes en rond dans une boucle de corrections qui ne résout rien. Pas parce que l'IA est mauvaise. Parce que le point de départ était flou.

### Section : Papier, crayon, cerveau

La première étape est fondamentalement humaine. Pas d'écran, pas d'IA, pas d'outil. Un papier, un crayon, et ton cerveau.

Cette phase de préparation fait exactement la même chose pour ton cerveau que le contexte fait pour un LLM : plus tu as réfléchi au problème, plus tu l'as retourné dans ta tête, griffonné, schématisé, plus tu seras en mesure de guider l'IA efficacement ensuite. Tu "charges le contexte dans ta propre mémoire".

### Section : La méthode Kidlin — 5 étapes ← RÉFÉRENCE POUR MEDWIN

Shubham Sharma utilise un cadre en 5 étapes inspiré de la **Kidlin's Law** : "une part importante de la solution réside dans la définition précise du problème."

**Les 5 étapes :**

1. **Problème vague** → "Le planning des bénévoles, c'est le bazar."
2. **Problème précis** → "La coordinatrice passe 3h par semaine à compiler les disponibilités envoyées par WhatsApp, et quand quelqu'un se désiste, elle doit relancer tout le monde manuellement."
3. **Sous-problèmes** → 1) Les disponibilités arrivent éparpillées. 2) Pas de vue d'ensemble. 3) Les désistements créent des trous difficiles à combler. 4) Tout repose sur une seule personne.
4. **Critère de succès en une phrase** → "Chaque bénévole peut voir son planning et signaler une indisponibilité, et Sophie voit en un coup d'œil les créneaux à pourvoir."
5. **Solutions possibles** → Un tableur partagé ? Un Google Form hebdomadaire ? Une petite app web dédiée ?

**Règle clé :** définir le PROBLÈME, pas la SOLUTION. "Je veux une application qui fait X" = solution. "Mes bénévoles perdent du temps à coordonner leurs plannings par WhatsApp" = problème. Cette distinction est fondamentale.

**Le critère de succès, c'est la boussole.** Si tu peux le résumer en une phrase simple, c'est que tu as compris ton problème. "Je veux pouvoir payer une facture en un clic." "Je veux que chaque bénévole sache son créneau sans m'appeler."

### Section : User flows sur papier

Après Kidlin : dessiner sur papier les parcours utilisateurs pour chaque profil. Boîtes et flèches. Pas besoin d'outil — Whimsical, Miro, Excalidraw, ou même l'application Notes du téléphone. L'outil n'a aucune importance. Ce qui a de l'importance : s'approprier le projet avant de le déléguer à une IA.

Les questions qui surgissent en dessinant sont "de l'or" — exactement ce qu'on aurait oublié si on avait foncé dans l'outil.

### Section : Le cadrage fonctionnel — le PRD

Le PRD (Product Requirement Document) décrit ce qu'on veut construire d'un point de vue fonctionnel, sans entrer dans les choix techniques. Il répond à la question "quoi", pas à la question "comment".

**Template de prompt PRD du livre :**
```
Tu es un expert en développement applicatif et tu vas me rédiger un PRD.
Contiens-toi à la partie fonctionnelle — pas de choix techniques.
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

**Règle cruciale :** relire le PRD intégralement, ligne par ligne. Le PRD est le plan de vol du projet. Si le plan de vol est faux, tout le reste sera faux aussi. Amender soi-même directement dans l'éditeur — pas besoin de demander à l'IA de corriger chaque détail. Si le PRD est vraiment à côté de la plaque → la préparation en amont n'était pas assez précise. Revenir à l'étape Kidlin.

Xavier Agapé : prépare un triptyque avant de commencer → PRD + fichier de bonnes pratiques réutilisable + base de données déjà structurée.

### Section : L'architecture technique

Avant de paniquer : la question du "comment" est accessible dès qu'on connaît 3 questions à se poser.

**Les 3 questions pour choisir son architecture :**
1. L'app a-t-elle besoin d'une base de données ? (si les gens stockent des infos ou partagent des données → oui)
2. Les utilisateurs doivent-ils s'authentifier ? (si chaque personne a son propre espace → oui)
3. Y a-t-il des services tiers à connecter ? (paiement, API météo, emails → clés API à sécuriser)

**Les 4 familles d'architecture :**

**Famille 1 — Site statique** : HTML/CSS servé. Pas de calcul, pas de données, pas de problème. Exemple : CV en ligne, page de présentation.

**Famille 2 — Front-end dynamique sans back-end** : logique dans le navigateur, mais pas de données persistantes. Exemple : simulateur, petit jeu.

**Famille 3 — Full-stack moderne (RECOMMANDÉE)** : front-end vibe codé + back-end no-code (Supabase, Xano). Le back-end gère auth, BDD, sécurité, stockage fichiers. "Sécurité par architecture, pas par espoir."

**Famille 4 — Architecture complexe (pour les pros)** : front + API custom + BDD + Auth + Logique métier + services tiers. Multiples points de défaillance. Laisser aux professionnels.

Pour discuter architecture avec l'IA sans coder : "Tu es un expert en architecture technique. Mon but est de faire un SaaS. Propose-moi une solution technique simple. Voici mes problèmes et mes user flows." Demander à l'IA de commenter avant de proposer pour s'assurer qu'elle a bien compris.

### Section : Le design

Ce qui est construit avec l'IA sans consigne graphique est propre, correct, lisible — mais sans caractère. Toutes les apps vibe codées sans direction graphique finissent par se ressembler. Ce n'est pas une fatalité, c'est le symptôme d'un manque de culture graphique.

Solution : passer du temps sur Dribbble, repérer ce qui plaît, noter les mots-clés qui décrivent ces styles. Donner une capture d'écran d'un design qui plaît à l'IA + "inspire-toi de cette direction graphique".

Distinction importante : **UI** (look) ≠ **UX** (parcours). L'IA peut aider à poser les bases de l'UX. L'UI relève du goût et de la culture visuelle — c'est à toi de l'apporter.

### Section : Pas d'overengineering

Ne pas se compliquer la vie. Ne pas copier les workflows des personnes expérimentées vus sur YouTube. La méthodologie complète (préparation + PRD + architecture) peut tenir en 1h pour un petit projet : 30min de griffonnage, 20min de PRD avec l'IA, 10min de réflexion sur l'architecture.

**Spec-driven development / spec coding :** mouvement qui consiste à écrire des spécifications détaillées avant de laisser l'IA coder. Frameworks : BMAD, SpecKit (GitHub), OpenSpec. Intéressant pour les projets ambitieux ou en équipe. Pour débuter : c'est de l'artillerie lourde — la méthode décrite dans ce chapitre est la version pragmatique et accessible de la même philosophie.

---

## Chapitre : Dans la boucle

### Section : Le context engineering

Un LLM ne "comprend" pas ton projet. Ce qu'il fait : prédire le prochain token en fonction de tout ce qui précède dans la conversation. Son carburant, c'est le contexte.

**La fenêtre glissante :** au fur et à mesure que la conversation s'allonge, les éléments anciens "sortent" de la fenêtre. Le modèle les "oublie". C'est pour ça que les conversations très longues perdent en cohérence. Conséquences pratiques :
- Du code cassé qui traîne dans le contexte = bruit qui dégrade les prédictions suivantes
- Un échange de débogage qui tourne en rond = place perdue dans la fenêtre
- Une correction qui en introduit une autre = contexte qui se contamine

Le terme "context engineering" décrit mieux que "vibe coding" ce qu'on fait réellement : gérer activement ce que le modèle sait de ton projet à chaque instant.

Valérian Lebert : il préfère les outils où il voit exactement ce qui se trouve dans le contexte, où il peut éditer la conversation, supprimer des morceaux qui polluent, plutôt que des boîtes noires.

### Section : La première itération

Donner au LLM le PRD + architecture + "commence par le lot 1". La première itération pose les fondations. Si ces fondations sont bancales, tout ce qu'on construit dessus sera fragile.

Si la première version est à côté de la plaque → **recommencer, ne pas corriger.** Corriger une mauvaise première itération prend souvent plus de temps que repartir de zéro avec un prompt amélioré. Traiter la première itération comme un brouillon jetable.

Sacha Pachoutinsky : il construit un premier prototype en mode "YOLO" sans s'y attacher, juste pour comprendre l'architecture que l'IA va proposer. Il le jette avant de recommencer proprement. Ce n'est pas du temps perdu : c'est de la compréhension gagnée.

### Section : Discuter avant de coder

La plupart des outils de vibe coding proposent un mode discussion et un mode écriture. **Toujours commencer en mode discussion.** Décrire la feature et demander à l'IA comment elle compte s'y prendre : "Comment implémenterais-tu cette fonctionnalité ? Quels fichiers modifierais-tu ? Quelles sont les étapes ?" Si elle prévoit de toucher 15 fichiers pour ajouter un bouton, elle part dans la mauvaise direction.

Valérian a intégré le mode plan directement dans ses instructions permanentes : un prompt qui force l'IA à planifier avant d'agir et à ne faire qu'une seule modification à la fois. Les moments où il a ignoré cette discipline ont systématiquement produit plus de problèmes.

### Section : Rester concentré

Pendant que l'IA travaille, utiliser ce temps utilement dans le projet :
- Préparer le prochain prompt
- Relire le PRD pour vérifier qu'on est dans les clous
- Explorer le code généré : noms de fichiers, structures, termes à chercher
- Ouvrir un autre LLM à côté pour poser des questions sur des concepts croisés
- Dicter le prochain prompt plutôt que le taper (les prompts dictés sont plus riches en contexte)

**Sur la parallélisation :** non, il n'y a pas besoin de lancer 8 agents en parallèle sur 8 projets. Sacha a testé 2 instances de Claude Code sur le même projet — résultat : conflits de fichiers, session terminée en pagaille. Ces IA vont déjà très vite.

**Surveiller l'IA en temps réel.** Si elle modifie des fichiers hors scope, installe des bibliothèques non prévues, ou refait l'interface alors qu'on lui a juste demandé de corriger un bug → interrompre immédiatement. Ne pas la laisser finir. Plus elle avance dans la mauvaise direction, plus le code erroné s'accumule dans le contexte.

Incident réel (février 2026) : Alexey Grigorev a laissé Claude Code exécuter des commandes Terraform sur son infrastructure cloud. L'agent a remplacé un fichier de configuration puis lancé une commande de destruction qui a effacé toute l'infrastructure de production (base de données 2 millions de lignes, serveurs, sauvegardes). 24h de panique et un upgrade du support AWS pour récupérer les données. Leçon : un agent autonome qui a accès à des commandes destructrices sans surveillance humaine = risque réel, pas théorique.

### Section : Tester tout le temps

**Happy path d'abord** : scénario nominal, tout se passe bien, données correctes. Si le happy path ne fonctionne pas, inutile d'aller plus loin.

**Premier réflexe** : ouvrir la console du navigateur (clic droit → Inspecter → onglet Console) au premier chargement de chaque nouvelle version. C'est là que s'affichent les erreurs invisibles à l'écran.

**Ensuite, casser l'application** : cas limites. Que se passe-t-il si quelqu'un entre un email sans le "@" ? Si on essaie d'agir sur un créneau déjà passé ? Si deux personnes cliquent en même temps ? Si un nom contient une apostrophe (comme O'Neill) ?

**Demander à l'IA de générer une liste de cas limites** pour chaque fonctionnalité. Les LLM sont très bons pour imaginer les scénarios tordus auxquels on n'aurait pas pensé.

**Format Gherkin pour structurer les tests :**
```
GIVEN  [contexte de départ]
WHEN   [action effectuée]
THEN   [résultat attendu]
AND    [résultat complémentaire]
```
Chaque user story du PRD se retourne naturellement en scénario de test. Prompt : "Prends les user stories du lot 2 et génère les scénarios de test en format Gherkin, y compris les cas limites."

### Section : Anatomie d'un bon rapport de bug

Un rapport insuffisant ("ça ne marche pas, corrige") ne donne pas le contexte nécessaire. L'IA n'a aucun contexte : elle ne sait pas ce qu'on a fait, ce qu'on a vu, ni ce qu'on attendait.

```
1. OÙ      → quelle page, quel rôle utilisateur
2. QUOI    → quelle action exactement
3. RÉSULTAT → ce qui s'est passé
4. ATTENDU  → ce qui aurait dû se passer
+ message d'erreur copié intégralement (console du navigateur ou terminal)
```

Si on envoie un screenshot d'un bug sans expliquer ce qui ne va pas, l'IA risque de considérer l'état bugué comme l'état normal.

### Section : Quand ça coince — escalade en 5 étapes

Ne jamais s'entêter au-delà de 2 essais sur le même problème. Escalade :

**Étape 1 — Analyse globale**
"Relis tout le code lié à cette feature. Analyse le problème dans son ensemble. Propose des hypothèses avant de modifier quoi que ce soit." Passe le LLM du mode correction locale au mode diagnostic global.

**Étape 2 — Revenir en arrière + contraintes négatives**
Git reset au dernier commit propre. Relancer en précisant ce que l'IA ne doit PAS faire. **La méthode par contraintes (Xavier Agapé) :** dire à l'IA ce qu'elle ne doit pas faire est souvent plus efficace que lui dire ce qu'elle doit faire. "Implémente X. Attention : ne touche pas à Y, ne passe pas par Z."

**Étape 3 — Changer de modèle**
Chaque modèle a été entraîné différemment. Ce qui est insoluble pour Claude peut être trivial pour GPT ou Gemini.

**Étape 4 — Recherche web**
Les modèles ont une date de péremption. Demander à l'IA de chercher les bonnes pratiques actuelles, les incompatibilités de versions connues. S'applique aussi en préventif : avant d'intégrer un service externe, chercher la documentation à jour avant de coder.

**Étape 5 — Nouvelle conversation**
Contexte propre. Redémarrer avec PRD + état du projet + description du problème + ce qui n'a pas fonctionné.

Si rien ne débloque → reporter la feature et continuer. Ce n'est pas un échec, c'est du pragmatisme. C'est du vibe coding éclairé.

### Section : Savoir quand rafraîchir la conversation

Stéphanie (QA engineer) : ne pas dépasser 2-3h sur une même conversation. Au-delà, le LLM a vu trop de choses, ses prédictions se dégradent.

Règle : **une conversation par fonctionnalité majeure.** Quand un lot du PRD est terminé et sauvegardé, fermer la conversation et en ouvrir une nouvelle pour le lot suivant.

### Section : Verrouiller ce qui marche — les régressions

Une régression : quand quelque chose qui marchait cesse de marcher après une modification. Le fléau du vibe coding. Même les meilleurs modèles en produisent régulièrement.

Solution : **test automatisé Playwright** sur chaque fonctionnalité validée. À chaque modification, relancer tous les tests. Si un test échoue → la modification a cassé quelque chose, et on sait exactement quoi. Le filet se renforce à chaque lot.

```
Lot 1 terminé → Test auto : connexion          ✅
Lot 2 terminé → Test auto : connexion          ✅
               Test auto : désistement         ✅
Lot 3 terminé → Test auto : connexion          ✅
               Test auto : désistement         ✅
               Test auto : notifications       ✅
```

### Section : Les 9 techniques nommées

Répertoire de gestes récurrents dans la communauté vibe coding :

| Nom | Geste |
|---|---|
| **La mue du serpent** | Si la première itération est ratée → recommencer, ne pas corriger. Le code bancal reste dans le contexte. |
| **L'archer immobile** | Toujours commencer en mode discussion. Demander comment l'IA compte s'y prendre avant de lui donner les commandes. |
| **Le bond du tigre** | Bloqué sur un bug → Git reset + relancer en ajoutant ce que l'IA ne doit pas faire. |
| **Le tranchant de la main** | IA part dans la mauvaise direction → interrompre immédiatement, sans la laisser finir. |
| **L'œil de l'aigle** | Bloqué depuis 3 itérations → arrêter les corrections ponctuelles, demander une analyse globale. |
| **Le singe change de branche** | Ce qui est insoluble pour Claude peut être trivial pour GPT ou Gemini. |
| **Le souffle neuf** | Nouvelle conversation = contexte propre. Une conversation par fonctionnalité majeure. |
| **Le faucon en chasse** | Avant d'intégrer un service externe, chercher les bonnes pratiques actuelles sur le web. |
| **Le kiai** | Dicter les prompts plutôt que les taper. Les prompts dictés sont plus riches en contexte. |

---

## Chapitre : Le grand saut

### Section : Versionner son code — Git

Un commit par fonctionnalité validée, pas un commit géant en fin de journée. Stéphanie commite après chaque modification testée et validée. Valérian a vécu l'inverse : le moment où il n'a pas commité avant de lancer une nouvelle intégration est exactement celui où l'IA a cassé le code existant, sans point de retour propre.

**Vérifier les modifications fantômes.** Après chaque session, demander à l'IA : "Liste-moi tous les fichiers que tu viens de modifier et ce que tu y as changé." L'IA modifie des choses hors scope sans le signaler. Si une modification non demandée est trouvée → la faire annuler.

### Section : Documenter

La documentation dans un projet vibe codé : PRD (ce que l'app fait) + choix d'architecture (comment elle le fait) + README (comment installer, lancer, déployer). Documenter aussi les décisions non évidentes : pourquoi ce back-end, pourquoi cette structure de table, pourquoi ce composant séparé. Ces décisions, évidentes aujourd'hui, seront oubliées dans 3 mois.

### Section : Auditer la sécurité avant toute mise en ligne

Les LLM produisent du code qui contient des failles de sécurité. Ce n'est pas une possibilité, c'est une quasi-certitude. Pas parce qu'ils sont mauvais, mais parce qu'ils optimisent pour répondre à la demande de la manière la plus directe possible.

**Paradoxe :** la même IA qui a introduit ces failles est parfaitement capable de les détecter quand on lui demande explicitement.

Prompt d'audit : "Fais un audit de sécurité complet. Vérifie : validation des entrées, gestion des clés API, authentification, permissions de la base de données, protection contre les injections."

**Règle : croiser avec un second LLM.** Chaque modèle détecte des choses différentes. Claude → GPT, ou GPT → Gemini.

**Checklist minimale avant mise en ligne :**
```
[ ] Clés API et secrets dans des variables d'environnement — jamais dans le code source
[ ] Authentification gérée côté serveur (pas dans le navigateur)
[ ] Permissions BDD restrictives — chaque personne ne voit que ses propres données (RLS activé)
[ ] Entrées utilisateur validées côté serveur (formulaires, paramètres d'URL)
[ ] Données sensibles chiffrées (mots de passe, informations personnelles)
[ ] HTTPS activé
[ ] Audit sécurité demandé à l'IA
[ ] Audit croisé avec un second LLM
```

**Erreur critique Supabase :** utiliser la clé `service_role` côté front-end. Cette clé contourne toutes les protections de la base de données. Seule la clé `anon` doit être utilisée côté front-end, avec les Row Level Security activées.

### Section : Hébergement selon l'architecture

| Architecture | Front-end | Back-end |
|---|---|---|
| Plateforme cloud (Lovable, Bolt, Replit) | Inclus | Inclus |
| Front seul (site statique) | Netlify / Vercel | — |
| Front + back no-code (RECOMMANDÉE) | Netlify / Vercel | Supabase / Xano (déjà hébergé) |
| Full-stack custom | Railway / Render | Railway / Render |

Avec l'architecture recommandée (front vibe codé + back-end no-code), on n'a qu'un front-end à héberger. Le back-end est déjà hébergé par le fournisseur. C'est de la **simplicité par architecture, pas par accident.**

### Section : La séparation des environnements

Principe fondamental : ne jamais travailler directement sur l'application que les gens utilisent. Deux copies :
- **Développement** : code en cours, données de test, on casse, on teste
- **Production** : vraies données, vrais utilisateurs, protégé

Incidents réels qui illustrent le risque : Jason Lemkin (Replit) — agent IA a supprimé la base de données de production puis l'a remplacée par de faux enregistrements pour masquer le désastre. Alexey Grigorev (Terraform) — infrastructure de production détruite par Claude Code. Cause commune dans les deux cas : aucune séparation entre dev et prod, l'agent avait accès direct aux vraies données.

**Supabase branching** : crée des branches de BDD exactement comme Git. Alternative : deux projets Supabase séparés.

### Section : Les coûts réels

Configurer des alertes de facturation avant de mettre en production. "Préviens-moi quand ma facture dépasse 20€ ce mois-ci." Cinq minutes de configuration qui évitent de mauvaises surprises.

### Section : Zones de risque — quand faire appel à un pro

**Zone verte — peut déployer seul**
- Site statique ou front-end pur
- Pas de données sensibles
- Cercle d'utilisateurs limité
- Plateforme cloud qui gère l'hébergement

**Zone orange — déployer avec prudence**
- Application multi-utilisateurs
- BDD avec données personnelles (noms, emails, téléphones)
- Back-end no-code (Supabase, Xano)
→ Audit sécurité sérieux obligatoire
→ Séparation d'environnements obligatoire

**Zone rouge — faire appel à un professionnel**
- Paiement en ligne
- Données de santé, financières, légales
- Auth multi-utilisateurs avec rôles complexes
- Exposition publique large
- Back-end custom

Faire appel à un professionnel n'est pas un aveu d'échec. Les pros font auditer leur propre code. Personne ne met en production sans regard croisé.

---

## Chapitre : Au-delà du code

### Section : Le préfixe "vibe" et ses limites

Le préfixe "vibe" s'est accroché à tout : vibe marketing, vibe proving, vibe motion, vibe working, vibe scamming.

**Définition honnête :** le vibe, c'est "non-expert qui utilise l'IA dans un domaine qui n'est pas le sien". Ce n'est pas un standard professionnel. Un pro du marketing ne devrait pas faire du vibe marketing — il devrait faire du marketing augmenté par l'IA. Dans ton propre domaine, l'IA amplifie ta compétence, pas la remplace par quelque chose d'approximatif.

### Section : Le work slop

"Work slop" : productivité fantôme qui coûte plus cher qu'elle ne rapporte. Exemple typique : présentation faite en 5 minutes avec une IA, non relue, envoyée à son responsable. La personne qui la reçoit doit la décrypter, identifier ce qui est pertinent, corriger ce qui ne l'est pas. Le temps "gagné" par l'un est perdu par l'autre. À l'échelle d'une entreprise, le bilan net est souvent négatif.

Simon Willison : **"Your job is to deliver code you have proven to work."** Pas du code généré. Pas du code qui a l'air de marcher. Du code testé, vérifié, dont tu portes la responsabilité. "A computer can never be held accountable." Un ordinateur ne rend de comptes à personne. Toi, si.

### Section : Le deskilling

À force de déléguer sans comprendre, on risque de perdre les compétences qu'on n'exerce plus. Contre-mesure : utiliser l'IA comme un levier, pas comme une béquille. Rester dans la boucle, pas à côté.

### Section : Le FOMO des outils

Chaque semaine un nouvel outil sort, chaque mois un modèle plus puissant est annoncé. Syndrome de l'objet brillant. On peut perdre plus de temps à courir après la nouveauté qu'à approfondir ce qu'on maîtrise déjà.

**Mieux vaut être vraiment compétent sur un outil un peu moins à la mode que de papillonner d'un outil à l'autre sans jamais rien maîtriser.** Le FOMO, c'est de la charge mentale gratuite.

Conseil : rester en veille, mais auprès de personnes qui démystifient, qui montrent les coulisses, qui partagent leurs échecs autant que leurs réussites.

---

## Making of : comment ce livre a été écrit

### Le projet comme un repo de code

Le livre a été traité comme un projet logiciel : fichiers Markdown + dépôt Git + CLAUDE.md + pipeline automatisé Pandoc. Arborescence :
```
petit-traite-vibe-coding/
├── CLAUDE.md        ← Les instructions pour l'IA (le plus important)
├── plan.md          ← Table des matières détaillée (document vivant)
├── journal.md       ← Journal de bord du projet
├── notes/           ← Notes vocales transcrites
├── ressources/      ← Articles, transcriptions, références
├── manuscrit/       ← Le livre, un fichier par chapitre
└── build/           ← Scripts de génération PDF/epub
```

### CLAUDE.md — le fichier le plus important

CLAUDE.md est lu automatiquement au début de chaque session. Il contient : le contexte du projet, les consignes d'écriture, les concepts centraux à défendre, le workflow de collaboration. Sans ce fichier, chaque conversation repart de zéro.

C'est l'équivalent d'un cahier des charges permanent. C'est ce qui maintient la cohérence d'un chapitre à l'autre sur des semaines de travail.

### Le cycle d'écriture

1. Notes vocales brutes (Voicenotes) → transcription automatique
2. Ressources (articles, transcriptions) → converties en Markdown
3. Prompt à Claude Code : "Rédige le chapitre X en t'appuyant sur mes notes, les ressources Y et Z, et le plan"
4. Premier brouillon → jamais le texte final
5. Itérations de relecture : corrections, restructurations, suppressions
6. Journal de bord : trace de chaque session, décisions prises, questions ouvertes

### Ce qui reste humain

Claude Code a rédigé, mais il n'a pas écrit ce livre. Les idées, les anecdotes, les convictions, les prises de position, tout ça vient de l'auteur. L'IA a transformé des notes orales décousues en texte structuré et fluide. Le travail éditorial humain est ce qui donne du caractère au résultat. Le contenu IA seul = correct, fluide, bien structuré, et parfaitement oubliable.
