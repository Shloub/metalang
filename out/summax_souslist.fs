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
: summax { lst len }
  0 { current }
  0 { max0 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    current lst  i cells +  @ + TO current
    current 0 <
    IF
      0 TO current
    THEN
    max0 current <
    IF
      current TO max0
    THEN
   1 + REPEAT 2DROP
  max0 exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { tmp }
    read-int TO tmp
    skipspaces
    tmp tab  i cells +  !
   1 + REPEAT 2DROP
  tab len summax { result }
  result s>d 0 d.r
  ;
main
BYE

