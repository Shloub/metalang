Metalang
========

C'est quoi ?
----------------
Metalang est un langage de programmation. Il permet d'écrire une fois un code et d'obtenir le même programme dans plusieurs autres langages (C, C++, python, javascript, ocaml, php, go, java, C#)

Quick start
----------------
* ouvrir une console
* aller dans le dossier metalang
* taper ::

  make metalang
  ./metalang tests/prog/npi.metalang

* on voit alors apparaitre des implémentations d'une calculette en notation polonaise inversée dans les langages C# ocaml python c++ java php ruby C go

Il me manque un compilateur
----------------
Pour installer go 1.1 ::

  hg clone -u release https://code.google.com/p/go
  hg update default
  cd go/src
  ./all.bash

Pour installer nodejs ::

  wget http://nodejs.org/dist/v0.10.10/node-v0.10.10.tar.gz
  tar -xvf node-v0.10.10.tar.gz
  cd node-v0.10.10
  ./configure --prefix $PREFIX
  make install

Les autres compilateurs devraient être packagé sur votre distribution de linux.

Note : La version de python utilisée est python3

Modes
----------------
Le dossier tools contient des outils comme le mode emacs et un mode vim, pour l'installer,
il faut ajouter ces lignes dans son .emacs::
  (setq auto-mode-alist (cons '("\\.metalang$" . metalang-mode) auto-mode-alist))
  (autoload 'metalang-mode "CHEMIN_ABSOLU/tools/metalang-mode.el" "Mode majeur pour éditer du code Metalang" t)


Exemples
----------------
Vous trouverez de nombreux exemples de programmes dans le dossier
tests/progs le plus notable est probablement le tictactoe avec une IA.
En tapant make testCompare, on peut lancer ces tests, et comparer les résultats dans les différents langages

La documentation se trouve sur le site http://eelte.megami.fr/metalang


But du projet:
----------------
Ce projet à été fait pour le concours prologin http://www.prologin.org
L'idée est de générer des lecteurs printers pour beaucoup de langages Ce projet devrait servir pour les demies finales de prologin, pour générer les codes à compléter pour les candidats.
On peut imaginer pousser le concept beaucoup plus loin, mais le but principal reste la génération de codes lisibles par des humains, dans le but de présenter des squelettes de codes ou des codes lisibles, pour les candidats de prologin.
Le choix s'est porté vers un langage impératif, ce qui facilite la génération de codes lisibles dans les langages les plus utilisés.
Ce langage impératif est typé, pour pouvoir compiler vers des langages typés assez facilement, éviter les erreurs, et offrir un code lisible plus facilement en sortie.
La syntaxe ne contient pas toutes les instructions de controles de flux, (break et continue n'existent pas) de cette manière, on a plus de facilités à générer du code lisible dans tout les langages cibles.
On a aussi un typer pour ne pas être obligé de déclarer les types (ça reste évidement typé statiquement)
Un evaluateur, qui sert, soit pour évaluer directement du code metalang, soit pour évaluer des macros.

Langages cibles :
* C
* C++
* java
* C#
* ocaml
* python
* ruby
* php
* javascript
* Go (Version 1.1 minimum, sinon on a des soucis avec leur test qui vérifie si chaque fonction renvoie bien.)

HOWTO Metalang
----------------


Dans le cadre du concours prologin, on a besoin d'écrire des codes à compléter. Ces codes lisent des entrées, et appellent une fonction "vide" que le candidat devra remplir.

Dans un premier temps, la structure d'un code metlang pour prologin est la suivante ::
  def ...1 la_fonction_a_completer( ...2 )
  end
  main
    ...3
  end

* dans ...1 on écrit le type de retour de la fonction. Souvent void ou int.
* dans ...2 on écrit les paramètres
* dans ...3 on écrit le code de parsing, et de quoi appeller la fonction, et afficher son résultat.

En métalang, on a trois primitives de parsing : une qui lit un entier, une qui lit un char, et une qui saute les espaces
Respectivement :

* read int variable
* read char variable
* skip

Ces trois méthodes peuvent générer du code dégueu dans certains langages (ceux qui n'ont pas scanf, donc python, C#, php, etc...)

Pour éviter ce problème, on a deux fonctions alternatives dans la lib standard : read_int et read_int_line. Il ne FAUT PAS melanger ces deux façons de parser, sinon ça risque de faire tout planter.

En metalang, on ne peut pas savoir quelle est la taille d'une ligne, donc on ne peut pas parser une ligne et récupérer un tableau d'entier de taille variable. On ne peut pas non plus le faire pour une chaine de caractères.

L'exemple tests/progs/aaa_read_ints.metalang montre comment parser des entiers correctement.
L'exemple tests/progs/npi.metalang montre comment parser des chars

Normalement, avec cet outil, vous avez les moyens de faire des codes à compléter. N'oubliez pas de tester vos codes générés.

Declaration de variables
----------------
Une variable doit toujours avoir une valeur. Pour définir un entier x de valeur 42, on fait::
  def int x = 42

On est pas obligé de définir le type : une passe de typage s'arrangera pour l'inférer.::
  def x = 42


Declaration de tableaux
----------------
Pour définir un tableau, rien de plus simple::
  def array<type> tab[taille] with variable do /* instructions */ return valeur end

Cette syntaxe correspond plus ou moins aux Array.init d'ocaml. Dans les autres langage, ce code est compilé vers une boucle for pour l'initialisation


Declaration de struct
----------------
Pour définir une struct ::
  record @nom_de_la_struct
    field1 : type1
    field2 : type2
  end

Ensuite, la structure a pour nom @nom_de_la_struct.
Pour définir une variable de type @nom_de_la_struct ::
  def variable = record
    field1 = valeur1
    field2 = valeur2
  end

Pour récupérer ou affecter la valeur du champ 1, on utilise variable.x

Pour éviter tout code moche généré, deux structures doivent avoir des noms de champs distincts.

Declaration d'enums
----------------
Pour définir un enum ::
  enum @foo_t
    Foo Bar Blah
  end

Ensuite, le type a pour nom @foo_t et on utilise Foo, Bar Blah comme des valeurs

Types
----------------
Les différents types manipulables en metalang sont :
* int
* string
* chars
* tableaux
* struct
* enums

Aucun de ces types n'est nullable. Il est donc difficile de faire des structures de données complexes 

Fonctions
----------------
Les fonctions ne peuvent pas être mutuellement récursives, mais les fonctions récursives ne posent aucun problème.
Les arguments sont passés par valeur pour les entiers, enum et chars, et par référence pour les tableaux et structures.

Pour définir une fonction ::
  def type_de_retour nom_fonction(type1 param1, type2 param2)
    ...
  end

Boucles
----------------
Les boucles for ont pour syntaxe ::

  for variable = debut to fin do
    ...
  end

If Then Else
----------------
La syntaxe est ::
  if ... then
    ...
  elsif ... then
    ...
  end

Print
----------------
L'instruction print vous permet d'écrire sur la sortie standard::

  print "foo"
  def x = 42
  print x
