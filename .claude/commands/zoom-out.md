# /zoom-out — Carte du module courant

Utilisé quand on arrive dans un fichier ou une zone de code peu familière et qu'on veut comprendre comment elle s'insère dans l'architecture avant de toucher quoi que ce soit.

Pas de questions. Pas de validation. Juste la carte.

---

## Ce que tu fais

1. Tu lis `[projet].archi.md` — tu identifies le module qui contient le fichier ou la zone en question, et tu extrais :
   - Sa responsabilité
   - Ce qu'il peut appeler (règle silo)
   - Ce qu'il expose (contrat public)

2. Tu lis `[projet].gloss.md` si il existe — tu retiens les termes du domaine pertinents pour ce module.

3. Tu produis cette carte :

> **Module : [nom]**
> Responsabilité : [en une phrase]
>
> Peut appeler : [modules autorisés]
> Appelé par : [modules qui l'utilisent, si identifiables depuis archi.md]
> Contrat public : [fonctions / composants / hooks exposés]
>
> Termes du domaine : [termes du gloss.md pertinents pour ce module — ou "aucun glossaire disponible"]
> Fichiers principaux : [liste des fichiers du module]
