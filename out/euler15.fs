: main
  10 { n }
  \  normalement on doit mettre 20 mais là on se tape un overflow 
  
  n 1 + TO n
  HERE n cells allot { tab }
  n 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE n cells allot { tab2 }
    n 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 tab2 j cells +
       !
     1 + REPEAT 2DROP
    tab2 tab i cells +
     !
   1 + REPEAT 2DROP
  n 1 - 0 BEGIN 2dup >= WHILE DUP { l }
    1 tab n 1 - cells +
     @ l cells +
     !
    1 tab l cells +
     @ n 1 - cells +
     !
   1 + REPEAT 2DROP
  n 2 BEGIN 2dup >= WHILE DUP { o }
    n o - { r }
    n 2 BEGIN 2dup >= WHILE DUP { p }
      n p - { q }
      tab r 1 + cells +
       @ q cells +
       @ tab r cells +
       @ q 1 + cells +
       @ + tab r cells +
       @ q cells +
       !
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
  n 1 - 0 BEGIN 2dup >= WHILE DUP { m }
    n 1 - 0 BEGIN 2dup >= WHILE DUP { k }
      tab m cells +
       @ k cells +
       @ s>d 0 d.r
       s"  " TYPE
     1 + REPEAT 2DROP
    NEWLINE TYPE
   1 + REPEAT 2DROP
  tab 0 cells +
   @ 0 cells +
   @ s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

