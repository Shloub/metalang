Object subclass: euler03 [
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
  read_char [|o|
     ((buffer isNil) | ((buffer size) = 0)) ifTrue: [ buffer := FileStream stdin nextLine. ].
    (buffer isNil) ifFalse:[
    o := buffer at: 1.
    buffer := buffer allButFirst:1.
    ^o.
    ]
  ]
  main [
    |sqrtia maximum found b0 b a|maximum := 1.
    b0 := 2.
    a := 408464633.
    sqrtia := ((a) sqrt floor).
    [(a ~= 1)] whileTrue:
    [
    b := b0.
    found := false.
    [(b <= sqrtia)] whileTrue:
    [
    ((a rem: b) = 0)
      ifTrue:[
             a :=  (a quo: b).
             b0 :=  b.
             b :=  a.
             sqrtia :=  ((a) sqrt floor).
             found :=  true.
      ].
    b :=  (b + 1).
    ].
    ((found) not)
      ifTrue:[
             (a) display.
             '
' display.
             a :=  1.
      ].
    ].
    ]
]
Eval [ (euler03 new) main. ]

