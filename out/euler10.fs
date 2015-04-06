: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: eratostene { t max0 }
  0 { sum }
  max0 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    t i cells +
     @ i =
    IF
      sum i + TO sum
      max0 i // i >
      IF
        i i * { j }
        BEGIN
          j max0 < j 0 > AND
        WHILE
          0 t j cells +
           !
          j i + TO j
        REPEAT
      THEN
    THEN
   1 + REPEAT 2DROP
  sum exit
;

: main
  100000 { n }
  \  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
  
  HERE n cells allot { t }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i t i cells +
     !
   1 + REPEAT 2DROP
  0 t 1 cells +
   !
  t n eratostene s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

