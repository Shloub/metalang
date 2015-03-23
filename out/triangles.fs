VARIABLE buffer-index
1000 buffer-index !
VARIABLE NEOF
1 NEOF !
VARIABLE buffer-max
0 buffer-max !
create bufferc 128 allot
: next-char
  buffer-index @ 1 + buffer-index !
  buffer-index @ buffer-max @ > IF
    0 buffer-index !
    bufferc 128 stdin read-line DROP -1 = NEOF ! buffer-max !
    10 bufferc buffer-max @ + !
  THEN ;
: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;
: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT ;
: read-int
  [char] - current-char = IF -1 next-char ELSE 1 THEN
  0 BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT * ;
\  Ce code a été généré par metalang
\    Il gère les entrées sorties pour un programme dynamique classique
\    dans les épreuves de prologin
\ on le retrouve ici : http://projecteuler.net/problem=18
\ 

: find0 recursive { len tab cache x y }
  \ 
  \ 	Cette fonction est récursive
  \ 	
  
  y len 1 - =
  IF
    tab y cells + @ x cells + @ exit
  ELSE
    x y >
    IF
      10000 NEGATE exit
    ELSE
      cache y cells + @ x cells + @ 0 <>
      IF
        cache y cells + @ x cells + @ exit
      THEN
    THEN
  THEN
  0 { result }
  len tab cache x y 1 + find0 { out0 }
  len tab cache x 1 + y 1 + find0 { out1 }
  out0 out1 >
  IF
    out0 tab y cells + @ x cells + @ + TO result
  ELSE
    out1 tab y cells + @ x cells + @ + TO result
  THEN
  result cache y cells + @ x cells + !
  result exit
;

: find01 { len tab }
  HERE len cells allot { tab2 }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE i 1 + cells allot { tab3 }
    i 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 tab3 j cells + !
     1 + REPEAT 2DROP
    tab3 tab2 i cells + !
   1 + REPEAT 2DROP
  len tab tab2 0 0 find0 exit
;

: main
  0 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    HERE i 1 + cells allot { tab2 }
    i 1 + 1 - 0 BEGIN 2dup >= WHILE DUP { j }
      0 { tmp }
      read-int TO tmp
      skipspaces
      tmp tab2 j cells + !
     1 + REPEAT 2DROP
    tab2 tab i cells + !
   1 + REPEAT 2DROP
  len tab find01 s>d 0 d.r
  NEWLINE TYPE
  len 1 - 0 BEGIN 2dup >= WHILE DUP { k }
    k 0 BEGIN 2dup >= WHILE DUP { l }
      tab k cells + @ l cells + @ s>d 0 d.r
       s"  " TYPE
     1 + REPEAT 2DROP
    NEWLINE TYPE
   1 + REPEAT 2DROP
  ;
main
BYE

