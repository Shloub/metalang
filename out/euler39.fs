: main
  HERE 1001 cells allot { t }
  1001 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 t i cells + !
   1 + REPEAT 2DROP
  1000 1 BEGIN 2dup >= WHILE DUP { a }
    1000 1 BEGIN 2dup >= WHILE DUP { b }
      a a * b b * + { c2 }
      c2 s>f fsqrt f>s { c }
      c c * c2 =
      IF
        a b + c + { p }
        p 1000 <=
        IF
          t p cells + @ 1 + t p cells + !
        THEN
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  0 { j }
  1000 1 BEGIN 2dup >= WHILE DUP { k }
    t k cells + @ t j cells + @ >
    IF
      k TO j
    THEN
   1 + REPEAT 2DROP
  j s>d 0 d.r
  ;
main
BYE

