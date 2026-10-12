# Puissance 4 (Pascal)

Jeu de Puissance 4 en console, écrit en Pascal. Projet de fin d'année de L1, cours d'algorithmie et programmation.

## Fonctionnalités

- Deux modes : **contre l'ordinateur** ou **à deux joueurs**
- Affichage de la grille dans la console, choix de la colonne à chaque tour
- Détection de la victoire : 4 jetons alignés horizontalement, verticalement ou en diagonale
- Possibilité de rejouer à la fin d'une partie
- Écrans d'aide : règles du jeu et conseils de stratégie

## Remarque sur l'ordinateur

L'adversaire joue une colonne choisie au hasard parmi celles qui ne sont pas pleines. Il ne cherche pas à gagner ni à bloquer le joueur : c'est une piste d'amélioration naturelle (par exemple un algorithme minimax).

## Technologies

Pascal (Free Pascal / Lazarus).

## Lancer le jeu

- Sous Windows : lancer `pjfa.exe`.
- Avec Lazarus : ouvrir `pjfa.lpi` puis compiler et exécuter.
- Avec Free Pascal en ligne de commande : `fpc pjfa.lpr`.

## Contenu du dépôt

| Fichier | Rôle |
|---|---|
| `pjfa.lpr` | Code source du jeu |
| `pjfa.lpi`, `pjfa.lps` | Fichiers de projet Lazarus |
| `pjfa.exe` | Version compilée pour Windows |
| `backup/`, `lib/` | Sauvegardes et fichiers générés par Lazarus |
