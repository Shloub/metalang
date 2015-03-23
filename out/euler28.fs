

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
\ 
\ 43 44 45 46 47 48 49
\ 42 21 22 23 24 25 26
\ 41 20  7  8  9 10 27
\ 40 19  6  1  2 11 28
\ 39 18  5  4  3 12 29
\ 38 17 16 15 14 13 30
\ 37 36 35 34 33 32 31
\ 
\ 1 3 5 7 9 13 17 21 25 31 37 43 49
\   2 2 2 2 4  4  4  4  6   6  6  6
\ 
\ 
\ 

: sumdiag { n }
  n 2 * 1 - { nterms }
  1 { un }
  1 { sum }
  nterms 2 - 0 BEGIN 2dup >= WHILE DUP { i }
    2 1 i 4 // + * { d }
    un d + TO un
    \  print int d print "=>" print un print " " 
    
    sum un + TO sum
   1 + REPEAT 2DROP
  sum exit
;

: main
  1001 sumdiag s>d 0 d.r
  ;
main
BYE

