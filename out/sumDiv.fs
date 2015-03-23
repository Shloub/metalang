: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
VARIABLE buffer-index
1000 buffer-index !
VARIABLE NEOF
1 NEOF !
VARIABLE buffer-max
0 buffer-max !
create bufferc 128 allot
: next-char
  buffer-index @ 1 + buffer-index !
  buffer-index @ buffer-max @ > IF
    0 buffer-index !
    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !
    10 bufferc buffer-max @ + !
  THEN ;
: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;
: read-int
  [char] - current-char = IF -1 next-char ELSE 1 THEN
  0 BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT * ;
: foo {  }
  0 { a }
  \  test 
  
  a 1 + TO a
  \  test 2 
  
;

: foo2 {  }
  
;

: foo3 {  }
  1 1 =
  IF
    
  THEN
;

: sumdiv { n }
  \  On désire renvoyer la somme des diviseurs 
  
  0 { out0 }
  \  On déclare un entier qui contiendra la somme 
  
  n 1 BEGIN 2dup >= WHILE DUP { i }
    \  La boucle : i est le diviseur potentiel
    
    n i % 0 =
    IF
      \  Si i divise 
      
      out0 i + TO out0
      \  On incrémente 
      
    ELSE
      \  nop 
      
    THEN
   1 + REPEAT 2DROP
  out0 exit
  \ On renvoie out
  
;

: main
  \  Programme principal 
  
  0 { n }
  read-int TO n
  \  Lecture de l'entier 
  
  n sumdiv s>d 0 d.r
  ;
main
BYE

