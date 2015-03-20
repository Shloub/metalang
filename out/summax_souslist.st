Object subclass: summax_souslist [
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
   summax: lst len: len [|max0 current|
    current := 0.
    max0 := 0.
    (0 to: (len - 1)) do: [:i|
      current :=  (current + (lst at: (i + 1))).
      (current < 0)
        ifTrue:[current :=  0.].
      (max0 < current)
        ifTrue:[max0 :=  current.].
    ].
    ^ max0
  ]
  
  main [
    |tmp tab result len|len := 0.
    len := self read_int.
    self skip.
    tab := Array new: len.
    (0 to: (len - 1)) do: [:i|
      tmp := 0.
      tmp := self read_int.
      self skip.
      tab at: (i + 1) put:  tmp.
    ].
    result := (self summax: tab len: len).
    (result) display.
    ]
]
Eval [ (summax_souslist new) main. ]

