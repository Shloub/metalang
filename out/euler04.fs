

: // { a b }
  a b /
  a 0 < b 0 < XOR IF 1 + THEN
;

: % { a b }
  a b MOD
  a 0 < b 0 < XOR IF b - THEN
 ;


VARIABLE buffer-index
1000 buffer-index !
VARIABLE NEOF
1 NEOF !
VARIABLE buffer-max
0 buffer-max !
create bufferc 128 allot

: next-char
  buffer-index @ 1 + buffer-index !
  buffer-index @ buffer-max @ > IF
    0 buffer-index !
    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !
    10 bufferc buffer-max @ + !
  THEN
;

: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;

: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT
;

: read-int
  [char] - current-char = IF
    -1
    next-char
  ELSE 1
  THEN
  0
  BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT
  *
;

: read-char current-char next-char ;


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
  NEWLINE TYPE
  ;
main
BYE

