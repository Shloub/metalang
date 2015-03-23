

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



: next0 { n }
  n 2 % 0 =
  IF
    n 2 // exit
  ELSE
    3 n * 1 + exit
  THEN
;

: find0 recursive { n m }
  n 1 =
  IF
    1 exit
  ELSE
    n 1000000 >=
    IF
      1 n next0 m find0 + exit
    ELSE
      m n cells + @ 0 <>
      IF
        m n cells + @ exit
      ELSE
        1 n next0 m find0 + m n cells + !
        m n cells + @ exit
      THEN
    THEN
  THEN
;

: main
  HERE 1000000 cells allot { m }
  1000000 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    0 m j cells + !
   1 + REPEAT 2DROP
  0 { max0 }
  0 { maxi }
  999 1 BEGIN 2dup >= WHILE DUP { i }
    \  normalement on met 999999 mais ça dépasse les int32... 
    
    i m find0 { n2 }
    n2 max0 >
    IF
      n2 TO max0
      i TO maxi
    THEN
   1 + REPEAT 2DROP
  max0 s>d 0 d.r
  NEWLINE TYPE
  maxi s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

