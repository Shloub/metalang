: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
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
  THEN ;
: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;
: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT ;
: read-char current-char next-char ;
struct
  cell% field ->bigint_sign
  cell% field ->bigint_len
  cell% field ->bigint_chiffres
end-struct bigint%

: read_bigint { len }
  HERE len cells allot { chiffres }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    read-char { c }
    c chiffres  j cells +  !
   1 + REPEAT 2DROP
  len 1 - 2 // 0 BEGIN 2dup >= WHILE DUP { i }
    chiffres  i cells +  @ { tmp }
    chiffres  len 1 - i - cells +  @ chiffres  i cells +  !
    tmp chiffres  len 1 - i - cells +  !
   1 + REPEAT 2DROP
  bigint% %allot { e }
  true e ->bigint_sign !
  len e ->bigint_len !
  chiffres e ->bigint_chiffres !
  e exit
;

: print_bigint { a }
  a ->bigint_sign @ INVERT
  IF
    45 EMIT
  THEN
  a ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    a ->bigint_chiffres @  a ->bigint_len @ 1 - i - cells +  @ s>d 0 d.r
   1 + REPEAT 2DROP
;

: bigint_eq { a b }
  \  Renvoie vrai si a = b 
  
  a ->bigint_sign @ b ->bigint_sign @ <>
  IF
    false exit
  ELSE
    a ->bigint_len @ b ->bigint_len @ <>
    IF
      false exit
    ELSE
      a ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { i }
        a ->bigint_chiffres @  i cells +  @ b ->bigint_chiffres @  i cells +  @ <>
        IF
          DROP DROP false exit
        THEN
       1 + REPEAT 2DROP
      true exit
    THEN
  THEN
;

: bigint_gt { a b }
  \  Renvoie vrai si a > b 
  
  a ->bigint_sign @ b ->bigint_sign @ INVERT AND
  IF
    true exit
  ELSE
    a ->bigint_sign @ INVERT b ->bigint_sign @ AND
    IF
      false exit
    ELSE
      a ->bigint_len @ b ->bigint_len @ >
      IF
        a ->bigint_sign @ exit
      ELSE
        a ->bigint_len @ b ->bigint_len @ <
        IF
          a ->bigint_sign @ INVERT exit
        ELSE
          a ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { i }
            a ->bigint_len @ 1 - i - { j }
            a ->bigint_chiffres @  j cells +  @ b ->bigint_chiffres @  j cells +  @ >
            IF
              DROP DROP a ->bigint_sign @ exit
            ELSE
              a ->bigint_chiffres @  j cells +  @ b ->bigint_chiffres @  j cells +  @ <
              IF
                DROP DROP a ->bigint_sign @ INVERT exit
              THEN
            THEN
           1 + REPEAT 2DROP
        THEN
      THEN
      true exit
    THEN
  THEN
;

: bigint_lt { a b }
  a b bigint_gt INVERT exit
;

: add_bigint_positif { a b }
  \  Une addition ou on en a rien a faire des signes 
  
  a ->bigint_len @ b ->bigint_len @ max 1 + { len }
  0 { retenue }
  HERE len cells allot { chiffres }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    retenue { tmp }
    i a ->bigint_len @ <
    IF
      tmp a ->bigint_chiffres @  i cells +  @ + TO tmp
    THEN
    i b ->bigint_len @ <
    IF
      tmp b ->bigint_chiffres @  i cells +  @ + TO tmp
    THEN
    tmp 10 // TO retenue
    tmp 10 % chiffres  i cells +  !
   1 + REPEAT 2DROP
  BEGIN
    len 0 > chiffres  len 1 - cells +  @ 0 = AND
  WHILE
    len 1 - TO len
  REPEAT
  bigint% %allot { f }
  true f ->bigint_sign !
  len f ->bigint_len !
  chiffres f ->bigint_chiffres !
  f exit
;

: sub_bigint_positif { a b }
  \  Une soustraction ou on en a rien a faire des signes
  \ Pré-requis : a > b
  \ 
  
  a ->bigint_len @ { len }
  0 { retenue }
  HERE len cells allot { chiffres }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    retenue a ->bigint_chiffres @  i cells +  @ + { tmp }
    i b ->bigint_len @ <
    IF
      tmp b ->bigint_chiffres @  i cells +  @ - TO tmp
    THEN
    tmp 0 <
    IF
      tmp 10 + TO tmp
      1 NEGATE TO retenue
    ELSE
      0 TO retenue
    THEN
    tmp chiffres  i cells +  !
   1 + REPEAT 2DROP
  BEGIN
    len 0 > chiffres  len 1 - cells +  @ 0 = AND
  WHILE
    len 1 - TO len
  REPEAT
  bigint% %allot { g }
  true g ->bigint_sign !
  len g ->bigint_len !
  chiffres g ->bigint_chiffres !
  g exit
;

: neg_bigint { a }
  bigint% %allot { h }
  a ->bigint_sign @ INVERT h ->bigint_sign !
  a ->bigint_len @ h ->bigint_len !
  a ->bigint_chiffres @ h ->bigint_chiffres !
  h exit
;

: add_bigint { a b }
  a ->bigint_sign @ b ->bigint_sign @ =
  IF
    a ->bigint_sign @
    IF
      a b add_bigint_positif exit
    ELSE
      a b add_bigint_positif neg_bigint exit
    THEN
  ELSE
    a ->bigint_sign @
    IF
      \  a positif, b negatif 
      
      a b neg_bigint bigint_gt
      IF
        a b sub_bigint_positif exit
      ELSE
        b a sub_bigint_positif neg_bigint exit
      THEN
    ELSE
      \  a negatif, b positif 
      
      a neg_bigint b bigint_gt
      IF
        a b sub_bigint_positif neg_bigint exit
      ELSE
        b a sub_bigint_positif exit
      THEN
    THEN
  THEN
;

: sub_bigint { a b }
  a b neg_bigint add_bigint exit
;

: mul_bigint_cp { a b }
  \  Cet algorithm est quadratique.
  \ C'est le même que celui qu'on enseigne aux enfants en CP.
  \ D'ou le nom de la fonction. 
  
  a ->bigint_len @ b ->bigint_len @ + 1 + { len }
  HERE len cells allot { chiffres }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { k }
    0 chiffres  k cells +  !
   1 + REPEAT 2DROP
  a ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 { retenue }
    b ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      chiffres  i j + cells +  @ retenue b ->bigint_chiffres @  j cells +  @ a ->bigint_chiffres @  i cells +  @ * + + chiffres  i j + cells +  !
      chiffres  i j + cells +  @ 10 // TO retenue
      chiffres  i j + cells +  @ 10 % chiffres  i j + cells +  !
     1 + REPEAT 2DROP
    chiffres  i b ->bigint_len @ + cells +  @ retenue + chiffres  i b ->bigint_len @ + cells +  !
   1 + REPEAT 2DROP
  chiffres  a ->bigint_len @ b ->bigint_len @ + 1 - cells +  @ 10 // chiffres  a ->bigint_len @ b ->bigint_len @ + cells +  !
  chiffres  a ->bigint_len @ b ->bigint_len @ + 1 - cells +  @ 10 % chiffres  a ->bigint_len @ b ->bigint_len @ + 1 - cells +  !
  2 0 BEGIN 2dup >= WHILE DUP { l }
    len 0 <> chiffres  len 1 - cells +  @ 0 = AND
    IF
      len 1 - TO len
    THEN
   1 + REPEAT 2DROP
  bigint% %allot { m }
  a ->bigint_sign @ b ->bigint_sign @ = m ->bigint_sign !
  len m ->bigint_len !
  chiffres m ->bigint_chiffres !
  m exit
;

: bigint_premiers_chiffres { a i }
  i a ->bigint_len @ min { len }
  BEGIN
    len 0 <> a ->bigint_chiffres @  len 1 - cells +  @ 0 = AND
  WHILE
    len 1 - TO len
  REPEAT
  bigint% %allot { o }
  a ->bigint_sign @ o ->bigint_sign !
  len o ->bigint_len !
  a ->bigint_chiffres @ o ->bigint_chiffres !
  o exit
;

: bigint_shift { a i }
  HERE a ->bigint_len @ i + cells allot { chiffres }
  a ->bigint_len @ i + 1 - 0 BEGIN 2dup >= WHILE DUP { k }
    k i >=
    IF
      a ->bigint_chiffres @  k i - cells +  @ chiffres  k cells +  !
    ELSE
      0 chiffres  k cells +  !
    THEN
   1 + REPEAT 2DROP
  bigint% %allot { p }
  a ->bigint_sign @ p ->bigint_sign !
  a ->bigint_len @ i + p ->bigint_len !
  chiffres p ->bigint_chiffres !
  p exit
;

: mul_bigint recursive { aa bb }
  aa ->bigint_len @ 0 =
  IF
    aa exit
  ELSE
    bb ->bigint_len @ 0 =
    IF
      bb exit
    ELSE
      aa ->bigint_len @ 3 < bb ->bigint_len @ 3 < OR
      IF
        aa bb mul_bigint_cp exit
      THEN
    THEN
  THEN
  \  Algorithme de Karatsuba 
  
  aa ->bigint_len @ bb ->bigint_len @ min 2 // { split }
  aa split NEGATE bigint_shift { a }
  aa split bigint_premiers_chiffres { b }
  bb split NEGATE bigint_shift { c }
  bb split bigint_premiers_chiffres { d }
  a b sub_bigint { amoinsb }
  c d sub_bigint { cmoinsd }
  a c mul_bigint { ac }
  b d mul_bigint { bd }
  amoinsb cmoinsd mul_bigint { amoinsbcmoinsd }
  ac 2 split * bigint_shift { acdec }
  acdec bd add_bigint ac bd add_bigint amoinsbcmoinsd sub_bigint split bigint_shift add_bigint exit
  \  ac × 102k + (ac + bd – (a – b)(c – d)) × 10k + bd 
  
;

\ 
\ Division,
\ Modulo
\ 

: log10 { a }
  1 { out0 }
  BEGIN
    a 10 >=
  WHILE
    a 10 // TO a
    out0 1 + TO out0
  REPEAT
  out0 exit
;

: bigint_of_int { i }
  i log10 { size }
  i 0 =
  IF
    0 TO size
  THEN
  HERE size cells allot { t }
  size 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    0 t  j cells +  !
   1 + REPEAT 2DROP
  size 1 - 0 BEGIN 2dup >= WHILE DUP { k }
    i 10 % t  k cells +  !
    i 10 // TO i
   1 + REPEAT 2DROP
  bigint% %allot { q }
  true q ->bigint_sign !
  size q ->bigint_len !
  t q ->bigint_chiffres !
  q exit
;

: fact_bigint { a }
  1 bigint_of_int { one }
  one { out0 }
  BEGIN
    a one bigint_eq INVERT
  WHILE
    a out0 mul_bigint TO out0
    a one sub_bigint TO a
  REPEAT
  out0 exit
;

: sum_chiffres_bigint { a }
  0 { out0 }
  a ->bigint_len @ 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    out0 a ->bigint_chiffres @  i cells +  @ + TO out0
   1 + REPEAT 2DROP
  out0 exit
;

\  http://projecteuler.net/problem=20 

: euler20 {  }
  15 bigint_of_int { a }
  \  normalement c'est 100 
  
  a fact_bigint TO a
  a sum_chiffres_bigint exit
;

: bigint_exp recursive { a b }
  b 1 =
  IF
    a exit
  ELSE
    b 2 % 0 =
    IF
      a a mul_bigint b 2 // bigint_exp exit
    ELSE
      a a b 1 - bigint_exp mul_bigint exit
    THEN
  THEN
;

: bigint_exp_10chiffres recursive { a b }
  a 10 bigint_premiers_chiffres TO a
  b 1 =
  IF
    a exit
  ELSE
    b 2 % 0 =
    IF
      a a mul_bigint b 2 // bigint_exp_10chiffres exit
    ELSE
      a a b 1 - bigint_exp_10chiffres mul_bigint exit
    THEN
  THEN
;

: euler48 {  }
  0 bigint_of_int { sum }
  100 1 BEGIN 2dup >= WHILE DUP { i }
    \  1000 normalement 
    
    i bigint_of_int { ib }
    ib i bigint_exp_10chiffres { ibeib }
    sum ibeib add_bigint TO sum
    sum 10 bigint_premiers_chiffres TO sum
   1 + REPEAT 2DROP
  S" euler 48 = " TYPE
  sum print_bigint
  S\" \n" TYPE
;

: euler16 {  }
  2 bigint_of_int { a }
  a 100 bigint_exp TO a
  \  1000 normalement 
  
  a sum_chiffres_bigint exit
;

: euler25 {  }
  2 { i }
  1 bigint_of_int { a }
  1 bigint_of_int { b }
  BEGIN
    b ->bigint_len @ 100 <
  WHILE
    \  1000 normalement 
    
    a b add_bigint { c }
    b TO a
    c TO b
    i 1 + TO i
  REPEAT
  i exit
;

: euler29 {  }
  5 { maxA }
  5 { maxB }
  HERE maxA 1 + cells allot { a_bigint }
  maxA 0 BEGIN 2dup >= WHILE DUP { j }
    j j * bigint_of_int a_bigint  j cells +  !
   1 + REPEAT 2DROP
  HERE maxA 1 + cells allot { a0_bigint }
  maxA 0 BEGIN 2dup >= WHILE DUP { j2 }
    j2 bigint_of_int a0_bigint  j2 cells +  !
   1 + REPEAT 2DROP
  HERE maxA 1 + cells allot { b }
  maxA 0 BEGIN 2dup >= WHILE DUP { k }
    2 b  k cells +  !
   1 + REPEAT 2DROP
  0 { n }
  true { found }
  BEGIN
    found
  WHILE
    a0_bigint  0 cells +  @ { min0 }
    false TO found
    maxA 2 BEGIN 2dup >= WHILE DUP { i }
      b  i cells +  @ maxB <=
      IF
        found
        IF
          a_bigint  i cells +  @ min0 bigint_lt
          IF
            a_bigint  i cells +  @ TO min0
          THEN
        ELSE
          a_bigint  i cells +  @ TO min0
          true TO found
        THEN
      THEN
     1 + REPEAT 2DROP
    found
    IF
      n 1 + TO n
      maxA 2 BEGIN 2dup >= WHILE DUP { l }
        a_bigint  l cells +  @ min0 bigint_eq b  l cells +  @ maxB <= AND
        IF
          b  l cells +  @ 1 + b  l cells +  !
          a_bigint  l cells +  @ a0_bigint  l cells +  @ mul_bigint a_bigint  l cells +  !
        THEN
       1 + REPEAT 2DROP
    THEN
  REPEAT
  n exit
;

: main
   euler29 s>d 0 d.r
  S\" \n" TYPE
  50 read_bigint { sum }
  100 2 BEGIN 2dup >= WHILE DUP { i }
    skipspaces
    50 read_bigint { tmp }
    sum tmp add_bigint TO sum
   1 + REPEAT 2DROP
  S" euler13 = " TYPE
  sum print_bigint
  S\" \neuler25 = " TYPE
   euler25 s>d 0 d.r
  S\" \neuler16 = " TYPE
   euler16 s>d 0 d.r
  S\" \n" TYPE
   euler48
  S" euler20 = " TYPE
   euler20 s>d 0 d.r
  S\" \n" TYPE
  999999 bigint_of_int { a }
  9951263 bigint_of_int { b }
  a print_bigint
  S" >>1=" TYPE
  a 1 NEGATE bigint_shift print_bigint
  S\" \n" TYPE
  a print_bigint
  S" *" TYPE
  b print_bigint
  S" =" TYPE
  a b mul_bigint print_bigint
  S\" \n" TYPE
  a print_bigint
  S" *" TYPE
  b print_bigint
  S" =" TYPE
  a b mul_bigint_cp print_bigint
  S\" \n" TYPE
  a print_bigint
  S" +" TYPE
  b print_bigint
  S" =" TYPE
  a b add_bigint print_bigint
  S\" \n" TYPE
  b print_bigint
  S" -" TYPE
  a print_bigint
  S" =" TYPE
  b a sub_bigint print_bigint
  S\" \n" TYPE
  a print_bigint
  S" -" TYPE
  b print_bigint
  S" =" TYPE
  a b sub_bigint print_bigint
  S\" \n" TYPE
  a print_bigint
  S" >" TYPE
  b print_bigint
  S" =" TYPE
  a b bigint_gt
  IF
    S" True" TYPE
  ELSE
    S" False" TYPE
  THEN
  S\" \n" TYPE
  ;
main
BYE

