Object subclass: devine [
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
   devine0: nombre tab: tab len: len [|min0 max0|
    min0 := tab at: 1.
    max0 := tab at: 2.
    (2 to: (len - 1)) do: [:i|
      (((tab at: (i + 1)) > max0) or: [(tab at: (i + 1)) < min0])
      ifTrue:[^ false].
      ((tab at: (i + 1)) < nombre)
      ifTrue:[min0 := tab at: (i + 1).].
      ((tab at: (i + 1)) > nombre)
      ifTrue:[max0 := tab at: (i + 1).].
      (((tab at: (i + 1)) = nombre) and: [len ~= (i + 1)])
      ifTrue:[^ false].
    ].
    ^ true
  ]
  main [
    |tmp tab nombre len|nombre := self read_int.
    self skip.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := self read_int.
      self skip.
      tab at: (i + 1) put: tmp.
    ].
    (self devine0: nombre tab: tab len: len)
    ifTrue:['True' display.]
    ifFalse:['False' display.].
    ]
]
Eval [ (devine new) main. ]

