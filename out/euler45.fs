

: // { a b }
  a b /
  a 0 < b 0 < XOR IF 1 + THEN
;

: % { a b }
  a b MOD
  a 0 < b 0 < XOR IF b - THEN
 ;


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
  THEN
;

: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;

: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT
;

: read-int
  [char] - current-char = IF
    -1
    next-char
  ELSE 1
  THEN
  0
  BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT
  *
;

: read-char current-char next-char ;



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
      NEWLINE TYPE
      t s>d 0 d.r
      NEWLINE TYPE
    THEN
   1 + REPEAT 2DROP
  ;
main
BYE

