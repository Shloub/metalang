: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: divisible { n t size }
  size 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    n t i cells +
     @ % 0 =
    IF
      DROP DROP true exit
    THEN
   1 + REPEAT 2DROP
  false exit
;

: find0 { n t used nth }
  BEGIN
    used nth <>
  WHILE
    n t used divisible
    IF
      n 1 + TO n
    ELSE
      n t used cells +
       !
      n 1 + TO n
      used 1 + TO used
    THEN
  REPEAT
  t used 1 - cells +
   @ exit
;

: main
  10001 { n }
  HERE n cells allot { t }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    2 t i cells +
     !
   1 + REPEAT 2DROP
  3 t 1 n find0 s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

