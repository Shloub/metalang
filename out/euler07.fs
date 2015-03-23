

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



: divisible { n t size }
  size 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    n t i cells + @ % 0 =
    IF
      DROP DROP true exit
    THEN
   1 + REPEAT 2DROP
  false exit
;

: find0 { n t used nth }
  BEGIN
    used nth <>
  WHILE
    n t used divisible
    IF
      n 1 + TO n
    ELSE
      n t used cells + !
      n 1 + TO n
      used 1 + TO used
    THEN
  REPEAT
  t used 1 - cells + @ exit
;

: main
  10001 { n }
  HERE n cells allot { t }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    2 t i cells + !
   1 + REPEAT 2DROP
  3 t 1 n find0 s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

