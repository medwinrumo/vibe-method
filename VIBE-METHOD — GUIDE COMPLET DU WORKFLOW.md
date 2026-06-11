VIBE-METHOD — GUIDE COMPLET DU WORKFLOW
Mis à jour le 11 juin 2026. Ce guide explique chaque skill de la méthode : ce qu'il fait, qui fait quoi (toi ou Claude), quels fichiers il produit, et comment il se termine.
 
LA RÈGLE DE BASE — QUI FAIT QUOI ?
TOI (User) : tu décides, tu valides les propositions de Claude, tu réponds aux questions, tu exécutes les commandes dans ton terminal.
CLAUDE : il pose les questions, analyse, génère les documents, écrit les fichiers, guide vers l'étape suivante. Il ne prend jamais de décision à ta place.
Chaque skill a des INPUTS (ce dont il a besoin) et des OUTPUTS (ce qu'il produit). Si un input manque, le skill s'arrête et demande de lancer le skill manquant d'abord.
 
LA CHAÎNE DU WORKFLOW — LES 7 PARTIES
1. CONCEPTION : /contexte → /brief → /devis (si projet client) → /cgv → /charte → /prd → /prd-update → /prd-validate → /angles-morts (PRD)
2. ARCHITECTURE & DESIGN : /gherkin (Mode PRD) → /design (Mode A) ↔ /archi → /angles-morts (archi) → /regles → /stack
3. PLANIFICATION : /roadmap → /specs → /angles-morts (spec) → /gherkin (Mode Specs)
4. AVANT LE CODE : /readyTo-code → /setup → /prp → /avancement → /sessionCode
5. VÉRIFICATION DU CODE : /code-review → /code-review-edge-cases → /repair-edge-cases → /code-review-hostil
6. TESTS & VALIDATION : /tests → /securite → /doc-tech (Mode B) → /recette ↔ /debug → /commit → /pr
7. FIN DE PHASE : /phase-retrospective → /doc-tech (Mode A)
TRANSVERSAUX (invocables à tout moment) : /party, /impact, /avancement, /adr, /refacto, /condense
 
═══ PARTIE 1 — CONCEPTION (9 skills) ═══
Ces 9 skills définissent CE QU'ON VA CONSTRUIRE et POUR QUI, et encadrent l'engagement commercial. On ne touche pas encore au code. On réfléchit, on décide, on documente.
 
── /contexte — CONTEXTE PROJET ──
Capture tout ce qui existe AVANT que le projet commence — le client, les réunions préparatoires, les délais imposés, les contraintes héritées. Différent du brief : le context c'est ce qui est IMPOSÉ de l'extérieur. Le brief c'est ce qu'on DÉCIDE de construire.
Exemple : tu as eu une réunion avec un client qui veut une app pour son réseau RAM. /context capture : qui est ce client, quels délais il a fixés, quels outils il utilise déjà, les risques évoqués en réunion.
TOI : tu réponds aux questions (qui est le client ? quelles contraintes ? quels risques ?)
CLAUDE : pose les questions domaine par domaine, synthétise, valide avec toi, écrit le fichier
Fichier produit : [projet].context.md
Fin : Claude dit 'Prochaine étape : /brief — le contexte est posé, construire le brief structuré.'
 
── /brief — DE L'INTENTION AU BRIEF STRUCTURÉ ──
Transforme une idée vague ('je veux une app de menus') en brief précis. Claude te pose des questions dans 9 domaines : le problème, les utilisateurs, les 3-5 fonctions essentielles, le hors-scope V1, les contraintes techniques, l'architecture légère et le modèle de prestation (M1 dev sur mesure / M2 SaaS / M3 Notion — stack, services tiers, coûts récurrents estimés), les règles métier, le niveau de risque sécurité (Bas/Moyen/Élevé), les données personnelles (RGPD).
Exemple : 'je veux une app RAM' → Claude : 'Quel problème résout-elle ? Pour qui ? Si l'app ne faisait que 3 choses, lesquelles ?' → Résultat : brief de 2 pages précis, prêt pour le PRD.
TOI : tu réponds domaine par domaine — problème, utilisateurs, fonctions, hors-scope, contraintes, architecture légère, règles métier, sécurité, RGPD
CLAUDE : pose les questions une par une, fait un brainstorming sur les fonctions si nécessaire, vérifie une Quality Gate de 16 critères avant de valider
Fichier produit : [projet].brief.md
Fin : 'Prochaine étape : /devis si projet client (proposition commerciale + CGV avant de démarrer), ou /prd directement si le cadrage commercial est déjà acté.'
 
── /devis — DE L'INTENTION À LA PROPOSITION COMMERCIALE ──
Transforme le brief en proposition commerciale complète, précédée d'un récapitulatif structuré des lignes de devis (utilisable pour remplir le devis PDF formel). Se déroule en 6 étapes : qualification client via recherche exa, confirmation de l'architecture légère, estimation complète de la charge, calibrage valeur interne, conditions contractuelles, génération du document.
L'estimation est en deux parties. (1) Phases workflow vibe-method calibrées depuis les paramètres du brief : modèle M1/M2/M3, niveau de sécurité, nombre de features, stack, distribution, RGPD — chaque phase est estimée avec sa base, ses ajustements et son incertitude propre. (2) Blocs de développement estimés depuis une table de référence par pattern (auth, CRUD, temps réel, UI, intégrations) ajustée selon la stack Supabase ou Convex — grille P/M/G en fallback.
TOI : tu confirmes la qualification client, tu valides les estimations de charge phase par phase et bloc par bloc, tu confirmes les conditions contractuelles
CLAUDE : lance la recherche exa pour qualifier le prospect, estime le workflow et les blocs dev depuis le brief, calibre le prix en interne (jamais montré au client), génère la proposition
Fichier produit : [projet].proposition.md — récapitulatif lignes de devis (à copier dans le devis PDF) + détail par phase supprimable (à supprimer avant envoi au client) + proposition narrative complète
Fin : 'Lance /cgv — proposition et CGV partent ensemble au client, jamais l'une sans l'autre.'
 
── /cgv — CONDITIONS GÉNÉRALES ET PARTICULIÈRES ──
Génère le document CGV personnalisé pour le projet — Conditions Générales (tronc commun, 18 articles) + Conditions Particulières adaptées au modèle de prestation : M1 (développement sur mesure, cession PI complète après paiement), M2 (SaaS, licence d'accès non exclusive), M3 (Notion, droit d'usage non exclusif).
Points clés par modèle : M1 — cession PI après paiement intégral, maintenance corrective et écosystème incluse sans facturation, accès Git maintenu post-mission. M2 — licence d'accès, SLA, réversibilité, portabilité des données. M3 — droit d'usage, non exclusif (Medwin peut vendre le même système à d'autres clients).
TOI : tu lis et valides le document généré avant envoi
CLAUDE : lit le brief et la proposition pour identifier le modèle et les paramètres du projet, génère le document CGV en sélectionnant les CG + CP adaptés
Fichier produit : [projet].cgv.md
Fin : 'CGV générées. Proposition et CGV partent ensemble au client. Après validation client : /prd.'
 
── /charte — CHARTE GRAPHIQUE ──
Définit l'identité visuelle du projet une fois pour toutes — couleurs, typographie, ambiance, style (arrondi/angulaire, dense/aéré, dark mode, animations). Cette charte est le socle de tout ce qui sera dessiné ensuite dans le design system avec /design.
Exemple : pour une app RAM sérieuse, tu réponds 'Notion + Linear comme références visuelles, ambiance sobre et dense, palette bleu/gris, Inter comme police' → la charte encode tout ça en tokens concrets.
TOI : tu réponds sur l'ambiance, les références visuelles, les couleurs, la typo, le style, le dark mode
CLAUDE : propose des options basées sur tes réponses — tu valides ou ajustes chaque décision
Fichier produit : [projet].charte.md
Fin : 'Prochaine étape : /design Mode A — la charte est posée, construire le design system.'
[RÉVISION 2026-05-15] Avant de lancer /design Mode A, consulter ui-vocabulary.md — le lexique de référence des zones, composants et états UI (avec ASCII art illustratifs). Il permet de nommer précisément ce que tu veux sans l'inventer sur le moment.
 
── /prd — DU BRIEF AU PRD V1 ──
Le PRD (Product Requirements Document) est le plan de vol du projet. Il détaille les features, les règles métier, les user journeys (parcours utilisateur étape par étape), les NFR (performance, sécurité, accessibilité, scalabilité) et les métriques de succès. Règle absolue : si le plan de vol est faux, tout le reste sera faux.
Claude utilise l'Advanced Elicitation (Socratique, First Principles, Pre-Mortem, Red Team) et la méthode Kidlin (problème vague → précis → sous-problèmes → critère de succès). À la fin, il te donne un message prêt à copier-coller pour envoyer le PRD à 2 autres IA pour critique — c'est la cross-pollination.
TOI : tu réponds aux questions sur les features, tu décides des priorités V1/V2, tu lis le fichier PRD avant la cross-pollination et tu l'amendos si besoin
CLAUDE : structure le dialogue en 5 étapes, vérifie une Quality Gate (9 critères), génère le PRD complet, prépare le message de cross-pollination
Fichier produit : [projet].prd.md (Version 1)
Fin : 'Envoie le PRD en cross-pollination (2 autres IA : Gemini, ChatGPT), puis reviens avec /prd-update.'
 
── /prd-update — INTÉGRATION DES RETOURS → PRD V2 ──
Tu colles ici les retours bruts des autres IA. Claude les analyse, trie ce qui est pertinent vs scope creep (suggestions hors du problème défini), te présente les points un par un pour décision, génère le PRD V2.
Exemple : Gemini suggère d'ajouter une messagerie interne → Claude : 'Cette suggestion sort du brief (le problème défini était le réseau de parrainage). C'est du scope creep — V2+ ou ignorer ?'
TOI : tu colles les retours bruts, tu décides pour chaque suggestion : intégrer / ignorer / V2+
CLAUDE : trie convergences / contradictions / scope creep, présente point par point, génère le PRD V2
Fichier produit : [projet].prd.md (V2 ajoutée à la suite — V1 préservée, jamais écrasée)
Fin : 'Prochaine étape : /prd-validate.'
 
── /prd-validate — GATE DE VALIDATION DU PRD ──
Dernier contrôle avant l'architecture. Claude vérifie 3 choses : la complétude (8 zones couvertes), la traçabilité (chaque feature a un critère de succès clair), la cohérence interne (pas de contradictions entre features). BLOCKERS = on ne passe pas à /archi.
TOI : tu lis le rapport et décides si tu corriges ou si le PRD est bon
CLAUDE : lit le PRD, produit un rapport Blockers / Warnings / Verdict GO ou BLOCKERS
Fichier produit : aucun (c'est une validation, pas un livrable)
Fin si GO : 'Prochaine étape : /angles-morts sur le PRD — identifier les zones d'ombre avant de passer en architecture.' Fin si BLOCKERS : retour à /prd ou /prd-update.
 
 
── /angles-morts — ZONES D'OMBRE ──
Examine un document (PRD, architecture, spec) pour en extraire ce qui N'EST PAS écrit — les hypothèses implicites, les scénarios non couverts, les décisions non prises, les risques non nommés, les dépendances cachées. Ce skill part du principe que tout document contient des angles morts que son auteur ne voit pas parce qu'il est trop proche du sujet.
Exemple : le PRD d'une app de prise de rendez-vous dit 'l'utilisateur peut annuler'. /angles-morts signale : quel délai minimum avant l'annulation ? Le prestataire est-il notifié ? Que se passe-t-il si le créneau est déjà payé ? Ces questions ne sont pas dans le PRD — elles sont dans ses angles morts.
Modèle recommandé : T3 — Opus (raisonnement profond requis).
TOI : tu indiques le document à analyser, tu décides pour chaque zone d'ombre : Traiter maintenant / Accepter le risque / Hors scope
CLAUDE : classe les zones d'ombre en 5 catégories (hypothèses implicites, scénarios non couverts, décisions non prises, risques non nommés, dépendances cachées), produit pour chaque item : Observation / Question à trancher / Impact si ignoré
Fichier produit : aucun (les décisions alimentent le document source — PRD, archi ou spec)
Fin : 'Angles morts traités. Prochaine étape : [skill suivant selon la position dans le flow].'
Note : ce skill est invoqué à 3 gates — après /prd-validate (sur le PRD), après /archi (sur l'architecture), après /specs (sur la spec de la feature).
 
═══ PARTIE 2 — ARCHITECTURE & DESIGN (5 skills) ═══
Ces skills définissent COMMENT on va construire — la structure du code, les modules, les règles, la stack technique, et le design system.
 
── /gherkin (Mode PRD) — VALIDATION DES FEATURES ──
Tente d'écrire des scénarios de test pour chaque feature du PRD. La règle du 'Alors' : le résultat doit être exact et vérifiable. 'Alors l'utilisateur est content' = invalide. 'Alors il est redirigé vers /dashboard' = valide. Si une feature ne peut pas être décrite en scénario clair, c'est qu'elle est encore trop floue.
Exemple : feature 'Intégration d'un RAM' → Claude tente d'écrire le 'Alors' et découvre que le PRD ne dit pas ce qui se passe après la soumission du formulaire → feature ambiguë, retour au PRD avant l'archi.
TOI : tu lis le rapport et retournes au PRD si des features sont ambiguës
CLAUDE : génère les scénarios, classe en claires/ambiguës, produit un verdict GO ou RETOUR PRD
Fichier produit : aucun en Mode PRD (validation uniquement)
Fin si GO : 'Prochaine étape : /archi — les features sont validées sur le fond, construire l'architecture.'
 
── /design (Mode A) — DESIGN SYSTEM ──
Produit le design system complet — composants UI, écrans, états de chaque élément, parcours de navigation. Ce fichier est donné à Claude Design (outil externe) pour créer les maquettes. Se construit EN ALLER-RETOUR avec /archi : les écrans révèlent des modules manquants, l'archi précise les états des composants.
Exemple : en listant les écrans de l'app RAM, Claude identifie qu'il faut un composant 'carte de statut' avec 4 états (actif, inactif, en intégration, perdu de vue). L'archi précise que cet état vient du module /membres.
TOI : tu valides les parcours clés, les composants, les états proposés
CLAUDE : lit le PRD et la charte, propose les écrans, inventorie les composants, structure le design system
Fichier produit : [projet].design.md (donné à Claude Design pour exécution)
Fin : 'Mode A → retour à /archi, itérer jusqu'à cohérence design ↔ architecture.'
[RÉVISION 2026-05-15] Quatre points issus du test Claude Design (TeamTasks, 2026-05-15) :
1. One-shot ou two-step — première décision à prendre en Mode A, avant de produire quoi que ce soit. One-shot (≤ 6 écrans, 1 type d'utilisateur, navigation simple) : un seul [projet].design.md contenant design system + écrans, donné à Claude Design en une passe. Two-step (> 6 écrans, plusieurs rôles, navigation complexe) : Passe 1 → [projet].design-system.md (tokens + composants uniquement) → Claude Design produit la référence. Passe 2 → [projet].design-screens-[batch].md par groupe d'écrans, chacun incluant la référence complète aux tokens et composants de la Passe 1. Règle critique : Claude Design n'a aucune mémoire d'une session à l'autre — la cohérence entre passes dépend entièrement de la présence de cette référence dans chaque document.
2. Précision absolue — Claude Design n'interrompt jamais pour demander une clarification : il interprète et produit. Chaque décision non prise dans [projet].design.md est une décision prise seul par Claude Design. Nommer chaque zone, chaque composant, chaque état explicitement — rien ne doit être laissé à l'interprétation.
3. Consulter ui-vocabulary.md en amont — zones d'écran (header fixe, contenu scrollable, bottom bar), composants courants (carte vs fond, badge, tab bar), états (hover, disabled, chargement...) et propriétés visuelles (border-radius, ombre, densité). Le lexique est disponible dans le repo vibe-method.
4. Révision in-browser obligatoire après Mode B — avant de passer à /roadmap, parcourir l'interface dans le navigateur et corriger les défauts visuels et UX directement dans le code. C'est le bon moment : le code est propre, rien de métier n'est encore construit dessus.
 
── /archi — ARCHITECTURE MODULAIRE ──
Définit la structure du code — les modules, leurs responsabilités, les règles silo (qui peut appeler quoi), les contrats d'interface (ce que chaque module expose), les décisions de sécurité, le backup et la conformité RGPD.
La règle silo : un module peut APPELER les fonctions d'un autre, mais ne peut PAS MODIFIER son code. C'est cette règle qui évite les spaghettis. Claude utilise le mécanisme A/P/C (Approfondir / Perspectives / Continuer) à chaque décision structurante.
Exemple app RAM : modules /auth (identité), /membres (réseau), /onboarding (parcours), /dashboard. Règle silo : /onboarding peut appeler /membres, mais ne touche JAMAIS au code de /auth.
TOI : tu valides chaque décision (modules, stack, RGPD, backup) via le menu A/P/C
CLAUDE : lit le PRD, propose les modules, vérifie une Quality Gate de 12 critères, génère l'archi et les blocs à ajouter dans CLAUDE.md
Fichiers produits : [projet].archi.md + 2 blocs (Architecture + Sécurité) à intégrer dans le CLAUDE.md du projet
Fin : 'Prochaine étape : /angles-morts sur l'architecture — identifier les zones d'ombre avant d'extraire les règles — puis /regles.'
 
── /regles — RÈGLES NON-ÉVIDENTES POUR LE LLM ──
Documente les pièges, patterns interdits/obligatoires, et décisions contra-intuitives du projet. Ce fichier est lu par Claude à chaque session de code. Règle d'or : si c'est évident, on ne l'écrit pas. Si ça peut surprendre une IA généraliste, on l'écrit.
Exemple : 'Ne jamais passer req.body directement à un update Supabase — whitelist les champs acceptés. Raison : un utilisateur pourrait sinon modifier is_admin.'
TOI : tu réponds à 7 questions (nommage, pièges stack, règles métier non-évidentes, patterns interdits/obligatoires, environnements, décisions contra-intuitives)
CLAUDE : lit l'archi et le PRD en silence, pose des questions ciblées, génère le fichier (idéalement < 60 lignes)
Fichier produit : [projet].regles.md
Fin : 'Prochaine étape : /stack — les règles sont posées, investiguer la stack.'
 
── /stack — INVESTIGATION TECHNIQUE ──
Spike technique approfondi de chaque outil de la stack — versions actuelles, limites du free tier, gotchas (comportements contre-intuitifs), sécurité, APIs clés. Claude fait des web searches systématiques. Doctrine : 'Aucun verdict sans source primaire.'
Exemple : Claude découvre que Supabase free tier met la base en pause après 1 semaine d'inactivité. Sans ce finding, l'app aurait semblé plantée le premier week-end sans utilisation.
TOI : tu lis les findings critiques et décides si quelque chose change dans l'archi ou la roadmap
CLAUDE : lance des web searches sur chaque outil, documente 7 points par outil (versions, free tier, gotchas, sécurité, APIs, compatibilité, compatibilité IA)
Fichier produit : [projet].stack.md (document permanent, lu à chaque session de code)
Fin : 'Prochaine étape : /roadmap — la stack est documentée, construire la roadmap.'
 
═══ PARTIE 3 — PLANIFICATION (3 skills) ═══
 
── /roadmap — PLAN D'EXÉCUTION ──
Organise le développement en phases ordonnées — dans quel ordre construire les modules, quelles dépendances, ce qui peut être parallélisé. C'est le plan d'exécution, pas un planning de dates.
Exemple app RAM : Phase 0 (socle : config, auth, BDD), Phase 1 (/membres — bloquant pour tout le reste), Phase 2 (/onboarding et /dashboard en parallèle car indépendants).
TOI : tu valides l'ordre des phases, tu signales si quelque chose te semble mal ordonné
CLAUDE : analyse les dépendances depuis le PRD et l'archi, génère la roadmap phasée, vérifie 6 critères
Fichier produit : [projet].Rmap.md
Fin : 'Prochaine étape : /specs — rédiger les specs feature par feature en commençant par la Phase 1.'
 
── /specs — USER STORY AU FORMAT A4 ──
Rédige les specs d'UNE feature à la fois — une user story avec les règles de gestion, les cas limites et les cas d'échec. UN FICHIER PAR FEATURE. Signal d'alerte : si la story génère plus de 5 règles de gestion → la feature est trop large, il faut la découper.
Exemple : feature 'Intégration d'un nouveau RAM' → 'En tant que tuteur, je souhaite intégrer un nouveau RAM afin de l'accueillir dans le réseau. Règles : max 5 filleuls par tuteur. Cas d'échec : invitation expirée après 7 jours.'
TOI : tu réponds sur les acteurs, les règles métier, les cas limites et les cas d'échec
CLAUDE : lit le PRD, l'archi et la roadmap, vérifie la cohérence (feature dans le PRD ? silo respecté ? RGPD ?), génère la spec
Fichier produit : [projet].spec.[feature].md (un fichier par feature)
Fin : 'Prochaine étape : /angles-morts sur la spec — identifier les scénarios manquants — puis /gherkin Mode Specs.'
 
── /gherkin (Mode Specs) — LA DÉFINITION DE 'DONE' ──
Génère les scénarios de test complets pour une feature — happy path (cas nominal), cas limites (frontières), cas d'échec (erreurs attendues). Ces scénarios deviennent LA DÉFINITION DE 'DONE' : la feature est terminée quand tous les scénarios passent. /tests et /recette lisent ce fichier — ils ne le régénèrent pas.
Exemple : 3 scénarios pour 'Intégration' : (1) happy path : tuteur qui intègre un RAM avec succès, (2) cas limite : 5ème filleul accepté, 6ème refusé, (3) cas d'échec : invitation expirée après 7 jours.
TOI : tu valides les scénarios avant sauvegarde, tu peux demander d'en ajouter ou modifier
CLAUDE : lit la spec, génère les 3 types de scénarios, présente avant de sauvegarder
Fichier produit : [projet].gherkin.[feature].md (source de vérité pour /tests et /recette)
Fin : 'Prochaine étape : /readyTo-code — vérifier que tout est en place avant de coder.'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PARTIE 4 — AVANT LE CODE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
À ce stade, toute la réflexion est terminée. On a le produit défini (PRD), l'architecture choisie, les règles métier capturées, la stack validée, la roadmap planifiée, et les specs écrites. Avant de toucher une seule ligne de code, trois vérifications s'imposent : est-on vraiment prêt ? L'environnement technique tourne-t-il ? Et Claude a-t-il en tête tout ce dont il a besoin ?
── /readyTo-code ──
Rôle : gate de validation avant de commencer le développement. Ce skill ne produit aucun fichier — c'est un feu vert ou un feu rouge.
Ce que fait Claude : il vérifie la présence et la cohérence de 5 éléments critiques. Si l'un manque ou est incohérent, il bloque et demande à User de le compléter avant de continuer.
[projet].prd.md — existe et contient une version validée
[projet].archi.md — existe et est cohérent avec le PRD
[projet].spec.[feature].md — au moins une spec pour la phase à coder
[projet].prp.md — le document condensé de démarrage existe
[projet].avancement.yaml — le sprint tracker est initialisé
Exemple concret — app RAM réseau : avant de coder le module 'Scan réseau', Claude vérifie que la spec du scanner est présente, que l'archi décrit bien le module Network dans le bon silo, et que le PRP mentionne les contraintes de sécurité réseau. S'il manque la spec → bloqué. User lance /specs d'abord.
Comment ça se termine : Claude affiche un récapitulatif des 5 points avec ✅ ou ❌ pour chacun. Si tout est ✅ → 'Feu vert — tu peux lancer /setup.' Si un ❌ → 'Feu rouge — résoudre [X] avant de continuer.'
── /setup ──
Rôle : bootstrap technique — créer l'environnement de développement depuis zéro. Ce skill est particulier : c'est User qui exécute les commandes, pas Claude. Claude donne les instructions étape par étape.
Pourquoi User exécute : les commandes touchent au système local (création de dossiers, installation de dépendances, variables d'environnement, premier git commit). Claude ne peut pas faire ces actions à la place de User — il les guide.
Ce que fait Claude : il s'appuie sur [projet].stack.md pour connaître la stack choisie, puis génère les instructions dans l'ordre suivant :
Prérequis — vérifier Node, Git, les CLIs nécessaires (Vercel, Supabase, Convex)
Création du repo — git init, structure de dossiers selon [projet].archi.md
Installation des dépendances — npm install avec les packages de la stack
.env.example — liste de toutes les variables nécessaires, sans les valeurs secrètes
Premier lancement — vérifier que l'app démarre sans erreur
Premier commit — 'chore: initial setup' avec .gitignore, .env dans .gitignore obligatoirement
Exemple concret — app Minou (chat multi-LLM, stack Convex) : Claude donne les commandes 'npm create vite@latest minou -- --template react-ts', puis 'cd minou && npm install convex', puis les instructions pour npx convex init. À chaque étape, Claude attend que User confirme que ça a tourné avant de passer à la suite.
Règle sécurité absolue : .env ne doit JAMAIS être commité. Claude vérifie que .gitignore contient .env avant de donner l'instruction du commit.
Comment ça se termine : Claude annonce 'Setup terminé — l'app tourne. Lance /prp pour créer le document de démarrage de session.'
── /prp ──
Rôle : créer le Project Ready Prompt — un document condensé (< 1000 tokens) qui sera chargé au début de chaque session de code. C'est la mémoire portable du projet.
Pourquoi < 1000 tokens : chaque session de code commence avec Claude qui n'a aucun contexte. Le PRP doit être assez court pour tenir dans le prompt système sans grignoter la fenêtre de contexte, mais assez dense pour donner tout l'essentiel.
Ce que contient le PRP (ce que Claude agrège depuis tous les artefacts produits) :
Contexte projet en 2-3 phrases : qui, quoi, pour quoi faire
Stack technique : les 4-5 outils principaux et leur rôle
Modules architecturaux : liste des silos et ce qu'ils contiennent
Règles critiques : les 5 règles non-évidentes les plus importantes de [projet].regles.md
Contraintes de sécurité : RLS, .env, validation serveur — rappel compact
Feature en cours : quelle phase, quelle feature, statut actuel
Exemple concret — app menu de la semaine : le PRP dit en 20 lignes que c'est une app de gestion de menus hebdomadaires, stack React + Supabase, que l'utilisateur est authentifié avec Supabase Auth, que les menus appartiennent à l'utilisateur (RLS obligatoire sur chaque table), que le module Calendar gère les semaines, que le module Recipes gère les plats, et que la phase 1 en cours couvre la création + édition de menus.
Comment ça se termine : Claude affiche le PRP complet pour relecture et demande 'Ce PRP est-il complet et exact ? On le sauvegarde ?' → User valide → fichier écrit → 'Lance /avancement pour initialiser le tracker de sprint.'
── /avancement ──
Rôle : créer et tenir à jour le fichier YAML de suivi des fonctions du projet. C'est le tracker de sprint qui répond à la question : 'Où en est-on ?'
Structure du fichier généré ([projet].avancement.yaml) :
phase: numéro et nom de la phase en cours
features: liste avec pour chaque feature son statut (todo / in_progress / done / blocked)
last_updated: date de la dernière mise à jour
notes: observations importantes (blocages, décisions prises en cours de dev)
Qui fait quoi : à l'init (/avancement mode init), Claude génère le YAML depuis la roadmap. Ensuite, /avancement est invocable à tout moment pour mettre à jour un statut — User dit 'marque Login comme done', Claude met à jour le fichier et le commite.
Exemple concret : après /setup, le YAML liste toutes les features de la Phase 1 en statut 'todo'. Après avoir codé et validé en recette la feature 'Authentification', User lance /avancement et dit 'Authentification : done' → Claude met à jour le YAML, commite, pousse.
Comment ça se termine : à l'init → 'Tracker initialisé — [N] features en todo. Lance /sessionCode pour démarrer le développement.' En mise à jour → 'Statut mis à jour. [N] features restantes en todo, [M] done.'
── /sessionCode ──
Rôle : sas d'entrée obligatoire avant chaque session de développement. Ce skill ne code rien — il prépare Claude à coder correctement. Sans /sessionCode, on ne touche pas au code.
Pourquoi obligatoire : à chaque nouvelle session, Claude commence sans contexte. /sessionCode charge le PRP, confirme la feature à coder, rappelle les règles critiques, et détermine le mode de travail. Sans cette étape, Claude risque de coder dans la mauvaise direction ou d'ignorer des contraintes importantes.
Les 4 vérifications du sas :
Chargement du PRP — Claude lit [projet].prp.md et confirme avoir compris le contexte
Confirmation de la feature — 'Quelle feature on code aujourd'hui ?' → vérification dans /avancement que c'est bien 'in_progress' ou la prochaine 'todo'
Rappel des règles critiques — affichage des 5 règles les plus importantes du [projet].regles.md pour la feature en cours
Détermination du mode — TDD ou Standard
TDD vs Standard — la règle :
Module métier ou sécurité (authentification, paiement, RLS, calculs critiques) → TDD. Les tests sont écrits AVANT le code. Si le test passe sans code → le test est mal écrit.
Module UI ou technique (composants React, routing, mise en page) → Standard. Code d'abord, tests ensuite si nécessaire.
Exemple concret — app RAM réseau, feature 'Détection d'intrusion' : /sessionCode charge le PRP, confirme que c'est la feature suivante en todo, rappelle la règle 'aucune alerte sans vérification double-source' et 'les logs de sécurité sont immuables', détermine mode TDD car c'est du métier sécurité. Claude annonce 'Mode TDD — j'écris les tests de détection d'intrusion avant le code. Prêt ?'
Comment ça se termine : 'Contexte chargé. Feature : [X]. Mode : [TDD/Standard]. Règles critiques rappelées. On commence — décris-moi le premier comportement à implémenter.'
→ Médwin donne le go, et le développement commence.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PARTIE 5 — DÉVELOPPEMENT ET REVUE DE CODE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Le développement en lui-même (le code au sens strict) n'est pas un skill — c'est la séquence [sessionCode] → [code] qui se déroule en dialogue User/Claude. Ce qui EST des skills, c'est la chaîne de revues qui suit chaque feature codée. Aucune feature ne passe en recette sans avoir traversé ces quatre filtres.
── /code-review ──
Rôle : revue structurelle et sécurité avant de considérer la feature terminée. C'est la revue 'est-ce que ce code est sain ?'
Ce que fait Claude : il passe le code en revue sur 4 axes principaux.
Structure — le code respecte-t-il l'architecture définie ? Pas de violation des silos (un module ne modifie pas le code d'un autre module).
Sécurité — RLS en place sur chaque table créée, pas de clé API en front, validation des entrées côté serveur, authentification ET autorisation vérifiées.
Cohérence — le code correspond-il à la spec ? Chaque critère d'acceptance de la User Story est couvert.
Dette technique — y a-t-il des raccourcis risqués ? Si oui, les signaler, pas les ignorer.
Output : un rapport de revue inline dans la conversation. Pas un fichier séparé sauf si User le demande.
Comment ça se termine : 'Revue structurelle terminée. [N] points à corriger / code sain. Lance /code-review-edge-cases pour la chasse aux cas non gérés.'
── /code-review-edge-cases ──
Rôle : énumération mécanique et exhaustive de tous les cas limites non gérés dans le code. C'est la revue 'qu'est-ce qui peut mal tourner ?'
Ce que fait Claude : il parcourt chaque fonction, chaque route, chaque formulaire, et liste TOUS les chemins alternatifs non traités. La méthode est systématique, pas intuitiv.
Entrées invalides — champ vide, type incorrect, valeur hors plage, caractères spéciaux, SQL injection
Accès non autorisé — utilisateur non connecté, utilisateur connecté mais accès à la ressource d'un autre
États intermédiaires — double soumission d'un formulaire, retour navigateur en plein milieu d'une transaction
Limites de données — liste vide, liste avec 10 000 éléments, donnée manquante dans un objet imbriqué
Exemple concret — feature 'Création de menu hebdomadaire' : Claude identifie que le code ne gère pas le cas où la semaine démarre un dimanche dans certains pays, ni le cas où un utilisateur essaie de créer deux menus pour la même semaine (doublon), ni le cas où le nom du menu contient des caractères HTML.
Comment ça se termine : liste numérotée de tous les cas non gérés, triés par priorité (bloquant / important / mineur). 'Lance /repair-edge-cases pour les traiter un par un.'
── /repair-edge-cases ──
Rôle : traiter les cas limites identifiés par /code-review-edge-cases, un par un, dans l'ordre de priorité.
Principe fondamental : jamais de correction batch. Claude traite un cas, explique ce qu'il a fait, attend que User valide avant de passer au suivant. Ça évite d'introduire de nouveaux bugs en réparant trop vite.
Comment ça se termine : 'Tous les cas bloquants et importants sont traités. [N] cas mineurs reportés (liste). Lance /code-review-hostil pour la revue cynique.'
── /code-review-hostil ──
Rôle : revue cynique et adversariale. Claude part du principe que le code est cassé et cherche à le prouver. C'est la revue la plus dure — volontairement.
Pourquoi ce skill existe : les revues précédentes (/code-review et /code-review-edge-cases) cherchent ce qui ne va pas. /code-review-hostil part du principe que tout va mal et cherche à démontrer pourquoi. L'angle d'attaque est différent — et trouve ce que les autres manquent.
Les 10 angles systématiques (Claude doit en trouver AU MOINS 10 problèmes) :
Race conditions — deux requêtes simultanées qui se marchent dessus
Fuite de données — un utilisateur peut-il lire les données d'un autre ?
Sécurité des dépendances — les packages utilisés ont-ils des vulnérabilités connues ?
Performance sous charge — que se passe-t-il avec 1000 utilisateurs simultanés ?
Gestion des erreurs réseau — timeout, perte de connexion en plein milieu d'une opération
Injection et XSS — chaque champ de saisie libre est suspect
Dépendances implicites — le code assume-t-il qu'un autre module est prêt ?
Logique métier incorrecte — le code fait-il vraiment ce que la spec dit ?
Configuration et déploiement — le code fonctionne en local mais pas en prod ?
Observabilité — si ça plante en prod, peut-on le diagnostiquer ?
Comment ça se termine : rapport avec minimum 10 problèmes catégorisés (critique / sérieux / mineur). User décide lesquels traiter maintenant vs reporter. 'Revue hostile terminée. [N] problèmes critiques à traiter avant de continuer.'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PARTIE 6 — TESTS ET VALIDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Après les revues de code, on valide que l'app fonctionne. Deux niveaux : les tests automatisés (vérifient que le code ne régresse pas), et la recette manuelle (vérifie que l'app correspond à ce que l'utilisateur attend). Claude annote également le code de JSDoc avant la recette pour faciliter la maintenance future.
── /tests ──
Rôle : écrire les tests automatisés selon la doctrine de test du projet. Doctrine de référence : tests.md.
Trois niveaux de tests :
Tests unitaires — une fonction, un résultat attendu. Isolés, rapides, nombreux. Pour la logique métier pure.
Tests d'intégration — plusieurs modules qui interagissent. Testent les connexions entre composants (ex : appel API → base de données → réponse).
Tests Playwright (E2E) — simulent un vrai utilisateur dans un vrai navigateur. Testent les parcours complets de l'interface.
Règle anti-auto-validation : Claude n'écrit pas des tests qui valident son propre code sans être challenger. Les scénarios Gherkin (/gherkin Mode Specs) sont LA définition de 'done' — les tests doivent les incarner, pas les paraphraser.
Exemple concret — feature 'Authentification' : Claude écrit un test unitaire pour la fonction de validation du mot de passe (> 8 caractères, un chiffre), un test d'intégration qui vérifie que Supabase renvoie bien un token valide après connexion, et un test Playwright qui simule un utilisateur qui se connecte, vérifie qu'il arrive sur le dashboard, puis se déconnecte.
Comment ça se termine : '[N] tests écrits. Suite de tests verte. Lance /securite pour l'audit de sécurité.'
── /securite ──
Rôle : audit de sécurité automatique après chaque feature, avant le merge dans main. Bloquant si un point échoue — pas de merge tant que ce n'est pas résolu.
Note importante : les règles de sécurité de base (RLS, pas de clé en front, validation serveur) sont TOUJOURS actives — même sans invoquer /securite. Ce skill est l'audit systématique qui vérifie leur application sur le code produit.
Deux modes : check (après chaque feature, automatique) et audit (avant chaque mise en production, obligatoire pour les niveaux de risque moyen et élevé).
Comment ça se termine : 'Audit sécurité OK — lance /doc-tech Mode B.' Si échec : merge bloqué jusqu'à correction.
── /doc-tech Mode B ──
Rôle : annoter le code source avec des commentaires JSDoc ou TSDoc. Ce mode B s'exécute DANS le code, pas dans un fichier séparé.
Pourquoi annotate-t-on le code avant la recette et pas après : si un bug est trouvé en recette et qu'on modifie le code, les annotations sont déjà là — elles guident la correction. Et si on annotait après, on risque de documenter un bug et pas la correction.
Ce que Claude annote :
Chaque fonction publique : ce qu'elle fait, ses paramètres, ce qu'elle retourne, les exceptions possibles
Les contraintes non-évidentes : pourquoi ce choix d'implémentation, quelle règle métier est encodée ici
Les effets de bord : si cette fonction modifie un état global ou déclenche un side effect
Comment ça se termine : 'Code annoté. Lance /recette pour la validation manuelle.'
── /recette ──
Rôle : validation manuelle de l'app par User, guidée par Claude. Ce skill orchestre la séquence : génération du cahier de recettes → User teste → résultat reporté → bug ⇒ debug → reprise.
Qui fait quoi : Claude génère le cahier structuré (scénarios Gherkin + étapes précises + résultat attendu). User exécute chaque recette dans le navigateur et reporte ✅ ou ❌.
Format d'une recette :
Scénario Gherkin : Étant donné [contexte] / Lorsque [action] / Alors [résultat attendu]
Étapes : actions précises (‘Aller sur /login, remplir le champ email avec test@test.com, cliquer Connexion’)
Résultat attendu : ce qui doit se passer exactement (‘Redirection vers /dashboard avec message Bonjour [prénom]’)
Règle : une seule recette à la fois. User ne passe pas à la suivante tant que la précédente n'est pas validée ou le bug résolu. Aucun saut autorisé.
Audit sécurité léger : une fois toutes les recettes ✅, Claude propose un audit Mozilla Observatory + securityheaders.com sur l'URL de staging avant de clôturer la phase.
Comment ça se termine : 'Phase [N] validée — [N] recettes ✅, [N] bugs détectés et corrigés. Lance /commit pour commiter chaque feature validée — une feature = un commit — puis /pr, puis /phase-retrospective.'
── /debug ──
Rôle : diagnostiquer et corriger un bug détecté pendant la recette. Ce skill est déclenché AUTOMATIQUEMENT par /recette dès qu'un ❌ est signalé. On ne le lance pas manuellement.
Séquence fixée en 3 tentatives :
Tentative 1 — diagnostic depuis les informations collectées (contexte, reproductibilité, message d'erreur, capture écran). Correction proposée et appliquée. User reteste.
Tentative 2 — si ❌ encore : Claude change d'angle complètement, relit le flux depuis le début. JAMAIS la même correction deux fois.
Tentative 3 avec web search — si ❌ encore : Claude lance une recherche web sur le comportement observé + framework concerné. Propose une correction basée sur les résultats.
Si après 3 tentatives le bug persiste → bug déclaré BLOQUANT. Recette suspendue. User décide : nouvelle approche technique (session dédiée) ou contournement temporaire si non-critique.
Règle fondamentale : Claude corrige toujours le CODE, jamais les tests ni les recettes. Si la recette 'semble incorrecte', c'est le code qui doit changer pour correspondre à la recette — pas l'inverse.
Comment ça se termine : 'Bug Recette [N]-[M] résolu ✅. On reprend le cahier à la Recette [N]-[M+1].'
── /commit — COMMIT PROPRE ──
Génère un message de commit au format Conventional Commits depuis le diff Git, le soumet à validation, puis exécute le commit. Ce skill est global — il est utilisé dans tous les projets, pas seulement en vibe-method. Claude doit l'utiliser dès qu'un commit est à faire, quel que soit le projet.
Format Conventional Commits : type(scope): description — types valides : feat, fix, refactor, test, docs, chore, style.
Exemple : 'feat(auth): ajouter la connexion Google OAuth' plutôt qu'un message vague comme 'update login'.
Modèle recommandé : T1 — Haiku (optionnel). Tâche mécanique — Sonnet fonctionne parfaitement.
TOI : tu valides le message proposé, tu confirmes avant exécution
CLAUDE : lit git status + git diff, lit le contexte depuis la spec ou le fichier avancement, propose un message structuré, attend la validation, exécute le commit
Fichier produit : aucun (commit dans le dépôt Git)
Fin : 'Commit créé. Lance /pr si tu veux ouvrir une Pull Request.'
 
── /pr — PULL REQUEST ──
Génère une Pull Request depuis la spec de la feature et le log Git — titre formaté, corps structuré (description, changements, checklist de tests, référence spec) — puis exécute via gh pr create.
Exemple : après avoir commité la feature 'Intégration d'un RAM', /pr génère une PR avec le titre 'feat(membres): intégration nouveau RAM' et un corps structuré qui référence la spec correspondante.
Modèle recommandé : T1 — Haiku (optionnel). Tâche mécanique — Sonnet fonctionne parfaitement.
TOI : tu valides le titre et le corps de la PR avant envoi
CLAUDE : lit la spec de la feature + git log, génère le titre et le corps de la PR, attend validation, exécute gh pr create --title --body --base main
Fichier produit : aucun (Pull Request créée sur GitHub)
Fin : 'Pull Request créée. Prochaine étape : /phase-retrospective Mode Léger.'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PARTIE 7 — CLÔTURE DE PHASE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
La phase est validée. Avant de démarrer la suivante, on capture ce qu'on a appris et on écrit la documentation de référence. Ces deux étapes prennent 30 minutes — et font gagner des heures à chaque phase suivante.
── /phase-retrospective ──
Rôle : rétrospective en deux modes — Mode Léger (fin de chaque phase) et Mode Complet (fin d'un ensemble de phases).
Mode Léger : 4 questions rapides pendant que c'est frais (ce qui a bien marché, bloqué, surpris, dette). Journal de 4 lignes écrit immédiatement après /recette. Alimente le Mode Complet.
Mode Complet : lecture de tous les journaux Mode Léger de l'ensemble, puis analyse des logs ([projet].log.md) pour reconstituer le temps réel passé par phase — identification des phases depuis les sujets travaillés dans chaque session (une session peut couvrir deux phases : les deux sont comptabilisées). Comparaison estimé vs réel depuis [projet].proposition.md si disponible → tableau de calibration appendé au compte-rendu. Puis 5 questions analytiques, suivi des action items précédents, nouveaux action items, preview de l'ensemble suivant.
Pourquoi l'analyse des logs : la calibration estimé vs réel sur plusieurs projets permet d'améliorer progressivement les estimations de /devis. C'est la boucle d'apprentissage de la méthode.
Output : [projet]-retrospective.md (journaux de phase + comptes-rendus d'ensemble, appendés à la suite).
Comment ça se termine : 'Rétrospective écrite. [N] action items. Lance /doc-tech Mode A pour la documentation de référence.'
── /doc-tech Mode A ──
Rôle : écrire la documentation technique de référence de la phase — vue d'ensemble développeur. C'est le document qu'un nouveau développeur lirait pour comprendre le projet.
Différence avec Mode B : Mode B annotait le code (JSDoc dans les fichiers). Mode A écrit une documentation narrative dans un fichier Markdown séparé — architecture, modules, décisions, comment démarrer le projet.
Ce que contient [projet].doc-tech.md :
Vue d'ensemble : quel problème résout cette app, pour qui, avec quelle stack
Architecture : carte des modules, silos, dépendances entre eux
Démarrage : commandes pour lancer le projet en local, variables d'environnement requises
Décisions clés : les ADR en synthèse (pourquoi Convex et pas Firebase, pourquoi ce pattern d'auth)
Gotchas : ce qui n'est pas évident et que tout développeur doit savoir
Comment ça se termine : 'Documentation écrite dans [projet].doc-tech.md. Phase [N] clôturée. La prochaine phase démarre par /sessionCode.'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SKILLS TRANSVERSAUX — INVOCABLES À TOUT MOMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Ces skills n'ont pas de position fixée dans la chaîne. On les invoque quand le besoin se présente, quelle que soit la phase du workflow. Ce sont des outils de réflexion et de gouvernance.
── /party ──
Rôle : obtenir plusieurs perspectives indépendantes sur une décision difficile. 'Party' = plusieurs sous-agents spawnnés en parallèle, chacun avec un angle différent.
Quand l'utiliser : face à un choix structurant où on hésite. Par exemple : 'Dois-je utiliser Convex ou Supabase pour ce projet ?', 'Dois-je couper cette feature en deux ou la garder unie ?', 'Cette architecture tient-elle vraiment à l'échelle ?'
Exemple concret : User hésite entre deux approches pour l'authentification. /party spawne 3 agents : l'un argumente pour Supabase Auth, l'autre pour Auth.js, le troisième joue l'avocat du diable sur les deux. User lit les 3 perspectives et décide en connaissance de cause.
── /impact ──
Rôle : analyser les conséquences d'un changement sur TOUS les artefacts du projet. Avant de modifier quelque chose d'important, on demande à Claude : qu'est-ce que ça impacte ?
Ce que Claude analyse : le PRD (la décision métier change-t-elle ?), l'archi (des modules sont-ils affectés ?), les specs (des User Stories deviennent-elles incohérentes ?), les tests (quels tests faut-il réécrire ?), la roadmap (le planning est-il décalé ?).
Exemple concret : User décide d'ajouter une feature 'partage de menu avec un ami' non prévue dans le PRD. /impact révèle que ça touche le modèle de données (nouvelle table shared_menus), la RLS (un menu peut maintenant être lu par un non-propriétaire), et deux specs existantes à mettre à jour.
── /adr ──
Rôle : capturer une décision architecturale avant que le contexte qui l'a motivée soit perdu. ADR = Architectural Decision Record.
Les 4 questions que Claude pose :
Décision prise — formulée en une phrase
Alternatives écartées — et pourquoi chacune a été rejetée
Raisonnement — ce qui a fait pencher la balance
Conditions de révision — dans quelles circonstances cette décision devrait être remise en question
Règle : jamais réécrire un ADR. Si une décision est révisée, on crée un nouvel ADR qui référence l'ancien. C'est un journal, pas un document vivant.
── /refacto ──
Rôle : refactoring guidé d'un module dégradé. Ce skill exige une SESSION DÉDIÉE — on ne refactorise pas en plein milieu d'une session de code normal.
Quand déclencher /refacto :
Avant de coder une nouvelle feature sur un module dégradé (ajouter sur du code pourri = empirer le pourri)
En fin de phase, si la dette technique accumulée est trop lourde
On demand : quand User sent que quelque chose pue
Séquence : diagnostic → liste des problèmes classés par priorité → exécution étape par étape avec validation entre chaque étape. Jamais de refacto batch.
── /condense — CONDENSATION DE DOCUMENT ──
Condense un document long (compte-rendu, email, retour client, doc externe) en un format exploitable pour le workflow. Ce skill est transversal — il peut être lancé sur n'importe quel document, à n'importe quel moment.
Exemple : tu reçois un email de 3 pages d'un client avec des demandes de modifications. /condense en extrait l'essentiel — les décisions, les contraintes, les chiffres, les acteurs — sans la politesse ni les répétitions.
Modèle recommandé : T2 — Sonnet (par défaut).
TOI : tu fournis le document à condenser
CLAUDE : condense en préservant décisions, contraintes, chiffres et acteurs — supprime politesse, répétitions et digressions — puis demande l'usage : brief/contexte, prd-update, context.md, ou brut
Fichier produit : dépend du mode choisi (peut alimenter directement un artefact du workflow)
Fin : le contenu condensé est livré dans le format demandé.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RÉCAPITULATIF — TOUS LES FICHIERS PRODUITS PAR LE WORKFLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
À la fin d'un projet complet, voici tous les fichiers présents dans le repo :
[projet].context.md — contexte écosystème, client, contraintes (/contexte)
[projet].brief.md — brief structuré en 9 domaines dont architecture légère et modèle de prestation (/brief)
[projet].proposition.md — proposition commerciale : récapitulatif devis + détail par phase + narrative complète (/devis)
[projet].cgv.md — Conditions Générales + Conditions Particulières M1/M2/M3 (/cgv)
[projet].charte.md — identité visuelle, couleurs, typo (/charte)
[projet].prd.md — PRD V1 + V2 + réponses cross-pollination (/prd, /prd-update)
[projet].gherkin.[feature].md — scénarios Gherkin par feature, Mode Specs (/gherkin)
[projet].design.md — design system complet pour Claude Design (/design Mode A)
[projet].archi.md — architecture modulaire + silos + garde-fous (/archi)
[projet].regles.md — règles non-évidentes < 60 lignes (/regles)
[projet].stack.md — investigation technique, free tier, gotchas (/stack)
[projet].Rmap.md — roadmap phasée avec planning (/roadmap)
[projet].spec.[feature].md — user story auto-contenue, un fichier par feature (/specs)
[projet].prp.md — Project Ready Prompt ≤ 1000 tokens (+ version extended si dépassement inévitable) (/prp)
[projet].avancement.yaml — sprint tracker YAML (/avancement)
[projet].recette.md — cahier de recettes avec résultats (/recette)
[projet].tests.md — suite de tests unit + intégration + Playwright (/tests)
[projet].doc-tech.md — documentation technique développeur (/doc-tech Mode A)
[projet]-retrospective.md — journal de rétrospective par phase (/phase-retrospective)
[projet].adr.md — journal des décisions architecturales (/adr)
[projet].refacto-dette.md — journal de dette refactoring, points résolus et en attente (/refacto)
CLAUDE.md (dans le repo projet) — blocs d'architecture injectés automatiquement dans le contexte Claude (/archi)
Fichiers techniques (générés par /setup) :
.env.example — template des variables d'environnement (jamais de valeurs réelles)
.gitignore — avec .env, node_modules, .DS_Store
Structure de dossiers source — selon l'architecture définie dans [projet].archi.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FIN DU RÉCAP — VIBE METHOD
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
La chaîne complète représente environ 28 skills principaux + 6 transversaux (/party, /impact, /avancement, /adr, /refacto, /condense). Chaque skill a une entrée claire (quand le lancer), un processus défini (ce que Claude fait), et une sortie explicite (comment ça se termine, quel fichier est produit, vers quel skill passer ensuite). La méthode est conçue pour que User ne puisse jamais se demander 'qu'est-ce qu'on fait maintenant ?' — le skill en cours répond toujours à cette question.
