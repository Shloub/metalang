

: // { a b }
  a b /
  a 0 < b 0 < XOR IF 1 + THEN
;

: % { a b }
  a b MOD
  a 0 < b 0 < XOR IF b - THEN
 ;


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
  THEN
;

: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;

: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT
;

: read-int
  [char] - current-char = IF
    -1
    next-char
  ELSE 1
  THEN
  0
  BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT
  *
;

: read-char current-char next-char ;



: main
  10 { n }
  \  normalement on doit mettre 20 mais là on se tape un overflow 
  
  n 1 + TO n
  HERE n cells allot { tab }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE n cells allot { tab2 }
    n 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 tab2 j cells + !
     1 + REPEAT 2DROP
    tab2 tab i cells + !
   1 + REPEAT 2DROP
  n 1 - 0 BEGIN 2dup >= WHILE DUP { l }
    1 tab n 1 - cells + @ l cells + !
    1 tab l cells + @ n 1 - cells + !
   1 + REPEAT 2DROP
  n 2 BEGIN 2dup >= WHILE DUP { o }
    n o - { r }
    n 2 BEGIN 2dup >= WHILE DUP { p }
      n p - { q }
      tab r 1 + cells + @ q cells + @ tab r cells + @ q 1 + cells + @ + tab r cells + @ q cells + !
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  n 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    n 1 - 0 BEGIN 2dup >= WHILE DUP { k }
      tab m cells + @ k cells + @ s>d 0 d.r
       s"  " TYPE
     1 + REPEAT 2DROP
    NEWLINE TYPE
   1 + REPEAT 2DROP
  tab 0 cells + @ 0 cells + @ s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

