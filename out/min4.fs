

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
  1 2 min 3 min 4 min s>d 0 d.r
   s"  " TYPE
  1 2 min 4 min 3 min s>d 0 d.r
   s"  " TYPE
  1 3 min 2 min 4 min s>d 0 d.r
   s"  " TYPE
  1 3 min 4 min 2 min s>d 0 d.r
   s"  " TYPE
  1 4 min 2 min 3 min s>d 0 d.r
   s"  " TYPE
  1 4 min 3 min 2 min s>d 0 d.r
  NEWLINE TYPE
  2 1 min 3 min 4 min s>d 0 d.r
   s"  " TYPE
  2 1 min 4 min 3 min s>d 0 d.r
   s"  " TYPE
  2 3 min 1 min 4 min s>d 0 d.r
   s"  " TYPE
  2 3 min 4 min 1 min s>d 0 d.r
   s"  " TYPE
  2 4 min 1 min 3 min s>d 0 d.r
   s"  " TYPE
  2 4 min 3 min 1 min s>d 0 d.r
  NEWLINE TYPE
  3 1 min 2 min 4 min s>d 0 d.r
   s"  " TYPE
  3 1 min 4 min 2 min s>d 0 d.r
   s"  " TYPE
  3 2 min 1 min 4 min s>d 0 d.r
   s"  " TYPE
  3 2 min 4 min 1 min s>d 0 d.r
   s"  " TYPE
  3 4 min 1 min 2 min s>d 0 d.r
   s"  " TYPE
  3 4 min 2 min 1 min s>d 0 d.r
  NEWLINE TYPE
  4 1 min 2 min 3 min s>d 0 d.r
   s"  " TYPE
  4 1 min 3 min 2 min s>d 0 d.r
   s"  " TYPE
  4 2 min 1 min 3 min s>d 0 d.r
   s"  " TYPE
  4 2 min 3 min 1 min s>d 0 d.r
   s"  " TYPE
  4 3 min 1 min 2 min s>d 0 d.r
   s"  " TYPE
  4 3 min 2 min 1 min s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

