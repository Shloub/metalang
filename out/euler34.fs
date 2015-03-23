

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
  HERE 10 cells allot { f }
  10 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    1 f j cells + !
   1 + REPEAT 2DROP
  9 1 BEGIN 2dup >= WHILE DUP { i }
    f i cells + @ i f i 1 - cells + @ * * f i cells + !
    f i cells + @ s>d 0 d.r
     s"  " TYPE
   1 + REPEAT 2DROP
  0 { out0 }
  NEWLINE TYPE
  9 0 BEGIN 2dup >= WHILE DUP { a }
    9 0 BEGIN 2dup >= WHILE DUP { b }
      9 0 BEGIN 2dup >= WHILE DUP { c }
        9 0 BEGIN 2dup >= WHILE DUP { d }
          9 0 BEGIN 2dup >= WHILE DUP { e }
            9 0 BEGIN 2dup >= WHILE DUP { g }
              f a cells + @ f b cells + @ + f c cells + @ + f d cells + @ + f e cells + @ + f g cells + @ +
              { sum }
              a 10 * b + 10 * c + 10 * d + 10 * e + 10 * g + { num }
              a 0 =
              IF
                sum 1 - TO sum
                b 0 =
                IF
                  sum 1 - TO sum
                  c 0 =
                  IF
                    sum 1 - TO sum
                    d 0 =
                    IF
                      sum 1 - TO sum
                    THEN
                  THEN
                THEN
              THEN
              sum num = sum 1 <> AND sum 2 <> AND
              IF
                out0 num + TO out0
                num s>d 0 d.r
                 s"  " TYPE
              THEN
             1 + REPEAT 2DROP
           1 + REPEAT 2DROP
         1 + REPEAT 2DROP
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  NEWLINE TYPE
  out0 s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

