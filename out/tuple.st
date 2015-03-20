Object subclass: tuple_int_int [
  | tuple_int_int_field_0 tuple_int_int_field_1 |
  tuple_int_int_field_0 [ ^tuple_int_int_field_0 ]
  tuple_int_int_field_1 [ ^tuple_int_int_field_1 ]
  tuple_int_int_field_0: h [ tuple_int_int_field_0 := h. ] 
  tuple_int_int_field_1: h [ tuple_int_int_field_1 := h. ] 
]
Object subclass: tuple [
  
   f: tuple0  [|d c b a|
    c := tuple0.
    a := (c tuple_int_int_field_0).
    b := (c tuple_int_int_field_1).
    d := tuple_int_int new.
    d tuple_int_int_field_0: (a + 1).
    d tuple_int_int_field_1: (b + 1).
    ^ d
  ]
  
  main [
    |t g e b a|e := tuple_int_int new.
    e tuple_int_int_field_0: 0.
    e tuple_int_int_field_1: 1.
    t := (self f: e).
    g := t.
    a := (g tuple_int_int_field_0).
    b := (g tuple_int_int_field_1).
    (a) display.
    ' -- ' display.
    (b) display.
    '--
' display.
    ]
]
Eval [ (tuple new) main. ]

