Object subclass: loop_unroll [
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
  "
Ce test permet de vérifier le comportement des macros
Il effectue du loop unrolling
"
  main [
    |j|j := 0.
    j :=  0.
    (j) display.
    '
' display.
    j :=  1.
    (j) display.
    '
' display.
    j :=  2.
    (j) display.
    '
' display.
    j :=  3.
    (j) display.
    '
' display.
    j :=  4.
    (j) display.
    '
' display.
    ]
]
Eval [ (loop_unroll new) main. ]

