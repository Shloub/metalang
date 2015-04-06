: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: g { i }
  i 4 * { j }
  j 2 % 1 =
  IF
    0 exit
  THEN
  j exit
;

: h { i }
  i s>d 0 d.r
  S\" \n" TYPE
;

: main
  14 h
  4 { a }
  5 { b }
  a b + s>d 0 d.r
  \  main 
  
  15 h
  2 TO a
  1 TO b
  a b + s>d 0 d.r
  ;
main
BYE

