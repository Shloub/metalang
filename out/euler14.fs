: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: next0 { n }
  n 2 % 0 =
  IF
    n 2 // exit
  ELSE
    3 n * 1 + exit
  THEN
;


: find0 recursive { n m }
  n 1 =
  IF
    1 exit
  ELSE
    n 1000000 >=
    IF
      1 n next0 m find0 + exit
    ELSE
      m  n cells +  @ 0 <>
      IF
        m  n cells +  @ exit
      ELSE
        1 n next0 m find0 + m  n cells +  !
        m  n cells +  @ exit
      THEN
    THEN
  THEN
;

: main
  HERE 1000000 cells allot { m }
  999999 0 BEGIN 2dup >= WHILE DUP { j }
    0 m  j cells +  !
   1 + REPEAT 2DROP
  0 { max0 }
  0 { maxi }
  999 1 BEGIN 2dup >= WHILE DUP { i }
    \  normalement on met 999999 mais ça dépasse les int32... 
    
    i m find0 { n2 }
    n2 max0 >
    IF
      n2 TO max0
      i TO maxi
    THEN
   1 + REPEAT 2DROP
  max0 s>d 0 d.r
  S\" \n" TYPE
  maxi s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

