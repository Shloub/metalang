: f { i }
  i 0 =
  IF
    true exit
  THEN
  false exit
;

: main
  4 f
  IF
    S\" true <-\n ->\n" TYPE
  ELSE
    S\" false <-\n ->\n" TYPE
  THEN
  S\" small test end\n" TYPE
  ;
main
BYE

