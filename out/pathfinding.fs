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
: pathfind_aux recursive { cache tab x y posX posY }
  posX x 1 - = posY y 1 - = AND
  IF
    0 exit
  ELSE
    posX 0 < posY 0 < OR posX x >= OR posY y >= OR
    IF
      x y * 10 * exit
    ELSE
      tab  posY cells +  @  posX cells +  @ 35 =
      IF
        x y * 10 * exit
      ELSE
        cache  posY cells +  @  posX cells +  @ 1 NEGATE <>
        IF
          cache  posY cells +  @  posX cells +  @ exit
        ELSE
          x y * 10 * cache  posY cells +  @  posX cells +  !
          cache tab x y posX 1 + posY pathfind_aux { val1 }
          cache tab x y posX 1 - posY pathfind_aux { val2 }
          cache tab x y posX posY 1 - pathfind_aux { val3 }
          cache tab x y posX posY 1 + pathfind_aux { val4 }
          1 val1 val2 min val3 min val4 min + { out0 }
          out0 cache  posY cells +  @  posX cells +  !
          out0 exit
        THEN
      THEN
    THEN
  THEN
;

: pathfind { tab x y }
  HERE y cells allot { cache }
  y 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE x cells allot { tmp }
    x 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      1 NEGATE tmp  j cells +  !
     1 + REPEAT 2DROP
    tmp cache  i cells +  !
   1 + REPEAT 2DROP
  cache tab x y 0 0 pathfind_aux exit
;

: main
  0 { x }
  0 { y }
  read-int TO x
  skipspaces
  read-int TO y
  skipspaces
  HERE y cells allot { tab }
  y 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE x cells allot { tab2 }
    x 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 { tmp }
      read-char TO tmp
      tmp tab2  j cells +  !
     1 + REPEAT 2DROP
    skipspaces
    tab2 tab  i cells +  !
   1 + REPEAT 2DROP
  tab x y pathfind { result }
  result s>d 0 d.r
  ;
main
BYE

