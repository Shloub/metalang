: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
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

