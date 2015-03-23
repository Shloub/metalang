

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



: main
  0 { i }
  i 1 - TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 55 + TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 13 * TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 2 // TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 1 + TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 3 // TO i
  i s>d 0 d.r
  NEWLINE TYPE
  i 1 - TO i
  i s>d 0 d.r
  NEWLINE TYPE
  \ 
  \ http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
  \ 
  
  117 17 // s>d 0 d.r
  NEWLINE TYPE
  117 17 NEGATE // s>d 0 d.r
  NEWLINE TYPE
  117 NEGATE 17 // s>d 0 d.r
  NEWLINE TYPE
  117 NEGATE 17 NEGATE // s>d 0 d.r
  NEWLINE TYPE
  117 17 % s>d 0 d.r
  NEWLINE TYPE
  117 17 NEGATE % s>d 0 d.r
  NEWLINE TYPE
  117 NEGATE 17 % s>d 0 d.r
  NEWLINE TYPE
  117 NEGATE 17 NEGATE % s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

