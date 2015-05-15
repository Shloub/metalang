: test { tab len }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    tab  i cells +  @ s>d 0 d.r
    S"  " TYPE
   1 + REPEAT 2DROP
  S\" \n" TYPE
;

: main
  HERE 5 cells allot { t }
  5 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    1 t  i cells +  !
   1 + REPEAT 2DROP
  t 5 test
  ;
main
BYE

