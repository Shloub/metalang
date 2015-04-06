: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: triangle { n }
  n 2 % 0 =
  IF
    n 2 // n 1 + * exit
  ELSE
    n n 1 + 2 // * exit
  THEN
;

: penta { n }
  n 2 % 0 =
  IF
    n 2 // 3 n * 1 - * exit
  ELSE
    3 n * 1 - 2 // n * exit
  THEN
;

: hexa { n }
  n 2 n * 1 - * exit
;

: findPenta2 recursive { n a b }
  b a 1 + =
  IF
    a penta n = b penta n = OR exit
  THEN
  a b + 2 // { c }
  c penta { p }
  p n =
  IF
    true exit
  ELSE
    p n <
    IF
      n c b findPenta2 exit
    ELSE
      n a c findPenta2 exit
    THEN
  THEN
;

: findHexa2 recursive { n a b }
  b a 1 + =
  IF
    a hexa n = b hexa n = OR exit
  THEN
  a b + 2 // { c }
  c hexa { p }
  p n =
  IF
    true exit
  ELSE
    p n <
    IF
      n c b findHexa2 exit
    ELSE
      n a c findHexa2 exit
    THEN
  THEN
;

: main
  55385 285 BEGIN 2dup >= WHILE DUP { n }
    n triangle { t }
    t n 5 // n findPenta2 t n 5 // n 2 // 10 + findHexa2 AND
    IF
      n s>d 0 d.r
      S\" \n" TYPE
      t s>d 0 d.r
      S\" \n" TYPE
    THEN
   1 + REPEAT 2DROP
  ;
main
BYE

