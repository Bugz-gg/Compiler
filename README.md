# Projet de Compilation 

## Introduction

Ce projet de compilation a pour objectif de transformer un langage C en Pcode. Le projet est divisé en plusieurs phases. Chaque phase ajoutant des fonctionnalités pour améliorer la compilation du langage. Ce README fournit un résumé des différentes phases du projet, ainsi que des informations sur la structure du répertoire et la manière de compiler et d'exécuter le compilateur.

## Phases du Projet effectuées

### Phase I - Gestion des expressions arithmétiques simples avec constantes

### Phase II - Gestion/vérification/conversions de types

### Phase III - Gestion des variables globales

### Phase IV - Gestion des branchements.

### Phase V - Gestion des sous-blocs

### Phase VI - Gestion des appels de fonctions

## Structure du Répertoire

Le répertoire de mon projet est organisé de la manière suivante :

- **src**: Contient les fichiers source du compilateur, y compris les fichiers de grammaire, le Makefile, et les modules pour la table des symboles et des chaînes.
- **Examples**: Contient des exemples de code source en lang.
- **Answer**: Les fichiers résultants de la compilation des exemples sont sauvegardés ici.
- **PCode**: Un répertoire permettant de compiler du Pcode, malheureusement il y a un bug qui fait que tous les exemples après l'exemple 5 ne peuvent pas être compiler à cause des variables globales.

## Compilation et Exécution

Pour compiler le projet, j'utilise le fichier `Makefile` situé dans le dossier `src`. La commande `make` génère l'exécutable du compilateur appelé "lang". Je peux exécuter le compilateur en utilisant le script `run.sh` suivi du numéro de l'exemple que je souhaite tester, comme suit :

```bash
./run.sh 1
```

Cela génère le PCode pour l'exemple 1 et le sauvegarde dans le dossier `Answer`.
