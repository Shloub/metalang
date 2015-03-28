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
: pathfind_aux recursive { cache tab len pos }
  pos len 1 - >=
  IF
    0 exit
  ELSE
    cache pos cells +
     @ 1 NEGATE <>
    IF
      cache pos cells +
       @ exit
    ELSE
      len 2 * cache pos cells +
       !
      cache tab len tab pos cells +
       @ pathfind_aux { posval }
      cache tab len pos 1 + pathfind_aux { oneval }
      0 { out0 }
      posval oneval <
      IF
        1 posval + TO out0
      ELSE
        1 oneval + TO out0
      THEN
      out0 cache pos cells +
       !
      out0 exit
    THEN
  THEN
;

: pathfind { tab len }
  HERE len cells allot { cache }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    1 NEGATE cache i cells +
     !
   1 + REPEAT 2DROP
  cache tab len 0 pathfind_aux exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { tmp }
    read-int TO tmp
    skipspaces
    tmp tab i cells +
     !
   1 + REPEAT 2DROP
  tab len pathfind { result }
  result s>d 0 d.r
  ;
main
BYE

