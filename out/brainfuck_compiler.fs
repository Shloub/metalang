

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


\ 
\ Ce test permet de tester les macros
\ C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
\ et qui produit les macros metalang correspondante
\ 

: main
  32 { input }
  500 { current_pos }
  HERE 1000 cells allot { mem }
  1000 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 mem i cells + !
   1 + REPEAT 2DROP
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  current_pos 1 + TO current_pos
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  BEGIN
    mem current_pos cells + @ 0 <>
  WHILE
    mem current_pos cells + @ 1 - mem current_pos cells + !
    current_pos 1 - TO current_pos
    mem current_pos cells + @ 1 + mem current_pos cells + !
    mem current_pos cells + @ EMIT
    current_pos 1 + TO current_pos
  REPEAT
  ;
main
BYE

