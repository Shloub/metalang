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
: nth { tab tofind len }
  0 { out0 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    tab i cells + @ tofind =
    IF
      out0 1 + TO out0
    THEN
   1 + REPEAT 2DROP
  out0 exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  0 { tofind }
  read-char TO tofind
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { tmp }
    read-char TO tmp
    tmp tab i cells + !
   1 + REPEAT 2DROP
  tab tofind len nth { result }
  result s>d 0 d.r
  ;
main
BYE

