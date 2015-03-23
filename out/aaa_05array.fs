: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: id { b }
  b exit
;

: g { t index }
  false t index cells + !
;

: main
  0 { j }
  HERE 5 cells allot { a }
  5 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i s>d 0 d.r
    j i + TO j
    i 2 % 0 = a i cells + !
   1 + REPEAT 2DROP
  j s>d 0 d.r
   s"  " TYPE
  a 0 cells + @ { c }
  c
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  NEWLINE TYPE
  a id 0 g
  a 0 cells + @ { d }
  d
  IF
     s" True" TYPE
  ELSE
     s" False" TYPE
  THEN
  NEWLINE TYPE
  ;
main
BYE

