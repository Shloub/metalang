: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: fact { n }
  1 { prod }
  n 2 BEGIN 2dup >= WHILE DUP { i }
    prod i * TO prod
   1 + REPEAT 2DROP
  prod exit
;

: show { lim nth }
  HERE lim cells allot { t }
  lim 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i t i cells +
     !
   1 + REPEAT 2DROP
  HERE lim cells allot { pris }
  lim 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    false pris j cells +
     !
   1 + REPEAT 2DROP
  lim 1 - 1 BEGIN 2dup >= WHILE DUP { k }
    lim k - fact { n }
    nth n // { nchiffre }
    nth n % TO nth
    lim 1 - 0 BEGIN 2dup >= WHILE DUP { l }
      pris l cells +
       @ INVERT
      IF
        nchiffre 0 =
        IF
          l s>d 0 d.r
          true pris l cells +
           !
        THEN
        nchiffre 1 - TO nchiffre
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  lim 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    pris m cells +
     @ INVERT
    IF
      m s>d 0 d.r
    THEN
   1 + REPEAT 2DROP
  S\" \n" TYPE
;

: main
  10 999999 show
  ;
main
BYE

