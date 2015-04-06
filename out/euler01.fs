: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: main
  0 { sum }
  999 0 BEGIN 2dup >= WHILE DUP { i }
    i 3 % 0 = i 5 % 0 = OR
    IF
      sum i + TO sum
    THEN
   1 + REPEAT 2DROP
  sum s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

