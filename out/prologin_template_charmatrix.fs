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
: programme_candidat { tableau taille_x taille_y }
  0 { out0 }
  taille_y 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    taille_x 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      out0 tableau i cells + @ j cells + @ i j 2 * + * + TO out0
      tableau i cells + @ j cells + @ EMIT
     1 + REPEAT 2DROP
     s" --" NEWLINE S+ TYPE
   1 + REPEAT 2DROP
  out0 exit
;

: main
  read-int { taille_x }
  skipspaces
  read-int { taille_y }
  skipspaces
  HERE taille_y cells allot { a }
  taille_y 1 - 0 BEGIN 2dup >= WHILE DUP { b }
    HERE taille_x cells allot { c }
    taille_x 1 - 0 BEGIN 2dup >= WHILE DUP { d }
      read-char c d cells + !
     1 + REPEAT 2DROP
    skipspaces
    c a b cells + !
   1 + REPEAT 2DROP
  a { tableau }
  tableau taille_x taille_y programme_candidat s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

