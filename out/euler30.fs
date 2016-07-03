: main
  \ 
  \ a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  \   a ^ 5 +
  \   b ^ 5 +
  \   c ^ 5 +
  \   d ^ 5 +
  \   e ^ 5
  \ 
  
  HERE 10 cells allot { p }
  9 0 BEGIN 2dup >= WHILE DUP { i }
    i i * i * i * i * p  i cells +  !
   1 + REPEAT 2DROP
  0 { sum }
  9 0 BEGIN 2dup >= WHILE DUP { a }
    9 0 BEGIN 2dup >= WHILE DUP { b }
      9 0 BEGIN 2dup >= WHILE DUP { c }
        9 0 BEGIN 2dup >= WHILE DUP { d }
          9 0 BEGIN 2dup >= WHILE DUP { e }
            9 0 BEGIN 2dup >= WHILE DUP { f }
              p  a cells +  @ p  b cells +  @ + p  c cells +  @ + p  d cells +  @ + p  e cells +  @ + p  f cells +  @ +
              { s }
              a b 10 * + c 100 * + d 1000 * + e 10000 * + f 100000 * + { r }
              s r = r 1 <> AND
              IF
                f s>d 0 d.r
                e s>d 0 d.r
                d s>d 0 d.r
                c s>d 0 d.r
                b s>d 0 d.r
                a s>d 0 d.r
                S"  " TYPE
                r s>d 0 d.r
                S\" \n" TYPE
                sum r + TO sum
              THEN
             1 + REPEAT 2DROP
           1 + REPEAT 2DROP
         1 + REPEAT 2DROP
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  sum s>d 0 d.r
  ;
main
BYE

