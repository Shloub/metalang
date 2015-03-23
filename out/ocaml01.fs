: foo {  }
  10 0 BEGIN 2dup >= WHILE DUP { i }
    
   1 + REPEAT 2DROP
  0 exit
;

: bar {  }
  10 0 BEGIN 2dup >= WHILE DUP { i }
    0 { a }
   1 + REPEAT 2DROP
  0 exit
;

: main
  
  ;
main
BYE

