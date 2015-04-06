: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
\ 
\ 
\ (a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
\ a * d + a * e * 10 + a * f * 100 +
\ 10 * (b * d + b * e * 10 + b * f * 100)+
\ 100 * (c * d + c * e * 10 + c * f * 100) =
\ 
\ a * d       + a * e * 10   + a * f * 100 +
\ b * d * 10  + b * e * 100  + b * f * 1000 +
\ c * d * 100 + c * e * 1000 + c * f * 10000 =
\ 
\ a * d +
\ 10 * ( a * e + b * d) +
\ 100 * (a * f + b * e + c * d) +
\ (c * e + b * f) * 1000 +
\ c * f * 10000
\ 
\ 

: chiffre recursive { c m }
  c 0 =
  IF
    m 10 % exit
  ELSE
    c 1 - m 10 // chiffre exit
  THEN
;

: main
  1 { m }
  9 0 BEGIN 2dup >= WHILE DUP { a }
    9 1 BEGIN 2dup >= WHILE DUP { f }
      9 0 BEGIN 2dup >= WHILE DUP { d }
        9 1 BEGIN 2dup >= WHILE DUP { c }
          9 0 BEGIN 2dup >= WHILE DUP { b }
            9 0 BEGIN 2dup >= WHILE DUP { e }
              a d * 10 a e * b d * + * + 100 a f * b e * + c d * + * + 1000 c e * b f * + * + 10000 c * f * +
              { mul }
              0 mul chiffre 5 mul chiffre = 1 mul chiffre 4 mul chiffre = AND 2 mul chiffre 
              3 mul chiffre = AND
              IF
                mul m max TO m
              THEN
             1 + REPEAT 2DROP
           1 + REPEAT 2DROP
         1 + REPEAT 2DROP
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  m s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

