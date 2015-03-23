

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



: result recursive { sum t maxIndex cache }
  cache sum cells + @ maxIndex cells + @ 0 <>
  IF
    cache sum cells + @ maxIndex cells + @ exit
  ELSE
    sum 0 = maxIndex 0 = OR
    IF
      1 exit
    ELSE
      0 { out0 }
      sum t maxIndex cells + @ // { div }
      div 0 BEGIN 2dup >= WHILE DUP { i }
        out0 sum i t maxIndex cells + @ * - t maxIndex 1 - cache result + TO out0
       1 + REPEAT 2DROP
      out0 cache sum cells + @ maxIndex cells + !
      out0 exit
    THEN
  THEN
;

: main
  HERE 8 cells allot { t }
  8 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 t i cells + !
   1 + REPEAT 2DROP
  1 t 0 cells + !
  2 t 1 cells + !
  5 t 2 cells + !
  10 t 3 cells + !
  20 t 4 cells + !
  50 t 5 cells + !
  100 t 6 cells + !
  200 t 7 cells + !
  HERE 201 cells allot { cache }
  201 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    HERE 8 cells allot { o }
    8 1 - 0 BEGIN 2dup >= WHILE DUP { k }
      0 o k cells + !
     1 + REPEAT 2DROP
    o cache j cells + !
   1 + REPEAT 2DROP
  200 t 7 cache result s>d 0 d.r
  ;
main
BYE

