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
: read-char current-char next-char ;
: is_triangular { n }
  \ 
  \    n = k * (k + 1) / 2
  \ 	  n * 2 = k * (k + 1)
  \    
  
  n 2 * s>f fsqrt f>s { a }
  a a 1 + * n 2 * = exit
;


: score {  }
  skipspaces
  read-int { len }
  skipspaces
  0 { sum }
  len 1 BEGIN 2dup >= WHILE DUP { i }
    read-char { c }
    sum c [char] A - 1 + + TO sum
    \ 		print c print " " print sum print " " 
    
   1 + REPEAT 2DROP
  sum is_triangular
  IF
    1 exit
  ELSE
    0 exit
  THEN
;

: main
  55 1 BEGIN 2dup >= WHILE DUP { i }
    i is_triangular
    IF
      i s>d 0 d.r
      S"  " TYPE
    THEN
   1 + REPEAT 2DROP
  S\" \n" TYPE
  0 { sum }
  read-int { n }
  n 1 BEGIN 2dup >= WHILE DUP { i }
    sum  score + TO sum
   1 + REPEAT 2DROP
  sum s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

