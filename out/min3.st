Object subclass: min3 [
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
   min2_: a b: b [
    (a < b)
      ifTrue:[^ a]
      ifFalse:[^ b].
  ]
  
  main [
    ((self min2_: (self min2_: 2 b: 3) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: 2 b: 4) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: 3 b: 2) b: 4)) display.
    ' ' display.
    ((self min2_: (self min2_: 3 b: 4) b: 2)) display.
    ' ' display.
    ((self min2_: (self min2_: 4 b: 2) b: 3)) display.
    ' ' display.
    ((self min2_: (self min2_: 4 b: 3) b: 2)) display.
    '
' display.
    ]
]
Eval [ (min3 new) main. ]

