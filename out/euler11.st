Object subclass: tuple_int_int [
  | tuple_int_int_field_0 tuple_int_int_field_1 |
  tuple_int_int_field_0 [ ^tuple_int_int_field_0 ]
  tuple_int_int_field_1 [ ^tuple_int_int_field_1 ]
  tuple_int_int_field_0: s [ tuple_int_int_field_0 := s. ] 
  tuple_int_int_field_1: s [ tuple_int_int_field_1 := s. ] 
]
Object subclass: euler11 [
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
   max2_: a b: b [
    (a > b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
   find: n m: m x: x y: y dx: dx dy: dy [
    (((((((x < 0)) ifTrue:[true] ifFalse: [(x = 20)])) ifTrue:[true] ifFalse: [(y < 0)])) ifTrue:[true] ifFalse: [(y = 20)])
      ifTrue:[^ (0-(1))]
      ifFalse:[(n = 0)
                ifTrue:[^ 1]
                ifFalse:[^ (((m at: (y + 1)) at: (x + 1)) * (self find: (n - 1) m: m x: (x + dx) y: (y + dy) dx: dx dy: dy))].].
  ]
  
  
  main [
    |r p max0 m l k h g f e dy dx directions d c|directions := Array new: 8.
    (0 to: (8 - 1)) do: [:i|
      (i = 0)
        ifTrue:[
               c := tuple_int_int new.
               c tuple_int_int_field_0: 0.
               c tuple_int_int_field_1: 1.
               directions at: (i + 1) put:  c.
        ]
        ifFalse:[(i = 1)
                  ifTrue:[
                         d := tuple_int_int new.
                         d tuple_int_int_field_0: 1.
                         d tuple_int_int_field_1: 0.
                         directions at: (i + 1) put:  d.
                  ]
                  ifFalse:[(i = 2)
                            ifTrue:[
                                   e := tuple_int_int new.
                                   e tuple_int_int_field_0: 0.
                                   e tuple_int_int_field_1: (0-(1)).
                                   directions at: (i + 1) put:  e.
                            ]
                            ifFalse:[(i = 3)
                                      ifTrue:[
                                             f := tuple_int_int new.
                                             f tuple_int_int_field_0: (0-(1)).
                                             f tuple_int_int_field_1: 0.
                                             directions at: (i + 1) put:  f.
                                      ]
                                      ifFalse:[(i = 4)
                                                ifTrue:[
                                                       g := tuple_int_int new.
                                                       g tuple_int_int_field_0: 1.
                                                       g tuple_int_int_field_1: 1.
                                                       directions at: (i + 1) put:  g.
                                                ]
                                                ifFalse:[(i = 5)
                                                          ifTrue:[
                                                                 h := tuple_int_int new.
                                                                 h tuple_int_int_field_0: 1.
                                                                 h tuple_int_int_field_1: (0-(1)).
                                                                 directions at: (i + 1) put:  h.
                                                          ]
                                                          ifFalse:[(i = 6)
                                                                    ifTrue:[
                                                                           k := tuple_int_int new.
                                                                           k tuple_int_int_field_0: (0-(1)).
                                                                           k tuple_int_int_field_1: 1.
                                                                           directions at: (i + 1) put:  k.
                                                                    ]
                                                                    ifFalse:[
                                                                            l := tuple_int_int new.
                                                                            l tuple_int_int_field_0: (0-(1)).
                                                                            l tuple_int_int_field_1: (0-(1)).
                                                                            directions at: (i + 1) put:  l.
                                                                    ].].].].].].].
    ].
    max0 := 0.
    m := Array new: 20.
    (0 to: (20 - 1)) do: [:o|
      p := Array new: 20.
      (0 to: (20 - 1)) do: [:q|
        p at: (q + 1) put: self read_int.
        self skip.
      ].
      m at: (o + 1) put:  p.
    ].
    (0 to: 7) do: [:j|
      r := (directions at: (j + 1)).
      dx := (r tuple_int_int_field_0).
      dy := (r tuple_int_int_field_1).
      (0 to: 19) do: [:x|
        (0 to: 19) do: [:y|
          max0 :=  (self max2_: max0 b: (self find: 4 m: m x: x y: y dx: dx dy: dy)).
        ].
      ].
    ].
    (max0) display.
    '
' display.
    ]
]
Eval [ (euler11 new) main. ]

