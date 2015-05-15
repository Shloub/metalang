Object subclass: plus_petit [
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
   go0: tab a: a b: b [|m j i e|
    m := (a + b) quo: 2.
    (a = m)
      ifTrue:[((tab at: (a + 1)) = m)
               ifTrue:[^ b]
               ifFalse:[^ a].].
    i := a.
    j := b.
    [i < j] whileTrue:
    [
    e := tab at: (i + 1).
    (e < m)
      ifTrue:[i :=  (i + 1).]
      ifFalse:[
              j :=  (j - 1).
              tab at: (i + 1) put:  (tab at: (j + 1)).
              tab at: (j + 1) put:  e.
      ].
    ].
    (i < m)
      ifTrue:[^ (self go0: tab a: a b: m)]
      ifFalse:[^ (self go0: tab a: m b: b)].
  ]
  
   plus_petit0: tab len: len [
    ^ (self go0: tab a: 0 b: len)
  ]
  
  main [
    |tmp tab len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := 0.
      tmp := self read_int.
      self skip.
      tab at: (i + 1) put:  tmp.
    ].
    (self plus_petit0: tab len: len) display.
    ]
]
Eval [ (plus_petit new) main. ]

