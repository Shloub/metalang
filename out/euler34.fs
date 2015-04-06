: main
  HERE 10 cells allot { f }
  10 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    1 f j cells +
     !
   1 + REPEAT 2DROP
  9 1 BEGIN 2dup >= WHILE DUP { i }
    f i cells +
     @ i f i 1 - cells +
     @ * * f i cells +
     !
    f i cells +
     @ s>d 0 d.r
    S"  " TYPE
   1 + REPEAT 2DROP
  0 { out0 }
  S\" \n" TYPE
  9 0 BEGIN 2dup >= WHILE DUP { a }
    9 0 BEGIN 2dup >= WHILE DUP { b }
      9 0 BEGIN 2dup >= WHILE DUP { c }
        9 0 BEGIN 2dup >= WHILE DUP { d }
          9 0 BEGIN 2dup >= WHILE DUP { e }
            9 0 BEGIN 2dup >= WHILE DUP { g }
              f a cells +
               @ f b cells +
               @ + f c cells +
               @ + f d cells +
               @ + f e cells +
               @ + f g cells +
               @ + { sum }
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
                S"  " TYPE
              THEN
             1 + REPEAT 2DROP
           1 + REPEAT 2DROP
         1 + REPEAT 2DROP
       1 + REPEAT 2DROP
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  S\" \n" TYPE
  out0 s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

