

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



struct
  cell% field ->tuple_int_int_field_0
  cell% field ->tuple_int_int_field_1
end-struct tuple_int_int%

: f { tuple0 }
  tuple0 { c }
  c ->tuple_int_int_field_0 @ { a }
  c ->tuple_int_int_field_1 @ { b }
  tuple_int_int% %allot { d }
  a 1 + d ->tuple_int_int_field_0 !
  b 1 + d ->tuple_int_int_field_1 !
  d exit
;

: main
  tuple_int_int% %allot { e }
  0 e ->tuple_int_int_field_0 !
  1 e ->tuple_int_int_field_1 !
  e f { t }
  t { g }
  g ->tuple_int_int_field_0 @ { a }
  g ->tuple_int_int_field_1 @ { b }
  a s>d 0 d.r
   s"  -- " TYPE
  b s>d 0 d.r
   s" --" NEWLINE S+ TYPE
  ;
main
BYE

