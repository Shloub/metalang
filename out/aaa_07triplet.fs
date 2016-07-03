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
  3 1 BEGIN 2dup >= WHILE DUP { i }
    read-int { a }
    skipspaces
    read-int { b }
    skipspaces
    read-int { c }
    skipspaces
    S" a = " TYPE
    a s>d 0 d.r
    S"  b = " TYPE
    b s>d 0 d.r
    S" c =" TYPE
    c s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  HERE 10 cells allot { l }
  9 0 BEGIN 2dup >= WHILE DUP { d }
    read-int l  d cells +  !
    skipspaces
   1 + REPEAT 2DROP
  9 0 BEGIN 2dup >= WHILE DUP { j }
    l  j cells +  @ s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

