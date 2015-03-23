: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
: h { i }
  \   for j = i - 2 to i + 2 do
  \     if i % j == 5 then return true end
  \   end 
  
  i 2 - { j }
  BEGIN
    j i 2 + <=
  WHILE
    i j % 5 =
    IF
      true exit
    THEN
    j 1 + TO j
  REPEAT
  false exit
;

: main
  0 { j }
  10 0 BEGIN 2dup >= WHILE DUP { k }
    j k + TO j
    j s>d 0 d.r
    NEWLINE TYPE
   1 + REPEAT 2DROP
  4 { i }
  BEGIN
    i 10 <
  WHILE
    i s>d 0 d.r
    i 1 + TO i
    j i + TO j
  REPEAT
  j s>d 0 d.r
  i s>d 0 d.r
   s" FIN TEST" NEWLINE S+ TYPE
  ;
main
BYE

