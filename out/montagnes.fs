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
: montagnes0 { tab len }
  1 { max0 }
  1 { j }
  len 2 - { i }
  BEGIN
    i 0 >=
  WHILE
    tab  i cells +  @ { x }
    BEGIN
      j 0 >= x tab  len j - cells +  @ > AND
    WHILE
      j 1 - TO j
    REPEAT
    j 1 + TO j
    x tab  len j - cells +  !
    j max0 >
    IF
      j TO max0
    THEN
    i 1 - TO i
  REPEAT
  max0 exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { x }
    read-int TO x
    skipspaces
    x tab  i cells +  !
   1 + REPEAT 2DROP
  tab len montagnes0 s>d 0 d.r
  ;
main
BYE

