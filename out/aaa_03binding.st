Object subclass: aaa_03binding [
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
   g: i  [|j|
    j := (i * 4).
    ((j rem: 2) = 1)
      ifTrue:[^ 0].
    ^ j
  ]
  
   h: i  [
    (i) display.
    '
' display.
  ]
  
  main [
    |b a|(self h: 14).
    a := 4.
    b := 5.
    (a + b) display.
    " main "
    (self h: 15).
    a :=  2.
    b :=  1.
    (a + b) display.
    ]
]
Eval [ (aaa_03binding new) main. ]

