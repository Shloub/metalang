: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: is_pair { i }
  1 { j }
  i 10 <
  IF
    2 TO j
    i 0 =
    IF
      4 TO j
      true exit
    THEN
    3 TO j
    i 2 =
    IF
      4 TO j
      true exit
    THEN
    5 TO j
  THEN
  6 TO j
  i 20 <
  IF
    i 22 =
    IF
      0 TO j
    THEN
    8 TO j
  THEN
  i 2 % 0 = exit
;

: main
  
  ;
main
BYE

