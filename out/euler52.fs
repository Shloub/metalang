: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: chiffre_sort recursive { a }
  a 10 <
  IF
    a exit
  ELSE
    a 10 // chiffre_sort { b }
    a 10 % { c }
    b 10 % { d }
    b 10 // { e }
    c d <
    IF
      c b 10 * + exit
    ELSE
      d c e 10 * + chiffre_sort 10 * + exit
    THEN
  THEN
;

: same_numbers { a b c d e f }
  a chiffre_sort { ca }
  ca b chiffre_sort = ca c chiffre_sort = AND ca d chiffre_sort = AND ca e chiffre_sort = AND ca f chiffre_sort = AND exit
;

: main
  142857 { num }
  num num 2 * num 3 * num 4 * num 6 * num 5 * same_numbers
  IF
    num s>d 0 d.r
    S"  " TYPE
    num 2 * s>d 0 d.r
    S"  " TYPE
    num 3 * s>d 0 d.r
    S"  " TYPE
    num 4 * s>d 0 d.r
    S"  " TYPE
    num 5 * s>d 0 d.r
    S"  " TYPE
    num 6 * s>d 0 d.r
    S\" \n" TYPE
  THEN
  ;
main
BYE

