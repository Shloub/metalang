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
: copytab { tab len }
  HERE len cells allot { o }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    tab i cells + @ o i cells + !
   1 + REPEAT 2DROP
  o exit
;

: bubblesort { tab len }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    len 1 - i 1 + BEGIN 2dup >= WHILE DUP { j }
      tab i cells + @ tab j cells + @ >
      IF
        tab i cells + @ { tmp }
        tab j cells + @ tab i cells + !
        tmp tab j cells + !
      THEN
     1 + REPEAT 2DROP
   1 + REPEAT 2DROP
;

: qsort0 recursive { tab len i j }
  i j <
  IF
    i { i0 }
    j { j0 }
    \  pivot : tab[0] 
    
    BEGIN
      i j <>
    WHILE
      tab i cells + @ tab j cells + @ >
      IF
        i j 1 - =
        IF
          \  on inverse simplement
          
          tab i cells + @ { tmp }
          tab j cells + @ tab i cells + !
          tmp tab j cells + !
          i 1 + TO i
        ELSE
          \  on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
          
          tab i cells + @ { tmp }
          tab j cells + @ tab i cells + !
          tab i 1 + cells + @ tab j cells + !
          tmp tab i 1 + cells + !
          i 1 + TO i
        THEN
      ELSE
        j 1 - TO j
      THEN
    REPEAT
    tab len i0 i 1 - qsort0
    tab len i 1 + j0 qsort0
  THEN
;

: main
  2 { len }
  read-int TO len
  skipspaces
  HERE len cells allot { tab }
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i_ }
    0 { tmp }
    read-int TO tmp
    skipspaces
    tmp tab i_ cells + !
   1 + REPEAT 2DROP
  tab len copytab { tab2 }
  tab2 len bubblesort
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    tab2 i cells + @ s>d 0 d.r
     s"  " TYPE
   1 + REPEAT 2DROP
  NEWLINE TYPE
  tab len copytab { tab3 }
  tab3 len 0 len 1 - qsort0
  len 1 - 0 BEGIN 2dup >= WHILE DUP { i }
    tab3 i cells + @ s>d 0 d.r
     s"  " TYPE
   1 + REPEAT 2DROP
  NEWLINE TYPE
  ;
main
BYE

