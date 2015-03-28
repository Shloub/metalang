: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
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
: position_alphabet { c }
  c { i }
  i [char] Z <= i [char] A >= AND
  IF
    i [char] A - exit
  ELSE
    i [char] z <= i [char] a >= AND
    IF
      i [char] a - exit
    ELSE
      1 NEGATE exit
    THEN
  THEN
;

: of_position_alphabet { c }
  c [char] a + exit
;

: crypte { taille_cle cle taille message }
  taille 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    message i cells +
     @ position_alphabet { lettre }
    lettre 1 NEGATE <>
    IF
      cle i taille_cle % cells +
       @ position_alphabet { addon }
      addon lettre + 26 % { new0 }
      new0 of_position_alphabet message i cells +
       !
    THEN
   1 + REPEAT 2DROP
;

: main
  read-int { taille_cle }
  skipspaces
  HERE taille_cle cells allot { cle }
  taille_cle 1 - 0 BEGIN 2dup >= WHILE DUP { index }
    read-char { out0 }
    out0 cle index cells +
     !
   1 + REPEAT 2DROP
  skipspaces
  read-int { taille }
  skipspaces
  HERE taille cells allot { message }
  taille 1 - 0 BEGIN 2dup >= WHILE DUP { index2 }
    read-char { out2 }
    out2 message index2 cells +
     !
   1 + REPEAT 2DROP
  taille_cle cle taille message crypte
  taille 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    message i cells +
     @ EMIT
   1 + REPEAT 2DROP
  NEWLINE TYPE
  ;
main
BYE

