Metalang
========

C'est quoi ?
----------------
Metalang est un langage de programmation. Il permet d'écrire une fois un code et d'obtenir le même programme dans plusieurs autres langages (voir plus bas)

Le blog du projet se trouve ici : A [eelte.megami.fr](http://eelte.megami.fr).

Ce langage a été conçu pour ce A [concours](http://prologin.org).

Hello World
----------------

Voici le programme helloworld.metalang ::

  main
	  print "Hello World"
  end

Quick start
----------------
ouvrir une console, aller dans le dossier metalang, taper ::

  make metalang
  ./metalang tests/prog/aaa_01hello.metalang

Le hello world apparait alors dans les différents langages.

Pour lancer metalang en mode évaluateur ::

  ./metalang -eval fichier.metalang

Pour générer uniquement une langue ::

  ./metalang -lang lang1,lang2,...

Les langues possibles sont : adb, c, cc, cl, cs, fs, fun.ml, go, hs, java, js, lua, m, ml, pas, php, pl, py, rb, rkt, scala, st, vb
fun.ml correspond à une version fonctionelle, en ocaml, du code metalang.

L'option -o vous permet de choisir le dossier de destination. Comme nous générons plusieurs fichiers, on ne peut pas choisir le nom des fichiers générés.

pour afficher l'aide ::

  ./metalang -help

pour afficher la version ::

  ./metalang -version



Backends
----------------
Langages cibles :

* Ada
* C
* C++
* common lisp (se lance avec sbcl dans les tests)
* C#
* Forth (se lance avec gforth dans les tests)
* Go (Version 1.1 minimum, sinon on a des soucis avec leur test qui vérifie si chaque fonction renvoie bien.)
* Haskell
* java
* javascript
* Lua
* Objective-C
* Ocaml
* Pascal
* php
* perl
* python
* ruby
* scheme (racket)
* scala
* smalltalk
* visual basic (.net)

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


Le dossier tools contient des outils comme le mode emacs et un mode vim, pour installer le mode emacs,
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

Pour éviter ce problème, on a plusieurs fonctions alternatives dans la lib standard : read_int et read_int_line. Il ne FAUT PAS melanger ces deux façons de parser, sinon ça risque de faire tout planter (le compilateur vérifie ça pour certains langages).

En metalang, on ne peut pas savoir quelle est la taille d'une ligne, donc on ne peut pas parser une ligne et récupérer un tableau d'entier de taille variable. On ne peut pas non plus le faire pour une chaine de caractères. La fonction read_int_line prend en paramètre le nombre d'entiers à parser.

Les exemples suivant présentent du code du même type que certains des codes à compléter pour les demies finales :

* tests/prog/prologin_template_2charline2.metalang
* tests/prog/prologin_template_charmatrix.metalang
* tests/prog/prologin_template_2charline.metalang
* tests/prog/prologin_template_intlist.metalang
* tests/prog/prologin_template_charline.metalang
* tests/prog/prologin_template_intmatrix.metalang


Normalement, avec cet outil, vous avez les moyens de faire des codes à compléter. N'oubliez pas de tester vos codes générés (en printant simplement une addition des valeurs parsées par exemple).

Types simples manipulables
----------------

Les types simples que metalang gère sont les entiers (notés int), les booleans (notés bool) les chars et les chaines de caractères (notés string).
Il n'existe pratiquement aucune fonction pour manipuler les chaines de caractères. Elles n'existent que pour l'instruction print.
Le type int représente des entiers, leur taille n'est pas définie. En C ils font 32 bits, en ocaml 31 bits, en python ce sont des bigints.
Le type char représente un caractère.

Il n'existe pas de type float en metalang.
Les conversions automatiques entre deux types ne sont pas possibles en metalang. Pour convertir un char en int, il faut utiliser la fonction int_of_char.
Attention toutefois : dans certains langages les chars sont signés, alors que dans d'autres ils sont non signés.

Null n'existe pas en metalang.

Commentaires
----------------

Il existe deux types de commentaires :

* Les commentaires sont compris entre /* et */ sont retranscrits dans les codes générés. Ils doivent etre placés comme des instructions.
* après le caractère #, la fin de la ligne est ignorée. Ces commentaires là ne sont pas retranscrits dans les codes générés.

Declaration de variables
----------------

Une variable doit toujours avoir une valeur. Pour définir un entier x de valeur 42, on fait ::

  def int x = 42

On est pas obligé de définir le type : une passe de typage s'arrangera pour l'inférer. ::

  def x = 42

Lorsque l'on veut déclarer une variable et lire sa valeur depuis l'entrée standard en même temps, on peut taper ::

  def read int x

ou encore ::

  def read x

Il faut noter que dans certains langages, une valeur par défault leur sera attribuée (en C par exemple)

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

La librairie standard contient un enum ::

  enum @target_language
    LANG_C
    LANG_Cc
    LANG_Cl
    LANG_Cs
    LANG_Fun_ml
    LANG_Go
    LANG_Hs
    LANG_Java
    LANG_Js
    LANG_M
    LANG_Ml
    LANG_Pas
    LANG_Php
    LANG_Pl
    LANG_Py
    LANG_Rb
    LANG_Rkt
    LANG_Metalang_parsed
  end


Elle comprend aussi les fonctions suivantes :

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
* (int, int) read_int_couple()
* (int, int, int) read_3ints()
* @target_language current_language ()

Elles sont définies dans le fichier Stdlib/stdlib.metalang.

Les fonctions définies dans la librairie standard ne seront compilées que si elles sont utilisées.

Couples & tuples
----------------

Les couples existent en metalang, ils ne sont cependant pas recommandés : leur utilisation produit du code assez illisible pour la plupart des backends.
Pour la plupart des langages, ils sont compilés vers des structures.

Le type s'écrit (a, b) (exemple : (int, int) )
Les valeurs de types tuples s'écrivent aussi (a, b) (exemple : (1, 2) )

Un exemple se trouve ici : tests/prog/tuple.metalang

Leur utilisation n'a pas été très testée. Il est possible que cette fonctionalité ne soit pas très stable.

inline
----------------

Le mot clé inline se place lors d'une définition de variables ou de fonction.
Il indique que l'on peut inliner la fonction et la variable.

Pour inliner une fonction, il faut qu'elle n'ai qu'un seul return et qu'il soit terminal.
Si une fonction est marquée inline et qu'elle n'est pas prévue pour, alors une erreur se produira.

Si une variable est marquée inline et que le compilateur ne trouve pas de méthode pour la supprimer, alors elle restera et aucune erreur ne sera levée.

Exemple ::

  def inline toto = b
  a = toto

Le code ci-dessus sera compilé vers ::

  a = b


Macros
----------------

Les macros metalang sont utilisées pour écrire des primitives.

La librairie standard regorge d'exemples ::

  macro type fonction_name(parametres)
    langage1 do "chaine1"
    langage2 do "chaine2"
    ** do "chaine3"
  end

les noms de langages sont définis par la méthode lang définie dans les printers.

les chaines sont inserées dans les fichiers générés, après un remplacement de : $parametre1 par le code qui correspond.

Lorsque l'on écrit une macro, il faut faire attention au parenthésage et aux conversions automatiques de types (entre int et float par exemple.)


Lexems
----------------

Cette notion est une notion de préprocessing avancée.

Il existe un autre type en metalang : lexems. Ce type représente une liste de "mots" metalang.
Pour en créer une, il suffit de faire taper du code entre des accolades ::

  def lexems i = { x = x + 1 }

Il existe deux façons d'utiliser la variable i : l'une d'entre elle consiste à l'inserrer dans un autre lexems ::

  def lexems j = { ${i} ${i} }

Cet exemple là permet de duppliquer le code compris dans i.

L'autre façon d'utiliser une valeur de type lexems est de faire "sortir" ce code. Il sera ensuite parsé et inserré dans le le flux d'instructions ::

  ${i}

L'exemple le plus simple se trouve dans le fichier tests/prog/loop_unroll.metalang
On trouve un exemple plus complexe dans tests/prog/sudoku.metalang. On y génère une expression qui détermine si un sudoku est valide ou non.

Générer un code différent par langage
----------------

Pour faire ceci, il faut utiliser des macros et des lexems.
On trouve un exemple de ceci dans la librairie standard pour min3 par exemple : en C on utilise la fonction metalang min2, alors qu'en python min permet de prendre trois valeurs pour un seul appel de fonction.

Pour tester si on compile bien dans un langage précis, on peut utiliser la fonction current_language ::

  if current_language() == LANG_Java then
    ...
  end

Cette méthode est utilisée aussi pour minimiser les lectures sur l'entrée standard.


Quels langages ne seront probablement jamais gérés dans Metalang ?
----------------

* TCL : le passage des tableaux par référence n'est pas une feature propre du langage, et le retour d'un tableau par référence ne fonctionne pas.
* Bash pour les memes raisons.

Tout les langages qui ne se testent pas facilement sous linux.
