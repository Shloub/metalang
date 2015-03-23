

: // { a b }
  a b /
  a 0 < b 0 < XOR IF 1 + THEN
;

: % { a b }
  a b MOD
  a 0 < b 0 < XOR IF b - THEN
 ;


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
  THEN
;

: current-char
  buffer-index @ buffer-max @ > IF next-char THEN
  bufferc buffer-index @ + c@ ;

: skipspaces
  BEGIN NEOF @ current-char 13 = current-char 32 = OR current-char 10 = OR AND
  WHILE next-char REPEAT
;

: read-int
  [char] - current-char = IF
    -1
    next-char
  ELSE 1
  THEN
  0
  BEGIN current-char [char] 0 >= current-char [char] 9 <= AND
  WHILE 10 * current-char [char] 0 - + next-char REPEAT
  *
;

: read-char current-char next-char ;



: main
  3 3 + 5 + 4 + 4 + s>d 0 d.r
  NEWLINE TYPE
  3 3 + 5 + 4 + 4 + 3 + 5 + 5 + 4 + { one_to_nine }
  one_to_nine s>d 0 d.r
  NEWLINE TYPE
  one_to_nine 3 + { one_to_ten }
  one_to_ten 6 + 6 + 8 + 8 + 7 + 7 + 9 + 8 + 8 + 6 + { one_to_twenty }
  one_to_twenty 6 9 * + one_to_nine + 6 + { one_to_thirty }
  one_to_thirty 6 9 * + one_to_nine + 5 + { one_to_forty }
  one_to_forty 5 9 * + one_to_nine + 5 + { one_to_fifty }
  one_to_fifty 5 9 * + one_to_nine + 5 + { one_to_sixty }
  one_to_sixty 5 9 * + one_to_nine + 7 + { one_to_seventy }
  one_to_seventy 7 9 * + one_to_nine + 6 + { one_to_eighty }
  one_to_eighty 6 9 * + one_to_nine + 6 + { one_to_ninety }
  one_to_ninety 6 9 * + one_to_nine + { one_to_ninety_nine }
  one_to_ninety_nine s>d 0 d.r
  NEWLINE TYPE
  100 one_to_nine * one_to_ninety_nine 10 * + 10 9 * 99 * + 7 9 * + 3 + 8 + s>d 0 d.r
  NEWLINE TYPE
  ;
main
BYE

