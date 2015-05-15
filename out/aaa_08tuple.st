Object subclass: tuple_int_int [
  | tuple_int_int_field_0 tuple_int_int_field_1 |
  tuple_int_int_field_0 [ ^tuple_int_int_field_0 ]
  tuple_int_int_field_1 [ ^tuple_int_int_field_1 ]
  tuple_int_int_field_0: g [ tuple_int_int_field_0 := g. ] 
  tuple_int_int_field_1: g [ tuple_int_int_field_1 := g. ] 
]
Object subclass: toto [
  | foo bar |
  foo [ ^foo ]
  bar [ ^bar ]
  foo: h [ foo := h. ] 
  bar: h [ bar := h. ] 
]
Object subclass: aaa_08tuple [
  |buffer|
  read_int [|o|
    ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
     o := 0.
    (buffer isNil) ifFalse:[
    (buffer =~ '^(-?\d+)' asRegex) ifMatched: [:match |
    o := match at: 1.
    buffer := buffer allButFirst:(o size).
    ].
    ^o asInteger. ]
  ]
  skip [
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    (buffer =~ '^(\s+)') ifMatched: [:match | buffer := buffer allButFirst:((match at: 1) size).].
    ]
  ]
  
  
  main [
    |t f e d c bar_ b a|bar_ := self read_int.
    self skip.
    c := self read_int.
    self skip.
    d := self read_int.
    self skip.
    e := tuple_int_int new.
    e tuple_int_int_field_0: c.
    e tuple_int_int_field_1: d.
    t := toto new.
    t foo: e.
    t bar: bar_.
    f := t foo.
    a := f tuple_int_int_field_0.
    b := f tuple_int_int_field_1.
    a display.
    ' ' display.
    b display.
    ' ' display.
    t bar display.
    '
' display.
    ]
]
Eval [ (aaa_08tuple new) main. ]

