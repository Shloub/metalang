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
  S"  -- " TYPE
  b s>d 0 d.r
  S\" --\n" TYPE
  ;
main
BYE

