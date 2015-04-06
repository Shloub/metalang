: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: palindrome2 { pow2 n }
  HERE 20 cells allot { t }
  20 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    n pow2 i cells +
     @ // 2 % 1 = t i cells +
     !
   1 + REPEAT 2DROP
  0 { nnum }
  19 1 BEGIN 2dup >= WHILE DUP { j }
    t j cells +
     @
    IF
      j TO nnum
    THEN
   1 + REPEAT 2DROP
  nnum 2 // 0 BEGIN 2dup >= WHILE DUP { k }
    t k cells +
     @ t nnum k - cells +
     @ <>
    IF
      DROP DROP false exit
    THEN
   1 + REPEAT 2DROP
  true exit
;

: main
  1 { p }
  HERE 20 cells allot { pow2 }
  20 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    p 2 * TO p
    p 2 // pow2 i cells +
     !
   1 + REPEAT 2DROP
  0 { sum }
  9 1 BEGIN 2dup >= WHILE DUP { d }
    pow2 d palindrome2
    IF
      d s>d 0 d.r
      S\" \n" TYPE
      sum d + TO sum
    THEN
    pow2 d 10 * d + palindrome2
    IF
      d 10 * d + s>d 0 d.r
      S\" \n" TYPE
      sum d 10 * d + + TO sum
    THEN
   1 + REPEAT 2DROP
  4 0 BEGIN 2dup >= WHILE DUP { a0 }
    a0 2 * 1 + { a }
    9 0 BEGIN 2dup >= WHILE DUP { b }
      9 0 BEGIN 2dup >= WHILE DUP { c }
        a 100000 * b 10000 * + c 1000 * + c 100 * + b 10 * + a + { num0 }
        pow2 num0 palindrome2
        IF
          num0 s>d 0 d.r
          S\" \n" TYPE
          sum num0 + TO sum
        THEN
        a 10000 * b 1000 * + c 100 * + b 10 * + a + { num1 }
        pow2 num1 palindrome2
        IF
          num1 s>d 0 d.r
          S\" \n" TYPE
          sum num1 + TO sum
        THEN
       1 + REPEAT 2DROP
      a 100 * b 10 * + a + { num2 }
      pow2 num2 palindrome2
      IF
        num2 s>d 0 d.r
        S\" \n" TYPE
        sum num2 + TO sum
      THEN
      a 1000 * b 100 * + b 10 * + a + { num3 }
      pow2 num3 palindrome2
      IF
        num3 s>d 0 d.r
        S\" \n" TYPE
        sum num3 + TO sum
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  S" sum=" TYPE
  sum s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

