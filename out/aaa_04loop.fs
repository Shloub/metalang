

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



: h { i }
  \   for j = i - 2 to i + 2 do
  \     if i % j == 5 then return true end
  \   end 
  
  i 2 - { j }
  BEGIN
    j i 2 + <=
  WHILE
    i j % 5 =
    IF
      true exit
    THEN
    j 1 + TO j
  REPEAT
  false exit
;

: main
  0 { j }
  10 0 BEGIN 2dup >= WHILE DUP { k }
    j k + TO j
    j s>d 0 d.r
    NEWLINE TYPE
   1 + REPEAT 2DROP
  4 { i }
  BEGIN
    i 10 <
  WHILE
    i s>d 0 d.r
    i 1 + TO i
    j i + TO j
  REPEAT
  j s>d 0 d.r
  i s>d 0 d.r
   s" FIN TEST" NEWLINE S+ TYPE
  ;
main
BYE

