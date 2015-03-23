

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
  1 { maximum }
  2 { b0 }
  408464633 { a }
  a s>f fsqrt f>s { sqrtia }
  BEGIN
    a 1 <>
  WHILE
    b0 { b }
    false { found }
    BEGIN
      b sqrtia <=
    WHILE
      a b % 0 =
      IF
        a b // TO a
        b TO b0
        a TO b
        a s>f fsqrt f>s TO sqrtia
        true TO found
      THEN
      b 1 + TO b
    REPEAT
    found INVERT
    IF
      a s>d 0 d.r
      NEWLINE TYPE
      1 TO a
    THEN
  REPEAT
  ;
main
BYE

