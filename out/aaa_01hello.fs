

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
   s" Hello World" TYPE
  5 { a }
  4 6 + 2 * s>d 0 d.r
   s"  " TYPE
  NEWLINE TYPE
  a s>d 0 d.r
   s" foo" TYPE
  S" " TYPE
  1 1 1 + 2 * 3 8 + * 4 // + 1 2 - - 3 - 12 = true AND { b }
  b
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  NEWLINE TYPE
  3 4 5 + 6 + * 2 * 45 = false = { c }
  c
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  4 1 + 3 // 2 1 + // s>d 0 d.r
  4 1 * 3 // 2 1 * // s>d 0 d.r
  a 0 = INVERT a 4 = INVERT AND INVERT { d }
  d
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  true false INVERT AND true false AND INVERT AND { e }
  e
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  NEWLINE TYPE
  ;
main
BYE

