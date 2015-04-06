: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: exp0 { a e }
  1 { o }
  e 1 BEGIN 2dup >= WHILE DUP { i }
    o a * TO o
   1 + REPEAT 2DROP
  o exit
;

: e { t n }
  8 1 BEGIN 2dup >= WHILE DUP { i }
    n t i cells +
     @ i * >=
    IF
      n t i cells +
       @ i * - TO n
    ELSE
      10 i 1 - exp0 n i // + { nombre }
      i 1 - n i % - { chiffre }
      DROP DROP nombre 10 chiffre exp0 // 10 % exit
    THEN
   1 + REPEAT 2DROP
  1 NEGATE exit
;

: main
  HERE 9 cells allot { t }
  9 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    10 i exp0 10 i 1 - exp0 - t i cells +
     !
   1 + REPEAT 2DROP
  8 1 BEGIN 2dup >= WHILE DUP { i2 }
    i2 s>d 0 d.r
    S"  => " TYPE
    t i2 cells +
     @ s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  80 0 BEGIN 2dup >= WHILE DUP { j }
    t j e s>d 0 d.r
   1 + REPEAT 2DROP
  S\" \n" TYPE
  50 1 BEGIN 2dup >= WHILE DUP { k }
    k s>d 0 d.r
   1 + REPEAT 2DROP
  S\" \n" TYPE
  220 169 BEGIN 2dup >= WHILE DUP { j2 }
    t j2 e s>d 0 d.r
   1 + REPEAT 2DROP
  S\" \n" TYPE
  110 90 BEGIN 2dup >= WHILE DUP { k2 }
    k2 s>d 0 d.r
   1 + REPEAT 2DROP
  S\" \n" TYPE
  1 { out0 }
  6 0 BEGIN 2dup >= WHILE DUP { l }
    10 l exp0 { puiss }
    t puiss 1 - e { v }
    out0 v * TO out0
    S" 10^" TYPE
    l s>d 0 d.r
    S" =" TYPE
    puiss s>d 0 d.r
    S"  v=" TYPE
    v s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  out0 s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

