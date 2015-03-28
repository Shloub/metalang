: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: primesfactors { n }
  HERE n 1 + cells allot { tab }
  n 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 tab i cells +
     !
   1 + REPEAT 2DROP
  2 { d }
  BEGIN
    n 1 <> d d * n <= AND
  WHILE
    n d % 0 =
    IF
      tab d cells +
       @ 1 + tab d cells +
       !
      n d // TO n
    ELSE
      d 1 + TO d
    THEN
  REPEAT
  tab n cells +
   @ 1 + tab n cells +
   !
  tab exit
;

: main
  20 { lim }
  HERE lim 1 + cells allot { o }
  lim 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    0 o m cells +
     !
   1 + REPEAT 2DROP
  lim 1 BEGIN 2dup >= WHILE DUP { i }
    i primesfactors { t }
    i 1 BEGIN 2dup >= WHILE DUP { j }
      o j cells +
 @ t j cells +
 @ max o j cells +
       !
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  1 { product }
  lim 1 BEGIN 2dup >= WHILE DUP { k }
    o k cells +
     @ 1 BEGIN 2dup >= WHILE DUP { l }
      product k * TO product
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  product s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

