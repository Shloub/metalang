\ 
\ TODO ajouter un record qui contient des chaines.
\ 

: idstring { D: s }
  s exit
;

: printstring { D: s }
  s idstring TYPE
  NEWLINE TYPE
;

: main
  HERE 2 cells 2 * allot { tab }
  2 1 - 0 BEGIN 2dup >= WHILE DUP { i }
     s" chaine de test" idstring tab i cells 2 * + 2!
   1 + REPEAT 2DROP
  1 0 BEGIN 2dup >= WHILE DUP { j }
    tab j cells 2 * + 2@ idstring printstring
   1 + REPEAT 2DROP
  ;
main
BYE

