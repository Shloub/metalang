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
\ 
\ Tictactoe : un tictactoe avec une IA
\ 

\  La structure de donnée 

struct
  cell% field ->cases
  cell% field ->firstToPlay
  cell% field ->note
  cell% field ->ended
end-struct gamestate%

\  Un Mouvement 

struct
  cell% field ->x
  cell% field ->y
end-struct move%

\  On affiche l'état 

: print_state { g }
  S\" \n|" TYPE
  2 0 BEGIN 2dup >= WHILE DUP { y }
    2 0 BEGIN 2dup >= WHILE DUP { x }
      g ->cases @  x cells +  @  y cells +  @ 0 =
      IF
        S"  " TYPE
      ELSE
        g ->cases @  x cells +  @  y cells +  @ 1 =
        IF
          S" O" TYPE
        ELSE
          S" X" TYPE
        THEN
      THEN
      S" |" TYPE
     1 + REPEAT 2DROP
    y 2 <>
    IF
      S\" \n|-|-|-|\n|" TYPE
    THEN
   1 + REPEAT 2DROP
  S\" \n" TYPE
;

\  On dit qui gagne (info stoquées dans g.ended et g.note ) 

: eval0 { g }
  0 { win }
  0 { freecase }
  2 0 BEGIN 2dup >= WHILE DUP { y }
    1 NEGATE { col }
    1 NEGATE { lin }
    2 0 BEGIN 2dup >= WHILE DUP { x }
      g ->cases @  x cells +  @  y cells +  @ 0 =
      IF
        freecase 1 + TO freecase
      THEN
      g ->cases @  x cells +  @  y cells +  @ { colv }
      g ->cases @  y cells +  @  x cells +  @ { linv }
      col 1 NEGATE = colv 0 <> AND
      IF
        colv TO col
      ELSE
        colv col <>
        IF
          2 NEGATE TO col
        THEN
      THEN
      lin 1 NEGATE = linv 0 <> AND
      IF
        linv TO lin
      ELSE
        linv lin <>
        IF
          2 NEGATE TO lin
        THEN
      THEN
     1 + REPEAT 2DROP
    col 0 >=
    IF
      col TO win
    ELSE
      lin 0 >=
      IF
        lin TO win
      THEN
    THEN
   1 + REPEAT 2DROP
  2 1 BEGIN 2dup >= WHILE DUP { x }
    g ->cases @  0 cells +  @  0 cells +  @ x = g ->cases @  1 cells +  @  1 cells +  @ x = AND g ->cases @  2 cells +  @  2 cells +  @ x = AND
    IF
      x TO win
    THEN
    g ->cases @  0 cells +  @  2 cells +  @ x = g ->cases @  1 cells +  @  1 cells +  @ x = AND g ->cases @  2 cells +  @  0 cells +  @ x = AND
    IF
      x TO win
    THEN
   1 + REPEAT 2DROP
  win 0 <> freecase 0 = OR g ->ended !
  win 1 =
  IF
    1000 g ->note !
  ELSE
    win 2 =
    IF
      1000 NEGATE g ->note !
    ELSE
      0 g ->note !
    THEN
  THEN
;

\  On applique un mouvement 

: apply_move_xy { x y g }
  2 { player }
  g ->firstToPlay @
  IF
    1 TO player
  THEN
  player g ->cases @  x cells +  @  y cells +  !
  g ->firstToPlay @ INVERT g ->firstToPlay !
;

: apply_move { m g }
  m ->x @ m ->y @ g apply_move_xy
;

: cancel_move_xy { x y g }
  0 g ->cases @  x cells +  @  y cells +  !
  g ->firstToPlay @ INVERT g ->firstToPlay !
  false g ->ended !
;

: cancel_move { m g }
  m ->x @ m ->y @ g cancel_move_xy
;

: can_move_xy { x y g }
  g ->cases @  x cells +  @  y cells +  @ 0 = exit
;

: can_move { m g }
  m ->x @ m ->y @ g can_move_xy exit
;

\ 
\ Un minimax classique, renvoie la note du plateau
\ 

: minmax recursive { g }
  g eval0
  g ->ended @
  IF
    g ->note @ exit
  THEN
  10000 NEGATE { maxNote }
  g ->firstToPlay @ INVERT
  IF
    10000 TO maxNote
  THEN
  2 0 BEGIN 2dup >= WHILE DUP { x }
    2 0 BEGIN 2dup >= WHILE DUP { y }
      x y g can_move_xy
      IF
        x y g apply_move_xy
        g minmax { currentNote }
        x y g cancel_move_xy
        \  Minimum ou Maximum selon le coté ou l'on joue
        
        currentNote maxNote > g ->firstToPlay @ =
        IF
          currentNote TO maxNote
        THEN
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  maxNote exit
;

\ 
\ Renvoie le coup de l'IA
\ 

: play { g }
  move% %allot { minMove }
  0 minMove ->x !
  0 minMove ->y !
  10000 { minNote }
  2 0 BEGIN 2dup >= WHILE DUP { x }
    2 0 BEGIN 2dup >= WHILE DUP { y }
      x y g can_move_xy
      IF
        x y g apply_move_xy
        g minmax { currentNote }
        x s>d 0 d.r
        S" , " TYPE
        y s>d 0 d.r
        S" , " TYPE
        currentNote s>d 0 d.r
        S\" \n" TYPE
        x y g cancel_move_xy
        currentNote minNote <
        IF
          currentNote TO minNote
          x minMove ->x !
          y minMove ->y !
        THEN
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  minMove ->x @ s>d 0 d.r
  minMove ->y @ s>d 0 d.r
  S\" \n" TYPE
  minMove exit
;

: init0 {  }
  HERE 3 cells allot { cases }
  3 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE 3 cells allot { tab }
    3 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 tab  j cells +  !
     1 + REPEAT 2DROP
    tab cases  i cells +  !
   1 + REPEAT 2DROP
  gamestate% %allot { a }
  cases a ->cases !
  true a ->firstToPlay !
  0 a ->note !
  false a ->ended !
  a exit
;

: read_move {  }
  read-int { x }
  skipspaces
  read-int { y }
  skipspaces
  move% %allot { b }
  x b ->x !
  y b ->y !
  b exit
;

: main
  1 0 BEGIN 2dup >= WHILE DUP { i }
     init0 { state }
    move% %allot { c }
    1 c ->x !
    1 c ->y !
    c state apply_move
    move% %allot { d }
    0 d ->x !
    0 d ->y !
    d state apply_move
    BEGIN
      state ->ended @ INVERT
    WHILE
      state print_state
      state play state apply_move
      state eval0
      state print_state
      state ->ended @ INVERT
      IF
        state play state apply_move
        state eval0
      THEN
    REPEAT
    state print_state
    state ->note @ s>d 0 d.r
    S\" \n" TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

