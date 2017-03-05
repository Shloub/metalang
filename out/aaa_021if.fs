: testA { a b }
  a
  IF
    b
    IF
      S" A" TYPE
    ELSE
      S" B" TYPE
    THEN
  ELSE
    b
    IF
      S" C" TYPE
    ELSE
      S" D" TYPE
    THEN
  THEN
;


: testB { a b }
  a
  IF
    S" A" TYPE
  ELSE
    b
    IF
      S" B" TYPE
    ELSE
      S" C" TYPE
    THEN
  THEN
;


: testC { a b }
  a
  IF
    b
    IF
      S" A" TYPE
    ELSE
      S" B" TYPE
    THEN
  ELSE
    S" C" TYPE
  THEN
;


: testD { a b }
  a
  IF
    b
    IF
      S" A" TYPE
    ELSE
      S" B" TYPE
    THEN
    S" C" TYPE
  ELSE
    S" D" TYPE
  THEN
;


: testE { a b }
  a
  IF
    b
    IF
      S" A" TYPE
    THEN
  ELSE
    b
    IF
      S" C" TYPE
    ELSE
      S" D" TYPE
    THEN
    S" E" TYPE
  THEN
;


: test { a b }
  a b testD
  a b testE
  S\" \n" TYPE
;

: main
  true true test
  true false test
  false true test
  false false test
  ;
main
BYE

