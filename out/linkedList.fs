

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
  cell% field ->head
  cell% field ->tail
end-struct intlist%

: cons { list i }
  intlist% %allot { out0 }
  i out0 ->head !
  list out0 ->tail !
  out0 exit
;

: rev2 recursive { empty acc torev }
  torev empty =
  IF
    acc exit
  ELSE
    intlist% %allot { acc2 }
    torev ->head @ acc2 ->head !
    acc acc2 ->tail !
    empty acc torev ->tail @ rev2 exit
  THEN
;

: rev { empty torev }
  empty empty torev rev2 exit
;

: test { empty }
  empty { list }
  1 NEGATE { i }
  BEGIN
    i 0 <>
  WHILE
    read-int TO i
    i 0 <>
    IF
      list i cons TO list
    THEN
  REPEAT
;

: main
  
  ;
main
BYE

