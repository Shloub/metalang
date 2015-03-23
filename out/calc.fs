\ 
\ La suite de fibonaci
\ 

: fibo { a b i }
  0 { out_ }
  a { a2 }
  b { b2 }
  i 1 + 0 BEGIN 2dup >= WHILE DUP { j }
    j s>d 0 d.r
    out_ a2 + TO out_
    b2 { tmp }
    b2 a2 + TO b2
    tmp TO a2
   1 + REPEAT 2DROP
  out_ exit
;

: main
  1 2 4 fibo s>d 0 d.r
  ;
main
BYE

