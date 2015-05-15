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
  1000001 { maximumprimes }
  HERE maximumprimes cells allot { era }
  maximumprimes 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    j era  j cells +  !
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
  HERE nprimes cells allot { sum }
  nprimes 1 - 0 BEGIN 2dup >= WHILE DUP { i_ }
    primes  i_ cells +  @ sum  i_ cells +  !
   1 + REPEAT 2DROP
  0 { maxl }
  true { process }
  maximumprimes 1 - { stop }
  1 { len }
  1 { resp }
  BEGIN
    process
  WHILE
    false TO process
    stop 0 BEGIN 2dup >= WHILE DUP { i }
      i len + nprimes <
      IF
        sum  i cells +  @ primes  i len + cells +  @ + sum  i cells +  !
        maximumprimes sum  i cells +  @ >
        IF
          true TO process
          era  sum  i cells +  @ cells +  @ sum  i cells +  @ =
          IF
            len TO maxl
            sum  i cells +  @ TO resp
          THEN
        ELSE
          stop i min TO stop
        THEN
      THEN
     1 + REPEAT 2DROP
    len 1 + TO len
  REPEAT
  resp s>d 0 d.r
  S\" \n" TYPE
  maxl s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

