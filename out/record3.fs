

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



struct
  cell% field ->foo
  cell% field ->bar
  cell% field ->blah
end-struct toto%

: mktoto { v1 }
  toto% %allot { t }
  v1 t ->foo !
  0 t ->bar !
  0 t ->blah !
  t exit
;

: result { t len }
  0 { out0 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    t j cells + @ ->blah @ 1 + t j cells + @ ->blah !
    out0 t j cells + @ ->foo @ + t j cells + @ ->blah @ t j cells + @ ->bar @ * + t j cells + @ ->bar @ t j cells + @ ->foo @ * + TO out0
   1 + REPEAT 2DROP
  out0 exit
;

: main
  HERE 4 cells allot { t }
  4 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i mktoto t i cells + !
   1 + REPEAT 2DROP
  read-int t 0 cells + @ ->bar !
  skipspaces
  read-int t 1 cells + @ ->blah !
  t 4 result { titi }
  titi s>d 0 d.r
  t 2 cells + @ ->blah @ s>d 0 d.r
  ;
main
BYE

