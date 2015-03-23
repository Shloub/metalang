: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: pgcd recursive { a b }
  a b min { c }
  a b max { d }
  d c % { reste }
  reste 0 =
  IF
    c exit
  ELSE
    c reste pgcd exit
  THEN
;

: main
  1 { top }
  1 { bottom }
  9 1 BEGIN 2dup >= WHILE DUP { i }
    9 1 BEGIN 2dup >= WHILE DUP { j }
      9 1 BEGIN 2dup >= WHILE DUP { k }
        i j <> j k <> AND
        IF
          i 10 * j + { a }
          j 10 * k + { b }
          a k * i b * =
          IF
            a s>d 0 d.r
             s" /" TYPE
            b s>d 0 d.r
            NEWLINE TYPE
            top a * TO top
            bottom b * TO bottom
          THEN
        THEN
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  top s>d 0 d.r
   s" /" TYPE
  bottom s>d 0 d.r
  NEWLINE TYPE
  top bottom pgcd { p }
   s" pgcd=" TYPE
  p s>d 0 d.r
  NEWLINE TYPE
  bottom p // s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

