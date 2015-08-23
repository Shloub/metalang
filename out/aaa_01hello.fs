: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: main
  S" Hello World" TYPE
  5 { a }
  4 6 + 2 * s>d 0 d.r
  S\"  \n" TYPE
  a s>d 0 d.r
  S" foo" TYPE
  1 1 1 + 2 * 3 8 + * 4 // + 1 2 - - 3 - 12 = true AND
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  S\" \n" TYPE
  3 4 5 + 6 + * 2 * 45 = false =
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  S"  " TYPE
  2 1 = false =
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  S"  " TYPE
  4 1 + 3 // 2 1 + // s>d 0 d.r
  4 1 * 3 // 2 1 * // s>d 0 d.r
  a 0 = INVERT a 4 = INVERT AND INVERT
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  true false INVERT AND true false AND INVERT AND
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  S\" \n" TYPE
  ;
main
BYE

