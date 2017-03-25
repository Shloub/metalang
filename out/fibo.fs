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
\ La suite de fibonaci
\ 

: fibo0 { a b i }
  0 { out0 }
  a { a2 }
  b { b2 }
  i 1 + 0 BEGIN 2dup >= WHILE DUP { j }
    out0 a2 + TO out0
    b2 { tmp }
    b2 a2 + TO b2
    tmp TO a2
   1 + REPEAT 2DROP
  out0 exit
;

: main
  read-int { a }
  skipspaces
  read-int { b }
  skipspaces
  read-int { i }
  a b i fibo0 s>d 0 d.r
  ;
main
BYE

