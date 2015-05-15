: // { a b } a b / a 0 < b 0 < XOR IF 1 + THEN ;
: % { a b } a b MOD a 0 < b 0 < XOR IF b - THEN ;
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
: read-char current-char next-char ;
: main
  1 { i }
  HERE 5 cells allot { last }
  5 1 - 0 BEGIN 2dup >= WHILE DUP { j }
    read-char { c }
    c [char] 0 - { d }
    i d * TO i
    d last  j cells +  !
   1 + REPEAT 2DROP
  i { max0 }
  0 { index }
  0 { nskipdiv }
  995 1 BEGIN 2dup >= WHILE DUP { k }
    read-char { e }
    e [char] 0 - { f }
    f 0 =
    IF
      1 TO i
      4 TO nskipdiv
    ELSE
      i f * TO i
      nskipdiv 0 <
      IF
        i last  index cells +  @ // TO i
      THEN
      nskipdiv 1 - TO nskipdiv
    THEN
    f last  index cells +  !
    index 1 + 5 % TO index
    max0 i max TO max0
   1 + REPEAT 2DROP
  max0 s>d 0 d.r
  S\" \n" TYPE
  ;
main
BYE

