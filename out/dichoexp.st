Object subclass: dichoexp [
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
   exp0: a b: b [|o|
    (b = 0)
    ifTrue:[^ 1].
    ((b rem: 2) = 0)
    ifTrue:[
      o := (self exp0: a b: (b quo: 2)).
      ^ o * o
    ]
    ifFalse:[^ a * (self exp0: a b: (b - 1))].
  ]
  main [
    |b a|a := 0.
    b := 0.
    a := self read_int.
    self skip.
    b := self read_int.
    (self exp0: a b: b) display.
    ]
]
Eval [ (dichoexp new) main. ]

