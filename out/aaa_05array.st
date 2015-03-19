Object subclass: aaa_05array [
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
   id: b  [
    ^ b
  ]
  
   g: t index: index [
    t at: (index + 1) put:  false.
  ]
  
  main [
    |j d c a|j := 0.
    a := Array new: 5.
    (0 to: (5 - 1)) do: [:i|
      (i) display.
      j :=  (j + i).
      a at: (i + 1) put:  ((i rem: 2) = 0).
    ].
    (j) display.
    ' ' display.
    c := (a at: (0 + 1)).
    c
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    '
' display.
    (self g: (self id: a)
    index: 0).
    d := (a at: (0 + 1)).
    d
      ifTrue:['True' display.]
      ifFalse:['False' display.].
    '
' display.
    ]
]
Eval [ (aaa_05array new) main. ]

