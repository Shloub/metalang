\ 
\ Ce test permet de vérifier le comportement des macros
\ Il effectue du loop unrolling
\ 

: main
  0 { j }
  0 TO j
  j s>d 0 d.r
  NEWLINE TYPE
  1 TO j
  j s>d 0 d.r
  NEWLINE TYPE
  2 TO j
  j s>d 0 d.r
  NEWLINE TYPE
  3 TO j
  j s>d 0 d.r
  NEWLINE TYPE
  4 TO j
  j s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

