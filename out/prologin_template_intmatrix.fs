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
: programme_candidat { tableau x y }
  0 { out0 }
  y 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    x 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      out0 tableau i cells +
       @ j cells +
       @ i 2 * j + * + TO out0
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  out0 exit
;

: main
  read-int { taille_x }
  skipspaces
  read-int { taille_y }
  skipspaces
  HERE taille_y cells allot { tableau }
  taille_y 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    HERE taille_x cells allot { b }
    taille_x 1 - 0 BEGIN 2dup >= WHILE DUP { c }
      read-int b c cells +
       !
      skipspaces
     1 + REPEAT 2DROP
    b tableau a cells +
     !
   1 + REPEAT 2DROP
  tableau taille_x taille_y programme_candidat s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

