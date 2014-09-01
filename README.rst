Metalang
========

C'est quoi ?
----------------
Metalang est un langage de programmation. Il permet d'écrire une fois un code et d'obtenir le même programme dans plusieurs autres langages (voir plus bas)

Hello World
----------------

Voici le programme helloworld.metalang ::

  main
	  print "Hello World"
  end

Quick start
----------------
* ouvrir une console
* aller dans le dossier metalang
* taper ::

  make metalang
  ./metalang tests/prog/aaa_01hello.metalang

* Le hello world apparait alors dans les différents langages.

Pour lancer metalang en mode évaluateur ::

  ./metalang -eval fichier.metalang

Pour générer uniquement une langue ::

  ./metalang -lang lang1,lang2,...

Les langues possibles sont : c,m,pas,cc,cs,java,js,ml,fun.ml,hs,php,rb,py,go,cl,rkt,pl,metalang_parsed
metalang_parsed correspond au fichier metalang tel qu'il a été parsé.
fun.ml correspond à une version fonctionelle, en ocaml, du code metalang.

L'option -o vous permet de choisir le dossier de destination. Comme nous générons plusieurs fichiers, on ne peut pas choisir le nom des fichiers générés.

pour afficher l'aide ::

  ./metalang -help

pour afficher la version ::

  ./metalang -version



Backends
----------------
Langages cibles :

* C
* Objective-C
* Pascal
* C++
* java
* C#
* common lisp
* scheme (racket)
* ocaml
* perl
* python
* ruby
* php
* javascript
* Go (Version 1.1 minimum, sinon on a des soucis avec leur test qui vérifie si chaque fonction renvoie bien.)

Nous avons testé :

* la compilation objective-C avec gcc `gnustep-config --objc-flags` -lgnustep-base
* La compilation C avec gcc
* La compilation C++ avec g++
* La compilation pascal avec fpc
* La compilation java avec l'open jdk 1.7
* La compilation C# avec mono : gmcs
* La compilation ocaml avec ocaml 3.12
* Le javascript avec nodeJS
* La compilation go avec go 1.1 (ne fonctionne pas sous go 1.0)
* Le common lisp avec gcl 2.6.7
* Le ruby avec ruby 1.9
* le python avec python 3
* le scheme avec racket 5.2.1

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

Modes
----------------

Pour vous permettre une édition plus confortable, nous fournissons quelques modes pour vos éditeurs préférés :


Le dossier tools contient des outils comme le mode emacs et un mode vim, pour l'installer,
il faut ajouter ces lignes dans son .emacs::
  (setq auto-mode-alist (cons '("\\.metalang$" . metalang-mode) auto-mode-alist))
  (autoload 'metalang-mode "CHEMIN_ABSOLU/tools/metalang-mode.el" "Mode majeur pour éditer du code Metalang" t)


Exemples
----------------
Vous trouverez de nombreux exemples de programmes dans le dossier
tests/progs le plus notable est probablement le tictactoe avec une IA.
En tapant make testCompare, on peut lancer ces tests, et comparer les résultats dans les différents langages

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

Les exemples suivant présentent du code du même type que deux des codes à compléter pour les demies finales :

* tests/prog/prologin_template_2charline2.metalang
* tests/prog/prologin_template_charmatrix.metalang
* tests/prog/prologin_template_2charline.metalang
* tests/prog/prologin_template_intlist.metalang
* tests/prog/prologin_template_charline.metalang
* tests/prog/prologin_template_intmatrix.metalang


Normalement, avec cet outil, vous avez les moyens de faire des codes à compléter. N'oubliez pas de tester vos codes générés.

Types simples manipulables
----------------

Les types simples que metalang gère sont les entiers (notés int), les booleans (notés bool) les chars et les chaines de caractères (notés string).
Il n'existe pratiquement aucune fonction pour manipuler les chaines de caractères. Elles n'existent que pour l'instruction print.
Le type int représente des entiers, leur taille n'est pas définie. En C ils font 32 bits, en ocaml 31 bits, en python ce sont des bigints.
Le type char représente un caractère.

Il n'existe pas de type float en metalang.
Les conversions automatiques entre deux types ne sont pas possibles en metalang. Pour convertir un char en int, il faut utiliser la fonction int_of_char.

Null n'existe pas en metalang.

Commentaires
----------------

Il existe deux types de commentaires :

* Les commentaires sont compris entre /* et */ sont retranscrits dans les codes générés.
* après le caractère #, la fin de la ligne est ignorée. Ces commentaires là ne sont pas retranscrits dans les codes générés.

Declaration de variables
----------------

Une variable doit toujours avoir une valeur. Pour définir un entier x de valeur 42, on fait ::

  def int x = 42

On est pas obligé de définir le type : une passe de typage s'arrangera pour l'inférer. ::

  def x = 42


Declaration de tableaux
----------------

Pour définir un tableau, rien de plus simple ::

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

Pour récupérer ou affecter la valeur du champ 1, on utilise variable.field1

Pour éviter tout code moche généré, deux structures doivent avoir des noms de champs distincts.

Declaration d'enums
----------------

Pour définir un enum ::

  enum @foo_t
    Foo Bar Blah
  end

Ensuite, le type a pour nom @foo_t et on utilise Foo, Bar Blah comme des valeurs

Fonctions
----------------

Les fonctions ne peuvent pas être mutuellement récursives, mais les fonctions récursives ne posent aucun problème.
Les arguments sont passés par valeur pour les entiers, enum et chars, et par référence pour les tableaux et structures.

Pour définir une fonction ::

  def type_de_retour nom_fonction(type1 param1, type2 param2)
    ...
  end

Pour renvoyer une valeur ::

  return valeur

Une fonction qui renvoie quelque chose doit forcément avoir un return dans chaque chemin d'execution (comme en java).

Il est impossible de mettre un return dans une fonction qui renvoie void.

Boucles
----------------

Les boucles for ont pour syntaxe ::

  for variable = debut to fin do
    ...
  end

L'incrémentation ne peut pas être définie. Elle est toujours égale à 1.
Attention : la boucle for déclare une nouvelle variable.

Les boucles while ont pour syntaxe ::

  while condition do
    ...
  end

Les instructions break et continue n'existent pas en metalang. Cependant, vous pouvez utiliser return à l'interieur de ces boucles.

If Then Else
----------------

La syntaxe est ::

  if ... then
    ...
  elsif ... then
    ...
  else
    ...
  end

Print
----------------

L'instruction print vous permet d'écrire sur la sortie standard::

  print "foo"
  def x = 42
  print x print "\n"


Librairie Standard
----------------

La librairie standard comprend les fonctions suivantes :

* int isqrt(int)
* char char_of_int(int)
* int int_of_char(char)
* bool is_number(char)
* int max2(int, int)
* int min2(int, int)
* int min3(int, int, int)
* int min4(int, int, int, int)
* int pgcd(int, int)
* int read_int()
* array<int> read_int_line(int len)
* array<char> read_char_line(int len)
* array<array<char>> read_char_matrix(int x, int y)
* array<array<int>> read_int_matrix(int x, int y)

Elles sont définies dans le fichier Stdlib/stdlib.metalang.
