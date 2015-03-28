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
: programme_candidat { tableau1 taille1 tableau2 taille2 }
  0 { out0 }
  taille1 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    out0 tableau1 i cells +
 @ i * + TO out0
    tableau1 i cells +
     @ EMIT
   1 + REPEAT 2DROP
   s" --" NEWLINE S+ TYPE
  taille2 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    out0 tableau2 j cells +
 @ j 100 * * + TO out0
    tableau2 j cells +
     @ EMIT
   1 + REPEAT 2DROP
   s" --" NEWLINE S+ TYPE
  out0 exit
;

: main
  read-int { taille1 }
  skipspaces
  read-int { taille2 }
  skipspaces
  HERE taille1 cells allot { tableau1 }
  taille1 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-char tableau1 a cells +
     !
   1 + REPEAT 2DROP
  skipspaces
  HERE taille2 cells allot { tableau2 }
  taille2 1 - 0 BEGIN 2dup >= WHILE DUP { b }
    read-char tableau2 b cells +
     !
   1 + REPEAT 2DROP
  skipspaces
  tableau1 taille1 tableau2 taille2 programme_candidat s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

