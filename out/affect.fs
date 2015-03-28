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
\ Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
\ 

struct
  cell% field ->foo
  cell% field ->bar
  cell% field ->blah
end-struct toto%

: mktoto { v1 }
  toto% %allot { t }
  v1 t ->foo !
  v1 t ->bar !
  v1 t ->blah !
  t exit
;

: mktoto2 { v1 }
  toto% %allot { t }
  v1 3 + t ->foo !
  v1 2 + t ->bar !
  v1 1 + t ->blah !
  t exit
;

: result { t_ t2_ }
  t_ { t }
  t2_ { t2 }
  toto% %allot { t3 }
  0 t3 ->foo !
  0 t3 ->bar !
  0 t3 ->blah !
  t2 TO t3
  t2 TO t
  t3 TO t2
  t ->blah @ 1 + t ->blah !
  1 { len }
  HERE len cells allot { cache0 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i NEGATE cache0 i cells +
     !
   1 + REPEAT 2DROP
  HERE len cells allot { cache1 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    j cache1 j cells +
     !
   1 + REPEAT 2DROP
  cache0 { cache2 }
  cache1 TO cache0
  cache0 TO cache2
  t ->foo @ t ->blah @ t ->bar @ * + t ->bar @ t ->foo @ * + exit
;

: main
  4 mktoto { t }
  5 mktoto { t2 }
  read-int t ->bar !
  skipspaces
  read-int t ->blah !
  skipspaces
  read-int t2 ->bar !
  skipspaces
  read-int t2 ->blah !
  t t2 result s>d 0 d.r
  t ->blah @ s>d 0 d.r
  ;
main
BYE

