

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
  10 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    i i * i * i * i * p i cells + !
   1 + REPEAT 2DROP
  0 { sum }
  9 0 BEGIN 2dup >= WHILE DUP { a }
    9 0 BEGIN 2dup >= WHILE DUP { b }
      9 0 BEGIN 2dup >= WHILE DUP { c }
        9 0 BEGIN 2dup >= WHILE DUP { d }
          9 0 BEGIN 2dup >= WHILE DUP { e }
            9 0 BEGIN 2dup >= WHILE DUP { f }
              p a cells + @ p b cells + @ + p c cells + @ + p d cells + @ + p e cells + @ + p f cells + @ +
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
                 s"  " TYPE
                r s>d 0 d.r
                NEWLINE TYPE
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

