

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
  \ 
  \ 	a + b + c = 1000 && a * a + b * b = c * c
  \ 	
  
  1000 1 BEGIN 2dup >= WHILE DUP { a }
    1000 a 1 + BEGIN 2dup >= WHILE DUP { b }
      1000 a - b - { c }
      a a * b b * + { a2b2 }
      c c * { cc }
      cc a2b2 = c a > AND
      IF
        a s>d 0 d.r
        NEWLINE TYPE
        b s>d 0 d.r
        NEWLINE TYPE
        c s>d 0 d.r
        NEWLINE TYPE
        a b * c * s>d 0 d.r
        NEWLINE TYPE
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  ;
main
BYE

