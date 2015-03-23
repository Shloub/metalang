

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



: pgcd recursive { a b }
  a b min { c }
  a b max { d }
  d c % { reste }
  reste 0 =
  IF
    c exit
  ELSE
    c reste pgcd exit
  THEN
;

: main
  1 { top }
  1 { bottom }
  9 1 BEGIN 2dup >= WHILE DUP { i }
    9 1 BEGIN 2dup >= WHILE DUP { j }
      9 1 BEGIN 2dup >= WHILE DUP { k }
        i j <> j k <> AND
        IF
          i 10 * j + { a }
          j 10 * k + { b }
          a k * i b * =
          IF
            a s>d 0 d.r
             s" /" TYPE
            b s>d 0 d.r
            NEWLINE TYPE
            top a * TO top
            bottom b * TO bottom
          THEN
        THEN
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  top s>d 0 d.r
   s" /" TYPE
  bottom s>d 0 d.r
  NEWLINE TYPE
  top bottom pgcd { p }
   s" pgcd=" TYPE
  p s>d 0 d.r
  NEWLINE TYPE
  bottom p // s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

