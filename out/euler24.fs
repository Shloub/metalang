

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
    i t i cells + !
   1 + REPEAT 2DROP
  HERE lim cells allot { pris }
  lim 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    false pris j cells + !
   1 + REPEAT 2DROP
  lim 1 - 1 BEGIN 2dup >= WHILE DUP { k }
    lim k - fact { n }
    nth n // { nchiffre }
    nth n % TO nth
    lim 1 - 0 BEGIN 2dup >= WHILE DUP { l }
      pris l cells + @ INVERT
      IF
        nchiffre 0 =
        IF
          l s>d 0 d.r
          true pris l cells + !
        THEN
        nchiffre 1 - TO nchiffre
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  lim 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    pris m cells + @ INVERT
    IF
      m s>d 0 d.r
    THEN
   1 + REPEAT 2DROP
  NEWLINE TYPE
;

: main
  10 999999 show
  ;
main
BYE

