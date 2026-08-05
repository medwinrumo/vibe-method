---
type: doctrine
source: ../../rgpd.md
source_modified: 2026-05-11
wiki_updated: 2026-08-05
tags: [rgpd, conformité, données-personnelles, consentement, dpa, registre, droits]
---

# Doctrine — RGPD

## En une ligne
Finalité, minimisation, durée limitée — trois principes à poser dès le `/archi`, avant la première ligne de code.

---

## Les trois principes fondateurs

- **Finalité** : toute donnée collectée a un but précis, déclaré à l'avance
- **Minimisation** : on ne collecte que le strictement nécessaire à ce but
- **Durée limitée** : on conserve le temps nécessaire, puis on supprime

Chaque champ de formulaire sans justification est une donnée qu'on n'a **pas le droit** de collecter.

---

## Les 12 sections de la doctrine

| # | Sujet | Ce qu'il faut retenir |
|---|---|---|
| 1 | Bases légales (art. 6) | 6 bases possibles ; une seule par traitement, choisie **avant** de coder. Contrat et consentement couvrent l'essentiel des projets. L'intérêt légitime exige une mise en balance documentée — à éviter si une autre base s'applique |
| 2 | Minimisation | Obligation légale, pas principe moral |
| 3 | Registre des traitements (art. 30) | Qui le tient dépend du modèle de projet (M1/M2/M3) |
| 4 | Droits des utilisateurs (art. 15-22) | 9 droits ; l'effacement doit vraiment effacer, pas désactiver |
| 5 | Consentement | Cookies exemptés vs cookies à consentement explicite ; ce qui rend une bannière valable |
| 6 | Politique de confidentialité | Contenu obligatoire, où la publier, comment la tenir à jour |
| 7 | Sous-traitants et DPA (art. 28) | DPA des fournisseurs standard ; le cas SaaS B2B où **tu es toi-même sous-traitant de ton client** |
| 8 | Transferts hors UE | Data Privacy Framework EU-USA en vigueur depuis 2023 |
| 9 | Violation de données (art. 33-34) | Ce qui déclenche la notification, la procédure, le registre des violations |
| 10 | DPIA et DPO | Quand l'analyse d'impact devient obligatoire, quand un DPO l'est |
| 11 | Hooks avec les skills | Voir ci-dessous |
| 12 | Checklist avant production | Une case non cochée = mise en prod bloquée |

---

## Le RGPD n'est pas une étape, c'est une série de points d'ancrage

C'est la structure la plus utile de la doctrine : chaque obligation se raccroche à un skill précis de la chaîne.

| Skill | Ce qui s'y joue |
|---|---|
| [[skills/brief]] | Type de données collectées, population concernée (mineurs ?) |
| [[skills/archi]] | Base légale + durée par donnée, minimisation champ par champ, sous-traitants et DPA, besoin de DPIA, création du registre |
| [[skills/specs]] | Chaque feature déclare sa base légale et sa rétention ; les fonctions droits utilisateurs entrent dans les specs |
| [[skills/stack]] | Par service : région d'hébergement, DPA disponible, certification DPF si fournisseur US |
| [[skills/deploy]] | Checklist de conformité complète avant toute mise en production |
| [[skills/code-review]] | L'effacement supprime-t-il vraiment tout ? L'export est-il complet ? RLS actif sur les tables à données personnelles ? |

---

## Liens
[[doctrines/securite]] (le RGPD hérite de ses règles techniques) | [[skills/cgv]] | [[flux/chaine-complete]]
