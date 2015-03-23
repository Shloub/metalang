: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: periode { restes len a b }
  BEGIN
    a 0 <>
  WHILE
    a b // { chiffre }
    a b % { reste }
    len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
      restes i cells + @ reste =
      IF
        DROP DROP len i - exit
      THEN
     1 + REPEAT 2DROP
    reste restes len cells + !
    len 1 + TO len
    reste 10 * TO a
  REPEAT
  0 exit
;

: main
  HERE 1000 cells allot { t }
  1000 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    0 t j cells + !
   1 + REPEAT 2DROP
  0 { m }
  0 { mi }
  1000 1 BEGIN 2dup >= WHILE DUP { i }
    t 0 1 i periode { p }
    p m >
    IF
      i TO mi
      p TO m
    THEN
   1 + REPEAT 2DROP
  mi s>d 0 d.r
  NEWLINE TYPE
  m s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

