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
: read-char current-char next-char ;
: main
  HERE 12 cells allot { str }
  12 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-char str a cells +
     !
   1 + REPEAT 2DROP
  skipspaces
  11 0 BEGIN 2dup >= WHILE DUP { i }
    str i cells +
     @ EMIT
   1 + REPEAT 2DROP
  ;
main
BYE

