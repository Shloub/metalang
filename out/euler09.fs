: main
  \ 
  \ 	a + b + c = 1000 && a * a + b * b = c * c
  \ 	
  
  1000 1 BEGIN 2dup >= WHILE DUP { a }
    1000 a 1 + BEGIN 2dup >= WHILE DUP { b }
      1000 a - b - { c }
      a a * b b * + { a2b2 }
      c c * { cc }
      cc a2b2 = c a > AND
      IF
        a s>d 0 d.r
        S\" \n" TYPE
        b s>d 0 d.r
        S\" \n" TYPE
        c s>d 0 d.r
        S\" \n" TYPE
        a b * c * s>d 0 d.r
        S\" \n" TYPE
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  ;
main
BYE

