

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



: eratostene { t max0 }
  0 { n }
  max0 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    t i cells + @ i =
    IF
      n 1 + TO n
      i i * { j }
      BEGIN
        j max0 < j 0 > AND
      WHILE
        0 t j cells + !
        j i + TO j
      REPEAT
    THEN
   1 + REPEAT 2DROP
  n exit
;

: isPrime { n primes len }
  0 { i }
  n 0 <
  IF
    n NEGATE TO n
  THEN
  BEGIN
    primes i cells + @ primes i cells + @ * n <
  WHILE
    n primes i cells + @ % 0 =
    IF
      false exit
    THEN
    i 1 + TO i
  REPEAT
  true exit
;

: test { a b primes len }
  200 0 BEGIN 2dup >= WHILE DUP { n }
    n n * a n * + b + { j }
    j primes len isPrime INVERT
    IF
      DROP DROP n exit
    THEN
   1 + REPEAT 2DROP
  200 exit
;

: main
  1000 { maximumprimes }
  HERE maximumprimes cells allot { era }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    j era j cells + !
   1 + REPEAT 2DROP
  0 { result }
  0 { max0 }
  era maximumprimes eratostene { nprimes }
  HERE nprimes cells allot { primes }
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { o }
    0 primes o cells + !
   1 + REPEAT 2DROP
  0 { l }
  maximumprimes 1 - 2 BEGIN 2dup >= WHILE DUP { k }
    era k cells + @ k =
    IF
      k primes l cells + !
      l 1 + TO l
    THEN
   1 + REPEAT 2DROP
  l s>d 0 d.r
   s"  == " TYPE
  nprimes s>d 0 d.r
  NEWLINE TYPE
  0 { ma }
  0 { mb }
  999 3 BEGIN 2dup >= WHILE DUP { b }
    era b cells + @ b =
    IF
      999 999 NEGATE BEGIN 2dup >= WHILE DUP { a }
        a b primes nprimes test { n1 }
        a b NEGATE primes nprimes test { n2 }
        n1 max0 >
        IF
          n1 TO max0
          a b * TO result
          a TO ma
          b TO mb
        THEN
        n2 max0 >
        IF
          n2 TO max0
          a NEGATE b * TO result
          a TO ma
          b NEGATE TO mb
        THEN
       1 + REPEAT 2DROP
    THEN
   1 + REPEAT 2DROP
  ma s>d 0 d.r
   s"  " TYPE
  mb s>d 0 d.r
  NEWLINE TYPE
  max0 s>d 0 d.r
  NEWLINE TYPE
  result s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

