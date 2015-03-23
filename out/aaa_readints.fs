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
: main
  read-int { len }
  skipspaces
  len s>d 0 d.r
   s" =len" NEWLINE S+ TYPE
  HERE len cells allot { tab1 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-int tab1 a cells + !
    skipspaces
   1 + REPEAT 2DROP
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i s>d 0 d.r
     s" =>" TYPE
    tab1 i cells + @ s>d 0 d.r
    NEWLINE TYPE
   1 + REPEAT 2DROP
  read-int TO len
  skipspaces
  HERE len 1 - cells allot { tab2 }
  len 1 - 1 - 0 BEGIN 2dup >= WHILE DUP { b }
    HERE len cells allot { c }
    len 1 - 0 BEGIN 2dup >= WHILE DUP { d }
      read-int c d cells + !
      skipspaces
     1 + REPEAT 2DROP
    c tab2 b cells + !
   1 + REPEAT 2DROP
  len 2 - 0 BEGIN 2dup >= WHILE DUP { i }
    len 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      tab2 i cells + @ j cells + @ s>d 0 d.r
       s"  " TYPE
     1 + REPEAT 2DROP
    NEWLINE TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

