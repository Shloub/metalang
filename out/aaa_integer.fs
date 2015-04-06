: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: main
  0 { i }
  i 1 - TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 55 + TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 13 * TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 2 // TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 1 + TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 3 // TO i
  i s>d 0 d.r
  S\" \n" TYPE
  i 1 - TO i
  i s>d 0 d.r
  S\" \n" TYPE
  \ 
  \ http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
  \ 
  
  117 17 // s>d 0 d.r
  S\" \n" TYPE
  117 17 NEGATE // s>d 0 d.r
  S\" \n" TYPE
  117 NEGATE 17 // s>d 0 d.r
  S\" \n" TYPE
  117 NEGATE 17 NEGATE // s>d 0 d.r
  S\" \n" TYPE
  117 17 % s>d 0 d.r
  S\" \n" TYPE
  117 17 NEGATE % s>d 0 d.r
  S\" \n" TYPE
  117 NEGATE 17 % s>d 0 d.r
  S\" \n" TYPE
  117 NEGATE 17 NEGATE % s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

