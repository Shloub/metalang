: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
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
      S\" \n" TYPE
      1 TO a
    THEN
  REPEAT
  ;
main
BYE

