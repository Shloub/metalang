

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



: eratostene { t max0 }
  0 { sum }
  max0 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    t i cells + @ i =
    IF
      sum i + TO sum
      max0 i // i >
      IF
        i i * { j }
        BEGIN
          j max0 < j 0 > AND
        WHILE
          0 t j cells + !
          j i + TO j
        REPEAT
      THEN
    THEN
   1 + REPEAT 2DROP
  sum exit
;

: main
  100000 { n }
  \  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
  
  HERE n cells allot { t }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i t i cells + !
   1 + REPEAT 2DROP
  0 t 1 cells + !
  t n eratostene s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

