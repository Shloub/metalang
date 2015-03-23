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

: result { t }
  t ->blah @ 1 + t ->blah !
  t ->foo @ t ->blah @ t ->bar @ * + t ->bar @ t ->foo @ * + exit
;

: main
  4 mktoto { t }
  read-int t ->bar !
  skipspaces
  read-int t ->blah !
  t result s>d 0 d.r
  ;
main
BYE

