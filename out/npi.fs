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
: is_number { c }
  c [char] 9 <= c [char] 0 >= AND exit
;

\ 
\ Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
\ 

: npi0 { str len }
  HERE len cells allot { stack }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 stack  i cells +  !
   1 + REPEAT 2DROP
  0 { ptrStack }
  0 { ptrStr }
  BEGIN
    ptrStr len <
  WHILE
    str  ptrStr cells +  @ 32 =
    IF
      ptrStr 1 + TO ptrStr
    ELSE
      str  ptrStr cells +  @ is_number
      IF
        0 { num }
        BEGIN
          str  ptrStr cells +  @ 32 <>
        WHILE
          num 10 * str  ptrStr cells +  @ + [char] 0 - TO num
          ptrStr 1 + TO ptrStr
        REPEAT
        num stack  ptrStack cells +  !
        ptrStack 1 + TO ptrStack
      ELSE
        str  ptrStr cells +  @ 43 =
        IF
          stack  ptrStack 2 - cells +  @ stack  ptrStack 1 - cells +  @ + stack  ptrStack 2 - cells +  !
          ptrStack 1 - TO ptrStack
          ptrStr 1 + TO ptrStr
        THEN
      THEN
    THEN
  REPEAT
  stack  0 cells +  @ exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { tmp }
    read-char TO tmp
    tmp tab  i cells +  !
   1 + REPEAT 2DROP
  tab len npi0 { result }
  result s>d 0 d.r
  ;
main
BYE

