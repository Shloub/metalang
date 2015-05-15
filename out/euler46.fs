: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: eratostene { t max0 }
  0 { n }
  max0 1 - 2 BEGIN 2dup >= WHILE DUP { i }
    t  i cells +  @ i =
    IF
      n 1 + TO n
      max0 i // i >
      IF
        i i * { j }
        BEGIN
          j max0 < j 0 > AND
        WHILE
          0 t  j cells +  !
          j i + TO j
        REPEAT
      THEN
    THEN
   1 + REPEAT 2DROP
  n exit
;

: main
  6000 { maximumprimes }
  HERE maximumprimes cells allot { era }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { j_ }
    j_ era  j_ cells +  !
   1 + REPEAT 2DROP
  era maximumprimes eratostene { nprimes }
  HERE nprimes cells allot { primes }
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { o }
    0 primes  o cells +  !
   1 + REPEAT 2DROP
  0 { l }
  maximumprimes 1 - 2 BEGIN 2dup >= WHILE DUP { k }
    era  k cells +  @ k =
    IF
      k primes  l cells +  !
      l 1 + TO l
    THEN
   1 + REPEAT 2DROP
  l s>d 0 d.r
  S"  == " TYPE
  nprimes s>d 0 d.r
  S\" \n" TYPE
  HERE maximumprimes cells allot { canbe }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { i_ }
    false canbe  i_ cells +  !
   1 + REPEAT 2DROP
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      primes  i cells +  @ 2 j * j * + { n }
      n maximumprimes <
      IF
        true canbe  n cells +  !
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  maximumprimes 1 BEGIN 2dup >= WHILE DUP { m }
    m 2 * 1 + { m2 }
    m2 maximumprimes < canbe  m2 cells +  @ INVERT AND
    IF
      m2 s>d 0 d.r
      S\" \n" TYPE
    THEN
   1 + REPEAT 2DROP
  ;
main
BYE

