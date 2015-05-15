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
: devine0 { nombre tab len }
  tab  0 cells +  @ { min0 }
  tab  1 cells +  @ { max0 }
  len 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    tab  i cells +  @ max0 > tab  i cells +  @ min0 < OR
    IF
      DROP DROP false exit
    THEN
    tab  i cells +  @ nombre <
    IF
      tab  i cells +  @ TO min0
    THEN
    tab  i cells +  @ nombre >
    IF
      tab  i cells +  @ TO max0
    THEN
    tab  i cells +  @ nombre = len i 1 + <> AND
    IF
      DROP DROP false exit
    THEN
   1 + REPEAT 2DROP
  true exit
;

: main
  read-int { nombre }
  skipspaces
  read-int { len }
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    read-int { tmp }
    skipspaces
    tmp tab  i cells +  !
   1 + REPEAT 2DROP
  nombre tab len devine0 { a }
  a
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  ;
main
BYE

