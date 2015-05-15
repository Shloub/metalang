: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: main
  \ 
  \ The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
  \ 
  \ Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
  \ 
  \ d2d3d4=406 is divisible by 2
  \ d3d4d5=063 is divisible by 3
  \ d4d5d6=635 is divisible by 5
  \ d5d6d7=357 is divisible by 7
  \ d6d7d8=572 is divisible by 11
  \ d7d8d9=728 is divisible by 13
  \ d8d9d10=289 is divisible by 17
  \ Find the sum of all 0 to 9 pandigital numbers with this property.
  \ 
  \ d4 % 2 == 0
  \ (d3 + d4 + d5) % 3 == 0
  \ d6 = 5 ou d6 = 0
  \ (d5 * 100 + d6 * 10 + d7  ) % 7 == 0
  \ (d6 * 100 + d7 * 10 + d8  ) % 11 == 0
  \ (d7 * 100 + d8 * 10 + d9  ) % 13 == 0
  \ (d8 * 100 + d9 * 10 + d10 ) % 17 == 0
  \ 
  \ 
  \ d4 % 2 == 0
  \ d6 = 5 ou d6 = 0
  \ 
  \ (d3 + d4 + d5) % 3 == 0
  \ (d5 * 2 + d6 * 3 + d7) % 7 == 0
  \ 
  
  HERE 10 cells allot { allowed }
  10 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    true allowed  i cells +  !
   1 + REPEAT 2DROP
  1 0 BEGIN 2dup >= WHILE DUP { i6 }
    i6 5 * { d6 }
    allowed  d6 cells +  @
    IF
      false allowed  d6 cells +  !
      9 0 BEGIN 2dup >= WHILE DUP { d7 }
        allowed  d7 cells +  @
        IF
          false allowed  d7 cells +  !
          9 0 BEGIN 2dup >= WHILE DUP { d8 }
            allowed  d8 cells +  @
            IF
              false allowed  d8 cells +  !
              9 0 BEGIN 2dup >= WHILE DUP { d9 }
                allowed  d9 cells +  @
                IF
                  false allowed  d9 cells +  !
                  9 1 BEGIN 2dup >= WHILE DUP { d10 }
                    allowed  d10 cells +  @ d6 100 * d7 10 * + d8 + 11 % 0 = AND d7 100 * d8 10 * + d9 + 13 % 0 = AND d8 100 * d9 10 * + d10 + 17 % 0 = AND
                    IF
                      false allowed  d10 cells +  !
                      9 0 BEGIN 2dup >= WHILE DUP { d5 }
                        allowed  d5 cells +  @
                        IF
                          false allowed  d5 cells +  !
                          d5 100 * d6 10 * + d7 + 7 % 0 =
                          IF
                            4 0 BEGIN 2dup >= WHILE DUP { i4 }
                              i4 2 * { d4 }
                              allowed  d4 cells +  @
                              IF
                                false allowed  d4 cells +  !
                                9 0 BEGIN 2dup >= WHILE DUP { d3 }
                                  allowed  d3 cells +  @
                                  IF
                                    false allowed  d3 cells +  !
                                    d3 d4 + d5 + 3 % 0 =
                                    IF
                                      9 0 BEGIN 2dup >= WHILE DUP { d2 }
                                        allowed  d2 cells +  @
                                        IF
                                          false allowed  d2 cells +  !
                                          9 0 BEGIN 2dup >= WHILE DUP { d1 }
                                            allowed  d1 cells +  @
                                            IF
                                              false allowed  d1 cells +  !
                                              d1 s>d 0 d.r
                                              d2 s>d 0 d.r
                                              d3 s>d 0 d.r
                                              d4 s>d 0 d.r
                                              d5 s>d 0 d.r
                                              d6 s>d 0 d.r
                                              d7 s>d 0 d.r
                                              d8 s>d 0 d.r
                                              d9 s>d 0 d.r
                                              d10 s>d 0 d.r
                                              S"  + " TYPE
                                              true allowed  d1 cells +  !
                                            THEN
                                           1 + REPEAT 2DROP
                                          true allowed  d2 cells +  !
                                        THEN
                                       1 + REPEAT 2DROP
                                    THEN
                                    true allowed  d3 cells +  !
                                  THEN
                                 1 + REPEAT 2DROP
                                true allowed  d4 cells +  !
                              THEN
                             1 + REPEAT 2DROP
                          THEN
                          true allowed  d5 cells +  !
                        THEN
                       1 + REPEAT 2DROP
                      true allowed  d10 cells +  !
                    THEN
                   1 + REPEAT 2DROP
                  true allowed  d9 cells +  !
                THEN
               1 + REPEAT 2DROP
              true allowed  d8 cells +  !
            THEN
           1 + REPEAT 2DROP
          true allowed  d7 cells +  !
        THEN
       1 + REPEAT 2DROP
      true allowed  d6 cells +  !
    THEN
   1 + REPEAT 2DROP
  0 s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

