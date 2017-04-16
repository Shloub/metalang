: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
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
: dichofind recursive { len tab tofind a b }
  a b 1 - >=
  IF
    a exit
  ELSE
    a b + 2 // { c }
    tab  c cells +  @ tofind <
    IF
      len tab tofind c b dichofind exit
    ELSE
      len tab tofind a c dichofind exit
    THEN
  THEN
;


: process { len tab }
  HERE len cells allot { size }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    j 0 =
    IF
      0 size  j cells +  !
    ELSE
      len 2 * size  j cells +  !
    THEN
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    len size tab  i cells +  @ 0 len 1 - dichofind { k }
    size  k 1 + cells +  @ tab  i cells +  @ >
    IF
      tab  i cells +  @ size  k 1 + cells +  !
    THEN
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { l }
    size  l cells +  @ s>d 0 d.r
    S"  " TYPE
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    len 1 - m - { k }
    size  k cells +  @ len 2 * <>
    IF
      DROP DROP k exit
    THEN
   1 + REPEAT 2DROP
  0 exit
;

: main
  read-int { n }
  skipspaces
  n 1 BEGIN 2dup >= WHILE DUP { i }
    read-int { len }
    skipspaces
    HERE len cells allot { d }
    len 1 - 0 BEGIN 2dup >= WHILE DUP { e }
      read-int d  e cells +  !
      skipspaces
     1 + REPEAT 2DROP
    len d process s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

