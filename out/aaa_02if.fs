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
     s" true <-" NEWLINE s"  ->" NEWLINE S+ S+ S+ TYPE
  ELSE
     s" false <-" NEWLINE s"  ->" NEWLINE S+ S+ S+ TYPE
  THEN
   s" small test end" NEWLINE S+ TYPE
  ;
main
BYE

