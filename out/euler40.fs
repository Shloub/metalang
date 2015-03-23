

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



: exp0 { a e }
  1 { o }
  e 1 BEGIN 2dup >= WHILE DUP { i }
    o a * TO o
   1 + REPEAT 2DROP
  o exit
;

: e { t n }
  8 1 BEGIN 2dup >= WHILE DUP { i }
    n t i cells + @ i * >=
    IF
      n t i cells + @ i * - TO n
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
    10 i exp0 10 i 1 - exp0 - t i cells + !
   1 + REPEAT 2DROP
  8 1 BEGIN 2dup >= WHILE DUP { i2 }
    i2 s>d 0 d.r
     s"  => " TYPE
    t i2 cells + @ s>d 0 d.r
    NEWLINE TYPE
   1 + REPEAT 2DROP
  80 0 BEGIN 2dup >= WHILE DUP { j }
    t j e s>d 0 d.r
   1 + REPEAT 2DROP
  NEWLINE TYPE
  50 1 BEGIN 2dup >= WHILE DUP { k }
    k s>d 0 d.r
   1 + REPEAT 2DROP
  NEWLINE TYPE
  220 169 BEGIN 2dup >= WHILE DUP { j2 }
    t j2 e s>d 0 d.r
   1 + REPEAT 2DROP
  NEWLINE TYPE
  110 90 BEGIN 2dup >= WHILE DUP { k2 }
    k2 s>d 0 d.r
   1 + REPEAT 2DROP
  NEWLINE TYPE
  1 { out0 }
  6 0 BEGIN 2dup >= WHILE DUP { l }
    10 l exp0 { puiss }
    t puiss 1 - e { v }
    out0 v * TO out0
     s" 10^" TYPE
    l s>d 0 d.r
     s" =" TYPE
    puiss s>d 0 d.r
     s"  v=" TYPE
    v s>d 0 d.r
    NEWLINE TYPE
   1 + REPEAT 2DROP
  out0 s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

