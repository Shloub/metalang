: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: eratostene { t max0 }
  0 { n }
  max0 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    t i cells + @ i =
    IF
      i i * { j }
      n 1 + TO n
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

: find0 { ndiv2 }
  110 { maximumprimes }
  HERE maximumprimes cells allot { era }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    j era j cells + !
   1 + REPEAT 2DROP
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
  10000 1 BEGIN 2dup >= WHILE DUP { n }
    HERE n 2 + cells allot { primesFactors }
    n 2 + 1 - 0 BEGIN 2dup >= WHILE DUP { m }
      0 primesFactors m cells + !
     1 + REPEAT 2DROP
    primesFactors n primes nprimes fillPrimesFactors primesFactors n 1 + primes nprimes fillPrimesFactors max
    { max0 }
    primesFactors 2 cells + @ 1 - primesFactors 2 cells + !
    1 { ndivs }
    max0 0 BEGIN 2dup >= WHILE DUP { i }
      primesFactors i cells + @ 0 <>
      IF
        ndivs 1 primesFactors i cells + @ + * TO ndivs
      THEN
     1 + REPEAT 2DROP
    ndivs ndiv2 >
    IF
      DROP DROP n n 1 + * 2 // exit
    THEN
    \  print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" 
    
   1 + REPEAT 2DROP
  0 exit
;

: main
  500 find0 s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

