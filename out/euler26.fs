

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



: periode { restes len a b }
  BEGIN
    a 0 <>
  WHILE
    a b // { chiffre }
    a b % { reste }
    len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
      restes i cells + @ reste =
      IF
        DROP DROP len i - exit
      THEN
     1 + REPEAT 2DROP
    reste restes len cells + !
    len 1 + TO len
    reste 10 * TO a
  REPEAT
  0 exit
;

: main
  HERE 1000 cells allot { t }
  1000 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    0 t j cells + !
   1 + REPEAT 2DROP
  0 { m }
  0 { mi }
  1000 1 BEGIN 2dup >= WHILE DUP { i }
    t 0 1 i periode { p }
    p m >
    IF
      i TO mi
      p TO m
    THEN
   1 + REPEAT 2DROP
  mi s>d 0 d.r
  NEWLINE TYPE
  m s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

