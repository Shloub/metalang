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
: programme_candidat { tableau taille }
  0 { out0 }
  taille 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    out0 tableau  i cells +  @ i * + TO out0
    tableau  i cells +  @ EMIT
   1 + REPEAT 2DROP
  S\" --\n" TYPE
  out0 exit
;

: main
  read-int { taille }
  skipspaces
  HERE taille cells allot { tableau }
  taille 1 - 0 BEGIN 2dup >= WHILE DUP { a }
    read-char tableau  a cells +  !
   1 + REPEAT 2DROP
  skipspaces
  tableau taille programme_candidat s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

