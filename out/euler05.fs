

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



: primesfactors { n }
  HERE n 1 + cells allot { tab }
  n 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 tab i cells + !
   1 + REPEAT 2DROP
  2 { d }
  BEGIN
    n 1 <> d d * n <= AND
  WHILE
    n d % 0 =
    IF
      tab d cells + @ 1 + tab d cells + !
      n d // TO n
    ELSE
      d 1 + TO d
    THEN
  REPEAT
  tab n cells + @ 1 + tab n cells + !
  tab exit
;

: main
  20 { lim }
  HERE lim 1 + cells allot { o }
  lim 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    0 o m cells + !
   1 + REPEAT 2DROP
  lim 1 BEGIN 2dup >= WHILE DUP { i }
    i primesfactors { t }
    i 1 BEGIN 2dup >= WHILE DUP { j }
      o j cells + @ t j cells + @ max o j cells + !
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  1 { product }
  lim 1 BEGIN 2dup >= WHILE DUP { k }
    o k cells + @ 1 BEGIN 2dup >= WHILE DUP { l }
      product k * TO product
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  product s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

