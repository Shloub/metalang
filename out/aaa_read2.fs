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
\ Ce test permet de vérifier si les différents backends pour les langages implémentent bien
\ read int, read char et skip
\ 

: main
  read-int { len }
  skipspaces
  len s>d 0 d.r
  S\" =len\n" TYPE
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-int tab a cells +
     !
    skipspaces
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i s>d 0 d.r
    S" =>" TYPE
    tab i cells +
     @ s>d 0 d.r
    S"  " TYPE
   1 + REPEAT 2DROP
  S\" \n" TYPE
  HERE len cells allot { tab2 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { b }
    read-int tab2 b cells +
     !
    skipspaces
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i_ }
    i_ s>d 0 d.r
    S" ==>" TYPE
    tab2 i_ cells +
     @ s>d 0 d.r
    S"  " TYPE
   1 + REPEAT 2DROP
  read-int { strlen }
  skipspaces
  strlen s>d 0 d.r
  S\" =strlen\n" TYPE
  HERE strlen cells allot { tab4 }
  strlen 1 - 0 BEGIN 2dup >= WHILE DUP { d }
    read-char tab4 d cells +
     !
   1 + REPEAT 2DROP
  skipspaces
  strlen 1 - 0 BEGIN 2dup >= WHILE DUP { i3 }
    tab4 i3 cells +
     @ { tmpc }
    tmpc { c }
    tmpc EMIT
    S" :" TYPE
    c s>d 0 d.r
    S"  " TYPE
    tmpc 32 <>
    IF
      c [char] a - 13 + 26 % [char] a + TO c
    THEN
    c tab4 i3 cells +
     !
   1 + REPEAT 2DROP
  strlen 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    tab4 j cells +
     @ EMIT
   1 + REPEAT 2DROP
  ;
main
BYE

