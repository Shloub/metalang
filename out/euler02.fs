: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: main
  1 { a }
  2 { b }
  0 { sum }
  BEGIN
    a 4000000 <
  WHILE
    a 2 % 0 =
    IF
      sum a + TO sum
    THEN
    a { c }
    b TO a
    b c + TO b
  REPEAT
  sum s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

