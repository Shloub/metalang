: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
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
\  lit un sudoku sur l'entrée standard 

: read_sudoku {  }
  HERE 9 9 * cells allot { out0 }
  9 9 * 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    read-int { k }
    skipspaces
    k out0 i cells +
     !
   1 + REPEAT 2DROP
  out0 exit
;

\  affiche un sudoku 

: print_sudoku { sudoku0 }
  8 0 BEGIN 2dup >= WHILE DUP { y }
    8 0 BEGIN 2dup >= WHILE DUP { x }
      sudoku0 x y 9 * + cells +
       @ s>d 0 d.r
      S"  " TYPE
      x 3 % 2 =
      IF
        S"  " TYPE
      THEN
     1 + REPEAT 2DROP
    S\" \n" TYPE
    y 3 % 2 =
    IF
      S\" \n" TYPE
    THEN
   1 + REPEAT 2DROP
  S\" \n" TYPE
;

\  dit si les variables sont toutes différentes 

\  dit si les variables sont toutes différentes 

\  dit si le sudoku est terminé de remplir 

: sudoku_done { s }
  80 0 BEGIN 2dup >= WHILE DUP { i }
    s i cells +
     @ 0 =
    IF
      DROP DROP false exit
    THEN
   1 + REPEAT 2DROP
  true exit
;

\  dit si il y a une erreur dans le sudoku 

: sudoku_error { s }
  false { out1 }
  8 0 BEGIN 2dup >= WHILE DUP { x }
    out1 s x cells +
     @ 0 <> s x cells +
     @ s x 9 + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 2 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 2 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 3 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 3 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 3 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 4 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 4 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 4 * + cells +
     @ = AND OR s x 9 3 * + cells +
     @ 0 <> s x 9 3 * + cells +
     @ s x 9 4 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 5 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 5 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 5 * + cells +
     @ = AND OR s x 9 3 * + cells +
     @ 0 <> s x 9 3 * + cells +
     @ s x 9 5 * + cells +
     @ = AND OR s x 9 4 * + cells +
     @ 0 <> s x 9 4 * + cells +
     @ s x 9 5 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x 9 3 * + cells +
     @ 0 <> s x 9 3 * + cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x 9 4 * + cells +
     @ 0 <> s x 9 4 * + cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x 9 5 * + cells +
     @ 0 <> s x 9 5 * + cells +
     @ s x 9 6 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 3 * + cells +
     @ 0 <> s x 9 3 * + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 4 * + cells +
     @ 0 <> s x 9 4 * + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 5 * + cells +
     @ 0 <> s x 9 5 * + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x 9 6 * + cells +
     @ 0 <> s x 9 6 * + cells +
     @ s x 9 7 * + cells +
     @ = AND OR s x cells +
     @ 0 <> s x cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 + cells +
     @ 0 <> s x 9 + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 2 * + cells +
     @ 0 <> s x 9 2 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 3 * + cells +
     @ 0 <> s x 9 3 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 4 * + cells +
     @ 0 <> s x 9 4 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 5 * + cells +
     @ 0 <> s x 9 5 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 6 * + cells +
     @ 0 <> s x 9 6 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR s x 9 7 * + cells +
     @ 0 <> s x 9 7 * + cells +
     @ s x 9 8 * + cells +
     @ = AND OR TO out1
   1 + REPEAT 2DROP
  false { out2 }
  8 0 BEGIN 2dup >= WHILE DUP { x }
    out2 s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 1 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 2 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 2 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 3 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 3 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 3 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 4 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 4 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 4 + cells +
     @ = AND OR s x 9 * 3 + cells +
     @ 0 <> s x 9 * 3 + cells +
     @ s x 9 * 4 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 5 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 5 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 5 + cells +
     @ = AND OR s x 9 * 3 + cells +
     @ 0 <> s x 9 * 3 + cells +
     @ s x 9 * 5 + cells +
     @ = AND OR s x 9 * 4 + cells +
     @ 0 <> s x 9 * 4 + cells +
     @ s x 9 * 5 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * 3 + cells +
     @ 0 <> s x 9 * 3 + cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * 4 + cells +
     @ 0 <> s x 9 * 4 + cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * 5 + cells +
     @ 0 <> s x 9 * 5 + cells +
     @ s x 9 * 6 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 3 + cells +
     @ 0 <> s x 9 * 3 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 4 + cells +
     @ 0 <> s x 9 * 4 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 5 + cells +
     @ 0 <> s x 9 * 5 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * 6 + cells +
     @ 0 <> s x 9 * 6 + cells +
     @ s x 9 * 7 + cells +
     @ = AND OR s x 9 * cells +
     @ 0 <> s x 9 * cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 1 + cells +
     @ 0 <> s x 9 * 1 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 2 + cells +
     @ 0 <> s x 9 * 2 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 3 + cells +
     @ 0 <> s x 9 * 3 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 4 + cells +
     @ 0 <> s x 9 * 4 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 5 + cells +
     @ 0 <> s x 9 * 5 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 6 + cells +
     @ 0 <> s x 9 * 6 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR s x 9 * 7 + cells +
     @ 0 <> s x 9 * 7 + cells +
     @ s x 9 * 8 + cells +
     @ = AND OR TO out2
   1 + REPEAT 2DROP
  false { out3 }
  8 0 BEGIN 2dup >= WHILE DUP { x }
    out3 s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ 0 <> s x 3 % 3 * 1 + 9 * x 3 // 3 * + 2 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ 0 <> s x 3 % 3 * 2 + 9 * x 3 // 3 * + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ 0 <> s x 3 % 3 * 2 + 9 * x 3 // 3 * + 1 + cells +
     @ s x 3 % 3 * 2 + 9 * x 3 // 3 * + 2 + cells +
     @ = AND OR TO out3
   1 + REPEAT 2DROP
  out1 out2 OR out3 OR exit
;

\  résout le sudoku

: solve recursive { sudoku0 }
  sudoku0 sudoku_error
  IF
    false exit
  THEN
  sudoku0 sudoku_done
  IF
    true exit
  THEN
  80 0 BEGIN 2dup >= WHILE DUP { i }
    sudoku0 i cells +
     @ 0 =
    IF
      9 1 BEGIN 2dup >= WHILE DUP { p }
        p sudoku0 i cells +
         !
        sudoku0 solve
        IF
          DROP DROP DROP DROP true exit
        THEN
       1 + REPEAT 2DROP
      0 sudoku0 i cells +
       !
      DROP DROP false exit
    THEN
   1 + REPEAT 2DROP
  false exit
;

: main
   read_sudoku { sudoku0 }
  sudoku0 print_sudoku
  sudoku0 solve
  IF
    sudoku0 print_sudoku
  ELSE
    S\" no solution\n" TYPE
  THEN
  ;
main
BYE

