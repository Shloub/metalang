Object subclass: test_returns [
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
   is_pair: i  [|j|
    j := 1.
    (i < 10)
      ifTrue:[
             j :=  2.
             (i = 0)
               ifTrue:[
                      j :=  4.
                      ^ true
               ].
             j :=  3.
             (i = 2)
               ifTrue:[
                      j :=  4.
                      ^ true
               ].
             j :=  5.
      ].
    j :=  6.
    (i < 20)
      ifTrue:[
             (i = 22)
               ifTrue:[j :=  0.].
             j :=  8.
      ].
    ^ ((i rem: 2) = 0)
  ]
  
  main [
    
    ]
]
Eval [ (test_returns new) main. ]

