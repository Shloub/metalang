: foo { a }
  4 TO a
;

: main
  0 { a }
  a foo
  a s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

