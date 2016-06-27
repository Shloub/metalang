Object subclass: montagnes [
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
   montagnes0: tab len: len [|x max0 j i|
    max0 := 1.
    j := 1.
    i := len - 2.
    [i >= 0] whileTrue:[
      x := tab at: (i + 1).
      [(j >= 0) and: [x > (tab at: (len - j + 1))]] whileTrue:[j := j - 1.].
      j := j + 1.
      tab at: (len - j + 1) put: x.
      (j > max0)
      ifTrue:[max0 := j.].
      i := i - 1.
    ].
    ^ max0
  ]
  
  main [
    |x tab len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      x := 0.
      x := self read_int.
      self skip.
      tab at: (i + 1) put: x.
    ].
    (self montagnes0: tab len: len) display.
    ]
]
Eval [ (montagnes new) main. ]

