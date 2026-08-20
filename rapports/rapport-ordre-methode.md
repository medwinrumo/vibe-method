> **Provenance — fichier reconstruit le 20/08/2026.** Dossier de sources du rapport
> `ordre-chaine-vibe-method.md`, écrit le 14/08/2026 dans un scratchpad depuis effacé.
> Rejeu du `Write` initial et des 18 `Edit` de
> `~/.claude/projects/-Users-medwinrumo-dev-RAMrezo/a44f168c-.../subagents/agent-aa1971e8cc103ce92.jsonl`.
> 18/18 appliqués, aucun `old_string` ambigu. 2 230 lignes.

---

# Rapport — quand monter le projet qui tourne ? (brouillon)

Consultation des sources : **14 août 2026**.

---

## SYNTHÈSE (à placer en fin de rapport — clairement étiquetée comme synthèse)

**Constat principal, et il est négatif : aucun auteur de source primaire ne prescrit une
position fixe pour le setup dans une chaîne de phases.** Ce n'est pas un manque de
recherche, c'est ce que disent les textes.
- Cockburn, interrogé directement (« À quel stade le walking skeleton doit-il voir le
  jour ? Fin du premier sprint ? »), répond le 07/04/2016 : « **no idea, to either
  question. so sorry, Alistair.** »
- Cagan écrit que son modèle est « **process agnostic** » et refuse d'y ajouter du détail
  de processus, parce que « **this is a slippery slope** ».
- Singer sépare « basic truths » et « specific practices » et dit qu'une équipe de deux ou
  trois personnes peut « **throw out most of the structure** ».

**Ce qui, en revanche, est prescrit en source primaire, c'est un CRITÈRE — pas une date.**
Trois critères convergents, chacun indépendant :

1. **L'horizon de pensée (Cockburn, Crystal Clear 2004).** On arrête de concevoir quand on
   commence à spéculer au-delà de ce qu'on peut tenir en tête. Ce point dépend de
   l'expérience du concepteur **sur ce domaine et ces technologies précis**, pas d'une
   position dans une chaîne. Ordre de grandeur donné : une à deux semaines. « Don't
   overdrive your headlights. »

2. **L'inconnu, pas la plomberie (Singer, Shape Up ch. 11).** Le premier morceau à
   construire doit être *core*, *small* et **novel** — « prefer the thing that you've never
   done before […] it wouldn't have taught the team anything. It wouldn't have eliminated
   uncertainty ». Et « **Start in the middle** » : ils n'ont pas construit le login d'abord.

3. **La question posable ou non sans code (Singer, ch. 5 vs ch. 9).** Tant que le risque se
   règle par une conversation (« is X possible in 6-weeks? ») ou par une décision qu'on peut
   trancher d'avance, on ne code pas. Quand « **we can't reliably shape what we want in
   advance** […] **we have to learn what we want by building it** », on code — et c'est
   précisément le cas d'un produit neuf dont l'architecture n'est pas posée.

**Le point 3 est la réponse la plus directe à la question posée.** Shape Up, méthode dont
tout l'appareil consiste à ne rien engager avant d'avoir bouché les trous, **suspend son
propre processus** pour un produit neuf : R&D mode, équipe senior, aucune livraison
attendue, « the aim is to spike, not to ship », jusqu'à ce que « the most important
architectural decisions are settled ». La séquence brief → … → specs → setup **est celle
du production mode**, c'est-à-dire d'un contexte où l'architecture est déjà acquise.

**L'axe qui tranche vraiment n'est pas « tôt ou tard », c'est « gardé ou jeté ».**
Le même mot « spike » recouvre deux choses opposées : jetable chez Cockburn et Beck,
conservé et porteur (« load-bearing structure ») chez Singer. Et le contraste
tracer bullet / prototype de Hunt & Thomas dit la même chose : « **Prototyping generates
disposable code. Tracer code is lean but complete, and forms part of the skeleton of the
final system.** » Poser la question « faut-il monter le projet tôt ? » sans dire si ce
qu'on monte est destiné à survivre revient à poser deux questions à la fois.

**Sur le coût du retravail : il est fonction de la masse construite dessus, pas de la date.**
C'est ce que montre l'histoire de Cockburn (mapping objet-relationnel remplacé sans drame
« while the system's delivered functionality was still small ») et sa contre-histoire (le
refus de « the extra rework » a coûté le produit entier). Hunt & Thomas disent la même
chose : « **a small body of code has low inertia—it is easy and quick to change** ». Et
Brooks, en 1995, remplace « jeter un prototype une fois » par le build incrémental, parce
que le remède d'origine était « too simplistic ».

**Sur la distinction coordination / retravail — décisive pour un développeur seul.**
Deux aveux en source primaire, tous deux d'auteurs qui vendent pourtant de la méthode :
- Singer : « After you hire more people, all of this fluidity flips from an asset to a
  liability. […] **Coordination starts to eat up more of your time** and things begin to
  slip through the cracks. **This is when it makes sense to take on the structure** of
  six-week cycles, cool-downs, and a formal betting table. » → la cérémonie existe à cause
  du nombre de personnes ; elle est explicitement dispensée en dessous.
- Cagan : « **If you are an early stage startup and you have no customers, then of course
  this is not really an issue (and it may be premature to even be creating
  production-quality software).** » → la précaution discovery/delivery suppose des clients
  en service.
Et l'argument de parcimonie d'Ian Mitchell (Scrum.org) vaut a fortiori pour une personne
seule : ce que le dispositif apporte est déjà couvert par des moyens plus légers, au prix
de couper en deux ce qui n'a aucune raison de l'être.

**Ce que la synthèse NE peut PAS établir, faute de source :** aucune donnée empirique n'a
été trouvée sur le coût de changer de stack en cours de projet, ni sur le développeur seul
assisté par IA. Aucune critique frontale du walking skeleton en source primaire d'auteur
reconnu non plus. Ces trois absences sont des absences de recherche, pas des preuves.

## §1 — Walking skeleton / tracer bullet

### 1.1 Cockburn — source primaire retrouvée

Page `Walking skeleton` du wiki personnel d'Alistair Cockburn, archivée :
https://web.archive.org/web/2016/http://alistair.cockburn.us/Walking+skeleton
(page datée 6/1/1996, postée 19/06/2008, dernière modif 20/03/2014)

Définition canonique (Cockburn indique lui-même que c'est « la description tirée du
livre Crystal Clear, 2004 ») :

> A **Walking Skeleton** is a tiny implementation of the system that performs a small
> end-to-end function. It need not use the final architecture, but it should link
> together the main architectural components. The architecture and the functionality
> can then evolve in parallel.

Généalogie donnée par Cockburn lui-même :
> I first found this pattern or strategy around 1994, named it somewhere between then
> and 1997. Around 1999 I found that it pairs well with Incremental Rearchitecture.

Note historique de Cockburn : le mot « skeleton » figure déjà chez Basili & Turner,
« Iterative Enhancement: A Practical Technique for Software Development », IEEE TSE,
déc. 1975. Cockburn : « I coined the term Walking Skeleton in the late-1990s sometime,
without knowing about the Basili-Turner paper, but it is the same thing, as far as I
can tell from here. »

MOMENT : le récit fondateur donne « within the first week ».
> We had a large project to do, consisting of systems passing messages around a ring to
> each other. The other technical lead and I decided that we should, within the first
> week, connect the systems together so they could pass a single null message around the
> ring. This way we at least had the ring working.

Puis règle de maintien :
> We then required that at the end of every week, no matter what new messages and message
> processing was developed during the week, the ring had to be intact, passing all of the
> previous weeks' messages without failure.

Ce que ça teste (Cockburn sur son propre projet client-serveur) :
> We tested the team, the process, the technologies, and the architecture at a very early
> point in the project.

Formes selon le système :
> For a client-server system, it would be a single screen-to-database-and-back capability.
> For a multi-tier or multi-platform system, it is a working connection between the tiers
> or platforms. For a compiler, it consists of compilation of the simplest element of the
> language, possibly just a single token.

DISTINCTION CENTRALE spike / walking skeleton (source primaire, même page) :
> A walking skeleton is different from a spike. A spike is "the smallest implementation
> that demonstrates plausible technical success." The spike typically takes between a few
> hours and a few days to complete, and is thrown away afterward, since it was built with
> nonproduction coding habits. A spike serves to answer the question: Are we headed in the
> wrong direction?
>
> A walking skeleton, on the other hand, is permanent code, built with production coding
> habits, regression tests, and is intended to grow with the system. Once the system is up
> and running, it will stay up and running for the rest of the project, despite the
> Incremental Rearchitecture that is quite likely to occur.

COÛT / DURÉE — Cockburn répond en commentaires (donc source primaire, mais informelle) :
- « Back in 1994 w a large commercial Smalltalk, COBOL, Rel DB project w 24 people, it
  took us weeks to make and months to deploy. In 2008 on a web project w SQL, .NET and
  browser, it took us 40 minutes. I would expect 20 minutes to 2 weeks to be a fairly
  normal spread these days. »
- Question directe « À quel stade doit-on faire le walking skeleton ? Fin du premier
  sprint ? » — réponse de Cockburn le 07/04/2016 : « no idea, to either question. so
  sorry, Alistair ». À CITER : l'auteur refuse de fixer le moment.

RUP — échange dans les commentaires (2013) :
ChrisFCarroll : « This is also what RUP was saying in the 90s? walking skeleton =
Baseline the architecture + produce working implementation before end of Elaboration. »
Cockburn : « Very similar if not the same. I never spoke to those authors about what they
exactly meant by their words, but it seems by now, looking back, that it would be similar
or same. »

Et René Johnsen cite les « 3 amigos » de UP (1999) : « This aggregate of models is the
architecture baseline; it is a small skinny system. […] It includes the same skeleton of
subsystems, components, and nodes as the eventual system, but not all of the musculature
is in place. »

Cockburn renvoie aussi à : Poppendieck (2003) « spanning application » ; Hunt & Thomas
« tracer bullets » (1999) ; Johanna Rothman « Hudson River Company start ».

### 1.2 Hunt & Thomas — tracer bullets

Source primaire la plus directe accessible en texte intégral : interview des deux auteurs
par Bill Venners, Artima, 21 avril 2003, « Tracer Bullets and Prototypes »
https://www.artima.com/articles/tracer-bullets-and-prototypes

Dave Thomas :
> The software analog to firing heavy artillery by calculating everything up front is
> saying, "I'm going to specify everything up front, feed that to the coders, and hope
> what comes out the other end is close to my target." Instead, the tracer bullet analogy
> says, "Let's try and produce something really early on that we can actually give to the
> user to see how close we will be to the target." […] You're looking at small iterations,
> skeleton code, which is non-functional, but enough of an application to show people how
> it's going to hang together.
> Basically, it all comes down to feedback. The more quickly you can get feedback, the
> less change you need to get back on target.

Andy Hunt, sur la « skeleton application » :
> Central to tracer bullet development is the idea of a skeleton application, in which one
> thin line of execution goes end to end. In a skeleton application, you have some bit of
> functionality—even if it's just the equivalent of "Hello, world!"—that goes all the way
> from the UI, through business logic, through whatever else is in the middle, all the way
> to a database.

LIMITE ADMISE PAR LES AUTEURS EUX-MÊMES (important — c'est la critique interne) :
Andy Hunt :
> Having said that, there are times when either approach is appropriate. […] if you're
> shelling a city, which isn't moving, that's a pretty good way to go. If you're writing
> software for the space shuttle, or any kind of environment where you really know all the
> requirements up front and they're not going to change, that's probably the cheapest way
> to do it. And there are some environments where that is the case. Not many, but that
> actually does happen.

Argument du coût du changement (Hunt) :
> As you steadily grow your application, one feature at a time—this is where tracer bullets
> come in—you may realize, you're off by a little bit. Well, you still don't have that much
> code. It's still easier to adjust it and fix your aim. As you grow the application fatter
> and fatter over time, it will be increasingly harder and harder to make gross changes.

Prototype = jetable (Dave Thomas) :
> Prototypes by their nature are not designed to be long lasting code. Prototypes are
> designed to be thrown away. They're one-offs. It is inappropriate to over-engineer a
> prototype. A prototype is like a town in a western movie. It's all facade.

TEXTE DU LIVRE — vérifié sur un scan intégral (édition du 20e anniversaire, 2019,
Topic 12 « Tracer Bullets » ; les renvois « Topic 13, Prototypes and Post-it Notes »,
« Topic 27 », « Topic 40 » confirment l'édition). Scan consulté :
https://pdfcoffee.com/programming-foundations-2-pdf-free.html

> TRACER CODE VERSUS PROTOTYPING — You might think that this tracer code concept is nothing
> more than prototyping under an aggressive name. There is a difference. With a prototype,
> you're aiming to explore specific aspects of the final system. With a true prototype, you
> will throw away whatever you lashed together when trying out the concept, and recode it
> properly using the lessons you've learned.
>
> The distinction is important enough to warrant repeating. **Prototyping generates
> disposable code. Tracer code is lean but complete, and forms part of the skeleton of the
> final system.** Think of prototyping as the reconnaissance and intelligence gathering that
> takes place before a single tracer bullet is fired.

Et, sur la nature du code produit :
> Tracer code is not disposable: you write it for keeps. It contains all the error checking,
> structuring, documentation, and self-checking that any piece of production code has. It
> simply is not fully functional.

Sur le coût du changement quand on se trompe :
> […] be thankful that you've used a lean development methodology; a small body of code has
> low inertia—it is easy and quick to change.

Exemple donné par les auteurs de leur propre tracer code : « a query that listed all the
rows in a table, but it proved that the UI could talk to the libraries, the libraries could
serialize and unserialize a query, and the server could generate SQL from the result. »

Tip 15 : « Use Tracer Bullets to Find the Target ». Tip 16 : « Prototype to Learn ».
Tip 14 : « There Are No Final Decisions ».

### 1.3 Freeman & Pryce — GOOS (2009), le moment et le coût

Source : Steve Freeman & Nat Pryce, *Growing Object-Oriented Software, Guided by Tests*,
Addison-Wesley 2009, chapitre 4 « Kick-Starting the Test-Driven Cycle », sections
« First, Test a Walking Skeleton » (p. 32), « Deciding the Shape of the Walking Skeleton »
(p. 33), « Expose Uncertainty Early » (p. 36). PDF consulté :
https://dropbox.ducheng.me/Growing%20Object-Oriented%20Software,%20Guided%20by%20Tests.pdf

Définition renforcée (ils citent [Cockburn04]) :
> A "walking skeleton" is an implementation of the thinnest possible slice of real
> functionality that we can automatically build, deploy, and test end-to-end [Cockburn04].
> It should include just enough of the automation, the major components, and communication
> mechanisms to allow us to start working on the first feature. We keep the skeleton's
> application functionality so simple that it's obvious and uninteresting, leaving us free
> to concentrate on the infrastructure.

→ noter : chez eux le squelette inclut **build + deploy + test automatisés**, pas seulement
le code. C'est plus lourd que chez Cockburn.

Sur le niveau de décision d'architecture exigé :
> The development of a "walking skeleton" is the moment when we start to make choices about
> the high-level structure of our application. We can't automate the build, deploy, and test
> cycle without some idea of the overall structure. We don't need much detail yet, just a
> broad-brush picture […]
> Our rule of thumb is that we should be able to draw the design for the "walking skeleton"
> in a few minutes on a whiteboard.

LE COÛT, admis par les auteurs (c'est LA critique documentée en source primaire) :
> Expose Uncertainty Early — All this effort means that teams are frequently surprised by
> the time it takes to get a "walking skeleton" working, considering that it does hardly
> anything.

Et le garde-fou :
> Of course, we don't want to spend the whole project setting up a perfect "walking
> skeleton," so we limit ourselves to whiteboard-level decisions and reserve the right to
> change our mind when we have to.

Justification :
> A "walking skeleton" will flush out issues early in the project when there's still time,
> budget, and goodwill to address them.

### 1.3bis — Cockburn, « Incremental Rearchitecture » : LA RÈGLE DE DÉCISION SUR LE MOMENT

Source primaire (archive du wiki, texte du livre *Crystal Clear*, 2004, « Strategy 4 ») :
https://web.archive.org/web/2016/http://alistair.cockburn.us/Incremental+Rearchitecture

C'est la stratégie jumelle du walking skeleton, et c'est elle qui répond littéralement à
la question « à quel moment arrêter de concevoir et commencer à faire tourner ».

> The system architecture will need to evolve, from the Walking Skeleton, and also to handle
> technology and business requirements changes over time. It is rarely effective to shut down
> development to perform an architectural revision, so the team evolves the architecture in
> stages, keeping the system running as they do so.

Puis, textuellement, la question posée par le demandeur :
> **The question naturally arises: How completely designed should the system architecture and
> infrastructure be during the early stages of the project?**

Et la réponse — le concept de **thought horizon** (horizon de pensée) :
> Any one person has his personal "thought horizon," how much complexity he can keep in his
> head for several days in a row, how much he can foresee from his experience and knowledge
> of the situation. An architect who has done similar systems in the same domain using
> similar technologies can think through to a further horizon than one just getting started.
>
> Some people keep the thought horizon down to a few days. They get started immediately with
> an initial design, and learn from that early version in which direction they should push the
> design. Others like to think longer and consider more contingencies before committing to an
> initial architecture.
>
> **The thought horizon on a Crystal Clear project is almost certainly reached within a week
> or two. At that point, the designers are probably speculating beyond their thought horizon,
> and would be better setting up the Walking Skeleton.** They should use that to get to the
> first of their Frequent Deliveries, and use the feedback to improve the architecture.
> **"Don't overdrive your headlights," is how some people phrase it.**

→ Critère explicite : on arrête la conception sur papier au moment où l'on se met à
spéculer au-delà de ce qu'on peut tenir en tête. Ce moment dépend de l'EXPÉRIENCE du
concepteur sur ce domaine et ces technologies, pas d'une position fixe dans une chaîne
de phases. Ordre de grandeur donné : une à deux semaines.

Les deux histoires que Cockburn oppose (matière pour le §6, coût du retravail) :
- Succès : le mapping objet-relationnel choisi initialement ne passait pas à l'échelle,
  découvert « after the second delivery ». L'équipe a maintenu l'ancienne architecture un
  incrément de plus « while the system's delivered functionality was still small », glissé
  la nouvelle au troisième cycle, arraché l'ancienne au quatrième. → le coût du retravail
  est fonction de la QUANTITÉ DE FONCTIONNALITÉ déjà construite dessus, pas de la date.
- Échec : une équipe a parié sur une architecture radicalement nouvelle sans repli.
  « The project manager said she had great confidence in the lead architects and **didn't
  want the extra rework**, so she chose to hang all hopes on the new architecture. […] In
  the end, the project was left with no running architecture at all, and no product was
  ever shipped. » → refuser le coût du retravail a coûté le produit entier.

Bilan de Cockburn :
> Developers in the last decade have shown that tidy, simple architectures are reasonably
> straightforward to upgrade to their next stage of complexity and performance.
> **Starting from a simple working architecture and applying Incremental Rearchitecture is a
> winning strategy for most, though not all systems.**

Avantages qu'il liste, dont un directement pertinent :
> The running system might reveal shortcomings in the architecture that the early thought
> experiments didn't catch.

### 1.4 Critiques

(a) Gojko Adzic, « Forget the walking skeleton – put it on crutches », 9 juin 2014
https://gojko.net/2014/06/09/forget-the-walking-skeleton-put-it-on-crutches/
(version remaniée dans *Fifty Quick Ideas To Improve Your User Stories*)

Ce n'est PAS un rejet : Adzic dit « The Walking Skeleton has long been my favourite
approach ». Sa critique est que relier les composants d'architecture retarde la valeur :
> Instead of validating the architecture with a thin slice, we can aim to deliver value with
> an even thinner slice and build the architecture through iterative delivery later. We can
> start with a piece that users can interact with, avoid linking together the architectural
> components, but instead use a simpler and easier back-end. […] In the skeleton lingo,
> don't worry about making the skeleton walk, put it on crutches and ship out.

Exemples chiffrés qu'il donne : rapport client via Google Analytics « first version was
done in two hours, and the final version took several weeks » ; uploader direct vers S3
« done in a hour » ; inscriptions + paiement via JotForm « without even having a database »,
resté trois mois en production.

Cite aussi Dan North, « Dancing Skeleton Pattern », QCon London 2012
http://qconlondon.com/dl/qcon-london-2012/slides/DanNorth_DecisionsDecisions.pdf

(b) CONSTAT À ÉCRIRE EXPLICITEMENT : je n'ai pas trouvé de critique frontale du walking
skeleton en source primaire (article d'auteur reconnu argumentant qu'il ne faut pas le
faire). Ce qui existe : (i) Adzic ci-dessus, qui l'amende ; (ii) l'aveu de coût de
Freeman & Pryce ; (iii) le refus de Cockburn de fixer un moment ; (iv) la littérature
YAGNI / architecture sacrificielle, qui attaque le problème par un autre angle. Recherches
menées : tavily « walking skeleton criticism drawback too early premature infrastructure
wasted effort critique ». Une absence de résultat n'est pas une preuve d'inexistence.

### 1.5 — CONTRE-LITTÉRATURE (l'autre côté de la question) — sources primaires en texte brut

**Le spike de Kent Beck — origine C2, passages signés.**
https://wiki.c2.com/?SpikeSolution (dernière édition 13/08/2010)
Ward Cunningham (signé) :
> I would often ask Kent, "**What is the simplest thing we can program that will convince us
> we are on the right track?**" Such stepping outside the difficulties at hand often led us
> to simpler and more compelling solutions. **Kent dubbed this a *Spike*.**
Kent Beck (signé) — LE CRITÈRE DE DÉCLENCHEMENT :
> **Spikes are good when you are knowledge-limited, not time-limited.**
Ron Jeffries (signé, projet C3 Chrysler) — LA DURÉE ET LE CARACTÈRE JETABLE :
> **We like a SpikeSolution to take no more than a couple of days, and a half day is ideal.
> We plan to throw away the code, although sometimes something is salvaged.** […] Those
> [spikes d'algorithme] should take minutes in most cases, not hours.
Étymologie (en-tête, non signé) : « a spike is "end to end, but very thin", like driving a
spike all the way through a log » — le spike est *depth-first* là où le top-down est
*breadth-first*.
Cockburn (https://wiki.c2.com/?SpikeDescribed, signé) :
> **Indications**: You are working in a new problem domain or with a new technology you do
> not understand, and cannot create an initial design in which you can place much confidence.
> **Recommended action**: Build the smallest possible *core* solution in the shortest possible
> time. Use that core solution to inform your decision about your technology, the domain,
> your design and your process.
> **Overdose effect**: The solution is too small, and in fact does not shed the necessary
> light on the domain, technology or process.
Et l'échange sur la limite (Dave Harris) : « **A database with 100 records doesn't tell you
much about how to organize one with 100 million.** » — Cockburn répond : « If scaling is on
your radar, the spike will perhaps write 10 million dummy records to the database. »
RÉSERVE : le texte d'*Extreme Programming Explained* n'a pas pu être lu. La page C2
`ArchitecturalSpike` (qui dit que le spike architectural a lieu « while the initial
PlanningGame is in process » et que sa durée n'est pas fixée d'avance) **n'est signée par
personne** — ne pas l'attribuer à Beck.

**Fowler, « Yagni » (26/05/2015) — https://martinfowler.com/bliki/Yagni.html**
Les quatre coûts, verbatim :
> the **cost of build**: all the effort spent on analyzing, programming, and testing this now
> useless feature.
> This **cost of delay** due to the presumptive feature is two months revenue.
> the **cost of carry**. The code for the presumptive feature adds some complexity to the
> software, this complexity makes it harder to modify and debug that software, thus
> increasing the cost of other features.
> you have accumulated TechnicalDebt and have to consider the **cost of repair**.
La règle de comparaison :
> that cost comparison has to be made at least against the cost of delay, **preferably
> factoring in the probability that you're building an unnecessary feature, for which your
> odds are at least ⅔.**
(Source du ⅔ donnée par Fowler : Kohavi et al., Microsoft — « **only ⅓ of them improved the
metrics they were designed to improve** », http://ai.stanford.edu/~ronnyk/ExPThinkWeek2009Public.pdf)
Extension aux abstractions — directement transposable à un choix d'architecture :
> Yagni says not to do this, because you may not need the other pricing functions, **or if
> you do your current ideas of what abstractions you'll need will not match what you learn
> when you do actually need them.** […] **any abstraction that makes it harder to understand
> the code for current requirements is presumed guilty.**
LES DEUX GARDE-FOUS QUE LES RÉSUMÉS COUPENT :
> **Yagni only applies to capabilities built into the software to support a presumptive
> feature, it does not apply to effort to make the software easier to modify.**
> **Yagni is not a justification for neglecting the health of your code base. Yagni requires
> (and enables) malleable code.**
Et son aveu de biais :
> these cases are **hard to spot in advance, and much easier to remember than the cases where
> yagni saved effort** [note : « This is a consequence of availability bias »]

**Fowler, « Is Design Dead? » (XP 2000, rév. mai 2004) — https://martinfowler.com/articles/designDead.html**
LE PASSAGE DÉCISIF sur l'architecture amont (section « Growing an Architecture ») :
> Certainly the most aggressive XPers - Kent Beck, Ron Jeffries, and Bob Martin - are putting
> more and more energy into avoiding any up front architectural design. **Don't put in a
> database until you really know you'll need it.** Work with files first and refactor the
> database in during a later iteration.
> **I'm known for being a cowardly XPer, and as such I have to disagree. I think there is a
> role for a broad starting point architecture.**
> However the key difference is that **these early architectural decisions aren't expected to
> be set in stone**, or rather the team knows that they may err in their early decisions, and
> should have the courage to fix them.
> **So my advice is to begin by assessing what the likely architecture is. If you see a large
> amount of data with multiple users, go ahead and use a database from day 1.** […] However
> in deference to the gods of YAGNI, **when in doubt err on the side of simplicity.**

LE CRITÈRE LE PLUS OPÉRATIONNEL DU DOSSIER (section « Things that are difficult to refactor in ») :
> **Another issue to bear in mind in this is whether you really know how to do it.** If you've
> done internationalization several times, then you'll know the patterns you need to employ.
> […] **So my advice would be that if you do know how to do it, you're in a position to judge
> the costs of doing it now to doing it later. However if you've not done it before, not just
> are you not able to assess the costs well enough, you're also less likely to do it well. In
> which case you should add it later.**
→ MÊME STRUCTURE QUE L'HORIZON DE PENSÉE DE COCKBURN : le critère est l'expérience du
développeur sur CE problème précis.

Priorité à la mise en production :
> Getting to a release as fast as possible is vitally important. […] **The power of shipped,
> running code is enormous.** […] **Even if it is more effort to add something after the first
> release, it is better to release sooner.**
Réversibilité (section ajoutée en 2004, d'après Enrico Zaninotto, XP 2002) :
> **one of the main source of complexity is the irreversibility of decisions. If you can
> easily change your decisions, this means it's less important to get them right** […] Rather
> than trying to get the right decision now, look for a way to either put off the decision
> until later (when you'll have more information) or **make the decision in such a way that
> you'll be able to reverse it later on without too much difficulty.**
> It also means it's worth doing experiments to see how hard future changes can be […]
> **effectively doing a throw-away prototype on a branch of the system.**
Et : « **it's easier to refactor over-design than it is to refactor no design.** »

**Fowler, « Design Stamina Hypothesis » (20/06/2007) —
https://martinfowler.com/bliki/DesignStaminaHypothesis.html**
> **If the functionality for your initial release is below the design payoff line, then it
> *may* be worth trading off design quality for speed; but if it's above the line then the
> trade-off is illusory. When your delivery is above the design payoff line neglecting design
> always makes you ship later.**
> **I take the view that it's much lower than most people think: usually weeks not months.**
ATTENTION AU CONTRESENS : ce n'est PAS « projet petit = design inutile ». Fowler place la
ligne très bas, donc presque tout projet réel la dépasse. Et il se limite lui-même :
> **I call this a hypothesis because it is a conjecture, there is no objective proof that this
> phenomenon actually occurs. In scientific terms it's not a very good hypothesis because
> it's hard to test. We CannotMeasureProductivity nor can we measure design quality.**
> But despite it being only a hypothesis, **it's also an axiom for many people, including
> myself.**

**Fowler, « Sacrificial Architecture » (20/10/2014) —
https://martinfowler.com/bliki/SacrificialArchitecture.html**
> **But often the best code you can write now is code you'll discard in a couple of years time.**
> **The right architecture to support 1996-ebay isn't going to be the right architecture for
> 2006-ebay. The 1996 one won't handle 2006's load but the 2006 version is too complex to
> build, maintain, and evolve for the needs of 1996.**
Règle Google (note 1, citant Jeff Dean) : « **design for ~10X growth, but plan to rewrite
before ~100X** ».
> in the early period of a software system you're less sure of what it really needs to do, so
> **it's important to put more focus on flexibility for changing features rather than
> performance or availability.** […] **getting too many users on an unperformant code base is
> usually the better problem than its inverse.**
LE GARDE-FOU :
> **Knowing your architecture is sacrificial doesn't mean abandoning the internal quality of
> the software. Usually sacrificing internal quality will bite you more rapidly than the
> replacement time.** […] Good modularity is a vital part of a healthy code base.
Et l'avertissement anti-infra distribuée précoce :
> **Microservices imply distribution and asynchrony, which are both complexity boosters.**
> […] **So a monolith is often a good sacrificial architecture.**

**Fowler, « MonolithFirst » (03/06/2015) — https://martinfowler.com/bliki/MonolithFirst.html**
> **Almost all the cases where I've heard of a system that was built as a microservice system
> from scratch, it has ended up in serious trouble.**
> **It may be hard to scale a poorly designed but successful software system, but that's
> still a better place to be than its inverse.**
> **But even experienced architects working in familiar domains have great difficulty getting
> boundaries right at the beginning.**
Et son propre doute, à citer :
> **I don't feel I have enough anecdotes yet to get a firm handle on how to decide whether to
> use a monolith-first strategy.** […] **So anybody's advice on these topics must be seen as
> tentative, however confidently they argue.**

**Fowler, « Who Needs an Architect? », IEEE Software, juillet/août 2003 —
https://martinfowler.com/ieeeSoftware/whoNeedsArchitect.pdf**
C'EST LE TEXTE LE PLUS FORT SUR LE COÛT D'UNE DÉCISION D'ARCHITECTURE PRISE TROP TÔT.
Ralph Johnson, cité par Fowler :
> **architecture is the decisions that you wish you could get right early in a project, but
> that you are not necessarily more likely to get them right than any other.**
Fowler :
> Why do people feel the need to get some things right early in the project? The answer, of
> course, is **because they perceive those things as hard to change. So you might end up
> defining architecture as "things that people perceive as hard to change."**
Et l'exemple de Pramod Sadalage (migrations de schéma automatisées) :
> **By doing this, he made it so that the database schema was no longer architectural. I see
> this as an entirely good thing because it let us better handle change.**
> **I think that one of an architect's most important tasks is to remove architecture by
> finding ways to eliminate irreversibility in software designs.**
La contrepartie, par Johnson :
> There is no theoretical reason that anything is hard to change about software. […]
> **Making something easy to change makes the overall system a little more complex, and
> making everything easy to change makes the entire system very complex. Complexity is what
> makes software hard to change.**
→ Il n'y a pas de position gratuite.

NOTE : `martinfowler.com/bliki/PrematureOptimization.html` **n'existe pas** (404 vérifié en
appelant l'URL directement le 14/08/2026, pas une absence de résultat de recherche).

**« Last responsible moment » — Poppendieck**
La phrase canonique de 2003 (« delay commitment until the last responsible moment, that is,
the moment at which failing to make a decision eliminates an important alternative ») est
**concordante chez quatre citants indépendants mais NON vérifiée dans le livre** (aperçu
éditeur incomplet, p. 57 absente). À présenter comme rapportée.
Ce qui EST vérifié, texte primaire de l'aperçu éditeur de *Lean Software Development* (2003,
https://api.pageplace.de/preview/DT0400.9780133812954_A23586516/preview-9780133812954_A23586516.pdf) :
> **Toyota and Honda had discovered a different way to avoid the penalty of incorrect design
> decisions: Don't make irreversible decisions in the first place; delay design decisions as
> long as possible, and when they are made, make them with the best available information to
> make them correctly.**
Et la reformulation par les auteurs eux-mêmes en 2006 (*Implementing Lean Software
Development*, ch. 2, https://res.infoq.com/articles/poppendieck-implementing-lean/en/resources/poppendieck_ch02.pdf) :
> **Principle 4: Defer Commitment.** […] They are taught to assess a challenging situation and
> **decide how long they can wait** before they must make critical decisions. Having set a
> **timebox** for such a decision, they learn to wait until the end of the timebox […]
> **Schedule irreversible decisions for the last responsible moment** […] **This is not to say
> that all decisions should be deferred.**
> in the face of uncertainty especially when it is accompanied by complexity, the more
> successful approach is to **tackle tough problems by experimenting with various solutions**,
> leaving critical options open until a decision must be made.
TROIS POINTS QUI CONTREDISENT LA LECTURE COURANTE : (1) la règle ne vise que les décisions
**irréversibles** ; (2) « this is not to say that all decisions should be deferred » ;
(3) le dernier moment se **programme** (timebox), il ne se sent pas venir.

**Les deux critiques nommées du LRM :**
- Rebecca Wirfs-Brock, 18/01/2011 —
  https://wirfs-brock.com/rebecca/blog/2011/01/18/agile-architecture-myths-2-architecture-decisions-should-be-made-at-the-last-responsible-moment/
  > it takes time to disseminate decisions. And decisions that initially appear to be
  > localized […] **can and frequently do have ripple effects outside their initially
  > perceived sphere of influence.**
  > I think I operate more effectively if **I make decisions at the "most responsible moment"
  > instead of the "last responsible moment"**.
  > **I'm not a good enough of a designer […] to know when the last responsible moment is.**
- Ben Morris, 21/02/2014 —
  https://www.ben-morris.com/lean-developments-last-responsible-moment-should-address-uncertainty-not-justify-procrastination/
  > **Too many open decisions can create mental clutter that impedes progress.** […] it can be
  > an excuse to dodge decisions.
  > **There is no clear tipping point that identifies the last responsible moment. There's
  > just a slow upwards creep of the cost of not making a decision. You can only tell when the
  > last responsible moment has *passed*.** […] **In this sense it is just a bad tool as it
  > can't really be applied in practice.**
  > **Early decisions can be valuable as they help you to bring focus to the solution and
  > remove uncertainty.** […] **you should seek to minimize the number of irreversible
  > decisions that you have to make.**
NOTE : ces deux critiques (2011, 2014) ne citent pas la reformulation de 2006 des
Poppendieck, qui y répond partiellement en programmant la décision dans un timebox.

**Set-based concurrent engineering (Toyota).**
« The Second Toyota Paradox: How Delaying Decisions Can Make Better Cars Faster », Ward,
Liker, Cristiano, Sobek, *Sloan Management Review*, printemps 1995, 36(3), p. 43-61.
**Le corps de l'article n'est pas lisible** — les deux copies PDF accessibles sont des scans
sans couche texte. Seuls le résumé éditeur et l'article de suivi des mêmes auteurs sont
citables :
https://sloanreview.mit.edu/article/toyotas-principles-of-setbased-concurrent-engineering/
> **Toyota considers a broader range of possible designs and delays certain decisions longer
> than other automotive companies do, yet has what may be the fastest and most efficient
> vehicle development cycles in the industry.**
> **Toyota engineers explore the implications of a proposed system design by designing
> alternatives of the subsystems** that make up the larger system. **Only in this way can
> engineers truly understand the ramifications of making certain system-level decisions.**
→ MISE EN GARDE DE TRANSPOSITION : le mécanisme n'est pas « s'abstenir de décider », c'est
**construire réellement plusieurs alternatives en parallèle** — payer plusieurs fois pour
savoir. Transposé à un choix de stack, l'équivalent honnête est plusieurs spikes menés en
parallèle, pas un report de décision.
Transposition logicielle (Bill Wake, xp123.com, 11/2006 rév. 2014,
https://xp123.com/set-based-concurrent-engineering/) qui cite **Kent Beck** :
> their client was trying to decide between an HTML interface or a rich client interface.
> [His] advice was to **implement both, keeping them in sync every iteration until it was
> clear which one was most valuable. The client said that they couldn't stand the idea of
> wasting all that effort, so they picked early and later regretted it.** This is the kind of
> strategy that is **only possible when you have slack programming capacity.**
Et Wake sur la couche de persistance construite trop tôt :
> You could "build the persistence layer," mapping out all objects from all the tables you
> already have. **This creates a "point-based" solution** […] **It creates a drag, from the
> effort spent on objects you don't need yet. Each of those objects will have to be tested,
> refactored, and maintained, against that possible day in the future when all that work may
> finally pay off.**

**Brooks 1975 → 1995 : voir la section « Vérifications ponctuelles » ci-dessus.**
Complément vérifié en texte brut : ce que Brooks met à la place, attribué à Harlan Mills —
> we should build the basic polling loop of a real-time system, with subroutine calls (stubs)
> for all the functions, **but only null subroutines. Compile it; test it. It goes round and
> round, doing literally nothing, but doing it correctly.**
> Next, we flesh out a (perhaps primitive) input module and an output module. **Voilà! A
> running system that does something, however dull. Now, function by function, we
> incrementally build and add modules. At every stage we have a running system.**
> The secret is that it is **grown, not built.** […] **Nothing in the past decade has so
> radically changed my own practice, or its effectiveness.**
→ C'est LITTÉRALEMENT le walking skeleton, décrit par Brooks en 1995. Cockburn le confirme
indirectement : il note que Basili employait déjà « skeleton » en 1975.
→ NUANCE À NE PAS RATER : Brooks ne remplace pas « jeter » par « garder ». Il remplace
**« jeter en bloc »** par **« refaire en continu »**. Le « premier système » disparaît en tant
qu'objet.

**TENSION NON RÉSOLUE, à présenter comme telle :** Fowler ré-argumente en 2014 (architecture
sacrificielle) ce que Brooks a rétracté en 1995 — mais pas à la même échelle. Brooks parlait
d'un système pilote jeté **avant livraison** ; Fowler d'une architecture **livrée, exploitée
et rentable pendant des années** puis remplacée quand la charge change d'ordre de grandeur.
Point commun des trois positions (Brooks 1995, Jeffries, Fowler 2014) : refus de construire
d'avance une structure dimensionnée pour un futur non observé.

**AUCUNE DONNÉE CHIFFRÉE** comparant le coût d'un prototype jeté à celui d'une architecture
conservée mal choisie n'a été trouvée. Le seul chiffre du dossier est celui de Kohavi et al.
(⅓ des fonctions déployées améliorent leur métrique), et c'est une probabilité d'erreur de
spécification, pas un ratio de coûts.

---

## §4 — RUP : socle primaire vérifié moi-même (texte brut, 14/08/2026)

Source primaire : **Rational Software White Paper TP026B, Rev 11/01, « Rational Unified
Process: Best Practices for Software Development Teams »** —
https://cmapspublic3.ihmc.us/rid=1JSPV1STK-1P1LDRY-RM8/RUP.pdf

**Les quatre phases et leurs jalons** : « Each phase is concluded with a well-defined
milestone—a point in time at which certain critical decisions must be made ». Le jalon de
fin d'Elaboration est nommé **Lifecycle Architecture Milestone** :
> At the end of the elaboration phase is the second important project milestone, the
> **Lifecycle Architecture Milestone**. At this point, you examine the detailed system
> objectives and scope, the choice of architecture, and the resolution of the major risks.
> The main evaluation criteria for the elaboration phase involves the answers to these
> questions: • Is the vision of the product stable? • **Is the architecture stable?** •
> **Does the executable demonstration show that the major risk elements have been addressed
> and credibly resolved?** • Is the plan for the construction phase sufficiently detailed and
> accurate?

**But de l'Elaboration** :
> The purpose of the elaboration phase is to **analyze the problem domain, establish a sound
> architectural foundation, develop the project plan, and eliminate the highest risk elements
> of the project.** To accomplish these objectives, you must have the **"mile wide and inch
> deep" view of the system.**

**Livrables de fin d'Elaboration** (liste verbatim) :
> • A use-case model (at least 80% complete) • Supplementary requirements capturing the non
> functional requirements • A Software Architecture Description • **An executable
> architectural prototype** • A revised risk list and a revised business case • A development
> plan for the overall project • An updated development case • A preliminary user manual.

**LA PHRASE DÉCISIVE — gardé ou jeté ?** (c'est la réponse à la question centrale) :
> In the elaboration phase, **an executable architecture prototype is built in one or more
> iterations**, depending on the scope, size, risk, and novelty of the project. This effort
> should at least address the critical use cases identified in the inception phase, which
> typically expose the major technical risks of the project. **While an evolutionary prototype
> of a production-quality component is always the goal, this does not exclude the development
> of one or more exploratory, throwaway prototypes to mitigate specific risks** such as
> design/requirements trade-offs, component feasibility study, or demonstrations to investors,
> customers, and end-users.
→ RUP tranche donc explicitement : le prototype d'architecture est **évolutif et de qualité
production (conservé)**, exactement la disposition du walking skeleton et du tracer bullet.
Les prototypes jetables sont admis **en plus**, pour des risques ponctuels. RUP porte donc
les deux régimes de code, nommés séparément.

**Pourquoi ce jalon est le point de bascule économique** :
> It is easy to argue that **the elaboration phase is the most critical of the four phases.**
> At the end of this phase, the hard "engineering" is considered complete and the project
> undergoes its most important day of reckoning: the decision on whether or not to commit to
> the construction and transition phases. For most projects, this also corresponds to
> **the transition from a mobile, light and nimble, low-risk operation to a high-cost,
> high-risk operation with substantial inertia.**
> Conceptually, this level of fidelity would correspond to the level necessary for an
> organization to **commit to a fixed-price construction phase.**
→ TRÈS UTILE : RUP dit que l'architecture exécutable est ce qui autorise à s'engager sur un
prix ferme. C'est exactement l'usage qu'on peut en faire quand on a une deadline contractuelle.

**Répartition de l'effort et du calendrier par phase** — source primaire :
Rational Software, « Planning a Project with the Rational Unified Process » (livre blanc),
copie hébergée par NYU :
https://www.nyu.edu/classes/jcf/g22.2440-001_sp07/handouts/PlanningProjWithRUP.pdf
> Based on more than twenty years of experience […] Rational has derived a ballpark estimate
> for project planning purposes of how time should be allocated among the four RUP phases.
> **Effort ~5% | 20% | 65% | 10% — Schedule 10% | 30% | 50% | 10%**
> (Figure 1: Typical time allocation for the four phases of a project)
RÉSERVE À SIGNALER : la prose du même paragraphe écrit « 10% inception, **30% elaboration**,
**65% construction**, 10% transition », ce qui ne correspond ni à la ligne Effort ni à la
ligne Schedule de sa propre figure (la somme dépasse 100 %). Le document est incohérent avec
lui-même ; ne citer que les valeurs de la figure, en signalant l'écart.
→ LECTURE : l'Elaboration consomme **20 % de l'effort et 30 % du calendrier**. Un tiers du
calendrier passé à faire tourner l'architecture avant d'écrire le gros du produit.

### §4 bis — COMPLÉMENTS RUP (recherche parallèle, sources primaires en texte brut)

**Deux prémisses courantes à corriger.**
(1) « La spécification Unified Process » n'existe pas. Il y a le livre générique de Jacobson,
Booch & Rumbaugh, *The Unified Software Development Process* (Addison-Wesley, 1999), et RUP
qui en est l'instanciation commerciale. TP026B le dit : « The Rational Unified Process is a
specific and detailed instance of a more generic process described by Ivar Jacobson, Grady
Booch, and James Rumbaugh ».
(2) Les quatre jalons ne sont pas de RUP : ce sont les *anchor points* de **Barry Boehm**,
« Anchoring the Software Process », *IEEE Software* 13(4), juillet 1996, p. 73-82 — référence
citée dans la bibliographie même de TP026B.

**Noms exacts des jalons** — variance attestée entre versions :
- TP026B (2001) : Lifecycle **Objectives** Milestone / Lifecycle Architecture Milestone /
  Initial Operational Capability Milestone / Product Release Milestone.
- Kroll & Kruchten (2003) : Lifecycle **Objective** Milestone (**LCO**) / Lifecycle
  Architecture Milestone (**LCA**) / **IOC** / **PR**.

**LA FORMULATION D'ORIGINE de l'architecture exécutable — Kruchten, 1995/1996.**
Philippe Kruchten, « A Rational Development Process », v5.0 août 1995, publié dans
*CrossTalk* 9(7), juillet 1996, p. 11-16. §3.2 « Elaboration Phase » :
> In this phase an **executable architectural prototype** is built, in one or several
> iterations depending on the scope, size, risk, novelty of the project, which addresses at
> least the top key use cases identified in the inception phase, and which addresses the top
> technical risks of the project. **This is an evolutionary prototype, of production quality
> code which becomes the architectural baseline**, but it does not exclude the development of
> one or more **exploratory, throw-away prototypes** to mitigate specific risks.
Critère de sortie de la phase, en toutes lettres : « **an executable architecture baseline** ».

**LA PREUVE QUE C'EST CONSERVÉ, ET ELLE EST STRUCTURELLE** — glossaire du même document :
> **Baseline** — A release that is subject to change management and configuration control.
> **Prototype** — A release which is **not** necessarily subjected to change management and
> configuration control.
Et la définition de la phase suivante : « **Construction** — The 3rd phase of the process,
where the software is brought **from an executable architectural baseline** to the point where
it is ready to be transitioned to its user's community. » On étoffe la baseline, on ne la jette
pas : « fleshing out the architecture baseline and evolving it in steps or increments ».

**« Ce n'est pas un exercice sur papier »** — Larman, Kruchten & Bittner, *How to Fail with
the Rational Unified Process: Seven Steps to Pain and Suffering*, © Valtech & Rational 2001,
version du 14/07/2002 :
> **Elaboration**—iteratively build the core architecture and resolve the technical risks of
> the project. **When we say build the architecture we mean really program, integrate, and
> test it—this is not a "paper" exercise or throw-away prototyping.**
Et, dans leur liste des malentendus :
> You think that **only prototypes** are created in elaboration. In reality, **the
> production-quality core of the risky architectural elements should be programmed in
> elaboration.**

**Ce qui doit tourner, précisément** (Kroll & Kruchten 2003, ch. 1) :
> **Design, implement, test, and baseline an executable architecture, including subsystems,
> their interfaces, key components, and architectural mechanisms**, such as how to deal with
> inter-process communication or persistency. Address major technical risks […] **by
> implementing and validating actual code.**

**Justification économique affichée** (TP026B, best practice n° 3) :
> The process focuses on **early development and baselining of a robust executable
> architecture, prior to committing resources for full-scale development.**

**Effort / calendrier — source primaire, Kruchten 1995/96, §2.5 :**
> All phases are not identical in terms of schedule and effort. **Although this will vary
> considerably depending on the project discriminants, a typical initial development cycle for
> a medium size project should anticipate the following ratios** — Effort : 5 % / 20 % / 65 % /
> 10 % ; Schedule : 10 % / 30 % / 50 % / 10 %.
> But for an **evolution cycle**, the inception and elaboration phases can be considerably
> reduced.
RÉSERVES DU TEXTE D'ORIGINE, à ne pas perdre : deux lignes distinctes (effort ≠ calendrier) ;
« varie considérablement selon les discriminants du projet » ; valable pour un **cycle initial**
d'un projet de **taille moyenne** ; réduit pour un cycle d'évolution.
→ Inception + Elaboration = **25 % de l'effort, 40 % du calendrier** avant le développement à
pleine échelle. C'est le prix affiché de l'architecture exécutable.

**CRITIQUES DE L'ABANDON — ce qui est prouvé.**
Kruchten lui-même, « A Plea for Lean Software Process Models », ICSSP'11, ACM, mai 2011,
p. 235-236 (il est alors professeur à UBC) :
> Over the last 30 years we have tried very hard the rich process models approach, and **we
> have not been extremely successful at it.**
> In most cases, the process models look at transformations […] and therefore have an
> **excessive focus on artifacts** […] Such processes are in practice very hard to configure.
> They are also rapidly misused. **I have seen half of RUP implementations fail, caving in
> under the weight of the artifacts that the process supposedly "forces" developers to create,
> manage, update.**
> Our fundamental metaphor: "this is a process, it looks like a program, the machine is a group
> of humans" is **the wrong metaphor**. […] **all software projects are different; even the
> same software project would not be done the same way twice.**
> The many adopters of lean and agile approaches seem to have **voted ("no!") with their feet,
> and moved away.**
Il cite Saint-Exupéry en exergue : « perfection is achieved not when there is nothing left to
add, but when there is nothing left to take away ». Et il n'épargne pas le successeur : « **I
have the same worry with the SEMAT initiative** ».

Et les auteurs eux-mêmes admettent le lien de causalité entre volume et échec (Larman,
Kruchten & Bittner, 2002) :
> The RUP was not meant by its authors to be either heavy or predictive, and it is due to
> superimposition of incorrect process ideas or misunderstanding of the RUP, **exacerbated by
> the large set of detailed process documentation that the RUP product provides**, that it
> could be so mischaracterized or poorly implemented.

**« RUP as waterfall in disguise » : ATTRIBUTION NON VÉRIFIÉE.** Aucun auteur, aucune
publication, aucune date n'ont été trouvés pour cet aphorisme appliqué à RUP. À ne pas
reprendre entre guillemets. **En revanche la critique de fond est massivement sourcée — et
presque toujours par des gens de la maison** :
Larman, Kruchten & Bittner (2002), pas n° 1 sur 7 :
> **Step 1: Superimpose "Waterfall" Thinking** […] This is an example of a linear, sequential
> "waterfall" lifecycle, and is **the first, best, and most common strategy for total RUP
> failure.**
> **The most common strategy for RUP failure is to in some way consider [the phases'] definition
> as similar to the waterfall phases**: 1. Inception—do most of the requirements 2.
> Elaboration—do the detailed design and models 3. Construction—implement 4.
> Transition—integration, system test, deployment. **The above description is quite incorrect,
> but a common misinterpretation** […] **It is not hard to find this misinterpretation in
> various books, articles, presentations, and consulting "advice" on the RUP.**
Pas n° 2 : « **Apply the RUP as a Heavy, Predictive Process** » — « Create most—or even better,
all—of the RUP artifacts » ; « **Draw at least twenty pages of UML diagrams before
programming.** »
Et la défense « pharmacie » : « The RUP is like a medicine cabinet or a drug store. […] Some
people suggest that the RUP is too big; this is like saying that there are too many medicines. »

Attestation que le grief circulait chez les auteurs : **Per Kroll** (chef de produit RUP chez
Rational/IBM, coauteur de *The RUP Made Easy*) a signé « Waterfall Made Easy — The RUP Way » à
la conférence-canular *Waterfall 2006* (https://www.waterfall2006.com/kroll.html) :
> Your team claims that RUP is an iterative process […] **Calmly explain that iterative
> development is just a thin veil of marketing sprinkled over RUP** […] Some think that the
> Elaboration phase is about elaborating on key risks by doing design, implementation and
> testing. Humbug! **The intent is to elaborate on the requirements until there is consensus
> that you have achieved analysis-paralysis.**
C'est une SATIRE écrite par un insider — pas une thèse critique, et pas l'origine de
l'aphorisme. Sa valeur : en 2006, le grief était assez répandu pour être un ressort de blague
reconnaissable chez les auteurs mêmes.

Scott Ambler (secondaire, mais auteur de cinq livres sur le sujet, jamais salarié de Rational) :
> **RUP became unwieldy and hard to understand and apply successfully due to the large amount
> of disparate content.** / **RUP was often inappropriately instantiated as a waterfall.
> Inception was a big requirements up front (BRUF) phase, Elaboration a detailed architecture
> phase, and Transition as a testing phase.**

**Décompte des rôles et artefacts : AUCUNE SOURCE PRIMAIRE IBM.** Les chiffres qui circulent
(30 rôles, 70 artefacts…) n'ont pas de décompte officiel derrière eux. À ne pas citer.
Découverte utile au passage : **le vocabulaire de RUP a changé** — TP026B (2001) dit
« **Workers** » et « nine core process **workflows** » ; Kroll & Kruchten (2003) disent
« **roles** » et « **disciplines** ». Tout décompte non daté et non versionné est inexploitable.

**RUP était conçu comme CONFIGURABLE, l'adoption intégrale n'a jamais été le mode d'emploi**
(TP026B) : « The Rational Unified Process is a **configurable** process. **No single process is
suitable for all software development.** […] It contains a **Development Kit**, providing
support for configuring the process to suit the needs of a given organization. »
→ Retourné, c'est le grief : un produit dont l'emploi correct suppose une expertise de
configuration que l'acheteur n'a pas.

**Trajectoire** : Objectory créé par Ivar Jacobson en Suède en 1987 → fusion Rational/Objectory
AB en 1995 → Rational Objectory Process v4 → RUP. Rachat de Rational par IBM (dates
communément données : annonce 06/12/2002, clôture 21/02/2003, ~2,1 Md$ — **non vérifié en
source primaire**, le 8-K SEC est en 403). Page produit IBM archivée (capture du 07/02/2006) :
RUP n'est déjà plus un produit autonome — « IBM Rational Unified Process, RUP, is **process
guidance content included in the Rational Method Composer framework** ».
Tentatives d'allègement : **OpenUP** (Eclipse Process Framework, ex-Basic Unified Process donné
par IBM fin 2005 ; projet aujourd'hui archivé) ; **EssUP** d'Ivar Jacobson (2007, huit pratiques
composables) ; puis **SEMAT** → **Essence** (OMG).
Le SEMAT *Call to Action* (Jacobson, Meyer & Soley, *Dr. Dobb's Digest*, décembre 2009) :
> **Software engineering is gravely hampered today by immature practices.** Specific problems
> include: **The prevalence of fads more typical of fashion industry than of an engineering
> discipline.** […] **The huge number of methods and method variants, with differences little
> understood and artificially magnified.** […] The lack of credible experimental evaluation and
> validation.
FAIT REMARQUABLE : parmi les signataires figurent **Philippe Kruchten (RUP), Ivar Jacobson
(Objectory), Barry Boehm (modèle en spirale), Ken Schwaber (Scrum), Alistair Cockburn, Scott
Ambler, Victor Basili, Watts Humphrey, Erich Gamma, Robert Martin**. Les camps opposés ont
co-signé, en 2009, une déclaration disant que la prolifération des méthodes était un problème.

**Date officielle de fin de vie de RUP : introuvable** (pages IBM inaccessibles). Le mieux
disponible est Ambler (secondaire) : « RUP was effectively retired by IBM Rational in the early
2010s. »

### §4 ter — KRUCHTEN A ÉCRIT SUR LE DÉVELOPPEUR SEUL. C'est la source la plus directe du dossier.

**Philippe Kruchten (Rational Fellow), « A Software Development Process for a Team of One »,
*The Rational Edge*, février 2002.** PDF consulté (copie hébergée par KTH) :
https://www.csc.kth.se/~karlm/light_sw_process.pdf

Ouverture :
> For some, the phrase "software engineering process" evokes an image of a huge set of dusty
> binders full of policies, directives, and forms, all saturated with administrative jargon.
> […] **In reality, however, a software engineering process does not need to be such a monster.
> It can be as lightweight or heavyweight as the job at hand and the size of the development**
> [team requires].

Il déroule ensuite le journal d'un développeur seul (« Nick », douze ans d'expérience) sur un
projet d'**une semaine**, avec les quatre phases et les jalons RUP nommés — **LCO, LCA, IOC** :
> **Inception.** […] If I get his commitment to pay for a demonstration prototype, then this
> phase will represent **a day of work** on the project. If he won't commit, then we'll quit
> there and remain good friends.
> **Elaboration.** I think I could conclude this phase by **Tuesday lunch. I'll build a rough
> prototype that will allow me to "elaborate" on the requirements, the solution, and the plan,
> and to explore some of my ideas.** Then, I'll ask Gary again to validate everything with me
> over lunch.

Et le commentaire de Kruchten sur ce que fait Nick :
> Nick is very aware of risks, both technical (technologies, languages, interfaces, and
> performance) and business (schedule, expenditure, and missed expectations). **He uses an
> iterative process to mitigate these risks, rapidly trying out ideas to validate them, to get
> feedback from his customer, and to avoid painting himself into a corner. He also sets up a
> plan with a few well-defined milestones, although the project is only one week long.**
> This is the essence of the very lightweight engineering process Nick uses. **It is a "low
> ceremony" process that focuses only on a small number of artifacts or workproducts. It does
> not involve a huge amount of paperwork, since many of the artifacts are stored in various
> development tools.**

→ PORTÉE : l'architecte en chef de RUP montre lui-même que la structure survit à l'échelle
d'une personne et d'une semaine — **ce qui disparaît, c'est la cérémonie et les artefacts, pas
les jalons ni l'ordre**. Et l'Elaboration solo, c'est « a rough prototype » construit en une
journée et demie. C'est la confirmation, par la méthode la plus lourde du corpus, de la
distinction coût de coordination / coût de retravail.

---

## §5 — AMORCE ATAM (vérifié moi-même, texte brut, 14/08/2026)

Source primaire : **Rick Kazman, Mark Klein, Paul Clements, « ATAM: Method for Architecture
Evaluation », Technical Report CMU/SEI-2000-TR-004 / ESC-TR-2000-004, août 2000.**
Notice SEI : https://www.sei.cmu.edu/library/atam-method-for-architecture-evaluation
PDF lu : https://wstomv.win.tue.nl/edu/2ii45/year-0910/00tr004.pdf

**Nature de la méthode — et la réponse à « avant ou après le code ? »** :
> The ATAM is meant to be a **risk identification method**, a means of detecting areas of
> potential risk within the architecture of a complex software intensive system. This has
> several implications: • **The ATAM can be done early in the software development life
> cycle.** • **It can be done relatively inexpensively and quickly (because it is assessing
> architectural design artifacts).** • The ATAM will produce analyses commensurate with the
> level of detail of the architectural specification. Furthermore **it need not produce
> detailed analyses of any measurable quality attribute of a system (such as latency or mean
> time to failure) to be successful. Instead, success is achieved by identifying trends.**
→ CONFIRMÉ : ATAM évalue des **artefacts de conception**, pas un système qui tourne. C'est
même la raison revendiquée de son bon rapport coût/bénéfice.

**Ce qu'il produit** :
> **Risks** are architecturally important decisions that have not been made (e.g., the
> architecture team has not decided what scheduling discipline they will use, or **has not
> decided whether they will use a relational or object oriented database**), or decisions that
> have been made but whose consequences are not fully understood.
> **Sensitivity points** are parameters in the architecture to which some [quality attribute
> is sensitive]. […] **tradeoff points**.

**LE POINT DÉCISIF SUR L'ORDRE ANALYSE → VALIDATION EMPIRIQUE** (phrase de conclusion) :
> Risks, sensitivity points, and tradeoff points are areas of potential future concern with
> the architecture. **These areas can be made the focus of future effort in terms of
> prototyping, design, and analysis.**
→ ATAM ne remplace pas le prototype : il **sélectionne où prototyper**. L'ordre prescrit est
donc analyse documentaire d'abord (pour identifier les points sensibles), prototypage ensuite
et **seulement là**. C'est l'inverse d'un squelette qui traverse tout indistinctement, et
c'est complémentaire du critère de Singer (« core, small, novel »).

### §5 bis — COMPLÉMENTS (recherche parallèle, textes lus en brut par pdftotext/curl)

**BOEHM 1988 — le modèle en spirale.** « A Spiral Model of Software Development and
Enhancement », *IEEE Computer* 21(5), mai 1988, p. 61-72, DOI 10.1109/2.59. Antériorité :
*ACM SIGSOFT Software Engineering Notes* 11(4), août 1986, p. 14-24, DOI 10.1145/12944.12948
(non lu). PDF libre : https://www.cse.msu.edu/~cse435/Homework/HW3/boehm.pdf — ATTENTION,
c'est une **ressaisie**, pas le scan IEEE, avec des corruptions OCR (« spinal » pour spiral).

Un tour de spirale (Boehm ne dit jamais « quadrants », c'est la figure 2 qui les dispose) :
> Each cycle of the spiral begins with the identification of • the **objectives** […] • the
> **alternative means** of implementing this portion of the product […] • the **constraints**
> imposed on the application of the alternatives.
> The next step is to **evaluate the alternatives** relative to the objectives and constraints.
> Frequently, this process will identify areas of uncertainty that are significant sources of
> project risk. If so, the next step should involve the formulation of a **cost-effective
> strategy for resolving the sources of risk**.
> […] each cycle is completed by a **review** involving the primary people or organizations
> concerned with the product. […] The review's major objective is to ensure that all concerned
> parties are **mutually committed to the approach for the next phase**.

Le prototypage n'est qu'un moyen parmi d'autres :
> This may involve **prototyping, simulation, benchmarking, reference checking, administering
> user questionnaires, analytic modeling**, or combinations of these and other risk resolution
> techniques.
> It incorporates **prototyping as a risk reduction option at any stage of development.**

LES PHRASES CLÉS — c'est le risque qui pilote l'ordre :
> The major distinguishing feature of the spiral model is that it creates a **risk-driven
> approach** to the software process rather than a primarily document-driven or code-driven
> process.
> Once the risks are evaluated, **the next step is determined by the relative remaining
> risks.** If performance or user-interface risks strongly dominate […] the next step may be an
> evolutionary development one: a minimal effort to specify the overall nature of the product,
> a plan for the next level of prototyping, and the development of a more detailed prototype.
> Thus, **risk considerations can lead to a project implementing only a subset of all the
> potential steps in the model.**
> This **risk-driven subsetting** of the spiral model steps allows the model to accommodate any
> appropriate mixture of a specification-oriented, prototype-oriented, simulation-oriented […]
> approach to software development.

ET LA RÉPONSE DIRECTE À « COMBIEN DE SPEC AVANT DE CODER ? » :
> For each of the sources of project activity and resource expenditure, it answers the key
> question, **"How much is enough?"** Stated another way, "How much of requirements analysis,
> planning, configuration management, quality assurance, testing, formal verification, and so
> on should a project do?" Using the risk-driven approach, one can see that **the answer is not
> the same for all projects and that the appropriate level of effort is determined by the level
> of risk incurred by not doing enough.**

Boehm montre que son modèle dégénère dans les deux sens selon le profil de risque :
> If a project has a low risk in such areas as getting the wrong user interface or not meeting
> stringent performance requirements, and if it has a high risk in budget and schedule
> predictability and control, then these risk considerations **drive the spiral model into an
> equivalence to the waterfall model.**
> [Inversement, risques d'IHM dominants] drive the spiral model into **an equivalence to the
> evolutionary development model.**
→ Le modèle en spirale est un **sélecteur de méthode**, pas une méthode.

**BOEHM & HANSEN 2000 — les six invariants et les « hazardous spiral look-alikes ».**
*Spiral Development: Experience, Principles, and Refinements*, Special Report
**CMU/SEI-2000-SR-008**, SEI/CMU, juin 2000. PDF qui SE RÉSOUT (contrairement à
resources.sei.cmu.edu) : https://www.sei.cmu.edu/documents/5439/2000_003_001_13655.pdf
> This paper characterizes spiral development by enumerating a few **"invariant" properties**
> that any such process must exhibit. […] **Each invariant excludes one or more "hazardous
> spiral look-alike" models.**

Les six invariants, verbatim :
> 1. Concurrent rather than sequential determination of artifacts.
> 2. Consideration in each spiral cycle of the main spiral elements: critical-stakeholder
>    objectives and constraints — product and process alternatives — risk identification and
>    resolution — stakeholder review — commitment to proceed.
> 3. Using risk considerations to determine the **level of effort** to be devoted to each
>    activity within each spiral cycle.
> 4. Using risk considerations to determine the **degree of detail of each artifact** produced
>    in each spiral cycle.
> 5. Managing stakeholder life-cycle commitments with three **anchor point milestones**:
>    Life Cycle Objectives (LCO) — Life Cycle Architecture (LCA) — Initial Operational
>    Capability (IOC).
> 6. Emphasis on activities and artifacts for **system and life cycle** rather than for
>    software and initial development.

LES SEPT « LOOK-ALIKES DANGEREUX » (Table 3, p. 29), avec l'invariant violé — c'est le
matériau le plus utile du dossier pour savoir quand une approche risk-first est mal appliquée :
> • Incremental sequential waterfalls with significant COTS, user interface, or technology
>   risks (viole 1)
> • Sequential spiral phases with key stakeholders excluded from phases (viole 2)
> • **Risk-insensitive evolutionary or incremental development** (viole 3)
> • **Impeccable spiral plan with no commitment to managing risks** (viole 3)
> • **Insistence on complete specifications for COTS, user interface, or deferred-decision
>   situations** (viole 4)
> • **Evolutionary development with no life-cycle architecture** (viole 5)
> • Purely logical object-oriented methods with operational, performance, or cost risks (viole 6)

Détail de l'invariant 3 :
> • risk-insensitive evolutionary development (e.g., **neglecting scalability risks**)
> • risk-insensitive incremental development (e.g., **suboptimizing on increment 1 with a
>   point-solution architecture which must be dropped or heavily reworked to accommodate future
>   increments**)
> • **impeccable spiral plans with no commitment to managing the risks identified.**

Détail de l'invariant 4 — LA SPEC EXHAUSTIVE EST ELLE-MÊME UN LOOK-ALIKE DANGEREUX :
> the traditional ideal of a complete, consistent, traceable, testable requirements
> specification **is not a good idea for certain product components**, such as a graphic user
> interface (GUI) or COTS interface. Here, **the risk of precisely specifying screen layouts in
> advance of development involves a high probability of locking an awkward user interface into
> the development contract**, while the risk of not specifying screen layouts is low […] Even
> aiming for full consistency and testability can be risky, as it **creates a pressure to
> prematurely specify decisions that would better be deferred.**
Et : « Levels must be balanced between the risks of **learning too little** and the risks of
**wasting time and effort gathering marginally useful information.** »

**CRITIQUES DU MODÈLE EN SPIRALE : les meilleures sont de Boehm lui-même** (§ « Difficulties »
de l'article de 1988) — trois, verbatim :
> The three primary challenges involve **matching to contract software**, **relying on
> risk-assessment expertise**, and the need for further **elaboration of spiral model steps**.
(1) Contrat : « The world of contract software acquisition has a harder time achieving these
degrees of flexibility and freedom without losing accountability and control. »
(2) Dépendance à l'expertise — la plus applicable à un développeur seul :
> The spiral model places a great deal of reliance on the ability of software developers to
> identify and manage sources of project risk. […] a team of inexperienced or low-balling
> developers may also produce a specification with […] a great elaboration of detail for the
> well-understood, low-risk elements, and little elaboration of the poorly understood,
> high-risk elements. […] **this type of project will give an illusion of progress during a
> period in which it is actually heading for disaster.**
MAIS Boehm détruit aussitôt le confort symétrique :
> With a conventional, document-driven approach, the requirement to carry all aspects of the
> specification to a uniform level of detail […] **creates a large drain on the time of the
> scarce experts, who must dig for the critical issues within a large mass of non-critical
> detail.** Furthermore, if the high-risk elements have been glossed over by impressive-sounding
> references to poorly understood capabilities […] **there is an even greater risk that the
> conventional approach will give the illusion of progress in situations that are actually
> heading for disaster.**
(3) Absence de guidage — ET LA PHRASE QUI TRANCHE POUR LE SOLO :
> **Highly experienced people can successfully use the spiral approach without these
> elaborations.** However, **for large-scale use in situations in which people bring widely
> differing experience bases to the project**, added levels of elaboration […] are important in
> ensuring consistent interpretation and use of the spiral approach across the project.
→ Le cérémonial documentaire est explicitement justifié par l'hétérogénéité d'expérience
**entre plusieurs personnes**. Boehm dit qu'un praticien expérimenté peut s'en passer.
Confirmé en 2000 (SR-008) : « A primary difficulty in applying the spiral model has been the
**lack of explicit process guidance** in determining these objectives, constraints, and
alternatives. »

CRITIQUES EXTERNES DU MODÈLE EN SPIRALE : **résultat négatif assumé.** La litanie « coûteux /
inadapté aux petits projets / estimation difficile / dépend de l'expertise » ne se trouve que
sur des sites pédagogiques sans source (GeeksforGeeks, TutorialsPoint, blogs). Elle paraît
être une reformulation non citée de la section « Difficulties » de Boehm 1988. Aucun article
évalué par les pairs consacré à la critique du modèle n'a été trouvé — accès Scopus/IEEE
Xplore non disponible, donc absence de recherche et non preuve d'inexistence.

### §5 ter — ATAM, compléments (texte brut)

PDF qui se résout : https://www.sei.cmu.edu/documents/629/2000_005_001_13706.pdf
L'aveu de portée, à citer intégralement :
> This final point is crucial in understanding the goals of the ATAM; **we are not attempting
> to precisely predict quality attribute behavior. That would be impossible at an early stage
> of design; one doesn't have enough information to make such a prediction.** What we are
> interested in doing—in the spirit of a risk identification activity—is learning where an
> attribute of interest is affected by architectural design decisions, so that we can reason
> carefully about those decisions, model them more completely in subsequent analyses, and
> **devote more of our design, analysis, and prototyping energies on such decisions.**
Et :
> The ATAM is a means of determining whether these goals are achievable by the architecture as
> it has been conceived, **before enormous organizational resources have been committed to it.**
> Having a structured method helps ensure that the right questions regarding an architecture
> will be asked **early, during the requirements and design stages when discovered problems can
> be solved relatively cheaply.**

**RÉSULTAT NÉGATIF IMPORTANT :** grep sur le texte intégral (cost, cheap, expensive, early,
life cycle, days, participants) → **le rapport n'énonce AUCUN ratio, AUCUN chiffre, AUCUNE
étude** sur le coût comparé de la découverte d'un défaut par l'analyse plutôt que par
l'implémentation. Les formulations sont purement qualitatives. **La prémisse économique
d'ATAM est posée, pas mesurée, par ses auteurs** — et elle emprunte implicitement à la courbe
du coût du changement, contestée au §6.

COÛT ET PARTICIPANTS, chiffres donnés par les auteurs :
> Running an ATAM can involve **as few as three to five stakeholders or as many as 40 or 50.**
> in Phase 1 […] a subset of the evaluation team (typically one to three people) […]
> **This interaction typically takes several weeks.**
Agenda type (Figure 11, p. 41) : **3 journées pleines**, jour 1 = Phase 1, « Break of several
weeks », jours 2-3 = Phase 2.
Et la conclusion, qui dit ce que la méthode vend réellement :
> An architecture analysis method, any architecture analysis method, is a
> **garbage-in-garbage-out** process. […] Our purpose in creating a method (rather than, say,
> just putting some intelligent and experienced people together in a room and having them chat
> about the architecture […]) is to **increase the effectiveness and repeatability of the
> analysis.**
→ ATAM ne prétend pas être meilleur qu'un expert seul qui réfléchit : il prétend être
**reproductible et auditable entre plusieurs personnes**. Son coût est donc structurellement
un **coût de coordination**. Un développeur seul paie zéro sur cette ligne — et perd la
reproductibilité, qui est le produit vendu.

Le couple analyse/prototype, écrit noir sur blanc dans TR-004 (étude de cas Battlefield
Control System) :
> the process of performing an ATAM on the BCS raised the stakeholders' awareness of critical
> risk, sensitivity, and tradeoff issues. This, in turn, **focused design activity in the areas
> of highest risk and caused a major iteration within the spiral process of design and
> analysis.**

Existence d'une littérature « lightweight » : Sahlabadi, Muniyandi, Shukur, Qamar,
« Lightweight Software Architecture Evaluation for Industry: A Comprehensive Review »,
*Sensors* 22(3):1252, 2022, DOI 10.3390/s22031252 — **obtenu par résumé, non lu en brut, à ne
pas citer**. Le fait notable, lui, est sûr : qu'une littérature entière soit consacrée depuis
~2010 à produire des variantes allégées d'ATAM (ARID d'origine SEI, PBAR, TARA, DCAR) atteste
que la communauté juge l'ATAM canonique trop lourd pour un usage courant.

À COMPLÉTER par la recherche parallèle : coût réel (nombre de participants, durée),
critiques d'inadaptation aux petits projets, et le complément QAW (Quality Attribute
Workshop, CMU/SEI-2003-TR-016), qui s'applique « **before the software architecture is fully
developed** » (cf. CMU/SEI-2002-TN-005, « SEI Architecture Analysis Techniques and When to
Use Them », https://apps.dtic.mil/sti/tr/pdf/ADA413696.pdf).

---

## §6 — AMORCE : coût de coordination vs coût de retravail (vérifié moi-même)

**Brooks : le coût de coordination est une fonction du NOMBRE DE PERSONNES, explicitement.**
*The Mythical Man-Month*, chapitre 2, texte vérifié en brut le 14/08/2026 sur
https://bowringj.people.charleston.edu/classes/csis%20602/docs/The.Mythical.Man.Month.F.Brooks.pdf
> The added burden of communication is made up of two parts, **training and
> intercommunication**. Each worker must be trained in the technology, the goals of the
> effort, the overall strategy, and the plan of work. This training cannot be partitioned,
> so this part of the added effort **varies linearly with the number of workers**.
> **Intercommunication is worse. If each part of the task must be separately coordinated with
> each other part, the effort increases as n(n-1)/2.** Three workers require three times as
> much pairwise intercommunication as two; four require six times as much as two.
Et la proposition 2.12 (chapitre 18, « Propositions… True or False? ») :
> Adding people to a software project increases the total effort necessary in three ways:
> **the work and disruption of repartitioning itself, training the new people, and added
> intercommunication.**
→ POUR n = 1 : n(n-1)/2 = 0. Le terme d'intercommunication s'annule, et le terme de
formation aussi. **Tout le poids que Brooks impute à la coordination disparaît pour un
développeur seul.** Le coût de retravail, lui, ne dépend pas de n.

**Singer, l'aveu symétrique côté méthode** (Shape Up, annexe « Adjust to Your Size ») :
> After you hire more people, all of this fluidity flips from an asset to a liability. […]
> **Coordination starts to eat up more of your time** and things begin to slip through the
> cracks. **This is when it makes sense to take on the structure of six-week cycles,
> cool-downs, and a formal betting table.**
Et, en dessous de ce seuil :
> **a tiny team can throw out most of the structure.** […] Shaping the work sets clearer
> boundaries and expectations for whoever does the work—**whether that's a separate team or
> just your future self.**
→ Singer distingue lui-même ce qui reste vrai en solo (le shaping, comme service rendu à
soi-même plus tard) de ce qui n'existe que pour coordonner (cycles, cool-down, betting table).

**Cagan, la troisième borne** (« Discovery vs. Delivery ») :
> **If you are an early stage startup and you have no customers, then of course this is not
> really an issue (and it may be premature to even be creating production-quality software).**

### LA TROUVAILLE DÉCISIVE DU §6 — Boehm & Basili se démentent eux-mêmes pour les petits projets

Source primaire : **Barry Boehm (USC) & Victor R. Basili (U. Maryland), « Software Defect
Reduction Top 10 List », *IEEE Computer*, vol. 34, n° 1, janvier 2001, p. 135-137.**
PDF sur la page de publications de Basili (donc source d'auteur) :
https://www.cs.umd.edu/users/basili/publications/journals/J81.pdf
**Texte vérifié en brut le 14/08/2026.**

Le point n° 1 de la liste :
> **ONE** Finding and fixing a software problem after delivery is **often** 100 times more
> expensive than finding and fixing it during the requirements and design phase.

Et immédiatement après — c'est LE passage :
> As Boehm observed in 1987, "This insight has been a major driver in focusing industrial
> software practice on thorough requirements analysis and design, on early verification and
> validation, and on up-front prototyping and simulation to avoid costly downstream fixes."
> **For this updated list, we have added the word "often" to reflect additional insights about
> this observation. One insight shows the cost-escalation factor for small, noncritical
> software systems to be more like 5:1 than 100:1. This ratio reveals that we can develop such
> systems more efficiently in a less formal, continuous prototype mode that still emphasizes
> getting things right early rather than late.**

Et la seconde nuance, sur les gros systèmes :
> Another insight reveals that **good architectural practices can significantly reduce the
> cost-escalation factor even for large critical systems. Such practices reduce the cost of
> most fixes by confining them to small, well-encapsulated modules.** A good example is the
> million-line CCPDS-R system described in Walker Royce's book, *Software Project Management*
> (Addison-Wesley, 1998).

Point n° 2 :
> **TWO** Current software projects spend about **40 to 50 percent of their effort on avoidable
> rework.**

→ PORTÉE POUR LA QUESTION POSÉE : l'auteur même de la courbe du coût du changement écrit, en
source primaire revue par les pairs, que (1) le facteur est **5:1 et non 100:1** pour un petit
système non critique, et (2) que ce facteur bas **justifie précisément** un mode de
développement « **less formal, continuous prototype mode** ». C'est-à-dire : monter quelque
chose qui tourne et itérer, plutôt que dérouler des phases. Le chiffre de 100:1, qui sert
d'argument massue en faveur de l'analyse amont exhaustive, est un résultat de **gros système
critique** — et ses auteurs le disent.
→ Et le second point ajoute le vrai levier : ce qui fait chuter le coût du retravail, ce n'est
pas de décider plus tôt, c'est la **modularité** (« confining them to small, well-encapsulated
modules »). Même conclusion que Fowler (« Knowing your architecture is sacrificial doesn't
mean abandoning the internal quality »).

**La généalogie contestée du 1:10:100 — Laurent Bossavit.**
*The Leprechauns of Software Engineering — How folklore turns into fact and what to do about
it*, Laurent Bossavit, Leanpub. Table des matières vérifiée sur la page de l'éditeur
(https://leanpub.com/leprechauns) : **chapitre 10, « The cost of defects: an illustrated
history »**, sous-sections « Origins / First amendments / **Where's the data?** / Metamorphoses
/ Changing the topic altogether / Reading curves / Theory-laden diagrams / **Boehm's assent** »,
et **annexe B, « bibliographical analysis for the "defect-cost-increase curve" »**.
RÉSERVE : je n'ai PAS lu le texte du livre. Ce que j'ai, ce sont (a) sa table des matières
chez l'éditeur, (b) les propos de Bossavit lui-même en entretien et en conférence.

Bossavit en entretien (interview vidéo, transcription publiée sur devgraph.com et
blog.glitch.com, « The 10X Programmer, and other Myths », 11/09/2015) — propos de l'auteur :
> **I could not find any solid proof that someone had measured something and came up with
> those fantastic costs** […] You can find some empirical data in Barry Boehm's books and he's
> often cited as the originator of the claim. **But it's much less convincing when you look at
> the original data than when you look at the derived citations.**
> These claims have been repeated exactly using the same numbers for **at least three decades**.

Bossavit en conférence (transcription YouTube « Leprechauns of Software Engineering ») —
il rejoue les données d'origine dans un tableur :
> at least one series does seem to fit more or less an exponential curve and that's the red
> […] **but it's the only data series that does that**
> **it's actually cheaper according to [the] graph to fix a defect in maintenance than it is
> in functional testing, contrary to what […] received wisdom and everyone who cites the curve
> is saying**
> it's actually more expensive to fix a defect in the architectural phase than it is in the
> design phase

**Le « IBM Systems Sciences Institute » (source du graphe 1x / 6.5x / 15x / 100x) :
étude introuvable.** Le grief est repris par The Register, 22 juillet 2021 (« Everyone cites
that bugs are 100x more expensive to fix in production, but the study might not even exist »)
et par Hillel Wayne. La piste remonterait à une note de bas de page du manuel de Roger
Pressman renvoyant à des supports de cours internes IBM de 1981. **Je n'ai pas vérifié cette
généalogie en source primaire** — à présenter comme rapportée, en distinguant nettement du
point Boehm & Basili 2001 qui, lui, est vérifié.

### §6 bis — LA COURBE DE BOEHM AVAIT DÉJÀ DEUX TRACÉS, DONT UN PLAT POUR LES PETITS PROJETS

Source : Boehm, *Software Engineering Economics*, Prentice Hall, 1981, **figure p. 40**
(non lue directement ; établie via la traçabilité faite par Menzies et al., ci-dessous).
Les données d'origine viennent de **grands systèmes de la fin des années 1970**, de quatre
organisations : **IBM, TRW, GTE, Bell Labs (programme Safeguard)**. Sources primaires
identifiables : Boehm, « Software engineering », *IEEE Trans. Computers* C-25(12), déc. 1976 ;
Daly, *IEEE TSE* SE-3(3), mai 1977 (GTE) ; Fagan, *IBM Systems Journal* 15(3), 1976 ;
Stephenson, *Proc. ICSE '76*.
> **The data points from these studies are not published for analysis.**
> We note that it is unclear from the text […] if cost is defined in terms of effort, or in
> actual cost.

ET LE FAIT DÉCISIF, qui ne dépend d'aucun contestataire :
> Some studies report smaller increases in the effort required to fix delayed issues. **Boehm
> provides data suggesting that the cost-to-fix curve for small projects is flatter than for
> large projects (the dashed line of Figure 2).**
Référence : Boehm, « Developing small-scale application software products: Some experimental
results », *Proceedings of the IFIP Congress*, 1980, p. 321-326.
→ **La courbe de Boehm 1981 comporte deux tracés** : un pour les grands projets (~1:100), et
**un en pointillés, nettement plus plat, pour les petits projets**. Le ratio 100:1 n'a jamais
été présenté par son auteur comme valant pour un petit projet.
RÉSERVE : le chiffre exact de la pente « petits projets » (souvent cité 1:4 ou 1:5) n'a pas
été vu dans un texte primaire. Ne pas le citer comme établi.

### §6 ter — LA CONTRE-ÉPREUVE EMPIRIQUE MODERNE, ET ELLE VIENT DU SEI

Menzies, Nichols, Shull, Layman, « Are Delayed Issues Harder to Resolve? Revisiting Cost-to-Fix
of Defects throughout the Lifecycle », arXiv **1609.04886v1**, 16/09/2016 —
https://arxiv.org/pdf/1609.04886 ; version publiée *Empirical Software Engineering* 22(4),
2017, p. 1903-1935. **Nichols et Shull sont au SEI de Carnegie Mellon** — ce n'est pas une
charge militante, c'est le SEI qui réexamine son héritage.
> Many practitioners and academics believe in a **delayed issue effect (DIE)** […] This paper
> tests for the delayed issue effect in **171 software projects conducted around the world in
> the period from 2006–2014.** To the best of our knowledge, this is the largest study yet
> published on this effect. **We found no evidence for the delayed issue effect; i.e. the
> effort to resolve issues in a later phase was not consistently or substantially greater than
> when issues were resolved soon after their introduction.**

Sur la circularité des citations :
> the evidence for delayed issue effect is both **very sparse and very old**. […] **nearly
> every citation to the delayed issue effect could be traced to the seminal *Software
> Engineering Economics* or its related works.**
> popular sources such as [Boehm & Basili 2001, Brooks, Glass, McConnell…], with a **combined
> citation count of over 14,500 on Google Scholar**, can all trace their evidence to *Software
> Engineering Economics*.
> An example of this is Figure 4 from [Stecklein et al.], which purports to show nine
> references to "studies [that] have been performed to determine the software error cost
> factors". **Only one of these sources, *Software Engineering Economics*, is based on real
> project data.**
Leur propre tableau recense, pour les ratios cités phase par phase : « **Fictitious example** »
(trois fois), « Unknown - no bibliography entry », « Extrapolated from defect counts for a one
project ».

Leurs conclusions, verbatim :
> We do not claim that this theory never holds in software projects; just that **it cannot be
> assumed to always hold**, as data have been found that falsify the general theory. […]
> 3. The effect might be **confined to very large systems** — in which case it would be
>    acceptable during development **to let smaller to medium sized projects carry some
>    unresolved issues from early phases into later phases.**
> 4. The effect might be **mitigated by modern software development approaches** that encourage
>    change and revision of older parts of the system.
> 5. The effect might be **mitigated by modern software development tools** that simplify the
>    process of large-scale reorganization.
Avec la restriction qu'ils posent eux-mêmes :
> The delayed issue effect may continue to be prevalent in some cases, such as high-assurance
> software, **architecturally complex systems**, or in projects with poor engineering
> discipline. **We do not have evidence for or against such claims.**
Et le seul chiffre mesuré et publié sur le retravail architectural (Royce, système critique
d'un million de lignes) : « **Design changes (including architecture changes) required
approximately twice the effort of implementation and test changes** » — un facteur **2**,
pas 100. Boehm l'attribue « to a development process focused on removing architecture risk
early in the lifecycle ».

### §6 quater — BOSSAVIT : ce qu'il démontre exactement (et ce qu'il ne démontre pas)

**Le chapitre 10 du livre n'a PAS pu être lu** : l'extrait libre de Leanpub ne contient que
Preface, Prelude, ch. 2 (Cone of Uncertainty) et ch. 7 (Waterfall) — vérifié en brut.
**En revanche, ses notes de recherche publiques sur exactement ce sujet ont été lues
intégralement en texte brut.** Ce sont des sources primaires (Bossavit écrivant lui-même) :
- https://gist.github.com/Morendil/ebfa32d10528af04e2ccb8995e3cb4a7 (« The IBM Systems Science Institute »)
- https://gist.github.com/Morendil/6d664bf990c17ea0f88f9bb0cc403c64 (« Pressman Ratios »)
- https://gist.github.com/Morendil/f9c2e9f3f450d3a76de8aeee7cf2bd00 (« Wolverton Ratios »)

Son cadrage :
> I have been researching quantity and quality of empirical evidence underlying claims in
> software engineering. What do we know, and how well-established is that? […] the answer is in
> (too) many cases **"not much, and poor"**. This applies in particular to the **"Defect Cost
> Increase"** claim, which is **poorly supported by evidence**.

Les ratios de Pressman (1 / 6,5 / 15 / 60-100), cités par Bossavit citant Pressman :
> "Assume that an error uncovered during design will cost 1.0 monetary unit to correct.
> Relative to this cost, the same error uncovered just before testing commences will cost 6.5
> units; during testing, 15 units; and after release, between 60 and 100 units."
> The reference cited by Pressman is: [IBM81] "Implementing Software Inspections," **course
> notes**, IBM Systems Sciences Institute, IBM Corporation, 1981.
Ses conclusions :
> **Evidence that the Systems Sciences Institute even existed is scant and hard to come by.**
> A search of the IBM corporate web site yields nothing.
> — **the Institute was a corporate training program, not a research body**; as such it is
> inappropriate to cite the source of the ratios as "an IBM study" […]
> — the original project data, **if any exist**, are not more recent than 1981, and probably
> older; and **could be as old as 1967**.
La mutation de la citation :
> In a 2003 article […] we find the following form: "IBM Systems Sciences Inst., Implementing
> Software Inspections, **monograph**, IBM, 1981." […] my interpretation of "course notes" is
> that Pressman **attended internal corporate training at IBM** […] **The above form of the
> citation, however, does claim this implicitly.**
Sur une reprise incohérente avec sa propre illustration :
> **the above quoted sentence makes zero sense when we consider the picture it's supposed to
> describe.** […] **Academics are copying and pasting a citation incorrectly attributing data
> to a study by a part of IBM, and at the same time uncritically copying and pasting a
> nonsensical sentence lifted out of a blog post.**
Les ratios de Wolverton (1:3:7:50:100), origine 1977, tutoriel de R. W. Wolverton au premier
COMPSAC, données du programme antimissile **Safeguard** :
> The Big Puzzle is that a bunch of later article and books attribute these ratios to a paper
> by Boehm and Basili "Software Defect Reduction Top 10 List" **which, it is easy to verify,
> does not contain these numbers.** (It's a whole two pages long.) Ergo, these later authors
> who are citing Boehm and Basili **actually HAVE NOT READ that paper.**
> The crime is **how little attention we are paying, as a profession, to the question "what
> process of empirical investigation generated the data we are looking at, and how reliable was
> that process".**

**CE QUE BOSSAVIT NE DÉMONTRE PAS, et qu'il ne faut pas lui faire dire** : il ne démontre pas
que corriger tard coûte autant que corriger tôt. Il démontre que **les chiffres qui circulent
n'ont pas de fondement empirique traçable**. C'est une thèse sur la qualité de la preuve, pas
sur le phénomène. La contestation du phénomène lui-même, c'est Menzies et al.

### §6 quinquies — KENT BECK : la contestation, et sa propre absence de données

Source primaire lue en brut : Kent Beck, *Extreme Programming Explained: Embrace Change*,
Addison-Wesley, 1999, **chapitre 5 « Cost of Change »**.
> Under certain circumstances, the exponential rise in the cost of changing software over time
> **can be flattened**. If we can flatten the curve, old assumptions about the best way to
> develop software no longer hold.
COMMENT IL PRÉSENTE LA COURBE ADVERSE — et c'est décisif :
> One of the universal assumptions of software engineering is that the cost of changing a
> program rises exponentially over time. **I can remember sitting in a big linoleum-floored
> classroom as a college junior and seeing the professor draw on the board the curve found in
> Figure 1.**
→ **Beck ne cite AUCUNE source pour la courbe qu'il combat : sa référence est un professeur au
tableau noir.** Ni Boehm, ni 1981, ni aucune référence dans le chapitre.
Sa thèse :
> What if the cost of change didn't rise exponentially over time, but rose much more slowly,
> **eventually reaching an asymptote**? […] **This is one of the premises of XP. It is the
> technical premise of XP.** […] **You would make big decisions as late in the process as
> possible**, to defer the cost of making the decisions and to have the greatest possible
> chance that they would be right.
> **If a flattened change cost curve makes XP possible, a steep change cost curve makes XP
> impossible.** If change is ruinously expensive, you would be crazy to charge ahead without
> careful forethought. But if change stays cheap, the additional value and reduced risk of
> early concrete feedback outweighs the additional cost of early change.
SA PREUVE : **une anecdote, une seule** — refonte du modèle de transaction d'un système
d'assurance-vie en un après-midi, couverte par « more than 1,000 unit and functional tests » :
> A change that would have taken a few minutes before much coding had occurred **took 30
> minutes after we had been in production for two years.**
Et les conditions qu'il pose lui-même : « **Keeping the cost of change low doesn't just happen
magically.** » — conception simple sans éléments anticipés, tests automatisés, entraînement au
refactoring.
Et la limite de domaine, dans son article *IEEE Computer* d'octobre 1999 (« Embracing Change
with Extreme Programming », p. 70-77) :
> the limits of its application are not clear. […] My strategy is first to try XP where it is
> clearly applicable: **outsourced or in-house development of small- to medium-sized systems
> where requirements are vague and likely to change.**
→ VERDICT SYMÉTRIQUE À ASSUMER : Beck oppose à une courbe non sourcée une courbe non sourcée.
Sa preuve est un projet, un facteur ~6-10 sur un cas. Remplacer la courbe de Boehm par celle de
Beck, c'est changer de croyance, pas passer à l'évidence.
NON VÉRIFIÉ : l'affirmation courante selon laquelle Beck aurait retiré cette courbe de la 2e
édition (2004). À ne pas présenter comme un fait.

### §6 sexies — COCOMO II : LE SEUL CHIFFRAGE CALIBRÉ, ET IL EST DÉCISIF

*COCOMO II Model Definition Manual*, USC Center for Software Engineering. Copie lue en brut :
https://athena.ecs.csus.edu/~buckley/CSc231_files/Cocomo_II_Manual.pdf
Le facteur **RESL — « Architecture / Risk Resolution »** est l'un des cinq *scale factors*.
Table I-3, caractéristique la plus parlante, verbatim :
> **Percent of development schedule devoted to establishing architecture, given general product
> objectives** : 5 — 10 — 17 — 25 — 33 — 40 [de Very Low à Extra High]
Second axe : « Percent of required top software architects available to project : 20 — 40 — 60
— 80 — 100 — 120 ».
Le mécanisme :
> […] summed across all of the factors, and used to determine a **scale exponent, B** […] a
> 100 KSLOC project with Extra High ratings for all factors will have ΣWi = 0, B = 1.01 […] If
> scale factors with Very Low rating […] B = 1.26.
Et, confirmé dans Menzies, Yang, Mathew, Boehm, Hihn (arXiv 1609.05563) :
> **scale factors change effort exponentially while effort multipliers have a linear impact on
> effort.**

**LE POINT THÉORIQUE DÉCISIF, et il est démontrable, pas rhétorique :** RESL est un **facteur
d'échelle**, pas un multiplicateur. Il agit sur **l'exposant** de la taille dans la formule
d'effort. Conséquence mathématique directe : **la pénalité de ne pas faire d'architecture croît
avec la taille du projet et tend vers zéro quand la taille tend vers zéro.** Ce n'est pas une
opinion sur les petits projets, c'est la forme de la fonction — publiée par Boehm, calibrée
sur 161 projets.
RÉSERVE : les chiffres qui circulent (pénalité de retravail 14 % à 10 KSLOC contre 91 % à
10 000 KSLOC, et le « sweet spot ») viennent de Boehm, « Architecting: How Much and When? »,
in Oram & Wilson (dir.), *Making Software*, O'Reilly, 2010, ch. 10 — **chapitre non lu (403)**.
Ne pas citer ces deux nombres comme établis. En revanche la table RESL du manuel est lue.
Ce qui EST lu dans les supports de Boehm (PROMISE 2009) : « **Larger projects need more** » et
« Sweet Spot Drivers: **Rapid Change: leftward** ; **High Assurance: rightward** » → plus le
contexte change vite, **moins** on investit en architecture initiale ; plus l'assurance requise
est haute, **plus** on y investit.

### §6 septies — CONWAY : le coût de coordination est quadratique, et c'est lui qui l'écrit

Melvin E. Conway, « How Do Committees Invent? », *Datamation*, avril 1968 —
https://www.melconway.com/research/committees.html
> **Any organization that designs a system […] will inevitably produce a design whose structure
> is a copy of the organization's communication structure.**
> **Elementary probability theory tells us that the number of possible communication paths in
> an organization is approximately half the square of the number of people in the
> organization.** Even in a moderately small organization it becomes necessary to **restrict
> communication in order that people can get some "work" done.**
> Once scopes of activity are defined, **a coordination problem is created.** Coordination
> among task groups, **although it appears to lower the productivity of the individual in the
> small group**, provides the only possibility that the separate task groups will be able to
> consolidate their efforts.
> Given any design team organization, **there is a class of design alternatives which cannot be
> effectively pursued by such an organization because the necessary communication paths do not
> exist.** Therefore, **there is no such thing as a design group which is both organized and
> unbiased.**
> **The larger an organization is, the less flexibility it has and the more pronounced is the
> phenomenon.**
→ n²/2 chemins : **zéro pour une personne**, 1 pour deux, 800 pour quarante (le haut de la
fourchette ATAM). Conway écrit lui-même que la coordination « paraît abaisser la productivité
de l'individu » : il en fait un mal nécessaire de l'**organisation**, pas une exigence de la
**conception**.

### §6 octies — CUNNINGHAM : la dette technique n'a JAMAIS été un argument pour concevoir plus en amont

Ward Cunningham, « The WyCash Portfolio Management System », OOPSLA '92 Experience Report,
26 mars 1992 — http://c2.com/doc/oopsla92.html
> **Shipping first time code is like going into debt. A little debt speeds development so long
> as it is paid back promptly with a rewrite.** Objects make the cost of this transaction
> tolerable. **The danger occurs when the debt is not repaid. Every minute spent on
> not-quite-right code counts as interest on that debt.**
Et la conclusion, très rarement citée, qui oppose explicitement les deux approches :
> The traditional waterfall development cycle has endeavored to avoid programming catastrophy
> by working out a program in detail before programming begins. […] **using our debt analogy,
> we recognize this amounts to preserving the concept of payment up-front and in-full.** The
> modularity offered by objects and the practice of consolidation make the alternative,
> **incremental growth**, both feasible and desirable […] in the competitive financial software
> market.
→ Chez Cunningham, la métaphore de la dette sert à défendre le **refactoring**, pas la
conception amont. Il qualifie le tout-en-amont de « paiement d'avance et intégral ».

Kruchten, Nord, Ozkaya, « Technical Debt: From Metaphor to Theory and Practice », *IEEE
Software* 29(6), 2012, p. 18-21 — https://www.sei.cmu.edu/documents/360/2012_019_001_58818.pdf
> the concept of technical debt in software development has become somewhat **diluted** lately.
> […] **The metaphor is losing some of its strength.**
> **where time to market is essential, the debt might actually be a good investment**, but it's
> imperative to remain aware of this debt and the increased friction it will impose.
> Gaps in technology are of particular interest because **the debt incurred isn't the result of
> having made a wrong choice originally, but rather the result of the context's evolution—the
> passing of time**—so that the choice isn't quite right in retrospect.
> You could even argue that **"gold plating" an architectural design, making the system more
> flexible and adaptable than it actually needs to be, can be a form of technical debt**, if
> this added flexibility hinders future development without actually being exploited.

**NON UTILISABLE : les rapports CISQ/CAST** (« Cost of Poor Software Quality in the US »,
2,41 T$ en 2022). Serveur `it-cisq.org` en HTTP 522, rapport non lu ; la méthode annoncée dans
les communiqués — « analysis, synthesis and extrapolation of 88 existing sources of available
online information, mixed with some expert knowledge » — en ferait de toute façon une
extrapolation macroéconomique à partir de sources secondaires, pas un relevé. Sponsor :
Synopsys. **À ne pas utiliser comme preuve.**

**RÉSULTAT NÉGATIF ASSUMÉ : aucune donnée empirique sur le coût de changer de stack en cours
de projet.** Recherches menées le 14/08/2026. Ce qui existe est adjacent, pas équivalent.
Le mécanisme est nommé sans être chiffré dans SR-008 (invariant 1) :
> Because sequential determination of the key artifacts will prematurely overconstrain, and
> often extinguish, the possibility of developing a system which satisfies the stakeholders'
> essential success conditions. Examples are **premature commitments to hardware platforms, to
> incompatible combinations of COTS components** […]
Et l'exemple concret donné par le SEI est très exactement un mauvais choix de brique technique :
ER Mapper choisi pour sa puissance, puis abandonné pour Mr. SID faute de portabilité Mac/UNIX,
« **but only after a good deal of effort was wasted on elaborating the ER Mapper solution** ».
Le remède proposé par le SEI n'est PAS « analyser plus longtemps » : c'est impliquer plus tôt
un représentant des utilisateurs Mac/UNIX. **Une vérification, pas une phase.**

### §6 nonies — ADDENDA POSTÉRIEURS À LA REMISE DU RAPPORT (dernier fil de recherche)

**1. Le profil des 171 projets de Menzies et al. — c'est ce qui rend le résultat transposable.**
Caractéristiques relevées dans le papier : **taille d'équipe médiane 6, moyenne 7,8** ; **durée
médiane 61 jours** ; **LOC ajoutées ou modifiées, médiane ≈ 4 201**.
→ Le résultat nul sur l'effet de retard n'est PAS un résultat de grands systèmes transposé de
force aux petits : **l'échantillon est fait de petits projets et de petites équipes**. C'est
exactement le régime d'un développeur indépendant. Cet élément manquait au rapport remis et
renforce nettement le §6.3.

**2. La réserve de Menzies et al. sur l'architecture de base — à ne pas escamoter.**
Passage qui ne figurait pas dans le rapport remis :
> **For the baseline architecture, bad decisions made early in the life cycle may be too
> expensive to change and the DIE may still hold.** However, **smaller projects within the
> larger architecture** […] can leverage more agile, interactive development **provided that
> interfaces and architectural requirements are well-defined.**
→ Même dans l'étude qui ne trouve aucun effet de retard, les auteurs **maintiennent
explicitement l'exception pour l'architecture de base**. Le retravail cher, s'il existe, est
celui-là — pas celui d'une fonctionnalité. C'est la réserve la plus honnête du dossier et elle
tempère la synthèse : elle vaut pour le choix de stack, précisément.

**3. Conway — le passage « deux hommes contre cent hommes ».**
Non cité dans le rapport remis, et directement pertinent pour le §6.7 :
> two men working for a year or one hundred men working for a week (at the same hourly cost per
> man) are resources of equal value. Assuming that two men and one hundred men cannot work in
> the same organizational structure […] our homomorphism says that **they will not design
> similar systems**; therefore the value of their efforts **may not even be comparable**. From
> experience we know that **the two men, if they are well chosen and survive the experience,
> will give us a better system.** **Assumptions which may be adequate for peeling potatoes and
> erecting brick walls fail for designing systems.**

**4. COCOMO II, Table I-1 — le second axe de RESL, qui manquait.**
> RESL — little (20%) / some (40%) / often (60%) / generally (75%) / mostly (90%) / full (100%)
avec la note : « **% significant module interfaces specified, % significant risks eliminated** ».
→ RESL ne mesure pas seulement un pourcentage de calendrier : il mesure **quelle proportion des
interfaces significatives est spécifiée et quelle proportion des risques significatifs est
éliminée**. C'est une définition opérationnelle du « assez d'architecture », plus utile que le
pourcentage seul.

**5. DEUX TROUS DÉCLARÉS, qui s'ajoutent à la liste finale du rapport remis :**
- **Scott Ambler sur la courbe du coût du changement : non couvert.** Recherche non menée.
- **Productivité du développeur seul ou des très petites équipes : non couvert.** Aucune
  recherche aboutie. C'est le trou le plus regrettable au vu de la question posée — le §6.7
  repose donc sur la *décomposition* du coût (Conway, Brooks, Singer, Boehm, ATAM), et non sur
  des données de productivité en solo, qui n'ont pas été cherchées.

**6. Confirmations, sans apport neuf** : le caractère qualitatif et non chiffré de la prémisse
économique d'ATAM (grep exhaustif sur `cost|cheap|expensive|ratio|times`) ; l'absence de toute
critique externe du modèle en spirale appuyée sur des données ; l'absence de toute donnée sur
le coût d'un changement de stack ; l'inutilisabilité des rapports CISQ/CAST. Ces quatre
constats négatifs, établis indépendamment par deux chemins de recherche, sont solides.

**Le coût de retravail, lui, est fonction de la MASSE CONSTRUITE DESSUS, pas de la date :**
- Cockburn (Incremental Rearchitecture) : correction faite « while the system's delivered
  functionality was still small ».
- Hunt & Thomas : « **a small body of code has low inertia—it is easy and quick to change.** »
- Fowler (cost of carry) : le coût se paie « on every feature built between now and the time
  the presumptive feature starts being useful » — donc proportionnel à ce qu'on empile dessus.

---

## VÉRIFICATIONS PONCTUELLES FAITES MOI-MÊME (contre le risque de citation fantôme)

**Brooks — le revirement de 1995 : VÉRIFIÉ en texte intégral.**
*The Mythical Man-Month*, édition du 20e anniversaire (1995), chapitre 19 « The Mythical
Man-Month after 20 Years », section intitulée « **Don't Build One to Throw Away—The
Waterfall Model Is Wrong!** ». Scan intégral consulté le 14/08/2026 :
https://bowringj.people.charleston.edu/classes/csis%20602/docs/The.Mythical.Man.Month.F.Brooks.pdf
(table des matières confirmée aussi sur les pages d'exemplaire Pearson :
https://ptgmedia.pearsoncmg.com/images/9780201835953/samplepages/0201835959.pdf)

Texte original du chapitre 11 (1975, p. 116-117) :
> Where a new system concept or new technology is used, one has to build a system to throw
> away, for even the best planning is not so omniscient as to get it right the first time.
> Hence plan to throw one away; you will, anyhow.

Le revirement, chapitre 19 (verbatim) :
> The unforgettable picture of Galloping Gertie, the Tacoma Narrows Bridge, opens Chapter 11,
> which radically recommends: "Plan to throw one away; you will, anyhow." **This I now
> perceive to be wrong, not because it is too radical, but because it is too simplistic.**
> […] The basic fallacy of the waterfall model is that it assumes a project goes through the
> process once […] "Plan to throw one away" does indeed attack this fallacy head on.
> **It is not the diagnosis that is wrong; it is the remedy.**

Sections suivantes du même chapitre : « An Incremental-Build Model Is Better—Progressive
Refinement », « Microsoft's "Build Every Night" Approach », « Incremental-Build and Rapid
Prototyping », « Parnas Was Right, and I Was Wrong about Information Hiding ».

→ Brooks ne dit PAS que le prototype jetable est inutile. Il dit que le remède « un
prototype jeté, une fois » est trop simple, et le remplace par le **build incrémental**
(« grow, not build, software »). C'est exactement la position walking skeleton /
Incremental Rearchitecture de Cockburn.

**Cagan « Dual Track is NOT Two Teams » : TITRE INEXISTANT.** Voir §2.2.

**Sy 2007 : RÉFÉRENCE CONFIRMÉE, mais la co-signature est fausse.**
Sy, Desirée, « Adapting Usability Investigations for Agile User-Centered Design »,
*Journal of Usability Studies*, vol. 2, n° 3, mai 2007, p. 112-132. Référence recoupée
sur quatre bibliographies académiques indépendantes le 14/08/2026 (Fox/Agile 2008 ;
Salah & Cairns, HCI 2014, York ; « Current State of Agile User-Centered Design: A
Survey », TU Graz ; Dialnet). **L'article est signé de Desirée Sy SEULE.** Lynn Miller
est l'autrice d'un article distinct — « Case Study of Customer Input For a Successful
Product », Agile Conference 2005, p. 225-234 — et co-signe avec Sy en 2009 seulement
(« Agile user experience SIG », CHI 2009 extended abstracts, p. 2751-2754). L'attribution
courante « Sy et Miller 2007 » (qu'on trouve par exemple sur uxofgametools.com) est
inexacte. Le « Cycle 0 » vient bien de cette littérature.
Je n'ai pas lu le PDF de l'article lui-même — seule la phrase citée par Jeff Patton
(« Although the dual tracks depicted seem separate… ») m'est accessible en source
secondaire de première main (Patton dit l'avoir lue à l'écran avec Cagan).

**CMU/SEI report Boehm & Hansen : NUMÉROTATION À VÉRIFIER.** La page de Wilfred Hansen à
CMU (https://www.cs.cmu.edu/~wjh/papers/DefeatingTheForces.html) le cite comme
**CMU/SEI-00-SR-008**, et attribue l'auteur à Boehm seul avec Hansen comme éditeur :
« Boehm, B. *Spiral Development: Experience, Principles, and Refinements*
(CMU/SEI-00-SR-008), Software Engineering Institute, Carnegie Mellon University, 2000. »
La forme « CMU/SEI-2000-SR-008 » circule aussi. Je n'ai pas résolu le PDF sur
resources.sei.cmu.edu moi-même — à ne présenter qu'avec cette réserve.

---

## §2 — Dual-track agile (sources primaires réunies moi-même, 14/08/2026)

### 2.1 Origine — Patton raconte lui-même la naissance du terme

Jeff Patton, « Dual Track Development is not Duel Track », 10 mai 2017 (mis à jour
12 avril 2023) — https://jpattonassociates.com/dual-track-development/

> ## No one really named it dual-track
> Years ago, I was teaching a class with my friend Marty Cagan. […] Marty asked me where
> this model came from. I opened the original paper from Desiree Sy (pronounced See) called
> *Adapting Usability Investigations for Agile User-centered Design*.
> Her 2007 article describes a common pattern which lots of people doing rigorous design and
> validation work in Agile development had already arrived at. […] At the time, Desiree was
> working with Alias, now an Autodesk company […]
> Marty asked me "what's this model called?"
> "It doesn't really have a name" I said. "It's just the way it's done."
> "What does she call it?" Marty asked.
> We scanned the paper and found this paragraph: […] "… we work with developers very closely
> through design and development. Although **the dual tracks** depicted seem separate, in
> reality, designers need to communicate every day with developers."
> And that was it. Marty began using this term in his teaching to product managers.

→ CONCLUSION DE PATERNITÉ, en source primaire : le terme n'a été baptisé par personne. Il
est extrait par Patton et Cagan d'une phrase incidente de l'article de Desirée Sy (2007),
puis diffusé par leurs formations. Ce n'est pas un modèle conçu comme tel.

### 2.2 L'auteur qui diffuse le terme le désavoue

Patton, même article :
> Now I need to tell you **I hate the term**, and here's why.
> ## It's Dual Track, not Duel Track
> People just don't read. […] But people do look at pictures. And that picture of dual track
> seems to suggest different jobs for different people – like product managers and designers
> figuring out what to build, and developers building it. And in the worst of cases, you may
> interpret it as developers needing to wait weeks for product managers and designers to get
> their sh*t done. **It's not supposed to be that way.**
> I'd love a different term, and a different picture. But, I don't have a better term or
> picture right now.

Cagan aussi. Marty Cagan, « Dual-Track Agile », svpg.com, 17 septembre 2012 —
https://www.svpg.com/dual-track-agile — porte en tête un encadré UPDATE :
> UPDATE: Starting with the publication of INSPIRED V2, **I stopped using the term
> "Dual-track Agile" because the phrase made people focus far too much on process, and not
> enough on the principles.** I wrote why this is the case here. So instead I started using
> the terms Continuous Discovery and Continuous Delivery.

ATTENTION — VÉRIFICATION FAITE : il **n'existe pas** d'article svpg.com intitulé « Dual
Track is NOT Two Teams ». Recherche menée sur le domaine svpg.com le 14/08/2026 ; les
articles réels sont « Dual-Track Agile » (2012), « Continuous Discovery » (2012),
« Discovery vs. Delivery », « Process vs. Model » (2017). La formule « Two tracks, not two
teams » existe bien mais c'est **un intertitre de l'article de Jeff Patton**, pas un titre
d'article de Cagan. Attribution à corriger.

### 2.3 Ce que le modèle affirme

Cagan, « Dual-Track Agile » (2012) :
> Remember that our higher order objective is to validate our ideas the fastest, cheapest way
> possible. **Actually building and launching a product idea is generally the slowest, most
> expensive way to validate the idea.**
> The Discovery track is all about quickly generating validated product backlog items, and the
> Delivery track is all about generating releasable software.
> […] much of the time we can in fact do our validation **before we write any production
> code**, in the spirit of "fake it before we make it."

Patton, formulations parallèles :
> Development work focuses on predictability and quality. […] Discovery work focuses on fast
> learning and validation. […] **The most expensive way to test your idea is to build
> production quality software.**
> We time-box discovery cycles. […] we'll timebox a test or experiment from a few hours to a
> few days.

### 2.4 Le « mini-waterfall » — attention, le sens est INVERSE de ce qu'on croit

Cagan emploie « mini-waterfall » pour désigner **ce que le dual-track corrige**, pas comme
une accusation contre le dual-track :
> Another reason I like the Dual-Track Agile metaphor is that I find many people essentially
> doing **little mini-waterfalls within their Scrum framework**. The product manager does some
> kind of "requirements" work, and that is passed to a designer that does his designs […] and
> then that is handed off to the delivery team to build and test.
> In contrast, in Dual-Track Agile, the work flow is not characterized by each role delivering
> artifacts on to the next step; rather it is **collaborative**.

Mais la critique « c'est un waterfall déguisé » est bien documentée — formulée par Patton
lui-même sous forme de mythe à démonter :
> **Myth: Discovery is a process that precedes agile development. It shouldn't.**
> Discovery is a necessary part of product development. Practice it with the same agile and
> lean principles in mind.

### 2.5 L'antipattern « two teams » — source primaire = Patton, pas Cagan

Patton, section « Two tracks, not two teams » :
> But, you shouldn't think of it as two processes – just two parts of one process. And, I
> think you're doing developers and others on the team a disservice not to involve them in
> discovery work.
> There's usually more than enough discovery work to do […] **If you feel pressure to shorten
> discovery work to "feed the beast," it usually means you're making decisions to build
> software before learning enough to be confident that you should.**

Liste complète des mythes (verbatim) :
> Myth: Discovery is a process that precedes agile development. It shouldn't.
> Myth: All work moves from discovery to development. It doesn't. — If we're doing discovery
> right, we substantially change and kill lots of ideas.
> Myth: The discovery team is different than the development team. It shouldn't be. — While a
> product manager, designer, and senior engineer may lead and orchestrate discovery, they must
> Involve the whole team in discovery tasks wherever possible.
> Myth: Once you move from discovery to development, discovery work done. It's not.

### 2.6 Cagan sur les mauvaises interprétations de son propre modèle

Marty Cagan, « Process vs. Model », 7 août 2017 — https://www.svpg.com/process-vs-model/
> There's an old saying which comes from the world of statistics: "All models are wrong, but
> some are useful." […] But there is always the risk that someone will take the conceptual
> model too literally, or project too much into it, and **interpret it as a prescriptive
> process.** This occasionally happens when explaining the concepts of continuous discovery
> and delivery.
> Lots of people over the years have encouraged me to augment the simple conceptual model
> […] I've resisted all of these suggestions not because any of them are wrong, but because
> hopefully you can see that **this is a slippery slope** as it moves from a simple conceptual
> model to an illustration of a much more detailed specific product development process.
> More importantly, what I like about the simple model is that it is **process agnostic.**
> […] it's important to realize that it's not about process. It's much more about putting in
> place the necessary culture, and training your team on the critical techniques.

Il cite Bezos (lettre aux actionnaires 2017) :
> "Good process serves you so you can serve customers. But if you're not watchful, the process
> can become the thing. […] The process becomes the proxy for the result you want."

### 2.7 LE POINT DIRECTEMENT UTILE POUR UN DÉVELOPPEUR SEUL

Cagan, « Discovery vs. Delivery » — https://www.svpg.com/discovery-vs-delivery
Il définit d'abord ce que « production-quality » veut dire :
> I always try hard to reserve this use of the product term to describe the state where we can
> actually run a business on this. Specifically, it is scalable and performant to the degree
> necessary. It has a strong suite of regression tests. It is instrumented to collect the
> necessary analytics. It has been internationalized and localized where appropriate. It's
> maintainable. […] **This is not easy. It's where most of the time goes when our engineers
> are building. As such, we try very hard not to waste this effort.**
> Doing all this work when the product manager isn't even sure this is the solution the
> customer wants or needs is a recipe for big waste.

Puis, l'exception explicite :
> **If you are an early stage startup and you have no customers, then of course this is not
> really an issue (and it may be premature to even be creating production-quality software).**
> But for most of us, we have real customers and real revenue so we do have to care about this.

→ Cagan dit lui-même que tout son argumentaire de découplage discovery/delivery suppose un
produit en service avec des clients réels. Sans clients, la précaution tombe.

### 2.8 COMPLÉMENTS (recherche parallèle, sources primaires lues en texte intégral)

**L'origine réelle remonte à 2005, pas 2007.**
Lynn Miller, « Case Study of Customer Input For a Successful Product », Agile Development
Conference (ADC) 2005, Denver, IEEE, p. 225-234. PDF :
https://research.cs.vt.edu/ns/cs5724papers/miller.agile.pdf
Miller était alors *Director of User Interface Development* chez Alias (Toronto).
> This paper describes one company's efforts to merge these processes by creating
> **interconnected parallel design and development tracks**.
> The SketchBook Pro team organized implementation and design as **two equal and highly
> interrelated tracks** […] This **double-track method** meant that we got richer customer
> input and more timely feedback.
La formule imprimée « **Dual tracks** » y figure déjà — comme légende de la figure 7 (une
seule occurrence du mot dans tout le papier).
Miller anticipe elle-même le reproche du handoff :
> Designs were **not just "thrown over the wall"** to the developers. Through the daily
> scrums and interface presentations, the developers had followed the design's progression
> throughout the last cycle.
Et : « Daily interaction between the developers and interaction designers was essential ».

**Le « Cycle 0 » est emprunté, pas inventé.** Miller 2005, §7 :
> **Cycle 0 is the "speculate" phase of the Adaptive Software Development method that we
> were using.** (= Jim Highsmith, ASD)

**Sy 2007 attribue elle-même l'antériorité à Miller** (ses références [13] Miller 2005 et
[14] Sy, UPA 2005). Le PDF d'origine est mort sur uxpajournal.org (404 au 14/08/2026) ;
copie lue via Internet Archive :
https://web.archive.org/web/20130805043555if_/http://upassoc.org:80/upa_publications/jus/2007may/agile-ucd.pdf

Formulations exactes de Sy :
> we need to do so **before coding begins, while the design is still malleable**. Because
> coding begins immediately in Agile development, we needed to find a way to **separate
> design iterations from implementation iterations**.
> **This pattern of designing at least one cycle ahead of developers, and gathering
> requirements at least two cycles ahead, continues until the product is released.**
> **Cycle Zero is the brief requirements-gathering phase at the start of the project.**

LA PHRASE QUE LES CRITIQUES POINTENT, et elle est de l'autrice d'origine (encadré
« Practitioner's Take Away ») :
> Design activities occur **at least one Agile cycle or sprint ahead of the development
> team** in an Interaction Designer Track **separate from** the Developer Track.
> **Developers receive validated designs.**
Et son antidote, dans le même article :
> Although the dual tracks depicted in Figure 3 seem separate, in reality, **interaction
> designers need to communicate every day with developers**.
→ Les deux moitiés sont de Sy. La vulgarisation a gardé la première, perdu la seconde.

**Le vrai texte de Cagan contre les deux équipes : « Discovery – Delivery », 30 octobre 2020**
https://www.svpg.com/discovery-delivery/
> In this article I want to tackle **a very damaging anti-pattern** […] where the product
> team essentially **devolves into two different teams** […] **this is not how you want to
> work, and we just have a single, cross-functional product team, responsible for both
> discovery and delivery.**
> Fundamentally we want to avoid having one person or group obtain the learnings, and then
> have to "**hand-off**" what they learned for another group to execute on. **The group on
> the receiving end is inevitably going to feel like mercenaries.**

IRONIE DOCUMENTÉE : en 2012, Cagan écrivait lui-même « The **product discovery team**
(product owner, lead designer and lead engineer) […] and **the delivery team** is busy
building » (« Time-Boxing Product Discovery », 20/08/2012,
https://www.svpg.com/time-boxing-product-discovery/). Le vocabulaire qu'il qualifie en 2020
d'antipattern très nuisible est celui qu'il employait huit ans plus tôt. L'article de 2012
est toujours en ligne sans note de correction.

**Désaccord entre les deux promoteurs sur qui a nommé la chose — non tranchable.**
Cagan (2012) : « **Jeff Patton first shared with me the term "Dual-Track Scrum"** ».
Patton (2017) : « **No one really named it dual-track** » — c'est Cagan qui a demandé le
nom, ils l'ont trouvé dans le papier de Sy. Deux sources primaires en désaccord ; aucune
pièce ne permet d'arbitrer.

**Les critiques « mini-waterfall », toutes SECONDAIRES (aucun texte d'autorité) :**
- Guy Strelitz, « Dual-Track Scrum and the Waterfall Monsters », 1er février 2015 —
  http://guystrelitz-considerations.blogspot.com/2015/02/dual-track-scrum-and-waterfall-monsters.html
  > Each design that is passed over the wall from Discovery to Delivery is a
  > **mini-contract**. […] **Dual-Track is starting to look like a step back towards process
  > and waterfall.**
  > **We already have the tools** — Visualise your workflow; Small, Independent, individually
  > Valuable user stories; Conversation, Conversation and more Conversation. **Lord knows
  > this is lower impact than slitting your team in two.**
- David Lowe, « Dual-track agile », scrumandkanban.co.uk, 10/09/2018 (maj 01/06/2020) —
  https://scrumandkanban.co.uk/dual-track-agile/ — distingue « split-team agile (aka
  mini-waterfall) » du dual-track de Patton. Trois objections :
  > we are building on top of unreleased product […] this **reduces the iterative way of
  > working because we are less likely to throw away work** […] **we are more emotionally
  > committed to our specifications because subsequent work has been based upon it** […]
  > this is **not a collaborative team effort and is encouraging silos**.
  Et : « Split-track agile (**and dual-track agile to a lesser extent**) ensures that the
  whole team is always kept busy (i.e. it is **resource-efficient**) […] **it won't return
  as good outcomes** » → optimise le taux d'occupation, pas le flux.
- Alex Ballarin Latre, Scrum.org, 20/09/2024 —
  https://www.scrum.org/resources/blog/how-integrate-scrum-and-ux-dual-track-scrum
  > **Delivery is delayed to 3 Sprint cycles** […] **It's not Scrum; there's no potentially
  > deliverable product at the end of the Sprint.**
  Et il retourne la source primaire : « When she [Sy] talks about two work streams, she
  refers to designers and developers working together, **not in separate teams or Sprints**. »

**LA CRITIQUE LA PLUS SOLIDE — argument de parcimonie.** Fil Scrum.org « Dual-Track Scrum »
(23/07/2017 – 08/10/2018) — https://www.scrum.org/forum/scrum-forum/9170/dual-track-scrum
Alex Crosby : « it is **a way of justifying teams to not be fully cross-functional** […]
am I also correct in saying it's **sneakily adding "phases" or "stages" back to
development**? »
Ian Mitchell (Professional Scrum Trainer) : « **That seems like a fair assessment.** […]
In Scrum, if a hypothesis needs to be validated, **just use a Sprint to frame and deliver
the corresponding MVP**. On the other hand, if scope needs to be better understood before
work can be planned into a Sprint, **improve Product Backlog refinement such as by means of
investigative spikes**. »
→ Autrement dit : ce que le dual-track apporte est déjà couvert par le raffinement de
backlog et les spikes, au prix de couper l'équipe en deux. Aucune réponse écrite de Patton
ni de Cagan à cet argument n'a été trouvée.

**Versant académique : rien sous ce nom.** La littérature traite le sujet sous
« AUCDI » (Agile and User Centred Design Integration). Revue systématique lue :
Salah, Paige, Cairns, « A Systematic Literature Review for Agile Development Processes and
User Centred Design Integration », EASE '14, ACM (71 publications, 2000-2012) —
https://www-users.york.ac.uk/paul.cairns/pubs/Salah_EASE2014.pdf
Ce qu'elle documente : la difficulté du « design chunking » ; le « design drift » (« User
interface consistency may be undermined as independently empowered teams evolve code in
parallel, without coordinating their work ») ; les objectifs concurrents (« the Agile
principle "Working software is the primary measure of progress" can […] introduce competing
goals between developers and UCD practitioners particularly when they work in parallel ») ;
et le risque de goulot d'étranglement. Verdict de la revue : la piste amont fonctionne
**à condition d'une synchronisation quotidienne** — la condition que Miller et Sy posaient
toutes deux et que la vulgarisation a supprimée.

---

## §3 — Shape Up (Ryan Singer / Basecamp, 2019)

Texte intégral libre : https://basecamp.com/shapeup (chapitres extraits en texte brut le
14/08/2026).

### 3.1 Shaping, appetite, betting, building

Ch. 2 « Principles of Shaping » — https://basecamp.com/shapeup/1.1-chapter-02
> When we shape the work, we need to do it at the right level of abstraction: not too vague
> and not too concrete.

Trois propriétés du travail « shapé » :
> Property 1: It's rough — Work in the shaping stage is rough. Everyone can tell by looking
> at it that it's unfinished. […] Work that's too fine, too early commits everyone to the
> wrong details.
> Property 2: It's solved — Despite being rough and unfinished, shaped work has been thought
> through. All the main elements of the solution are there at the macro level and they
> connect together. The work isn't specified down to individual tasks, but the overall
> solution is spelled out. […] Any open questions or rabbit holes we could see up front have
> been removed to reduce the project's risk.
> Property 3: It's bounded — Lastly, shaped work indicates what *not* to do. It tells the
> team where to stop. There's a specific appetite—the amount of time the team is allowed to
> spend on the project.

Appetite (glossaire, https://basecamp.com/shapeup/4.5-appendix-06) :
> Appetite : The amount of time we want to spend on a project, as opposed to an estimate.
> Bet : The decision to commit a team to a project for one cycle with no interruptions and
> an expectation to finish.
> De-risk : Improve the odds of shipping within one cycle by shaping and removing rabbit holes.
> Rabbit hole : Part of a project that is too unknown, complex, or open-ended to bet on.
> Circuit breaker : A risk management technique: Cancel projects that don't ship in one cycle
> by default instead of extending them by default.

Les quatre étapes du shaping :
> 1. Set boundaries. 2. Rough out the elements. 3. Address risks and rabbit holes.
> 4. Write the pitch.

### 3.2 Rabbit holes et de-risking AVANT l'engagement

Ch. 5 « Risks and Rabbit Holes » — https://basecamp.com/shapeup/1.4-chapter-05

Définition et enjeu :
> However, if there are any rabbit holes in the shaping—technical unknowns, unsolved design
> problems, or misunderstood interdependencies—the project could take *multiple times* the
> original appetite to complete. The right tail stretches out.

La règle de séquence, explicite :
> Before we consider it safe to bet on, a shaped project should be as free of holes as possible.

Le contre-exemple que Singer donne sur son propre échec :
> We once bet on a project to redesign the way we present projects with clients on Basecamp's
> home screen. We assumed the designer would figure it out; we didn't do the work in the
> shaping phase to validate that a viable approach existed. […] We ended up abandoning the
> project and rethinking it later.

Les quatre questions de chasse aux trous :
> Does this require new technical work we've never done before? / Are we making assumptions
> about how the parts fit together? / Are we assuming a design solution exists that we
> couldn't come up with ourselves? / Is there a hard decision we should settle in advance so
> it doesn't trip up the team?

IMPORTANT — POINT DE VÉRIFICATION : le mot « spike » N'APPARAÎT PAS dans le chapitre 5
(texte brut vérifié le 14/08/2026). Les gestes de de-risking que Singer nomme dans ce
chapitre sont : **patcher le trou** (dicter une solution dans le concept shapé),
**declare out of bounds**, **cut back**, et **présenter à des experts techniques**. Aucun
code n'est écrit à ce stade. La formule clé :
> Beware the simple question: "Is this possible?" In software, everything is possible but
> nothing is free. We want to find out if it's possible within the appetite we're shaping
> for. Instead of asking "is it possible to do X?" ask "is X possible in 6-weeks?"
Et :
> It's not just a "what do you think" conversation—we're really hunting for time bombs that
> might blow up the project once it's committed to a team.

→ Autrement dit : chez Singer, le de-risking d'avant-engagement est **conversationnel et
documentaire**, pas empirique. Le mot « spike » apparaît ailleurs dans le livre — voir
§3.3bis, c'est un point majeur.

### 3.3bis — COLLISION TERMINOLOGIQUE : « spike » ne désigne pas la même chose chez Cockburn et chez Singer

Occurrences vérifiées de « spike » dans Shape Up (texte brut, 14/08/2026) :
- Glossaire : « R&D mode : A phase of building a new product where a senior team **spikes**
  the core features to define the core architecture. »
- Ch. 9 : « we mainly bet the *time* on **spiking** some key pieces of the new product idea » ;
  « The aim is to **spike**, not to ship. »
- Ch. 11 : « the programmer wasn't waiting around. He had enough guidance from the pitch to
  start **spiking** the access model. »

Or, chez Cockburn (source primaire, page Walking skeleton) :
> A spike is "the smallest implementation that demonstrates plausible technical success." The
> spike typically takes between a few hours and a few days to complete, and **is thrown away
> afterward**, since it was built with nonproduction coding habits.

Et chez Singer (ch. 9, R&D mode) :
> In the best case we'll have some UI and **code committed to serve as the foundation for
> subsequent work**. The goal is to learn what works so we can **commit to some load-bearing
> structure**.

→ MÊME MOT, DISPOSITION OPPOSÉE DU CODE : jeté chez Cockburn, conservé et portant chez
Singer. C'est exactement l'axe sur lequel se joue la question « setup tôt ou pas ». Le
spike de Kent Beck (XP) se range du côté de Cockburn (jetable).
À traiter comme une section à part entière dans le rapport final.

### 3.3 LE POINT DÉCISIF : « R&D mode » — Singer répond directement à la question posée

Ch. 9 « Place Your Bets » — https://basecamp.com/shapeup/2.3-chapter-09
Glossaire : « R&D mode : A phase of building a new product where a senior team **spikes the
core features to define the core architecture**. » / « Production mode : A phase of building
a new product where **the core architecture is settled** and we apply the standard Shape Up
process. »

Texte du chapitre 9 :
> New products are different. Whereas adding to an existing product is like buying a couch
> for a room with fixed dimensions, new product development is like figuring out where the
> walls and the foundation should go so the building will stand.

> At the very earliest stages of a new product, our idea is just a theory or a glimmer. We
> don't know if the bundle of features we imagine will hold together in reality, and the
> technical decisions about how to model them in code are even less clear.
> This means there is a lot of scrapwork. […]
> In other words, **we can't reliably shape what we want in advance** and say: "This is what
> we want. We expect to ship it after six weeks." **We have to learn what we want by
> building it.**

Les trois ajustements du R&D mode :
> 1. Instead of betting on a well-shaped pitch, we mainly bet the *time* on spiking some key
> pieces of the new product idea. The shaping is much fuzzier because we expect to learn by
> building.
> 2. Rather than delegating to a separate build team, our senior people make up the team. […]
> First, you can't delegate to other people when you don't know what you want yourself.
> Second, **the architectural decisions will determine what's possible in the product's
> future — they define the "holes" that future features fit into.**
> 3. Lastly, we don't expect to ship anything at the end of an R&D cycle. **The aim is to
> spike, not to ship.** In the best case we'll have some UI and code committed to serve as the
> foundation for subsequent work. The goal is to learn what works so we can commit to some
> **load-bearing structure**: the main code and UI decisions that will define the form of the
> product going forward.

Passage en production mode :
> If we continue to get warmer after some R&D cycles, we'll eventually reach a point where
> **the most important architectural decisions are settled.** […] With this structure in
> place, the senior team can bring in other people to contribute.

Exemple chiffré (HEY) : « HEY was in R&D mode for the first year of its development. […]
Nearly a year of production mode cycles followed […] two cycles of cleanup ».

→ LECTURE POUR LA QUESTION POSÉE : Shape Up **ne prescrit pas** son propre process
(shaping → betting → building) tant que l'architecture n'est pas posée. Sur un produit
neuf, la séquence est inversée : on code d'abord pour découvrir, avec les gens les plus
seniors, sans rien livrer, jusqu'à ce que la « load-bearing structure » soit décidée.
C'est un argument de source primaire **pour** le setup tôt — mais avec une nuance :
Singer parle de *spikes*, donc de code d'apprentissage, pas d'un squelette conservé.

### 3.4 « Get One Piece Done » — la version Shape Up de la tranche verticale

Ch. 11 — https://basecamp.com/shapeup/3.2-chapter-11
> It's important at this early phase that they don't create a master plan of parts that
> should come together in the 11th hour. […] Instead they should aim to make something
> tangible and demoable early—in the first week or so. That requires **integrating vertically
> on one small piece of the project instead of chipping away at the horizontal layers.**

Les trois critères de choix du premier morceau :
> First, it should be **core**. […] Second, it should be **small**. […] Third, it should be
> **novel**. If two parts of the project are both core and small, prefer the thing that you've
> never done before. […] Starting on that would have moved the project forward, but it
> wouldn't have taught the team anything. It wouldn't have eliminated uncertainty.

Et le contre-pied explicite au « setup d'abord » :
> **Start in the middle** — In the examples above, the team didn't build log in first. They
> didn't build a way to create an interview project and an interview subject before solving
> the problem of adding interview data. They jumped straight into the middle where the
> interesting problem was and stubbed everything else to get there.

Exemple d'infrastructure délibérément bâclée :
> Rather than building full username and password support—or even integrating a third-party
> solution—they just used plain HTTPAuth to hard-code a password. This allowed the team to
> try adding data from real interviews very early in the cycle, **without slowing down to hook
> up some authentication code that wasn't going to teach them anything about the problems
> they were trying to solve.**

Et : « The early back-end work can be **strategically patchy**. »

→ C'est un contraste net avec le walking skeleton de Freeman & Pryce (qui commence par
build+deploy+test automatisés) : Singer dit de commencer par le **problème le plus
incertain**, pas par la plomberie.

### 3.5 Le cas du développeur seul — Singer le traite explicitement

Annexe « Adjust to Your Size » — https://basecamp.com/shapeup/4.1-appendix-02
> To apply Shape Up to your company, it helps to separate out the basic truths from the
> specific practices.
> Work has to come from somewhere, and it takes work to figure out what the right work is.
> This is shaping. **Shaping the work sets clearer boundaries and expectations for whoever
> does the work—whether that's a separate team or just your future self.** If we don't make
> trade-offs up front by shaping, the universe will force us to make trade-offs later in a
> mad rush when we're confronted by deadlines, technical limitations, or resource constraints.

> **For these reasons, a tiny team can throw out most of the structure.** You don't need to
> work six weeks at a time. You don't need a cool-down period, formal pitches or a betting
> table. Instead of parallel tracks with dedicated shapers and builders, the same people can
> alternate back and forth. Be deliberate about which hat you're wearing and what phase
> you're in. Set an appetite, shape what to do next, build it, then shape the next thing.
> Your bets might be different sizes each time: maybe two weeks here, three weeks there.

Et l'aveu sur l'origine de la structure — DIRECTEMENT PERTINENT pour la distinction
coordination / retravail :
> After you hire more people, all of this fluidity flips from an asset to a liability.
> Winging it with ad-hoc meetings and chat room discussions doesn't work anymore.
> **Coordination starts to eat up more of your time** and things begin to slip through the
> cracks. This is when it makes sense to take on the structure of six-week cycles,
> cool-downs, and a formal betting table.

### 3.6 Critiques de Shape Up

CONSTAT : je n'ai trouvé aucune critique académique ni aucune critique en source primaire
d'auteur reconnu. Ce qui existe est de la littérature praticienne. Je le signale comme tel.

(a) John Cutler, « Review Notes: Shape Up », https://cutle.fish/blog/shape-up-review —
notes de lecture d'un praticien reconnu, plutôt favorables ; il relève surtout le
malentendu « ils n'utilisent pas de sprints donc ils ne collaborent pas au quotidien » :
> There's this sense that somehow with Shape Up they'll go for weeks on end doing brilliant
> work before showing it. The opposite is true.

(b) John Cutler, « TBM 386: Understanding Enabling Constraints Using Shape Up (Basecamp) »,
https://cutlefish.substack.com/p/tbm-386-understanding-enabling-constraints — analyse
contrainte par contrainte, avec le risque de chacune :
> The risk is that teams lose sight of the cycle as a creative boundary and treat it as a
> rigid deadline. If taken to the extreme, teams may optimize only for short-term
> deliverables, avoid ambitious work that can't fit neatly into six weeks, and prematurely
> kill ideas that could have created more long-term value.
> The risk is that Appetite gets confused with an estimate […] teams may treat appetites as
> inflexible budgets.

(c) Povilas Korop, « Basecamp's "Shape Up" Review »,
https://medium.com/@povilaskorop/basecamps-shape-up-review-or-how-to-scope-and-manage-projects-358bdfa122f
— la limite « travail produit vs travail client » :
> It's more suitable for *product* work (Basecamp create their own software) where your team
> decide on everything. Not so much for client work where you get bombarded with new
> requirements or questions daily.
> It all relies on people being *very* good at what they do […] So all team should be,
> more-or-less, "senior".

(d) Alex Debecker, « Concerns before implementing Shape Up »,
https://alexdebecker.substack.com/p/concerns-before-implementing-shape — le problème du
travail « presque fini » et du circuit breaker en pratique.

(e) Tensure, « Let's Shape Up », https://www.tensure.io/blogs/lets-shape-up — relève que
le cycle de six semaines est inadapté « in Research and Development (R&D) projects with
risks and dependencies that are difficult to measure » — ce qui rejoint le propre aveu de
Singer au ch. 9.

