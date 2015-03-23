\ 
\ Ce test permet de tester les macros
\ C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
\ et qui produit les macros metalang correspondante
\ 

: main
  32 { input }
  500 { current_pos }
  HERE 1000 cells allot { mem }
  1000 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    0 mem i cells + !
   1 + REPEAT 2DROP
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  current_pos 1 + TO current_pos
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  mem current_pos cells + @ 1 + mem current_pos cells + !
  BEGIN
    mem current_pos cells + @ 0 <>
  WHILE
    mem current_pos cells + @ 1 - mem current_pos cells + !
    current_pos 1 - TO current_pos
    mem current_pos cells + @ 1 + mem current_pos cells + !
    mem current_pos cells + @ EMIT
    current_pos 1 + TO current_pos
  REPEAT
  ;
main
BYE

