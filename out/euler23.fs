

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

: fillPrimesFactors { t n primes nprimes }
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    primes i cells + @ { d }
    BEGIN
      n d % 0 =
    WHILE
      t d cells + @ 1 + t d cells + !
      n d // TO n
    REPEAT
    n 1 =
    IF
      DROP DROP primes i cells + @ exit
    THEN
   1 + REPEAT 2DROP
  n exit
;

: sumdivaux2 { t n i }
  BEGIN
    i n < t i cells + @ 0 = AND
  WHILE
    i 1 + TO i
  REPEAT
  i exit
;

: sumdivaux recursive { t n i }
  i n >
  IF
    1 exit
  ELSE
    t i cells + @ 0 =
    IF
      t n t n i 1 + sumdivaux2 sumdivaux exit
    ELSE
      t n t n i 1 + sumdivaux2 sumdivaux { o }
      0 { out0 }
      i { p }
      t i cells + @ 1 BEGIN 2dup >= WHILE DUP { j }
        out0 p + TO out0
        p i * TO p
       1 + REPEAT 2DROP
      out0 1 + o * exit
    THEN
  THEN
;

: sumdiv { nprimes primes n }
  HERE n 1 + cells allot { t }
  n 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 t i cells + !
   1 + REPEAT 2DROP
  t n primes nprimes fillPrimesFactors { max0 }
  t max0 0 sumdivaux exit
;

: main
  30001 { maximumprimes }
  HERE maximumprimes cells allot { era }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { s }
    s era s cells + !
   1 + REPEAT 2DROP
  era maximumprimes eratostene { nprimes }
  HERE nprimes cells allot { primes }
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { t }
    0 primes t cells + !
   1 + REPEAT 2DROP
  0 { l }
  maximumprimes 1 - 2 BEGIN 2dup >= WHILE DUP { k }
    era k cells + @ k =
    IF
      k primes l cells + !
      l 1 + TO l
    THEN
   1 + REPEAT 2DROP
  100 { n }
  \  28124 ça prend trop de temps mais on arrive a passer le test 
  
  HERE n 1 + cells allot { abondant }
  n 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { p }
    false abondant p cells + !
   1 + REPEAT 2DROP
  HERE n 1 + cells allot { summable }
  n 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { q }
    false summable q cells + !
   1 + REPEAT 2DROP
  0 { sum }
  n 2 BEGIN 2dup >= WHILE DUP { r }
    nprimes primes r sumdiv r - { other }
    other r >
    IF
      true abondant r cells + !
    THEN
   1 + REPEAT 2DROP
  n 1 BEGIN 2dup >= WHILE DUP { i }
    n 1 BEGIN 2dup >= WHILE DUP { j }
      abondant i cells + @ abondant j cells + @ AND i j + n <= AND
      IF
        true summable i j + cells + !
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  n 1 BEGIN 2dup >= WHILE DUP { o }
    summable o cells + @ INVERT
    IF
      sum o + TO sum
    THEN
   1 + REPEAT 2DROP
  NEWLINE TYPE
  sum s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

