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
  read-int { x }
  skipspaces
  read-int { y }
  skipspaces
  HERE y cells allot { tab }
  y 1 - 0 BEGIN 2dup >= WHILE DUP { d }
    HERE x cells allot { e }
    x 1 - 0 BEGIN 2dup >= WHILE DUP { f }
      read-int e f cells + !
      skipspaces
     1 + REPEAT 2DROP
    e tab d cells + !
   1 + REPEAT 2DROP
  x 1 - 1 BEGIN 2dup >= WHILE DUP { ix }
    y 1 - 1 BEGIN 2dup >= WHILE DUP { iy }
      tab iy cells + @ ix cells + @ 1 =
      IF
        tab iy cells + @ ix 1 - cells + @ tab iy 1 - cells + @ ix cells + @ min tab iy 1 - cells + @ ix 1 - cells + @ min 1 + tab iy cells + @ ix cells + !
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  y 1 - 0 BEGIN 2dup >= WHILE DUP { jy }
    x 1 - 0 BEGIN 2dup >= WHILE DUP { jx }
      tab jy cells + @ jx cells + @ s>d 0 d.r
       s"  " TYPE
     1 + REPEAT 2DROP
    NEWLINE TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

