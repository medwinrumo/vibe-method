# /cgv — Génération des Conditions Générales de Vente

Tu génères `[projet].cgv.md` — le document CGV complet, prêt à être joint à la proposition commerciale.

Le document est composé de deux blocs : les **Conditions Générales (CG)**, identiques pour tous les projets, et les **Conditions Particulières (CP)**, spécifiques au modèle de prestation.

---

## Étape 0 — Lecture des fichiers existants

Tu cherches dans le répertoire courant du projet :
- `[projet].brief.md`
- `[projet].context.md`
- `[projet].proposition.md`

Pour chaque fichier trouvé, tu extrais :
- Nom du projet et du client
- Modèle de prestation (M1 / M2 / M3) si identifiable
- Durée de la période d'ajustements si mentionnée
- Stack technique et services tiers si disponibles
- Conditions financières si disponibles

**Si aucun fichier n'est trouvé** → tu t'arrêtes :
> "Lance `/contexte` puis `/brief` avant de générer les CGV."

---

## Étape 1 — Détermination du modèle

À partir des fichiers lus, tu identifies le modèle de prestation :

- **M1** — développement applicatif sur mesure, pour ce client uniquement
- **M2** — application SaaS, destinée à être proposée à plusieurs clients
- **M3** — système Notion, pour ce client uniquement

Si le modèle n'est pas identifiable dans les fichiers :
> "Ce projet est-il un développement sur mesure pour ce client uniquement (M1), une application SaaS que tu comptes proposer à plusieurs clients (M2), ou un système Notion (M3) ?"

Tu ne passes à l'étape suivante qu'après avoir confirmé le modèle.

---

## Étape 2 — Collecte des variables manquantes

Tu identifies les informations nécessaires absentes des fichiers. Tu poses les questions manquantes une par une — jamais plusieurs à la fois.

**Variables communes à tous les modèles :**

| Variable | Source prioritaire | Si absente |
|---|---|---|
| Nom complet du client | `[projet].context.md` | Demander |
| Date du document | Date du jour | Utiliser automatiquement |
| Durée de la période d'ajustements | `[projet].proposition.md` | Demander |

**Variables spécifiques M1 (dev sur mesure) :**

| Variable | Source prioritaire | Si absente |
|---|---|---|
| Territoire de cession | `[projet].brief.md` | Proposer "monde entier" — confirmer |
| TJM pour interventions hors période | `[projet].proposition.md` | Demander si maintenance envisagée |

**Variables spécifiques M2 (SaaS) :**

| Variable | Source prioritaire | Si absente |
|---|---|---|
| Taux de disponibilité cible | `[projet].proposition.md` | Demander (ex. : 99,5 %) |
| Fréquence de facturation | `[projet].proposition.md` | Demander (mensuel / annuel / autre) |
| Délai de préavis résiliation client | — | Demander (recommandé : 30 jours) |

**Variables spécifiques M3 (Notion) :**

| Variable | Source prioritaire | Si absente |
|---|---|---|
| Offre Notion requise | `[projet].brief.md` | Demander (gratuite / payante selon besoins) |

---

## Étape 3 — Lecture des sources et assemblage

Tu lis les deux fichiers sources dans cet ordre — source canonique : `~/dev/wiki` (partagé Mac/Hermes, voir `~/dev/wiki/CLAUDE.md`) :

1. `~/dev/wiki/cgv-conditions-generales.md` — les Conditions Générales
2. Le fichier CP correspondant au modèle confirmé :
   - M1 → `~/dev/wiki/cgv-cp-m1-dev-sur-mesure.md`
   - M2 → `~/dev/wiki/cgv-cp-m2-saas-multiclients.md`
   - M3 → `~/dev/wiki/cgv-cp-m3-notion.md`

Chaque fichier source commence par un bloc frontmatter YAML et une section "Fiches liées" — ne pas les inclure dans le document assemblé, ne lire que le contenu à partir du `---` de séparation.

**Si un fichier source est introuvable** → tu t'arrêtes et tu le signales. Tu ne génères pas de document incomplet.

Tu assembles le document final dans l'ordre suivant :
1. En-tête du document (voir format ci-dessous)
2. Contenu des Conditions Générales — intégral, sans modification
3. Séparateur `---`
4. Contenu des Conditions Particulières applicables — intégral, avec substitution des variables

**Règles de substitution dans les CP :**
- Remplacer les valeurs collectées à l'étape 2 (durée d'ajustements, territoire, etc.)
- Remplacer les éléments entre crochets `[...]` par les valeurs réelles
- Conserver telles quelles les mentions "précisées dans la proposition commerciale" — ces données sont dans la proposition, pas dans les CGV

---

## Format de l'en-tête

```markdown
# CONDITIONS GÉNÉRALES ET CONDITIONS PARTICULIÈRES

**Prestataire :** RUMO Medwin — 20 Rue de la grande île, 77100 Meaux
SIRET : 520 868 480 00028 — medwinrumo@gmail.com

**Client :** [Nom complet du client]

**Date :** [Date du document]

**Objet :** Conditions contractuelles applicables à la prestation « [Nom du projet] »

---

*Ce document est composé de deux parties :*
*— les **Conditions Générales (CG)**, applicables à toutes les prestations du Prestataire ;*
*— les **Conditions Particulières (CP — M[1/2/3])**, précisant les modalités spécifiques*
*à la nature de cette prestation.*
*En cas de contradiction, les Conditions Particulières prévalent sur les Conditions Générales.*
```

---

## Étape 4 — Quality Gate avant enregistrement

- [ ] Le modèle de prestation est confirmé (M1 / M2 / M3)
- [ ] Le nom du client est renseigné
- [ ] La date du document est renseignée
- [ ] La durée de la période d'ajustements est précisée dans les CP
- [ ] Pour M1 : le territoire de cession est confirmé
- [ ] Pour M2 : le taux de disponibilité et la fréquence d'abonnement sont renseignés
- [ ] Pour M2 : le délai de préavis résiliation est renseigné
- [ ] Aucune variable entre crochets `[...]` ne subsiste dans le document généré
- [ ] Les mentions "précisées dans la proposition commerciale" sont conservées intactes

Si une case est vide → poser la question manquante. Tu ne génères pas un document incomplet.

---

## Étape 5 — Enregistrement

Tu écris `[projet].cgv.md` dans le répertoire courant du projet.

Tu confirmes :
> "`[projet].cgv.md` généré — Conditions Générales + Conditions Particulières M[1/2/3].
> Ce document est prêt à être converti en PDF et joint à la proposition commerciale.
> Rappel : CGV et proposition commerciale partent ensemble vers le client."

---

## Règles

- Ne jamais modifier le contenu des CG lors de l'assemblage — elles sont identiques pour tous les projets
- Les mentions "précisées dans la proposition commerciale" restent dans les CP sans être complétées
- Ne jamais générer de CGV sans que le modèle soit confirmé explicitement
- Si les fichiers sources CG ou CP sont introuvables dans `~/dev/wiki/` → le signaler avant toute génération

---

## Prochaine étape

`[projet].cgv.md` est joint à `[projet].proposition.md` pour envoi au client.
