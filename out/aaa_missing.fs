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
\ 
\   Ce test a été généré par Metalang.
\ 

: result { len tab }
  HERE len cells allot { tab2 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    false tab2 i cells +
     !
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i1 }
    tab i1 cells +
     @ s>d 0 d.r
    S"  " TYPE
    true tab2 tab i1 cells +
     @ cells +
     !
   1 + REPEAT 2DROP
  S\" \n" TYPE
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i2 }
    tab2 i2 cells +
     @ INVERT
    IF
      DROP DROP i2 exit
    THEN
   1 + REPEAT 2DROP
  1 NEGATE exit
;

: main
  read-int { len }
  skipspaces
  len s>d 0 d.r
  S\" \n" TYPE
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-int tab a cells +
     !
    skipspaces
   1 + REPEAT 2DROP
  len tab result s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

