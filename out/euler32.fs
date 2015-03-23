

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
\ We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
\ for example, the 5-digit number, 15234, is 1 through 5 pandigital.
\ 
\ The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
\ and product is 1 through 9 pandigital.
\ 
\ Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
\ 1 through 9 pandigital.
\ 
\ HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
\ 
\ 
\ (a * 10 + b) ( c * 100 + d * 10 + e) =
\   a * c * 1000 +
\   a * d * 100 +
\   a * e * 10 +
\   b * c * 100 +
\   b * d * 10 +
\   b * e
\   => b != e != b * e % 10 ET
\   a != d != (b * e / 10 + b * d + a * e ) % 10
\ 

: okdigits recursive { ok n }
  n 0 =
  IF
    true exit
  ELSE
    n 10 % { digit }
    ok digit cells + @
    IF
      false ok digit cells + !
      ok n 10 // okdigits { o }
      true ok digit cells + !
      o exit
    ELSE
      false exit
    THEN
  THEN
;

: main
  0 { count }
  HERE 10 cells allot { allowed }
  10 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i 0 <> allowed i cells + !
   1 + REPEAT 2DROP
  HERE 100000 cells allot { counted }
  100000 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    false counted j cells + !
   1 + REPEAT 2DROP
  9 1 BEGIN 2dup >= WHILE DUP { e }
    false allowed e cells + !
    9 1 BEGIN 2dup >= WHILE DUP { b }
      allowed b cells + @
      IF
        false allowed b cells + !
        b e * 10 % { be }
        allowed be cells + @
        IF
          false allowed be cells + !
          9 1 BEGIN 2dup >= WHILE DUP { a }
            allowed a cells + @
            IF
              false allowed a cells + !
              9 1 BEGIN 2dup >= WHILE DUP { c }
                allowed c cells + @
                IF
                  false allowed c cells + !
                  9 1 BEGIN 2dup >= WHILE DUP { d }
                    allowed d cells + @
                    IF
                      false allowed d cells + !
                      \  2 * 3 digits 
                      
                      a 10 * b + c 100 * d 10 * + e + * { product }
                      counted product cells + @ INVERT allowed product 10 // okdigits AND
                      IF
                        true counted product cells + !
                        count product + TO count
                        product s>d 0 d.r
                         s"  " TYPE
                      THEN
                      \  1  * 4 digits 
                      
                      b a 1000 * c 100 * + d 10 * + e + * { product2 }
                      counted product2 cells + @ INVERT allowed product2 10 // okdigits AND
                      IF
                        true counted product2 cells + !
                        count product2 + TO count
                        product2 s>d 0 d.r
                         s"  " TYPE
                      THEN
                      true allowed d cells + !
                    THEN
                   1 + REPEAT 2DROP
                  true allowed c cells + !
                THEN
               1 + REPEAT 2DROP
              true allowed a cells + !
            THEN
           1 + REPEAT 2DROP
          true allowed be cells + !
        THEN
        true allowed b cells + !
      THEN
     1 + REPEAT 2DROP
    true allowed e cells + !
   1 + REPEAT 2DROP
  count s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

