struct
  double% field ->s
  cell% field ->v
end-struct toto%

: idstring { D: s }
  s exit
;

: printstring { D: s }
  s idstring TYPE
  S\" \n" TYPE
;

: print_toto { t }
  t ->s 2@ TYPE
  S"  = " TYPE
  t ->v @ s>d 0 d.r
  S\" \n" TYPE
;

: main
  HERE 2 cells 2 * allot { tab }
  2 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    S" chaine de test" idstring tab  i cells 2 * +  2!
   1 + REPEAT 2DROP
  1 0 BEGIN 2dup >= WHILE DUP { j }
    tab  j cells 2 * +  2@ idstring printstring
   1 + REPEAT 2DROP
  toto% %allot { a }
  S" one" a ->s 2!
  1 a ->v !
  a print_toto
  ;
main
BYE

