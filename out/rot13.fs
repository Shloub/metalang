: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
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
  THEN ;
: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;
: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT ;
: read-int
  [char] - current-char = IF -1 next-char ELSE 1 THEN
  0 BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT * ;
: read-char current-char next-char ;
\ 
\ Ce test effectue un rot13 sur une chaine lue en entrée
\ 
: main
  read-int { strlen }
  skipspaces
  HERE strlen cells allot { tab4 }
  strlen 1 - 0 BEGIN 2dup >= WHILE DUP { toto }
    read-char { tmpc }
    tmpc { c }
    tmpc 32 <>
    IF
      c [char] a - 13 + 26 % [char] a + TO c
    THEN
    c tab4  toto cells +  !
   1 + REPEAT 2DROP
  strlen 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    tab4  j cells +  @ EMIT
   1 + REPEAT 2DROP
  ;
main
BYE

